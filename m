Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A711DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8276D2224D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEywIbIK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XEDJQTTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMKqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgHMKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:46:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AACC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 03:46:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597315565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCg1ZdtTl1KhAjawebiFvNnjllljAIdwgNvbFA5RkDM=;
        b=bEywIbIK22XdO0ai4D1Bx5DPlNeBk5voSqr1vXsP7AVobytK6wgdxdlRVmMkzuluT+WZVx
        MDloLbbbkcCw5CYBGSqNJnqOP8wLSBb/i1z9Pu72J2vywDadD+M24YBHPspCFrFRlvPekG
        ht4wyZ3kWRvi0+eoeLZPIX9yFEn9oNmFg9L3tgIkYe3TwlyIkQYXx7vohIewPzrZjxYvMK
        1RtPof3s4s5hVkx1bniz52OVM69jGptBpmwKGm0OwFJfTd8dfefh2BJbR9fZlgOsbGbDZw
        tajT9V9wYYJLv6pX3PxRuB1fBjHLbFL268WOHVjZ5sHYR7LW6WcoSseCUxgGTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597315565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCg1ZdtTl1KhAjawebiFvNnjllljAIdwgNvbFA5RkDM=;
        b=XEDJQTTrOA+Ajl0PYX6L2bHeRYagwpHbpMD6GjEmX5RnhID6Q16IBfPaZLonVzbv8Bm8QM
        1oIdgPsL0mAp4JDA==
To:     Qianli Zhao <zhaoqianligood@gmail.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: Re: [PATCH] timer: mask unnecessary set of flags in do_init_timer
In-Reply-To: <1596767378-27241-1-git-send-email-zhaoqianligood@gmail.com>
References: <1596767378-27241-1-git-send-email-zhaoqianligood@gmail.com>
Date:   Thu, 13 Aug 2020 12:46:05 +0200
Message-ID: <87h7t6lt76.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qianli Zhao <zhaoqianligood@gmail.com> writes:

Please start the first word after the colon with an upper case letter.

> do_init_timer can specify flags of timer_list,

Please write do_init_timer() so it's entirely clear that this is about a
function.

> but this function does not expect to specify the CPU or idx.

or idx does not mean anything unless someone looks at the
code. Changelogs want to explain things so they can be understood
without staring at the code.

> If user invoking do_init_timer and specify CPU,
> The result may not what we expected.

Right. And which caller exactly hands in crappy flags?

> E.g:
> do_init_timer invoked in core2,and specify flags 0x1
> final result flags is 0x3.If the specified CPU number
> exceeds the actual number,more serious problems will happen

More serious problems is not a really helpful technical explanation and
0x3 does not make sense for a changelog reader either because it again
requires to look up the code.

>  	timer->entry.pprev = NULL;
>  	timer->function = func;
> -	timer->flags = flags | raw_smp_processor_id();
> +	timer->flags = (flags & ~TIMER_BASEMASK & ~TIMER_ARRAYMASK) |
> raw_smp_processor_id();

If the caller hands in invalid flags then silently fixing them up is
fundamentally wrong. So this wants to be:

   if (WARN_ON(flags & ~TIMER_INIT_FLAGS))
   	flags &= TIMER_INIT_FLAGS;

and TIMER_INIT_FLAGS wants to be exactly the set of flags which are
valid for being handed in by a caller, i.e.:

      TIMER_DEFFERABLE, TIMER_PINNED, TIMER_IRQSAFE

Guess what happens when the caller hands in TIMER_MIGRATING?

If we do sanity checking then we do it correct and not just silently
papering over the particular problem which you ran into.

Thanks,

        tglx
