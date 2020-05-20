Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD27207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ivjriBhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgETUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgETUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:14:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609DCC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:14:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so2096035pfw.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jNCjRptabh6f7dGyAbYdK74F2n0Wz/7WyriwNjKrYLo=;
        b=ivjriBhPfAPW1WSo2qqkeu94jowUi6nmAulGkKdEMSYXycw4lYLpAifIExWjnM04yR
         f7kqfS1Sax+wy0NqUUYQAT14DdKtsrsgZagfy1LYait88OZadQFM6NFX791z9ql3WjM/
         mf5LF1IJ6f2yEHzlZuJagXi0OB10O2PNJrinD4zMF+/529iQ1+la1L1DuFkkMPiggGu/
         GDzeTddXQ0mBYAIWTfn7q75JsrjVBqw+flSsCnjnmXplGveBSXePO/IsSumKp1vLgurJ
         PbD5Sd3csw1XvTq5DmIZx8qYkdi3nqfoXof/Gonqg0AUudeQjADtHY+2AMKsi2vPGw08
         esUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jNCjRptabh6f7dGyAbYdK74F2n0Wz/7WyriwNjKrYLo=;
        b=QeqQmT3wjPqqB+u5UrDQ20uGy3/zf99RpmcgWH1TWNQQjBCIba8hPz7H1mW7WgKjV5
         FZQs2JgsN1aNuntfEIW8sgJGI/96V93ATGZE9iJNWQp8cpxBrAgOeqkkD76P4x2zQoEH
         CCmQH9Q1QLXUchHKrVetVLVqlieJEWgFAuX9+VgpS9cy3IhuXL6/ljqunn4bHU1nR1F+
         4sULI+5zi8KOJ0us0CZte5Dg1M7gAg/pTysGGhmXX5w5aOEy1d+CMctDkp/rqlXGk9Q8
         E8KutEcqSqM1S3Et4tfUrEL5pklDAXEJesm4BSzJutI/9Zuqkv0sK+VJ/Ka/V3tsbh99
         EHSA==
X-Gm-Message-State: AOAM530U7F4NTtKP/IuDRsG+FA2q9aLskdh9vsb43+RJsJXgZQw/evCI
        +WmqcuNLF4OB5Q5V5OBLNAtHTg==
X-Google-Smtp-Source: ABdhPJwQD66fWw4jqXZFOBJQ5H67GaEvcINWX0bzqGyZnVwJWLwMcccoKTBmcqopAvoL+DN3pcG0cA==
X-Received: by 2002:a62:2f43:: with SMTP id v64mr5848809pfv.170.1590005650687;
        Wed, 20 May 2020 13:14:10 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6953:ad9a:addc:d616? ([2601:646:c200:1ef2:6953:ad9a:addc:d616])
        by smtp.gmail.com with ESMTPSA id d2sm2730544pfa.164.2020.05.20.13.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:14:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
Date:   Wed, 20 May 2020 13:14:07 -0700
Message-Id: <CF349A31-C401-4684-BA34-CD3359AF34E7@amacapital.net>
References: <87imgqv055.fsf@nanos.tec.linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
In-Reply-To: <87imgqv055.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 20, 2020, at 1:10 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFPeter Zijlstra <peterz@infradead.org> writes:
>>> On Mon, May 18, 2020 at 10:05:56AM +0200, Thomas Gleixner wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>> On Sat, May 16, 2020 at 01:45:51AM +0200, Thomas Gleixner wrote:
>>>>> --- a/arch/x86/kernel/nmi.c
>>>>> +++ b/arch/x86/kernel/nmi.c
>>>>> @@ -334,6 +334,7 @@ static noinstr void default_do_nmi(struc
>>>>>    __this_cpu_write(last_nmi_rip, regs->ip);
>>>>>=20
>>>>>    instrumentation_begin();
>>>>> +    ftrace_nmi_handler_enter();
>>>>>=20
>>>>>    handled =3D nmi_handle(NMI_LOCAL, regs);
>>>>>    __this_cpu_add(nmi_stats.normal, handled);
>>>>> @@ -420,6 +421,7 @@ static noinstr void default_do_nmi(struc
>>>>>        unknown_nmi_error(reason, regs);
>>>>>=20
>>>>> out:
>>>>> +    ftrace_nmi_handler_exit();
>>>>>    instrumentation_end();
>>>>> }
>>>>=20
>>>> Yeah, so I'm confused about this and the previous patch too. Why not
>>>> do just this? Remove that ftrace_nmi_handler.* crud from
>>>> nmi_{enter,exit}() and stick it here? Why do we needs the
>>>> nmi_{enter,exit}_notrace() thing?
>>>=20
>>> Because you then have to fixup _all_ architectures which use
>>> nmi_enter/exit().
>>=20
>> We probably have to anyway. But I can do that later I suppose.
>=20
> Second thoughts. For #DB and #INT3 we can just keep nmi_enter(), needs
> just annotation in nmi_enter() around that trace muck.
>=20
> For #NMI and #MCE I rather avoid the early trace call and do it once we
> have reached "stable" state, i.e. avoid it in the whole nested NMI mess.
>=20
>=20

What=E2=80=99s the issue?  The actual meat is mostly in the asm for NMI, and=
 for MCE it=E2=80=99s just the sync-all-the-cores thing. The actual simultan=
eous NMI-and-MCE case is utterly busted regardless, and I=E2=80=99ve been th=
inking about how to fix it. It won=E2=80=99t be pretty, but nmi_enter() will=
 have nothing to do with it.=
