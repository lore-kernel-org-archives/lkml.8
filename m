Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D9FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4C3206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIzmcXfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgGHTdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGHTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:33:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643FAC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:33:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so48285415iow.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slImY14f0rNlEWIkm1VGpH6ry5mubIzN1YXFRSQUYYw=;
        b=EIzmcXfUjvt2TpgoLMvmOT/1wauSIofM4ahX4qssit2mGp/aZJvZpH0CRIzLFtLSzj
         6kOGwZNSPgSre7jg2e413VgkxMXoVHdCL2ISAnaA7VDlGOgsOXE67V7PkS+g2IrVAPpM
         4RDM2PSqPHKBq7sucj1es79e+9iuSaSUercAkwFBm+PTQ/TWXGBAfqkJWSkC7i5fA8EX
         pdC8XtamtPprKBVLrjxBiPVyfIKH9tNEPD1PeHISshRyle6SIZnT9Aa8V131VZ5g48zs
         59t53fKWZnIRKv8irTmRNGVXDECNokzdTN08hCWuJgj9+wO5jjZcv85b8NjobvZWHKce
         xrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slImY14f0rNlEWIkm1VGpH6ry5mubIzN1YXFRSQUYYw=;
        b=cWlMkZ9mNfAz3Tp0m2WlJp2fX54AY2fqSrqjejSTB4znAkMbsKbpt7esWejg18pLin
         f3l9ov658/kMegLeejydNXJd0r5Ds3XK276UictrEJXkUflFzdAfQZ0rlvlY4F1o/gBz
         Lij7eneWqfF/KDAPL6X+rWqDf44JFfriyc+Gwn77mzH7K2OwvWDOODZbN9HvV5A0EIKk
         GMfiab2c/YND18oxmHuPqYt9YUPbkRNh+FZwh18vYnKExLuV2AVxniUWoeaUwskY8Nup
         j2VKkryx4hdr+QPBmbU1+ruKsHmoHwE5QhdiNWphm74c7VI23kq+D/edF/G2TBJ1CJWB
         yBfw==
X-Gm-Message-State: AOAM533XSKF/QoMFdyYNuIC+6xmNfTP/swajTWj3GzxQZHbJZMfFnMr/
        51uO4iBQsWUIy5eqp9dkmLB+dJu9DHfjr/caU5uBBg==
X-Google-Smtp-Source: ABdhPJzDCnsVGm3VcsqdzLHzVCHdu3/UfHN/Is45+S8jIg9IrJQNXCoiom79Lh+8ZiI4+GAHi9UzpqcSFOyp8/SmOGg=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr37795277iok.43.1594236784442;
 Wed, 08 Jul 2020 12:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200702221237.2517080-1-abhishekbh@google.com>
 <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com> <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
 <CA+noqoj6u9n_KKohZw+QCpD-Qj0EgoCXaPEsryD7ABZ7QpqQfg@mail.gmail.com>
 <20200703114037.GD2999146@linux.ibm.com> <CAD=FV=XRbrFqSbR619h+9HXNyrYNbqfBF2e-+iUZco9qQ8Wokg@mail.gmail.com>
 <20200705152304.GE2999146@linux.ibm.com> <5d2ccf3d-b473-cf30-b863-e29bb33b7284@redhat.com>
 <CA+noqojih03kKsWs33EUMV4H6RkWSRSQD=DHa9pAQ03yiz2GtQ@mail.gmail.com>
 <48f82669-f1ff-0f5e-e531-ebbd151205f9@redhat.com> <CA+noqoj70jThJ-N9DhWi8wnCLueJNfYKEU72HaMjSsMhJQEzJA@mail.gmail.com>
 <f8e84764-1cc7-c4e5-4e4f-4b907204a374@redhat.com>
In-Reply-To: <f8e84764-1cc7-c4e5-4e4f-4b907204a374@redhat.com>
From:   Abhishek Bhardwaj <abhishekbh@google.com>
Date:   Wed, 8 Jul 2020 12:32:27 -0700
Message-ID: <CA+noqoh90h3Mtk_3++bnMGMYyEGmUUq09R1k2WzCUbKX1jgQXQ@mail.gmail.com>
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

On Mon, Jul 6, 2020 at 8:14 AM Waiman Long <longman@redhat.com> wrote:
>
> On 7/5/20 5:51 PM, Abhishek Bhardwaj wrote:
>
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
>
> I'd rather avoid this dependency. However, if people are okay with the
> CONFIG option then I am happy to oblige with whatever people agree on.
> Can a maintainer chime in ? Waiman if you're the final authority on
> this, will you accept the patch if I incorporated your suggestion ?
>
> It is fine if you think this is not what you want.
>
> BTW, I am not a maintainer. However, no maintainer will give pre-approval. At least, you have to give the reason why this patch is needed in the patch itself. Before that happens, I don't see how it will get merged upstream.

I just updated the patch with the reasoning in the commit message -
https://lkml.org/lkml/2020/7/8/1325


>
> Cheers,
> Longman



-- 
Abhishek
