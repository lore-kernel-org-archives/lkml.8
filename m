Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1ACC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89A0207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgA2DxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgA2DxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:53:20 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B459207FF;
        Wed, 29 Jan 2020 03:53:18 +0000 (UTC)
Date:   Tue, 28 Jan 2020 22:53:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: add lockless buffer
Message-ID: <20200128225316.0a735187@rorschach.local.home>
In-Reply-To: <20200128161948.8524-2-john.ogness@linutronix.de>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-2-john.ogness@linutronix.de>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 17:25:47 +0106
John Ogness <john.ogness@linutronix.de> wrote:

> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> new file mode 100644
> index 000000000000..796257f226ee
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -0,0 +1,1370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/irqflags.h>
> +#include <linux/string.h>
> +#include <linux/errno.h>
> +#include <linux/bug.h>
> +#include "printk_ringbuffer.h"
> +
> +/**
> + * DOC: printk_ringbuffer overview
> + *
> + * Data Structure
> + * --------------
> + * The printk_ringbuffer is made up of 3 internal ringbuffers::
> + *
> + *   * desc_ring:      A ring of descriptors. A descriptor contains all record
> + *                     meta data (sequence number, timestamp, loglevel, etc.)
> + *                     as well as internal state information about the record
> + *                     and logical positions specifying where in the other
> + *                     ringbuffers the text and dictionary strings are
> + *                     located.
> + *
> + *   * text_data_ring: A ring of data blocks. A data block consists of an
> + *                     unsigned long integer (ID) that maps to a desc_ring
> + *                     index followed by the text string of the record.
> + *
> + *   * dict_data_ring: A ring of data blocks. A data block consists of an
> + *                     unsigned long integer (ID) that maps to a desc_ring
> + *                     index followed by the dictionary string of the record.
> + *
> + * Implementation
> + * --------------
> + *
> + * ABA Issues
> + * ~~~~~~~~~~
> + * To help avoid ABA issues, descriptors are referenced by IDs (index values
> + * with tagged states) and data blocks are referenced by logical positions
> + * (index values with tagged states). However, on 32-bit systems the number
> + * of tagged states is relatively small such that an ABA incident is (at
> + * least theoretically) possible. For example, if 4 million maximally sized

4 million? I'm guessing that maximally sized printk messages are 1k?

Perhaps say that, otherwise one might think this is a mistake. "4
million maximally sized (1k) printk messages"

> + * printk messages were to occur in NMI context on a 32-bit system, the
> + * interrupted task would not be able to recognize that the 32-bit integer
> + * wrapped and thus represents a different data block than the one the
> + * interrupted task expects.
> + *
> + * To help combat this possibility, additional state checking is performed
> + * (such as using cmpxchg() even though set() would suffice). These extra
> + * checks will hopefully catch any ABA issue that a 32-bit system might
> + * experience.
> + *
[..]

> + * Usage
> + * -----
> + * Here are some simple examples demonstrating writers and readers. For the
> + * examples a global ringbuffer (test_rb) is available (which is not the
> + * actual ringbuffer used by printk)::
> + *
> + *	DECLARE_PRINTKRB(test_rb, 15, 5, 3);
> + *
> + * This ringbuffer allows up to 32768 records (2 ^ 15) and has a size of
> + * 1 MiB (2 ^ 20) for text data and 256 KiB (2 ^ 18) for dictionary data.

 (2 ^ (15 + 5)) ... (2 ^ (15 + 3)) ?

I'll play around more with this this week. But so far it looks good.

-- Steve

> + *
> + * Sample writer code::
> + *
> + *	struct prb_reserved_entry e;
> + *	struct printk_record r;
> + *
> + *	// specify how much to allocate
> + *	r.text_buf_size = strlen(textstr) + 1;
> + *	r.dict_buf_size = strlen(dictstr) + 1;
> + *
> + *	if (prb_reserve(&e, &test_rb, &r)) {
> + *		snprintf(r.text_buf, r.text_buf_size, "%s", textstr);
> + *
> + *		// dictionary allocation may have failed
> + *		if (r.dict_buf)
> + *			snprintf(r.dict_buf, r.dict_buf_size, "%s", dictstr);
> + *
> + *		r.info->ts_nsec = local_clock();
> + *
> + *		prb_commit(&e);
> + *	}
> + *
