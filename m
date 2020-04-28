Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60ACC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BAB206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXuANhi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD1XYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgD1XYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:24:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21252C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:24:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k23so221852ios.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tYTe3rXjQCNrBkKTXCmJf8lKprp2RWUAlHsRaWNxGTc=;
        b=TXuANhi0BR/JvyNjZ8nFnQsNZ4GupoZB2lYXOs15aNSTXp8rXR8eORnV/dPHv5qVQO
         wtgyDJ2jD8GYUaTGPEjvTkkvFhLb8Sj1iszbfT4W0QH/hWFvecz9SLWlyz6qJpFr/u/e
         xVfR3geOpR/9ejNcEqBvcj4oXzS743JT5vt2JSc7V88h1ShcNVcBgF4vJh1HOkK21TaS
         0bGkVsqcf8wWQ016Azt0Ro1bKOedsJuhvo67WQwQcfsntwjg10hsHHRwWspyMmE/lC5m
         KE8nAWQ7H7+ELIVDnsmiZu1Y9ttYzJybd/6JoEFXeaqjPzn2QE9uI7DEkcn8Dxus7gvx
         wnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tYTe3rXjQCNrBkKTXCmJf8lKprp2RWUAlHsRaWNxGTc=;
        b=Gnn2mdhEe0bkcnK+gwDKnRfzU06bapRRi0FyFqlRYirQkHiSiXKZlKptJbGM9Pbkio
         YqYJyCuo3e1qvem0Hw5lFVqjEG2P/Ta6/5mrR3F48U/q8HevpoJqJ0x3ULPYSe/74mwe
         vD6gCmGS4iArAu45KPpsgOdqS2M6Z6MnMs/LV3wrs2dgHAZR2ueNJbgkugg7rOfvK/QV
         wUUjRnlwVpWzUPEoQUj4yZfe8zpgq7bWGWjLGczMv6xWAcM0nR0BcctnTELq9P+MCzuI
         5UxmQUanQsgyMhXV0UJDphjKplQ+KwlQ1RKP/VmfmCBrUROLj5lD35nsHh5ZkhLDkOgx
         rwDQ==
X-Gm-Message-State: AGi0Pua/B7OGHsaipTEU4YS2+mg7sRNDQw8eVkHBuwoLtU1zM/R71be+
        QyIIkV+o9XssICoq01iMaiewODFqFKv24yD1JEoOhg==
X-Google-Smtp-Source: APiQypJARVyM9++FPpENPWT9FRn8ts9pOcs46/T52gRBupV/SBqZ6MaFNM0VJKXMuJDTTIEqosCza1ykao3hdWRhF5Q=
X-Received: by 2002:a5e:a610:: with SMTP id q16mr28422670ioi.75.1588116244121;
 Tue, 28 Apr 2020 16:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com>
 <20200423022550.15113-10-sean.j.christopherson@intel.com> <CALMp9eSuYqeVmWhb6q7T5DAW_Npbuin_N1+sbWjvcu0zTqiwsQ@mail.gmail.com>
 <20200428225949.GP12735@linux.intel.com>
In-Reply-To: <20200428225949.GP12735@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 16:23:52 -0700
Message-ID: <CALMp9eR8VsGAPrKLM2ZCG_DBTJa5Cn+raaUtzG=4V-bp_jxqWw@mail.gmail.com>
Subject: Re: [PATCH 09/13] KVM: nVMX: Prioritize SMI over nested IRQ/NMI
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 3:59 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Apr 28, 2020 at 03:04:02PM -0700, Jim Mattson wrote:
> > On Wed, Apr 22, 2020 at 7:26 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > Check for an unblocked SMI in vmx_check_nested_events() so that pendi=
ng
> > > SMIs are correctly prioritized over IRQs and NMIs when the latter eve=
nts
> > > will trigger VM-Exit.  This also fixes an issue where an SMI that was
> > > marked pending while processing a nested VM-Enter wouldn't trigger an
> > > immediate exit, i.e. would be incorrectly delayed until L2 happened t=
o
> > > take a VM-Exit.
> > >
> > > Fixes: 64d6067057d96 ("KVM: x86: stubs for SMM support")
> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > ---
> > >  arch/x86/kvm/vmx/nested.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index 1fdaca5fd93d..8c16b190816b 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -3750,6 +3750,12 @@ static int vmx_check_nested_events(struct kvm_=
vcpu *vcpu)
> > >                 return 0;
> > >         }
> > >
> > > +       if (vcpu->arch.smi_pending && !is_smm(vcpu)) {
> > > +               if (block_nested_events)
> > > +                       return -EBUSY;
> > > +               goto no_vmexit;
> > > +       }
> > > +
> >
> > From the SDM, volume 3:
> >
> > =E2=80=A2 System-management interrupts (SMIs), INIT signals, and higher
> > priority events take priority over MTF VM exits.
> >
> > I think this block needs to be moved up.
>
> Hrm.  It definitely needs to be moved above the preemption timer, though =
I
> can't find any public documentation about the preemption timer's priority=
.

Section 25.2 of the SDM, volume 3:

Debug-trap exceptions and higher priority events take priority over VM
exits caused by the VMX-preemption
timer. VM exits caused by the VMX-preemption timer take priority over
VM exits caused by the =E2=80=9CNMI-window
exiting=E2=80=9D VM-execution control and lower priority events.
