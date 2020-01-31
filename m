Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B24DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2C6214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580493719;
	bh=HzftWgsZk32yiP3RQKMKd1EJd7vGrGpUwuuxUtZOOJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QO84k5v0Zv8TSkS51Ey3cizem6PjWx7o1mSHS5JGES5uCev1U5OrWQ1WYWgbFMPAe
	 LC2lk0676TxSd7K2poPxwmf/hqlrtzun7clkAIwQGHFIyOnd99uNW4dthsAkoS8AAm
	 W9miEk+iaJmZmYaxKg+njV2GnI2512jrvADhEejU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAaSB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:01:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43838 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgAaSB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:01:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so5473247lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9j/+yOHRUYs86/r1vUBwGlUumkt31a+ZC51irf1zwo=;
        b=D9gep9Su+ciFsa7BYxm54ROJPrkIkuAtNGvFFM0CHhn8lLDZwftjQmXQrAcYf+J5GE
         y5q/J6r9VpK0aNs1wGqnQ3vuOS6I79HcguOHRwiQZ7YGR5sIFAs1gaICq2ZZ9TzJ9r+A
         Tsy00vCgGmCl5idF1c6WC4PhCg2ur+3fvg0Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9j/+yOHRUYs86/r1vUBwGlUumkt31a+ZC51irf1zwo=;
        b=M9zR+rkk/MyKctOgevFLjNFYCfpWij06DHSkMGdo10qCSLhKHboW88vfiFaLrgo3ZU
         p4TC5sWq+D84Srgd+eKjL8NQ7kNVahBm7cUr8NHqGyizAeVZMOboqwxMzZ2sAhZ4OLCd
         YIH2zKcDjfXlsAcHpfg2SMZeZJucxEHtFOjjIMfxhTg2qHh2APgniDUGND0gujHM+BYh
         n5XqUxjTldKSkK/jMgi26ZbNb89Wyox9mSMKXY99OxJMQ/0+DUJn4MnPfGYxZ5IjYqug
         xJdkLCsFv8rvjbXWego0lWNwJcId42pbyDuaZiJRvhZXUfsAO/siU+shm3/rqGI3ysf+
         u3dw==
X-Gm-Message-State: APjAAAUEipqiq3fVCzeVGMewQKKVaZX/1/WaJPiblHrJvpKqcqQqtOfK
        Rj7t5b9jICDXea7QHHl3chVBMRj1ArA=
X-Google-Smtp-Source: APXvYqxiFUDB6uKrxfbRHTSJhN6eb9hdpFAmbeEAAbfPes/6itUd0uBtdDnKxOgSbV1Pg81RY1dmGw==
X-Received: by 2002:ac2:4a89:: with SMTP id l9mr6005589lfp.121.1580493715644;
        Fri, 31 Jan 2020 10:01:55 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 126sm4919752lfm.38.2020.01.31.10.01.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 10:01:54 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id b15so5507987lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:01:54 -0800 (PST)
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr6129965lfl.125.1580493713847;
 Fri, 31 Jan 2020 10:01:53 -0800 (PST)
MIME-Version: 1.0
References: <1580408442-23916-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1580408442-23916-1-git-send-email-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Jan 2020 10:01:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZTUq8u0HZUJ1mKZjb-haBFhX+mKcUv3Kdh9LQb8rg4g@mail.gmail.com>
Message-ID: <CAHk-=wjZTUq8u0HZUJ1mKZjb-haBFhX+mKcUv3Kdh9LQb8rg4g@mail.gmail.com>
Subject: Re: [GIT PULL] First batch of KVM changes for 5.6 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 10:20 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Xiaoyao Li (3):
>       KVM: VMX: Rename INTERRUPT_PENDING to INTERRUPT_WINDOW
>       KVM: VMX: Rename NMI_PENDING to NMI_WINDOW
>       KVM: VMX: Fix the spelling of CPU_BASED_USE_TSC_OFFSETTING

So in the meantime, on the x86 merge window side, we have this:

  b39033f504a7 ("KVM: VMX: Use VMX_FEATURE_* flags to define VMCS control bits")

and while the above results in a conflict, that's not a problem. The
conflict was trivial to fix up.

HOWEVER.

It most definitely shows that the above renaming now means that the
names don't match. It didn't match 100% before either, but now the
differences are even bigger. The VMX_FEATURE_xyz bits have different
names than the CPU_BASED_xyz bits, and that seems a bit questionable.

So I'm not convinced about the renaming. The spelling fix is good: it
actually now more closely resembles the VMCS_FEATURE bit that already
had OFFSETTING with two T's.

But even that one isn't really the same even then. The CPU_BASED_xyz
thing has "USE_TSC_OFFSETTING", while the VMCS_FEATURE_xyz bit doesn't
have the "USE" part.

And the actual renaming means that now we basically have

  CPU_BASED_INTR_WINDOW_EXITING
  VMX_FEATURE_VIRTUAL_INTR_PENDING

and

  CPU_BASED_NMI_WINDOW_EXITING
  VMX_FEATURE_VIRTUAL_NMI_PENDING

for the same bit definitions (yeah, the VMX_FEATURE bits obviously
have the offset in them, so it's not the same _value_, but it's a 1:1
relationship between them).

There are other (pre-existing) differences, but while fixing up the
merge conflict I really got the feeling that it's confusing and wrong
to basically use different naming for these things when they are about
the same bit.

I don't care much which way it goes (maybe the VMX_FATURE_xyz bits
should be renamed instead of the other way around?) and I wonder what
the official documentation names are? Is there some standard here or
are people just picking names at random?

The two commits both came from intel.com addresses, so hopefully there
can be some intel-sanctioned resolution on the naming? Please?

Hmm?

                  Linus
