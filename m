Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97352C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6842C2253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd/gDq8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCIUoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:44:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37264 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIUn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:43:59 -0400
Received: by mail-yw1-f68.google.com with SMTP id i1so7299125ywf.4;
        Mon, 09 Mar 2020 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAE4tbLOHr7PfWPVPg1IGfxuALloJp02P/TPV4CS1Go=;
        b=kd/gDq8h1WLVhBkNE2x6fD0JgOBeJ73GPigwJ8XpNCyUEG4euZUB5ikjWU/t48UolK
         nIGwQdv81wEhNcfwipAxEsTqCwXCm7wz42BGwJIGoKNTKSMIpZjjqe55m+n+Fi8zKzMW
         ntN7xAE6yqv3c8eJDlelgjxhwbh49hbh4/AGxGLQQzw0NPIQTc52XQabGWCTjxRht/vc
         WJ/lfJglJdqMz9mmMLKmuu8s2vvclAVlWC6Pz5vWInWZ/2TIAmn1uFerMEYVeQjhngJq
         U8m5qOVSzxA8R9IM9VxRztjLk1t2Y7Kn24y9LKpgPRy+gQHZuXKK0XCTWZqQpvcQlYqM
         AHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAE4tbLOHr7PfWPVPg1IGfxuALloJp02P/TPV4CS1Go=;
        b=Xd2gSeOGFHeENXustO6sJB/Tbfgiyb28JojPNP0JJkNDhFL+Cb3zDjX/YoERvBEybY
         jdfdggH60rJgGGXvwYbQYXtMfwf8+5rwYxGNk/GPWjZrY/GzlfGEMZbqhgFdmnaZf0py
         Z1+xwfciSCKyxIHz4Faj1Zuar3f07XUtXizwRnDvIeBYBN0WE9+kfyfN0pQA3CAzr1BT
         m6g5SFjzcAeM+Sbhbex5JR2qDFxVr2tsJ0CHkSLg7iFLwW4mJn/Sx0vM8G9y4zlpjD35
         a0dkBZmAqgcZOiCCvAdk/Hf9weTEJ6IpmlxS1OOF5NQIS8Z9kbMHk2hcMREO636tg/6i
         +xGw==
X-Gm-Message-State: ANhLgQ2Rep17a29R69zU/Xj+qcDzAS2vz609oZWWENOoxVF9MGN5bcu3
        I/NPulPidDvuSCtfOYRuqZs=
X-Google-Smtp-Source: ADFU+vthSS3+5gJZjuZCDC+BlTqS2VOFpODEBY6DczD5goOob+YmwLQ7QvOnIrSSHpkFnHATI/IfXA==
X-Received: by 2002:a25:bd88:: with SMTP id f8mr19371732ybh.384.1583786636676;
        Mon, 09 Mar 2020 13:43:56 -0700 (PDT)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id s63sm17998768ywd.82.2020.03.09.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:43:56 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/5] phy: sun4i-usb: add support for the USB PHY on suniv SoC
Date:   Mon,  9 Mar 2020 15:43:23 -0500
Message-Id: <20200309204326.27403-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309204326.27403-1-thirtythreeforty@gmail.com>
References: <20200309204326.27403-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv SoC has one USB OTG port connected to a MUSB controller.

Add support for its USB PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 856927382248..5fb0c42fe8fd 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -98,6 +98,7 @@
 #define POLL_TIME			msecs_to_jiffies(250)
 
 enum sun4i_usb_phy_type {
+	suniv_f1c100s_phy,
 	sun4i_a10_phy,
 	sun6i_a31_phy,
 	sun8i_a33_phy,
@@ -859,6 +860,14 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg = {
+	.num_phys = 1,
+	.type = suniv_f1c100s_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A10,
+	.dedicated_clocks = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
 	.num_phys = 3,
 	.type = sun4i_a10_phy,
@@ -973,6 +982,8 @@ static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
 };
 
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
+	{ .compatible = "allwinner,suniv-f1c100s-usb-phy",
+	  .data = &suniv_f1c100s_cfg },
 	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
 	{ .compatible = "allwinner,sun6i-a31-usb-phy", .data = &sun6i_a31_cfg },
-- 
2.25.0

