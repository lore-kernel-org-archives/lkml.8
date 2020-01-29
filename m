Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5622C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5E72070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgA2LzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:55:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:59898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgA2LzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:55:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C8C2AE3F;
        Wed, 29 Jan 2020 11:55:18 +0000 (UTC)
Date:   Wed, 29 Jan 2020 12:55:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 0/2] printf: add support for %de
Message-ID: <20200129115516.zsvxu56e6h7gheiw@pathway.suse.cz>
References: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
 <CAHp75Vei9_xqxiiAWBrcMp3yOWmMNmdRmNEwO=Ht+URsnoD4Pw@mail.gmail.com>
 <f039631b-8a90-48fc-c80f-1160628469a9@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f039631b-8a90-48fc-c80f-1160628469a9@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-01-21 11:27:34, Rasmus Villemoes wrote:
> On 20/01/2020 10.32, Andy Shevchenko wrote:
> > On Mon, Jan 20, 2020 at 10:57 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > 
> >> this is an reiteration of my patch from some time ago that introduced
> >> %dE with the same semantic. Back then this resulted in the support for
> >> %pe which was less contentious.
> >>
> > 
> >> I still consider %de (now with a small 'e' to match %pe) useful.
> > 
> > Please, don't spread the extensions over the standard specifiers. The
> > %p* extensions are enough for my opinion.
> > NAK.
> > 
> 
> As I think I already mentioned (and what led me to do the %pe), I'm with
> Andy and Joe here, I don't think modifying the behaviour of stuff other
> than %p is a good idea - especially not when it's only about saving a
> few characters to avoid the ERR_PTR() wrapping.

+1

Best Regards,
Petr
