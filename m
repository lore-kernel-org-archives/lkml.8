Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C39EC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F077F24687
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696972;
	bh=VAXM/wI+ARk8lW10+nryJ2K86Vm1q4s0xDutsq//i+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dc1K9fbqUH4SMvGIbjSDE4a1LSK6t/sb/CYu81/F0Dtk3mxIZYTzBULgNVn+JpZss
	 tM7bBlyVuDeHM2h5n9gWdAi+AAY9xrKJGL5S9qiCimLUsDPmtBvG2plT1y6oeZHWCf
	 /j0G0GdpK09oZvoeqsacKIwDdjV8o1/dHXkdcNnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbgBNQQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392438AbgBNQPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:15:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B656A246DA;
        Fri, 14 Feb 2020 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696915;
        bh=VAXM/wI+ARk8lW10+nryJ2K86Vm1q4s0xDutsq//i+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1u4hFqaoCRgySgzlzsoSprOYpIPcdmf/CJjgnj0gsWurVXsTO6jO/nM8326OPYUO/
         Ku4AAXA7k3V6X7xRw1ADx6V0Mc6b8FfTJ5nq/7bZGL1peCQyfsFDeY1lMaeVzzTf+0
         eBi12bwwT0NN7Oo7+GhSiC6GwYcMiSnoaZxBJ2Vo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 164/252] ARC: [plat-axs10x]: Add missing multicast filter number to GMAC node
Date:   Fri, 14 Feb 2020 11:10:19 -0500
Message-Id: <20200214161147.15842-164-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 7980dff398f86a618f502378fa27cf7e77449afa ]

Add a missing property to GMAC node so that multicast filtering works
correctly.

Fixes: 556cc1c5f528 ("ARC: [axs101] Add support for AXS101 SDP (software development platform)")
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/boot/dts/axs10x_mb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 37bafd44e36d0..da10a569adf73 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -80,6 +80,7 @@
 			interrupt-names = "macirq";
 			phy-mode = "rgmii";
 			snps,pbl = < 32 >;
+			snps,multicast-filter-bins = <256>;
 			clocks = <&apbclk>;
 			clock-names = "stmmaceth";
 			max-speed = <100>;
-- 
2.20.1

