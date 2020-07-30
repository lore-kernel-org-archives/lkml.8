Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B7F2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MtDwwZN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgG3AZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:25:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33201 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgG3AZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596068739; x=1627604739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eZTfMgiK2vEeMZsD5lwwoP2zVvgB9NQ0c2HdLF8qwXA=;
  b=MtDwwZN6u54Yd6TZyAesj3nKzWmd37fDiXby6gvMrCxmFZOECwB/s1Tj
   qeBiGwxRyPSY/fWXgy2wt5u5pZHQo80OfWiubuQNoniZjvU5efEXJlclZ
   Yg6eruHy6NRmMqRAYXbuL/gAd1vR0a1ZtjdmSea6z5TACi6QO745s7Ucj
   eVkQhzqXnBy8DLjtMCDwCwJTYCQHKo2JZwAKcg8a7Iye/6ADpNfFdI77d
   8bzmzb+WlmtFD5USejezAEk1DTZNyN97Qfy7bObAjh1fmUdcRctKPEpBq
   GHZtvwtJuqA9MzV0r9Ug3KXxhe4l5fEW2yXkBaysKA405gWyCpOZUEJ1Y
   w==;
IronPort-SDR: LRjIRlPiDUXVZavr6SS0YbT2Ll9/TQnMq2TSZoWyndF1OV/qX2DDDl1sh29PCRZ6WW082HMBjg
 Kz4QkkhHoYBPTdJqnRuvu7Zdd0mokur51okc8K4HWp+04jYzFaQSVPshkN990Jb8CivUOd/D1e
 eZRSxUOaHHyFUh1ql+NxkQvyjQgrPWx4kpUFgyY2kZdZPsUlan56sGIx32LWtDYfmwLxiqzPYS
 BMxr41pEvhaCOaIVX3HGRFl+Rn0CxpPhPb59M3ODYE6k3ddmXOtQgHibBCci1Hl8+PyX7ExgbQ
 Ues=
X-IronPort-AV: E=Sophos;i="5.75,412,1589212800"; 
   d="scan'208";a="253040609"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 08:25:39 +0800
IronPort-SDR: 2kmw3pgLDyOZaUJhD5yBfLPod9DCOGcdEkWCNZW0yk7HkEI95YNdJKr9fJ/kNEpNxJYAKM/QDy
 HphhY6hBr3OnXyxP67dCiPPn5teYb+qm4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 17:13:09 -0700
IronPort-SDR: 6UJWOZcUcSr7TfQqXrqD26zZiC1kzKQxJVo8FI0jW1AO2FT4vnNLnamB+KCsFFg/X6LmkZwDOT
 CyVema/uVjpw==
WDCIronportException: Internal
Received: from jpf009043.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.210])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jul 2020 17:25:40 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] RISC-V: Fix build warning for smpboot.c
Date:   Wed, 29 Jul 2020 17:25:35 -0700
Message-Id: <20200730002535.17335-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warnings are reported by kbuild with W=1.

>> arch/riscv/kernel/smpboot.c:109:5: warning: no previous prototype for
'start_secondary_cpu' [-Wmissing-prototypes]
     109 | int start_secondary_cpu(int cpu, struct task_struct *tidle)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/smpboot.c:146:34: warning: no previous prototype for
'smp_callin' [-Wmissing-prototypes]
     146 | asmlinkage __visible void __init smp_callin(void)
         |                                  ^~~~~~~~~~

Fix the warnings by marking the local functions static and adding the prototype
for the global function.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/smp.h | 3 +++
 arch/riscv/kernel/smpboot.c  | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 40bb1c15a731..6dfd2a1446d5 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -40,6 +40,9 @@ void arch_send_call_function_single_ipi(int cpu);
 int riscv_hartid_to_cpuid(int hartid);
 void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
+/* Secondary hart entry */
+asmlinkage void smp_callin(void);
+
 /*
  * Obtains the hart ID of the currently executing task.  This relies on
  * THREAD_INFO_IN_TASK, but we define that unconditionally.
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 4e9922790f6e..c09fbdf924b1 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -106,7 +106,7 @@ void __init setup_smp(void)
 	}
 }
 
-int start_secondary_cpu(int cpu, struct task_struct *tidle)
+static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 {
 	if (cpu_ops[cpu]->cpu_start)
 		return cpu_ops[cpu]->cpu_start(cpu, tidle);
-- 
2.24.0

