Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8E620885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597945891;
	bh=Hd7dQCZl4iX+4WliBBdnAj0CCq4bi2DQ3q+O7Ti6Nlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I7icew+Ta4JB4pzEqZstoj42ZppUIVKUP6JsUy4fy9ja9MCRtQfJlWXA6S2U5+cGH
	 hy+VU9PXYx4c8BAn63XYrE78ikzFHUK7DVrol/3EiLIb01MuXAL+OVDv5vsBrjA3l4
	 mm/XMrTmI555otACpQRT2blkQwGF6ui5H+jbPdAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHTRv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgHTRvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:51:24 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E9A22B47
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597945883;
        bh=Hd7dQCZl4iX+4WliBBdnAj0CCq4bi2DQ3q+O7Ti6Nlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Im+4gBzl5bMAbo5vl1UwPaLrbBNkZB3oa0hi94GLj5UtzODGxtqGempxVlLZ6SyAN
         DWUTs3AziuArOpNOWYiwlXGA3yelXsbpk+EPT+DZQBHhOpNrdYm/EGPU0MyeMKr3oP
         qIQxfSVS2YOdxm67vTzEAebMWTZQhZkNX5qFMfVE=
Received: by mail-wm1-f51.google.com with SMTP id x5so2454265wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:51:23 -0700 (PDT)
X-Gm-Message-State: AOAM530kTY5HCkb4uo5Va8aX+exGMKrdBOee18QjKMgrbR3QogLxIh7a
        25ja/pyvMU72A6KUUITyEb65fql8EB88LC/QXCnccg==
X-Google-Smtp-Source: ABdhPJxcfh3w4DsaGHJOKg/5/rhLHj1LNmJV95DlNJr3n5TBlCyXcbFkCp4plyjTDN2OBa0gvhasE/RmvsvqVvaV5zA=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr4577943wmc.138.1597945881693;
 Thu, 20 Aug 2020 10:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com> <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com> <aab48f12-5c2a-8e01-8dcb-16669fda7526@redhat.com>
In-Reply-To: <aab48f12-5c2a-8e01-8dcb-16669fda7526@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Aug 2020 10:51:10 -0700
X-Gmail-Original-Message-ID: <CALCETrXoquUOZEtYUHA8ZgbihbUHK=ShaHndy5Tk4WUFJrjqqw@mail.gmail.com>
Message-ID: <CALCETrXoquUOZEtYUHA8ZgbihbUHK=ShaHndy5Tk4WUFJrjqqw@mail.gmail.com>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/08/20 23:25, Andy Lutomirski wrote:
> >         wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> >         load_gs_index(svm->host.gs);
> >
> > Surely that should do load_gs_index() *before* wrmsrl().  But that's
> > not the problem at hand.
>
> The wrmsrl is writing the inactive GS base so the ordering between
> load_gs_index and wrmsrl(MSR_KERNEL_GS_BASE) should be irrelevant?

load_gs_index() sets the index between a pair of swapgs's -- it writes
the inactive base, too.

--Andy
