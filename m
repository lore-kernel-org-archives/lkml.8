Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71083C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407092080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/G4QQAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgFZLMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgFZLMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:12:35 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C44CC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sjRLUnZLZ94WrZSMgbRHd1Qq6wYAG49AAQb4wUyD0x4=; b=O/G4QQAvH1nMCTwQfU5lvlqtPc
        R/MLDTYUSQxqBTyuHZW5fURGBQ5va87u3TE11DMpJTr4FFWrHsLTu0LPgm/DBqD2rNK19Oa95ddd/
        vNq5qdyayL24vG0tX0lJgqs8h7pcQ0Op8wKqj6w7YnsxXyLtNsV1Aol2PKrBe37jD9jdne7cVNhGs
        d3f37cIajkh38FtEtTjlIQ4W9aL6Kkl0Vnhf3AhjIOCjMX5F77K+fkdLB+GmDbVi86vG63rdtsKNG
        DyWGl4OhjrubLY+4vChjASiFtfVw41bzN6SHVPShCzi/5aCzllofaiGU8rKGFwAHUsHG4YBd2s2QJ
        6PmoJa1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jomHC-0005DT-FL; Fri, 26 Jun 2020 11:12:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B13A9304B6D;
        Fri, 26 Jun 2020 13:12:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DCA729C9594E; Fri, 26 Jun 2020 13:12:08 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:12:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] init: Align init_task to avoid conflict with MUTEX_FLAGS
Message-ID: <20200626111208.GD4817@hirez.programming.kicks-ass.net>
References: <20200625204410.3168791-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625204410.3168791-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 05:44:09AM +0900, Stafford Horne wrote:
> When booting on 32-bit machines (seen on OpenRISC) I saw this warning
> with CONFIG_DEBUG_MUTEXES turned on.

> I traced this to kernel/locking/mutex.c storing 3 bits of MUTEX_FLAGS in
> the task_struct pointer (mutex.owner).  There is a comment saying that
> task_structs are always aligned to L1_CACHE_BYTES.  This is not true for
> the init_task.
> 
> On 64-bit machines this is not a problem because symbol addresses are
> naturally aligned to 64-bits providing 3 bits for MUTEX_FLAGS.  Howerver,
> for 32-bit machines the symbol address only has 2 bits available.
> 
> Fix this by setting init_task alignment to at least L1_CACHE_BYTES.

Whoopsie, sorry about that.

> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  init/init_task.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/init/init_task.c b/init/init_task.c
> index 15089d15010a..d2d2af018d0d 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -64,6 +64,8 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
>  struct task_struct init_task
>  #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
>  	__init_task_data
> +#else
> +	__aligned(L1_CACHE_BYTES)
>  #endif

Why make this conditional? task_struct_cachep (in kernel/fork.c) has
max_t(int, L1_CACHE_BYTES, ARCH_MIN_TASKALIGN) alignment, so this really
should be aligned on L1_CACHE_BYTES at least.
