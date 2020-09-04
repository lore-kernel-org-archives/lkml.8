Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1532BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAADA20797
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjlxQWmC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXmYxx/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgIDNS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbgIDNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:17:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4774C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:17:21 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pllLZNJCvdQsB4JmeBRmHqn2PPQUqy9KaaoJxWXL0jw=;
        b=jjlxQWmCg2xjw7t3Ttq+2JdE4xo99C+Jl/woxtuK+PfTiR2ul3lPUdASaOJ5YaeGeBK1CO
        XijA6W/l3spoPI0Ta1uvoynUDii+vmrthj403hOqdn15GLkiI9vmaPAEdlL0AbcNuwRu4b
        9QgivnKKTF2T7jki71R5qhNlzPofYk/Djv5Hx6FTnEz9RXKxe7Gs3TFcsUW2f+3EKygWKv
        Xkv5pgJ0U3Mp8bzoKu4vfx38nPV4Orjayz7APw2Q6uz0naZ4FfAYzM5/0WmjSpLh3k42Nw
        VsUZqbfoQkUddyH//dn2eGdeIdcUQCMTHbcpQWKRVqZ5yejSn3GqQzxpVh2rMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pllLZNJCvdQsB4JmeBRmHqn2PPQUqy9KaaoJxWXL0jw=;
        b=HXmYxx/y6kt79sCiq4qpzhZCUToy0Hk/DGaunQ/WZNFVHvFoYJBG/6ZZsmcUp4jzXdHVeZ
        N+NhMTD3W7cKgHAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
In-Reply-To: <20200904124530.GB20558@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com> <20200904082438.20707-1-changki.kim@samsung.com> <874kod6fgh.fsf@jogness.linutronix.de> <20200904124530.GB20558@alley>
Date:   Fri, 04 Sep 2020 15:23:19 +0206
Message-ID: <87y2lp4r6o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-04, Petr Mladek <pmladek@suse.com> wrote:
> I am currently playing with support for all three timestamps based
> on https://lore.kernel.org/lkml/20200814101933.574326079@linutronix.de/
>
> And I got the following idea:
>
> 1. Storing side:
>
>    Create one more ring/array for storing the optional metadata.
>    It might eventually replace dict ring, see below.
>
>    struct struct printk_ext_info {
> 	u64 ts_boot;			/* timestamp from boot clock */
> 	u64 ts_real;			/* timestamp from real clock */
> 	char process[TASK_COMM_LEN];	/* process name */
>    };
>
>    It must be in a separate array so that struct prb_desc stay stable
>    and crashdump tools do not need to be updated so often.
>
>    But the number of these structures must be the same as descriptors.
>    So it might be:
>
>    struct prb_desc_ring {
> 	unsigned int		count_bits;
> 	struct prb_desc		*descs;
> 	struct printk_ext_info  *ext_info
> 	atomic_long_t		head_id;
> 	atomic_long_t		tail_id;
>    };
>
>    One huge advantage is that these extra information would not block
>    pushing lockless printk buffer upstream.
>
>    It might be even possible to get rid of dict ring and just
>    add two more elements into struct printk_ext_info:
>
> 	  char subsystem[16];	/* for SUBSYSTEM= dict value */
> 	  char device[48];	/* for DEVICE= dict value */

You say "get rid of dict ring", but there is nothing requiring the
dict_ring to be strings. It can be binary data. The @data of the
prb_data_block struct could be a printk_ext_info struct. This would be
trivial to implement in printk.c and would not require any ringbuffer
changes. (My ringbuffer test software [0] uses binary structs for the
data.)

Using VMCOREINFO we can provide the printk_ext_info size and field
offsets for crash tools.

>    Pros:
>
> 	+ the information will always get stored

If the dict_ring is "_DESCS_COUNT() * sizeof(struct printk_ext_info)"
then it would also always get stored. Although this does seem like a bit
of a waste of space in order to cover the worst case scenario of all
records using all fields.

John Ogness

[0] https://github.com/Linutronix/prb-test.git
