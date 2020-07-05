Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E32C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C7420739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5/pIAXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgGESXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgGESXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:23:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8884C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 11:23:18 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q8so37118989iow.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMEHe+br8dXcHI+hB4O6nEY5v7Sg6St98G6CWcHOLAY=;
        b=p5/pIAXf3CKYBu7XQ+eET85u6p43lVcZZCEJzOCn6xIig95QPwz/9I/2x+weOJLgxn
         Cie31azzWN79bqQqUdusC9nA9+hbL9kvsl1MJwazGnkcJn1kiG3l6fQ1dV2Ib6ejFaTp
         WjCjV1l5Ehh2ZrunNBhIrGkQMyglDkpgtqJ2U/MIXQ8luL+uaTBJn1aWJKcwAkBhMVAX
         P2IY3nJQcZI7yfOYlFzUvVdgsBKEMcyevYLUwC1XYkeeD6Sw4vzLu0lMNHRQSsnMpPsK
         1dNu8PjzqnGWr0G9s2y6gBF3/WNe3mf2YHQmY+3ZgezLAq1YbzpBMbbRVlAbJ+hGGI6R
         U4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMEHe+br8dXcHI+hB4O6nEY5v7Sg6St98G6CWcHOLAY=;
        b=XkKXmVUj2FzfuI8taGXVpkK8Axm8v4vzhfr4Ae83CeVDKNgDvidkrvKGxJ47lUVYin
         clhxGLjcMzqG4/bFZ6K6n5AARtjB3jcr+UtjyjWtHfv/N1wskzxwcPNosr5O3ghSzUt3
         BnsZM8F2lczHjufYqh8QY0JZPDWE/eueoB9+RUIDrq/DU1OuMRFZfNfZhCizYgbTIn+g
         mnh5ZvRTl2WgjsFttHT4Tm+Vkjlk0DSCQ2pJWrYnKxdWhE45qs1D/NGpKsq2FFrQCUGt
         /qop9xrBwTu5r4DwkwwwYWwa/6RFPfkwOQ473KynxBKTRdjo9lXa8zxQyHl920FEMQF9
         gEOw==
X-Gm-Message-State: AOAM533nuqWVKUoIbQFoc9qXzvM0UzZ7ZUi+KsfUBC9ix7zqZwDOZ5V9
        E2IrxQZZSsAB2LlahkW6hKmSMao8qxA+JFQSzv7Tlw==
X-Google-Smtp-Source: ABdhPJyBOWuLUXOzG6o2lDDAnLH070zEuFx/Po3XVCpmBC/ky8dEjid7/3THBJAz32DNG7JWCQm++YJmtgD+wfcVmls=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr21634185iok.43.1593973397858;
 Sun, 05 Jul 2020 11:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200702221237.2517080-1-abhishekbh@google.com>
 <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com> <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
 <CA+noqoj6u9n_KKohZw+QCpD-Qj0EgoCXaPEsryD7ABZ7QpqQfg@mail.gmail.com>
 <20200703114037.GD2999146@linux.ibm.com> <CAD=FV=XRbrFqSbR619h+9HXNyrYNbqfBF2e-+iUZco9qQ8Wokg@mail.gmail.com>
 <20200705152304.GE2999146@linux.ibm.com> <5d2ccf3d-b473-cf30-b863-e29bb33b7284@redhat.com>
In-Reply-To: <5d2ccf3d-b473-cf30-b863-e29bb33b7284@redhat.com>
From:   Abhishek Bhardwaj <abhishekbh@google.com>
Date:   Sun, 5 Jul 2020 11:22:42 -0700
Message-ID: <CA+noqojih03kKsWs33EUMV4H6RkWSRSQD=DHa9pAQ03yiz2GtQ@mail.gmail.com>
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

On Sun, Jul 5, 2020 at 8:57 AM Waiman Long <longman@redhat.com> wrote:
>
> On 7/5/20 11:23 AM, Mike Rapoport wrote:
> >> Nothing prevents people from continuing to use the command line
> >> options if they want, right?  This just allows a different default.
> >> So if a distro is security focused and decided that it wanted a slower
> >> / more secure default then it could ship that way but individual users
> >> could still override, right?
> > Well, nothing prevents you from continuing to use the command line as
> > well;-)
> >
> > I can see why whould you want an ability to select compile time default
> > for an option, but I'm really not thrilled by the added ifdefery.
> >
>
> It turns out that CONFIG_KVM_VMENTRY_L1D_FLUSH values match the enum
> vmx_l1d_flush_state values. So one way to reduce the ifdefery is to do,
> for example,
>
> +#ifdef CONFIG_KVM_VMENTRY_L1D_FLUSH
> +#define VMENTER_L1D_FLUSH_DEFAULT CONFIG_KVM_VMENTRY_L1D_FLUSH
> +#else
> +#define VMENTER_L1D_FLUSH_DEFAULT      VMENTER_L1D_FLUSH_AUTO
> #endif
> -enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
> +enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_DEFAULT;
>
> Of course, we may need to add a comment on enum vmx_l1d_flush_state
> definition to highlight the dependency of CONFIG_KVM_VMENTRY_L1D_FLUSH
> on it to avoid future mismatch.

I explicitly wanted to avoid doing that for this very reason. In my
opinion this is brittle and bound to be missed
sooner or later.

I'd rather have the value assignment be explicit rather than some
clever hack. Notice, this wouldn't work if the enum
values were not contiguous. We just got lucky.

Do people feel strongly against this ifdef ladder ?

>
> Cheers,
> Longman
>



--
Abhishek
