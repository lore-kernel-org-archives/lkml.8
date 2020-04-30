Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706BC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D740D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FNsMRJvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3Jxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgD3Jxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:53:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971FBC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:53:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so2638927pfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5b3mMRHvXQbzHGW+qWobb2z60I2edTthB81/8CnRyTY=;
        b=FNsMRJvctW/IDfTOYQj2ig1bKzEgCq7adVIiDRyxR3g9R6bKngVEVS6C4dsVXlmUIg
         vUmXjcffoR5a+SZZWsGwH/bi3hYBRz1qQI3C9LY988QEnkjCbK98ITHxeJLIjRcpaBu/
         mu9lyGOJCdAeYwDU/4zKkaJYYUxOuwwbfBtiFCD7LQxknApn/q1i44jO94/jCmqqmbFQ
         K2TOCuc83POJeLBBim07HMywiC7a7TBFmA5jUA3uDKs1gtLg7mJn9HTvLW0yjBiYlZPw
         vpg+Xvp2TdcKwtNzuVHzn40qfbVA+rnkS2dbDde5IMcGLMda4HBVgqOP/6/NLORzNAd/
         qQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5b3mMRHvXQbzHGW+qWobb2z60I2edTthB81/8CnRyTY=;
        b=qM0TIilO6/7cvoVN4bfWTJJSdtlM6x/DMLv2WOZmz6CJZRKZYi50TvZ6XBMp8t3BgL
         ECZqRNdia/+ELMpcMdfx6d932ySS3pyGItZ5zDrddxD1VEK+jRB21JjwvbbrEHqHcscl
         jSYghltBe3qjuly/5s6W6zdVMQk6XPgxt6EA3ZGT5Xgu39ozTWqxKYx79SBym1F4lght
         ySlXrKhnPPSxTxe3zkPG/LaoWy1CiHizaMS76sctOUntlX8j8tZlUYFlwyMAQXOMD425
         KcUPRGolYr/eJdk2eaA1VmuW2jY5xlgMqdzKgJ8h6JXy53sN8kK8uZMQoEl5B2oOisLD
         wIgQ==
X-Gm-Message-State: AGi0PubaoDf3juiSJLsudZ26qQWSO3aVDcVRZCAXK+8tiCoK5mMwQudt
        4P3TQiTzseJGlbstfGVXAMFulA==
X-Google-Smtp-Source: APiQypIkjbayVsvLjWrGFWYn1ptLAshEvqSgyGsXfTy7kGchV4xlRb/GFZHnzZrdW8ybBdTQ56nSaQ==
X-Received: by 2002:aa7:9683:: with SMTP id f3mr2825239pfk.278.1588240409127;
        Thu, 30 Apr 2020 02:53:29 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t23sm1367108pji.32.2020.04.30.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:53:28 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: force __cpu_up_ variables to put in data section
Date:   Thu, 30 Apr 2020 17:53:25 +0800
Message-Id: <20200430095325.111441-1-zong.li@sifive.com>
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
harts would go through the waiting loop and enable the MMU before
main hart set up the page table.

Signed-off-by: Zong Li <zong.li@sifive.com>
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

