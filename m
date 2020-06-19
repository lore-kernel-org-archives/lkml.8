Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C9AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5D920786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580838;
	bh=thQfZr/q8RAdyDUbyWCNv25/gg/BpfzE787BTka3u6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aElTS+kbJ+MGl6P5IPex2ImbFzo7bqZy8cXBs1bCko4p24K2/p1F3r8DLvwEuZfwu
	 QcO41PxMQ/Igmp0Uk+J7k955NgLEu4ady5ykKy7tsAxrWMztN2O4e7QgXurDfyC8sY
	 Xb/LE/rsEBZoXSbQN47TRZDKYBrUkBx5dcUCUFso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393974AbgFSPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404895AbgFSPdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:33:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A984B2166E;
        Fri, 19 Jun 2020 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580782;
        bh=thQfZr/q8RAdyDUbyWCNv25/gg/BpfzE787BTka3u6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=An3xlAUc7TfD/GJVt6wTHmoNH2wkRHeSgIKerGjpFXsS0TWMJlIbgtW4E9bJQ0hf9
         YRfCChW2PEcQdSbn9e0pCG0rKskRPWx0EF+doKaFz39fwhJcMAuu5PaPS9eCCYq+04
         oOO0n26YgoHFHh/vMtvibrN88GZDzFq1iRGzbCRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5.7 350/376] pwm: lpss: Fix get_state runtime-pm reference handling
Date:   Fri, 19 Jun 2020 16:34:28 +0200
Message-Id: <20200619141726.893185565@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 01aa905d4791da7d3630f6030ff99d58105cca00 upstream.

Before commit cfc4c189bc70 ("pwm: Read initial hardware state at request
time"), a driver's get_state callback would get called once per PWM from
pwmchip_add().

pwm-lpss' runtime-pm code was relying on this, getting a runtime-pm ref for
PWMs which are enabled at probe time from within its get_state callback,
before enabling runtime-pm.

The change to calling get_state at request time causes a number of
problems:

1. PWMs enabled at probe time may get runtime suspended before they are
requested, causing e.g. a LCD backlight controlled by the PWM to turn off.

2. When the request happens when the PWM has been runtime suspended, the
ctrl register will read all 1 / 0xffffffff, causing get_state to store
bogus values in the pwm_state.

3. get_state was using an async pm_runtime_get() call, because it assumed
that runtime-pm has not been enabled yet. If shortly after the request an
apply call is made, then the pwm_lpss_is_updating() check may trigger
because the resume triggered by the pm_runtime_get() call is not complete
yet, so the ctrl register still reads all 1 / 0xffffffff.

This commit fixes these issues by moving the initial pm_runtime_get() call
for PWMs which are enabled at probe time to the pwm_lpss_probe() function;
and by making get_state take a runtime-pm ref before reading the ctrl reg.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1828927
Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-lpss.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -158,7 +158,6 @@ static int pwm_lpss_apply(struct pwm_chi
 	return 0;
 }
 
-/* This function gets called once from pwmchip_add to get the initial state */
 static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			       struct pwm_state *state)
 {
@@ -167,6 +166,8 @@ static void pwm_lpss_get_state(struct pw
 	unsigned long long base_unit, freq, on_time_div;
 	u32 ctrl;
 
+	pm_runtime_get_sync(chip->dev);
+
 	base_unit_range = BIT(lpwm->info->base_unit_bits);
 
 	ctrl = pwm_lpss_read(pwm);
@@ -187,8 +188,7 @@ static void pwm_lpss_get_state(struct pw
 	state->polarity = PWM_POLARITY_NORMAL;
 	state->enabled = !!(ctrl & PWM_ENABLE);
 
-	if (state->enabled)
-		pm_runtime_get(chip->dev);
+	pm_runtime_put(chip->dev);
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
@@ -202,7 +202,8 @@ struct pwm_lpss_chip *pwm_lpss_probe(str
 {
 	struct pwm_lpss_chip *lpwm;
 	unsigned long c;
-	int ret;
+	int i, ret;
+	u32 ctrl;
 
 	if (WARN_ON(info->npwm > MAX_PWMS))
 		return ERR_PTR(-ENODEV);
@@ -232,6 +233,12 @@ struct pwm_lpss_chip *pwm_lpss_probe(str
 		return ERR_PTR(ret);
 	}
 
+	for (i = 0; i < lpwm->info->npwm; i++) {
+		ctrl = pwm_lpss_read(&lpwm->chip.pwms[i]);
+		if (ctrl & PWM_ENABLE)
+			pm_runtime_get(dev);
+	}
+
 	return lpwm;
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_probe);


