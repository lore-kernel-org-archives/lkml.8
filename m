Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD6FC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACD2246BE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4ihWZHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgB0SO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:14:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39431 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbgB0SO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:14:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id x97so61091ota.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAE4tbLOHr7PfWPVPg1IGfxuALloJp02P/TPV4CS1Go=;
        b=Z4ihWZHKv1Y5pFcZLZ4XJQTAABE5r8wzWtCj6Ft1pliDbn3z0QHM2JgMpcK1iUPoLV
         UTCzc77AfrfxzUFoAHFzxAZ3ZRKrp76X/PanPsUbX2+NBxCRgcaGSQmhwF2I/WwTkwAB
         aCZ3nE6sV3lvl5r5g6hmKNoUBA8HX3ja/tXPegXdyb0Pnv3SigB7fbk+DFJxCwc96Otj
         hLPB1UduFs447OdM5LQKCKyPSvcyjh5r343kUBKTiebcbuyS2e97AGnQr9fHxAbeQoA4
         0L3FE7H7+jteuNIgKYuY1+w50BXP7hSDOqbo95RF/RQsvY2fuVGrWxrnz/VYRVcSIugc
         xYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAE4tbLOHr7PfWPVPg1IGfxuALloJp02P/TPV4CS1Go=;
        b=eiolHIB8ukglkAVbFunzQ/bJcZe94aT/GlMcnH1h9araab7f/mnl1LTfj6u+FhLJY6
         O/msRbtdxnUSV3VK5bNrA32Uj34gF65GLX429zLNNbEJFJgM3BzyDo2m6MN5+X/50pF6
         fr7ymROjDESXqbxZlhSndxHvNrwigEXtc1GFp81VFp0v2UF6Tk+x3Tw3adbGBAFVruyW
         MDt1nrPa/eNgXrdNQgwq1LukdGS/C3BYJ0nctzs68tCDUM5WIS4jUyA/y2yeJZBGJvHM
         P+/xWR2TaNoKCpRgR133258rKd9Qbrt9+cbsAag0+DIety+9knIVNwNVWnVl5GfL1tyC
         JzGA==
X-Gm-Message-State: APjAAAV7VM77qmAAqK8PeLPYKJ5mSU7uQHPdHPFO28o/d0NYLdB6zy4H
        0mCqkFNOk214moQub5FsCeU=
X-Google-Smtp-Source: APXvYqwzFLqDr5jzWuvDV3j3CXdxyYYhAlWlTZrGUDDvb86Qf4WuW4y8kvwOM7tDhQvsK3goBo2/QA==
X-Received: by 2002:a9d:7309:: with SMTP id e9mr165540otk.260.1582827297343;
        Thu, 27 Feb 2020 10:14:57 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id t203sm2205534oig.39.2020.02.27.10.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:14:56 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] phy: sun4i-usb: add support for the USB PHY on suniv SoC
Date:   Thu, 27 Feb 2020 12:14:49 -0600
Message-Id: <20200227181452.31558-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227181452.31558-1-thirtythreeforty@gmail.com>
References: <20200227181452.31558-1-thirtythreeforty@gmail.com>
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

