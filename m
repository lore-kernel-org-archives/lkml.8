Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0788620829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPvWf1/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7M/8Cb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMAYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHMAYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 20:24:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA2C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:24:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597278242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6cBMmvGDUSJmOhpFTOJY1Nvmk9svDWb0crnONfsRcg=;
        b=tPvWf1/uSjOuVeRO3Z9Yaulwt779rs1oJYXB5HPTf+btDUoofO5xwuNZZgX5MwyoT+B5RP
        WCDF3BmNAkt1V5LjpJmuhstr995Ij3FlvqaL+xHs956BVev5DZvBuFLVra0Myf37dxNsSH
        i5rwrR60hbCwgHceGDRzFOICFld/Hp9mCkc0r+XQ1HtnkSlvLtR7Oxja5biMnHHSf84AnU
        vYC5aTCuH0PYgXjjSIz8rfL/GGMGkAjRs42iOUZLAPp3o3X4YQTeLLvyUzHJ5/CTEtzGXE
        tZiPuFq1OegoBLpU08RgS38pvRFq0M7tJpqgQRrfhfPh1MUwxthR2LFP/IMejg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597278242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6cBMmvGDUSJmOhpFTOJY1Nvmk9svDWb0crnONfsRcg=;
        b=F7M/8Cb9meZTlnO2bFm10TBxaHceqURrhXtctSbptC0KFrURa6iXEw+tMfct0mD2v+1Lq4
        Izbtejnq/0Sa/SDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
In-Reply-To: <20200812163908.GH12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de> <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com> <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley> <20200812163908.GH12903@alley>
Date:   Thu, 13 Aug 2020 02:30:02 +0206
Message-ID: <87v9hn2y1p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-12, Petr Mladek <pmladek@suse.com> wrote:
> So, I have one crazy idea to add one more state bit so that we
> could have:
>
>   + committed: set when the data are written into the data ring.
>   + final: set when the data block could not longer get reopened
>   + reuse: set when the desctiptor/data block could get reused
>
> "final" bit will define when the descriptor could not longer
> get reopened (cleared committed bit) and the data block could
> not get extended.

I had not thought of extending data blocks. That is clever!

I implemented this solution for myself and am currently running more
tests. Some things that I changed from your suggestion:

1. I created a separate prb_reserve_cont() function. The reason for this
is because the caller needs to understand what is happening. The caller
is getting an existing record with existing data and must append new
data. The @text_len field of the info reports how long the existing data
is. So the LOG_CONT handling code in printk.c looks something like this:

        if (lflags & LOG_CONT) {
                struct prb_reserved_entry e;
                struct printk_record r;

                prb_rec_init_wr(&r, text_len, 0);

                if (prb_reserve_cont(&e, prb, &r, caller_id)) {
                        memcpy(&r.text_buf[r.info->text_len], text, text_len);
                        r.info->text_len += text_len;

                        if (lflags & LOG_NEWLINE)
                                r.info->flags |= LOG_NEWLINE;

                        if (r.info->flags & LOG_NEWLINE)
                                prb_commit_finalize(&e);
                        else
                                prb_commit(&e);

                        return text_len;
                }
        }

This seemed simpler than trying to extend prb_reserve() to secretly
support LOG_CONT records.

2. I haven't yet figured out how to preserve calling context when a
newline appears. For example:

pr_info("text");
pr_cont(" 1");
pr_cont(" 2\n");
pr_cont("3");
pr_cont(" 4\n");

For "3" the calling context (info, timestamp) is lost because with "2"
the record is finalized. Perhaps the above is invalid usage of LOG_CONT?

3. There are some memory barriers introduced, but it looks like it
shouldn't add too much complexity.

I will continue to refine my working version and post a patch so that we
have something to work with. This looks to be the most promising way
forward. Thanks.

John Ogness
