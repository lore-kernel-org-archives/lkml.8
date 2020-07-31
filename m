Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE23620791
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596238466;
	bh=ITLemeA+7bIT0Gyumefb19FaUYhRK8aANpWoBIk24ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GZDOnTsOXGBWLhNOBhAymG1iV2hQyl0MRRqi1YW0aUY3XsggDq941vsmXlZOGHKTw
	 5qReLRcS+J/sf+UJ7oZroNM+C4B6/w/GCR/hDiGd+5e1gsZCJkBMvZmITLFH1WpMoB
	 Bz1Kl/Er5mFCz5erOSs1nTMoHns/ETURiNZ5+GVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGaXeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgGaXeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:34:25 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB8A22BEA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 23:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596238464;
        bh=ITLemeA+7bIT0Gyumefb19FaUYhRK8aANpWoBIk24ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PitolgIcwqhucedGVzrmbU+mixt9I+bZpDo1c+KN/xZR7qvwjD6rIm2BIN9PPr0hA
         rwYsDXIJbqkEFv29YlLvNdTum8LQr4KHQNNUgihepRc0Dk855ZHBxx5QXog31r6gbh
         GNtRZ1uBwdcxXfCE9v7u3y9dRvZBVaLTOsgo4Evc=
Received: by mail-wm1-f50.google.com with SMTP id d190so9720573wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:34:23 -0700 (PDT)
X-Gm-Message-State: AOAM530jSMNnohTWZZ0vQtYeuxJFruaCLbsiKvk52owoifJ5ieZd48Ji
        oUb+woK20SiW8BWAv05TyFqKMKNviza8qRnJLZIP4Q==
X-Google-Smtp-Source: ABdhPJwHRJFpNjV4x8D1GMUC1YCOqAimw3vWn2FV0L8VSZMCzBymUACLIz90Tn5KcszLgZJWFdAUcRlC6fy1hhSBmbk=
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr948983wmf.49.1596238462535;
 Fri, 31 Jul 2020 16:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com> <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 Jul 2020 16:34:11 -0700
X-Gmail-Original-Message-ID: <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
Message-ID: <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
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

On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> A #GP fault is generated when ENQCMD instruction is executed without
> a valid PASID value programmed in the current thread's PASID MSR. The
> #GP fault handler will initialize the MSR if a PASID has been allocated
> for this process.
>
> Decoding the user instruction is ugly and sets a bad architecture
> precedent. It may not function if the faulting instruction is modified
> after #GP.
>
> Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
> without a valid PASID value programmed. #GP error codes are 16 bits and all
> 16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
> choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
> when loading from the source operand, so its not fully comprehending all
> the reasons. Rather than special case the ENQCMD, in future Intel may
> choose a different fault mechanism for such cases if recovery is needed on
> #GP.

Decoding the user instruction is ugly and sets a bad architecture
precedent, but we already do it in #GP for UMIP.  So I'm unconvinced.

Memo to Intel, though: you REALLY need to start thinking about what
the heck an OS is supposed to do with all these new faults you're
coming up with.  The new #NM for TILE is utterly nonsensical.  Sure,
it works for an OS that does not use CR0.TS and as long as no one
tries to extend the same mechanism for some new optional piece of
state, but as soon as Intel tries to use the same mechanism for
anything else, it falls apart.

Please do better.

> +
> +/*
> + * Write the current task's PASID MSR/state. This is called only when PASID
> + * is enabled.
> + */
> +static void fpu__pasid_write(u32 pasid)
> +{
> +       u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> +
> +       fpregs_lock();
> +
> +       /*
> +        * If the MSR is active and owned by the current task's FPU, it can
> +        * be directly written.
> +        *
> +        * Otherwise, write the fpstate.
> +        */
> +       if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +               wrmsrl(MSR_IA32_PASID, msr_val);
> +       } else {
> +               struct ia32_pasid_state *ppasid_state;
> +
> +               ppasid_state = get_xsave_addr(&current->thread.fpu.state.xsave,
> +                                             XFEATURE_PASID);
> +               /*
> +                * ppasid_state shouldn't be NULL because XFEATURE_PASID
> +                * is enabled.
> +                */
> +               WARN_ON_ONCE(!ppasid_state);
> +               ppasid_state->pasid = msr_val;

WARN instead of BUG is nice, but you'll immediate oops if this fails.
How about:

if (!WARN_ON_ONCE(!ppasid_state))
  ppasid_state->pasid = msr_val;
