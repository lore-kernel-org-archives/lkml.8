Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA332071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o41t8+Ug";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bs7XmMqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbgGVNw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:52:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48686 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGVNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:52:25 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595425943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8h8jDnKHO+X8h3JJZpGFDff1DSLLwv2lsjn5ygW/YYg=;
        b=o41t8+Ug405t9avNdafVT++MNKlB2qIbBnr+C9yPyGblCnphGXOq3LcsCWgz2FNkpSfqjj
        GMQ9GYaFCYOl+KNUqYJYaYsFH79+T2OmdOvd5QDA+sX1hnJ/s22QI3105YtNtdM/8gFxwd
        leyYa7hhqCMxTlO8YlerILYfgwZKuisGXXQO/q5ZFN8UzTzPiEAaKp1Jna1QCloeUEKXYF
        FzpUM5gys7rxayoymjwa2zX7lsYc252ETLAJm5phgTQHc/Koj/afLsw3z0qX6UVN4f/YPR
        kVjvn2vDukpQrkS9CYCqXiAzw2GgqgCXtq69HBI+hXdcbxENiZJt8ieXQuRblA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595425943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8h8jDnKHO+X8h3JJZpGFDff1DSLLwv2lsjn5ygW/YYg=;
        b=bs7XmMqG2TRpVSN1AGdk/wewXlRhia7REr1ECA5sar/tlqs/5qiq1HlfUYfd6by3CPIdfj
        eZ36ubC+VODG49Dw==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     jbaron@akamai.com, mingo@redhat.com, kernel@axis.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
In-Reply-To: <20200721173045.540ae500@oasis.local.home>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com> <20200721173045.540ae500@oasis.local.home>
Date:   Wed, 22 Jul 2020 15:58:22 +0206
Message-ID: <87eep3zmg9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-21, Steven Rostedt <rostedt@goodmis.org> wrote:
>> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
>> index 321437bbf87d..9f6d8867af7c 100644
>> --- a/lib/dynamic_debug.c
>> +++ b/lib/dynamic_debug.c
[..]
>> +static void dynamic_printk(unsigned int flags, const char *fmt, ...)
>> +{
>> +	if (flags & _DPRINTK_FLAGS_TRACE) {
>> +		va_list args;
>> +
>> +		va_start(args, fmt);
>> +		/*
>> +		 * All callers include the KERN_DEBUG prefix to keep the
>> +		 * vprintk case simple; strip it out for tracing.
>> +		 */
>> +		dynamic_trace(fmt + strlen(KERN_DEBUG), args);

Do we really need a separate tracing event for this? Why not just:

                ftrace_vprintk(fmt + strlen(KERN_DEBUG), args);

John Ogness
