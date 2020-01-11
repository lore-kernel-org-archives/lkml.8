Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C629C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5642082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738278;
	bh=HbygnXdb9+pNdvN77EkwyXpwBKKeuf9al5hOlxjXzp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WU8bjPs1zFTOq8t2y61n7jAT9cfhkSz1m6SSrtdojS8CfNGdh46CC+dKWGPJmezY7
	 VcScn05e/ab7gNF77GVXLcbG+Lz6qLey/oJ3MlT+jzBB+mOEveGf9oGwqWL5sPukbE
	 dRYldMcArlluoQXxLPzJmwt7eySnPHCQj09CFDWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgAKKYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbgAKKYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:24:33 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5018620848;
        Sat, 11 Jan 2020 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738273;
        bh=HbygnXdb9+pNdvN77EkwyXpwBKKeuf9al5hOlxjXzp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8wFL2J4VHLMIJycHytcWyhVTH36Kzwb50DS65hhuLLx7+8DpUZL3AcPBCsPgSxlW
         I9pABoHqbwX7uGGNP0tXjT+scnDQHX2pefC9ESOShk44bNJ82VdVBywi+CFTcRKAX+
         MLJPRHBy9rinPGS4i+5nt4qWjSyzsv0n8JiCiSzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 064/165] arm64: dts: ls1028a: fix reboot node
Date:   Sat, 11 Jan 2020 10:49:43 +0100
Message-Id: <20200111094926.483420867@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

[ Upstream commit 3f0fb37b22b460e3dec62bee284932881574acb9 ]

The reboot register isn't located inside the DCFG controller, but in its
own RST controller. Fix it.

Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index c7dae9ec17da..bb960fe2bb64 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -102,7 +102,7 @@
 
 	reboot {
 		compatible ="syscon-reboot";
-		regmap = <&dcfg>;
+		regmap = <&rst>;
 		offset = <0xb0>;
 		mask = <0x02>;
 	};
@@ -161,6 +161,12 @@
 			big-endian;
 		};
 
+		rst: syscon@1e60000 {
+			compatible = "syscon";
+			reg = <0x0 0x1e60000 0x0 0x10000>;
+			little-endian;
+		};
+
 		scfg: syscon@1fc0000 {
 			compatible = "fsl,ls1028a-scfg", "syscon";
 			reg = <0x0 0x1fc0000 0x0 0x10000>;
-- 
2.20.1



