Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A88DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D5B20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589989033;
	bh=NQCDMUqiaub1mXRPCEgRga1C7/0ZUzFHfp/sg9QVQJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=co+YruFQY4ZSOlNJ2LTdFshUHGoqb8NsM1tMeWLJ5P8UX/NpFEiUZh8TJKf96X6ti
	 YEhNLivHQ4SQRJnw96PoYeSZSBoFvNXuUTEk6eHG/CLSrYxOEtt5is9WYt59e6pfHg
	 Y0YkhyWqtHjg/Qdd37XJP5ixKwhA5AD2XAuzNHvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgETPhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgETPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:37:11 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF82207D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589989031;
        bh=NQCDMUqiaub1mXRPCEgRga1C7/0ZUzFHfp/sg9QVQJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qF9kbF6vOy7wFNiFqQG5IS3CN7yQFSrgDbocXaC+wn1S6gEm6HK+JzKzpDc0yMRuw
         R3rcdh5fcpEQPiTyAE6KXCXPafG2tp8nHfrCnPy8d6UFzgbD9wsUDvmlQsZDMepveR
         lg3RGgYPNWjaTxvbtb7CYiHLeHEEosBjBZunc6Rk=
Received: by mail-wm1-f42.google.com with SMTP id z4so2945318wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:37:10 -0700 (PDT)
X-Gm-Message-State: AOAM533WMleeSqj2y89654K3F9qY/+SnXpAh9nz2SPU/B8lr9rQ0hrJk
        Mbomtcwnr66wokN5Z+hwIrC/t9wpOBG15OLe6zJhJg==
X-Google-Smtp-Source: ABdhPJzQpqKZzQ589viMluBBwwkwkCfLnrvunaotI5eaBweAGgtoHlO7TXc5jEQvOuLCwKluj5CADfK6UEGdwRuJmBo=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr5161810wmf.138.1589989029194;
 Wed, 20 May 2020 08:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.110889386@linutronix.de>
 <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com>
 <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com>
 <87o8qkvm03.fsf@nanos.tec.linutronix.de> <CALCETrX4p71MyQHfUUCBWh8LicewyyVNj7T5mOmZevND2vvqoQ@mail.gmail.com>
 <871rne6ayr.fsf@nanos.tec.linutronix.de> <CALCETrW5uHQGLRyA8_JZ6Xv95Ui8g4OdrjCViWMVcG2W5B1cWg@mail.gmail.com>
 <87d06ywrsf.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d06ywrsf.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 08:36:57 -0700
X-Gmail-Original-Message-ID: <CALCETrUTqiTjap72M3jENVOAs0m9G7tcbf++Mn-qiVmZXQ0eqA@mail.gmail.com>
Message-ID: <CALCETrUTqiTjap72M3jENVOAs0m9G7tcbf++Mn-qiVmZXQ0eqA@mail.gmail.com>
Subject: Re: [patch V6 07/37] x86/entry: Provide helpers for execute on irqstack
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 8:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Wed, May 20, 2020 at 5:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Andy Lutomirski <luto@kernel.org> writes:
> >> > On Mon, May 18, 2020 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >>
> >> >> Andy Lutomirski <luto@kernel.org> writes:
> >> >> > Actually, I revoke my ack.  Can you make one of two changes:
> >> >> >
> >> >> > Option A: Add an assertion to run_on_irqstack to verify that irq_count
> >> >> > was -1 at the beginning?  I suppose this also means you could just
> >> >> > explicitly write 0 instead of adding and subtracting.
> >> >> >
> >> >> > Option B: Make run_on_irqstack() just call the function on the current
> >> >> > stack if we're already on the irq stack.
> >> >> >
> >> >> > Right now, it's too easy to mess up and not verify the right
> >> >> > precondition before calling run_on_irqstack().
> >> >> >
> >> >> > If you choose A, perhaps add a helper to do the if(irq_needs_irqstack)
> >> >> > dance so that users can just do:
> >> >> >
> >> >> > run_on_irqstack_if_needed(...);
> >> >> >
> >> >> > instead of checking everything themselves.
> >> >>
> >> >> I'll have a look tomorrow morning with brain awake.
> >> >
> >> > Also, reading more of the series, I suspect that asm_call_on_stack is
> >> > logically in the wrong section or that the noinstr stuff is otherwise
> >> > not quite right.  I think that objtool should not accept
> >> > run_on_irqstack() from noinstr code.  See followups on patch 10.
> >>
> >> It's in entry.text which is non-instrumentable as well.
> >
> > Hmm.  I suppose we can chalk this up to the noinstr checking not being
> > entirely perfect.
>
> objtool considers both entry.text and noinstr.text. We just can't stick
> everything into entry.text for these !%@#45@# reasons.
>

Meh, this is all fine I think.  I think it would be slightly nicer if
objtool were to warn if noinstr code called run_on_stack(), but I'm
not sure it matters much.
