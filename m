Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D722D2072D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598224198;
	bh=darGgUpJBt8Rvn6x7zwXnTJQUJdwmAom9kh77u2Kn2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sJ1EWE0HRazUWvoJjvg1TJD1UHXdCXYN/5dH6xRmK09fWcgjsDNJXvdHypEphGdOk
	 Lk1CLVWACzQpT4U+VFSjhmWhxSz+pLRwT1N5jI4QbY11OC0fAJQ05P0cE/oAuEx5P4
	 FhAgsjtmVDb90JboVcKd291s4YI8Wv/wD4qJfzHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHWXJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHWXJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:09:56 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0520620774
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598224196;
        bh=darGgUpJBt8Rvn6x7zwXnTJQUJdwmAom9kh77u2Kn2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AUgzWFVFF3H9ZWTxVyOo9fzw0AN/Du8xIGZO3AVcmPb02cU1oS5jUeVQDhTwzWL8F
         RkMpAdh2aFup4ASLQtUJGncIiReYKIP1zkAIg/NpItRGWUc/JXibniQpGHAyn1MuoG
         T1vIicubXujn1xH6ZEsfeqlu3+NR0VlrDY+FTK4U=
Received: by mail-wr1-f46.google.com with SMTP id f7so6929420wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 16:09:55 -0700 (PDT)
X-Gm-Message-State: AOAM532T6MU7rORIhwUdcNlXGpcG2ROhHorbQsX07CgHdKL7K0wjBX/V
        aDfxXxkoc2oRgSDZnG9ruoePbYQc4jRl4fh/CzatMA==
X-Google-Smtp-Source: ABdhPJzBbVjtZ4qm6aji+unVVCHzfBWz7dTxJa1zzFSakr6eVCGKpLQtS3Z/6/3waPtqaJKgmr3yuoxVXda8FtB1wP8=
X-Received: by 2002:adf:9283:: with SMTP id 3mr3122376wrn.70.1598224194614;
 Sun, 23 Aug 2020 16:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200821093912.815135402@infradead.org> <20200821102053.034965283@infradead.org>
In-Reply-To: <20200821102053.034965283@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Aug 2020 16:09:42 -0700
X-Gmail-Original-Message-ID: <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com>
Message-ID: <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] x86/debug: Simplify #DB signal code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Get rid of the two variables, avoid computing si_code when not needed
> and be consistent about which dr6 value is used.
>

> -       if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> -               send_sigtrap(regs, 0, si_code);
> +       /*
> +        * If dr6 has no reason to give us about the origin of this trap,
> +        * then it's very likely the result of an icebp/int01 trap.
> +        * User wants a sigtrap for that.
> +        */
> +       if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
> +               send_sigtrap(regs, 0, get_si_code(dr6));

The old condition was ... || (actual DR6 value) and the new condition
was ... || (stupid notifier-modified DR6 value).  I think the old code
was more correct.

The right fix is to get rid of the notifier garbage.  Want to pick up
these two changes into your series:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=b695a5adfdd661a10eead1eebd4002d08400e7ef
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=40ca016606bd39a465feaf5802a8dc3e937aaa06

And then there is no code left that modifies ->debugreg6 out from under you.

--Andy
