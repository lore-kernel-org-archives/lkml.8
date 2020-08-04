Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A97C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9EC22B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHDKOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:14:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:47284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgHDKOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:14:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 059FEB595;
        Tue,  4 Aug 2020 10:14:17 +0000 (UTC)
Date:   Tue, 4 Aug 2020 12:14:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] printk: ringbuffer: support dataless records
Message-ID: <20200804101400.GB24529@alley>
References: <20200721132528.9661-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721132528.9661-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-07-21 15:31:28, John Ogness wrote:
> With commit ("printk: use the lockless ringbuffer"), printk()
> started silently dropping messages without text because such
> records are not supported by the new printk ringbuffer.
> 
> Add support for such records.
> 
> Currently dataless records are denoted by INVALID_LPOS in order
> to recognize failed prb_reserve() calls. Change the ringbuffer
> to instead use two different identifiers (FAILED_LPOS and
> NO_LPOS) to distinguish between failed prb_reserve() records and
> successful dataless records, respectively.
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 7355ca99e852..0659b50872b5 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
>  static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  {
>  	struct prb_data_block *db = NULL;
>  
> -	/*
> -	 * Writers are not allowed to write data-less records. Such records
> -	 * are used only internally by the ringbuffer to denote records where
> -	 * their data failed to allocate or have been lost.
> -	 */
>  	if (size == 0)
> -		return false;
> +		return true;

Nit: This might deserve a comment why size == 0 is handled
     a special way.specially. I think about something like:

	/*
	 * Empty data blocks are handled by special lpos values in
	 * the record descriptor. No space is needed in the data ring.
	 */

or simply

	/* Data-less records take no space in the data ring. */

>  	/*
>  	 * Ensure the alignment padded size could possibly fit in the data

> @@ -1025,6 +1020,10 @@ static char *data_alloc(struct printk_ringbuffer *rb,
>  static unsigned int space_used(struct prb_data_ring *data_ring,
>  			       struct prb_data_blk_lpos *blk_lpos)
>  {
> +	/* Data-less blocks take no space. */
> +	if (LPOS_DATALESS(blk_lpos->begin))
> +		return 0;

Nit: It seems that all the other locations check also blk_lpos->next,
     for example, get_data() does:

	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {


     Both approaches are error prone. I would either simplify the
     other locations and check only lpos->begin. But better might
     be to be on the safe side do a paranoid check, like:

bool is_dataless(struct prb_data_blk_lpos *blk_lpos)
{
	if (LPOS_DATALESS(blk_lpos->begin) || LPOS_DATALESS(blk_lpos->next)) {
		WARN_ON_ONCE(blk_lpos->begin != blk_lpos->next);
		return true;
	}

	return false;
}

> +
>  	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
>  		/* Data block does not wrap. */
>  		return (DATA_INDEX(data_ring, blk_lpos->next) -

Anyway, the patch looks fine. It is already pushed in
printk/linux.git. So, if you agree with my nits, we should
solve them with separate patches on top of the existing ones.

Best Regards,
Petr
