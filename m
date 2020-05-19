Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936BFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D38207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589919727;
	bh=sBaxMvDvpb8lGhSCBFZEnwIAcZrTKYiEudaBGAyTwwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UK8trBytyojyfCeEemEmMFkYqnh8H0LqehEp5w2rt1Fy+9B+JhKEhWXtFHjPxlWCl
	 u3lWFUzZR59QwqwMLhmxmo267IlPf4K8BMYLnzeaZgsfecMBlAkl2mv1z5DyM8QwYJ
	 IKge58HfHo0vqZERb68LaqDBfAlHg5Ruf3BJxk+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgESUWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgESUWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:22:06 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80AC320829
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919725;
        bh=sBaxMvDvpb8lGhSCBFZEnwIAcZrTKYiEudaBGAyTwwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YBMJ7xrgBhQUiiBpPey0YpU6g6HgYXX6gQlFR6u6HtpEorQX9Ti22iPm6Hrlo+OqJ
         CBOHj6EEwD6tX8b1/PGTH9k/A0N32Ui03Pe/J80zcJv4eZ/OhSL1N0luAatx4NJ3BH
         sd22e2zbMfr0A5fhWBrbGefml9pcSc4JURzK0lvk=
Received: by mail-wm1-f54.google.com with SMTP id m185so616544wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:22:05 -0700 (PDT)
X-Gm-Message-State: AOAM531IdyYO6ACOzASlLVLXjkh1RiZ/CbXrJUoxex5DgaC2VdkWMoOA
        sFhKxRYUhnygebJkYx+kG6ZYHyO1GdMyZ3wDGLIAYw==
X-Google-Smtp-Source: ABdhPJzNetHuu0bHafdVC4j9EKsBbiAoYoDZr9wgTy6U0wHfJ/GQ2CUD7NnBHpLP6eVJffvwOsY+u9oeX4aEonvVpmY=
X-Received: by 2002:a1c:b3c1:: with SMTP id c184mr1118764wmf.36.1589919723960;
 Tue, 19 May 2020 13:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.425706250@linutronix.de>
In-Reply-To: <20200515235126.425706250@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:21:52 -0700
X-Gmail-Original-Message-ID: <CALCETrV-G6-UGMK=MT4RLQyqcUH7p=VsFPOddu-oAUaKic7CKw@mail.gmail.com>
Message-ID: <CALCETrV-G6-UGMK=MT4RLQyqcUH7p=VsFPOddu-oAUaKic7CKw@mail.gmail.com>
Subject: Re: [patch V6 20/37] x86/irq/64: Provide handle_irq()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> To consolidate the interrupt entry/exit code vs. the other exceptions
> provide handle_irq() (similar to 32bit) to move the interrupt stack
> switching to C code. That allows to consolidate the entry exit handling by
> reusing the idtentry machinery both in ASM and C.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> index 62cff52e03c5..6087164e581c 100644
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -79,3 +79,11 @@ void do_softirq_own_stack(void)
>         else
>                 run_on_irqstack(__do_softirq, NULL);
>  }
> +
> +void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
> +{
> +       if (!irq_needs_irq_stack(regs))
> +               generic_handle_irq_desc(desc);
> +       else
> +               run_on_irqstack(desc->handle_irq, desc);
> +}
>

Would this be nicer if you open-coded desc->handle_irq(desc) in the if
branch to make it look less weird.

This also goes away if you make the run_on_irqstack_if_needed() change
I suggested.
