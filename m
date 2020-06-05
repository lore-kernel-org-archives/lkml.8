Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B12EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421A9206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591344704;
	bh=zrr154I6+z9qrSobHKylWGNpO1NGopM9NeVcpUZlx1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rkkxagnQhjNiTwe0RJDE4SC/a/mxVPbog/LeeKrqhF4pL7HlBQnafM+jWtOJgfWK7
	 opCu33uNqFlsYGjHwvSrE2QTOu80D4XotHE7UdTOs4+3W8D+VuSWBnnMunBRj95GTU
	 SPG+DV/0asjeIGu3SKUq2IW2LLD4YSbnVelCdbik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgFEILn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgFEILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:11:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB03C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 01:11:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so8519508wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=htoDmdMBIui/pVbxzVjgDJM+XC/4r/VbCpbuP9UPRhg=;
        b=Dy+81hWUouFmyd+GaN18KYZ/Ud1bJj5U9apjtg8I8F+XAgDZ24bM/v107mhrf8SZAK
         l7FK6kgqsT7toUBKQiISSB5F6HUjPGC4egIyXSbSrK96rgNMDMr/g4BCcyZqbhTx8V3/
         RVk7B8qY3dBQ937IzmpeXCgQIlWitgYCLK1c/S0ReynxUVT9EShVLrMh5K/2Mtjii3H6
         M5zpSrtSU3APVm43VjJZL6/f76blYN1SvBtpevc4+QqizccVSL+DD/NCPYqt1s1bMeRb
         gFZSSShrADH53guAAFnCxFjQaNq9Kz5/inqcKECe7RcILMXy/KdFaL979SuA0NBIAOXx
         jsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=htoDmdMBIui/pVbxzVjgDJM+XC/4r/VbCpbuP9UPRhg=;
        b=IZCvCXcWyKPIYSJUDiGmg0eOoUznD98uZcVy5s+paz3JoW2zB+ykG65P2VCs5e3hzN
         z7eAZlOh67c2gk8LZ89QtONqNUJNb14zlb36n8Mm8pbakpL0eNj27h7X0lx49PZb5Snb
         2GufpOmKB06G8DICcM1duJhKpNjfQrAjVJCMRg2LfQd9g0CMRI2qOd2okFs/t+jyM+Fc
         GKsNjKp1ZYMk2iYy13IJUep7XVSPICpvc1sMOfPh+q2hV4B1WgFZbV2YOpvUmkzvqXgO
         ThojLvgWaFDKa2UHCtpeRedSaDxQpJyZru2GX58rtNtofU3m1o75/j/+B+4pfXi4IwqY
         NI1Q==
X-Gm-Message-State: AOAM533shBDftY1yn014XoAkeoSDqEEjgCw9cOzagklYXSIA8m57KqLJ
        DgL21yqGK1iH5Uv+j1K69Qo=
X-Google-Smtp-Source: ABdhPJziVB4mVbrIgoi6KkBYECZnCBdtxrIC6FnZb6k94fOApGc3ojONJZzMeBv4x+G1tQLilIz6sQ==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr1538409wmi.185.1591344700985;
        Fri, 05 Jun 2020 01:11:40 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w17sm11314624wra.71.2020.06.05.01.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 01:11:39 -0700 (PDT)
Date:   Fri, 5 Jun 2020 10:11:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <sblbir@amazon.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Subject: [GIT PULL v3] x86/mm changes for v5.8
Message-ID: <20200605081137.GA2231266@gmail.com>
References: <20200601170102.GA1346815@gmail.com>
 <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
 <20200602073350.GA481221@gmail.com>
 <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
 <871rmxgw4d.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
 <20200604172904.GA1751362@gmail.com>
 <CAHk-=whK846PwG_qNqyb-q-BSPALb=xZ9k6ThVjRm8u=vCpkqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whK846PwG_qNqyb-q-BSPALb=xZ9k6ThVjRm8u=vCpkqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jun 4, 2020 at 10:29 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Yeah, sure - here's the updated pull request for the rest:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-06-04
> >
> >    # HEAD: bd1de2a7aace4d1d312fb1be264b8fafdb706208 x86/tlb/uv: Add a forward declaration for struct flush_tlb_info
> 
> Nope, that still points to
> 
>  0fcfdf55db9e1ecf85edd6aa8d0bc78a448cb96a Documentation: Add L1D
> flushing Documentation
> 
> although it looks like the 'x86/mm' _branch_ does point to that commit
> bd1de2a7aace.
> 
> You did something odd where you created a new tag, but used the old branch. Hmm?

