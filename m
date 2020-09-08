Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE2121D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl35qbKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgIHHa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgIHHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:30:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F9C061573;
        Tue,  8 Sep 2020 00:30:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so16229306wmi.1;
        Tue, 08 Sep 2020 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmA2lH7gtqxoy4mDbQrWCRwHZAf3YyIuPWiZh8AnqYQ=;
        b=Xl35qbKVmDEE2krWlxOS4SSQHfc1+nT1fS34f3N8NHld+TH6w8YRP7rMSbMyxOkOY/
         o6EQr1iRJ5fjKT938/V5rxpyD0OQOmE+57w8nAJb900n2KTKeZfYnJOYGiEGpcf6lArT
         88GZZZQLKpwHYJNPrdM616uzoTPqNlgnWKswwSs1Cimi7zgFmvJCV/4WFT9pcxBhXXNY
         fpnlEd1Bil24AMUUMBQxfwgwi5l6ADc8elexQRZjYI4Jj5+HJE1Oc3ON+R3EDjQXhsNp
         qwZpfzJfpBJVaYB3rHNodTLWHB/GaIP9tp0sHRmLC2k7HI0hzM4ZjCIjFj3yg7etzu4f
         qswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmA2lH7gtqxoy4mDbQrWCRwHZAf3YyIuPWiZh8AnqYQ=;
        b=GsGp6PGTETBdoZJh+tR+mcrDK+i8hKDI8KfYTzTBn7VuB24Xrq3bcscCqTv2ZENDNe
         s884fHtDGQH5rXCI1RBMPl18TJjvzklKio6TUNq3fzj/LbkrlGXRVrRA8wpamKx5y+Or
         PQ5fI2shl3qtySnx2C2iVaB6ZO+Vt4p1mthBBgBTc7S3AxWJ6SdL5FsL6HXKXLYMAaxC
         vLakOhbEoQ6bwFryfFFHLtLVvCgR99bqlGbid1LVvLABRtagk8QeiNHibSoLCbo+AX2Y
         xIbNiGRsmgXcoN2WorxjlHYskJwKggNNIaKsRfXQI6z6sJ0eXbf+tFfxK+36m1Hs57iY
         x8hQ==
X-Gm-Message-State: AOAM532YLeApv0YKMch3gYPt5/fysdurT/RVx27ED/eOvdcoyEFISf9Z
        7Lbq/MUSP+1wiLw0hbHAILw=
X-Google-Smtp-Source: ABdhPJzh2uEi1a9lEH05SEcFEEKjR5cujH7Cqau95bPA8Are5JFA2A660SUhx29/ShVmCPTgP40F7Q==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr2962523wmo.186.1599550252445;
        Tue, 08 Sep 2020 00:30:52 -0700 (PDT)
Received: from mamamia.internal (a89-183-54-2.net-htp.de. [89.183.54.2])
        by smtp.gmail.com with ESMTPSA id u66sm30949377wmg.44.2020.09.08.00.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:30:51 -0700 (PDT)
From:   Andre Heider <a.heider@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: espressobin: Simplify v7 ethernet port labeling
Date:   Tue,  8 Sep 2020 09:30:50 +0200
Message-Id: <20200908073050.535919-1-a.heider@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the switch ports have a label in the .dtsi, simplify the whole
"switch0" block for the v7 dts files.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---

This goes on top of Pali's patch:
"arm64: dts: marvell: espressobin: Add ethernet switch aliases"

The resulting .dtb files are the same.

 .../armada-3720-espressobin-v7-emmc.dts        | 18 +++++-------------
 .../dts/marvell/armada-3720-espressobin-v7.dts | 18 +++++-------------
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
index 215d2f702623..61d49d6a2a2a 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
@@ -28,20 +28,12 @@ aliases {
 	};
 };
 
-&switch0 {
-	ports {
-		switch0port1: port@1 {
-			reg = <1>;
-			label = "lan1";
-			phy-handle = <&switch0phy0>;
-		};
+&switch0port1 {
+	label = "lan1";
+};
 
-		switch0port3: port@3 {
-			reg = <3>;
-			label = "wan";
-			phy-handle = <&switch0phy2>;
-		};
-	};
+&switch0port3 {
+	label = "wan";
 };
 
 /* U11 */
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
index b6f4af8ebafb..44dbe9a21cc7 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
@@ -27,18 +27,10 @@ aliases {
 	};
 };
 
-&switch0 {
-	ports {
-		switch0port1: port@1 {
-			reg = <1>;
-			label = "lan1";
-			phy-handle = <&switch0phy0>;
-		};
+&switch0port1 {
+	label = "lan1";
+};
 
-		switch0port3: port@3 {
-			reg = <3>;
-			label = "wan";
-			phy-handle = <&switch0phy2>;
-		};
-	};
+&switch0port3 {
+	label = "wan";
 };
-- 
2.28.0

