Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4FCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3901C20772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gaLtMBfM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oi8TokTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgGJJwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:52:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6946AC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:52:37 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594374755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Km6vAwuriX6Tn2g2G/7pxWYSZJCjiixivHALQxnghlQ=;
        b=gaLtMBfMEd91QUFpoqap5H/jH3FpE7bQVpw8ur1R95T2341r1c4G4nO81uY1zPYPwBbvke
        IVGkmj03jUHIVQYrpx2jUNRp5n4/wO4rhY6jjeecveHiPOmE4Pi5k9ZNFei46LjyXQwQeT
        e1bkk4mG365cR5JIPFdVEwupi8RZTCvMILWfvzhRJ1oBhguT9gC7L1LSyYMJqplL1c93Pf
        uHQfF6XN1zOvnq1+TyF/Mhbtg9Z8vp19NvcFUPzYNagFlKQPjFedxqK/tdrEssRQ4HnO5E
        FsDy0PxoreFh7Jx+ou6ijnGz3kvRSWXW6sciLUDrUM5qoW/XtUYOuk0+S8q2aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594374755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Km6vAwuriX6Tn2g2G/7pxWYSZJCjiixivHALQxnghlQ=;
        b=Oi8TokTjd6ow2X0eetNqW38Nez1o6+drTO1F6JdSqZgYaGXrEl9yjUQ4ybNWPduDFRKSIJ
        oTwbGFtrNuCuqvDA==
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
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
In-Reply-To: <20200710091137.GN4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de> <20200708152005.GF4751@alley> <87wo3d9nlo.fsf@jogness.linutronix.de> <20200710091137.GN4751@alley>
Date:   Fri, 10 Jul 2020 11:58:34 +0206
Message-ID: <87o8onhf31.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-10, Petr Mladek <pmladek@suse.com> wrote:
>> The next series in the printk-rework (move LOG_CONT handling from
>> writers to readers) makes some further changes that, while not
>> incompatible, could affect the output of existing tools. It may be a
>> good idea to let the new ringbuffer sit in linux-next until the next
>> series has been discussed/reviewed/merged. After the next series,
>> everything will be in place (with regard to userspace tools) to
>> finish the rework.
>
> I know that it might be premature question. But I wonder what kind
> of changes are expected because of the continuous lines.

I will be posting the next series quite soon, so I think it will be
better to discuss it when we have a working example in front of us.

> Do you expect some changes in the ring buffer structures so that
> the debugging tools would need yet another update to actually
> access the data?

The next series will be modifying the ringbuffer to allow data-less
records. This is necessary to support the thousands of

    pr_cont("\n");

calls in the kernel code. Failed dataring allocations will still be
detected because the message flags for those records will be 0. For the
above pr_cont() line, they will be LOG_NEWLINE|LOG_CONT.

Since the dump tools need to make changes for the new ringbuffer anyway,
I think it would be good to hammer out the accepted LOG_CONT
implementation first, just in case we do need to make any subtle
internal changes.

> Or do you expect backward compatible changes that would allow
> to pass related parts of the continuous lines via syslog/dev_kmsg
> interface and join them later in userspace?

For users of console, non-extended netconsole, syslog, and kmsg_dump,
there will be no external changes whatsoever. These interfaces have no
awareness of sequence numbers, which will allow the kernel to
re-assemble the LOG_CONT messages for them.

Users of /dev/kmsg and extended netconsole see sequence numbers. Offlist
we discussed various hacks how to get around this without causing errors
for existing software, but it was all ugly.

IMHO users of these sequence number interfaces need to see all the
records individually and reassemble the LOG_CONT messages themselves if
they want to. I believe that is the only sane path forward. To do this,
the caller id will no longer be optional to the sequence number output
since that is vital information to re-assemble the LOG_CONT messages.

Keep in mind that current software already needs to be able to handle
the caller id being shown. Also, currently in mainline there is no
guarantee that LOG_CONT messages are contiguous. So current software
must also be ready to accept broken up LOG_CONT messages. This is why I
think it would be acceptable to make this change for /dev/kmsg and
extended netconsole. But I understand it is controversial since tools
like systemd and dmesg use /dev/kmsg. Until they are modified to
re-assemble LOG_CONT messages, they will present the user with the
ugliness of LOG_CONT pieces (always, rather than as is now rarely).

John Ogness
