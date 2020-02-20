Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CCC11D41
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A042B2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lhj6VrVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgBTGXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32798 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBTGXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so1142143plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrN5cGA/hR+8GAwew+ghcTVrboaz31zc6S2U8uLng8Y=;
        b=lhj6VrVvbHxOfsVEKIgLtzh7RX0njiqAm2xiSDFfgiq2h2wXFHwU6swytC/ZBgVV+n
         tUQj96obljz21juK5kf91Rgd65pQIKTrGGQmTAqGB+RS0Y0vMlYX+KR32KZxOzvujeeA
         4P44aMe2EQaStGPbJECKeLZnQZN7XkdukCwgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrN5cGA/hR+8GAwew+ghcTVrboaz31zc6S2U8uLng8Y=;
        b=M5PzzcfaZuDJWZ649lzvKibqDRItIpwgP8jOm/HwiFxh5PhWu78nGQD2mU9ioPR5nu
         H/neO2weGTQbs/YwBZfTVCsXyCvR87ashrHJx3W1eVP9tMtYMG5ZiiwsI0sdGFmFhSuY
         1sZFJehfyDZAXbTSbRYCPX6mp/nYN+4j81kj5GvRIOGqYPBcohncCwty7Q0uscZS1L/4
         uIn6UjrmTQor/L1m65dpu2RfMKU/OuE+pSLWAhyoculjJVxpMBvixPGASataOjbm5bNM
         ZpRD4o89g6ort5TUWuVA4D2mVmUfh6K7r4YL1MqD3IxsX7pkCwiMo7GYR9r1RrWJ2+lo
         Kb8g==
X-Gm-Message-State: APjAAAVGnRoHQxrW9vwpyLwHJKETQe5Z9BR86IdPBe+fxbxIoGZnEcOE
        3lf4iaW4Mj+fCyj+AE/bK6eJyA==
X-Google-Smtp-Source: APXvYqyI3Vz5dXf6V/nwzNO8UPo21XBktqoN6L1R8l/IWf8oDZ1m/9nvqFrIFEeJLQiKwHSJIZ2RYw==
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr1778354pjr.17.1582179793890;
        Wed, 19 Feb 2020 22:23:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9sm1735491pfd.141.2020.02.19.22.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:13 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ppdev: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:11 -0800
Message-Id: <20200220062311.69121-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

drivers/char/ppdev.c: In function ‘pp_do_ioctl’:
drivers/char/ppdev.c:516:25: warning: statement will never be executed [-Wswitch-unreachable]
  516 |   struct ieee1284_info *info;
      |                         ^~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/ppdev.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 2c2381a806ae..38b46c7d1737 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -355,14 +355,19 @@ static int pp_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct pp_struct *pp = file->private_data;
 	struct parport *port;
 	void __user *argp = (void __user *)arg;
+	struct ieee1284_info *info;
+	unsigned char reg;
+	unsigned char mask;
+	int mode;
+	s32 time32[2];
+	s64 time64[2];
+	struct timespec64 ts;
+	int ret;
 
 	/* First handle the cases that don't take arguments. */
 	switch (cmd) {
 	case PPCLAIM:
 	    {
-		struct ieee1284_info *info;
-		int ret;
-
 		if (pp->flags & PP_CLAIMED) {
 			dev_dbg(&pp->pdev->dev, "you've already got it!\n");
 			return -EINVAL;
@@ -513,15 +518,6 @@ static int pp_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	port = pp->pdev->port;
 	switch (cmd) {
-		struct ieee1284_info *info;
-		unsigned char reg;
-		unsigned char mask;
-		int mode;
-		s32 time32[2];
-		s64 time64[2];
-		struct timespec64 ts;
-		int ret;
-
 	case PPRSTATUS:
 		reg = parport_read_status(port);
 		if (copy_to_user(argp, &reg, sizeof(reg)))

