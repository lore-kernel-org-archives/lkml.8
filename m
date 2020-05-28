Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1671207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405385AbgE1RIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:08:25 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:55776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405314AbgE1RIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:08:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0E039181D3028;
        Thu, 28 May 2020 17:08:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shop26_1d0c21926d5c
X-Filterd-Recvd-Size: 3462
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 May 2020 17:08:20 +0000 (UTC)
Message-ID: <a4f8cfc41d4b7f9f76a403767cfc28d5ffafc1ee.camel@perches.com>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 28 May 2020 10:08:18 -0700
In-Reply-To: <20200528121455.GD11286@linux-b0ei>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <20200525084218.GC5300@linux-b0ei>
         <20200525091157.GF755@jagdpanzerIV.localdomain>
         <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
         <20200527083747.GA27273@linux-b0ei>
         <35d76737-8d23-9fb2-8e55-507109317f44@i-love.sakura.ne.jp>
         <20200527155504.GD3529@linux-b0ei>
         <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
         <20200528105942.GB11286@linux-b0ei>
         <945213f4-a2c3-b25e-35e4-7c55f836e11c@i-love.sakura.ne.jp>
         <20200528121455.GD11286@linux-b0ei>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-28 at 14:14 +0200, Petr Mladek wrote:
> On Thu 2020-05-28 20:33:10, Tetsuo Handa wrote:
> > On 2020/05/28 19:59, Petr Mladek wrote:
> > > 2. Add twist into vprintk_store(). In the current, implementation
> > >    it would do:
> > > 
> > >   #if TWIST
> > > 	return text_len;
> > >   #endif
> > > 
> > > 	return log_output(facility, level, lflags,
> > > 			  dict, dictlen, text, text_len);
> > 
> > This part could be possible. But
> > 
> > > 1. Add twist into ddebug_add_module() and enable all newly added
> > >    entries by default. For example, by calling
> > >    ddebug_exec_query("*:+p", const char *modname) or what is the syntax.
> > > 
> > >    This will cause that any pr_devel() variant will always get called.
> > 
> > how to handle
> > 
> > > >   #define no_printk(fmt, ...)                             \
> > > >   ({                                                      \
> > > >           if (0)                                          \
> > > >                   printk(fmt, ##__VA_ARGS__);             \
> > > >           0;                                              \
> > > >   })
> > 
> > part used by e.g. pr_devel() ? Since this macro is not using dynamic debug
> > interface, vprintk_store() will not be called from the beginning. Are you
> > suggesting that we should convert no_printk() to use dynamic debug interface ?
> 
> OK, this is one more path that would need special handling. Two paths
> are much better than 15.

A few more:

$ grep-2.5.4 --include=*.[ch] -rP '\if\s*\(\s*0\s*\)\s*\{?\s*\\?\s*no_printk' *
drivers/platform/x86/thinkpad_acpi.c:	do { if (0) no_printk(format, ##arg); } while (0)
fs/ntfs/debug.h:	if (0)								\
		no_printk(fmt, ##__VA_ARGS__);				\
include/linux/net.h:		if (0)						\
			no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
kernel/cred.c:	if (0)								\
		no_printk("[%-5.5s%5u] " FMT "\n",			\


