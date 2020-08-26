Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C94C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAAD2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T6Am/23J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+ggM4/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgHZMh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgHZMhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:37:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8EBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:37:24 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598445442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlt9S/UsA1PTgGu91u0P7+MdmhnGevB0IRj1HFjAdgQ=;
        b=T6Am/23J07Sv8ujvdcXTn1Gb2zxhRvOo+CnuyMFXbBBZmtNNAGTOZY5WXDv2Nxk6YginBn
        76cLWGZp0Ygomvj1ijXvq8qSmU1wvvxS/YP1nS3BqVxIRHX8/d2W+ZEq+QnZm3F6c1feYs
        PAL83Q6cOiTSrdMv2UQ+BOo9Qo9miA9K5+tVhWO4qp/ncpnK1OcSIopC37yodWFA/XdhP6
        Le8o2ilUdCPLXEvxh5Iayf9stO6HkhltlqUbOGexC0ILGuI+Erql++91tLgoMItsmqQFc9
        x3R4fxMhTAo6sD7Txnfm2F3FUn0todLvR0UGUuVALCEqzHDRd1ebbaQ2AvDtHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598445442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlt9S/UsA1PTgGu91u0P7+MdmhnGevB0IRj1HFjAdgQ=;
        b=U+ggM4/xASoWvGsQsYa7bCQ8zUBvNFn+N7CHYROnRVLTAWV0I5JTAJsRpEL62CI5MNlCHh
        G+R1ISwygFNGM2AQ==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
In-Reply-To: <20200826100113.GA8849@jagdpanzerIV.localdomain>
References: <20200824103538.31446-1-john.ogness@linutronix.de> <20200824103538.31446-6-john.ogness@linutronix.de> <87lfi1ls2g.fsf@jogness.linutronix.de> <20200826100113.GA8849@jagdpanzerIV.localdomain>
Date:   Wed, 26 Aug 2020 14:43:22 +0206
Message-ID: <87eentlh19.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>>> @@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>>>  		goto fail;
>>>  	}
>>>  
>>> +	/*
>>> +	 * New data is about to be reserved. Once that happens, previous
>>> +	 * descriptors are no longer able to be extended. Finalize the
>>> +	 * previous descriptor now so that it can be made available to
>>> +	 * readers (when committed).
>>> +	 */
>>> +	desc_finalize(desc_ring, DESC_ID(id - 1));
>>> +
>>>  	d = to_desc(desc_ring, id);
>>>  
>>>  	/*
>> 
>> Apparently this is not enough to guarantee that past descriptors are
>> finalized. I am able to reproduce a scenario where the finalization
>> of a certain descriptor never happens. That leaves the descriptor
>> permanently in the reserved queried state, which prevents any new
>> records from being created. I am investigating.
>
> Good to know. I also run into problems:
> - broken dmesg (and broken journalctl -f /dev/kmsg poll) and broken
>   syslog read
>
> $ strace dmesg
>
> ...
> openat(AT_FDCWD, "/dev/kmsg", O_RDONLY|O_NONBLOCK) = 3
> lseek(3, 0, SEEK_DATA)                  = 0
> read(3, 0x55dda8c240a8, 8191)           = -1 EAGAIN (Resource temporarily unavailable)
> close(3)                                = 0
> syslog(10 /* SYSLOG_ACTION_SIZE_BUFFER */) = 524288
> mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f43ea847000
> syslog(3 /* SYSLOG_ACTION_READ_ALL */, "", 524296) = 0

Yes, this a consequence of the problem. The tail is in the reserved
queried state, so readers will not advance beyond it.

This series makes a very naive assumption that the previous descriptor
is either in the reserved or committed queried states. The fact is, it
can be in any of the 4 queried states. Adding support for finalization
of all the states then gets quite complex, since any state transition
(cmpxchg) may have to deal with an unexpected FINAL flag.

The ringbuffer was designed so that descriptors are completely
self-contained. So adding logic where an action on one descriptor should
affect another descriptor is far more complex than I initially expected.

Keep in mind the finalization concept satisfies 3 things:

- denote if a record can be extended (i.e. transition back to reserved)
- denote if a reader may read the record
- denote if a writer may recycle a record

I have not yet given up on the idea of finalization (particularly
because it allows mainline LOG_CONT behavior to be preserved locklessy),
but I am no longer sure if this is the direction we want to take.

John Ogness
