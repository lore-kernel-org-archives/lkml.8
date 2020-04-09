Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F9C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6CC2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDITmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:42:50 -0400
Received: from peace.netnation.com ([204.174.223.2]:46842 "EHLO
        peace.netnation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDITmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:42:49 -0400
X-Greylist: delayed 1023 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2020 15:42:49 EDT
Received: from sim by peace.netnation.com with local (Exim 4.92)
        (envelope-from <sim@hostway.ca>)
        id 1jMco4-0008Me-5I; Thu, 09 Apr 2020 12:25:44 -0700
Date:   Thu, 9 Apr 2020 12:25:44 -0700
From:   Simon Kirby <sim@hostway.ca>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCHv2] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200409192543.GA30816@hostway.ca>
References: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
 <20200304152159.2p7d7dnztf433i24@pathway.suse.cz>
 <20200305013014.GA174444@google.com>
 <20200305185348.GB2141048@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305185348.GB2141048@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:53:48PM +0100, Greg Kroah-Hartman wrote:

> On Thu, Mar 05, 2020 at 10:30:14AM +0900, Sergey Senozhatsky wrote:
> > On (20/03/04 16:21), Petr Mladek wrote:
> > [..]
> > > > Fix printk_deferred() and do not queue per-CPU irq_work
> > > > before per-CPU areas are initialized.
> > > >
> > > > [0] https://lore.kernel.org/lkml/aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com/
> > > >
> > > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > > Reported-by: Lech Perczak <l.perczak@camlintechnologies.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > > Cc: John Ogness <john.ogness@linutronix.de>
> > >
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > Thanks!
> > 
> > > Now, the question is whether to hurry this fix into 5.6 or if
> > > it could wait for 5.7.
> > >
> > > I think that it could wait because 5.6 is not affected by
> > > the particular printk_deferred(). This patch fixes a long-term
> > > generic problem. But I am open for other opinions.
> > 
> > Good question. My 5 cents, I would _probably_ push it now. Not
> > because it fixes any known issues on 5.6, but because we have
> > a number of LTS kernel (4.19, 4.14, 4.9, 4.4, 3.16) that can be
> > affected should 1b710b1b10eff9d4 be backported to those kernels.
> 
> It was backported there, and now has been reverted.  So no big rush from
> what I can tell.

This causes "dmesg -w" or "cat /dev/kmsg" to not print new messages after
dumping the current ring. I hit this on v5.5.9, v5.5.15, v5.6.3, and
Linus HEAD. This prints no "hi":

(sleep 1;echo hi > /dev/kmsg)& dmesg -w

...curiously, "strace dmesg -w" shows the data received once ^C is hit.

Jann pointed me to this patch. Applying it or reverting 1b710b1b10eff9d4
does fix it for me. However, Linus HEAD is still broken and, AFAICS,
remains unreverted and unfixed in stable/linux-5.4.y through linux-5.6.y.
It was introduced in 5.6 but backported to those, not just the LTS above.

Simon-
