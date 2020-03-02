Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFC2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89A6246BB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCBJtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:49:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:45102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCBJtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:49:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB16CB0B6;
        Mon,  2 Mar 2020 09:49:08 +0000 (UTC)
Date:   Mon, 2 Mar 2020 10:49:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200302094907.qdbhe6iobegah56t@pathway.suse.cz>
References: <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
 <20200228031306.GO122464@google.com>
 <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
 <20200228105836.GA2913504@kroah.com>
 <20200228113214.kew4xi5tkbo7bpou@pathway.suse.cz>
 <20200228130217.rj6qge2en26bdp7b@pathway.suse.cz>
 <20200228205334.GF101220@mit.edu>
 <20200229033253.GA212847@google.com>
 <20200229184719.714dee74@oasis.local.home>
 <20200301052219.GA83612@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301052219.GA83612@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-03-01 14:22:19, Sergey Senozhatsky wrote:
> On (20/02/29 18:47), Steven Rostedt wrote:
> [..]
> > > > What do folks think?  
> > > 
> > > Well, my 5 cents, there is nothing that prevents "too-early"
> > > printk_deferred() calls in the future. From that POV I'd probably
> > > prefer to "forbid" printk_deffered() to touch per-CPU deferred
> > > machinery until it's not "too early" anymore. Similar to what we
> > > do in printk_safe::queue_flush_work().
> > 
> > I agree that printk_deferred() should handle being called too early.
> > But the issue is with per_cpu variables correct? Not the irq_work?
> 
> Correct. printk_deferred() and printk_safe()/printk_nmi() irq_works
> are per-CPU. We use "a special" flag in printk_safe()/printk_nmi() to
> tell if it's too early to modify per-CPU irq_work or not.
> 
> I believe that we need to use that flag for all printk-safe/nmi
> per-CPU data, including buffers, not only for irq_work. Just in
> case if printk_safe or printk_nmi, somehow, are being called too
> early.
> 
> > We could add a flag in init/main.c after setup_per_cpu_areas() and then
> > just have printk_deferred() act like a normal printk(). At that point,
> > there shouldn't be an issue in calling printk() directly, is there?
> 
> Sure, this will work. I believe we introduced a "work around" approach
> in printk-safe because noone would ACK a global init/main.c flag for
> printk(). If we can land a "per_cpu_areas_ready" flag (I've some doubts
> here), then yes (!), let's use it and let's remove printk-safe workaround.

A compromise might be to set a flag in setup_log_buf(). It is called
much earlier but it seems to be safe enough.

mm_init() is called close after setup_log_buf(). And it seems to be
using per-cpu variables when creating caches, see:

  + mm_init()
    + kmem_cache_init()
      + create_boot_cache()
        + __kmem_cache_create()
	  + setup_cpu_cache()

It is just a detail. But I would make the flag independent
on the existing printk_safe stuff. printk_safe will get removed
with the lockless printk buffer. While the irq_work() will still
be needed for the wakeup functions.

Sergey, do you agree and want to update your patch accordingly?

Best Regards,
Petr
