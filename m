Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBDFC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE9D20728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snMZPzzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDYULt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:11:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924FC09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 13:11:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so6435731pgi.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2k1av1tyvdh6GZhcN5D4YMVgv3ZyjCy2t6rq6Gh3IE=;
        b=snMZPzzyiHGucldZsOb4HyMr7AyHIgLiDE8tusGDu5dHaAbKHiDPfTq/C3t9cE4jB7
         fEv5QnMzvGS0YF7M54Y4+r1QnP8MQ90yA8vMfMFl1r1+vcq7hLWd5EXEy8MgrjmmH2o4
         xJYfd6hOkA1mP2627weH5mVrEhfFP36wE6ZkiLwuypOSLTiJfSImwGkgZmduRS9XZVk8
         g82fvBxbKD0/rb3Gx2uDhxToarFa2CVBo90Nd20pz/jsLaLgiA9MuUi6rvrW1YL/2zsT
         ULyQpF/wDHWDLsxyrZGs0dJh1RXy+t+aBiwLycI2yo57qkBz8kjUMb/yIpY1qPQGQNA0
         32lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2k1av1tyvdh6GZhcN5D4YMVgv3ZyjCy2t6rq6Gh3IE=;
        b=d0rKudM9ggHbWufiuUT4Epdt44Xtu+wYjyIJtQyN4TuAWhKaeJ0BM/a0Ri2Ikdt8YX
         4rSC3Zb4+naN1/io245XZ6VNw+pLR7keZtKiNDVkUS7DN75LyDBRVFDBcLnNraeC82/U
         3gYed5XDaIqn1hUk+gEoJm6GQ3vMF2XLb+MMdUtM4/emihAtbZjzmWHvjX1fVxGfmcn2
         /biV0WLuetaEEMwzUV4sTSdovez3ETSwBEvuIijsLOkk8h+eW4V9gY6ytlFtm95q7G9w
         R14pLinEIIff/qA/qUoTocxd49CRbKW1OPyOxaAZTm14vIWC7V92fU7acRIwgfUO0fyy
         OmLw==
X-Gm-Message-State: AGi0PuYputcOYsiRba02SNSXs6FqMhNZf/jLmCIGKvZ+nCkG3ZebhJaz
        l3e1c2NpA1Ca5Og92bciSpM=
X-Google-Smtp-Source: APiQypLA7CcCVqPz+pgp7tBCRZNdeaPlgiN2G3MAfcwL2tPJb5G80JNT4t9IIjZDyJgbIJlPjajF1g==
X-Received: by 2002:a62:3803:: with SMTP id f3mr16459171pfa.322.1587845507846;
        Sat, 25 Apr 2020 13:11:47 -0700 (PDT)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id u188sm8746681pfu.33.2020.04.25.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 13:11:47 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ALSA: line6: Fix POD HD500 audio playback
Date:   Sat, 25 Apr 2020 13:11:15 -0700
Message-Id: <20200425201115.3430-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently interface 1 is control interface akin to HD500X,
setting LINE6_CAP_CONTROL and choosing it as ctrl_if fixes
audio playback on POD HD500.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/usb/line6/podhd.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index d37db32ecd3b..e39dc85c355a 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -21,8 +21,7 @@
 enum {
 	LINE6_PODHD300,
 	LINE6_PODHD400,
-	LINE6_PODHD500_0,
-	LINE6_PODHD500_1,
+	LINE6_PODHD500,
 	LINE6_PODX3,
 	LINE6_PODX3LIVE,
 	LINE6_PODHD500X,
@@ -318,8 +317,7 @@ static const struct usb_device_id podhd_id_table[] = {
 	/* TODO: no need to alloc data interfaces when only audio is used */
 	{ LINE6_DEVICE(0x5057),    .driver_info = LINE6_PODHD300 },
 	{ LINE6_DEVICE(0x5058),    .driver_info = LINE6_PODHD400 },
-	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500_0 },
-	{ LINE6_IF_NUM(0x414D, 1), .driver_info = LINE6_PODHD500_1 },
+	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500 },
 	{ LINE6_IF_NUM(0x414A, 0), .driver_info = LINE6_PODX3 },
 	{ LINE6_IF_NUM(0x414B, 0), .driver_info = LINE6_PODX3LIVE },
 	{ LINE6_IF_NUM(0x4159, 0), .driver_info = LINE6_PODHD500X },
@@ -352,23 +350,13 @@ static const struct line6_properties podhd_properties_table[] = {
 		.ep_audio_r = 0x82,
 		.ep_audio_w = 0x01,
 	},
-	[LINE6_PODHD500_0] = {
+	[LINE6_PODHD500] = {
 		.id = "PODHD500",
 		.name = "POD HD500",
-		.capabilities	= LINE6_CAP_PCM
+		.capabilities	= LINE6_CAP_PCM | LINE6_CAP_CONTROL
 				| LINE6_CAP_HWMON,
 		.altsetting = 1,
-		.ep_ctrl_r = 0x81,
-		.ep_ctrl_w = 0x01,
-		.ep_audio_r = 0x86,
-		.ep_audio_w = 0x02,
-	},
-	[LINE6_PODHD500_1] = {
-		.id = "PODHD500",
-		.name = "POD HD500",
-		.capabilities	= LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 0,
+		.ctrl_if = 1,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
 		.ep_audio_r = 0x86,
-- 
2.25.0

