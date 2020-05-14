Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA588C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B534D206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="N/e/huZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgENQTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgENQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:19:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D172C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:19:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so1518458pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3+sj8Y+Mzr1j1P1P/nbqTLTnFDHWmPPgkXsU5sEA7Z8=;
        b=N/e/huZ6btUGYbWK1Tar6juPyELlg9sZ9YtRRal5GmqUMsDO/Mloqv4TFysMyTjTyy
         62QCf5P/CY2DJxug8jwaBKL0x9IMlPVit5iQH/1ZudG588GT/6bSjfycVeYHJrLDHF7L
         92DrI/LQKeEAF4/QEXTpnyLMUmxQt4b7ibnVrgfCyjshxsQLDYqvSgRivW1oyOOQ2OCz
         o66caulfTHMSzE1CdY4vORB9FfkbIgllPBI+rfpEKgteFWSrwpcDujCgH8JUdGk8L0J1
         7WMAYCuK3DkdQfb7dWsBWdSmzhdTgTq7ufA/Oyblna/o4/Ob055EmiPk3qPOENDlyfrZ
         8eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3+sj8Y+Mzr1j1P1P/nbqTLTnFDHWmPPgkXsU5sEA7Z8=;
        b=F6eVnyNBwjueO5x3iKXS631XXDzQvqcqwBT82ofJJNav2dIh9VsOfz2C0EconJSMZn
         L3bKoeL1tQh3KnTntCPMmB0HIePl047XHwwzwxuE48J5My9aG0othKbDdriiMFbiGIhg
         aQbTh0ekvvHtT2CrHDJoFetuW8ahS7F+BttmXxdfFdchLLhA00X4i14sUmtew4iTl9Zo
         pXv3ioFpuJ//N8zcvFvEePjkH87xEMI9OHsUirP6+Yv9Dg0gAC/uVPVJ2GLPj17EbDpb
         C8N3R7wfGpRUngMXHeekhWpKn5PjjKffy40q0x4a7bz6HVh/ZciZK/TO5BexkAIDptFf
         UDxQ==
X-Gm-Message-State: AOAM533h7MqOkxnuTWGFzEGZD7AtPMsnS1RVbj/UowN7CqMr+64TlONQ
        7ICFe8lg8HFO3ZukuIsKYdSkyw==
X-Google-Smtp-Source: ABdhPJySVoFGAIOBhD0O2omMuSmdS5yCUPdhxrrL0m5SdSFTjytVpC1OjgYFTKmT9z67J0FdacOhDA==
X-Received: by 2002:a62:34c1:: with SMTP id b184mr5032916pfa.73.1589473175462;
        Thu, 14 May 2020 09:19:35 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1c47:1b32:8edf:77f5? ([2601:646:c200:1ef2:1c47:1b32:8edf:77f5])
        by smtp.gmail.com with ESMTPSA id c2sm2712246pfp.118.2020.05.14.09.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 09:19:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
Date:   Thu, 14 May 2020 09:19:32 -0700
Message-Id: <19476304-8EA8-4B68-9894-3056308035EE@amacapital.net>
References: <1278452779.21179.1589472210183.JavaMail.zimbra@efficios.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>
In-Reply-To: <1278452779.21179.1589472210183.JavaMail.zimbra@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 14, 2020, at 9:03 AM, Mathieu Desnoyers <mathieu.desnoyers@efficios=
.com> wrote:
>=20
> =EF=BB=BF----- On May 14, 2020, at 10:17 AM, Borislav Petkov bp@alien8.de w=
rote:
>=20
>> + Tony.
>>=20
>>> On Tue, May 05, 2020 at 03:16:31PM +0200, Thomas Gleixner wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>
>>>=20
>>> Convert #MC over to using task_work_add(); it will run the same code
>>> slightly later, on the return to user path of the same exception.
>>>=20
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>>> ---
>>> arch/x86/kernel/cpu/mce/core.c |   56 ++++++++++++++++++++++------------=
-------
>>> include/linux/sched.h          |    6 ++++
>>> 2 files changed, 37 insertions(+), 25 deletions(-)
>>=20
>> I like this:
>>=20
>> Reviewed-by: Borislav Petkov <bp@suse.de>
>=20
> What I am not fully grasping here is whether this patch preserves the inst=
ruction
> pointer (and possibly other relevant information for siginfo_t) triggering=
 the
> exception in a scenario where we have:
>=20
> - #MC triggered, queuing task work,
> - unrelated signal happens to be delivered to task,
> - exit to usermode loop handles do_signal first,
> - then it runs task work.

If anyone wants to ponder this, I suspect that we have lots of delightful bu=
gs in our handling of cr2, trapnr, and error_code in signals. We should move=
 them to the sigcontext, at least in kernel, and fix up ucontext when we del=
iver the signal.  The current code can=E2=80=99t possibly be correct.=
