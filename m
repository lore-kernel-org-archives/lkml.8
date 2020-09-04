Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97197C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B4D2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgIDPNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:13:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbgIDPNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:13:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3F0DAD2C;
        Fri,  4 Sep 2020 15:13:38 +0000 (UTC)
Date:   Fri, 4 Sep 2020 17:13:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
Message-ID: <20200904151336.GC20558@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <874kod6fgh.fsf@jogness.linutronix.de>
 <20200904124530.GB20558@alley>
 <87y2lp4r6o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2lp4r6o.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-04 15:23:19, John Ogness wrote:
> On 2020-09-04, Petr Mladek <pmladek@suse.com> wrote:
> > I am currently playing with support for all three timestamps based
> > on https://lore.kernel.org/lkml/20200814101933.574326079@linutronix.de/
> >
> > And I got the following idea:
> >
> > 1. Storing side:
> >
> >    Create one more ring/array for storing the optional metadata.
> >    It might eventually replace dict ring, see below.
> >
> >    struct struct printk_ext_info {
> > 	u64 ts_boot;			/* timestamp from boot clock */
> > 	u64 ts_real;			/* timestamp from real clock */
> > 	char process[TASK_COMM_LEN];	/* process name */
> >    };
> >
> >    It must be in a separate array so that struct prb_desc stay stable
> >    and crashdump tools do not need to be updated so often.
> >
> >    But the number of these structures must be the same as descriptors.
> >    So it might be:
> >
> >    struct prb_desc_ring {
> > 	unsigned int		count_bits;
> > 	struct prb_desc		*descs;
> > 	struct printk_ext_info  *ext_info
> > 	atomic_long_t		head_id;
> > 	atomic_long_t		tail_id;
> >    };
> >
> >    One huge advantage is that these extra information would not block
> >    pushing lockless printk buffer upstream.
> >
> >    It might be even possible to get rid of dict ring and just
> >    add two more elements into struct printk_ext_info:
> >
> > 	  char subsystem[16];	/* for SUBSYSTEM= dict value */
> > 	  char device[48];	/* for DEVICE= dict value */
> 
> You say "get rid of dict ring", but there is nothing requiring the
> dict_ring to be strings. It can be binary data. The @data of the
> prb_data_block struct could be a printk_ext_info struct. This would be
> trivial to implement in printk.c and would not require any ringbuffer
> changes. (My ringbuffer test software [0] uses binary structs for the
> data.)
>
> Using VMCOREINFO we can provide the printk_ext_info size and field
> offsets for crash tools.
> 
> >    Pros:
> >
> > 	+ the information will always get stored
> 
> If the dict_ring is "_DESCS_COUNT() * sizeof(struct printk_ext_info)"
> then it would also always get stored. Although this does seem like a bit
> of a waste of space in order to cover the worst case scenario of all
> records using all fields.

The opposite is that the extended metadata might be missing for some
lines. This might cause quite some confusion.

For example, I can't find any reasonable way how to produce missing
timestamps.

From my POV, if we support 3 timestamps then they must be stored
reliably. And dict ring is out of the game.


And I am not comfortable even with the current dictionary handling.
I already wrote this somewhere. The following command is supposed
to show all kernel messages printed by "pci" subsystem:

	$> journalctl _KERNEL_SUBSYSTEM=pci

It will be incomplete when the dictionary metadata were not saved.

You might argue that the problem already exists when the entire
message gets lost. But this situation can be detected by missing
sequence numbers and journalctl even add messages about it.
But the user currently is not informed about missing
dictionary.


Regarding the waste of space. The dict ring currently has the same
size as the text ring. It is likely a waste of space as well. Any tuning
is complicated because it depends on the use case.

The advantage of the fixed @ext_info[] array is that everything is
clear, simple, and predictable (taken space and name length limits).
We could easily tell users what they will get for a given cost.

Best Regards,
Petr
