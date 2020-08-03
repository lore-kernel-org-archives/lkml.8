Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E031C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7AB20A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596475026;
	bh=ZfW2vhvSScmUs7HxUE0FsgQ1dlDVdrRmbY/gG/hY7hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qj/UTwgzEbPhdqx3+wSEqvR5dbBtIGTtW+OewkSmd+lCSr7XRQc66iVZCNBjBxLZg
	 xFPH7h1iSxfkEpNeZgcFsV5tdbqiImJ2nAOp7jaqdwZ3bTuy1JA2mbPjR18sd42fpp
	 TXK+09DFhkkwaWej7AIej33noDfP9SuE6aXbdcwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgHCRRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHCRRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:17:05 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B70422BED
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596475023;
        bh=ZfW2vhvSScmUs7HxUE0FsgQ1dlDVdrRmbY/gG/hY7hg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Np7Qal28gMw4vcH1iKZe+TCqR6WclB8Xl5dpKtQX+V2iYlgPe7V6F8enqvaZFIEk2
         I/Mthwxs+qNrkOId4Kwi++aCgOrG1nb2jiaXJkC5c1dj2bJ7lcaLS3wS0GK5Mj1eMN
         /F+YS18i6ApdnLrSIBlXk7GDgD7KvH9c8mG8Tmg8=
Received: by mail-lf1-f48.google.com with SMTP id v15so16336370lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:17:04 -0700 (PDT)
X-Gm-Message-State: AOAM532nl7fMRCkhIHFalrbgGy1SGd7FW+CbYG7l98HPcrLRVdINcG8L
        gnB1gidwDV+GoBc5SWuFw4A3od2K4QYgbzoCA9zOZg==
X-Google-Smtp-Source: ABdhPJw3cLd2NyF1JTZLmIChK5azh663lCruYa9l5xMzdcEl0b7NT7N2OX4JjEA6xNE9eK5dDwiBzSwU4LUpGRtccrQ=
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr15622569wrw.70.1596475021990;
 Mon, 03 Aug 2020 10:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com> <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
 <f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com> <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
 <12fbdc01-e444-8d10-5790-e3495fc8a837@intel.com>
In-Reply-To: <12fbdc01-e444-8d10-5790-e3495fc8a837@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 3 Aug 2020 10:16:50 -0700
X-Gmail-Original-Message-ID: <CALCETrWR1hL=eXAkn=OG1vtAPvC9n1jGqyNuyXpYw8QwPENo1A@mail.gmail.com>
Message-ID: <CALCETrWR1hL=eXAkn=OG1vtAPvC9n1jGqyNuyXpYw8QwPENo1A@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 9:37 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/3/20 8:12 AM, Andy Lutomirski wrote:
> > I could easily be convinced that the PASID fixup is so trivial and so
> > obviously free of misfiring in a way that causes an infinite loop that
> > this code is fine.  But I think we first need to answer the bigger
> > question of why we're doing a lazy fixup in the first place.
>
> There was an (internal to Intel) implementation of this about a year ago
> that used smp_call_function_many() to force the MSR state into all
> threads of a process.  I took one look at it, decided there was a 0%
> chance of it actually functioning and recommended we find another way.
> While I'm sure it could be done more efficiently, the implementation I
> looked at took ~200 lines of code and comments.  It started to look too
> much like another instance of mm->cpumask for my comfort.

If I were implementing this, I would try making switch_mm_irqs_off()
do, roughly:

void load_mm_pasid(...) {
  if (cpu_feature_enabled(X86_FEATURE_ENQCMD))
    tsk->xstate[offset] = READ_ONCE(next->context.pasid);
}

This costs one cache miss, although the cache line in question is
about to be read anyway.  It might be faster to, instead, do:

void load_mm_pasid(...) {
  u32 pasid = READ_ONCE(next->context.pasid);

  if (tsk->xstate[offset] != pasid)
    tsk->state[offset] = pasid;
}

so we don't dirty the cache line in the common case.  The actual
generated code ought to be pretty good -- surely the offset of PASID
in XSTATE is an entry in an array somewhere that can be found with a
single read, right?

The READ_ONCE is because this could race against a write to
context.pasid, so this code needs to be at the end of the function
where it's protected by mm_cpumask.  With all this done, the pasid
update is just on_each_cpu_mask(mm_cpumask(mm), load_mm_pasid, mm,
true).

This looks like maybe 20 lines of code.  As an added bonus, it lets us
free PASIDs early if we ever decide we want to.




May I take this opportunity to ask Intel to please put some real
thought into future pieces of CPU state?  Here's a summary of some
things we have:

- Normal extended state (FPU, XMM, etc): genuinely per thread and only
ever used explicitly.  Actually makes sense with XSAVE(C/S).

- PKRU: affects CPL0-originated memory accesses, so it needs to be
eagerly loaded in the kernel.  Does not make sense with XRSTOR(C/S),
but it's in there anyway.

- CR3: per-mm state.  Makes some sense in CR3, but it's tangled up
with CR4 in nasty ways.

- LDTR: per-mm on Linux and mostly obsolete everyone.  In it's own
register, so it's not a big deal.

- PASID: per-mm state (surely Intel always intended it to be per-mm,
since it's for shared _virtual memory_!).  But for some reason it's in
an MSR (which is slow), and it's cleverly, but not that cleverly,
accessible with XSAVES/XRSTORS.  Doesn't actually make sense.  Also,
PASID is lazy-loadable, but the mechanism for telling the kernel that
a lazy load is needed got flubbed.

- TILE: genuinely per-thread, but it's expensive so it's
lazy-loadable.  But the lazy-load mechanism reuses #NM, and it's not
fully disambiguated from the other use of #NM.  So it sort of works,
but it's gross.

- "KERNEL_GS_BASE", i.e. the shadow GS base.  This is logically
per-user-thread state, but it's only accessible in MSRs.  For some
reason this is *not* in XSAVES/XRSTORS state, nor is there any
efficient way to access it at all.

- Segment registers: can't be properly saved except by hypervisors,
and can almost, but not quite, be properly loaded (assuming the state
was sane to begin with) by normal kernels.  Just don't try to load 1,
2, or 3 into any of them.

Sometimes I think that this is all intended to be as confusing as
possible and that it's all a ploy to keep context switches slow and
complicated.  Maybe Intel doesn't actually want to compete with other
architectures that can context switch quickly?


It would be really nice if we had a clean way to load per-mm state
(see my private emails about this), a clean way to load CPL3 register
state, and a clean way to load per-user-thread *kernel* register state
(e.g. PKRU and probably PKRS).  And there should be an exception that
says "user code accessed a lazy-loaded resource that isn't loaded, and
this is the resource it tried to access".
