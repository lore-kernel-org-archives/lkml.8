Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF7FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BF620771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JDgXNAvB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWwIStof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMHo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:44:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A021C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:44:28 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597304666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwAqU//1A3R+DJkuFK8D981mTCm47eLPJEs5PgpmP9k=;
        b=JDgXNAvBhNk7sR7EzwEc33vq9Lw8Usil2bJSf+xGy78xRTZa1mb7JbaUerHQlJvov8bdiW
        7FY0pDMbtSdFEjk3GLTa/ou1+hf29dbq583M+dLloPbI/AihV1u/ft57SFze7ndul95X6R
        tulbwjxr3i+dl0kpLQe1OMtq0t/Q4gTIb1sZBiG/pLPGlaVTxvLIUlOdYPIefin43DKhsp
        jTFELLi3TP6UuqLwZ7T7JnWMbYh3bibtSWwgS6+yVxz0imH+XtvLauLgEpQa/mtv6WmEUV
        xWRJN80hCA9Lu/ZOYfAsfjKHG30ilXoEc2+GfXowupqNIkmFw748kYfx5G/B8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597304666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwAqU//1A3R+DJkuFK8D981mTCm47eLPJEs5PgpmP9k=;
        b=rWwIStofMz+NLlwO+Tl2ilc3Yyj+GtzqpIP8SXEkLp3BQ0QflC7HoMs0sV6IjEhJcAa0KJ
        iKD/3V2YvH11FiCg==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
In-Reply-To: <20200813051853.GA510@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de> <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com> <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley> <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de> <20200813051853.GA510@jagdpanzerIV.localdomain>
Date:   Thu, 13 Aug 2020 09:50:25 +0206
Message-ID: <875z9nvvl2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-13, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> This is not an unseen pattern, I'm afraid. And the problem here can
> be more general:
>
> 	pr_info("text");
> 	pr_cont("1");
> 	exception/IRQ/NMI
> 		pr_alert("text\n");
> 	pr_cont("2");
> 	pr_cont("\n");
>
> I guess the solution would be to store "last log_level" in task_struct
> and get current (new) timestamp for broken cont line?

(Warning: new ideas ahead)

The fundamental problem is that there is no real association between
the cont parts. So any interruption results in a broken record. If we
really want to do this correctly, we need real association.

With the new finalize flag for records, I thought about perhaps adding
support for chaining data blocks.

A data block currently stores an unsigned long for the ID of the
associated descriptor. But it could optionally include a second unsigned
long, which is the lpos of the next text part. All the data blocks of a
chain would point back to the same descriptor. The descriptor would only
point to the first data block of the chain and include a flag that it is
using chained data blocks.

Then we would only need to track the sequence number of the open record
and new data blocks could be added to the data block chain of the
correct record. Readers cannot see the record until it is finalized.

Also, since only finalized records can be invalidated, there are no
races of chains becoming invalidated while being appended.

My concerns about this idea:

- What if the printk user does not correctly terminate the cont message?
  There is no mechanism to allow that open record to be force-finalized
  so that readers can read newer records.

- For tasks, the sequence number of the open record could be stored on
  the task_struct. For non-tasks, we could use a global per-cpu variable
  where each CPU stores 2 sequence numbers: the sequence number of the
  open record for the non-task and the sequence number of the open
  record for an interrupting NMI. Is that sufficient?

John Ogness
