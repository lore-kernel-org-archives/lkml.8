Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F1420724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgBLOD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:03:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:45354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLOD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:03:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DAE13B1A8;
        Wed, 12 Feb 2020 14:03:55 +0000 (UTC)
Date:   Wed, 12 Feb 2020 15:03:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200212140355.56drih2wfcryjjtl@pathway.suse.cz>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
 <20200211124317.x5erhl7kvxj2nq6a@pathway.suse.cz>
 <20200212013133.GB13208@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212013133.GB13208@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-12 10:31:33, Sergey Senozhatsky wrote:
> On (20/02/11 13:43), Petr Mladek wrote:
> >
> > Even better solution might be to move fs/proc/kmsg.c to
> > kernel/printk/proc_kmsg.c and declare printk_log_wait only
> > in kernel/printk/internal.h. I think that this is what
> > Sergey suggested.
> 
> Yes, right.
> 
> > Another great thing would be to extract devkmsg stuff from
> > kernel/printk/printk.c and put it into kernel/printk/dev_kmsg.c.
> 
> Yeah, can do, I would still prefer proc_kmsg to "move in".
> Either both can live in printk.c (won't make it much worse),
> or in kernel/printk/dev_kmsg.c and kernel/printk/proc_kmsg.c

I would prefer to split it:

    + printk.c is already too big and would deserve splitting.

    + The two different kmgs interfaces are confusing on its
      own. IMHO, it will be even more confusing when they
      live in one huge source file.


> I can take a look at dev_ksmg.c/proc_kmsg.c option, unless
> someone else wants to spend their time on this.

It would be lovely from my POV. I am only concerned about
the lockless printk() stuff. I would prefer to avoid creating
too many conflicts in the same merge window. Well, I am
not sure how many conflicts there would be. Adding John
into CC.

Best Regards,
Petr
