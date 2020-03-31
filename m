Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E94C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC920CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOq/MgcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgCaRCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:02:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43202 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgCaRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:02:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so22752276otb.10;
        Tue, 31 Mar 2020 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9UnDZyQ2YKPggbhoniPAeDPe2uWjAaBSRBm1Rfex5E=;
        b=iOq/MgcBbSipwpL2n98Yk5g1vneSS5GA3tyBB69AbUUL5cNdEcOnw2MeATbdsbXuPa
         q51MWnepSfz4AUMlY558zD6fcHf/6wVH/QlYdH/68WRgQCEc9lS1is6B2QZD5Mh6vr3i
         hes/yYhQ8QzoKYlEsOa6tG7ZLh18RpmgwgYS5UUwM4erDxteM1dktc1Bx8ynD030JWVX
         vKePHvx7M7ZOhOBmHOA74xux6fdXR+5/xAI/6wVckRj4fEVNihE3dwP1nR4Xo6pjr3x1
         N6zbgzjaKWMXiZL/ovbynVMSYl0Zu8Vz39FNjPEXCvLsOKNA9s4YB671aHX9QfC7obaD
         O0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9UnDZyQ2YKPggbhoniPAeDPe2uWjAaBSRBm1Rfex5E=;
        b=gfjdg/8Kz+pZnlHv7g4rQ3FHdaP2fjYE4CD69kwSZhQLyoPeyQX6GIGwExK6AXzKDp
         lu29BDlm7gRC8KF8eRIxw6LvsdE6V+Ubylp0zeLAkSpw09i8UEkZvkydx/+AyEySefHv
         ZgiXpBwflhODZc6YM6Thdwas+9utLQutch/BKHAJbeXZ8QkjXB5JKNsvTuSPzfzAMSWQ
         h1OSYe1f5/+RCqe+oiR3Iq/bvSlCwoAYQ00Ex0YL5VEAT8SYGxuxfRDD4d5fekA1R1ZE
         JkYJBAdK8uM4vUED/KVm2UubigKaDRhY8mcgNlcPYdNs2GhV39u7RAtC4YHBEQhvX4N5
         OCkA==
X-Gm-Message-State: ANhLgQ15/7+8iFqp9xrr/0OmyWPjF/dafRmvOZL/Kz0mkEmlU7amDeq5
        KY6NCmDaceV8pCQIQJV6wJE=
X-Google-Smtp-Source: ADFU+vtFnS3zr2wAMvjQYxIlrGQnqds5Xcyfx/Z5iGHNM3Jx81a88ZVOB6nYOjKjkMwMfb92CZrk7A==
X-Received: by 2002:a05:6830:1d90:: with SMTP id y16mr14257426oti.157.1585674149603;
        Tue, 31 Mar 2020 10:02:29 -0700 (PDT)
Received: from desertvoice.lan ([2601:3c7:8303:2a10::21c])
        by smtp.gmail.com with ESMTPSA id h7sm2952605otk.3.2020.03.31.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:02:29 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 2/5] phy: sun4i-usb: add support for the USB PHY on suniv SoC
Date:   Tue, 31 Mar 2020 12:02:16 -0500
Message-Id: <20200331170219.267732-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331170219.267732-1-thirtythreeforty@gmail.com>
References: <20200331170219.267732-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The suniv SoC has one USB OTG port connected to a MUSB controller.

Add support for its USB PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
George Hilliard: changed style to match existing code.
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
v1..v2: reordered sun{50,iv} to match `sort` order.

 drivers/phy/allwinner/phy-sun4i-usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 856927382248..5c10b55f2aad 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -107,6 +107,7 @@ enum sun4i_usb_phy_type {
 	sun8i_v3s_phy,
 	sun50i_a64_phy,
 	sun50i_h6_phy,
+	suniv_f1c100s_phy,
 };
 
 struct sun4i_usb_phy_cfg {
@@ -972,6 +973,14 @@ static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
 	.missing_phys = BIT(1) | BIT(2),
 };
 
+static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg = {
+	.num_phys = 1,
+	.type = suniv_f1c100s_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A10,
+	.dedicated_clocks = true,
+};
+
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
@@ -986,6 +995,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
 	  .data = &sun50i_a64_cfg},
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
+	{ .compatible = "allwinner,suniv-f1c100s-usb-phy", .data = &suniv_f1c100s_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
-- 
2.26.0

