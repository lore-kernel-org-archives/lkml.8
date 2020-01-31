Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D380C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14736215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ocNmgmBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgAaM4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgAaM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tQe5ZkmOJfFNHXR/r2H5EVWu98xBJw3hJYOCQreRxLE=; b=ocNmgmBOpYN35Mc8mLXROXdxo
        WBjIQAMyZtqZqd8y4pusoY3WUd7YnHZucy9eI0kQOTgeLHXGbbcnTnYjMnCHBJ7SOsZNLcsqLw4QT
        wIAE6VgD4buNEBhY/0MfWTr/Hpq+lN9nJgHMywwaXfu0fKcGHYcPe7jtwErNaQdVRZpDUqTLRsEdU
        GGJmgyLp3WAfwpoHouMQs4JFoLOTyptn8CK1Jf3rOpCmMliEdw0+1FK+BJpWlzhE9f185gp1tmgQH
        dk13A7/Ff5EFkNTnHMMn9FdqRO/Pqtr8qywACkwIyc/tCI4JgwxFtSDT8lfRfoKZZXy6jgOfF8CUI
        7WVm3OFWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq7-0003gH-P5; Fri, 31 Jan 2020 12:56:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34027300E0C;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DA4742B4C426D; Fri, 31 Jan 2020 13:56:00 +0100 (CET)
Message-Id: <20200131124531.623136425@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In order to faciliate Will's READ_ONCE() patches:

  https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org

we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
are tested using ARAnyM/68040.

Michael tested the previous version on his Atari Falcon/68030.

Build tested for sun3/coldfire.

Please consider!

Changes since -v1:
 - fixed sun3/coldfire build issues
 - unified motorola mmu page setup
 - added enum to table allocator
 - moved pointer table allocator to motorola.c
 - converted coldfire pgtable_t
 - fixed coldfire pgd_alloc
 - fixed coldfire nocache

---
 arch/m68k/include/asm/mcf_pgalloc.h      |  31 ++---
 arch/m68k/include/asm/motorola_pgalloc.h |  74 ++++------
 arch/m68k/include/asm/motorola_pgtable.h |  36 +++--
 arch/m68k/include/asm/page.h             |  16 ++-
 arch/m68k/include/asm/pgtable_mm.h       |  10 +-
 arch/m68k/mm/init.c                      |  34 +++--
 arch/m68k/mm/kmap.c                      |  36 +++--
 arch/m68k/mm/memory.c                    | 103 --------------
 arch/m68k/mm/motorola.c                  | 228 +++++++++++++++++++++++++------
 9 files changed, 302 insertions(+), 266 deletions(-)


