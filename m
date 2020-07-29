Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E4DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030B220663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtI4IXDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgG2AgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgG2AgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:36:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F8C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:36:13 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z17so2779147ill.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRha7jx49vrjhrwihmHUXl2bsb7CryChoPGMp67OlAw=;
        b=dtI4IXDysOcFC/8Nn9kbGIJx8CkV8yny9ilR/JCriJ2AR5gSdfBgPpMAD00wdPRO6H
         L8S3BPEYoNMQ/7rRAOlw1NHrWUlT4oIFXSsYwVeUkzVXPUgmMp6yLsxPx8HPjVV6cgmR
         5nrgsvlPVycdtpSpo/oPf+FCI8uMnMoY8j/P4FGzQoaCBDz6Mb2dlmJ+8c30IDESYQ30
         VnYypXUdoRyd+Bh9wgwHd4/9UXn5x8wggykc1kjWbd0p+f3qSUqDZsVkGboorFgioN8/
         YE9mKmxzb9DTEjhyDEOIPukQtWBfIxVQ15bsQQcFQSnpIVqumXnGuHAGUQkjvp/PmCIS
         erZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRha7jx49vrjhrwihmHUXl2bsb7CryChoPGMp67OlAw=;
        b=MvMsyd2O7gnIh0HBWuJebklWTZW8YLkmw9h0Ft/YAhXX45/VZ05uiTzrlhcJir+iLY
         w7tiwGlUDShHVFq4dDgS5LSfLAfCWo9XODKwRCqy58pLy38l4PYw6e1XxFu/79wwdtRI
         AQSnHD1+nhlH4ul5WurcncfSBcUMOuUU0ZuOaWLrN1igR0nIjqhAVRNIjdpZAwoJPtIH
         /fNZqpUb6qkCltDD+NZGSeId5wkldTDa53TrG3u8Z5BtmCGzV6ARBjKGUhHTDqhsnJPy
         FizTypupaHGhKeNUzCUmhKNtSLQTQlaQglVTPNvoZA7rJfDOpmfhulrGO+A5pziNg6dh
         hXMQ==
X-Gm-Message-State: AOAM5322UnPhMvmXcJzZLAq+sxaqPkuG+UFiSwvgj7oYhh0+t2uJuShq
        IxoijpYHh3JA24Dph2+WpdnPLC5UuvHE2KKANsw=
X-Google-Smtp-Source: ABdhPJx1DQhprwHauoyDTT+d1sX5JoIv5bEBP1mV9sxP6lbj+CQQNZm1ah0gakcc5f0T0bNRKsU4wHjWIOXuVutaWR8=
X-Received: by 2002:a05:6e02:e89:: with SMTP id t9mr28352221ilj.292.1595982973064;
 Tue, 28 Jul 2020 17:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <c2bfe1aa390777b10d810d2b76a35b97fbd32a1c.camel@intel.com>
 <CALCETrUBDUKTcmmYD7BpZkL3869ELvha1PqOcScw4M-B_DQdiA@mail.gmail.com>
 <7653c6c74a4eee18b8bdc8262e0c0b5b95f9d771.camel@intel.com>
 <d4b9d6a1-d413-b044-1d4a-512bbbf06d78@intel.com> <14f3bee7569f229541852f61f0a1a88fcdec7249.camel@intel.com>
In-Reply-To: <14f3bee7569f229541852f61f0a1a88fcdec7249.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 28 Jul 2020 17:35:37 -0700
Message-ID: <CAMe9rOr=WsOnKk3x8AK-iB5JLCjJ7FaDKXsFp01+3BbJvLZqMA@mail.gmail.com>
Subject: Re: Random shadow stack pointer corruption
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 4:35 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Sat, 2020-07-18 at 15:41 -0700, Dave Hansen wrote:
> > On 7/18/20 11:24 AM, Yu-cheng Yu wrote:
> > > On Sat, 2020-07-18 at 11:00 -0700, Andy Lutomirski wrote:
> > > > On Sat, Jul 18, 2020 at 10:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > > > Hi,
> > > > >
> > > > > My shadow stack tests start to have random shadow stack pointer corruption after
> > > > > v5.7 (excluding).  The symptom looks like some locking issue or the kernel is
> > > > > confused about which CPU a task is on.  In later tip/master, this can be
> > > > > triggered by creating two tasks and each does continuous
> > > > > pthread_create()/pthread_join().  If the kernel has max_cpus=1, the issue goes
> > > > > away.  I also checked XSAVES/XRSTORS, but this does not seem to be an issue
> > > > > coming from there.
> > > >
> > > > What do you mean "shadow stack pointer corruption"?  Is SSP itself
> > > > corrupt while running in the kernel?  Is one of the MSRs getting
> > > > corrupted?  Is the memory to which the shadow stack points getting
> > > > corrupted? Is the CPU rejecting an attempt to change SSP?
> > >
> > > What I see is, a new thread after ret_from_fork() and iret back to ring-3,
> > > its shadow stack pointer (MSR_IA32_PL3_SSP) is corrupted.
> >
> > Does corrupt mean random?  Or is it a valid stack address, just not for
> > _this_ thread?  Or NULL?  Or is it a kernel address?  Have you tried
> > tracing *ALL* the WRMSR's and XRSTOR's that write to the MSR?
>
> When a shadow stack address is changed, the address appears to be other task's.
> I traced all WRMSR's and XRSTOR's.  I also verified there have not been any
> XRSTORS from a wrong buffer.  When rc6 is tagged, I will re-base, test, and
> share current patches.
>

We have identified that

ommit 91eeafea1e4b7c95cc4f38af186d7d48fceef89a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu May 21 22:05:28 2020 +0200

    x86/entry: Switch page fault exception to IDTENTRY_RAW

    Convert page fault exceptions to IDTENTRY_RAW:

      - Implement the C entry point with DEFINE_IDTENTRY_RAW
      - Add the CR2 read into the exception handler
      - Add the idtentry_enter/exit_cond_rcu() invocations in
        in the regular page fault handler and in the async PF
        part.
      - Emit the ASM stub with DECLARE_IDTENTRY_RAW
      - Remove the ASM idtentry in 64-bit
      - Remove the CR2 read from 64-bit
      - Remove the open coded ASM entry code in 32-bit
      - Fix up the XEN/PV code
      - Remove the old prototypes

    No functional change.

triggered the shadow stack corruption when the process returned from syscall.
SSP MSR somehow was changed between setting SSP MSR and IRET.    Could
there be a page fault between setting SSP MSR and IRET?

-- 
H.J.
