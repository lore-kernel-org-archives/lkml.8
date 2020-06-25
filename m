Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B78C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 03:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF61C20709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 03:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjWDyaKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbgFYDYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 23:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbgFYDYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 23:24:34 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DAFC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 20:24:34 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g6so3120667qtr.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 20:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nb7KRZc1NMpDhOZa08wLKNRZFGJeavE5VbCb55z4mbA=;
        b=UjWDyaKo6b7a1XX/VMRdzD2WwqSjMIXsv8wqEJ9DUkWtbAZUgvKdeuQ/hCg35QP2Kn
         CYpaRkMvnYrje1W+8ECjiLPZ3/UcGqA7Zkh7QUGNY91JgKBk/mSfa/dDBefm6nGJ681D
         jgdyu35BpUmPg06BgHxk2RQ+6WcygzCGdfFSW2mPf1mhygkTkq7F6d9MgYcRb471z/IV
         TCcAn66IYcsxLcX68IWd94feB7dkOtXEVdVGHbSuNOKN3QbN81Zkhkt6RL3F1ewzvLHp
         ZRJomnHT+x3PqbR7RXDA9aK7niPAaOwyM7B1bpehLmgM8xcYbCJxoKAWxKa57mOMUWHA
         ZbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nb7KRZc1NMpDhOZa08wLKNRZFGJeavE5VbCb55z4mbA=;
        b=O4zqV3OE/VQvLy/hzlJKUsk3bCpTeGRaKXC/7cfAsR0m1j/KIAUriL6BQ7ihd1fvOK
         J0lUX082EVPCH88uiCO6oBHQSn0KgWwTi8kgtpTYgJYNZvgkFn/hd4wdG9cSUPM9EcF1
         mkFLLu4kM++EwilEIXENdfmZTwkul1KpHfuZpvTCYkYAFgV0+QixDFXhssJ1yG5S8b0y
         nzETKYcFS3qpaF5wd/rrPGhNhEqaz2DsyPRBr3R0veNJ1fT7G8XliYfezRDYh1rhB0pU
         //RFxhDzOYv8NNzPYYj562fFt+vMxeZU3jup7cnTU4QnVLK2QHua1iwXnAgOmy3bIgOt
         wE1Q==
X-Gm-Message-State: AOAM531tQqEx9kvlQwqmG2HEo4QfSrXA6zGdl3dJtQgOEUz46Z5BHxvk
        o469Q5xP1ChNvBNuhVdpywR2yjh9wEZEsHA=
X-Google-Smtp-Source: ABdhPJyW1dErZ8Mb24TYiwYEbKNun9miLJZ/VEdKQda/KyE+XSd3K9hyOX6Z+j5BhCA3dx+Y8NTfxSjUeb/ugU4=
X-Received: by 2002:a0c:b520:: with SMTP id d32mr9309405qve.6.1593055473102;
 Wed, 24 Jun 2020 20:24:33 -0700 (PDT)
Date:   Wed, 24 Jun 2020 20:24:30 -0700
Message-Id: <20200625032430.152447-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v1] driver core: Fix suspend/resume order issue with deferred probe
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Toan Le <toanle@apm.com>,
        Feng Kan <fkan@apm.com>, Saravana Kannan <saravanak@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under the following conditions:
- driver A is built in and can probe device-A
- driver B is a module and can probe device-B
- device-A is supplier of device-B

Without this patch:
1. device-A is added.
2. device-B is added.
3. dpm_list is now [device-A, device-B].
4. driver-A defers probe of device-A.
5. deferred probe of device-A is reattempted
6. device-A is moved to end of dpm_list.
6. dpm_list is now [device-B, device-A].
7. driver-B is loaded and probes device-B.
8. dpm_list stays as [device-B, device-A].

Suspend (which goes in the reverse order of dpm_list) fails because
device-A (supplier) is suspended before device-B (consumer).

With this patch:
1. device-A is added.
2. device-B is added.
3. dpm_list is now [device-A, device-B].
4. driver-A defers probe of device-A.
5. deferred probe of device-A is reattempted later.
6. dpm_list is now [device-B, device-A].
7. driver-B is loaded and probes device-B.
8. dpm_list is now [device-A, device-B].

Suspend works because device-B (consumer) is suspended before device-A
(supplier).

Fixes: 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9a1d940342ac..52b2148c7983 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -109,6 +109,8 @@ static void deferred_probe_work_func(struct work_struct *work)
 		 * probe makes that very unsafe.
 		 */
 		device_pm_move_to_tail(dev);
+		/* Greg/Rafael: SHOULD I DELETE THIS? ^^ I think I should, but
+		 * I'm worried if it'll have some unintended consequeneces. */
 
 		dev_dbg(dev, "Retrying from deferred list\n");
 		bus_probe_device(dev);
@@ -557,6 +559,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		goto re_probe;
 	}
 
+	/*
+	 * The devices are added to the dpm_list (resume/suspend (reverse
+	 * order) list) as they are registered with the driver core. But the
+	 * order the devices are added doesn't necessarily match the real
+	 * dependency order.
+	 *
+	 * The successful probe order is a much better signal. If a device just
+	 * probed successfully, then we know for sure that all the devices that
+	 * probed before it don't depend on the device. So, we can safely move
+	 * the device to the end of the dpm_list. As more devices probe,
+	 * they'll automatically get ordered correctly.
+	 */
+	device_pm_move_to_tail(dev);
+
 	pinctrl_init_done(dev);
 
 	if (dev->pm_domain && dev->pm_domain->sync)
-- 
2.27.0.111.gc72c7da667-goog

