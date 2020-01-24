Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45851C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EE62071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863681;
	bh=KAzaguREQ3RaeAQy55+/Xuv+pFlbqm53eOVOgzlveEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U+YFRFJ09JIEenWIcP7eavY51F/xVSZ8cPfSeFdmv/QGZD/SuGVPA/NDRIr9746ra
	 04p+cpvtByXyKgAud+8LTa1jC88o5xy6jtCTu/+GzvxaG61vJ5prEGObuM1LOPFRNx
	 IdkzL2OfAvqVyIhsOQq7wSMTNguHjv2ApByOw168=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgAXLBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:01:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730614AbgAXLBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:01:19 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC022077C;
        Fri, 24 Jan 2020 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863678;
        bh=KAzaguREQ3RaeAQy55+/Xuv+pFlbqm53eOVOgzlveEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JemysKp7I7qDj5/WS5bcY9fLzKZD1Z+QrsL+PwuTQfRlsO5HDU7dgf7D4iiFx68Kt
         R72iescrdAv3kEr12CbtBonb7vL2LS+lBXmaNL2lFR1yLwKg/Us/UYinaRBeNvgT9T
         w+G/1gw1ky4M9p33AZOFcn7G2u6BNUyeJCxgNaxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/639] pwm: lpss: Release runtime-pm reference from the drivers remove callback
Date:   Fri, 24 Jan 2020 10:23:40 +0100
Message-Id: <20200124093053.680658951@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 42885551cedb45961879d2fc3dc3c4dc545cc23e ]

For each pwm output which gets enabled through pwm_lpss_apply(), we do a
pm_runtime_get_sync().

This commit adds pm_runtime_put() calls to pwm_lpss_remove() to balance
these when the driver gets removed with some of the outputs still enabled.

Fixes: f080be27d7d9 ("pwm: lpss: Add support for runtime PM")
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-lpss.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 1e69c1c9ec096..7a4a6406cf69a 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -216,6 +216,12 @@ EXPORT_SYMBOL_GPL(pwm_lpss_probe);
 
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
 {
+	int i;
+
+	for (i = 0; i < lpwm->info->npwm; i++) {
+		if (pwm_is_enabled(&lpwm->chip.pwms[i]))
+			pm_runtime_put(lpwm->chip.dev);
+	}
 	return pwmchip_remove(&lpwm->chip);
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_remove);
-- 
2.20.1



