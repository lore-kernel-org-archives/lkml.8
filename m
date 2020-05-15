Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B08C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BFDF206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589521064;
	bh=SuVHOy8cA7zaee1Wtzeq5edqdj/GnFqaX2yUkDrhAUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yom/KI/daa4pvxOsqXOrMogj1vJLteItOSKQ4GFu18hxHGJ41D7tDepC1Jv3RuJuA
	 lK127hTHfwIgeOnf3RGBAQxzkRCizKNvAoRe73tBlK+LjQZGELuJ/OtXjS7TBvVVpQ
	 hpIootEgXPKdm+a9nt5fPycDOK0grXBbYRb8UpHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEOFhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgEOFhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:37:43 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64DA720671
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521062;
        bh=SuVHOy8cA7zaee1Wtzeq5edqdj/GnFqaX2yUkDrhAUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OlniUzH1ZnVwPBp/5Z3f/4e+e1z2AkmWp7CXReQ5bC4a/J0AcN6uLOZk2uKHdE2nD
         DvEWLiFw3/FlM8E1wusUmg+kF4LYFPWPoG0k1a5LW7XTQEI6Ad/qp7ehTLau947an4
         lzsW9eFBgsqGQl3YpzCzNSzjtSVWLK/39HRTgqcw=
Received: by mail-wm1-f50.google.com with SMTP id n5so1167386wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:37:42 -0700 (PDT)
X-Gm-Message-State: AOAM532Tul6V+ttQWfvlMDDaGgbZ/ssWJrMIkkUYKjzrcaG4n3RZKL09
        4mF6dY3AAbJGilz1y5f3MjBAMdbQnzKIGzjHP5kTxw==
X-Google-Smtp-Source: ABdhPJy2M8IQey4U6e7K04OTZ5tUzm0crbydvUjQHcDy7lIaGJYXIcMQTaP860O0jZq0UsQHr8WiVQs+p26DJU+KUTw=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr1071698wmd.21.1589521060978;
 Thu, 14 May 2020 22:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.808628211@linutronix.de>
In-Reply-To: <20200505135314.808628211@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:37:29 -0700
X-Gmail-Original-Message-ID: <CALCETrWFiAWiMByNmDSnWJDfRai2meaLaOJ-fxxWoBKhVOd9xw@mail.gmail.com>
Message-ID: <CALCETrWFiAWiMByNmDSnWJDfRai2meaLaOJ-fxxWoBKhVOd9xw@mail.gmail.com>
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
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
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> DR6/7 should be handled before nmi_enter() is invoked and restore after
> nmi_exit() to minimize the exposure.
>
> Split it out into helper inlines and bring it into the correct order.

> +        *
> +        * Entry text is excluded for HW_BP_X and cpu_entry_area, which
> +        * includes the entry stack is excluded for everything.
> +        */
> +       get_debugreg(*dr7, 6);
> +       set_debugreg(0, 7);

Fortunately, PeterZ is hiding in a brown paper bag, so I don't have to
comment :)

Other than that:

Acked-by: Andy Lutomirski <luto@kernel.org>
