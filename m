Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D1C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1380020684
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgIDMpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:45:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgIDMpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:45:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7590CAF06;
        Fri,  4 Sep 2020 12:45:32 +0000 (UTC)
Date:   Fri, 4 Sep 2020 14:45:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
Message-ID: <20200904124530.GB20558@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <874kod6fgh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kod6fgh.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-04 11:53:42, John Ogness wrote:
> On 2020-09-04, Changki Kim <changki.kim@samsung.com> wrote:
> > Printk() meesages are the most basic and useful debug method.
> > However, additional information needs in multi-processor.
> > If we add messages with processor id and process name, we can find
> > a problem only with messages when the problem occurs with H/W IP or CPU.
> > This is very useful in narrowing down the scope of the problems.
> 
> [...]
> 
> > diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> > index e6302da041f9..fcefe9516606 100644
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -21,6 +22,12 @@ struct printk_info {
> >  	u8	flags:5;	/* internal record flags */
> >  	u8	level:3;	/* syslog level */
> >  	u32	caller_id;	/* thread id or processor id */
> > +#ifdef CONFIG_PRINTK_PROCESS
> > +	int	pid;			/* process id */
> > +	u8	cpu_id;			/* processor id */
> > +	u8	in_interrupt;		/* interrupt conext */
> > +	char process[TASK_COMM_LEN];	/* process name */
> > +#endif
> >  };
> 
> I can understand the desire to have more information with messages. But
> IMHO adding it to the ringbuffer descriptor is the wrong place for
> it. The descriptor should really be limited to data that the printk
> subsystem needs for _itself_.

I fully agree.

> With respect to LOG_CONT, I think we can agree that @caller_id is
> not enough. But there has been discussions [0]
> of having @caller_id provide a better context representation.

I am not sure if I read the above correctly. Anyway, @caller_id is
needed by printk() to handle continuous lines. It would be great
to store more precise information about the irq context. But
more details, like process name, have to be stored somewhere else.


> If we want to support adding more meta information to messages, I would
> prefer that the information is either prepended directly to the message
> text string or appended to the dictionary text string.

I have two problems with dict ring:

   + does not guarantee enough space to always store the metadata
   + waste of space by repeating the same prefixes again and again


I am currently playing with support for all three timestamps based
on https://lore.kernel.org/lkml/20200814101933.574326079@linutronix.de/

And I got the following idea:


1. Storing side:

   Create one more ring/array for storing the optional metadata.
   It might eventually replace dict ring, see below.

   struct struct printk_ext_info {
	u64 ts_boot;			/* timestamp from boot clock */
	u64 ts_real;			/* timestamp from real clock */
	char process[TASK_COMM_LEN];	/* process name */
   };

   It must be in a separate array so that struct prb_desc stay stable
   and crashdump tools do not need to be updated so often.

   But the number of these structures must be the same as descriptors.
   So it might be:

   struct prb_desc_ring {
	unsigned int		count_bits;
	struct prb_desc		*descs;
	struct printk_ext_info  *ext_info
	atomic_long_t		head_id;
	atomic_long_t		tail_id;
   };

   One huge advantage is that these extra information would not block
   pushing lockless printk buffer upstream.

   It might be even possible to get rid of dict ring and just
   add two more elements into struct printk_ext_info:

	  char subsystem[16];	/* for SUBSYSTEM= dict value */
	  char device[48];	/* for DEVICE= dict value */

   Pros:

	+ the information will always get stored

   Cons:

	+ the names might get shrinked

   Space usage:

	+ No need to store "SUBSYSTEM=" and "DEVICE=" repeatedly.
	+ Space used only for dev_printk()


   Well, I think that it might work in practice.



2. Reading side:

   + /dev/kmsg is easy. It makes perfect sense to pass all extra
     information in the dictionary format:

       + less effective but /dev/kmsg is fast
       + does not break userspace
       + might be shown even by the current journalctl


    + syslog syscall and /proc/syslog are hard to extend.
      I would ignore them. Users need to use /dev/kmsg to
      get the dictionary metadata already now.


    + console is a sensitive beast

      The output format would need to be configurable using
      build/boot/runtime options. It is already the case
      for the timestamp, see printk_time parameter.

      And people would probably want to have this configurable
      per-console to disable this on the slow ones, sigh.


Best Regards,
Petr
