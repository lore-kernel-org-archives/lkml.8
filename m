Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD79C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61554206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260075;
	bh=Yqv4Iy4D7IpvZdWeRuwgS5y5415qBTlSh60EUkQfr4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHIftMfIq/kT7YdYlALREUFe4yT0MhUEiFORCC6UlHhEpHUMtmNaihXn2lLVqSxc7
	 Kg+xZXPEEMB2mohDEcJzSfDDk8pJYK0Cii4zRgLcVNiczGEpLYWDp2tI4uMPizmpoT
	 I+YE5ZQb3NqIEDswIDA9/v8RmMHsWdH2NgL8qpE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgGTPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbgGTPrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:47:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43079206E9;
        Mon, 20 Jul 2020 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260066;
        bh=Yqv4Iy4D7IpvZdWeRuwgS5y5415qBTlSh60EUkQfr4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1Wdyuzlh4q0ZI34tMM1RX3jaR4qu/6i27Yig4Vl1MZXq2lQuyaWjLbDlx5meVP4P
         F05vKEOgD81TQKOEb/RWVjDSXlUNwF/r6BuQ0SJ1oeRjb6Q/0SqPDprR0tvnwAhfaX
         yLPEIToazvFF0/eQtzBPQGguFlzYefA8qYTBzSEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 087/125] ARM: dts: socfpga: Align L2 cache-controller nodename with dtschema
Date:   Mon, 20 Jul 2020 17:37:06 +0200
Message-Id: <20200720152807.219607099@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit d7adfe5ffed9faa05f8926223086b101e14f700d ]

Fix dtschema validator warnings like:
    l2-cache@fffff000: $nodename:0:
        'l2-cache@fffff000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Fixes: 475dc86d08de ("arm: dts: socfpga: Add a base DTSI for Altera's Arria10 SOC")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 10d2fa183a9ff..7ee99e11508ca 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -706,7 +706,7 @@ ocram-ecc@ffd08144 {
 			};
 		};
 
-		L2: l2-cache@fffef000 {
+		L2: cache-controller@fffef000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffef000 0x1000>;
 			interrupts = <0 38 0x04>;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index bd1985694bcae..672e73e35228c 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -606,7 +606,7 @@ sdr: sdr@ffcfb100 {
 			reg = <0xffcfb100 0x80>;
 		};
 
-		L2: l2-cache@fffff000 {
+		L2: cache-controller@fffff000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffff000 0x1000>;
 			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1



