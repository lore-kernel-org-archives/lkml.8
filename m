Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C8521775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQ5YkFr0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xe6GrYBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgGTKUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:20:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56688 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgGTKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:20:47 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595240446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGN4a9T4+fArx80G7sxmBScW+YSeCVCeIRIwBpZpeX0=;
        b=UQ5YkFr0mg8eiuyWrTq4fE3KBax1O6REpEbo5oMP+x1m9Lb7i68DY49dHuRy2+XPTzhIMX
        bRgSCdwumNFLcvALIt9WixzO5KFvskOd8To47WH44AmTtQ8HZVGdv9+x3FmgSetPkaBAA/
        8F9IZCVrGtbIckxPukk0egDAXAFeHUKEvVL4Bo0agore0wXrICOfzPz6G4R1BxcmOR3rKk
        K7fM+DDdcgeWRLdfh+EjjFKpc7oFbWPUsm8l9UqZKhSwWshi10Nx7SakLg0rLOvzuAMT0e
        EvhcJea4d6uJUSzcjf3SzdzwIJ0TZ12G2IJLrc8vYgC02OL9CVowvLnwy/rQiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595240446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGN4a9T4+fArx80G7sxmBScW+YSeCVCeIRIwBpZpeX0=;
        b=Xe6GrYBaP1ZMyjoCOp049r76FvbckLFJ7ozR6d4Hkfx75QMHsESyTSNxzk7S07wUotoLaI
        F3IP9S+xkz/wWHCw==
To:     Marco Elver <elver@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
In-Reply-To: <20200718121053.GA691245@elver.google.com>
References: <20200709132344.760-1-john.ogness@linutronix.de> <20200709132344.760-5-john.ogness@linutronix.de> <20200718121053.GA691245@elver.google.com>
Date:   Mon, 20 Jul 2020 12:26:45 +0206
Message-ID: <87eep6sd1e.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-18, Marco Elver <elver@google.com> wrote:
> It seems this causes a regression observed at least with newline-only
> printks.
> [...]
> ------ >8 ------
>
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1039,6 +1039,10 @@ asmlinkage __visible void __init start_kernel(void)
>  	sfi_init_late();
>  	kcsan_init();
>  
> +	pr_info("EXPECT BLANK LINE --vv\n");
> +	pr_info("\n");
> +	pr_info("EXPECT BLANK LINE --^^\n");
> +
>  	/* Do the rest non-__init'ed, we're now alive */
>  	arch_call_rest_init();

Thanks for the example. This is an unintentional regression in the
series. I will submit a patch to fix this.

Note that this regression does not exist when the followup series [0]
(reimplementing LOG_CONT) is applied. All the more reason that the 1st
series should be fixed before pushing the 2nd series to linux-next.

John Ogness

[0] https://lkml.kernel.org/r/20200717234818.8622-1-john.ogness@linutronix.de
