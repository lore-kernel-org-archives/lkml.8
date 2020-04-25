Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4830C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B927720704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDYSSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 14:18:40 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:60430 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYSSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 14:18:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B46191802926E;
        Sat, 25 Apr 2020 18:18:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wine94_684a8c69f9151
X-Filterd-Recvd-Size: 2277
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 Apr 2020 18:18:36 +0000 (UTC)
Message-ID: <38aeb1431d8245b0c37b5d3d7ec6d9e2f33c330e.camel@perches.com>
Subject: Re: [PATCHv3 11/50] c6x: Add show_stack_loglvl()
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org
Date:   Sat, 25 Apr 2020 11:18:35 -0700
In-Reply-To: <20200418201944.482088-12-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
         <20200418201944.482088-12-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-18 at 21:19 +0100, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
[]
> diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
[]
> @@ -344,12 +344,13 @@ asmlinkage int process_exception(struct pt_regs *regs)
>  
>  static int kstack_depth_to_print = 48;
>  
> -static void show_trace(unsigned long *stack, unsigned long *endstack)
> +static void show_trace(unsigned long *stack, unsigned long *endstack,
> +		       const char *loglvl)
>  {
>  	unsigned long addr;
>  	int i;
> 
> -	pr_debug("Call trace:");
> +	printk("%sCall trace:", loglvl);

These are not equivalent transforms as pr_debug
is compiled to nothing unless DEBUG is defined
or CONFIG_DYNAMIC_DEBUG is enabled.

Perhaps all the conversions should be checked
for these "not the same" object code changes.

