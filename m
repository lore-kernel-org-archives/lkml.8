Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50B8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816A020674
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tqyB+b0h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IS/fTrrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgF3F7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:59:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52048 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgF3F7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:59:43 -0400
X-Greylist: delayed 883 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 01:59:42 EDT
Date:   Tue, 30 Jun 2020 07:59:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593496780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISSeNlZb4Rl1m7bgMA2uyOzUeDrOW1JpndE6Mh/W8oo=;
        b=tqyB+b0h7XAflMZ6GCQA117o6LO/DRXQ49iOQJaRt6GU+AMe/g96NWoHeJ3OKOxYIqAf56
        R9jHf5NsgEwHhU8JfVG/7KopkPQObAv6gXHNLk3oVB02Cw6D9HfcjnLKG4kMEsSQbmRLKQ
        ql+OWsaB7Ew3IyMmDmdfTl0r4tj3w/0UmA59u6U3hXTKCSEoRma9BkbJFQWc4h6HHXV/UA
        0/DpJwbBzBymAknZtj5HJUHqavwWqGdtOWPff6P1edyHQuF/qvQiB+mrzLGOrOK7cV2SmH
        y9azpiFEn/6HMpOnxKo09o4IoZdBMmaq5qLwGKVa268DfUBmzcP9oCGC6uRtCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593496780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISSeNlZb4Rl1m7bgMA2uyOzUeDrOW1JpndE6Mh/W8oo=;
        b=IS/fTrrEBdr0B5uSkPSVJuizfzPVBDIc0SfUXgPsIr2XNfbeNGHrvtMNmsoh6sP3ovWtTB
        9Z/W5HYn3zWJUVDw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200630055939.GA3676007@debian-buster-darwi.lab.linutronix.de>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623083721.512673481@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:

...

> -#define lockdep_assert_irqs_disabled()	do {			\
> -		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> -			  current->hardirqs_enabled,			\
> -			  "IRQs not disabled as expected\n");		\
> -	} while (0)

...

> +#define lockdep_assert_irqs_disabled()				\
> +do {									\
> +	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
> +} while (0)

I think it would be nice to keep the "IRQs not disabled as expected"
message. It makes the lockdep splat much more readable.

This is similarly the case for the v3 lockdep preemption macros:

  https://lkml.kernel.org/r/20200630054452.3675847-5-a.darwish@linutronix.de

I did not add a message though to get in-sync with the IRQ macros above.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
