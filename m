Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1246C3F348
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772F121D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811768;
	bh=mOOtcuYefSa15nfqQ9Wq3br9lXDGL6dSNLWXObe5bYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0oETGuajVP5LiOOFC8mnIgFdhwrGWWyrbhOhi/ZZukKQIDzFE/CIc8n6dcgGFdA7z
	 q+94F+WaMtxW/7n4NGhE4Jfbbzh9nqg6R991AF1HHyE/By3gEdp+2o/WoXoTW/D+0D
	 1dk9rCYB2bhIZ+OAsankKVrkuMj3vhIBRN0J36MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgB0N4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732067AbgB0N4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:56:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986EE2073D;
        Thu, 27 Feb 2020 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811762;
        bh=mOOtcuYefSa15nfqQ9Wq3br9lXDGL6dSNLWXObe5bYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zti/Ycijs0cbHMY2BOpPHh8PLz1gCjn+URzIQnoFhN9ojjcgo16kAsN8ra0XPXk4l
         vlo2EwyA8RTEc9hR326wXeDUUvnIMn247ZpK/JKjb87okdz1eV7GvUrT6UyWSto/aw
         HVrhEEgQEl0PvZZxXSqpy82nWMQXFBgYe38C3RSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 091/237] ARM: dts: r8a7779: Add device node for ARM global timer
Date:   Thu, 27 Feb 2020 14:35:05 +0100
Message-Id: <20200227132303.724200994@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 8443ffd1bbd5be74e9b12db234746d12e8ea93e2 ]

Add a device node for the global timer, which is part of the Cortex-A9
MPCore.

The global timer can serve as an accurate (4 ns) clock source for
scheduling and delay loops.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191211135222.26770-4-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 8ee0b2ca5d39a..2face089d65b9 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -67,6 +67,14 @@
 		      <0xf0000100 0x100>;
 	};
 
+	timer@f0000200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0xf0000200 0x100>;
+		interrupts = <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&cpg_clocks R8A7779_CLK_ZS>;
+	};
+
 	timer@f0000600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xf0000600 0x20>;
-- 
2.20.1



