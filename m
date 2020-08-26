Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B7CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA2B20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JtLWwenJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OFqmKblX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHZIjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgHZIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:39:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF964C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:39:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598431144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioAxhFzpgilIVQ5B/okT+TPEavcUfC9KtYUnzhhh+Ks=;
        b=JtLWwenJ18uKrMm4N/jo2ul6kSyZwObGCDwv6DwIwVEg7usFORbY1SjARm/j14RLqB4b+q
        S8GvBbN798/cmEebuV2eZ2526CKgVDob4AOKc1zmc90C212141gw8/sg1Dwh72Z4ZtTUaj
        1j0qg/+J68dno8tdo2E2FF3zAUj+DUEsp2gS/bAZdMKu/01oXYnB1oQcs5i5nxWKzUTDGl
        P2SVW6g0fr9f3rFRyFfL7Uh+3iwdARSDGBb2dWzlq/BBZ/W/QZsBeJ1J6YEIbc/JRCeaXh
        UeNOifnXQx143BOjaDCPHiJFU6WcSd1Hxs1CeUsXras0X2+q2MO4REN4rsoSjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598431144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioAxhFzpgilIVQ5B/okT+TPEavcUfC9KtYUnzhhh+Ks=;
        b=OFqmKblXPVRfXFuD9xS0kEtUZOoRkr07eTSRqcDIwu7oQ5a2O7LkRSmNJgMrOf180ux/bY
        jMw+8wWqEZANCzCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add finalization/extension support
In-Reply-To: <20200824103538.31446-6-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de> <20200824103538.31446-6-john.ogness@linutronix.de>
Date:   Wed, 26 Aug 2020 10:45:03 +0206
Message-ID: <87lfi1ls2g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24, John Ogness <john.ogness@linutronix.de> wrote:
> @@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>  		goto fail;
>  	}
>  
> +	/*
> +	 * New data is about to be reserved. Once that happens, previous
> +	 * descriptors are no longer able to be extended. Finalize the
> +	 * previous descriptor now so that it can be made available to
> +	 * readers (when committed).
> +	 */
> +	desc_finalize(desc_ring, DESC_ID(id - 1));
> +
>  	d = to_desc(desc_ring, id);
>  
>  	/*

Apparently this is not enough to guarantee that past descriptors are
finalized. I am able to reproduce a scenario where the finalization of a
certain descriptor never happens. That leaves the descriptor permanently
in the reserved queried state, which prevents any new records from being
created. I am investigating.

John Ogness
