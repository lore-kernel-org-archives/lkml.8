Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC296C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB94206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0LF9JZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgF2TIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbgF2THm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:07:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2824FC030797
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:30:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 67so3979831pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RINlcGid5tXT6CMl/BlaGcdBBeQoedzncf8Z81bYVn4=;
        b=i0LF9JZFTGzzv7lTaYor27wrc3CqWqL6t0x5gXJZ6Y8AaiN61bQFr/vEt1YS4vpjBh
         ZJy1GQ25jEKV4+t4xZ2mmLkIiuvnSeSFqy5xLwCg3OqqvA0KDAFT5FahZWc28O+iAaXm
         GLz+IoDWWi+4SRM4AvqycRFfWwj1l85/0V6Uaa56Fw6or84p8aakaN7zkJ/pd0n9HXkr
         gUFqCAy6UHguTi3MWm02pdmN4a/fi63iYkBHH+Ak2kKyBP38CcpqqcboLUqNlqTYfhoI
         Xv6JpL9Diez6KUb7L1xVv8NnKTifXbGnpKTh7zTJ5VHnru/49qRhQq83se3YgEtj6JaB
         j4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RINlcGid5tXT6CMl/BlaGcdBBeQoedzncf8Z81bYVn4=;
        b=M/jFaBosIbR8xEr4PiMMdijGw3Qkzapanp9YPvczZPRyjUFT1bnTeITT0ElJ4vM2dk
         i4/6Py6GG+FK8Dome29e0OqEVmQqHVXTY1Qsz1Qee8su+gvixjHeqGzdBKltIx1nZeR4
         BFfv1BZK3blCRHNYNo8VUpgoNbnulKIVcOItqa5OBK3LlEwGduxc8FQX7Xp2iYUIrFVe
         n9wj+1aWzIrYTAjrVCKLwFx3Ero9vuSScBhIqTrCVxkmNJsdo7z5if2JjbU37Tv+TsxS
         miAQ7vFSyMhMfErXpjN6mEbxr7us0WX8kMSQjZlK4u5rp+6PNf2CHJcWVIhfLt4dRqST
         Hkbw==
X-Gm-Message-State: AOAM5306+cWnPSS5I4bWF01Cc+3zcMTmYHetMZpPwnh3NomB77pVAIyx
        9mnXrWkX7Z7VFc2Czd74yeiJWFGDPjDKAhBE5lqRsDYh
X-Google-Smtp-Source: ABdhPJwfpJYt2qU20jxd82u9P3QAka3swGqHWthAfqRJWH4hTciAhSPMM+mylgMCCkgqbZ5mAeN6Tzgf1SCq6Z3QnEc=
X-Received: by 2002:aa7:98c1:: with SMTP id e1mr15668859pfm.318.1593444607274;
 Mon, 29 Jun 2020 08:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a0784a05a916495e@google.com> <04786ba2-4934-c544-63d1-4d5d36dc5822@redhat.com>
In-Reply-To: <04786ba2-4934-c544-63d1-4d5d36dc5822@redhat.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 29 Jun 2020 17:29:56 +0200
Message-ID: <CAAeHK+yPbp_e9_DfRP4ikvfyMcfaveTwoVUyA+2=K3g+MvW-fA@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds Read in kvm_arch_hardware_setup
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     syzbot <syzbot+e0240f9c36530bda7130@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>, joro@8bytes.org,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        sean.j.christopherson@intel.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, vkuznets@redhat.com,
        wanpengli@tencent.com, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 5:25 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The reproducer has nothing to do with KVM:
>
>         # https://syzkaller.appspot.com/bug?id=c356395d480ca736b00443ad89cd76fd7d209013
>         # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
>         #{"repeat":true,"procs":1,"sandbox":"","fault_call":-1,"close_fds":false,"segv":true}
>         r0 = openat$fb0(0xffffffffffffff9c, &(0x7f0000000180)='/dev/fb0\x00', 0x0, 0x0)
>         ioctl$FBIOPUT_VSCREENINFO(r0, 0x4601, &(0x7f0000000000)={0x0, 0x80, 0xc80, 0x0, 0x2, 0x1, 0x4, 0x0, {0x0, 0x0, 0x1}, {0x0, 0x0, 0xfffffffc}, {}, {}, 0x0, 0x40})
>
> but the stack trace does.  On the other hand, the address seems okay:
>
>         kvm_cpu_caps+0x24/0x50
>
> and there are tons of other kvm_cpu_cap_get calls that aren't causing
> KASAN to complain.  The variable is initialized from
>
>         kvm_arch_hardware_setup
>           hardware_setup (in arch/x86/kvm/vmx/vmx.c)
>             vmx_set_cpu_caps
>               kvm_set_cpu_caps
>
> with a simple memcpy that writes the entire array.  Does anyone understand
> what is going on here?

Most likely a bug in /dev/fb handlers caused a memory corruption in
kvm related memory.

>
> Paolo
>
> On 27/06/20 22:01, syzbot wrote:
> > BUG: KASAN: out-of-bounds in kvm_cpu_cap_get arch/x86/kvm/cpuid.h:292 [inline]
> > BUG: KASAN: out-of-bounds in kvm_cpu_cap_has arch/x86/kvm/cpuid.h:297 [inline]
> > BUG: KASAN: out-of-bounds in kvm_init_msr_list arch/x86/kvm/x86.c:5362 [inline]
> > BUG: KASAN: out-of-bounds in kvm_arch_hardware_setup+0xb05/0xf40 arch/x86/kvm/x86.c:9802
> > Read of size 4 at addr ffffffff896c3134 by task syz-executor614/6786
> >
> > CPU: 1 PID: 6786 Comm: syz-executor614 Not tainted 5.7.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1e9/0x30e lib/dump_stack.c:118
> >  print_address_description+0x66/0x5a0 mm/kasan/report.c:383
> >  __kasan_report mm/kasan/report.c:513 [inline]
> >  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
> >  kvm_cpu_cap_get arch/x86/kvm/cpuid.h:292 [inline]
> >  kvm_cpu_cap_has arch/x86/kvm/cpuid.h:297 [inline]
> >  kvm_init_msr_list arch/x86/kvm/x86.c:5362 [inline]
> >  kvm_arch_hardware_setup+0xb05/0xf40 arch/x86/kvm/x86.c:9802
> >  </IRQ>
> >
> > The buggy address belongs to the variable:
> >  kvm_cpu_caps+0x24/0x50
> >
> > Memory state around the buggy address:
> >  ffffffff896c3000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffffffff896c3080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> ffffffff896c3100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                                         ^
> >  ffffffff896c3180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffffffff896c3200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/04786ba2-4934-c544-63d1-4d5d36dc5822%40redhat.com.
