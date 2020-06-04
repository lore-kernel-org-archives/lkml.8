Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA55C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A2C20823
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591291749;
	bh=+tIfTN4AKbjFZiU266XMpsou10nk9aL5/QlfpPvbmoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pjDMmKQhNCjLS9v1R3XFQrog+NcdZxatnyYidnjuP9Rhcmyc0N3P+uF1AeB3I73TC
	 UrQwacC5LAap/jAQs5jcrPGgdY2BcZkzbtRDtfCcvulPpKlaKlqHboFiy5Ev2JkRKU
	 9TeiZl7VTadqZu5KJCrQ6Ro4dnYUNwtfaZMC6s+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgFDR3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbgFDR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:29:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65651C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:29:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y17so6993971wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XK4XxAyMrFE61yTwuBKcQu3plYybeTKw9SSA51UCKoI=;
        b=YRJON5ilF22hJlC8STJPAfiAB7E4EyyhFD3WDTs9SaogE6fbJMSAwhtV0TgaZMk0rF
         xC3u5jbY6/bQXgPkoEeebnLdEjIEVfSYGs7OwJY17C25J44LKn2J99v0IHuGilKVSU32
         wanUiczz0YHs5bEVNL9vzSPM7qXGuPJI0ejatfMhehh1TgOX14NB//0b+fBgwgPZCmrz
         WmErX8ace7xACzVMC3735QnMWp8mqyNBz/KmL8GKb0QnY7Aw7czeIy5ouamzFr1EpLpQ
         YO4TGPaAeAOSuxmsduyVdnk6FPkMZGhambVZgRke/viKsP5TaSbH2ZiKylahjVHdfDdL
         55zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XK4XxAyMrFE61yTwuBKcQu3plYybeTKw9SSA51UCKoI=;
        b=JD/i5LYfx53BwpFhwEh3UDt98tmEiCmA+ZrdBYtpYsRSRJc51tgwC9Q6p7G9uj4K1k
         rPo65LmES5NYhiqiozzdqTYK32o41KY2/1d4rp3/0veyp2SCNKZaXe8en+YMIkgrkdXl
         9IH2y+Qkh3aspOsdUAA58GcB75OX6ksm+XkDRpRGkZJQjp4OIaKk5dum1JbxFeqJOs7o
         U6u7K1V87W+ZxCVWILWoS4KRvOG+gHF7uqsjvfCS18tg+8g1boJ2jdGFqHrAMofqrJ9K
         rbm59pi3deYMe+o+v1TCi8XKALmVck+Xn/4MnGEpgnyAQOCmX19mNe54dghdH7hZKT9t
         Cyew==
X-Gm-Message-State: AOAM532vbmuX17rMMp5ePlF1yk330Q8bFdz45jOnxJtDrJ0vWu4ZfyqW
        ObHpHK3YE0sc39TuXCuuQN8=
X-Google-Smtp-Source: ABdhPJxzvGnibUcN1GZJhYZ5OjbaFBgU/LiZ8vbiC1amonXH0QBivpl99JmoqcAoEHFr4gQdqmg8pg==
X-Received: by 2002:a5d:6581:: with SMTP id q1mr5286724wru.43.1591291747104;
        Thu, 04 Jun 2020 10:29:07 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r2sm9485950wrg.68.2020.06.04.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:29:06 -0700 (PDT)
Date:   Thu, 4 Jun 2020 19:29:04 +0200
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
Subject: [GIT PULL v2] x86/mm changes for v5.8
Message-ID: <20200604172904.GA1751362@gmail.com>
References: <20200601170102.GA1346815@gmail.com>
 <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
 <20200602073350.GA481221@gmail.com>
 <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
 <871rmxgw4d.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I really get the feeling that this feature just isn't ready.
> 
> Ingo - would you mind sending me a pull request for the (independent)
> TLB cleanups part of that x86/mm tree? Because everything up to and
> including commit bd1de2a7aace ("x86/tlb/uv: Add a forward declaration
> for struct flush_tlb_info") looks sane.

Yeah, agreed, in fact we moved x86/mm back to bd1de2a7aace almost 
immediately and put the L1D bits into WIP.x86/mm. Fortunately they are 
on top of the rest, as you noted, so it didn't have to be rebased.

> It's only this L1D$ flushing thing at the end of that branch that I 
> think isn't fully cooked.

Yeah, sure - here's the updated pull request for the rest:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-06-04

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
