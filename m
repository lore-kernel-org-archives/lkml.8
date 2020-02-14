Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9411FC3B1A6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E9C2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701039;
	bh=JisXudK13Jk6Kspb8myNxbaBJxcABpU3ZxO3USpbX0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qxznDUdzdvtXnnH/9o6E2JlX46i8ADrvJMhPnSUgTFfDnk3fP3nwOGisnaPV1v83I
	 C7vPIrwgDCMqkVlHislItPgyUvToLKGMp2Z60+OnoRLiqekosTQgjydO6YllOb6CyD
	 JG4fKGs8521yfVX5HOSRZqb1LnoPTqY+ELtfkLw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbgBNQJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389963AbgBNQJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988AD24681;
        Fri, 14 Feb 2020 16:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696549;
        bh=JisXudK13Jk6Kspb8myNxbaBJxcABpU3ZxO3USpbX0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2Ry/xdDrIas9EIQFjWqwaivTqr4jLFRNEbauVx4khClXSiL7ubtnUgha2OnPDFuF
         u/jS8/WwYWM1KrJqyyfVUOdGrfB5xKbuFaTg7U7LkCKL29a0TDgqK5nWKIn+2hPXTp
         8Wkw0iqbYAe8nh7OJCLzq5tOmCHCTIgRtV6jPU9M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 342/459] arm64: dts: ti: k3-j721e-main: Add missing power-domains for smmu
Date:   Fri, 14 Feb 2020 10:59:52 -0500
Message-Id: <20200214160149.11681-342-sashal@kernel.org>
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

From: Lokesh Vutla <lokeshvutla@ti.com>

[ Upstream commit 3f03a58b25753843ce9e4511e9e246c51bd11011 ]

Add power-domains entry for smmu, so that the it is accessible as long
as the driver is active. Without this device shutdown is throwing the
below warning:
"[   44.736348] arm-smmu-v3 36600000.smmu: failed to clear cr0"

Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 698ef9a1d5b75..96445111e3985 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -43,6 +43,7 @@
 	smmu0: smmu@36600000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x0 0x36600000 0x0 0x100000>;
+		power-domains = <&k3_pds 229 TI_SCI_PD_EXCLUSIVE>;
 		interrupt-parent = <&gic500>;
 		interrupts = <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
 			     <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>;
-- 
2.20.1

