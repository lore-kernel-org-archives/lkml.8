Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34885C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0486222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCEmacRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBZR1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:27:51 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45045 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgBZR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:27:51 -0500
Received: by mail-wr1-f45.google.com with SMTP id m16so4070376wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Guhz1TvLa+j1kLsI8L+19deSsQysL9993WVY47CsKR0=;
        b=oCEmacRFo+nQYpacfKMzpwTIVY0CzTR7rB6sAB57a3/DesOjLeh4CRwMIfbSeR8FYx
         F1uipdbUYpVCoTJCTXeQ15cNiRG9R4BnexbXkB2FPCLIyrc7ey8cgBnZQ69ivDQM1b4T
         O/vnc3tzeOI+oSnEArvlIU972xBCmVhn/ONkrK+oUrfqV1lXHgGpz0EISocApJHMMHAR
         /FZt9VuPJv6fEwCEVLG2rdwSiIqJ6BLWNo6jn8hyBtOZgkXyov3ntp3uHxZd9nfQxYDA
         fga64Rq72jEGJyzSImRuPiUiAHAxjseokf8Vg6lPOLh6uEl41jbti5UTGMrZOE0SMyUk
         3OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Guhz1TvLa+j1kLsI8L+19deSsQysL9993WVY47CsKR0=;
        b=DAB2b1a0k7EJlEAO75nwblBNCyrtwOpPhvJLZMcp1hKjqykXfsbJYwGa6Mi2GPlFaI
         o6NJXMCIuElTTbqKeaXNxzf/xgRtnAyp61r6faFvb4bpcvd1pCzYl/Fk7Fhx0Y1/f/EF
         hOHLRb30QNXDK2gA2JTKX2MjXudNj344OYNImOwMjEptQSGeOfvG9YcM21AhZpXxsW3M
         09S1mEk7ymwUoihSmMRmVE7f3H97x5I3mIPM6PCn8NJjviYmV3nh/uTZ8du5KHWelvCG
         vFD+zwcm0kaX5MzEnJdHJaUjw8uvPioICGXzq3hE94rQjEMKFx5NoeeueD4LP4apnB3U
         S/lA==
X-Gm-Message-State: APjAAAU9SkmMeQ6pWFuGaACsZtVoJWjYWU6HKRKoJ7Kt1hZHFfsOtNLu
        LDYWRQodBi02a3XkHA3HbZRw3kD2F+FCcg52SUphSA==
X-Google-Smtp-Source: APXvYqzHmLx9ZQhs/7O3StRItypg85pdASnx4KnJ9HvOSboBpJ/tzhf689OmtZAmMBfhASQ3QF1JVNaTwA1NM8OyPsY=
X-Received: by 2002:adf:e40f:: with SMTP id g15mr6482239wrm.223.1582738068080;
 Wed, 26 Feb 2020 09:27:48 -0800 (PST)
MIME-Version: 1.0
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
 <20200221154923.GC194360@google.com> <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com>
 <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
 <CAEE+ybmQb02u-=c1sHozkJ+RXOi2Hno6qYJ0Vx9rOpKjSQ4fPQ@mail.gmail.com> <1089333712.8657.1582736509318.JavaMail.zimbra@efficios.com>
