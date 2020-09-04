Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD2C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2308F2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgIDQHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:07:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgIDQHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:07:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F40106F;
        Fri,  4 Sep 2020 09:07:41 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.8.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B143F66F;
        Fri,  4 Sep 2020 09:07:39 -0700 (PDT)
Date:   Fri, 4 Sep 2020 17:07:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Haesung Kim <matia.kim@lge.com>
Cc:     jirislaby@kernel.org, akpm@linux-foundation.org, mingo@kernel.org,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stacktrace: print real address of trace entries
Message-ID: <20200904160736.GB21956@C02TD0UTHF1T.local>
References: <1599213624-14632-1-git-send-email-matia.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599213624-14632-1-git-send-email-matia.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 07:00:24PM +0900, Haesung Kim wrote:
> If function is marked as static and compiler decies to lnline function
> with or without inline keyword, the function has no symbol.
> We just know symbol located near the address of the inline function
> by %pS type that shows symbol and offset. But we don't know function
> name.

What exactly is output in this case today? Can't you get the real
addr/symbol from scripts/faddr2line?

> The real address let us extract the function name and location of
> source code by debugging tools such as addr2line. This is helpful to
> debug.

Not logging the address was a deliberate decision to minimize leakage of
the kernel's VA layout. This undermines that, and I don't think doing so
is a good idea.

If there is a problem with faddr2line we should work out how to improve
that.

Mark.

> 
> Signed-off-by: Haesung Kim <matia.kim@lge.com>
> ---
>  kernel/stacktrace.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 946f44a..b7168c5 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -24,12 +24,15 @@ void stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
>  		       int spaces)
>  {
>  	unsigned int i;
> +	unsigned long ip;
>  
>  	if (WARN_ON(!entries))
>  		return;
>  
>  	for (i = 0; i < nr_entries; i++)
> -		printk("%*c%pS\n", 1 + spaces, ' ', (void *)entries[i]);
> +		ip = entries[i];
> +		printk("%*c[<%px>] %pS\n",
> +			1 + spaces, ' ', (void *) ip, (void *) ip);
>  }
>  EXPORT_SYMBOL_GPL(stack_trace_print);
>  
> @@ -47,13 +50,15 @@ int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
>  			unsigned int nr_entries, int spaces)
>  {
>  	unsigned int generated, i, total = 0;
> +	unsigned long ip;
>  
>  	if (WARN_ON(!entries))
>  		return 0;
>  
>  	for (i = 0; i < nr_entries && size; i++) {
> -		generated = snprintf(buf, size, "%*c%pS\n", 1 + spaces, ' ',
> -				     (void *)entries[i]);
> +		ip = entries[i];
> +		generated = snprintf(buf, size, "%*c[<%px>] %pS\n",
> +				     1 + spaces, ' ', (void *) ip, (void *) ip);
>  
>  		total += generated;
>  		if (generated >= size) {
> -- 
> 2.7.4
> 
