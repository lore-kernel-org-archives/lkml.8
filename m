Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93AFC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983512072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmq4K6KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:41:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43087 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCFKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:41:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id v22so1330196qtp.10;
        Fri, 06 Mar 2020 02:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=al7age2oTXgYTympMQW4jKiNWfRyppUJjWuKVFSzTq4=;
        b=Pmq4K6KDvmWg+QImisnIgA7B7RmumCDCRG1Xkl53KFpEcY+WMWtEh6qtXRWE89kD8/
         ablkdKssUXeOAw8KzuISRSoznT0nsDNPDsLJbAd+B89tQXU4CPT0nu/wacgsNiy3Akd/
         wObt8muPZYIaPjFpZlh6ILWyiB2ueb07kRcxCTQSFuM7vXzlu0p8RWFbfPFE4j1RwgXO
         vTDpN0GhxFl39+h/8HFJr1sgpjk+8bdS1aYTI7a4icPjgzjWmOU/E05T7+h0FuPPr0+F
         fAQD1xEnyBoMLWMAoZBI3XK4nkWE4axsjGsEJ7KsUjYuE1C2+HZiG9qq407qRGkn1qyf
         xPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=al7age2oTXgYTympMQW4jKiNWfRyppUJjWuKVFSzTq4=;
        b=GaPVML/K50+BqtaCFuvD2fsHYOODgvAGYNmfICzaQxrTNUYc6vWZnHeCxzhraQYQV8
         9yWNX9gwd09+VRa1SRE6mebTOylLi7jAGVmVjzUCLvMPclD7SfC2jWJ/SqG4KAZf1t0s
         BTK0+xQHdOxVDMFMRo0bxC4rvBmybwZO/W2CqhZm81Q+dDyl6otAHZIg0usFpth+BIGb
         fBzWl0u80yF9Oiet01BmF5Hc37UFcTKE+f2pf8qIM4nsx7oAAn7qbVYVvDx6Z5UJ83sO
         73m9woy7xdiTG/atyZfHJdwsE6W7dODOqa5Cw0ahlJlXuVfmaXz8sb+Zzsgb9P3nZGuR
         iQRQ==
X-Gm-Message-State: ANhLgQ0s51YXsVEK+3ZYNxV6yHm8SoCKGMvcMI7kH23EATBt7UalJD30
        Qnb7SscaYHV84sBnQxfe2Mo=
X-Google-Smtp-Source: ADFU+vuSKVKDhCno4+Mq0uvE1KVuExpu4oA+/WFezYFdXs9rfgVJNmqSirh5K9SNW5BgkOeQFHON2A==
X-Received: by 2002:ac8:4659:: with SMTP id f25mr2248175qto.273.1583491293109;
        Fri, 06 Mar 2020 02:41:33 -0800 (PST)
Received: from L-E5450.nxp.com ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id u5sm17096932qkf.32.2020.03.06.02.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:41:32 -0800 (PST)
From:   Alifer Moraes <alifer.wsdm@gmail.com>
To:     robh+dt@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        marco.franchi@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alifer Moraes <alifer.wsdm@gmail.com>
Subject: [PATCH] arm64: dts: imx8mq-phanbell: Fix Ethernet PHY post-reset duration
Date:   Fri,  6 Mar 2020 07:42:19 -0300
Message-Id: <20200306104219.6434-1-alifer.wsdm@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ Phanbell board uses Realtek RTL8211FD as Ethernet PHY.
Its datasheet states that the proper post reset duration should be at least 50 ms.

Fixes: f34d4bfab354 ("arm64: dts: imx8mq-phanbell: Add support for ethernet")
Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
index 16ed13c44a47..06e248b95ada 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -207,7 +207,7 @@
 	phy-mode = "rgmii-id";
 	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 	phy-reset-duration = <10>;
-	phy-reset-post-delay = <30>;
+	phy-reset-post-delay = <50>;
 	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
 	status = "okay";
-- 
2.17.1

