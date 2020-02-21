Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B0C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459C420578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBUQdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:33:43 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38513 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgBUQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:33:42 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j5BFB-0002cI-1H; Fri, 21 Feb 2020 17:33:37 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j5BF8-00081h-K4; Fri, 21 Feb 2020 17:33:34 +0100
Date:   Fri, 21 Feb 2020 17:33:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1] lib/vsprintf: update comment about
 simple_strto<foo>() functions
Message-ID: <20200221163334.w7pocmbbw4ymimlc@pengutronix.de>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
 <20200221145141.pchim24oht7nxfir@pengutronix.de>
 <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:27:49PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 21, 2020 at 4:54 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Feb 21, 2020 at 10:57:23AM +0200, Andy Shevchenko wrote:
> > > The commit 885e68e8b7b1 ("kernel.h: update comment about simple_strto<foo>()
> > > functions") updated a comment regard to simple_strto<foo>() functions, but
> > > missed similar change in the vsprintf.c module.
> > >
> > > Update comments in vsprintf.c as well for simple_strto<foo>() functions.
> 
> ...
> 
> > > - * This function is obsolete. Please use kstrtoull instead.
> > > + * This function has caveats. Please use kstrtoull instead.
> 
> > I wonder if we instead want to create a set of functions that is
> > versatile enough to cover kstrtoull and simple_strtoull. i.e. fix the
> > rounding problems (that are the caveats, right?) and as calling
> > convention use an errorvalued int return + an output-parameter of the
> > corresponding type.
> 
> It wouldn't be possible to apply same rules to both. They both are
> part of existing ABI.

The idea is to creat a sane set of functions, then convert all users to
the sane one and only then strip the strange functions away. (Userspace)
ABI isn't affected, is it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
