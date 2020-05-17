Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F96C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 05:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF9E206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 05:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589692370;
	bh=xtPpd2bre5VjU07gEm8x6R8Gfz9tYMXZIBIRCvVL9gA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v2XT0sqc+1fwkiU39JvHK18wCSCACmQplAjJ3q17s0ZJfrv+f5yRurTgidYL/c/FR
	 wIyPz1VJAg9TVqMbda0S955iAtzAxHEt179zm4KzjR37TNunOcVhlaUWIdFJ6yjY5y
	 D7wsBJQvzEqMUEqJvUXyJ9qQnDZPJh9gnJbTycF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgEQFMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 01:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgEQFMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 01:12:49 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B709207F5
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 05:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589692368;
        bh=xtPpd2bre5VjU07gEm8x6R8Gfz9tYMXZIBIRCvVL9gA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6bzA+G3NtuaqDbXqYEHBLoqAvcqrVcf4Lhbh3MnjdiuSNA62YPNC2JscuHfxrZEI
         7hk/fa2rYeJrnOcproKWwPbpp1Lk7qnAIjLF45gLC5VqjuQk7pnGtcOpqWdy4tQOrp
         JVKq2vh1xm4fidSwsDF1M3ECaXZTwwjdNKSnmyMw=
Received: by mail-wm1-f52.google.com with SMTP id g14so19791861wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 22:12:48 -0700 (PDT)
X-Gm-Message-State: AOAM530ZPlOs0zjRX3zYgg4XA76k4g29s0xaPvPnuWMEvlRGkE2b6xwQ
        C0nGKXKD1WC776DGWremxNI5OzZOM7gZ0NZZYS4s8g==
X-Google-Smtp-Source: ABdhPJxYbP+JC8eZBgGujEzxs6f9RroomKcJXs7l2aUQoqcnB07MUEqbsxkBZKSLhvMISqguxPQ7Fq3nOZYSI2nzjSk=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr12433164wmf.138.1589692366666;
 Sat, 16 May 2020 22:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235124.673436293@linutronix.de>
In-Reply-To: <20200515235124.673436293@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 16 May 2020 22:12:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUXr3gAv5DJfoXk-1qUMT00T+2urvG3AUGJL+NGsWAn+g@mail.gmail.com>
Message-ID: <CALCETrUXr3gAv5DJfoXk-1qUMT00T+2urvG3AUGJL+NGsWAn+g@mail.gmail.com>
Subject: Re: [patch V6 03/37] nmi, tracing: Provide nmi_enter/exit_notrace()
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
> To fully isolate #DB and #BP from instrumentable code it's necessary to
> avoid invoking the hardware latency tracer on nmi_enter/exit().
>
> Provide nmi_enter/exit() variants which are not invoking the hardware
> latency tracer. That allows to put calls explicitely into the call sites
> outside of the kprobe handling.


Acked-by: Andy Lutomirski <luto@kernel.org>
