Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86916C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E1220575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JJCxO3Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgENIA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbgENIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:00:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC23C05BD0B
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so2589738wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3BhZ5w2nZuK3+ZudhXc+00fKQMrXVNQ6trbR5U2M5Y=;
        b=JJCxO3Exc7DnGIwr2iuuQUzDbvfOLbZbgPpv5L3N74cFZsgnyJHeo5Sc60JJTq+MbP
         XwFLwQsDTsS0wGHd4KAwQHWKbM9MwDOMb86EwwIBhrl0F6j84h5tjc2/n3ZabjTtMh9D
         ky3W3TQ+YF5EhKOyDkGQ3o2KIlO7tbPkHLOmpD4Nrk5F1S5+YN1zv+gHWLHEzDcrxu+g
         rabtnGA8f9E8JFjGQkbJ2p0Qn0ZRvcwuKhqf+n5uk9hGMcmu+GqfDrq5yfic4Rk4Cv04
         Tu/m1I679dB1PLq36SC+1yxLv5TcGKGsz+b/f+0RUtSrRVXjYdBuloDHyilE/A1AhdW4
         cHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3BhZ5w2nZuK3+ZudhXc+00fKQMrXVNQ6trbR5U2M5Y=;
        b=VvIrWO7HfHdgvW1Sw2SvSnSCUV9N/Vc6KAncnS+lHf/lSbZ58ssxdI0Ex4wbZoFJ6q
         OYO91lm5hzCi9+iQkE4ZtlZ5Y5/PLmZiToZdLdDBwHYRUaquZr1TtikzTnOiUkgrkfus
         RKpt3WeY/wrtJ+7cBmJS/l5hPUk21ExGf0myhw3izYYBgSg9klz8/maKl+PwQ9WD8975
         YGq9qIhDRtbOIFrAhmkkORtjTiA+6SdUN1dO4nxp73CHdDi2a1IbnK1VAaMNilfWVB8E
         WepvhmIz1oDkaDhhP9ORcXBDqe93fa1GoisNTUDNjhXb5BB2gNhpoyGKhbbCOnVo0KWI
         07ww==
X-Gm-Message-State: AOAM530jxNAtQbAJLp1Bi5drNcLZsLMZmIxQ3ii0llSqm1tjuoMDkyr6
        ioXL9PlB+SRDerTRI7VJ8ThDWQ==
X-Google-Smtp-Source: ABdhPJwQsAtFFDpkxmlp3HoBK9HFLKTyKPF/9otGNSorLEiCutYPpPt/Uz19BtSeOpUqWag0enyEZw==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr4090320wrp.419.1589443221364;
        Thu, 14 May 2020 01:00:21 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 81sm23337446wme.16.2020.05.14.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:00:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v3 11/15] ARM64: dts: mediatek: add pericfg syscon to mt8516.dtsi
Date:   Thu, 14 May 2020 09:59:38 +0200
Message-Id: <20200514075942.10136-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200514075942.10136-1-brgl@bgdev.pl>
References: <20200514075942.10136-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This adds support for the PERICFG register range as a syscon. This will
soon be used by the MediaTek Ethernet MAC driver for NIC configuration.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index 2f8adf042195..8cedaf74ae86 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -191,6 +191,11 @@ infracfg: infracfg@10001000 {
 			#clock-cells = <1>;
 		};
 
+		pericfg: pericfg@10003050 {
+			compatible = "mediatek,mt8516-pericfg", "syscon";
+			reg = <0 0x10003050 0 0x1000>;
+		};
+
 		apmixedsys: apmixedsys@10018000 {
 			compatible = "mediatek,mt8516-apmixedsys", "syscon";
 			reg = <0 0x10018000 0 0x710>;
-- 
2.25.0

