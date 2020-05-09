Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A023C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49147208E4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589051333;
	bh=V7nflp6cNkG5QGevgXa5od/IvI2G15l1QxbDlrMhLNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TE2daM7zjYgX5AQDN3KEVetrfth1LitxuIZdQS/MCsFcAVt5k32SA9w3mNWJhghvO
	 AFwKaRp2yEUb68KEx13S2DVvnETUuOCi6RYCkd09iLtMrv4IeT9LWDQKat9/A7q5M7
	 G9OwOeJTRLhIBD6h979zR0tNaeoowS7EMe8CR/oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgEITIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 15:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgEITIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 15:08:52 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 978D6208E4
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589051331;
        bh=V7nflp6cNkG5QGevgXa5od/IvI2G15l1QxbDlrMhLNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JqHGviI5EBrhkQrotH2SE8ZgCg+bRnc6ualxWiI9Y5q6eQZCgI+ONSUoHkcODKpxK
         vU0OQ6ejhus2pyQ1BWw0OL0CRolUm+vDIzBOX+gI6wjAmU5wPXRXklfKSWJe5itgdk
         ysjrpk82zFiHOaWlRg+wC5pRv1fj6MHwWnHVBtW8=
Received: by mail-wm1-f45.google.com with SMTP id y24so14309922wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 12:08:51 -0700 (PDT)
X-Gm-Message-State: AGi0PubTlr2B9eoKzSPsyGkHM9ZiC9pl6jXhDI4UGAFltYteSBYasRX6
        dBtDbCgShj39jNgnUW6GnkB3CuniQcG8G6g7lmwn/w==
X-Google-Smtp-Source: APiQypKdBb41feJIlpHU/i82pAmRbOrknH7DpSZcASb4cLU12jXUnMf20fF4zb9Mw9BgFp7S4XdzYly6PJe+7KB4DLI=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr21726641wmk.36.1589051330110;
 Sat, 09 May 2020 12:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134058.272448010@linutronix.de>
 <CAJhGHyAetdYdj=bdvoXRfu7bMVZiR8jLhek=_tes-6XPKOxKQQ@mail.gmail.com>
In-Reply-To: <CAJhGHyAetdYdj=bdvoXRfu7bMVZiR8jLhek=_tes-6XPKOxKQQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 9 May 2020 12:08:38 -0700
X-Gmail-Original-Message-ID: <CALCETrVSNPQesBfuKVwZkQXTF-Q-p4s6jH8ocr0RKRErERRzMA@mail.gmail.com>
Message-ID: <CALCETrVSNPQesBfuKVwZkQXTF-Q-p4s6jH8ocr0RKRErERRzMA@mail.gmail.com>
Subject: Re: [patch V4 part 1 02/36] x86/hw_breakpoint: Prevent data
 breakpoints on cpu_entry_area
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 2:23 AM Lai Jiangshan
<jiangshanlai+lkml@gmail.com> wrote:
>
> On Tue, May 5, 2020 at 10:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > From: Andy Lutomirski <luto@kernel.org>
> >
> > A data breakpoint near the top of an IST stack will cause unresoverable
> > recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
> > Prevent either of these from happening.
> >
>
> What happen when a data breakpoint on the direct GDT (load_direct_gdt())
> and the debug IDT (load_debug_idt()) which are not considered in this patch?
>

I have no idea, and learning the answer may involve talking to the
respective CPU vendors' microcode engineers.  We should probably block
those, too.
