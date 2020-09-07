Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE4BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002C92078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgIGJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgIGJyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:54:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17DB2AD39;
        Mon,  7 Sep 2020 09:54:39 +0000 (UTC)
Date:   Mon, 7 Sep 2020 11:54:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
Message-ID: <20200907095437.GD8084@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <874kod6fgh.fsf@jogness.linutronix.de>
 <20200904124530.GB20558@alley>
 <87y2lp4r6o.fsf@jogness.linutronix.de>
 <20200904151336.GC20558@alley>
 <87ft7xazsf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft7xazsf.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-09-05 01:33:12, John Ogness wrote:
> On 2020-09-04, Petr Mladek <pmladek@suse.com> wrote:
> >>> I am currently playing with support for all three timestamps based
> >>> on https://lore.kernel.org/lkml/20200814101933.574326079@linutronix.de/
> >>>
> >>> And I got the following idea:
> >>>
> >>> 1. Storing side:
> >>>
> >>>    Create one more ring/array for storing the optional metadata.
> >>>    It might eventually replace dict ring, see below.
> >>>
> >>>    struct struct printk_ext_info {
> >>> 	u64 ts_boot;			/* timestamp from boot clock */
> >>> 	u64 ts_real;			/* timestamp from real clock */
> >>> 	char process[TASK_COMM_LEN];	/* process name */
> >>>    };
> >>>
> >>>    It must be in a separate array so that struct prb_desc stay stable
> >>>    and crashdump tools do not need to be updated so often.
> >>>
> >>>    But the number of these structures must be the same as descriptors.
> >>>    So it might be:
> >>>
> >>>    struct prb_desc_ring {
> >>> 	unsigned int		count_bits;
> >>> 	struct prb_desc		*descs;
> >>> 	struct printk_ext_info  *ext_info
> >>> 	atomic_long_t		head_id;
> >>> 	atomic_long_t		tail_id;
> >>>    };
> >>>
> >>>    One huge advantage is that these extra information would not block
> >>>    pushing lockless printk buffer upstream.
> >>>
> >>>    It might be even possible to get rid of dict ring and just
> >>>    add two more elements into struct printk_ext_info:
> >>>
> >>> 	  char subsystem[16];	/* for SUBSYSTEM= dict value */
> >>> 	  char device[48];	/* for DEVICE= dict value */
> >
> > From my POV, if we support 3 timestamps then they must be stored
> > reliably. And dict ring is out of the game.
> 
> Agreed. I am just trying to think of how to better manage the strings,
> which currently are rare and optional. That is where the dict_ring
> becomes interesting.
> 
> Perhaps we should use both the fixed structs with the variable
> dict_ring. printk_ext_info could look like this:
> 
> struct struct printk_ext_info {
>     u64 ts_boot;
>     u64 ts_real;
>     char *process;
>     char *subsystem;
>     char *device;
> };
> 
> And @process, @subsystem, @device could all point to null-terminated
> trings within the dict_ring. So printk.c code looks something like this:

Yeah, it would be possible. But I would prefer to start with something
simple. We could always make it more complicated when people
complains.

This extra metadata are not currently read by crashdump tools.
It should be much easier to change them at least in the near future.

> The whole point of the dict_ring is that it allows for variable length
> _optional_ data to be stored. If we decide there is no optional data,
> then dict_ring is not needed.

I know but they are currently used only for subsystem and device names.

I tried to find what are the longest subsystem and device names. They
are limited already now by the buffer for formatting the dictionary in
dev_printk_emit():

	char hdr[128];

and create_syslog_header() prints a warning when the buffer is not
enoung:

	dev_WARN(dev, "device/subsystem name too long");

Google has shown only one syscaller report with this error message,
see
https://lore.kernel.org/lkml/001a113a36724a053a0562f93c05@google.com/


First, dev_WARN() looks like an overhead. Simple printk() should
be enough. Anyway, this type of error is not a reason for panicing
the system.

Second, I believe that limit device name to 48 characters should
work well in practice. Note that it is not clear how many people,
if any, is using the journalctl filtering. And shrinked device name
should be better than missing one.


I personally would prefer to replace the dict ring with the array.
Bot solutions are not fully reliable. But the array is easier
and we would need it for the timestamps, cpu number, and maybe
some other metadata anyway.

We could always add the dict ring back again when there is
a good use for it.

Best Regards,
Petr
