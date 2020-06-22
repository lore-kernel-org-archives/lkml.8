Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2AE20706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0nc5637"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgFVLGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgFVLGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:06:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:06:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k15so12699213otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVCGBNAMVVzJBUyEH8AYaaJuZeDFv/AQspAXfpR7QWs=;
        b=H0nc56373dVnFC0+ikr2sQCUW3pSnEIy19Lc57N1R1+mlC6lUNu5QQPGytZhsXgC7f
         c6Uk3RG80/AsxrGiNe5k//VGeexfUJ264jlYjVOoIG+NxTKBE+lhBVgR/a/XpjmBh1vO
         /mvEhZTrcZNBlPOdxsj6hPKS4fIuxWRF29fs9M4eYDgc6TEbmTSITFQdJnLM770QuTdR
         c91KXzpGjPgaX/ZJo6uxQ4z2MAjuHjSKvZcjDOS9bP3f198zaE1eW0140/qQiNCNazUn
         RJomDJKecJdfe65g/1abkUo1Zl7W+quhWj4+4IwZaYIUHiOxcTzLlE1Af+Uvco54MLIA
         dQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVCGBNAMVVzJBUyEH8AYaaJuZeDFv/AQspAXfpR7QWs=;
        b=faDlJM6+we8ErwyO/xY6myNmR8705ndSEJ4ahHME/P6YYa8zfOet//glvkK4lcyZ3a
         4V/3EX5TDDLDfs7phqWmr/4Vejy+lh76BiP0D1snmAmRhuJ4hGiMdvRRAQgrO4SolTPm
         VKWruM34jN1HwNPGvRckQIF9m9lc9epP2m2oEjAssiMkMtcJXCylMmZ+dcMbHyZzg7oW
         opYtNfI+LEzowc/x2USrPaHUA8s0RV+gzm4gjXl5a3RwG8PQfdyyMhed2JNfHoFSQD3Q
         VAsRnNBBswbtMkOs9kWkubS7FDNe7uXwMqTaphrY+W3Y5abKeQLSvQv7C/8/dnsNOWBh
         5rKQ==
X-Gm-Message-State: AOAM532beEQj00Z7EOP2AVsZ1+gxbJ5zSB0awNx/manI5rC1OUeX0jaK
        00vnyGz2GuS+/YjjMa5/2W7wAGdq+hUTvN4zyieGTw==
X-Google-Smtp-Source: ABdhPJxAl2Be/hK5NnkGkpXO2GQ9KziacpATXhsXKpvvVg2BuS4BDxq29uLM52C/E3EyVpoHnBW9WWKjtAa5gKfsGeQ=
X-Received: by 2002:a9d:638c:: with SMTP id w12mr10791348otk.251.1592823994787;
 Mon, 22 Jun 2020 04:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c25ce105a8a8fcd9@google.com> <20200622094923.GP576888@hirez.programming.kicks-ass.net>
In-Reply-To: <20200622094923.GP576888@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 22 Jun 2020 13:06:23 +0200
Message-ID: <CANpmjNMJL2euWekeJ-pRcW7-BQaDCmfCSr=8Z3Mfnz-ugtUX4g@mail.gmail.com>
Subject: Re: linux-next build error (9)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+dbf8cf3717c8ef4a90a0@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        sean.j.christopherson@intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, vkuznets@redhat.com,
        wanpengli@tencent.com, "the arch/x86 maintainers" <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 at 11:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 22, 2020 at 02:37:12AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    27f11fea Add linux-next specific files for 20200622
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=138dc743100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=41c659db5cada6f4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dbf8cf3717c8ef4a90a0
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+dbf8cf3717c8ef4a90a0@syzkaller.appspotmail.com
> >
> > ./arch/x86/include/asm/kvm_para.h:99:29: error: inlining failed in call to always_inline 'kvm_handle_async_pf': function attribute mismatch
> > ./arch/x86/include/asm/processor.h:824:29: error: inlining failed in call to always_inline 'prefetchw': function attribute mismatch
> > ./arch/x86/include/asm/current.h:13:44: error: inlining failed in call to always_inline 'get_current': function attribute mismatch
> > arch/x86/mm/fault.c:1353:1: error: inlining failed in call to always_inline 'handle_page_fault': function attribute mismatch
> > ./arch/x86/include/asm/processor.h:576:29: error: inlining failed in call to always_inline 'native_swapgs': function attribute mismatch
> > ./arch/x86/include/asm/fsgsbase.h:33:38: error: inlining failed in call to always_inline 'rdgsbase': function attribute mismatch
> > ./arch/x86/include/asm/irq_stack.h:40:29: error: inlining failed in call to always_inline 'run_on_irqstack_cond': function attribute mismatch
> > ./include/linux/debug_locks.h:15:28: error: inlining failed in call to always_inline '__debug_locks_off': function attribute mismatch
> > ./include/asm-generic/atomic-instrumented.h:70:1: error: inlining failed in call to always_inline 'atomic_add_return': function attribute mismatch
> > kernel/locking/lockdep.c:396:29: error: inlining failed in call to always_inline 'lockdep_recursion_finish': function attribute mismatch
> > kernel/locking/lockdep.c:4725:5: error: inlining failed in call to always_inline '__lock_is_held': function attribute mismatch
>
> Hurmph, I though that was cured in GCC >= 8. Marco?

Yeah, time to upgrade syzbot's compiler. This experimental gcc 9.0.0
still has the bug, but stable gcc 9 doesn't. For now, I think this
requires no fixes on the kernel side.

Thanks,
-- Marco
