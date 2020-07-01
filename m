Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00098C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF31220748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VcccQpHI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ElYBtgVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgGAT6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:58:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAT6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:58:22 -0400
X-Greylist: delayed 165618 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jul 2020 15:58:21 EDT
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593633499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lT9zajvxSVCwKbbkbNiXXnFEejqxJREj9fDOL+2G3jc=;
        b=VcccQpHIsvg8wpMdxlOWoKrNzGvYmajmmFoLXjzZUKKQILCYVYE5LfRrogTRZ8dDCjlT01
        BdjC+u2eH4lP+V1ra0QBZvUIeE50B9wQprM7isXv9dLDb47VJy9kNo9dQ/YUDGMkktOSSO
        tmhSuClHdemmm5KuiQI2gUDh6+Cuc8ryxcdxgkJgqd6eN2fzopIWXI1Qa4f8oDwLA9b4G2
        SSGS9OVvxcMdrHp/AFW+pi+w1esuge7XuFWEwQBA6LYujcVDxPbTsE4W4M8UH50G6gvc6n
        2y8BItFxCmEaaI+XIs2ya0nhNsZXRjO8JfDgxGZddjHdvn73MfEYoqawlW1FHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593633499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lT9zajvxSVCwKbbkbNiXXnFEejqxJREj9fDOL+2G3jc=;
        b=ElYBtgVaS13sLgg5ngPELxflDHtPZGxBeD5FSbUKtihCrm6sIu6rK4MGDil2f7nPyfYoGt
        MFMRr3WPSDkAf7CA==
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
Subject: Re: pending output optimization: was: [PATCH v3 3/3] printk: use the lockless ringbuffer
In-Reply-To: <20200625151741.GH8444@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de> <20200618144919.9806-4-john.ogness@linutronix.de> <20200625151741.GH8444@alley>
Date:   Wed, 01 Jul 2020 22:04:19 +0206
Message-ID: <87o8oznh2c.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2009,9 +2056,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  
>>  	/* This stops the holder of console_sem just where we want him */
>>  	logbuf_lock_irqsave(flags);
>> -	curr_log_seq = log_next_seq;
>> +	pending_output = !prb_read_valid(prb, console_seq, NULL);
>>  	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
>> -	pending_output = (curr_log_seq != log_next_seq);
>> +	pending_output &= prb_read_valid(prb, console_seq, NULL);
>
> This will stop working after we remove the locks. Consoles will be
> able to handle messages while the new one is being added. There will
> be no gurantee that someone is still hadling the previously pending
> output.
>
> Please, always handle consoles when printed_len is not zero!!!
>
> The pending output was just an optimization added recently. Nobody
> requested it. It was just an idea that made sense.

OK. I will insert a patch before this one that reverts commit
3ac37a93fa92 ("printk: lock/unlock console only for new logbuf
entries"). Then there is no @pending_output for me to implement and it
will be clear that this series is changing/reverting some printk
behavior.

John Ogness
