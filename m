Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AE0C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29726206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jdx2GA1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgEEGlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 02:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 02:41:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E4C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 23:41:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q124so582749pgq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0cSV3VIHWOti9hEY160GUxOocjb2RCw+0GAblBav28=;
        b=jdx2GA1koza677xbRvZximfAf3eGqC7089PhpVhfCaxhySIm3yOjCP9QXvpRhy04F3
         oG7tyrbqfcEr32erEqjE7Z4UoG3MR3xAF+S8B3PPxGYNWfOndefMsxQYIbPQX9dRyIgv
         xTCuzdHkr2Yr6X1CewqQeGNwmj+HA2xEB/y9O27sQZMIi80o6k0nPFd8qZ8Gc9PYMs4P
         sI2G9wE1tO6OMvUE4KxQtmYL0ACqocC8upwIDbEr6kqrIpiTV6gbqH1AQ3w/3UdZPwyX
         QFuBgyKLJgXrGF27aCnZHVzGUmPuIa717pzkI8uXOMGX5Q1D6/AnnEYexa0gavRMcLKM
         4iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0cSV3VIHWOti9hEY160GUxOocjb2RCw+0GAblBav28=;
        b=mIgv9cfvSp+AVYxkkeMgDGRTAOPv3EhyGRABJGvaSeuUAhx/r1R1zGgl5XxKMEucLB
         vNe2EeExf1NcK7psAiFOc/NVTtf1pVg3lm9PdyyQxuB67JGjgUuIfOC+luZLw7FD8avw
         0GqvM7r4Cj2fIW3TC/cjSXFDmmtG/jrGI5V5uLcau5GTncuyfxlcgycW+POU6jiDBZtW
         SMAWbo3YXZIMyvN4Hhd+cojoYk3V3P+0/Ccu++BGxFxj0wJv5ykvy138xNIanpxQVkAI
         bHCcF3RRdmwA62beZ8mlCnhnaVK8MQ/JpB3U7L/j7QOb0b5+H50kTQ3T+pkvtxucTEQV
         7D3A==
X-Gm-Message-State: AGi0Pub8WAfXUrjmLS4rFHocz6lqwqeKpCiWFz+ML9vOpNuYWQE+VOVH
        0LkHu4seVlBRGq8BBtt8REbNLA==
X-Google-Smtp-Source: APiQypKGKEIRzYStVQ9WNqw/QSkSxDNZxHPjYla+bZdF1kI2qQtde6vSpCmlnwhpGdMfNCdr9rBAlw==
X-Received: by 2002:a63:4f08:: with SMTP id d8mr1796556pgb.308.1588660878274;
        Mon, 04 May 2020 23:41:18 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t188sm822858pgc.3.2020.05.04.23.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 23:41:17 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        atishp@atishpatra.org, anup@brainfault.org, schwab@linux-m68k.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH v3] riscv: force __cpu_up_ variables to put in data section
Date:   Tue,  5 May 2020 14:41:13 +0800
Message-Id: <20200505064113.3455-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
Currently, these two variables are put in bss section, there is a
potential risk that secondary harts get the uninitialized value before
main hart finishing the bss clearing. In this case, all secondary
harts would pass the waiting loop and enable the MMU before main hart
set up the page table.

This issue happened on random booting of multiple harts, which means
it will manifest for BBL and OpenSBI which older than v0.6. In OpenSBI
v0.7 (or higher version), we have HSM extension so all the secondary
harts are brought-up by Linux kernel in an orderly fashion. This means
we don't need this change for OpenSBI v0.7 (or higher version).

Changes in v2 and v3:
  - Add commit description about random booting.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index c4c33bf02369..0ec22354018c 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -15,8 +15,8 @@
 
 const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
-void *__cpu_up_stack_pointer[NR_CPUS];
-void *__cpu_up_task_pointer[NR_CPUS];
+void *__cpu_up_stack_pointer[NR_CPUS] __section(.data);
+void *__cpu_up_task_pointer[NR_CPUS] __section(.data);
 
 extern const struct cpu_operations cpu_ops_sbi;
 extern const struct cpu_operations cpu_ops_spinwait;
-- 
2.26.1

