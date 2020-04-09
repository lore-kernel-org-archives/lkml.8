Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75024C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF5320692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586414672;
	bh=PfUikIBTXspGc+39UOUujO6Ld9bq2yeVd1JILOFiYkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZJvrt8EMwbukTaF9SPB1nnfaiW3m8NRUGq06Kv1s2Yfarm6AjvVpEDEiP1Q3HZZOK
	 QhBLbKVmaHoyjjYol3LMHhq3cFUkD85IlRPEcX7R3jcIkwXHwj2RTgE4JWwN+j7ZZK
	 lU/JukQ/Rqtpyj9nFIAOkJ+wD6exfIzThN4XX6YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDIGoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgDIGoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:44:22 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD4620BED;
        Thu,  9 Apr 2020 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586414662;
        bh=PfUikIBTXspGc+39UOUujO6Ld9bq2yeVd1JILOFiYkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZetZ7gnfpkdwUseH1r6bxNNA1el+rz7oYz4LyevmNTO9t3OPj+7t2uJiVVGepT7X7
         YDdST0PO679vPjqL2Ply5/38kf/3L517WUPEpPrSx4NmTzYyn1ubV91mZZRo+q393D
         jjETfRsJm0zkR7or/H93LlOWljQK7OAlOUs1M/6k=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 10/10] clk: Move HAVE_CLK config out of architecture layer
Date:   Wed,  8 Apr 2020 23:44:16 -0700
Message-Id: <20200409064416.83340-11-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200409064416.83340-1-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of 'struct clk' is not really an architectual detail
anymore now that most architectures have migrated to the common clk
framework. To sway new architecture ports away from trying to implement
their own 'struct clk', move the config next to the common clk framework
config.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/Kconfig        | 6 ------
 drivers/clk/Kconfig | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 17fe351cdde0..903ac5547ee8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -321,12 +321,6 @@ config HAVE_FUNCTION_ARG_ACCESS_API
 	  the API needed to access function arguments from pt_regs,
 	  declared in asm/ptrace.h
 
-config HAVE_CLK
-	bool
-	help
-	  The <linux/clk.h> calls support software clock gating and
-	  thus are a key power management tool on many systems.
-
 config HAVE_HW_BREAKPOINT
 	bool
 	depends on PERF_EVENTS
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 890bed62196d..6ea0631e3956 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -1,5 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
+config HAVE_CLK
+	bool
+	help
+	  The <linux/clk.h> calls support software clock gating and
+	  thus are a key power management tool on many systems.
+
 config CLKDEV_LOOKUP
 	bool
 	select HAVE_CLK
-- 
Sent by a computer, using git, on the internet

