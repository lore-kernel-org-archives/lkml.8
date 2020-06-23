Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	SUBJ_BRKN_WORDNUMS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EB52076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgFWCw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:33024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731954AbgFWCvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEDAAB1A2;
        Tue, 23 Jun 2020 02:51:39 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 22/29] arm64: dts: realtek: rtd16xx: Add eFuse node
Date:   Tue, 23 Jun 2020 04:50:59 +0200
Message-Id: <20200623025106.31273-23-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for eFuse.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
index 04cb546142a0..3c955fc7450c 100644
--- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -155,6 +155,14 @@ iso: syscon@7000 {
 				ranges = <0x0 0x7000 0x1000>;
 			};
 
+			efuse: efuse@17000 {
+				compatible = "realtek,rtd1195-efuse";
+				reg = <0x17000 0x1000>;
+				read-only;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
 			sb2: syscon@1a000 {
 				compatible = "syscon", "simple-mfd";
 				reg = <0x1a000 0x1000>;
-- 
2.26.2

