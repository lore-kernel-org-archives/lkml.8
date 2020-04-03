Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035EA20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAqv5c9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390224AbgDCBQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:16:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731783AbgDCBQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585876567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4RCULoQ2d8bsXo0P6cSh9l9aG0hJAhK3B7qmwPBmjc=;
        b=UAqv5c9Sk//aUCizYmjC9N3TzsPVipf+4JnWiRA2oPix3//hwgCoygYeKiDztQkaidpb+1
        F/yje/GGUdv015bOjsq5WX9n2uzliu9c+0Owa7cvLq/SAYwBw+CrVi+nTL0DcuJJ/zwytr
        qNCkFlIoHKuuUeTckFSidN/pd+WjPt4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-vVF6xiXJMheDK0-SAY135Q-1; Thu, 02 Apr 2020 21:16:06 -0400
X-MC-Unique: vVF6xiXJMheDK0-SAY135Q-1
Received: by mail-wm1-f71.google.com with SMTP id o5so2115010wmo.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 18:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4RCULoQ2d8bsXo0P6cSh9l9aG0hJAhK3B7qmwPBmjc=;
        b=YKX86H4kxpxUVAZ0OFeygPk64wO1J150k+XJplDY3zc/M0yoTH4jQrXAQ5Aqevs3E/
         omdfthJcc8m3OWWRVtkR3CEOn6y2P7ZRotfxleGftsfiYMUEPLjfE4YXIpYUwPWRNe/Z
         mRFf8Wm//vIyqE1Y3Y0OHqE4Xhkssz6Xkwq9muqIiYlRqkt535OZQ7/dQezQyNbZZEfK
         rF/f0ExyC9Hlxe9VZwD55WJkx9TudPpC5SfjZd7KB341WSCM2I8/354RTRaCTI03HlTR
         VGgC+fW/8JdvwkB6rZNqPraTcc5OGp8Ifhms4CuyNFzhqRweOSjMiRuf6GWO5znST0IB
         dJVQ==
X-Gm-Message-State: AGi0PuYPPAV9G3yUWY317aIx9VSfRtMx7/hsBz77nq6uX/S4o0Tfju2l
        3jUjtG2w1iChL/5jxcYJcB4QmNawc2GtTNcxG7UtAFZRRXE9z3PQZ1ENriGuV/pVnrn+iTBTM9I
        YH/KDCBaGDsR53KyVXriHLMBV
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr6031889wme.148.1585876564619;
        Thu, 02 Apr 2020 18:16:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypL9YxBx70KaKxheDXRA5Yu8A2lmoFb91FLoPAJLfQwsH7VoZvscEk5tm/dJnygQ7MU/TvDC4A==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr6031856wme.148.1585876564163;
        Thu, 02 Apr 2020 18:16:04 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i1sm9528648wrq.89.2020.04.02.18.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 18:16:03 -0700 (PDT)
Date:   Thu, 2 Apr 2020 21:15:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200403011559.GH103677@xz-x1>
References: <20200402145929.102587-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402145929.102587-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:59:29AM -0400, Peter Xu wrote:
> The "isolcpus=" parameter allows sub-parameters to exist before the
> cpulist is specified, and if it sees unknown sub-parameters the whole
> parameter will be ignored.  This design is incompatible with itself
> when we add more sub-parameters to "isolcpus=", because the old
> kernels will not recognize the new "isolcpus=" sub-parameters, then it
> will invalidate the whole parameter so the CPU isolation will not
> really take effect if we start to use the new sub-parameters while
> later we reboot into an old kernel. Instead we will see this when
> booting the old kernel:
> 
>     isolcpus: Error, unknown flag
> 
> The better and compatible way is to allow "isolcpus=" to skip unknown
> sub-parameters, so that even if we add new sub-parameters to it the
> old kernel will still be able to behave as usual even if with the new
> sub-parameter is specified.
> 
> Ideally this patch should be there when we introduce the first
> sub-parameter for "isolcpus=", so it's already a bit late.  However
> late is better than nothing.
> 
> CC: Ming Lei <ming.lei@redhat.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Luiz Capitulino <lcapitulino@redhat.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - only allow isalpha() for sub-parameters [tglx]
> ---
>  kernel/sched/isolation.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 008d6ac2342b..c2e8b4a778d6 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -149,6 +149,9 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
>  static int __init housekeeping_isolcpus_setup(char *str)
>  {
>  	unsigned int flags = 0;
> +	char *par;
> +	int len;
> +	bool illegal = false;
>  
>  	while (isalpha(*str)) {
>  		if (!strncmp(str, "nohz,", 5)) {
> @@ -169,8 +172,21 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  			continue;
>  		}
>  
> -		pr_warn("isolcpus: Error, unknown flag\n");
> -		return 0;
> +		/*
> +		 * Skip unknown sub-parameter and validate that it is not
> +		 * containing an invalid character.
> +		 */
> +		for (par = str, len = 0; *str && *str != ','; str++, len++)
> +			if (!isalpha(*str))
> +				illegal = true;
> +
> +		if (illegal) {
> +			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
> +			return 0;
> +		}
> +
> +		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
> +		str++;
>  	}

I just noticed this is still problematic if we want to mark this as
stable, because "managed_irq" violate the "isalpha()" rule already...
It means even if we apply this patch to the stable trees it'll still
think managed_irq as illegal and ignore the whole isolcpus=.

Thomas, do you want me to repost a v3 as v1 plus some pr_warn()s?

Thanks,

-- 
Peter Xu

