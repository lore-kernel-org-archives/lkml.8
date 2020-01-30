Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E1BC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854A5206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgA3Gkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:40:42 -0500
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:42661 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgA3Gkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:40:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 187D6182CED2A;
        Thu, 30 Jan 2020 06:40:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chalk31_40013548c1333
X-Filterd-Recvd-Size: 2693
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Jan 2020 06:40:39 +0000 (UTC)
Message-ID: <f099965dc5de82fc5fb60ba10371cd9f1aed2d94.camel@perches.com>
Subject: Re: -Wfortify-source in kernel/printk/printk.c
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Wed, 29 Jan 2020 22:39:32 -0800
In-Reply-To: <20200130051711.GF115889@google.com>
References: <20200130021648.GA32309@ubuntu-x2-xlarge-x86>
         <20200130051711.GF115889@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-30 at 14:17 +0900, Sergey Senozhatsky wrote:
> On (20/01/29 19:16), Nathan Chancellor wrote:
> > Hi all,
> > 
> > After commit 6d485ff455e ("Improve static checks for sprintf and
> > __builtin___sprintf_chk") in clang [1], the following warning appears
> > when CONFIG_PRINTK is disabled (e.g. allnoconfig):
> > 
> > ../kernel/printk/printk.c:2416:10: warning: 'sprintf' will always
> > overflow; destination buffer has size 0, but format string expands
> > to at least 33 [-Wfortify-source]
> >                         len = sprintf(text,
> >                               ^
> > 1 warning generated.
> > 
> > Specifically referring to
> > https://elixir.bootlin.com/linux/v5.5/source/kernel/printk/printk.c#L2416.
> 
> Good catch.
> 
> > It isn't wrong, given that when CONFIG_PRINTK is disabled, text's length
> > is 0 (LOG_LINE_MAX and PREFIX_MAX are both zero). How should this
> > warning be dealt this? I am not familiar enough with the printk code to
> > say myself.
> 
> It's not wrong.
> 
> Unless I'm missing something completely obvious: with disabled printk()
> we don't have any functions that can append messages to the logbuf, hence
> we can't overflow it. So the error in question should never trigger.
> 
> - Normal printk() is void, so kernel cannot append messages;
> - dev_printk() is void, so drivers cannot append messages and dicts;
> - devkmsg_write() is void, so user space cannot write to logbuf.
> 
> So I think we should never trigger that overflow (assuming that I
> didn't miss something) message.
> 
> In any case feel free to submit a patch - switch it to snprintf().

and/or make the code depend on CONFIG_PRINTK


