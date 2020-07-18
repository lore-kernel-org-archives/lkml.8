Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E745EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C042820657
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4c+55hW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HygpJuHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGROnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:43:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47370 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgGROm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:42:59 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595083377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=robvEvPfTGacPLLxfjqEcu14s1gI/E9Po46qbTLNH9U=;
        b=f4c+55hWWUCG3ELBCMrjgWLE2gsZhHBDVa/JvAlkChgE2cV8SZer9ivxhUTMz53HiVDUyZ
        vQxr02bZojUUNnLGyj5yDINRDU0AuoxkBkNh7s+x9YqeaEIjN2yyzcBniVqKjA4/H3OTg4
        G7bOjhEAIl6yopkDvxGkh7ejY1LoGMNlK6ugEmtdDUS8m71nsZ2QwZGURU3BgbaXEOB/q3
        7/vtwA7ecPr7TgEfyDe5XLK2VEvuGD+koJff8GRSuDfroDr8H/OOfxLi7WzgKkT3u5LbQ6
        DBBDWq+nXG069WVNdnVRpNTQYgIrpaee5qEjvRY7g5xhjHaOPAagrndMxAAvOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595083377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=robvEvPfTGacPLLxfjqEcu14s1gI/E9Po46qbTLNH9U=;
        b=HygpJuHRIGXxBEU/34gMJCGzgTpx8GS6bRIRReV1UJ/TVLQ+RV5oSW53bVibyTWZqwS9DH
        7Cls6AERIWr8EPAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
In-Reply-To: <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de> <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
Date:   Sat, 18 Jul 2020 16:48:55 +0206
Message-ID: <87blkcanps.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-17, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Make sure you test the case of "fast concurrent readers". The last
> time we did things like this, it was a disaster, because a concurrent
> reader would see and return the _incomplete_ line, and the next entry
> was still being generated on another CPU.
>
> The reader would then decide to return that incomplete line, because
> it had something.
>
> And while in theory this could then be handled properly in user space,
> in practice it wasn't. So you'd see a lot of logging tools that would
> then report all those continuations as separate log events.
>
> Which is the whole point of LOG_CONT - for that *not* to happen.

I expect this is handled correctly since the reader is not given any
parts until a full line is ready, but I will put more focus on testing
this to make sure. Thanks for the regression and testing tips.

> So this is just a heads-up that I will not pull something that breaks
> LOG_CONT because it thinks "user space can handle it". No. User space
> does not handle it, and we need to handle it for the user.

Understood. Petr and Sergey are also strict about this. We are making a
serious effort to avoid breaking things for userspace.

John Ogness
