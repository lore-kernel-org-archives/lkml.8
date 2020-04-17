Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F12FC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBA020B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGtWiYh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgDQV4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDQV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:56:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=35vQ9aG9jAJX5dHI+t+djpgDpVwXXiguJrlhJzWaW7c=; b=BGtWiYh0RS7ttpR4W03t1QeP99
        qbjQwmzdfQIJ8bHYM2mzvjtjypH+TLr0rppcWiJEJsGOudrXda5BSF3LL993XPI6h4JDk06nM/pqe
        tFjnFKck1c/5vw345vzsesdo7VacT2LUGt9nqz/gXP/Ejpi5DboMfsi2P8RJDkfBLRsdF9ne0vyNh
        J0pWHSN4bgiXIQ6Yxxj6gInU8xy8iIFEKCnVBPrxi4gvk1ccskebNgNXNX7FDvx1wZz25Z73Ek2nL
        xyffkQ9KLt5IDSZLZk0HgV8YLWXpCFTSeyq959CXt6V2ojRY2/acTjTRaLzT+xJhfiJzLOnRCEurf
        RQ+7fk0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPYxv-0001UZ-Rk; Fri, 17 Apr 2020 21:56:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 153689834C7; Fri, 17 Apr 2020 23:56:01 +0200 (CEST)
Date:   Fri, 17 Apr 2020 23:56:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>, Leo Li <sunpeng.li@amd.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harry Wentland <harry.wentland@amd.com>, mhiramat@kernel.org
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200417215601.GQ2483@worktop.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200409155956.GQ20760@hirez.programming.kicks-ass.net>
 <20200409170916.GR20760@hirez.programming.kicks-ass.net>
 <87a2f2fc-972d-ab9b-a29d-72f02d94e60e@amd.com>
 <20200409200125.GB2483@worktop.programming.kicks-ass.net>
 <20200417202728.w2v3frkxqsgutb7h@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417202728.w2v3frkxqsgutb7h@outlook.office365.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:27:28PM -0400, Rodrigo Siqueira wrote:
> I'm going to work on the FPU issues in the display code. In this sense,
> could you clarify a little bit more about the Makefile issues?

I think it might have been PEBKAC, I assumed allmodconfig would end up
selecting the driver, it doesn't!

Adding "AMD GPU" to a defconfig seems to make it work:

$ make O=defconfig-build/ drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o

Sorry about the confusion.

> Also, I applied the patch `[PATCH v4] x86: insn: Add insn_is_fpu()` and
> tried to reproduce the warning that you described but I didn't see it.
> Could you explain to me how I can check those warnings?

grab:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fpu

Then build like above:

$ make O=defconfig-build/ drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o

And manually validate:

$ defconfig-build/tools/objtool/objtool check -Ffa defconfig-build/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o
defconfig-build/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o: warning: objtool: dcn_validate_bandwidth()+0x1b17: FPU instruction outside of kernel_fpu_{begin,end}()


