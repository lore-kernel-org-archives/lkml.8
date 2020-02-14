Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B624C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA96320873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwXJ9r3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbgBNRk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:40:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41148 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389839AbgBNRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:40:53 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so11400413ioo.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1CClW4tYZ79EFJV8GTAjHe6cQOLCCNvZ/tb7p+kbKo=;
        b=jwXJ9r3dQp/+12/mbTFMCINEUOtuUUs4zVoRGjZh0Jq9CkblELQN4A56KA8aiGl1rN
         nkE2kqBst9wANEpXI7757f5nrnoVW7516f/SpwI3dLJ97L/AeQAZnOzEQXZKSXd+5gwT
         zXrtjMkFKNqanCANOJcqvHaBMZZ/f2kdcSA+0Yyyz2/9lqpeOuT5Py6uxuFb4UCyEojZ
         zH0eaKYFXQtq2uQLLrJXsDRxB2rs84YUiUsmPhvNxMRxhclsTmehsmNqbuAh7eBjzguq
         aX47um+kgMO9UePZ8xabTT5VazkH6rv1QT2FYdEMjAqq4KBnJc6LCerOXaqJFddBQD1A
         AZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1CClW4tYZ79EFJV8GTAjHe6cQOLCCNvZ/tb7p+kbKo=;
        b=qPvUmFSMjyHJYnHCzDt67FDLfuyXylDWt87DvIpYatV3BjwAdErTYS5zEvPUxW3JLM
         2i0u591XxIo/DQw4e1KErG5poCVCS+gE33R+0o/7WdVUr2sbu5k8JVOUuu7FCILzGSlx
         XJ3ZC3jbfDnC+TKxSV14BvXtJ+QExVXj6E/lt6AH/0CQa3n5VWmd7QemJPaBwelzQO1u
         bhdKZ8ltkP1rDLEfjcp8kPUPVkUEzgkN+Ty2mMJa5rHvkfxZ8G4vCtrulY5EuOzlbZZ8
         WT0jREqYQin1H7sDjGFua8gaJzN23IOutzWBNmROt2z15updJzrG2VvDYFBOUqKpaMtG
         bk1g==
X-Gm-Message-State: APjAAAWX8zAevCtvi9O2L2qPHyg3fJ2Lstw9NB1/nDFqVZ643YJHBJ8O
        xh9yMo3OwQs+U1E9Dp9AzqNq7BAyY8E/ciYhezkJOA==
X-Google-Smtp-Source: APXvYqwbi/0s5UxMmiRUbEbHBhFsoQqrHDUU8ZNMeLvDBxbO0J9/qf0mX18DlDrmzayB1IZ16Glzb1cOG7SLbG+NeJI=
X-Received: by 2002:a02:3312:: with SMTP id c18mr3493979jae.24.1581702052559;
 Fri, 14 Feb 2020 09:40:52 -0800 (PST)
MIME-Version: 1.0
References: <1581695768-6123-1-git-send-email-cai@lca.pw> <20200214165923.GA20690@linux.intel.com>
 <1581700124.7365.70.camel@lca.pw>
In-Reply-To: <1581700124.7365.70.camel@lca.pw>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 14 Feb 2020 09:40:41 -0800
Message-ID: <CALMp9eTRn-46oKg5a9h79EZOvHGwT=8ZZN15Zmy5NUYsd+r8wQ@mail.gmail.com>
Subject: Re: [PATCH] kvm/emulate: fix a -Werror=cast-function-type
To:     Qian Cai <cai@lca.pw>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 9:08 AM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2020-02-14 at 08:59 -0800, Sean Christopherson wrote:
> > On Fri, Feb 14, 2020 at 10:56:08AM -0500, Qian Cai wrote:
> > > arch/x86/kvm/emulate.c: In function 'x86_emulate_insn':
> > > arch/x86/kvm/emulate.c:5686:22: error: cast between incompatible
> > > function types from 'int (*)(struct x86_emulate_ctxt *)' to 'void
> > > (*)(struct fastop *)' [-Werror=cast-function-type]
> > >     rc = fastop(ctxt, (fastop_t)ctxt->execute);
> > >
> > > Fixes: 3009afc6e39e ("KVM: x86: Use a typedef for fastop functions")
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >  arch/x86/kvm/emulate.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > > index ddbc61984227..17ae820cf59d 100644
> > > --- a/arch/x86/kvm/emulate.c
> > > +++ b/arch/x86/kvm/emulate.c
> > > @@ -5682,10 +5682,12 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
> > >             ctxt->eflags &= ~X86_EFLAGS_RF;
> > >
> > >     if (ctxt->execute) {
> > > -           if (ctxt->d & Fastop)
> > > -                   rc = fastop(ctxt, (fastop_t)ctxt->execute);
> >
> > Alternatively, can we do -Wno-cast-function-type?  That's a silly warning
> > IMO.
>
> I am doing W=1 on linux-next where some of the warnings might be silly but the
> recent commit changes all warnings to errors forces me having to silence those
> somehow.
>
> >
> > If not, will either of these work?
> >
> >                       rc = fastop(ctxt, (void *)ctxt->execute);
> >
> > or
> >                       rc = fastop(ctxt, (fastop_t)(void *)ctxt->execute);
>
> I have no strong preference. I originally thought just to go back the previous
> code style where might be more acceptable, but it is up to maintainers.

It seems misguided to define a local variable just to get an implicit
cast from (void *) to (fastop_t). Sean's first suggestion gives you
the same implicit cast without the local variable. The second
suggestion makes both casts explicit.
