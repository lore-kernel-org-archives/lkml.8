Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CEBC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAE520838
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581393148;
	bh=SwOJ007DlzVaHhAfxj8kTa2Qa2osckocmYAkhDLCzo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hYrodwzpdahyN0+emBm8nYfnTJeKWENVUs2mDoDQf/f9NcNbVEzmYEkZmyd0XMPbi
	 +wCiAgvwE7SbLeOy5g/OainTRexQRoPu/KcIA5r+wfxEAD8rg/JcWdWHc5PO1SWP7u
	 /Ocx9dBrEgAaH8qnNIkdHImw+iv0YSv5EhYd59es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgBKDw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgBKDw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:52:27 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E590208C3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581393146;
        bh=SwOJ007DlzVaHhAfxj8kTa2Qa2osckocmYAkhDLCzo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X45AOYTK/2z2tJBJ2/KPVqQ75Plm5YduM66SbWef3glBImIIrrgcHzxXyiq04edaS
         cZUxrLhCRvpCatPBYmm+UzMLw7V8YEUMFgs0AOiYvg2d+UWSMqkADFsrC37us26jmo
         BJ/kjXsSKupVKlApw9nMkm7Y0+Pq+P5QOHRJk1Ho=
Received: by mail-wm1-f47.google.com with SMTP id s144so1295212wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 19:52:26 -0800 (PST)
X-Gm-Message-State: APjAAAViEVgs8kTXiUVbo8CzUgt7Ix5KhKjtcQP68Yaftlq2FBcGKDy0
        7ov3uTkBriUgZc+WFC84cAQny79834qT7aK3N3iDAQ==
X-Google-Smtp-Source: APXvYqxgbhqU637eohL+mE8vS87HxSjkCSN70aYM1/0pu6EKsQATjp/v+OfI4bu1ySc4Mfq5i4rBqGuW6P+CNAnBMec=
X-Received: by 2002:a1c:bb82:: with SMTP id l124mr2708818wmf.176.1581393144706;
 Mon, 10 Feb 2020 19:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20200203151608.28053-1-xiaoyao.li@intel.com> <20200203151608.28053-6-xiaoyao.li@intel.com>
 <20200203214300.GI19638@linux.intel.com> <829bd606-6852-121f-0d95-e9f1d35a3dde@intel.com>
 <20200204093725.GC14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200204093725.GC14879@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Feb 2020 19:52:13 -0800
X-Gmail-Original-Message-ID: <CALCETrUAsUzqLhhNkLSC2612odskjqPQvj4uXgBOaoBGoCQD0A@mail.gmail.com>
Message-ID: <CALCETrUAsUzqLhhNkLSC2612odskjqPQvj4uXgBOaoBGoCQD0A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kvm: x86: Emulate MSR IA32_CORE_CAPABILITIES
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 1:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 04, 2020 at 05:19:26PM +0800, Xiaoyao Li wrote:
>
> > > > + case MSR_IA32_CORE_CAPS:
> > > > +         if (!msr_info->host_initiated)
> > >
> > > Shouldn't @data be checked against kvm_get_core_capabilities()?
> >
> > Maybe it's for the case that userspace might have the ability to emulate SLD
> > feature? And we usually let userspace set whatever it wants, e.g.,
> > ARCH_CAPABILITIES.
>
> If the 'sq_misc.split_lock' event is sufficiently accurate, I suppose
> the host could use that to emulate the feature at the cost of one
> counter used.

I would be impressed if the event were to fire before executing the
offending split lock.  Wouldn't the best possible result be for it to
fire with RIP pointing to the *next* instruction?  This seems like it
could be quite confusing to a guest.
