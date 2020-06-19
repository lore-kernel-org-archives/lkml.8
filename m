Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69637C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373D52184D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579854;
	bh=wYOBonMFOcw+NCR1S5pFDveiILnmyP7Jt2GUW7nzcvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2GX5de+AfEYqKJ5lHDYA5iO4G65sGR5VThB3tLz+XIanmeosJBcWmEnFFgo+06ZeO
	 MM5TgxDQ6dMyYi7++Xx55kwqo5SPrKe+H2wIc3uPOFiKxz6/Ar/1NSFN5XVxEEO3Xs
	 V/srtg7+Qcm6U4DC53bChG058BVFeVl6SLKgg1Zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392495AbgFSPRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404173AbgFSPRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86DD92158C;
        Fri, 19 Jun 2020 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579839;
        bh=wYOBonMFOcw+NCR1S5pFDveiILnmyP7Jt2GUW7nzcvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hr7u8FjGYDkOOe+jGYLafKA6jts94wSGllJaOz9eYaajhtOdd0nXotdy7mNWWmcXX
         y+DFenJqxuXH0nvS/Wx8/xbzt28/2jebOOw4gOzihdmb8wVueXXJCg+VKbeSbYTCpN
         xmsBlUQ5wVChtNnmjTa0vo2AXu9OA7AoHW/csHFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 024/376] x86,smap: Fix smap_{save,restore}() alternatives
Date:   Fri, 19 Jun 2020 16:29:02 +0200
Message-Id: <20200619141711.506266278@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 1ff865e343c2b59469d7e41d370a980a3f972c71 ]

As reported by objtool:

  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x0: alternative modifies stack
  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x7: alternative modifies stack

the smap_{save,restore}() alternatives violate (the newly enforced)
rule on stack invariance. That is, due to there only being a single
ORC table it must be valid to any alternative. These alternatives
violate this with the direct result that unwinds will not be correct
when it hits between the PUSH and POP instructions.

Rewrite the functions to only have a conditional jump.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200429101802.GI13592@hirez.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/smap.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 27c47d183f4b..8b58d6975d5d 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -57,8 +57,10 @@ static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
 
-	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
-				  X86_FEATURE_SMAP)
+	asm volatile ("# smap_save\n\t"
+		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
+		      "pushf; pop %0; " __ASM_CLAC "\n\t"
+		      "1:"
 		      : "=rm" (flags) : : "memory", "cc");
 
 	return flags;
@@ -66,7 +68,10 @@ static __always_inline unsigned long smap_save(void)
 
 static __always_inline void smap_restore(unsigned long flags)
 {
-	asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
+	asm volatile ("# smap_restore\n\t"
+		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
+		      "push %0; popf\n\t"
+		      "1:"
 		      : : "g" (flags) : "memory", "cc");
 }
 
-- 
2.25.1



