Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0465C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C572B206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431045;
	bh=QO0YgO2s4elXiLdZ/YnyJWuw0f1W7Nd1x3ZKibc/TkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q56e7bI/c6C1tQomZ5LF1vrGl2pUct//Dtv/+57yEew+wS+L4GoJnUNbvxpAY1lZe
	 fZgr++VEsgffv2RTcFgNz6rkDcmRJytH5af4jObqd558B6lG63Icdo1P56uLF+Q8nM
	 VQ9QsyqJGdJVhnQ+bHgdJW4txvCWMG+6IdxKCkrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgENEhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:37:24 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DBD92073E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431043;
        bh=QO0YgO2s4elXiLdZ/YnyJWuw0f1W7Nd1x3ZKibc/TkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/KKY3seNmJXXlEUPBCVBRpLS/jnqWupKrFxW9CBQZ+Afumbt+8MCfIGy/AOedMCC
         qqZb/9VCu9TvQsW8K8F/qiDgNlW+7UMR2RXfRUySubAsm2RFx6j9PhM8NoY1IEKsNn
         xLu9/ta2AGGIdLQO83ZtjNtgMIiX3TALGDycDlpo=
Received: by mail-wr1-f50.google.com with SMTP id l17so2110256wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:37:23 -0700 (PDT)
X-Gm-Message-State: AOAM533/WSlgI1IUVI5wkQl3yNhcOuiX62Xj3AuemfImhEfsaCtn0kZt
        0c1bPSNqmvEa4eTOLP/XmWXnr9paatTgkX7PwQSlAg==
X-Google-Smtp-Source: ABdhPJzklne40utABnpOVEvJQp2e3sFA/52WxEBk7XCmUjfkaepM5kd5Cb8z5MetdSZrQeermECGcW5N7B57xLDOINM=
X-Received: by 2002:adf:a298:: with SMTP id s24mr3004503wra.184.1589431041918;
 Wed, 13 May 2020 21:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.556327833@linutronix.de>
In-Reply-To: <20200505134904.556327833@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:37:10 -0700
X-Gmail-Original-Message-ID: <CALCETrUyA5bN2ScrdhwEYZSUpyOhO+MaEu1X3PwX6vHGGCkqCg@mail.gmail.com>
Message-ID: <CALCETrUyA5bN2ScrdhwEYZSUpyOhO+MaEu1X3PwX6vHGGCkqCg@mail.gmail.com>
Subject: Re: [patch V4 part 3 13/29] x86/traps: Prepare for using DEFINE_IDTENTRY
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Prepare for using IDTENTRY to define the C exception/trap entry points. It
> would be possible to glue this into the existing macro maze, but it's
> simpler and better to read at the end to just make them distinct. Provide
> a trivial inline helper to read the trap address.
>
> The existing macros will be removed once all instances are converted.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>
> ---
>  arch/x86/kernel/traps.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -205,6 +205,11 @@ static void do_error_trap(struct pt_regs
>         }
>  }
>
> +static __always_inline void __user *error_get_trap_addr(struct pt_regs *regs)
> +{
> +       return (void __user *)uprobe_get_trap_addr(regs);
> +}

My mind boggles.  WTF is this?

Perhaps this should have a comment like:

/*
 * Returns the address from which a user trap originated.  This would
be the same as regs->ip,
 * except for frhgnieawfn nvlrkvklsrvs and mfkealwf, and this lets the
thingummy pass a
 * modified value to the signal frame, but only for #DE and #UD,
because #*!&@&#@.
 */

except with the blanks filled in.

After reading a bit of uprobe code, I assume this is a fixup for when
we're running code that got moved out of line because it got replaced
by a breakpoint.  I'm still mystified by why it only seems to apply to
#DE and #UD.
