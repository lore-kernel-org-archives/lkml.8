Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF35C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B482C207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="15AVGYQZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jq+AXIL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgHTWLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:11:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgHTWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:11:21 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597961478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zglLHRJDp8t8DRRuLZuvKBensI8bwuAzUgeKOh3U1e4=;
        b=15AVGYQZJK+HhXN5oPTjvA+2c5fu3tHTcu632JtlVChloFRhnfxQbor+5vbwQrkcLjgUL9
        EcbHAunL/6BeAwdywBTJtUJwYs6thXYcTknSH34AeCSemujFEKm2XcqORiZTky+nPtfCxg
        ar1RRhdb052acTQEsET9NUz1WPHDa6oAi3NkeztiptF1cw1VEQQNMTn1+zJPxQGcGykmsc
        hp9Ah1HM7A0aC2qBgpXkT2WPm5awF9T5YmHOTvApQdpuieokpqCFGsR6WoOf9VgUvfdmMm
        dLLtQiyizER+0Ns30CcMd1CWIzyPi0+sIS4t9RtYtHNBPe2vmdBtE9Smh0xReg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597961478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zglLHRJDp8t8DRRuLZuvKBensI8bwuAzUgeKOh3U1e4=;
        b=jq+AXIL+qmrkdoE5qBqzZ9r1zdvalMOfBI4nJbi6uDhWIDn2fUZgoZpmpa2wtzEjmTZSBf
        7cq48yOgpJV57SBQ==
To:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] sysrq: use pr_cont_t for cont messages
In-Reply-To: <472f2e553805b52d9834d64e4056db965edee329.camel@perches.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de> <20200819232632.13418-3-john.ogness@linutronix.de> <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com> <472f2e553805b52d9834d64e4056db965edee329.camel@perches.com>
Date:   Fri, 21 Aug 2020 00:17:18 +0206
Message-ID: <87364hge7t.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-20, Joe Perches <joe@perches.com> wrote:
> And here it seems like the 'for (j =...)' loop is superfluous.

AFAICT it is skipping duplicate entries. In the case of a duplicate,
only the first one is printed.

> Maybe something like this would be reasonable:
> ---
>  drivers/tty/sysrq.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index a8e39b2cdd55..a145e4fc1a2a 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -572,21 +572,14 @@ void __handle_sysrq(int key, bool check_mask)
>  			console_loglevel = orig_log_level;
>  		}
>  	} else {
> -		pr_info("HELP : ");
> -		/* Only print the help msg once per handler */
> +		pr_context c;
> +		pr_info_start(&c, "HELP :");
>  		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
> -			if (sysrq_key_table[i]) {
> -				int j;
> -
> -				for (j = 0; sysrq_key_table[i] !=
> -						sysrq_key_table[j]; j++)
> -					;
> -				if (j != i)
> -					continue;
> -				pr_cont("%s ", sysrq_key_table[i]->help_msg);
> -			}
> +			if (!sysrq_key_table[i])
> +				continue;
> +			pr_next(&c, " %s", sysrq_key_table[i]->help_msg);
>  		}
> -		pr_cont("\n");
> +		pr_end(&c, "\n");
>  		console_loglevel = orig_log_level;
>  	}
>  	rcu_read_unlock();
