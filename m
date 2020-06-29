Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6722C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FCF206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKXYGJmt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5bCsnwV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404572AbgF2Vvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404569AbgF2Vvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:51:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C73C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:51:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593467502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=siVZWIEnwE41C7ZxHsZfQ8/Re56UAlzQKcSRDT+JiwE=;
        b=IKXYGJmt9+3Ei4t1+Bz9jNVCq5EyBhJN4FxcPlnhlriH3eqv1MsTGz+xRnHdHDt0MdwjAZ
        GgC/iiIB5osdzoNnLhSWN8WopSY5+H2icQKjzEAsbVzPTQEvwT7j3BiGUke+vmxAisBCVf
        ncxdG+J5IclAPaNTpWyACqalFl+HvjJ18ehxf14FR5l9si8QVQiNGyyhqKcCaRzp+bSlCe
        3HfQdz2WnIxanWg9QdWnbTdRRUl9QUALzpFJOp88k2eTtqHX97GFc/zeFuG8FQcH+itufC
        GKq9M863SUY4Byx3DH2OO1kBh+nuTCBoYmmih+2F1/feVSJ0c4MP5ERnCyZ7uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593467502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=siVZWIEnwE41C7ZxHsZfQ8/Re56UAlzQKcSRDT+JiwE=;
        b=5bCsnwV2vmOJbIXbrSqZo66YzWmyOSG5xc215ieN3Sqv6ET2KdOCpBcPMjC/fZH1IV3ZcL
        GMnrZcN4JNSoE9AA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: syslog size unread: was: [PATCH v3 3/3] printk: use the lockless ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
        <20200618144919.9806-4-john.ogness@linutronix.de>
        <20200625152042.GI8444@alley>
Date:   Mon, 29 Jun 2020 23:51:40 +0200
In-Reply-To: <20200625152042.GI8444@alley> (Petr Mladek's message of "Thu, 25
        Jun 2020 17:20:42 +0200")
Message-ID: <87k0zp8rrn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2020-06-18 16:55:19, John Ogness wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1609,11 +1633,15 @@ int do_syslog(int type, char __user *buf, int len, int source)
>>  		break;
>>  	/* Number of chars in the log buffer */
>>  	case SYSLOG_ACTION_SIZE_UNREAD:
>> +		if (source != SYSLOG_FROM_PROC) {
>> +			text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
>> +			if (!text)
>> +				return -ENOMEM;
>
> The buffer is needed only to count lines to count the size of added
> prefixes. Could we use the new prb_read_valid_info() that allows to
> get the number of lines without actually reading the buffer?

Yes!

For the next version I introduce a macro to iterate just the meta data:

#define prb_for_each_info(from, rb, s, i, lc) \
for ((s) = from; prb_read_valid_info(rb, s, i, lc); (s) = (i)->seq + 1)

This can be used in all 3 locations where prb_count_lines() is used. In
all three places, there is no need to be copying the data. And for
SYSLOG_ACTION_SIZE_UNREAD, there is no need for the record and kmalloc'd
buffer.

This also means that prb_count_lines() will become a private static
helper of the ringbuffer.

John Ogness
