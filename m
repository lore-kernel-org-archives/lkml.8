Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4956A20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoFNk7HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCJOat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:30:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44350 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCJOat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:30:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so5489015plo.11;
        Tue, 10 Mar 2020 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge7gDpcBGRttSD8WjUIEGB/IfPhV68NKF/ex9fXuV1k=;
        b=CoFNk7HHJ27bS8Sau2w7fDpQELoK3pr1joAA4rGVBfG5Pm0v8QxK3gvrRv31TMJgBw
         /CCO4x6Zsc+Of+XbBzOwSfE7m1Sxr4AKwGylYBTm8IAkBbFMbk7JAamCR/yEbd2trE7T
         ZB4gaC5uh/i04xNu0v5Ipync9hCnJUA093+tfr9ocBI/54M6JwTgwD/rLyyfGf25JEz2
         6mhMR3QILXYjsvcCSoUdGHBFZ3n01gLbiOIyaQvtohNjsTXC47ZHWkh/TucOuWvDJzoq
         G/Wcnk5S+SeD4OiYuFpNFMeNtZYnrAN0/fiJWGGuuDfvlHAM+YL+0/6r96Z2X7HtH+xo
         G/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge7gDpcBGRttSD8WjUIEGB/IfPhV68NKF/ex9fXuV1k=;
        b=SWc+ny+TEzkz6dVQIGR/2SF6zPW7daQHOHGWufBnRY7dqdv46fh0Y9X/WSbqOT8Z0e
         bI0qmnzL05/dCP+3gGtbtpiYECk0Uo4ZFl+K3u+n+Pr6pYr7XdycGNnMbi3s2gLYYh/Z
         rWEORg0JbMzuceFSkQ5vgkhZOT8xPolHem5j3sfQGdRy6/1TS/mwtsIGxbIAA8xGwcHA
         FkE3HY1FbJnXzRBlq2z72RmUMTLmLT2/ujbmUUyA8Srqlc0dMBz9VM3VvgcV1vxanlTc
         UM2IGwH19jLUTtAwmPk+5DrbAqFmt4DXmSDYW5vwgh2xsLqmKVsWgBJzqVxfDf/opa/n
         IL2A==
X-Gm-Message-State: ANhLgQ1rXWxiDg/iFXJkpK0lr3C1i7PMu34vMPS0u6WPkIPe1OlpGKxS
        ejg62fDl5PBxMQFHMA9aEoojJWOLIi0=
X-Google-Smtp-Source: ADFU+vstmImOUNgoCcrT7uEN6qpq42UEh1S0ApYVVlp2WgbIzWYZKiUJyohS5+dKEhJO2dENy6CcRA==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr19846817plv.297.1583850647173;
        Tue, 10 Mar 2020 07:30:47 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id l11sm2419160pjy.44.2020.03.10.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:30:46 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
Date:   Tue, 10 Mar 2020 22:30:33 +0800
Message-Id: <20200310143033.5098-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls register_framebuffer() in probe but does not call
unregister_framebuffer() in remove.
Rename current remove to __s1d13xxxfb_remove() for error handler.
Then add a new remove to call unregister_framebuffer().

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Rename the existing remove and add a new one to ensure the correctness
    of error handler in probe.

 drivers/video/fbdev/s1d13xxxfb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 8048499e398d..bafea3d09bba 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -721,9 +721,8 @@ static void s1d13xxxfb_fetch_hw_state(struct fb_info *info)
 		xres, yres, xres_virtual, yres_virtual, is_color, is_dual, is_tft);
 }
 
-
 static int
-s1d13xxxfb_remove(struct platform_device *pdev)
+__s1d13xxxfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct s1d13xxxfb_par *par = NULL;
@@ -752,6 +751,18 @@ s1d13xxxfb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int
+s1d13xxxfb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+
+	if (info)
+		unregister_framebuffer(info);
+
+	return __s1d13xxxfb_remove(pdev);
+}
+
+
 static int s1d13xxxfb_probe(struct platform_device *pdev)
 {
 	struct s1d13xxxfb_par *default_par;
@@ -895,7 +906,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
 	return 0;
 
 bail:
-	s1d13xxxfb_remove(pdev);
+	__s1d13xxxfb_remove(pdev);
 	return ret;
 
 }
-- 
2.25.1

