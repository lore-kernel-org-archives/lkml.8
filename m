Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC3CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0520222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgBMNHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:07:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:41110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbgBMNHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:07:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B13ECACD9;
        Thu, 13 Feb 2020 13:07:21 +0000 (UTC)
Date:   Thu, 13 Feb 2020 14:07:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     lijiang <lijiang@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200213130720.j4e5qv37am2bapup@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
 <877e11h0ir.fsf@linutronix.de>
 <cd7509a5-48fd-e652-90f4-1e0fe2311134@redhat.com>
 <87sgjp9foj.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgjp9foj.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-05 17:12:12, John Ogness wrote:
> On 2020-02-05, lijiang <lijiang@redhat.com> wrote:
> > Do you have any suggestions about the size of CONFIG_LOG_* and
> > CONFIG_PRINTK_* options by default?
> 
> The new printk implementation consumes more than double the memory that
> the current printk implementation requires. This is because dictionaries
> and meta-data are now stored separately.
> 
> If the old defaults (LOG_BUF_SHIFT=17 LOG_CPU_MAX_BUF_SHIFT=12) were
> chosen because they are maximally acceptable defaults, then the defaults
> should be reduced by 1 so that the final size is "similar" to the
> current implementation.
>
> If instead the defaults are left as-is, a machine with less than 64 CPUs
> will reserve 336KiB for printk information (128KiB text, 128KiB
> dictionary, 80KiB meta-data).
> 
> It might also be desirable to reduce the dictionary size (maybe 1/4 the
> size of text?).

Good questions. It would be great to check the usage on some real
systems.

In each case, we should inform users when messages and/or dictionaries
were lost.

Also it would be great to have a way (function) that would show how
big parts of the two ring buffers are occupied by valid data. It might
be useful also to detect problems with the ring buffer:

   + too many space reserved but not commited

   + too many records invalidated because of different ordering
     in desc ring and data ring.


> However, since the new printk implementation allows for
> non-intrusive dictionaries, we might see their usage increase and start
> to be as large as the messages themselves.

I wish the dictionaries were never added ;-) They complicate the code
and nobody knows how many people actually use the information.

Best Regards,
Petr
