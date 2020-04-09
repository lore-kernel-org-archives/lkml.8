Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDF92082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586414690;
	bh=wpjYeJaRX+oFDpCf/IvH1JwOqqMijMUQvvWWiKeoI9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i3ZSdweo7PknA762pvjoftrYtSan5BowpcExrlFqtDIWdJVEoLKgO9N7MoG3aMhli
	 nmVE0iaX0zeYH5BkqRbTuI3S1msoul2YtsMbqA6go4RtUXe1WYWN4vI8S/w5iHEOW1
	 /VqY5mWVdrVdFIT2vF8LTWQfsdwRP5cdEi+xMyPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgDIGos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgDIGoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:44:19 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6631420771;
        Thu,  9 Apr 2020 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586414659;
        bh=wpjYeJaRX+oFDpCf/IvH1JwOqqMijMUQvvWWiKeoI9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hP5yP9BRPMqbNFCc2VoqiuxeeypKB7c4NTSMVMzFLZYmQiPNB7n8DYZe/XLrJi4/9
         NxB9tM5vULN+bgPKeHgBiR4uwsA7N2VluUF1fGOoT2CGEcqtnugZDkAwwUAc9PDESl
         UCEhFedk312390MObPJYeKjaIyb6hwBJc6t90yvc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>,
        Thierry Reding <treding@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 03/10] arm64: tegra: Remove redundant CLKDEV_LOOKUP selects
Date:   Wed,  8 Apr 2020 23:44:09 -0700
Message-Id: <20200409064416.83340-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200409064416.83340-1-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 architecture selects COMMON_CLK at the toplevel ARM64 config.
The COMMON_CLK config option already selects CLKDEV_LOOKUP so it's
redundant to have this selected again for the Tegra specific config.

Cc: Paul Walmsley <paul@pwsan.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b2b504ea6fd6..5d5d91feca44 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,7 +236,6 @@ config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC_PM
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF
 	select GENERIC_CLOCKEVENTS
-- 
Sent by a computer, using git, on the internet