Oops, my apologies, indeed I did something odd with tags: my testing 
script used a x86-mm-for-linus temporary branch to construct the tag 
and test the tree, and merged x86/mm into it - but this branch was 
still a leftover from the previous pull request and the merge of 
x86/mm into it succeeded without an error ...

In a comedy of errors, while it used the out of date x86-mm-for-linus 
to generate the tag, it consistently used the correct x86/mm branch 
for the pull request itself, and thus my fail-safes to catch such 
mishaps of sending the wrong tree to you all failed. :-/

I fixed my tag workflow, re-tested this case (and a few others) to 
make sure it doesn't happen again, and find below the updated v3 pull 
request. Sorry about this!

---
Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-06-05

   # HEAD: bd1de2a7aace4d1d312fb1be264b8fafdb706208 x86/tlb/uv: Add a forward declaration for struct flush_tlb_info

Misc changes:

 - Unexport various PAT primitives

 - Unexport per-CPU tlbstate

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/tlb/uv: Add a forward declaration for struct flush_tlb_info

Christoph Hellwig (5):
      x86/mm: Add a x86_has_pat_wp() helper
      x86/mm: Move pgprot2cachemode out of line
      x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()
      x86/mm: Unexport __cachemode2pte_tbl
      x86/mm: Use pgprotval_t in protval_4k_2_large() and protval_large_2_4k()

Thomas Gleixner (17):
      x86/tlb: Uninline __get_current_cr3_fast()
      x86/cpu: Uninline CR4 accessors
      x86/cr4: Sanitize CR4.PCE update
      x86/alternatives: Move temporary_mm helpers into C
      x86/tlb: Move __flush_tlb() out of line
      x86/tlb: Move __flush_tlb_global() out of line
      x86/tlb: Move __flush_tlb_one_user() out of line
      x86/tlb: Move __flush_tlb_one_kernel() out of line
      x86/tlb: Move flush_tlb_others() out of line
      x86/tlb: Move __flush_tlb_all() out of line
      x86/tlb: Move paravirt_tlb_remove_table() to the usage site
      x86/tlb: Move cr4_set_bits_and_update_boot() to the usage site
      x86/tlb: Uninline nmi_uaccess_okay()
      x86/tlb: Move PCID helpers where they are used
      xen/privcmd: Remove unneeded asm/tlb.h include
      x86/tlb: Restrict access to tlbstate
      x86/cpu: Export native_write_cr4() only when CONFIG_LKTDM=m


 arch/x86/events/core.c               |  11 +-
 arch/x86/include/asm/memtype.h       |   3 +
 arch/x86/include/asm/mmu_context.h   |  88 +------
 arch/x86/include/asm/paravirt.h      |  12 +-
 arch/x86/include/asm/pgtable_32.h    |   2 +-
 arch/x86/include/asm/pgtable_types.h |  44 +---
 arch/x86/include/asm/tlbflush.h      | 441 ++++-------------------------------
 arch/x86/include/asm/uv/uv.h         |   1 +
 arch/x86/kernel/alternative.c        |  55 +++++
 arch/x86/kernel/cpu/common.c         |  25 +-
 arch/x86/kernel/cpu/mtrr/generic.c   |   4 +-
 arch/x86/kernel/paravirt.c           |  21 +-
 arch/x86/kernel/process.c            |  11 +
 arch/x86/mm/init.c                   |  44 +++-
 arch/x86/mm/init_64.c                |   4 +-
 arch/x86/mm/ioremap.c                |  10 +-
 arch/x86/mm/kmmio.c                  |   2 +-
 arch/x86/mm/mem_encrypt.c            |   2 +-
 arch/x86/mm/pat/set_memory.c         |   7 +-
 arch/x86/mm/pgtable.c                |  16 +-
 arch/x86/mm/pgtable_32.c             |   2 +-
 arch/x86/mm/tlb.c                    | 384 +++++++++++++++++++++++++++++-
 arch/x86/platform/uv/tlb_uv.c        |   4 +-
 drivers/xen/privcmd.c                |   1 -
 24 files changed, 608 insertions(+), 586 deletions(-)
