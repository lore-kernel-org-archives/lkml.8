Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28589C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C9920675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609395;
	bh=GpAFdeV30Ly8tSqs64OvWbMhA2JGYKwmki85FBOeM6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SIoYEbFPHc8JewESA3DnNsYn4ITuhN7MJ9VluQ5ttxE5vmVI6wv2fjPuEcNwZpMP8
	 Iahyb8mRXXWgsR1t8gqXsHtuTELzNf4Gw+KIdwbLBf40nsrZx8M3fCRhX5yvDvyNn/
	 +VkyR43Qz2m2gWniPDCkgDEFCKq6HWQ+HGw/x9MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgBMPZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgBMPXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:52 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF18246A3;
        Thu, 13 Feb 2020 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607431;
        bh=GpAFdeV30Ly8tSqs64OvWbMhA2JGYKwmki85FBOeM6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srQgvdLGuL0e/g+wWjUsu+iD9w76FK4oVlPqs081wsh6Cz9pfg+wLj0+SZ+ymT+LO
         JWdz3x1HBMnadE8KC0gX26WtFyavD4yzbokB2pPOWHovSUPJiak+Edw/vm0r2d8SuG
         rZVSFmMRwHt0omLrbRMKqX3Kl6B4rskU6ouADG+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.9 057/116] clk: tegra: Mark fuse clock as critical
Date:   Thu, 13 Feb 2020 07:20:01 -0800
Message-Id: <20200213151905.073987382@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

commit bf83b96f87ae2abb1e535306ea53608e8de5dfbb upstream.

For a little over a year, U-Boot on Tegra124 has configured the flow
controller to perform automatic RAM re-repair on off->on power
transitions of the CPU rail[1]. This is mandatory for correct operation
of Tegra124. However, RAM re-repair relies on certain clocks, which the
kernel must enable and leave running. The fuse clock is one of those
clocks. Mark this clock as critical so that LP1 power mode (system
suspend) operates correctly.

[1] 3cc7942a4ae5 ARM: tegra: implement RAM repair

Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/tegra/clk-tegra-periph.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -797,7 +797,11 @@ static struct tegra_periph_init_data gat
 	GATE("vcp", "clk_m", 29, 0, tegra_clk_vcp, 0),
 	GATE("apbdma", "clk_m", 34, 0, tegra_clk_apbdma, 0),
 	GATE("kbc", "clk_32k", 36, TEGRA_PERIPH_ON_APB | TEGRA_PERIPH_NO_RESET, tegra_clk_kbc, 0),
-	GATE("fuse", "clk_m", 39, TEGRA_PERIPH_ON_APB, tegra_clk_fuse, 0),
+	/*
+	 * Critical for RAM re-repair operation, which must occur on resume
+	 * from LP1 system suspend and as part of CCPLEX cluster switching.
+	 */
+	GATE("fuse", "clk_m", 39, TEGRA_PERIPH_ON_APB, tegra_clk_fuse, CLK_IS_CRITICAL),
 	GATE("fuse_burn", "clk_m", 39, TEGRA_PERIPH_ON_APB, tegra_clk_fuse_burn, 0),
 	GATE("kfuse", "clk_m", 40, TEGRA_PERIPH_ON_APB, tegra_clk_kfuse, 0),
 	GATE("apbif", "clk_m", 107, TEGRA_PERIPH_ON_APB, tegra_clk_apbif, 0),


