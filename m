Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D41C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEBE222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846609;
	bh=cKYl5Bomn7OIOLCEqiFWbDvqbeoLZJjAkix424k6Qd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y93sJBwX1RoeFaHzoO1gEj/Knh205DLAGke6IYC9XFEEwahjRHRl7k3dqE3QCHgep
	 cjpIxmwOiSJ017HCiIzX7+EtMSUfLhzMviugIk38KyX1etv+t5KTRk0zXurhRLTsl1
	 PGAHjt77Jz+mdya6rJZFw/wFFopY+iEViA69+XtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgCJNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbgCJM7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:59:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1019A2468D;
        Tue, 10 Mar 2020 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845161;
        bh=cKYl5Bomn7OIOLCEqiFWbDvqbeoLZJjAkix424k6Qd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvf59BZjVcKmOv/Xf1maJv8Z58uXf74slvbk84t2m/51lUcTaniA2ABT5fCy/tZn4
         KlTC/++WEU5ZCuBPbpbIAi/BYNb7ujMuSFmgj2CpSm8pdP/4Tfzk8h5mez+Qbd4Cak
         EnCb5RBsWJo8uoK96e+xClV+kX/OjA4IZvzilhy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ley Foon Tan <ley.foon.tan@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.5 085/189] arm64: dts: socfpga: agilex: Fix gmac compatible
Date:   Tue, 10 Mar 2020 13:38:42 +0100
Message-Id: <20200310123648.275495203@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ley Foon Tan <ley.foon.tan@intel.com>

commit 8c867387160e89c9ffd12459f38e56844312a7a7 upstream.

Fix gmac compatible string to "altr,socfpga-stmmac-a10-s10". Gmac for
Agilex should use same compatible as Stratix 10.

Fixes: 4b36daf9ada3 ("arm64: dts: agilex: Add initial support for Intel's Agilex SoCFPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -102,7 +102,7 @@
 		};
 
 		gmac0: ethernet@ff800000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff800000 0x2000>;
 			interrupts = <0 90 4>;
 			interrupt-names = "macirq";
@@ -117,7 +117,7 @@
 		};
 
 		gmac1: ethernet@ff802000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff802000 0x2000>;
 			interrupts = <0 91 4>;
 			interrupt-names = "macirq";
@@ -132,7 +132,7 @@
 		};
 
 		gmac2: ethernet@ff804000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff804000 0x2000>;
 			interrupts = <0 92 4>;
 			interrupt-names = "macirq";


