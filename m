Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B32C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515E22145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588874546;
	bh=VwlZdvyZ65Zk5wRT7z0+h8x/so/vB6yAwldwafnFQW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DrPTVyenANLeJPAeNsPLVUzzo6L9YFv6x2utA/xwFm5+nBowq0pdYVWf8wto1pw1e
	 tTl9MpDq1/PJkunnNqO8FnilycjICjctHDUdM+s0XLFzP9ZAMOkB1p93N5RoaMpkdD
	 jd9ujr8sCnxD/zWmjRwlHTlpEWGdnouQBjlIop/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEGSCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGSCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:02:24 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A4A24954
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588874543;
        bh=VwlZdvyZ65Zk5wRT7z0+h8x/so/vB6yAwldwafnFQW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RBb8L9nURNjYclAs3LOnV3iMbO+08U1E+5fWF500lIiqowb9vDzqnVHrFf2R6YOJQ
         c+tksHteKwvzR1Qm0eZ7x2rQ2kbvCB7ivlAutVrE0BxRM68SEwe1gv8HbU+UH/XcWh
         EPxTkRL9XaVSXsP+hbwZovrdnQZqKFq9pKxr/jtI=
Received: by mail-wr1-f41.google.com with SMTP id l18so7471969wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:02:23 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ42fCJFRil4AkpaeDbPwYStrdZUF35YX+atGWyrtEXXLNLh1E8
        CMH8rcL/BB6FRZMXVpGRvIMcLFYnK7dXVimj2eL6+g==
X-Google-Smtp-Source: APiQypJmWnsaeXWFP3t8RdXi07tyN0RgGFyVnzXqq90lSm0AqnFzrs2SnReq/hpsqubfqhJK8KMT9Cq9xeaxvO4eaGA=
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr16440356wrv.75.1588874541618;
 Thu, 07 May 2020 11:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134100.957390899@linutronix.de>
In-Reply-To: <20200505134100.957390899@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 May 2020 11:02:09 -0700
X-Gmail-Original-Message-ID: <CALCETrX=Obqn2ms5EYs7HPxTE_UgnVkmt-HoAoGzB4BajuMwLA@mail.gmail.com>
Message-ID: <CALCETrX=Obqn2ms5EYs7HPxTE_UgnVkmt-HoAoGzB4BajuMwLA@mail.gmail.com>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Convert #MC over to using task_work_add(); it will run the same code
> slightly later, on the return to user path of the same exception.

I think this patch is correct, but I think it's only one small and not
that obviously wrong step away from being broken:

>         if ((m.cs & 3) == 3) {
>                 /* If this triggers there is no way to recover. Die hard. */
>                 BUG_ON(!on_thread_stack() || !user_mode(regs));
> -               local_irq_enable();
> -               preempt_enable();
>
> -               if (kill_it || do_memory_failure(&m))
> -                       force_sig(SIGBUS);
> -               preempt_disable();
> -               local_irq_disable();
> +               current->mce_addr = m.addr;
> +               current->mce_status = m.mcgstatus;
> +               current->mce_kill_me.func = kill_me_maybe;
> +               if (kill_it)
> +                       current->mce_kill_me.func = kill_me_now;
> +               task_work_add(current, &current->mce_kill_me, true);

This is fine if the source was CPL3, but it's not going to work if CPL
was 0.  We don't *currently* do this from CPL0, but people keep
wanting to.  So perhaps there should be a comment like:

/*
 * The #MC originated at CPL3, so we know that we will go execute the
task_work before returning to the offending user code.
 */

IOW, if we want to recover from CPL0 #MC, we will need a different mechanism.

I also confess a certain amount of sadness that my beautiful
haha-not-really-atomic-here mechanism isn't being used anymore. :(

--Andy
