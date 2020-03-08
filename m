Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C8C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA2120828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCHQdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:33:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:44940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgCHQcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7357B2F2;
        Sun,  8 Mar 2020 16:32:50 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC 10/11] ARM: dts: sp7021-cpu: Add interrupt controller node
Date:   Sun,  8 Mar 2020 17:32:28 +0100
Message-Id: <20200308163230.4002-11-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi b/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
index ae58bf5ffadf..7e424baa9214 100644
--- a/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
+++ b/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
@@ -73,3 +73,16 @@
 		};
 	};
 };
+
+&rgst {
+	intc: interrupt-controller@780 {
+		compatible = "sunplus,sp7021-intc";
+		reg = <0x780 0x80>, /* G15 */
+		      <0xa80 0x80>; /* G21 */
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
-- 
2.16.4

