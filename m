Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89460C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B2A20757
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JIdJlCRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgEKPIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730376AbgEKPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:08:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972BC05BD0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 50so10881611wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=JIdJlCRVq/GMgbBOvi6/7vVciRUSXXPqqjgduOgvL6hA0KWWzhAvAc4R1L0GT4gHDf
         8IwpdH2Yu9XMwIwKiNXbtmKgEvK4I/GzELYFo8rR2E8gwlPB3G4Ci5J99YwzgjqqQ3mm
         tKGH8HwJEXN73O+tXJbA+hKlAPPmJxkYMDVJOuNh/sm37mW+SRwSnwEvlor8o9Rx9QEH
         hnJ+YkdjEzwA/2jbkn4zicFLDMTmRXu3oOOCdGkHMZqEr7X95rALqp2a1WUtMH+ozBxQ
         FHjKG0IMFQJ9PtkrWaR8RHbB4qXgsRrsjCCu27j+GJ5AhVxFQHMrjbOzvmhOeEw2l7cW
         +F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLB08H4ZIlTMzvj5hInDPm3tTNq7mk/XtYoMNSk6v2w=;
        b=pCor43oYktLHGeQJxfCPHiQXAfXsFBqJ+oVzzxvXos4xCv2WAkqrjXlOvq32MNUkPD
         CfmLC/l8fKmfIpkcFLQq890s3WZdulTPEog75m4bbaR/VBzgCV6jPourmUuFDVq2NTzJ
         +0DxHFxzf4Es/bgeifKAaYxJUgM5MNkiitevKyyom67ZEeyFQ1GyxnCvVGpK8FdTPZ/x
         qgCnfrMhOArkREIIrSFHZwBqqkVwx0rAwdxjhbMPhUkw6rXwgSTw5eNDWtCas5epNIQM
         FgVdXibSjVF0ydhM5H/hRWNdm8xBUbnW2U2ADSexewx7TStPz3uV0i2sKyES/sLCWcBo
         17CA==
X-Gm-Message-State: AGi0Pubc5InnAEe0xylic8xaPKv3VG2B3RAWMgzQby1JB//BkSIFG+r8
        KGnldjkSKJLxEOLdDDjh0GXEcQ==
X-Google-Smtp-Source: APiQypKchqURWEOE156yp9c2Gtsg+rjBGU1OyYDs5zNKt1tBVinXwxb57TLkJavCyiOfPrG3uEzb7g==
X-Received: by 2002:adf:9264:: with SMTP id 91mr19344771wrj.362.1589209715886;
        Mon, 11 May 2020 08:08:35 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 94sm3514792wrf.74.2020.05.11.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:08:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 11/14] ARM64: dts: mediatek: add the ethernet node to mt8516.dtsi
Date:   Mon, 11 May 2020 17:07:56 +0200
Message-Id: <20200511150759.18766-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511150759.18766-1-brgl@bgdev.pl>
References: <20200511150759.18766-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the Ethernet MAC node to mt8516.dtsi. This defines parameters common
to all the boards based on this SoC.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index 8cedaf74ae86..89af661e7f63 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -406,6 +406,18 @@ mmc2: mmc@11170000 {
 			status = "disabled";
 		};
 
+		ethernet: ethernet@11180000 {
+			compatible = "mediatek,mt8516-eth";
+			reg = <0 0x11180000 0 0x1000>;
+			mediatek,pericfg = <&pericfg>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_RG_ETH>,
+				 <&topckgen CLK_TOP_66M_ETH>,
+				 <&topckgen CLK_TOP_133M_ETH>;
+			clock-names = "core", "reg", "trans";
+			status = "disabled";
+		};
+
 		rng: rng@1020c000 {
 			compatible = "mediatek,mt8516-rng",
 				     "mediatek,mt7623-rng";
-- 
2.25.0

