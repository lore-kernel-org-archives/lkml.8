Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A124C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C30D204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHMDki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:40:38 -0400
Received: from lonlinode-sdnproxy-1.icoremail.net ([139.162.193.133]:24264
        "HELO lonlinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726078AbgHMDkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:40:37 -0400
Received: from localhost.localdomain (unknown [175.0.107.229])
        by c1app11 (Coremail) with SMTP id CwINCgBHjHwUtjRffJ0gAw--.51036S2;
        Thu, 13 Aug 2020 11:40:06 +0800 (CST)
From:   Qiu Wenbo <qiuwenbo@phytium.com.cn>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Cc:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: Setup exception vector for nommu platform
Date:   Thu, 13 Aug 2020 11:38:04 +0800
Message-Id: <20200813033807.19556-1-qiuwenbo@phytium.com.cn>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: CwINCgBHjHwUtjRffJ0gAw--.51036S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww15XFWDKr13CF17GrWrGrg_yoW8Aw1rp3
        y7Cw1YyrW8Ka1xZr9xtwnY9rW3ArZ7Gw13Gr4kJayrGr95Kr98Xrn2q3srXFWUWF4Syr48
        Zw4IvryF9w1UA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JU-miiUUUUU=
X-Originating-IP: [175.0.107.229]
X-CM-SenderInfo: 5tlx4vhqerq15k1wx33pof0zgofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exception vector is missing on nommu platform and that is an issue.
This patch is tested in Sipeed Maix Bit Dev Board.

Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
Suggested-by: Anup Patel <anup@brainfault.org>
Suggested-by: Atish Patra <atishp@atishpatra.org>
Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
---
 arch/riscv/kernel/head.S | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index d0c5c316e9bb..0a4e81b8dc79 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -77,16 +77,10 @@ relocate:
 	csrw CSR_SATP, a0
 .align 2
 1:
-	/* Set trap vector to exception handler */
-	la a0, handle_exception
+	/* Set trap vector to spin forever to help debug */
+	la a0, .Lsecondary_park
 	csrw CSR_TVEC, a0
 
-	/*
-	 * Set sup0 scratch register to 0, indicating to exception vector that
-	 * we are presently executing in kernel.
-	 */
-	csrw CSR_SCRATCH, zero
-
 	/* Reload the global pointer */
 .option push
 .option norelax
@@ -144,9 +138,23 @@ secondary_start_common:
 	la a0, swapper_pg_dir
 	call relocate
 #endif
+	call setup_trap_vector
 	tail smp_callin
 #endif /* CONFIG_SMP */
 
+.align 2
+setup_trap_vector:
+	/* Set trap vector to exception handler */
+	la a0, handle_exception
+	csrw CSR_TVEC, a0
+
+	/*
+	 * Set sup0 scratch register to 0, indicating to exception vector that
+	 * we are presently executing in kernel.
+	 */
+	csrw CSR_SCRATCH, zero
+	ret
+
 .Lsecondary_park:
 	/* We lack SMP support or have too many harts, so park this hart */
 	wfi
@@ -240,6 +248,7 @@ clear_bss_done:
 	call relocate
 #endif /* CONFIG_MMU */
 
+	call setup_trap_vector
 	/* Restore C environment */
 	la tp, init_task
 	sw zero, TASK_TI_CPU(tp)
-- 
2.28.0

