Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C542C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F13720714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgBJNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:33 -0500
Received: from foss.arm.com ([217.140.110.172]:60762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbgBJNA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:00:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 036711FB;
        Mon, 10 Feb 2020 05:00:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D49B93F68E;
        Mon, 10 Feb 2020 05:00:26 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        richard.henderson@linaro.org, tytso@mit.edu, will@kernel.org
Subject: [PATCH 4/4] random: Make RANDOM_TRUST_CPU depend on ARCH_RANDOM
Date:   Mon, 10 Feb 2020 13:00:15 +0000
Message-Id: <20200210130015.17664-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200210130015.17664-1-mark.rutland@arm.com>
References: <20200210130015.17664-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Henderson <richard.henderson@linaro.org>

Listing the set of host architectures does not scale.
Depend instead on the existence of the architecture rng.

This will allow RANDOM_TRUST_CPU to be selected on arm64. Today
ARCH_RANDOM is only selected by x86, s390, and powerpc, so this does not
adversely affect other architectures.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/char/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 26956c006987..84207d5a9bb0 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -539,7 +539,7 @@ endmenu
 
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
-	depends on X86 || S390 || PPC
+	depends on ARCH_RANDOM
 	default n
 	help
 	Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
-- 
2.11.0

