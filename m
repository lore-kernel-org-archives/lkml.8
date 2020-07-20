Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5905C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B91C22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EO7ZPAeW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOc+oKTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgGTOtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:49:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:49:42 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595256580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrNCCUAh2qiZuq2tVk2FZ+e78IxZ1qs8q7MJBM78TL4=;
        b=EO7ZPAeWQLpnykYbzD1TFl0foAm4h4HbxaZGQms+E7wJpyNpk0vBs1H53/JT0Eg5z51oqY
        iRbsrvmSYdnPZRsJB4rjxgNfUYL08goTZEmPBnUrb98oGiIJmWSMwuI/oHsDJDfMjZkZWz
        1+IL9OH3+3uvQkfQi4dtO0lt5oQOBxAQe4nU5FzROfjYhnDFFdoq3F4+hHue2HWwUAtXpB
        izSqV6KLFlY+jOljUqSFJY3qYEImVbgKTSLvC2T5pe2zyYxK+xMmMSTl3bTtfnJLGSQ5Dh
        T0/CMUeOjia7KpXUVjb2p/HFAOAgCTd7+e2gECHhyqJ5BEKRWaHcmksTFjo3tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595256580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrNCCUAh2qiZuq2tVk2FZ+e78IxZ1qs8q7MJBM78TL4=;
        b=sOc+oKTvagCDtpu/9bD5lYKVljsyXyW2ARDIQNp3+5dwgW6ihifCizyid8+OnMb8WtBgax
        3aGWgJkITKDvz5Dw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] printk: ringbuffer: support dataless records
In-Reply-To: <20200717234818.8622-2-john.ogness@linutronix.de>
References: <20200717234818.8622-1-john.ogness@linutronix.de> <20200717234818.8622-2-john.ogness@linutronix.de>
Date:   Mon, 20 Jul 2020 16:55:39 +0206
Message-ID: <87blkas0l8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-18, John Ogness <john.ogness@linutronix.de> wrote:
> In order to support storage of continuous lines, dataless records must
> be allowed. For example, these are generated with the legal calls:
>
>     pr_info("");
>     pr_cont("\n");
>
> Currently dataless records are denoted by INVALID_LPOS in order to
> recognize failed prb_reserve() calls. Change the code to use two
> different identifiers (FAILED_LPOS and NO_LPOS) to distinguish
> between failed prb_reserve() records and successful dataless records.

This patch has been re-posted [0] as a regression fix for the first
series that is already in linux-next. Only the commit message has been
changed to reflect the regression fix rather than preparing for
continuous line support.

Assuming that patch is accepted, this one should be dropped.

John Ogness

[0] https://lkml.kernel.org/r/20200720140111.19935-1-john.ogness@linutronix.de
