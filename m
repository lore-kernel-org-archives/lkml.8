Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C134C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB9220786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgGHPUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:20:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgGHPUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:20:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99E97AFF1;
        Wed,  8 Jul 2020 15:20:07 +0000 (UTC)
Date:   Wed, 8 Jul 2020 17:20:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
Message-ID: <20200708152005.GF4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707145932.8752-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-07-07 17:05:28, John Ogness wrote:
> Hello,
> 
> Here is a v4 for the first series to rework the printk
> subsystem. The v3 is here [0]. This first series
> only replaces the existing ringbuffer implementation. No locking
> is removed. The semantics/behavior of printk are kept the same
> except for a minor optimization that is reverted (patch 3).
> 
> Despite minor changes to the ringbuffer code since v3 (comments,
> function names, very minor refactoring), the ringbuffer logic
> itself has not changed. And, in particular, the memory barriers
> have been exactly preserved from v3. For this reason I deem it
> appropriate to keep Paul's reviewed by tag (patch 2).
> 
> RFC patches for various userspace tools to dump the kernel log
> are available: crash [1], makedumpfile [2], kexec-tools [3].
> 
> Finally, I would like to thank some people/organizations that
> helped with performing ringbuffer stress tests on big or rare
> hardware that I do not have access to:
> 
> - Prarit Bhargava of Red Hat (x86_64, ppc64le power8)
> - Michael Cree of Debian (alpha)
> - Jeff Scheel of OSU Open Source Lab (ppc64le power8 kvm)

OK, I think that we are ready to try this in linux-next.
I am going to push it there via printk/linux.git.

I have a good feeling about the patchset. The great thing is that
the access is still synchronized using logbuf_lock so that we do not
have to deal with races for the moment.

Of course, there are still many potential problems. The following comes
to my mind:

   + Bugs in the algorithm logic or implementation might prevent
     showing any messages on consoles or via syslog or /dev/kmsg.
     We did our best to avoid it.

   + Debugging tools accessing the buffer directly would need to
     understand the new structure. Fortunately John provided
     patches for the most prominent ones.

   + Small devices might complain about less effective use of memory.
     Part of descriptors and dictionaries ring buffers might stay
     unused. But it hopefully could get tuned.


This is basically just a start of the journey. I hope that it will be a
good one.

Best Regards,
Petr
