Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B4C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735E420661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="b1g+w8Bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgEEOD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729395AbgEEODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:03:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7156DC061BD3
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:03:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so2935022wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZF4M1Ryr6CWnpRgUMWuRsLTKn/UHmWXZ3+MZTEjA0A=;
        b=b1g+w8BbUfw1KBw5K5flqcpokPuwWxqpurh2OtOPaunuRCeznQpZQlwP/WmuzoQgod
         CFSP4OiPt1lnEwVmBbNmoJbW8Lp9A94lN6aZgEgid2Id63oLBylgAseWNbdxn6jtSsYR
         E/Fc3NnZWPVr75Zc4iI18RNGT0JBcgshtWeyJ7ygIa2DncTH6eFWRlYLO+juQ1IJuzRg
         qq/R2tbLKwU0DYSzilgyEMuOgD9YzdMBKR7ZxLdG9s7DBdX+mipCe+CicuEcioBHW8Pl
         SLJzfUoWzzS0YBpfZIcrkuLP4G1MO1KO2GPMW7SFg0Od6O4NZwujxJubuNCjSksjEPFg
         B38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZF4M1Ryr6CWnpRgUMWuRsLTKn/UHmWXZ3+MZTEjA0A=;
        b=ZyQh8qgZMZt2mO5D6Z3HEXHUe3hg1Z/Kbl9MmAdFO4dv4c6G+5/5OIxJBmZOlZPf7k
         PsZyfO6INittU2Uo+ZIHmXk+JPdnsaRtIaWJD4OFrkO2GYEMENETF0JREloGUkmYSh4s
         lDuOuHp9p16u+SymgR4d+YLlqtAC8m7t/7IdW1QYsaD17O1Ekt0iChnTTIjfRUncuxkP
         xyYTchhONM5XGL1U/jaMVktzcaq74gDijvkSKbbpYaLFkFHsfj05j/pQyZCAM8MWXpNQ
         F59+YXQ88nr7Xt8eFFD2VY5McFQoJOz/m8r7s8nO205YFILq/1nJ9mJ1CdpEt8KH5qOf
         zHZg==
X-Gm-Message-State: AGi0PubSEPA10IvWJt2T2OR2wt6LvDoriiqKBsImBxwuggP4KK/X/WEy
        UkUdP3FVBm+dLv8Y6JlpIM0dDA==
X-Google-Smtp-Source: APiQypKSn8NhwYdJ0V9/oJPNixCPyhQzeTO3N+zmykXTaq3hm8BpCPa3gRNfEdcvq21s3N2xigB8/Q==
X-Received: by 2002:adf:e905:: with SMTP id f5mr3949344wrm.409.1588687400189;
        Tue, 05 May 2020 07:03:20 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id c190sm4075755wme.4.2020.05.05.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:03:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/11] ARM64: dts: mediatek: enable ethernet on pumpkin boards
Date:   Tue,  5 May 2020 16:02:31 +0200
Message-Id: <20200505140231.16600-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200505140231.16600-1-brgl@bgdev.pl>
References: <20200505140231.16600-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add remaining properties to the ethernet node and enable it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../boot/dts/mediatek/pumpkin-common.dtsi      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 4b1d5f69aba6..dfceffe6950a 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -167,6 +167,24 @@ &uart0 {
 	status = "okay";
 };
 
+&ethernet {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_pins_default>;
+	phy-handle = <&eth_phy>;
+	phy-mode = "rmii";
+	mac-address = [00 00 00 00 00 00];
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
 &usb0 {
 	status = "okay";
 	dr_mode = "peripheral";
-- 
2.25.0

