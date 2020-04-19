Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F55C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE0D206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+I7XIdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDSNuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDSNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36DC061A0F;
        Sun, 19 Apr 2020 06:50:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f13so8667919wrm.13;
        Sun, 19 Apr 2020 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvYBwY55hequdKKDkallbXJKwj0FSX4Wpx+56e8/UBw=;
        b=Y+I7XIdJyCO7AikaNxp7CzikO0z7qJMeXabc77Mlpc2MXuiraKAO9dOwGKvKqkdvE7
         n9Bs6dXr35KzRkf4upwGp07k3nT3/2uYPnTKXyE7OWKCxvT2Hrx2+ISLXYZ0rHoXgued
         iBk3QBwEDDe5i3PG6Zyk5stbHl4qthyctLTUNkjw1cnsuqDF+euYm9cfkp/Q7Mbh2CDs
         4Vd/4thZYWx/XBegRkOyBSsvptaJIcHOkiejFMoN7tej1tlaGFa5Uj0fMHytZ8oXfkva
         WL5F5XVaX9QDhcJWecqe4RfoVJAQ8kI94YEAzcNsPwAgvMM9zsop49HHS0G5RXNcgU1F
         2FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvYBwY55hequdKKDkallbXJKwj0FSX4Wpx+56e8/UBw=;
        b=Wrnc9KiDT2Il1ahL3c/TMdnUyrzzhF9fyc6+qn/6tatO6mJ1rbZGmbmD/kgOUmhm+X
         b4daOjvY27ddx6zKZcHE5lYwek9LNJILtQ1Xr5SoNdfQ+4827sgRe5dhxm39uv+VIWPr
         7/Nk4l2PB6l3x68WEG2m3nQEHjTb5Q1qdtd+YtZxN80CrkDPkPQIHmPpiy4Ko6J/H6of
         D6+7tZFNJshK4IpupuHqG5L92SYE9ZGSglVb3EVH5gCkBS+lFL3t8hl9DJAlUqOtmLkj
         MZ0o44sO8ylRCJ/4IvSKytfQy6VR3TJD2iwGY1jfExxsiIt5bGmjei+FEfS0SPcsVwUq
         XZMA==
X-Gm-Message-State: AGi0Pua/ElEyUsoXeDMJtQMvqcAZErveBSNl/zaTSFSP0C0FbDsMes44
        Y7f93hH2+JdoNgfbQcp4QHh0SeC0gbH28g==
X-Google-Smtp-Source: APiQypLn4bqtnUB1e79+Q6pe+4ghMVVA9Jb3/VN4U1zkQZ+3oHqQjqX4Lgt7x7IVN0Ja002iok/QaA==
X-Received: by 2002:adf:d0ca:: with SMTP id z10mr14909892wrh.172.1587304220548;
        Sun, 19 Apr 2020 06:50:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:19 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 6/7] arm64: dts: allwinner: Sort Pine H64 device-tree nodes
Date:   Sun, 19 Apr 2020 15:50:10 +0200
Message-Id: <20200419135011.18010-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419135011.18010-1-peron.clem@gmail.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pine H64 device-tree have some nodes not properly sorted.

Fix this.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index b0642d841933..63a785b534e1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -80,6 +80,18 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ext_rgmii_pins>;
@@ -91,17 +103,6 @@
 	status = "okay";
 };
 
-&mdio {
-	ext_rgmii_phy: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-	};
-};
-
-&de {
-	status = "okay";
-};
-
 &gpu {
 	mali-supply = <&reg_dcdcc>;
 	status = "okay";
@@ -117,12 +118,11 @@
 	};
 };
 
-&ehci0 {
-	status = "okay";
-};
-
-&ehci3 {
-	status = "okay";
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
 };
 
 &mmc0 {
-- 
2.20.1

