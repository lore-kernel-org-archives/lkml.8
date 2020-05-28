Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDD6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC6A215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667122;
	bh=PLNJeXxTBPc66RzOoR4Z0fys6oMg6bP2vmEK7g3T1FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nckx03I0bFdLeRjpoThTxEi1KxZ/GsDYXh1UkrKLNwx/H3M1Tcyg3JuDEo1I0E5bp
	 4KrBmKtRkTo9VLnI/UOlJklzthtDI9/3BSrUOvJh38EstlPyA478F5s7CFjdDQzqsd
	 rwCJ3rTCdGVVSoLV9DCP+v9XKX/YnPupMMv91lXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgE1L6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389093AbgE1L5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13C4216C4;
        Thu, 28 May 2020 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667067;
        bh=PLNJeXxTBPc66RzOoR4Z0fys6oMg6bP2vmEK7g3T1FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIsZYTqXjMgwGr8CqJ/GAgShtF0Cns+kgEsiElK+pSglW+4es7SI8v8CSge0McTmk
         ++FgMFezFd3H15kwPQpWqZ0Y7IcDnn8IV18onEr0cJ7mM3Wn13SsnyL1Qd/KqSwks9
         443fMMjh121eNWGOzft2ptxbLrx/DTEB5IKQ3XC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        kbuild test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 02/13] ARC: [plat-eznps]: Restrict to CONFIG_ISA_ARCOMPACT
Date:   Thu, 28 May 2020 07:57:33 -0400
Message-Id: <20200528115744.1406533-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115744.1406533-1-sashal@kernel.org>
References: <20200528115744.1406533-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit 799587d5731db9dcdafaac4002463aa7d9cd6cf7 ]

Elide invalid configuration EZNPS + ARCv2, triggered by a
make allyesconfig build.

Granted the root cause is in source code (asm/barrier.h) where we check
for ARCv2 before PLAT_EZNPS, but it is better to avoid such combinations
at onset rather then baking subtle nuances into code.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/plat-eznps/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/plat-eznps/Kconfig b/arch/arc/plat-eznps/Kconfig
index ce908e2c5282..71378bfec8d0 100644
--- a/arch/arc/plat-eznps/Kconfig
+++ b/arch/arc/plat-eznps/Kconfig
@@ -6,6 +6,7 @@
 
 menuconfig ARC_PLAT_EZNPS
 	bool "\"EZchip\" ARC dev platform"
+	depends on ISA_ARCOMPACT
 	select CPU_BIG_ENDIAN
 	select CLKSRC_NPS if !PHYS_ADDR_T_64BIT
 	select EZNPS_GIC
-- 
2.25.1

