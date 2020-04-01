Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235BBC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D831E206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDM/OF4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbgDAXBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:01:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732537AbgDAXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585782073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SS3NeMLw6rn/tUQZ5RQimBbdXAVH/T2d5UyAUQFoHM4=;
        b=gDM/OF4noSAtqTWr5KzMoomwAFIZ69ugdsXwemSgOyGkakHp2cMpI5QN+ZKgfsH7dpAozo
        vpLLvRJGotQpSm5KVY94D00hrk+T4R2cXNNN63Wb4bYRVz6sEDZGHMlcNyiHLK/p7aFUlM
        Cns/gg+axGwtzPVL5Zaej2Es1zHdyb0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Oo1fmPU-OLaNuSMRh32q1g-1; Wed, 01 Apr 2020 19:01:08 -0400
X-MC-Unique: Oo1fmPU-OLaNuSMRh32q1g-1
Received: by mail-qt1-f198.google.com with SMTP id x3so1431317qtv.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SS3NeMLw6rn/tUQZ5RQimBbdXAVH/T2d5UyAUQFoHM4=;
        b=K0pOWfMuKT2wjOKlD1ApBe3SjlfhQo6Y1yS5KjA5rFrhO9pIzIOEAsKZ+O5nVjeYND
         rlqRMa+7gopKxI52oQAWLRz+bAOy8peIZHsXRZkWhqNKYxyiS4W2T6kCSOpnXwXJYmq2
         TtkvqNthu0z5bOspe6xX3d9i7V7jhafSKsZyCQ4U3MxVU7165LMT2CoezkfKhf5Fa6Yc
         2GnxREWbsqijMX2mqbOubIZRn4gkZ4SvtL34dcLzCj2DdQK7vCmtUdUZ6E3mHVg8Q2gL
         ywIJ52ogvUNugOOmcuttDUvZV9zmk9bB9wlOCdCEdeZJJKhh6aPuTi/aRkJ3Y8aWw2ax
         wP/w==
X-Gm-Message-State: AGi0PuZdoqgX7HnVzeDyvdpJHWpyT6aF1+V1eWv6WaL+8S6/nc4SM7tl
        pNaHc7qlctwzLt2ilGXj+7es2AXanZgd8c/Z8rMu0kL6xNfjlNtLksMstwk0pEBsi5KdTfeWvsO
        Bbgdu1hH/VkH0rzw4sj5delGa
X-Received: by 2002:ac8:7448:: with SMTP id h8mr115605qtr.51.1585782068307;
        Wed, 01 Apr 2020 16:01:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypIAu8GyjD+zpYZlYttKK9Lw4nrXJTszwtXTk8YuG6RrkDaTzddarJ8Cpkv1X9tYFmJeLq99+w==
X-Received: by 2002:ac8:7448:: with SMTP id h8mr115562qtr.51.1585782067985;
        Wed, 01 Apr 2020 16:01:07 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id j85sm2425778qke.20.2020.04.01.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 16:01:07 -0700 (PDT)
Date:   Wed, 1 Apr 2020 19:01:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200401230105.GF648829@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com>
 <87d08rosof.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d08rosof.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:30:08PM +0200, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> > @@ -169,8 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >  			continue;
> >  		}
> >  
> > -		pr_warn("isolcpus: Error, unknown flag\n");
> > -		return 0;
> > +		str = strchr(str, ',');
> > +		if (str)
> > +			/* Skip unknown sub-parameter */
> > +			str++;
> > +		else
> > +			return 0;
> 
> Just looked at it again because I wanted to apply this and contrary to
> last time I figured out that this is broken:
> 
>      isolcpus=nohz,domain1,3,5
> 
> is a malformatted option, but the above will make it "valid" and result
> in:
> 
>      HK_FLAG_TICK and a cpumask of 3,5.

I would think this is no worse than applying nothing - I read the
first "isalpha()" check as something like "the subparameter's first
character must not be a digit", so to differenciate with the cpu list.
If we keep this, we can still have subparams like "double-word".

> 
> The flags are required to be is_alpha() only. So you want something like
> the untested below. Hmm?

I'm fine with it, however note that...

> 
> Thanks,
> 
>         tglx
> 
> 8<---------------
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -149,6 +149,8 @@ static int __init housekeeping_nohz_full
>  static int __init housekeeping_isolcpus_setup(char *str)
>  {
>  	unsigned int flags = 0;
> +	char *par;
> +	int len;
>  
>  	while (isalpha(*str)) {
>  		if (!strncmp(str, "nohz,", 5)) {
> @@ -169,8 +171,17 @@ static int __init housekeeping_isolcpus_
>  			continue;
>  		}
>  
> -		pr_warn("isolcpus: Error, unknown flag\n");
> -		return 0;
> +		/*
> +		 * Skip unknown sub-parameter and validate that it is not
> +		 * containing an invalid character.
> +		 */
> +		for (par = str, len = 0; isalpha(*str); str++, len++);
> +		if (*str != ',') {
> +			pr_warn("isolcpus: Invalid flag %*s\n", len, par);

... this will dump "isolcpus: Invalid flag domain1,3,5", is this what
we wanted?  Maybe only dumps "domain1"?

For me so far I would still prefer the original one, giving more
freedom to the future params and the patch is also a bit easier (but I
definitely like the pr_warn when there's unknown subparams).  But just
let me know your preference and I'll follow yours when repost.

Thanks,

> +			return 0;
> +		}
> +		pr_info("isolcpus: Skipped unknown flag %*s\n", len, par);
> +		str++;
>  	}
>  
>  	/* Default behaviour for isolcpus without flags */
> 

-- 
Peter Xu

