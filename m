Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2503C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18FB208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHTAd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:33:56 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:33372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbgHTAdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:33:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B4E68181D3028;
        Thu, 20 Aug 2020 00:33:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: berry50_5c0699f2702c
X-Filterd-Recvd-Size: 2006
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 00:33:53 +0000 (UTC)
Message-ID: <e1e3164eabf69e04ad9e9ddc259ca685f48c5e27.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
From:   Joe Perches <joe@perches.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Aug 2020 17:33:51 -0700
In-Reply-To: <20200819232632.13418-2-john.ogness@linutronix.de>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
         <20200819232632.13418-2-john.ogness@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 01:32 +0206, John Ogness wrote:
> Implement a new buffering mechanism for pr_cont messages.
> 
> Old mechanism syntax:
> 
>     printk(KERN_INFO "text");
>     printk(KERN_CONT " continued");
>     printk(KERN_CONT "\n");
> 
> New mechanism syntax:
> 
>     pr_cont_t c;
> 
>     pr_cont_begin(&c, KERN_INFO "text");

bikeshed:

I suggest:

	printk_begin(&printk_context, fmt, ...)
	printk_continue(&printk_context, fmt, ...) (maybe printk_next())
	printk_end(&printk_context, fmt, ...)

and macros using pr_<level>_begin

ie:

#define pr_info_begin(context, fmt, ...)		\
	printk_begin(context, KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)

and each continued bit would use printk_continue or printk_end
as appropriate.

KERN_<LEVEL> could be a separate argument, but it's simple
enough to use
printk_get_level on the format.


