Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE12C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E53D2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgESRVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:21:12 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:37354 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729421AbgESRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:21:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BB0F318224D70;
        Tue, 19 May 2020 17:21:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bath79_4410d9c26d0e
X-Filterd-Recvd-Size: 2853
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 17:21:08 +0000 (UTC)
Message-ID: <ccdab3adb4c1fe9f814f55bc069f8ad2e4fe111b.camel@perches.com>
Subject: Re: lockdep tracing and using of printk return value ?
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Date:   Tue, 19 May 2020 10:21:07 -0700
In-Reply-To: <20200519144539.GB317569@hirez.programming.kicks-ass.net>
References: <335067f871a85db5f24650a3dff96f19727bed50.camel@perches.com>
         <20200519144539.GB317569@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-19 at 16:45 +0200, Peter Zijlstra wrote:
> On Tue, May 19, 2020 at 05:41:47AM -0700, Joe Perches wrote:
> > Except for some ancient code in drivers/scsi, this code
> > may be the only kernel use of the printk return value.
> 
> Is using the printk() return value a problem?

Maybe.  The printk code isn't obviously correct.

https://lore.kernel.org/lkml/20200518204415.d1a3adaba597ce5b232b4b2a@linux-foundation.org/

> > Code that uses the printk return value in
> > kernel/locking/lockdep.c is odd because the printk
> > return length includes both the length of a KERN_<LEVEL>
> > prefix and the newline.  depth also seems double counted.
> 
> Yeah, it seems dodgy. OTOH printk() really ought to discard the
> KERN_<level> crud from the return size.

Or change it to the actual output of '<' level '>'
instead of the internal KERN_SOH level.

> > Perhaps there's a better way to calculate this?
> > 
> > Maybe:
> > ---
> >  kernel/locking/lockdep.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 2fadc2635946..265227edc550 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -1960,11 +1960,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
> >  
> >  	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
> >  		if (class->usage_mask & (1 << bit)) {
> > -			int len = depth;
> > -
> > -			len += printk("%*s   %s", depth, "", usage_str[bit]);
> > -			len += printk(KERN_CONT " at:\n");
> > -			print_lock_trace(class->usage_traces[bit], len);
> > +			printk("%*s   %s at:\n", depth, "", usage_str[bit]);
> > +			print_lock_trace(class->usage_traces[bit],
> > +					 depth + 3 + strlen(usage_str[bit]);
> >  		}
> >  	}
> >  	printk("%*s }\n", depth, "");
> 
> Doesn't seem crazy...

