Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E859C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615132087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596244487;
	bh=j0J/7ja9WKirDvkyCZhO+IkvePr5ZhC8vW7o8X/Z79Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XZz8bNMaiEjbYjj5KZjt4I9AGexhZqZkURN2s8kdmLp5/lSgGDULz6ZC+n8CLnBGA
	 6faNtpvK0+ucKmMFeBYAQaooXNj4lWCDBpfsY9nEPhg66vqoOUpXkYBd8NlGGPHULK
	 2yfL+AGtBXp28lGCWVFcMkQd6zn42yBP6DnwdoOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHABOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgHABOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:43 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5717020836;
        Sat,  1 Aug 2020 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244483;
        bh=j0J/7ja9WKirDvkyCZhO+IkvePr5ZhC8vW7o8X/Z79Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kt+tmwIcuYE7tpUt9GeGeGveSU9iDm7kG4bzlkXSgx4xvJi3dj+cCnwxXUCt8Fiwn
         GCohKZwTWXb+WqDB6nNIsVxPs/r2N4Ar9sI4uGA177oXTI7PvemhnaEY91iGLkMbZ+
         srr88712l+re/AK/wWYOtDSpePCHpPZVo2OrDuNQ=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 03/13] csky: Add cpu feature register hint for smp
Date:   Sat,  1 Aug 2020 01:14:03 +0000
Message-Id: <1596244453-98575-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

CPU features registers are setup by customers' bootloader, but
Linux must help transfer them from the primary to secondary cores.
This patch add hint2 CPU feature register supported.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b5c5bc3..1945fb2 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -156,6 +156,7 @@ void __init setup_smp(void)
 extern void _start_smp_secondary(void);
 
 volatile unsigned int secondary_hint;
+volatile unsigned int secondary_hint2;
 volatile unsigned int secondary_ccr;
 volatile unsigned int secondary_stack;
 
@@ -168,6 +169,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	secondary_stack =
 		(unsigned int) task_stack_page(tidle) + THREAD_SIZE - 8;
 	secondary_hint = mfcr("cr31");
+	secondary_hint2 = mfcr("cr<21, 1>");
 	secondary_ccr  = mfcr("cr18");
 	secondary_msa1 = read_mmu_msa1();
 
@@ -209,6 +211,7 @@ void csky_start_secondary(void)
 	unsigned int cpu = smp_processor_id();
 
 	mtcr("cr31", secondary_hint);
+	mtcr("cr<21, 1>", secondary_hint2);
 	mtcr("cr18", secondary_ccr);
 
 	mtcr("vbr", vec_base);
-- 
2.7.4

