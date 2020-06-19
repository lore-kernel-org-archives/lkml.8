Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28972C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0A820786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580848;
	bh=52hVFjVhLh2OoAw3LAR/P2MpsdMw6E97K8yE7KBRUrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SkZraf0DzpIqDpcXIDD6cRMbnH29L+Tn03Y2l8cPdUsRnq8GYatoqm9WJyAAz8PR0
	 +AWfHgJTlZim3rtZdavCSVLxP0qqcq1h1l3qU3va4oncO0JcQrP1Z5d/YrBe8AxhAb
	 s/cOr7nhmlfBVtfAEpUbUaD1Ms+fYWe4oHy4KKkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404916AbgFSPeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404763AbgFSPdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:33:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A817C20786;
        Fri, 19 Jun 2020 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580779;
        bh=52hVFjVhLh2OoAw3LAR/P2MpsdMw6E97K8yE7KBRUrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7cwfrHukGXiS+VpD0wZRwG1g+KlR3uxu44kAeKQF8rFpOf31qI0eitsG+yA1UV6v
         1AHqy3t7Wpigngwh5hfVE/etWTZNBxUqpFbilYKeil8d9zFJUwgvflTFWV7wbEpurr
         DKRR/AC4aPgI+DzEfR+LUtowMJdaR8XNyisYl1Lw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Zong Li <zong.li@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 5.7 349/376] RISC-V: Dont mark init section as non-executable
Date:   Fri, 19 Jun 2020 16:34:27 +0200
Message-Id: <20200619141726.847148265@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

commit 4e0f9e3a6104261f25b16fcab02fc96f5666ba11 upstream.

The head text section (i.e. _start, secondary_start_sbi, etc) and the
init section fall under same page table level-1 mapping.

Currently, the runtime CPU hotplug is broken because we are marking
init section as non-executable which in-turn marks head text section
as non-executable.

Further investigating other architectures, it seems marking the init
section as non-executable is redundant because the init section pages
are anyway poisoned and freed.

To fix broken runtime CPU hotplug, we simply remove the code marking
the init section as non-executable.

Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/mm/init.c |   11 -----------
 1 file changed, 11 deletions(-)

--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -479,17 +479,6 @@ static void __init setup_vm_final(void)
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
 }
-
-void free_initmem(void)
-{
-	unsigned long init_begin = (unsigned long)__init_begin;
-	unsigned long init_end = (unsigned long)__init_end;
-
-	/* Make the region as non-execuatble. */
-	set_memory_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
-	free_initmem_default(POISON_FREE_INITMEM);
-}
-
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {


