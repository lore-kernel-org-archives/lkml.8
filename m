Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3002206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEUCJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 22:09:32 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:38168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbgEUCJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 22:09:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9A46C1802E8BC;
        Thu, 21 May 2020 02:09:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ducks22_401036126d1a
X-Filterd-Recvd-Size: 2806
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 May 2020 02:09:29 +0000 (UTC)
Message-ID: <032f1e9eec231e230781931ca8525ab2d29ae206.camel@perches.com>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 20 May 2020 19:09:27 -0700
In-Reply-To: <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
References: <cover.1589916689.git.joe@perches.com>
         <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
         <20200520044127.GB938@jagdpanzerIV.localdomain>
         <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
         <20200520121000.GF520@jagdpanzerIV.localdomain>
         <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
         <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-20 at 18:00 -0700, Andrew Morton wrote:
> On Wed, 20 May 2020 13:36:45 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Wed, 2020-05-20 at 21:10 +0900, Sergey Senozhatsky wrote:
> > > On (20/05/19 21:58), Joe Perches wrote:
> > > [..]
> > > > >  Maybe we can
> > > > > use here something rather random and much shorter instead. E.g.
> > > > > 256 chars. Hmm. How 
> > > > 
> > > > 	min(some_max like 132/256, PRINTK_LOG_LINE_MAX)
> > > > 
> > > > would work.
> > > 
> > > An alternative approach would be to do what we do in the
> > > print_modules() (the list of modules which can definitely
> > > be longer than 1K chars).
> > > 
> > > We can split command line in a loop - memchr(pos, ' ') - and
> > > pr_cont() parts of the command line. pr_cont() has overflow
> > > control and it flushes cont buffer before it overflows, so
> > > we should not lose anything.
> > 
> > It doesn't matter much here, but I believe
> > there's an 8k max buffer for pr_cont output.
> > 
> > include/linux/printk.h:#define CONSOLE_EXT_LOG_MAX      8192
> > 
> > Anyway, no worries, it simplifies the loop if
> > done that way.
> 
> I'm wondering if we shold add a kernel puts() (putsk()?  yuk) which can
> puts() a string of any length.
> 
> I'm counting around 150 instances of printk("%s", ...) and pr_foo("%s",
> ...) which could perhaps be converted, thus saving an argument.

I'd expect that it hardly matters.
printk(KERN_CONT "string") works.


