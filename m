Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22EAC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F462075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZ4vqcXi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPS6KYi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHTJTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgHTJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:18:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793DC061384
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:18:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597915114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKCC8LY5eyXxgPkbZLKy7wBhTWb+3NrngDGJtPc7giw=;
        b=yZ4vqcXicaTwqzYA56JRtJyNmR4lrnwCmHnfwA94jLlWRfPDycDYu/Q8ElPHlUXk5zSmrd
        JmCWqW5xHeMiwMvynRwMIRmocvxe95LOkKedTBsNZcWAze2OrUZjwDRw11m98xuDCUfn5L
        Vu8IBNa/KvbIrn5oZDyb+eM0vdJopgbvnav7/8bkD3wUr/AAkBjHJI5J1qfjHfspqlAq0C
        8LT4AM56sEml8AwtzDoEV3YF6TJl8XboLR6DK17tJat7fAX5Xi69ZtlBP2xNPUUDJf6rpc
        EPYFfTfPOHQIKUu7w+n2xkB60sBUx1zyvw9A0+ha59X/PcrEPKJc79/hBGdaDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597915114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKCC8LY5eyXxgPkbZLKy7wBhTWb+3NrngDGJtPc7giw=;
        b=HPS6KYi1eAGXLYiQWiaX4ld6qTIt6H3EeQs1uRPabErkbY9Z+V/pVQ6nGEBafTOetEENlx
        OsfrWYk7MrzgrFBg==
To:     David Laight <David.Laight@ACULAB.COM>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/5] printk: implement pr_cont_t
In-Reply-To: <389a62f178d2482b9525f499b82e92df@AcuMS.aculab.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de> <20200819232632.13418-2-john.ogness@linutronix.de> <e1e3164eabf69e04ad9e9ddc259ca685f48c5e27.camel@perches.com> <b17fc8afc8984fedb852921366190104@AcuMS.aculab.com> <29b6120680fbfb51936bb9100b2c9bb78385aef0.camel@perches.com> <389a62f178d2482b9525f499b82e92df@AcuMS.aculab.com>
Date:   Thu, 20 Aug 2020 11:24:33 +0206
Message-ID: <87wo1tzndi.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-20, David Laight <David.Laight@ACULAB.COM> wrote:
>> On Thu, 2020-08-20 at 07:44 +0000, David Laight wrote:
>>> I've no idea how you'd 'size' the number of buffers.
>> 
>> I believe they are static and assume no more than 10
>> simultaneous uses of printk_begin
>
> What I meant was how you'd work out whether 10 was in any way
> appropriate.  ISTM it is either 'too many' or 'nowhere near enough'
> depending on exactly what the system is doing.

Right now mainline has 1, which breaks pr_cont just booting your system.

I expect we will be increasing the number of buffers, regardless if we
adapt a new API or continue with what we have now.

> And if code 'leaks' them you are in deep doo-doos.

Not really. It falls back to printing individual parts. Also, the printk
subsystem has access to the open buffers and could even track the users
lockdep style.

But this discussion has little to do with the API. These are
implementation details that may end up under the hood of the current
mainline API.

John Ogness
