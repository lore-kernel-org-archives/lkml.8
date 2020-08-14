Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B85C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A66D22B49
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0cCCceBv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iIl3fT9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHNIQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:16:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgHNIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:16:38 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597392996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aw8cLn0cJ1vSrWaV3ggp3sxIOuFTPfWi+rVC27WKTwM=;
        b=0cCCceBvsEqTbdr7y1QJk9XX9nO0fZLIYh0M7uovWZt/bHEQPQFvWUQ6YjKAHrwupITRJs
        H4X47VQ8i3iZviR1ZsRhb2WtjjsTmdEJaa4OVOZPBeKpPxSrHCSkgFHVzusv7VWGpjx3P2
        Fo3o/3/HbGzOGQCDqf3tOQ55u3q9myTXjfJGeiG3uFU/IuvAf+LWuP2tzuqwVgIkmnT8xW
        IrC+eqTj9tQSn/zKZ45oGsSaC0Sd89LY8EvMHF2c9OOK8rLruTikk7TKzWFXsbnnKqKCwy
        PO0Gyz8V/IYttw90UJasKGM151yHIxvxfvF9/i+3gi//Sl9bvxySZ9xe4YQWOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597392996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aw8cLn0cJ1vSrWaV3ggp3sxIOuFTPfWi+rVC27WKTwM=;
        b=iIl3fT9DoAwtelVo9Y9+WBxuGUawFbUpEyGdLGzwzr2II+M8XCOLLNd9JuIu93y9yiuoJA
        MmA2WsqxTGKo/GDg==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
In-Reply-To: <20200814033424.GA582@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de> <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com> <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley> <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de> <20200813051853.GA510@jagdpanzerIV.localdomain> <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley> <87v9hmrg84.fsf@jogness.linutronix.de> <20200814033424.GA582@jagdpanzerIV.localdomain>
Date:   Fri, 14 Aug 2020 10:22:35 +0206
Message-ID: <87k0y1k5gc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-14, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> One thing that we need to handle here, I believe, is that the context
> which crashes the kernel should flush its cont buffer, because the
> information there is relevant to the crash:
>
> 	pr_cont_alloc_info(&c);
> 	pr_cont(&c, "1");
> 	pr_cont(&c, "2");
> 	>>
> 	   oops
> 	      panic()
> 	<<
> 	pr_cont_flush(&c);
>
> We better flush that context's pr_cont buffer during panic().

I am not convinced of the general usefulness of partial messages, but as
long as we have an API that includes registration, usage, and
deregistration of some sort of handle, then we leave the window open for
such implementations.

John Ogness
