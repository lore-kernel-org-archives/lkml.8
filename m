Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D4C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F07420732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD8A8qgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgDMIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:35:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47085 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgDMIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:35:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id w12so7507682otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AvGw2BENomW5mAjLN7te1eswf7XokhztvBZamCcaYj0=;
        b=uD8A8qgO9EqAhRj5jnTHJFUY7v3Kp1X0ZbRX5+kzzkRJbOVFzZMvIiC0vrd8AEbXu6
         j4U+LKqu1BGr1U7Iyv+gVYNLgnS1VGVayNBYCS2IHfvT2MLP6CobSya5jv/iUGy3TLgI
         nm1wc59YKGg1s266n/VVhr39Z0sn1jSlMGTUPUvRSslX08GMWK3H9oihKMZDUGRoCDcD
         xIAoJTdKpJInqVJYXUnt5AxEf7Yhxw6+V3EFPF7Fd1q8HNMdrOnUyEE4AQi1AgQodiaM
         2vFiaW3n8RvkIVFYrU1b0b3Z7ncEW4wNV2ia112RomwbVmIeuZQ8f08i5g2dGbk/dqaj
         Tb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AvGw2BENomW5mAjLN7te1eswf7XokhztvBZamCcaYj0=;
        b=UDh2hX9CzP6n5IIfoDBKd7M/2LjNWrGYx8xlBcADYKlpMJ5Oi9TiAOwJvclHw0DyWB
         H0SwziWHWMgeDigfDMOtIBQzyRVYHImkBL5CuIHb433s6xxUlbO7bLxt1+2zNEIjVb0p
         NmTSugV6a8l+xF5p5Krmrdc0QxTz6qtAMKOtanuygje6VwKkp3VQtcxCAh2jXd602nfr
         GMLuPN9GAwkeULHX/9aZXj15n7sS42lSwh886SVZFIwGVe/zPZDBqEzfReCIkMuT+1gp
         zlcvGMuiCmTBGmgSR0Zu0e42m0SexpXmLjQjyEv5TN5p4mcrZvERXOppBQ1itraD787b
         Tvpw==
X-Gm-Message-State: AGi0PubItOrbjX0Y/+MNZE0vvGGmMTJmgZS3BduqnYMprELeBE1aWsNd
        snkWPutYlJRlq8Ha+K6emnwjw81Bl15vOxn6o1xpcg==
X-Google-Smtp-Source: APiQypLGyU2+5UH8I4pQFfkdm4IeQucZnCldFkCGft+bJP32qprqeDoFkHg65jEskDU5xzjopyRhE7fXAcHOLPADm9w=
X-Received: by 2002:a9d:4b84:: with SMTP id k4mr3987928otf.233.1586766950301;
 Mon, 13 Apr 2020 01:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
 <AC8A5393-B817-4868-AA85-B3019A1086F9@lca.pw> <CANpmjNPqQHKUjqAzcFym5G8kHX0mjProOpGu8e4rBmuGRykAUg@mail.gmail.com>
 <C4FED226-E3DE-44AE-BBED-2B56B9F5B12F@lca.pw>
In-Reply-To: <C4FED226-E3DE-44AE-BBED-2B56B9F5B12F@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Mon, 13 Apr 2020 10:35:38 +0200
Message-ID: <CANpmjNPSLkiEer3xQHHxJm_4o5Em0i3bvM7TMmNO46Vzv2cwWQ@mail.gmail.com>
Subject: Re: KCSAN + KVM = host reset
To:     Qian Cai <cai@lca.pw>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 21:57, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Apr 10, 2020, at 7:35 AM, Marco Elver <elver@google.com> wrote:
> >
> > On Fri, 10 Apr 2020 at 13:25, Qian Cai <cai@lca.pw> wrote:
> >>
> >>
> >>
> >>> On Apr 10, 2020, at 5:47 AM, Marco Elver <elver@google.com> wrote:
> >>>
> >>> That would contradict what you said about it working if KCSAN is
> >>> "off". What kernel are you attempting to use in the VM?
> >
> > Ah, sorry this was a typo,
> >  s/working if KCSAN/not working if KCSAN/
> >
> >> Well, I said set KCSAN debugfs to =E2=80=9Coff=E2=80=9D did not help, =
i.e., it will reset the host running kvm.sh. It is the vanilla ubuntu 18.04=
 kernel in VM.
> >>
> >> github.com/cailca/linux-mm/blob/master/kvm.sh
> >
> > So, if you say that CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn works, that
> > contradicts it not working when KCSAN is "off". Because if KCSAN is
> > off, it never sets up any watchpoints, and whether or not
> > KCSAN_INTERRUPT_WATCHER is selected or not shouldn't matter. Does that
> > make more sense?
>
> Yes, you are right. CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn does not
> make it work. It was a mistake when I tested it because there was a stale=
 svm.o
> leftover from the previous run, and then it will not trigger a rebuild (a=
 bug?) when
> only modify the Makefile to remove KCSAN_SANITIZE :=3D n. Sorry for the m=
isleading
> information. I should be checking if svm.o was really recompiled in the f=
irst place.
>
> Anyway, I=E2=80=99ll send a patch to add __no_kcsan for svm_vcpu_run() be=
cause I tried
> to narrow down more with a kcsan_[disable|enable]_current() pair, but it =
does NOT
> work even by enclosing the almost whole function below until Marcro has m=
ore ideas?

This is expected. Instrumentation is not removed if you add
kcsan_{disable,enable}_current() (it has the same effect as a
localized "off"). Since it seems just the instrumentation and
associated calls before every memory access is enough, this won't
work. The attribute __no_kcsan removes instrumentation entirely from
the function. If the non-instrumented code should be reduced, it is
conceivable to take the problematic portion of code and factor it into
a function that has attribute '__no_kcsan_or_inline'.

Thanks,
-- Marco

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 2be5bbae3a40..e58b2d5a575c 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3286,6 +3286,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>         svm->vmcb->save.rsp =3D vcpu->arch.regs[VCPU_REGS_RSP];
>         svm->vmcb->save.rip =3D vcpu->arch.regs[VCPU_REGS_RIP];
>
> +       kcsan_disable_current();
>         /*
>          * A vmexit emulation is required before the vcpu can be executed
>          * again.
> @@ -3410,6 +3411,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>                 svm_handle_mce(svm);
>
>         mark_all_clean(svm->vmcb);
> +       kcsan_enable_current();
>  }
>  STACK_FRAME_NON_STANDARD(svm_vcpu_run);
>
>
>
>
>
>
