Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F01C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E120663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwK4A3bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgCPODr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:03:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48521 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729456AbgCPODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584367424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LswxjmRwCl5Y8T8sS8FlN+jFURuk1TQ71z6c49JyB+s=;
        b=XwK4A3bz9a7e1l2FzLJr8SkhYCdoDoAgCN0paT5UvmzelmuzXwNYPCy7/831UtcTEP9q3e
        K+XfvCDEkkmtOgVOq0bGPEajoTKPNsr+7Vtie6zEx/6JLi8IWfcrY9ZzLWOD3Fpdabxl2Y
        RE0nlpXd1BZ3011Nc9NMGq+236svxS0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-Cx-cnndvP02N1FVsaBhBiA-1; Mon, 16 Mar 2020 10:03:43 -0400
X-MC-Unique: Cx-cnndvP02N1FVsaBhBiA-1
Received: by mail-il1-f197.google.com with SMTP id x2so11323772ilg.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LswxjmRwCl5Y8T8sS8FlN+jFURuk1TQ71z6c49JyB+s=;
        b=qwB0xI+eG99reizoQlJ3nBIiCq4VkF86WXLgFeG+1PTcqHSm018HpLs2OBuIK0T5dP
         83rdMk4ZVoYfdON68BoEhxUzGKM21tdWFADBF2VplzKasHSe+DdO/SaODco9ceg9mS96
         OSsbfYjFZlswHyFmt2U/GVttRrbERlvC1LDZUk3IQTkyXC5r5tiGyANE4MHkykKQLEwK
         JRf39Ko2zFE69GTkwoT7byISClXZs+/dQdof5iReGPEncSCsn8CAr//nCMHXPrHvQmPa
         lxTkr2yYmndyjKVYChb7ofz95r2DyRWoJmMw8HIxwUeRYaqj7jn6bLjglcJzwmELJ1OQ
         P4gw==
X-Gm-Message-State: ANhLgQ39sHLRyx5/mAs7FFuvFnfnTf/KOPlf3NQLP340bOln+u6LCgcz
        PuDQFElSe8U2AxW6uV5TQn9+x1vVPPvM/qdoedHcFeBRkllDetYhql9ctwdB/FgM57g94C9rQOV
        QjDZ/VBkF6ki8uC4+qRgdww96AerUjdxk96ED5ZjW
X-Received: by 2002:a92:41c7:: with SMTP id o190mr26927119ila.11.1584367422523;
        Mon, 16 Mar 2020 07:03:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvRb3fO7kFA2+s96XfnJAV9F+vjv+0Okmgx6390jzYusfpxC+KyIGmoaBsJouTj5ydhlyI4juBVr8dd70uxTnU=
X-Received: by 2002:a92:41c7:: with SMTP id o190mr26927071ila.11.1584367422202;
 Mon, 16 Mar 2020 07:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com>
 <20200315012523.GC208715@linux.intel.com> <CAOASepP9GeTEqs1DSfPiSm9ER0whj9qwSc46ZiNj_K4dMekOfQ@mail.gmail.com>
 <7f9f2efe-e9af-44da-6719-040600f5b351@fortanix.com> <CAOASepNifZdBmg59sJcP1mqSYMW_C=KsdKq-fCmvAU_5iQ9DFw@mail.gmail.com>
 <db12016d-8719-daa0-4742-7d7c43dd464d@fortanix.com>
In-Reply-To: <db12016d-8719-daa0-4742-7d7c43dd464d@fortanix.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Mon, 16 Mar 2020 10:03:31 -0400
Message-ID: <CAOASepNZZ8rGmJNvSdFHbtYpJkfkHp4vAdDFOmR4BcuOcCRgNQ@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        cedric.xing@intel.com, Patrick Uiterwijk <puiterwijk@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Connor Kuehl <ckuehl@redhat.com>,
        Harald Hoyer <harald@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 9:59 AM Jethro Beekman <jethro@fortanix.com> wrote:
>
> On 2020-03-16 14:57, Nathaniel McCallum wrote:
> > On Mon, Mar 16, 2020 at 9:32 AM Jethro Beekman <jethro@fortanix.com> wrote:
> >>
> >> On 2020-03-15 18:53, Nathaniel McCallum wrote:
> >>> On Sat, Mar 14, 2020 at 9:25 PM Jarkko Sakkinen
> >>> <jarkko.sakkinen@linux.intel.com> wrote:
> >>>>
> >>>> On Wed, Mar 11, 2020 at 01:30:07PM -0400, Nathaniel McCallum wrote:
> >>>>> Currently, the selftest has a wrapper around
> >>>>> __vdso_sgx_enter_enclave() which preserves all x86-64 ABI callee-saved
> >>>>> registers (CSRs), though it uses none of them. Then it calls this
> >>>>> function which uses %rbx but preserves none of the CSRs. Then it jumps
> >>>>> into an enclave which zeroes all these registers before returning.
> >>>>> Thus:
> >>>>>
> >>>>>   1. wrapper saves all CSRs
> >>>>>   2. wrapper repositions stack arguments
> >>>>>   3. __vdso_sgx_enter_enclave() modifies, but does not save %rbx
> >>>>>   4. selftest zeros all CSRs
> >>>>>   5. wrapper loads all CSRs
> >>>>>
> >>>>> I'd like to propose instead that the enclave be responsible for saving
> >>>>> and restoring CSRs. So instead of the above we have:
> >>>>>   1. __vdso_sgx_enter_enclave() saves %rbx
> >>>>>   2. enclave saves CSRs
> >>>>>   3. enclave loads CSRs
> >>>>>   4. __vdso_sgx_enter_enclave() loads %rbx
> >>>>>
> >>>>> I know that lots of other stuff happens during enclave transitions,
> >>>>> but at the very least we could reduce the number of instructions
> >>>>> through this critical path.
> >>>>
> >>>> What Jethro said and also that it is a good general principle to cut
> >>>> down the semantics of any vdso as minimal as possible.
> >>>>
> >>>> I.e. even if saving RBX would make somehow sense it *can* be left
> >>>> out without loss in terms of what can be done with the vDSO.
> >>>
> >>> Please read the rest of the thread. Sean and I have hammered out some
> >>> sensible and effective changes.
> >>
> >> I'm not sure they're sensible? By departing from the ENCLU calling convention, both the VDSO
> >> and the wrapper become more complicated.
> >
> > For the vDSO, only marginally. I'm counting +4,-2 instructions in my
> > suggestions. For the wrapper, things become significantly simpler.
> >
> >> The wrapper because now it needs to implement all
> >> kinds of logic for different behavior depending on whether the VDSO is or isn't available.
> >
> > When isn't the vDSO available?
>
> When you're not on Linux. Or when you're on an old kernel.

I fail to see why the Linux kernel should degrade its new interfaces
for those use cases.

