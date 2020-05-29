Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7884C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE1B20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OrNBw3Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgE2Vnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE2Vnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:43:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462D6C03E969;
        Fri, 29 May 2020 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5rR1NJgZkMSAM5DsE3mS2iF8blmza8kjDJ/kqIILuBo=; b=OrNBw3CuPy/zbnEZhshCKupz6A
        +zs4nSTw1Z5AmszLAASctKMALY+PXzHrBk5nQAPaC8HiehcIrV4kcF7bT3585u1Nv3eLN3qaxXXEB
        EuYeZguCbqbpq6Y8iK6jZvEWcfmk8T+rha8XDekQDos53rT0xYsnWXQ4EI5Nk31uDDnH41aU0pt2D
        ojNvDIxKvWCZyoAFEQKn6wtPsyMhLLo9pRXW7rX7G6OyG4vNtpdZ8bJxaboaQtQ0VySSf975xoD4A
        BXBZU/dwPH3vlNZhl3sp1KmuTnR1sLFfAA8Sib3wgOyplwM8EWkEU/zdMQyqoYBik6W9eDTiYI4a0
        igmT94JQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemmK-0006Hs-1t; Fri, 29 May 2020 21:43:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23EFB302814;
        Fri, 29 May 2020 23:42:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CE78E2021AF90; Fri, 29 May 2020 23:42:57 +0200 (CEST)
Message-ID: <20200529214203.673108357@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:35:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [RFC][PATCH v3 1/5] sparc64: Fix asm/percpu.h build error
References: <20200529213550.683440625@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to break a header dependency between lockdep and task_struct,
I need per-cpu stuff from lockdep.

Including <asm/percpu.h> from lockdep.h gives a build error, this
patch cures that, but results in the following warning:

../arch/sparc/include/asm/percpu_64.h:7:24: warning: call-clobbered register used for global register variable
register unsigned long __local_per_cpu_offset asm("g5");

But i've no idea how to fix that :/ but it does build.

Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/include/asm/trap_block.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_TRAP_BLOCK_H
 #define _SPARC_TRAP_BLOCK_H
 
+#include <linux/threads.h>
+
 #include <asm/hypervisor.h>
 #include <asm/asi.h>
 