In-Reply-To: <1089333712.8657.1582736509318.JavaMail.zimbra@efficios.com>
From:   Chris Kennelly <ckennelly@google.com>
Date:   Wed, 26 Feb 2020 12:27:36 -0500
Message-ID: <CAEE+ybkTs4U7h-Js818k1QEqpVfHwAHSTXaEwHs3g37LwOsjLQ@mail.gmail.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:01 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Feb 25, 2020, at 10:38 PM, Chris Kennelly ckennelly@google.com wrote:
>
> > On Tue, Feb 25, 2020 at 10:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>
> >> On Fri, Feb 21, 2020 at 11:13 AM Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> >> >
> >> > ----- On Feb 21, 2020, at 10:49 AM, Joel Fernandes, Google
> >> > joel@joelfernandes.org wrote:
> >> >
> >> > [...]
> >> > >>
> >> > >> 3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
> >> > >> registered.
> >> > >>
> >> > >> - Current protocol in the most recent glibc integration patch set.
> >> > >> - Not supported yet by Linux kernel rseq selftests,
> >> > >> - Not supported yet by tcmalloc,
> >> > >>
> >> > >> Use the per-thread state to figure out whether each thread need to register
> >> > >> Rseq individually.
> >> > >>
> >> > >> Works for integration between a library which exists for the entire lifetime
> >> > >> of the executable (e.g. glibc) and other libraries. However, it does not
> >> > >> allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
> >> > >> having a library like glibc handling the registration present.
> >> > >
> >> > > Mathieu, could you share more details about why during dlopen/close
> >> > > libraries we cannot use the same __rseq_abi TLS to detect that rseq was
> >> > > registered?
> >> >
> >> > Sure,
> >> >
> >> > A library which is only loaded and never closed during the execution of the
> >> > program can let the kernel implicitly unregister rseq at thread exit. For
> >> > the dlopen/dlclose use-case, we need to be able to explicitly unregister
> >> > each thread's __rseq_abi which sit in a library which is going to be
> >> > dlclose'd.
> >>
> >> Mathieu, Thanks a lot for the explanation, it makes complete sense. It
> >> sounds from Chris's reply that tcmalloc already checks
> >> __rseq_abi.cpu_id and is not dlopened/closed. Considering these, it
> >> seems to already handle things properly - CMIIW.
> >
> > I'll make a note about this, since we can probably benefit from some
> > more comments about the assumptions/invariants the fastpath uses.
>
> I suspect the integration with glibc and with dlopen'd/dlclose'd libraries will not
> behave correctly with the current tcmalloc implementation.
>
> Based on the tcmalloc code-base, InitFastPerCpu is only called from IsFast. As long
> as this is the only expected caller, having IsFast comparing the RseqCpuId detects
> whether glibc (or some other library) has already registered rseq for the current
> thread.
>
> However, if the application chooses to invoke InitFastPerCpu() directly, things become
> expected, because it invokes:
>
>   absl::base_internal::LowLevelCallOnce(&init_per_cpu_once, InitPerCpu);
>
> which AFAIU invokes InitPerCpu once after execution of the current program. Which
> does:
>
> static bool InitThreadPerCpu() {
>   if (__rseq_refcount++ > 0) {
>     return true;
>   }
>
>   auto ret = syscall(__NR_rseq, &__rseq_abi, sizeof(__rseq_abi), 0,
>                      PERCPU_RSEQ_SIGNATURE);
>   if (ret == 0) {
>     return true;
>   } else {
>     __rseq_refcount--;
>   }
>
>   return false;
> }
>
> static void InitPerCpu() {
>   // Based on the results of successfully initializing the first thread, mark
>   // init_status to initialize all subsequent threads.
>   if (InitThreadPerCpu()) {
>     init_status = kFastMode;
>   }
> }
>
> In a scenario where glibc has already registered Rseq, the __rseq_refcount will
> be incremented, the __NR_rseq syscall will fail with -1, errno=EBUSY, so the refcount
> will be immediately decremented and it will return false. Therefore, "init_status" will
> never be set fo kFastMode, leaving it in kSlowMode for the entire lifetime of this
> program. That being said, even though this state can come as a surprise, it seems to
> be entirely bypassed by the fast-paths IsFast() and IsFastNoInit(), so maybe it won't
> have any observable side-effects other than leaving init_status in a state that does not
> match reality.

I agree that this could potentially violate inviarants, but
InitFastPerCpu is not intended to be called by the application.

> In the other use-case where tcmalloc co-exist with a dlopened/dlclosed library, but glibc
> does not provide Rseq registration, we run into issues as well if the dlopened library
> registers rseq first for a given thread. The IsFastNoInit() expects that if Rseq has been
> observed as registered in the past for a thread, it stays registered. However, if a
> dlclosed library unregisters Rseq, we need to be prepared to re-register it. So either
> tcmalloc needs to express its use of Rseq by incrementing __rseq_refcount even when Rseq
> is registered (this would hurt the fast-path however, and I would hate to have to do this),
> or tcmalloc needs to be able to handle the fact that Rseq may be unregistered by a dlclosed
> library which was the actual owner of the Rseq registration.

We have a bit of an opportunity to figure out whether this is the
first time--from TCMalloc's perspective--a thread is doing per-CPU and
bump the __rseq_count accordingly.  I think this could be done off of
the fast path.

Chris
