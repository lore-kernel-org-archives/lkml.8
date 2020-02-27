Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A5C3F358
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299620801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811256;
	bh=XYGSiGMpjLNrL6iof9ltMi4uaPxiKfUKwYzBWza8r7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YS3WzPPD0RN3Op6hgb0v5wAElmNniC7dspOnu5r+fa5GLe2prVbfXWtZYcJsolstD
	 Jt9VTSStq/bpiXk/7i8882AHeYmVVczNkn2nhZDaB/A4uCz5ceId9SHpxfAiyg08JN
	 ATC+GF29eOCd76I0K5KiJBrnd/zSv7m4piyVFuo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgB0Nrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbgB0Nra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D2E2469F;
        Thu, 27 Feb 2020 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811250;
        bh=XYGSiGMpjLNrL6iof9ltMi4uaPxiKfUKwYzBWza8r7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVyxKUgbwcvWnngF1mR7qaexJSUSLViJehBF8Ws2iZm4wchKH77hKAlZDMsEVhNU8
         Cc8+cf5OenGwUp/GnjKAuCo4o5NdQzjZUaanIE/gSBpKgodppQVG9gUNRu8I+pmF3H
         JqU9XE9IKF32Wd7sbJlqsd+GBZoyFlR8qdkyqIfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 061/165] ARM: dts: r8a7779: Add device node for ARM global timer
Date:   Thu, 27 Feb 2020 14:35:35 +0100
Message-Id: <20200227132240.407677843@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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
index b9bbcce69dfbd..6c6d4893e92d4 100644
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



