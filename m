Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4EAC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA21E2465D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701604;
	bh=HnagLcugEPxKRMVeDKW3PpwSXLKSbWNBKXlVLtNoHMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JeHQlj8PvuhURTw9kbjpK8y/hrUwn810OElhtw3rsnFrjFWqiKJvUIesB6kpmoEr4
	 8QRp9MqdCLX74J36hy1sHLJZSxjZvitdHVaHmjvvlDRmjnhA7fDXtnpEXWEdZXj/z3
	 HOPSN434MyT3iNsuMBYRi6+Ce2ngTVFVEM2DF9rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394717AbgBNRdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390430AbgBNQG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:06:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67525222C2;
        Fri, 14 Feb 2020 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696388;
        bh=HnagLcugEPxKRMVeDKW3PpwSXLKSbWNBKXlVLtNoHMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXUT4NXYmBylU8FbrC4HSxnmGSn9oZqo+kujvM3nFbUsteiCVwCVCkAxvT+9kbIOO
         d3YjLwp7RDwdWhYngFKxj8ihJTFhgdlCSQAIw7gm8Z6z/0Tepttc0jQ9gs2ds5ADQ3
         oWsXKVErwE3kpW9CMNbKg1WylAT83UUByJ+Tcxok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 214/459] ARM: dts: r8a7779: Add device node for ARM global timer
Date:   Fri, 14 Feb 2020 10:57:44 -0500
Message-Id: <20200214160149.11681-214-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index ebf5b7cfe2159..63341635bddf8 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -68,6 +68,14 @@
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

