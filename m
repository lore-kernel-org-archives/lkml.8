Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A975C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B8A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589226346;
	bh=5sFOwMePwnrmS2DiujoGIPlyrE9PbxM2k66U5cZbrMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mJ9eSHvdHQiRT6OJ10HHkV+AdK+UmAcIc2tl5X5vPcNQnWEzkRiChK8a9VHEwVq9z
	 v0o57+8j8lwrcDBv8cw9+Mf1pOO0WxN+rxxKGHxmPmaTjMLfJETd7fGfN7+vAu2oI9
	 bj+fCd8bmJHr25l55EJrDxZLMtD346lmH4bpXJlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbgEKTpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgEKTpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:45:45 -0400
Received: from kernel.org (unknown [77.127.227.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B4E206F5;
        Mon, 11 May 2020 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589226344;
        bh=5sFOwMePwnrmS2DiujoGIPlyrE9PbxM2k66U5cZbrMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6GwRCiadCTyRyfp5wu6v+IgSCH42fXpaFaUjBgiu4UM9h4faJOHlmZj82ARsMF5z
         EQMjhAPgoMpS+Hxcn5/YRQhNLX0OMhLAQHohjK+364CcJKUcy3E/GmiiPtUG3aY8Ej
         KOtGSfF1E/IAEMpqDTZJi0uEDqos8Wfao4ZPKY4k=
Date:   Mon, 11 May 2020 22:45:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCHv3 42/50] xtensa: Add loglvl to show_trace()
Message-ID: <20200511194534.GA1018386@kernel.org>
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-43-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418201944.482088-43-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 18, 2020 at 09:19:36PM +0100, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Add log level argument to show_trace() as a preparation for introducing
> show_stack_loglvl().
> 
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/xtensa/kernel/traps.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> index 0976e27b8d5d..c397a02457bc 100644
> --- a/arch/xtensa/kernel/traps.c
> +++ b/arch/xtensa/kernel/traps.c
> -void show_trace(struct task_struct *task, unsigned long *sp)
> +static void show_trace(struct task_struct *task, unsigned long *sp,
> +		       const char *loglvl)
>  {
>  	if (!sp)
>  		sp = stack_pointer(task);
>  
> -	pr_info("Call Trace:\n");
> -	walk_stackframe(sp, show_trace_cb, NULL);
> +	printk("%sCall Trace:\n", loglvl);
> +	walk_stackframe(sp, show_trace_cb, (void *)loglvl);
>  }
>  
>  #define STACK_DUMP_ENTRY_SIZE 4
> @@ -511,7 +515,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>  	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
>  		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
>  		       sp, len, false);
> -	show_trace(task, sp);
> +	show_trace(task, stack, KERN_INFO);

it should have been

	show_trace(task, sp, KERN_INFO);

Andrew, can you fold the following patch as a fixup please:


diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index f9217b6b45c8..efc3a29cde80 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -515,7 +515,7 @@ void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 	print_hex_dump(loglvl, " ", DUMP_PREFIX_NONE,
 		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
 		       sp, len, false);
-	show_trace(task, stack, loglvl);
+	show_trace(task, sp, loglvl);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.26.1


-- 
2.26.1


>  }
>  
>  DEFINE_SPINLOCK(die_lock);
> -- 
> 2.26.0
> 

-- 
Sincerely yours,
Mike.
