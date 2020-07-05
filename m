Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EEEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 21:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D59920658
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JioBrfmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgGEVwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 17:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGEVwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 17:52:19 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB24C08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 14:52:19 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a11so23072188ilk.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZK1R5YMa0aF6KR1E2UDLcWw1cuQUbwg5uNgHrHFxCc=;
        b=JioBrfmUo/u9lPG7BO5RHgxZ0WwuucbyKrUF+FYXv2NY3Jq+ccEO0qI/dFmEJ6tt8i
         F9cAluXiTU+4Zf5z6c1FMN/KDeJvAWj3sp0fiUZHFTaikIONCs/LU8ILyzOhKRqjYYW3
         f16QHCnGzfg8NPjZu0WI7OfJ7jWCyQC6r2Rz090++zM7mfq9Rj2kV/HCZ+j+0w1Dr+se
         +N5Gsv0oAnpXKTsQVYa1QLhvRc03FQf97NhGrXOByVHFmnrYNSlFCcDiT2M2HIX9OZFY
         fyaBuXVyXu4jttabXqX4Rgfopxs0ClNSCKVJSOFyzRpIxayzmNGo3xLlefp5XigNd0sr
         ABtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZK1R5YMa0aF6KR1E2UDLcWw1cuQUbwg5uNgHrHFxCc=;
        b=tPG+4HLbqlVHabbM2Khni/NSEG4sK8t8LPd9geYTU1Q+hjXXTcStWBn7/QI5BO+R5a
         siLHNckGPOJwokPlfZdKTy/rDpVy2V/VVbcXtUo2h8p79kRKlZTVh3DYT3aMJpmPiJVl
         Noi86nsWBVlkWq6Ze7ydLv7pu2ZIRSlzbYwEoK4RVAe5jgeUcXJ77PzRnAvpSx9dHkk8
         EJMUMA+9dhlHHlqr8veF8fmohTsSwdeiANPACokEL+eHfbZ70D6Y1ZD77uYTpCv2aj0S
         3aOkp/r3ZGErYvZ+Jr94OCTagM+VF2icQ9MFPp62qou6v2Tt+0O4X/sWiTFUWe6PGZBT
         4fmw==
X-Gm-Message-State: AOAM530bpgMI43pYGbN3ChYqVngi1MC0YacCIer8D/QyRR/uz888B6j+
        QE6va+iA6gSVIJwb+fnhgwK31/2X8wNwDA8E2es9Hg==
X-Google-Smtp-Source: ABdhPJxyTBAED5VYWUj6l8sZBfU30eNF40Cj47R44Pt+FbKn3964usrXrO9Me5UVhokJ2uTDpsC/XFspHH/6YY6IfIk=
X-Received: by 2002:a92:c9cb:: with SMTP id k11mr27918475ilq.70.1593985938519;
 Sun, 05 Jul 2020 14:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200702221237.2517080-1-abhishekbh@google.com>
 <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com> <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
 <CA+noqoj6u9n_KKohZw+QCpD-Qj0EgoCXaPEsryD7ABZ7QpqQfg@mail.gmail.com>
 <20200703114037.GD2999146@linux.ibm.com> <CAD=FV=XRbrFqSbR619h+9HXNyrYNbqfBF2e-+iUZco9qQ8Wokg@mail.gmail.com>
 <20200705152304.GE2999146@linux.ibm.com> <5d2ccf3d-b473-cf30-b863-e29bb33b7284@redhat.com>
 <CA+noqojih03kKsWs33EUMV4H6RkWSRSQD=DHa9pAQ03yiz2GtQ@mail.gmail.com> <48f82669-f1ff-0f5e-e531-ebbd151205f9@redhat.com>
In-Reply-To: <48f82669-f1ff-0f5e-e531-ebbd151205f9@redhat.com>
From:   Abhishek Bhardwaj <abhishekbh@google.com>
Date:   Sun, 5 Jul 2020 14:51:40 -0700
Message-ID: <CA+noqoj70jThJ-N9DhWi8wnCLueJNfYKEU72HaMjSsMhJQEzJA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <dianders@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 11:48 AM Waiman Long <longman@redhat.com> wrote:
>
> On 7/5/20 2:22 PM, Abhishek Bhardwaj wrote:
> > On Sun, Jul 5, 2020 at 8:57 AM Waiman Long <longman@redhat.com> wrote:
> >> On 7/5/20 11:23 AM, Mike Rapoport wrote:
> >>>> Nothing prevents people from continuing to use the command line
> >>>> options if they want, right?  This just allows a different default.
> >>>> So if a distro is security focused and decided that it wanted a slower
> >>>> / more secure default then it could ship that way but individual users
> >>>> could still override, right?
> >>> Well, nothing prevents you from continuing to use the command line as
> >>> well;-)
> >>>
> >>> I can see why whould you want an ability to select compile time default
> >>> for an option, but I'm really not thrilled by the added ifdefery.
> >>>
> >> It turns out that CONFIG_KVM_VMENTRY_L1D_FLUSH values match the enum
> >> vmx_l1d_flush_state values. So one way to reduce the ifdefery is to do,
> >> for example,
> >>
> >> +#ifdef CONFIG_KVM_VMENTRY_L1D_FLUSH
> >> +#define VMENTER_L1D_FLUSH_DEFAULT CONFIG_KVM_VMENTRY_L1D_FLUSH
> >> +#else
> >> +#define VMENTER_L1D_FLUSH_DEFAULT      VMENTER_L1D_FLUSH_AUTO
> >> #endif
> >> -enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
> >> +enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_DEFAULT;
> >>
> >> Of course, we may need to add a comment on enum vmx_l1d_flush_state
> >> definition to highlight the dependency of CONFIG_KVM_VMENTRY_L1D_FLUSH
> >> on it to avoid future mismatch.
> > I explicitly wanted to avoid doing that for this very reason. In my
> > opinion this is brittle and bound to be missed
> > sooner or later.
> >
> That is why I said a comment will have to be added to highlight this
> dependency. For instance,
>
> +/*
> + * Three of the enums are explicitly assigned as the KVM_VMENTRY_L1D_FLUSH
> + * config entry in arch/x86/kvm/Kconfig depends on these values.
> + */
>   enum vmx_l1d_flush_state {
>          VMENTER_L1D_FLUSH_AUTO,
> -       VMENTER_L1D_FLUSH_NEVER,
> -       VMENTER_L1D_FLUSH_COND,
> -       VMENTER_L1D_FLUSH_ALWAYS,
> +       VMENTER_L1D_FLUSH_NEVER = 1,
> +       VMENTER_L1D_FLUSH_COND = 2,
> +       VMENTER_L1D_FLUSH_ALWAYS = 3,
>          VMENTER_L1D_FLUSH_EPT_DISABLED,
>          VMENTER_L1D_FLUSH_NOT_REQUIRED,
>   };
>
> Of course, this is just a suggestion.

I'd rather avoid this dependency. However, if people are okay with the
CONFIG option then I am happy to oblige with whatever people agree on.
Can a maintainer chime in ? Waiman if you're the final authority on
this, will you accept the patch if I incorporated your suggestion ?

>
> Cheers,
> Longman
>


-- 
Abhishek
