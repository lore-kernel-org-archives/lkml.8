Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C49C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGJOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:15:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgGJOPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:15:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65580ABDE;
        Fri, 10 Jul 2020 14:15:28 +0000 (UTC)
Date:   Fri, 10 Jul 2020 16:15:27 +0200
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
Message-ID: <20200710141527.GP4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200708152005.GF4751@alley>
 <87wo3d9nlo.fsf@jogness.linutronix.de>
 <20200710091137.GN4751@alley>
 <87o8onhf31.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8onhf31.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-07-10 11:58:34, John Ogness wrote:
> On 2020-07-10, Petr Mladek <pmladek@suse.com> wrote:
> >> The next series in the printk-rework (move LOG_CONT handling from
> >> writers to readers) makes some further changes that, while not
> >> incompatible, could affect the output of existing tools. It may be a
> >> good idea to let the new ringbuffer sit in linux-next until the next
> >> series has been discussed/reviewed/merged. After the next series,
> >> everything will be in place (with regard to userspace tools) to
> >> finish the rework.
> >
> > I know that it might be premature question. But I wonder what kind
> > of changes are expected because of the continuous lines.
> 
> I will be posting the next series quite soon, so I think it will be
> better to discuss it when we have a working example in front of us.

sure

> > Do you expect some changes in the ring buffer structures so that
> > the debugging tools would need yet another update to actually
> > access the data?
>
> The next series will be modifying the ringbuffer to allow data-less
> records. This is necessary to support the thousands of
> 
>     pr_cont("\n");
> 
> calls in the kernel code. Failed dataring allocations will still be
> detected because the message flags for those records will be 0. For the
> above pr_cont() line, they will be LOG_NEWLINE|LOG_CONT.
> 
> Since the dump tools need to make changes for the new ringbuffer anyway,
> I think it would be good to hammer out the accepted LOG_CONT
> implementation first, just in case we do need to make any subtle
> internal changes.

Makes sense.


> > Or do you expect backward compatible changes that would allow
> > to pass related parts of the continuous lines via syslog/dev_kmsg
> > interface and join them later in userspace?
> 
> For users of console, non-extended netconsole, syslog, and kmsg_dump,
> there will be no external changes whatsoever. These interfaces have no
> awareness of sequence numbers, which will allow the kernel to
> re-assemble the LOG_CONT messages for them.

yup

> Users of /dev/kmsg and extended netconsole see sequence numbers. Offlist
> we discussed various hacks how to get around this without causing errors
> for existing software, but it was all ugly.
> 
> IMHO users of these sequence number interfaces need to see all the
> records individually and reassemble the LOG_CONT messages themselves if
> they want to. I believe that is the only sane path forward. To do this,
> the caller id will no longer be optional to the sequence number output
> since that is vital information to re-assemble the LOG_CONT messages.
> 
> Keep in mind that current software already needs to be able to handle
> the caller id being shown. Also, currently in mainline there is no
> guarantee that LOG_CONT messages are contiguous. So current software
> must also be ready to accept broken up LOG_CONT messages. This is why I
> think it would be acceptable to make this change for /dev/kmsg and
> extended netconsole. But I understand it is controversial since tools
> like systemd and dmesg use /dev/kmsg. Until they are modified to
> re-assemble LOG_CONT messages, they will present the user with the
> ugliness of LOG_CONT pieces (always, rather than as is now rarely).

I am not completely sure how often newline is used in common messages.
I hope that it is more frequently used in a debug code that has to
dump many details.

If my assumption is correct then your proposed approach should be well
acceptable. Normal people will not notice. Developers should be able
to deal with it, especially when a reasonable output might be seen
on consoles, via dmesg or crashdumnp.

Anyway, the proposal looks fine to me. I hope that it will work :-)
Let's continue the discussion when you send the patchset.

Best Regards,
Petr
