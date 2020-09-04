Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DAFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B5520791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eslhLbsN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HqfY51zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgIDJrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:47:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:47:45 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599212863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hHqBGIebxhiyyM9RTU/4YmnS0Qyo5VtVy50lOnr3r0=;
        b=eslhLbsN8es9czlhxK3GR8OzcmbFf+wg4TCB+N+1tn/6Zx/1TmbmH/K2tOTTRqAjsIyrFy
        73VcPHoXPswqI4YeCXBfMblYe3dc/855BdojPtdSUdLZJlwMoaogaNhgSlXN2V3NR8U3qk
        FqfQw7GIfY7RXSw3AfbZ/C0fAv80bhSdpctOTOx9P2Rx1XbQ/TUzvsJMs+4vBOUmYrDxee
        2EMeKKthZ5oa+2MH+4a909VA3ORCiMaZqZGZuxOzAQeWeO352GYYwXAXnQdAfz5zYNnrIR
        omXAxOWbe1KLKrydIyswmbuHsc0tWFovtZBX5yiotZz4L8kaGSpgwMmvrHp9mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599212863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hHqBGIebxhiyyM9RTU/4YmnS0Qyo5VtVy50lOnr3r0=;
        b=HqfY51zjqESfOoxOeRseFBpK8uPVB7wZD+d/tsSFF3dyPbGgGrKW6XXeXKo7RxzwR+jhvl
        G2uixpTkUmtzggDg==
To:     Changki Kim <changki.kim@samsung.com>, pmladek@suse.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org, Changki Kim <changki.kim@samsung.com>
Subject: Re: printk: Add process name information to printk() output.
In-Reply-To: <20200904082438.20707-1-changki.kim@samsung.com>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com> <20200904082438.20707-1-changki.kim@samsung.com>
Date:   Fri, 04 Sep 2020 11:53:42 +0206
Message-ID: <874kod6fgh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-04, Changki Kim <changki.kim@samsung.com> wrote:
> Printk() meesages are the most basic and useful debug method.
> However, additional information needs in multi-processor.
> If we add messages with processor id and process name, we can find
> a problem only with messages when the problem occurs with H/W IP or CPU.
> This is very useful in narrowing down the scope of the problems.

[...]

> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index e6302da041f9..fcefe9516606 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -21,6 +22,12 @@ struct printk_info {
>  	u8	flags:5;	/* internal record flags */
>  	u8	level:3;	/* syslog level */
>  	u32	caller_id;	/* thread id or processor id */
> +#ifdef CONFIG_PRINTK_PROCESS
> +	int	pid;			/* process id */
> +	u8	cpu_id;			/* processor id */
> +	u8	in_interrupt;		/* interrupt conext */
> +	char process[TASK_COMM_LEN];	/* process name */
> +#endif
>  };

I can understand the desire to have more information with messages. But
IMHO adding it to the ringbuffer descriptor is the wrong place for
it. The descriptor should really be limited to data that the printk
subsystem needs for _itself_. With respect to LOG_CONT, I think we can
agree that @caller_id is not enough. But there has been discussions [0]
of having @caller_id provide a better context representation.

If we want to support adding more meta information to messages, I would
prefer that the information is either prepended directly to the message
text string or appended to the dictionary text string. We could even go
so far as providing a boot argument where a list of information could be
specified, what should be automatically added to the text/dict strings
of each message. That would not require any ringbuffer changes and would
allow new types of information to be added later.

Something like:

    printk.format=ts,cpu,comm,pid,in_atomic

John Ogness

[0] https://lkml.kernel.org/r/20200719143527.GA566@jagdpanzerIV.localdomain
