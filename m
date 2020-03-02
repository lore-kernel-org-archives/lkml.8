Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F22F214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCBMSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:18:53 -0500
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:41853 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgCBMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:18:53 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D8764100E7B46;
        Mon,  2 Mar 2020 12:18:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mouth08_4d1868ea18439
X-Filterd-Recvd-Size: 2221
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Mar 2020 12:18:49 +0000 (UTC)
Message-ID: <843d33f05fabc63329b3d305a25f0a31e9fba7b5.camel@perches.com>
Subject: Re: misc nits Re: [PATCH 1/2] printk: add lockless buffer
From:   Joe Perches <joe@perches.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 04:17:18 -0800
In-Reply-To: <87r1ybujm5.fsf@linutronix.de>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
         <20200128161948.8524-2-john.ogness@linutronix.de>
         <20200221120557.lxpeoy6xuuqxzu5w@pathway.suse.cz>
         <87r1ybujm5.fsf@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 11:38 +0100, John Ogness wrote:
> On 2020-02-21, Petr Mladek <pmladek@suse.com> wrote:
> > > diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
[]
> > > +static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
> > > +				       unsigned long begin_lpos)
> > > +{
> > > +	char *data = &data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
> > > +
> > > +	return (struct prb_data_block *)data;
> > 
> > Nit: Please, use "blk" instead of "data". I was slightly confused
> > because "data" is also one member of struct prb_data_block.
> 
> OK.

trivia:

Perhaps use void * instead of char * and a direct return
and avoid the naming altogether.

static struct prb_data_block *to_block(struct prb_data_ring *data_ring, 
				       unsigned long begin_lpos)
{
	return (void *)&data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
}

