Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9E3C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE6F20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ATRMXOAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGOXac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:30:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49845 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOXac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594855832; x=1626391832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmdUefgLBOB6PwU6TU8acnzTWIcf74JT8SNUiU8W9IE=;
  b=ATRMXOAeAiln3pzG+CY+W/5td8a72UDYPNVP7MLAuvE/JvEFI/id4KYe
   Wg7CyxEQfqqObNqKrH+l7YLh+F6nuGl1gA2VT2nybSn7Nvb6CRkgfMBB/
   1p9p5/BWyUjbObmaFfnw75spHIsP8my1o0ZOReWc0AmPy4aoLGRQ8QaqK
   p3pzAW3B1cAKpLZ5dDleVcbwt9TecTj4C1NyCkDxUlpu37Aoe1Oh173nm
   oCDKQsm/YBARsQm+6ABGiZApIPtRMlsfHhrxdfd9oruehfCx/eT5WKn/q
   07wNoPTDI8TtyF7NBouu4s2QOaVFrXnw57DC7hm/7lqco0FjdsG9uTL6N
   Q==;
IronPort-SDR: Al5FoC5l38LeI3obHrSE2PYozpY5SSKfxR9rSoUSn+H8eecJ1oPjU4pbUW4CCnNNL6h1+Tdedt
 e6ACjMWL5q7iV4DmjTqyBOYMNB9750iFDzARFdgKzBiiQJi7QOA+6dL7ctgdhZer0tC1kXqy2R
 UctXa2W4Gih5bDAGGCl69EnRfr24KxmpZr9zWJ5hcCtlIYqMymx1ZRlyoqsCU0NX8ZSnXTLz5l
 sClpUwtLY9wii94rss8Sfh3MTNXGjJOlNyQ1AkZk70BhxDEfm4t3YinVUohnJTtGvivZFd9MCE
 IZk=
X-IronPort-AV: E=Sophos;i="5.75,357,1589212800"; 
   d="scan'208";a="146868539"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 07:30:18 +0800
IronPort-SDR: lSE140Mb4DIIreAYyX0FS1Ra0A5gxp4kdic9JGfBwzSAAWyrU6yTqZLPWzF1W+oCD3vdiZk9I1
 m3m4450bFRTMHe9g2IBe+Dg0ej/rE8HGk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 16:18:42 -0700
IronPort-SDR: Q9PPzO3I5sP4soZoy+FP95bTTSmzWIFA2ZaPnmYDUwcXva5OXZSyHl61x14Sl0d10zsFYjODc0
 JfkewB3zndJg==
WDCIronportException: Internal
Received: from cnf009656.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.5])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 16:30:15 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/4] RISC-V: Setup exception vector early
Date:   Wed, 15 Jul 2020 16:30:06 -0700
Message-Id: <20200715233009.27183-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200715233009.27183-1-atish.patra@wdc.com>
References: <20200715233009.27183-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trap vector is set only in trap_init which may be too late in some
cases. Early ioremap/efi spits many warning messages which may be useful.

Setup the trap vector early so that any warning/bug can be handled before
generic code invokes trap_init.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/head.S    | 10 ++++++++--
 arch/riscv/kernel/smpboot.c |  1 -
 arch/riscv/kernel/traps.c   |  8 +-------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 7ed1b22950fd..d0c5c316e9bb 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -77,10 +77,16 @@ relocate:
 	csrw CSR_SATP, a0
 .align 2
 1:
-	/* Set trap vector to spin forever to help debug */
-	la a0, .Lsecondary_park
+	/* Set trap vector to exception handler */
+	la a0, handle_exception
 	csrw CSR_TVEC, a0
 
+	/*
+	 * Set sup0 scratch register to 0, indicating to exception vector that
+	 * we are presently executing in kernel.
+	 */
+	csrw CSR_SCRATCH, zero
+
 	/* Reload the global pointer */
 .option push
 .option norelax
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 4e9922790f6e..5a9c127a380e 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -154,7 +154,6 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
-	trap_init();
 	notify_cpu_starting(smp_processor_id());
 	update_siblings_masks(smp_processor_id());
 	set_cpu_online(smp_processor_id(), 1);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 7d95cce5e47c..ad14f4466d92 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -174,13 +174,7 @@ int is_valid_bugaddr(unsigned long pc)
 }
 #endif /* CONFIG_GENERIC_BUG */
 
+/* stvec & scratch is already set from head.S */
 void trap_init(void)
 {
-	/*
-	 * Set sup0 scratch register to 0, indicating to exception vector
-	 * that we are presently executing in the kernel
-	 */
-	csr_write(CSR_SCRATCH, 0);
-	/* Set the exception vector address */
-	csr_write(CSR_TVEC, &handle_exception);
 }
-- 
2.24.0

