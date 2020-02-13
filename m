Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF3C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61CB2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBMWgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:36:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMWgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:36:32 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j2N5v-0004iY-OO; Thu, 13 Feb 2020 23:36:27 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-3-john.ogness@linutronix.de>
        <20200213090757.GA36551@google.com> <87v9oarfg4.fsf@linutronix.de>
        <20200213115957.GC36551@google.com>
Date:   Thu, 13 Feb 2020 23:36:25 +0100
In-Reply-To: <20200213115957.GC36551@google.com> (Sergey Senozhatsky's message
        of "Thu, 13 Feb 2020 20:59:57 +0900")
Message-ID: <87pneiyv12.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>> @@ -890,30 +758,26 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>>>>  
>>>>  		logbuf_unlock_irq();
>>>>  		ret = wait_event_interruptible(log_wait,
>>>> -					       user->seq != log_next_seq);
>>>> +					prb_read_valid(prb, user->seq, r));
>>>>  		if (ret)
>>>>  			goto out;
>>>>  		logbuf_lock_irq();
>>>>  	}
>>>>  
>>>> -	if (user->seq < log_first_seq) {
>>>> -		/* our last seen message is gone, return error and reset */
>>>> -		user->idx = log_first_idx;
>>>> -		user->seq = log_first_seq;
>>>> +	if (user->seq < r->info->seq) {
>>>> +		/* the expected message is gone, return error and reset */
>>>> +		user->seq = r->info->seq;
>>>>  		ret = -EPIPE;
>>>>  		logbuf_unlock_irq();
>>>>  		goto out;
>>>>  	}
>>>
>>> Sorry, why doesn't this do something like
>>>
>>> 	if (user->seq < prb_first_seq(prb)) {
>>> 		/* the expected message is gone, return error and reset */
>>> 		user->seq = prb_first_seq(prb);
>>> 		ret = -EPIPE;
>>> 		...
>>> 	}
>> 
>> Here prb_read_valid() was successful, so a record _was_ read. The
>> kerneldoc for the prb_read_valid() says:
>
> Hmm, yeah. That's true.
>
> OK, something weird...
>
> I ran some random printk-pressure test (mostly printks from IRQs;
> + some NMI printk-s, but they are routed through nmi printk-safe
> buffers; + some limited number of printk-safe printk-s, routed
> via printk-safe buffer (so, once again, IRQ); + user-space
> journalctl -f syslog reader), and after the test 'cat /dev/kmsg'
> is terminally broken
>
> [..]
> cat /dev/kmsg
> cat: /dev/kmsg: Broken pipe

In mainline you can have this "problem" as well. Once the ringbuffer has
wrapped, any read to a newly opened /dev/kmsg when a new message arrived
will result in an EPIPE. This happens quite easily once the ringbuffer
has wrapped because each new message is overwriting the oldest message.

Although it can be convenient, cat(1) is actually a poor tool for
viewing the ringbuffer for this reason. Unfortunately dmesg(1) is
sub-optimal as well because it does not show the sequence numbers. So
with dmesg(1) you cannot see if a message was dropped. :-/

> So I printed seq numbers from devksmg read to a seq buffer and dumped
> it via procfs, just seq numbers before we adjust user->seq (set to
> r->seq) and after
>
> +                       offt += snprintf(BUF + offt,
> +                                       sizeof(BUF) - offt,
> +                                       "%s: devkmsg_read() error %llu %llu %llu\n",
> +                                       current->comm,
> +                                       user->seq,
> +                                       r->info->seq,
> +                                       prb_first_seq(prb));
>
>
> ...
> systemd-journal: devkmsg_read() error 1979281 1982465 1980933
> systemd-journal: corrected seq 1982465 1982465
> cat: devkmsg_read() error 1980987 1982531 1980987
> cat: corrected seq 1982531 1982531
> cat: devkmsg_read() error 1981015 1982563 1981015
> cat: corrected seq 1982563 1982563

The situation with a data-less record is the same as when the ringbuffer
wraps: cat is hitting that EPIPE. But re-opening the file descriptor is
not going to help because it will not be able to get past that data-less
record.

We could implement it such that devkmsg_read() will skip over data-less
records instead of issuing an EPIPE. (That is what dmesg does.) But then
do we need EPIPE at all? The reader can see that is has missed records
by tracking the sequence number, so could we just get rid of EPIPE? Then
cat(1) would be a great tool to view the raw ringbuffer. Please share
your thoughts on this.


On a side note (but related to data-less records): I hacked the
ringbuffer code to inject data-less records at various times in order to
verify your report. And I stumbled upon a bug in the ringbuffer, which
can lead to an infinite loop in console_unlock(). The problem occurs at:

    retry = prb_read_valid(prb, console_seq, NULL);

which will erroneously return true if console_seq is pointing to a
data-less record but there are no valid records after it. The following
patch fixes the bug. And yes, for v2 I have added comments to the
desc_read_committed() code.

I now have 2 bugfixes queued up for v2. The first one is here[0].

[0] https://lkml.kernel.org/r/87wo919grz.fsf@linutronix.de

John Ogness


diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 796257f226ee..31893051ad6b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1074,6 +1071,7 @@ static int desc_read_committed(struct prb_desc_ring *desc_ring,
 			       unsigned long id, u64 seq,
 			       struct prb_desc *desc)
 {
+	struct prb_data_blk_lpos *blk_lpos = &desc->text_blk_lpos;
 	enum desc_state d_state;
 
 	d_state = desc_read(desc_ring, id, desc);
@@ -1084,6 +1082,11 @@ static int desc_read_committed(struct prb_desc_ring *desc_ring,
 	else if (d_state != desc_committed)
 		return -EINVAL;
 
+	if (blk_lpos->begin == INVALID_LPOS &&
+	    blk_lpos->next == INVALID_LPOS) {
+		return -ENOENT;
+	}
+
 	return 0;
 }
 
