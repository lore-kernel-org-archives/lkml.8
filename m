Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBACC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BAC20936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQySLHVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgDQPfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728956AbgDQPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:35:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5DBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:35:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o1so1215024pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8g/4GTCmb07WPAJDQsUl+Pc0itbtm8TY2kRQQ40HQLQ=;
        b=QQySLHVmQBzQDdCyw3zxSD0kEoZFv5duA4bB+yAv9ahFyvW/sYbFeu/0ZPxOmYSIAW
         6bYufznvhCAJVDY7O//3S77FLStHI7Xe7RnSWkOzLMpEUExE7rGcTY/f/Xg0fpiXiA/6
         sscMdYHfAK03DFuLnSWvUr2rHLTYbQAFKEbvTgoD8AZYDmYfSNfs5GSWB+npp/M8IE0a
         pof45iMGtm3hTVtdRVGfGmVe3vh9mqZJc1Odd2tfzghe0KkCb6d9ynt6laAam/9R3o8P
         dEcK+0Up5z4k5sDZdY4t7hlJBGs9EMpp8BWqiTkmc2SOceKO60c0aOXSDQ9+IXuq9+D4
         lu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8g/4GTCmb07WPAJDQsUl+Pc0itbtm8TY2kRQQ40HQLQ=;
        b=KAik1nXCrqCn7wZhWTsZcRD1ulseQCIfil2t4v63p7d+U1Zd0EfIVNCTmHDro4iB26
         LrMLTRMlFAUJG0nWI7QTBq/VgZbLPcGJ1xnqkR2hQXVnrHm6J53hyjwpZHLbv/meZJ32
         4kTGuwEWDMRnyHqSckTv3Nais8E2//UhjT3K0tgt+kNhrro7jEWjOgZHaNYXh+X7UeTs
         rN8rrKh07fVxhECSStXHw5C5cZvIxsobKFbXbkI8AfdHx2SvLTPyJnzjaXn4XDuH3DDT
         bwa3fHgLf9JlLS7kMf/ep+1PejczJWzer4o5QHLUlXyE8wSJy/J8TSYj1FXYvmAcYOxG
         BBmw==
X-Gm-Message-State: AGi0PuZ/cY3mnOkBQ5PnhBVlXv+76C8CPC/nEyXOjBaXe9XU3SIB6g4B
        jvLbAE2/w8alt9cYeJPoT1euTII=
X-Google-Smtp-Source: APiQypLwL7/CaQrhwzBWkPiF3qwclKIcmR3/CezQkRtwS7XXfA+kW1xuxiEi9NNnDFnfw7Bhzl3YIw==
X-Received: by 2002:a17:902:68:: with SMTP id 95mr4068361pla.7.1587137719214;
        Fri, 17 Apr 2020 08:35:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:5018:92b5:dcd1:1314:8d3f:7e83])
        by smtp.gmail.com with ESMTPSA id c201sm19986152pfc.73.2020.04.17.08.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:35:18 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     mark.gross@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] drivers: char: tlclk.c: Avoid data race between init and interrupt handler
Date:   Fri, 17 Apr 2020 21:04:51 +0530
Message-Id: <20200417153451.1551-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

After registering character device the file operation callbacks can be
called. The open callback registers interrupt handler.
Therefore interrupt handler can execute in parallel with rest of the init
function. To avoid such data race initialize telclk_interrupt variable
and struct alarm_events before registering character device.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/char/tlclk.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
index 6d81bb3bb503..896a3550fba9 100644
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -777,17 +777,21 @@ static int __init tlclk_init(void)
 {
 	int ret;
 
+	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
+
+	alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
+	if (!alarm_events) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
 	ret = register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
 	if (ret < 0) {
 		printk(KERN_ERR "tlclk: can't get major %d.\n", tlclk_major);
+		kfree(alarm_events);
 		return ret;
 	}
 	tlclk_major = ret;
-	alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
-	if (!alarm_events) {
-		ret = -ENOMEM;
-		goto out1;
-	}
 
 	/* Read telecom clock IRQ number (Set by BIOS) */
 	if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
@@ -796,7 +800,6 @@ static int __init tlclk_init(void)
 		ret = -EBUSY;
 		goto out2;
 	}
-	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
 
 	if (0x0F == telclk_interrupt ) { /* not MCPBL0010 ? */
 		printk(KERN_ERR "telclk_interrupt = 0x%x non-mcpbl0010 hw.\n",
@@ -837,8 +840,8 @@ static int __init tlclk_init(void)
 	release_region(TLCLK_BASE, 8);
 out2:
 	kfree(alarm_events);
-out1:
 	unregister_chrdev(tlclk_major, "telco_clock");
+out1:
 	return ret;
 }
 
-- 
2.17.1

