Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6050C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A13720661
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM31AFba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgEIJXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgEIJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:23:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1680C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 02:23:31 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k6so4305608iob.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npUCSug3UNmvoID4U4QjZrQryTMG/6PUbxsaJOR4T28=;
        b=TM31AFba3DfHCrEv6efBqjc5asmfKIAX5qK8448CR2SCW4RuZMPfdPDyaPyMU2xgHT
         5sueQWG1vPyOt/KzIibm6A0+NMj9kTMmFpWeZQKBxGCGzq6hPMr2onN0RlU4TpBc56Al
         PctXOx5V46kH2vXzLqOVscXgYxzfsb7T8z51BfozgWXs+qtr4A7oEBB+VfCmmhCLaxvv
         3TU4VFyAOzNYymYWoC19ULVREZ1oLpYVigTv0KzeE/RgBk2rpVSlVXiofXlBaVgRM/sd
         ay0FwbQGqMIqj4q1oGpHCYQQC0M7e8DKGW4fpzWpCM5KdICjq0kwD4HACP7ncUfrxSzB
         SWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npUCSug3UNmvoID4U4QjZrQryTMG/6PUbxsaJOR4T28=;
        b=NUSR+1lhd3prZEPPxrQEg9s0e4E8m90dyLz0E5BqUAFjdhHMLTVAzUvbnz2oehiA77
         HhNDcRxX86GWuAcwuQzUckOVGWEIxrxQxwQK9oByJqfOFsUackFzz+eTzP1LxhM8UpL1
         y9CDouKBn0LSXGhp4uLafBXOZKfqpvn69xa4fcZ2zIs9/7MsqkWIesmNB7zsE1zHUGHW
         vZ59/XhcCyWeRdboiUJwj9HqFB6CpUYRuooBCHXMRNU6jqQxqMiEvMHA8tMiL64B7R8I
         /BB6COqilMxd7J59P/GwE9bbh3y7Nqezmwr3NwmD0h70iPsRuwHUuMYVV834oXn2g8WH
         pcfQ==
X-Gm-Message-State: AGi0PuZMw4tMMutcxJ7dEdiSAutAqiqsqG9a9d09r0ZsnENmdwnW+CA6
        DXK95E+195aKkwRQZhbChQB8A6xm0/hYDr87slU=
X-Google-Smtp-Source: APiQypJTo+iHmgKOwr7znP0jcjAroPrnAacktBKv3E9YmNJoP6PNKBM81igz0/RNbvATdEWY6mYeNODi6BRo1UaqPOk=
X-Received: by 2002:a02:6a1e:: with SMTP id l30mr6254957jac.98.1589016211189;
 Sat, 09 May 2020 02:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134058.272448010@linutronix.de>
In-Reply-To: <20200505134058.272448010@linutronix.de>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 9 May 2020 17:23:20 +0800
Message-ID: <CAJhGHyAetdYdj=bdvoXRfu7bMVZiR8jLhek=_tes-6XPKOxKQQ@mail.gmail.com>
Subject: Re: [patch V4 part 1 02/36] x86/hw_breakpoint: Prevent data
 breakpoints on cpu_entry_area
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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

On Tue, May 5, 2020 at 10:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Andy Lutomirski <luto@kernel.org>
>
> A data breakpoint near the top of an IST stack will cause unresoverable
> recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
> Prevent either of these from happening.
>

What happen when a data breakpoint on the direct GDT (load_direct_gdt())
and the debug IDT (load_debug_idt()) which are not considered in this patch?

Thanks
Lai
