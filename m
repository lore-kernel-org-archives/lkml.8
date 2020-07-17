Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77816C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D8620704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eYf4efJL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D4hS5as4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGQUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:15:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42952 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgGQUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:15:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRr/bKkS7/U/6PsK6K4fGaOQKjxoGqV1/oWizy/cOuM=;
        b=eYf4efJLxfwui+MVHDpTy8jq6eCnUI4+IQiXhuXrDc4H0ue1Al5tBX1sJ4qLQ4wKQqH1u2
        956eMEIeLHrk4AfWY5YdKGxN9t86NZq3LOzOQFAsm6RnPo+CGISWOc2KlRkaUn2M/19rH4
        PYVIYHad73Ryn5glPiK5I8Ua8CBz3nnmTYEgdtkKVwdTzgktOGxwDnX6z7GNL5dRIPnJqy
        r/HqCXNvaIeqpARi2Kz1dBDslRlnKL4CiEdmkZBbw8zK9Ji5leH8jWEX9kH0weXqiDfItp
        SSCH6bjrJ4+kfEzJotJE4V3qfD2igHia1mhyVz2S0soBzGh56xAFUglkAE79eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRr/bKkS7/U/6PsK6K4fGaOQKjxoGqV1/oWizy/cOuM=;
        b=D4hS5as4Ya+T4lxgDZSTebQLTY2wKeMIwZFGGYs735Ikk9vClgh/patDA2HRNIR53PLoWD
        EXoAABBo5bb3KHCg==
To:     Muchun Song <songmuchun@bytedance.com>, peterz@infradead.org,
        mingo@kernel.org, bigeasy@linutronix.de, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH RESEND] smp: Fix a potential usage of stale nr_cpus
In-Reply-To: <20200716070457.53255-1-songmuchun@bytedance.com>
References: <20200716070457.53255-1-songmuchun@bytedance.com>
Date:   Fri, 17 Jul 2020 22:15:34 +0200
Message-ID: <87k0z1rj89.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun,

Muchun Song <songmuchun@bytedance.com> writes:

> The get_option() maybe return 0, it means that the nr_cpus is
> not initialized.

Good catch, but see below.

> Then we will use the stale nr_cpus to initialize

We use nothing. Please describe your changes in technical neutral
language.

> the nr_cpu_ids. So fix it.

'So fix it.' is not much valuable information. What about:

    Check the return value to prevent this.

Hmm?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/smp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 472c2b274c65..2a9a04acf123 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -634,8 +634,7 @@ static int __init nrcpus(char *str)
>  {
>  	int nr_cpus;
>  
> -	get_option(&str, &nr_cpus);
> -	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
> +	if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
>  		nr_cpu_ids = nr_cpus;
>  
>  	return 0;

get_option() can return 0 - 3:

 *      0 - no int in string
 *      1 - int found, no subsequent comma
 *      2 - int found including a subsequent comma
 *      3 - hyphen found to denote a range

For this parameter exists only one valid format: '1 - int found, no comma',
right?

So why fixing it just half and why returning '0' aka success if the
parameter is bogus?

Thanks,

        tglx
