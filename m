Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D59E207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596467553;
	bh=+PZ/awBxxRTMw2BeBwqmtU59rWiDwd7Tyrz4gbzxrPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mw8XJmu3fHklGhqpN8uaUa999OkZ5zRxz8HAchAFBSXsCIHKeKBXxBogggJCGK6Zr
	 OmCjemvybnP34qdaOL4xO1u+azo767mZj5HURwTSMyXMgpdZw1ejGbR0e7TIFauyPx
	 O7LHsfZHt96HGPMsSjA13MWgXkVdZOca7mW/DvSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHCPMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgHCPMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:12:32 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE97722B40
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596467551;
        bh=+PZ/awBxxRTMw2BeBwqmtU59rWiDwd7Tyrz4gbzxrPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0/f4b8/09auXonUnapsGzATJEFpuQt2ckgRpCmNzlIVMXQHi1eCxGLxYavFmhfKvv
         C2kxNDkhIOpg/osZuSwpo2ywTRfz6bkY3OJF5UvfhxkmNadk37TFmqVfdZP/JvTFFM
         /K7KIaULvc0BVWY+ZzLoEBa6FS6F3JWY0TYN39T0=
Received: by mail-wm1-f49.google.com with SMTP id q76so14564500wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:12:31 -0700 (PDT)
X-Gm-Message-State: AOAM5324jyo/DEeGK0SlU2/tL33fdmB41XcHQNJ/qJlWs2j4AnjfYv5L
        byFFkcn1dEKcnQNG8awxx4FStdQB67rmubGXgH4mXA==
X-Google-Smtp-Source: ABdhPJwiaA4kvJyZgwWanbpbA2UDgr/APeGodXtQoq2MM4XlnMkdWJK9xJVz1B9yxVMecsh5WGJ2L5eyBMVqiOoZypY=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr436874wmc.138.1596467549637;
 Mon, 03 Aug 2020 08:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com> <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
 <f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com>
In-Reply-To: <f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 3 Aug 2020 08:12:18 -0700
X-Gmail-Original-Message-ID: <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
Message-ID: <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
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

On Mon, Aug 3, 2020 at 8:03 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/31/20 4:34 PM, Andy Lutomirski wrote:
> >> Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
> >> without a valid PASID value programmed. #GP error codes are 16 bits and all
> >> 16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
> >> choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
> >> when loading from the source operand, so its not fully comprehending all
> >> the reasons. Rather than special case the ENQCMD, in future Intel may
> >> choose a different fault mechanism for such cases if recovery is needed on
> >> #GP.
> > Decoding the user instruction is ugly and sets a bad architecture
> > precedent, but we already do it in #GP for UMIP.  So I'm unconvinced.
>
> I'll try to do one more bit of convincing. :)
>
> In the end, we need a way to figure out if the #GP was from a known "OK"
> source that we can fix up.  You're right that we could fire up the
> instruction decoder to help answer that question.  But, it (also)
> doesn't easily yield a perfect answer as to the source of the #GP, it
> always involves a user copy, and it's a larger code impact than what
> we've got.
>
> I think I went and looked at fixup_umip_exception(), and compared it to
> the alternative which is essentially just these three lines of code:
>
> > +     /*
> > +      * If the current task already has a valid PASID in the MSR,
> > +      * the #GP must be for some other reason.
> > +      */
> > +     if (current->has_valid_pasid)
> > +             return false;
> ...> +  /* Now the current task has a valid PASID in the MSR. */
> > +     current->has_valid_pasid = 1;
>
> and *I* was convinced that instruction decoding wasn't worth it.
>
> There's a lot of stuff that fixup_umip_exception() does which we don't
> have to duplicate, but it's going to be really hard to get it anywhere
> near as compact as what we've got.
>

I could easily be convinced that the PASID fixup is so trivial and so
obviously free of misfiring in a way that causes an infinite loop that
this code is fine.  But I think we first need to answer the bigger
question of why we're doing a lazy fixup in the first place.

--Andy
