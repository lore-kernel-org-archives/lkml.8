Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A496AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846FA2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgB1O6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:58:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:41674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgB1O6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:58:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29E08ACF2;
        Fri, 28 Feb 2020 14:58:21 +0000 (UTC)
Date:   Fri, 28 Feb 2020 15:58:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] printk/console: Fix preferred console handling
Message-ID: <20200228145820.6k4ddp457kf4e6c4@pathway.suse.cz>
References: <20200213095133.23176-1-pmladek@suse.com>
 <20200217130308.GA447@jagdpanzerIV.localdomain>
 <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
 <025fe463a37a01a39e8b988530b36ce79210897b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025fe463a37a01a39e8b988530b36ce79210897b.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-02-28 09:14:47, Benjamin Herrenschmidt wrote:
> On Tue, 2020-02-18 at 10:52 +0100, Petr Mladek wrote:
> > On Mon 2020-02-17 22:03:08, Sergey Senozhatsky wrote:
> > > On (20/02/13 10:51), Petr Mladek wrote:
> > > > Hi,
> > > > 
> > > > I send this on behalf of Benjamin who is traveling at the moment.
> > > > It is an interesting approach to long terms problems with
> > > > matching
> > > > the console preferred on the command line.
> > > > 
> > > > Changes against v3:
> > > > 
> > > > 	+ better check when accepting pre-enabled consoles
> > > > 	+ correct reasoning in the 3rd patch
> > > > 	+ update a comment of CON_CONSDEV definition
> > > > 	+ fixed checkpatch warnings
> > > 
> > > Looks good to me,
> > > 
> > > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> > The patchset is commited in printk.git, branch
> > for-5.7-preferred-console.
> > 
> Do you plan to send any of this to -stable ?

Good question. I would prefer to wait until 5.7 gets release or even
longer. Changes in console registration order are prone to
regressions. People then complain that they do not longer see console
after reboot.

linux-next and rc phase has only pretty limited number of users.
Released kernels hit much bigger user base, for example, via
OpenSUSE Tumbleweed.

Best Regards,
Petr
