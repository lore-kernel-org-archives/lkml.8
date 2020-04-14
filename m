Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143D5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06C7206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMC8lAMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407787AbgDNV5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:57:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25831 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729713AbgDNV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586901440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DvGxiWkeKdHX0wP+6BrRMFvoI6T/wBJtjpbt2ET1G0=;
        b=PMC8lAMcAlXG+vlKSQJETBUtVFHDB1V/+WH3IAt5NaSfu9nVPFFH6hJxKa8FfiTg0EG65u
        X2hgJ4hjLMJ9uIuXz3PHvlj0yb19X/jod6xjIqy7AEmpAbcJkoCkDumgwhU8Nlk6Hhb9Gl
        iEB6GJ5zV4eUA2IDTm3YLkI8lf445DU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-5TG96tHLOXGu-YHrP5UrxA-1; Tue, 14 Apr 2020 17:57:18 -0400
X-MC-Unique: 5TG96tHLOXGu-YHrP5UrxA-1
Received: by mail-qv1-f70.google.com with SMTP id dc4so1195063qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/DvGxiWkeKdHX0wP+6BrRMFvoI6T/wBJtjpbt2ET1G0=;
        b=jRklVVjTrmblqU28wa77DcxTMJfWgITr5RVCEqrJLDjMKC2MXLShynwUUvo7+6g7oe
         YBFIQQ5tqzss3GilG+X5bhtB1Vao8WqZC9+IbMqbdgzaXCqOoiMqHpDNi6mY0fEohnAA
         hqV3DTJgD3nHxul+ITCyWxirU15Dz1+V1rIB9OS7ZXarJSZAWU6kUEuPU15MnJtShz6R
         PysWaQwDhz6xDfBprZTzNjpdax+84X1LRhH/d+n8yu50JCNRAqh9Rgxxnj/IQJLht7sc
         LPGWPRQzXeCf/rdkTScs2kJTOva42aL5N2AvTEaNEKw2CkfUrxo35Jowg8Xl/lvDg9ZR
         hQFg==
X-Gm-Message-State: AGi0PubjfiKeSNdXReWgjEGpMhPUSqJX9R2E664B6qCW9crqC70lJyQ5
        32gnLInPqcy50IjJNqPl4UFL5j+HJj6phea/SpcDSQxhrnwJ2D8AD9Pu6he/DXQawF7gt2Ex8v4
        RI9B5bZXX7y3AYBWqsGmPuzBv
X-Received: by 2002:ac8:d0b:: with SMTP id q11mr17303049qti.83.1586901437855;
        Tue, 14 Apr 2020 14:57:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAq8/oVtuN82Lj+g/soNr3duU7rQj5JUtrZrCf8s8azs+/QVan20H2uRELqfB65dBG+56qbQ==
X-Received: by 2002:ac8:d0b:: with SMTP id q11mr17303031qti.83.1586901437603;
        Tue, 14 Apr 2020 14:57:17 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w30sm12139130qtw.21.2020.04.14.14.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:57:16 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:57:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200414215715.GB182757@xz-x1>
References: <20200403223517.406353-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403223517.406353-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping - Thomas, do you think this version is ok to you?

This has missed 5.7 already, am I right?

Thanks,

On Fri, Apr 03, 2020 at 06:35:17PM -0400, Peter Xu wrote:
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
> v3:
> - add brackets for for loop
> - move "illegal" a bit higher, which may look tiny bit nicer
> - also allow '_'
> v2:
> - only allow isalpha() for sub-parameters [tglx]
> ---
>  kernel/sched/isolation.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 008d6ac2342b..808244f3ddd9 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -149,6 +149,9 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
>  static int __init housekeeping_isolcpus_setup(char *str)
>  {
>  	unsigned int flags = 0;
> +	bool illegal = false;
> +	char *par;
> +	int len;
>  
>  	while (isalpha(*str)) {
>  		if (!strncmp(str, "nohz,", 5)) {
> @@ -169,8 +172,22 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  			continue;
>  		}
>  
> -		pr_warn("isolcpus: Error, unknown flag\n");
> -		return 0;
> +		/*
> +		 * Skip unknown sub-parameter and validate that it is not
> +		 * containing an invalid character.
> +		 */
> +		for (par = str, len = 0; *str && *str != ','; str++, len++) {
> +			if (!isalpha(*str) && *str != '_')
> +				illegal = true;
> +		}
> +
> +		if (illegal) {
> +			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
> +			return 0;
> +		}
> +
> +		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
> +		str++;
>  	}
>  
>  	/* Default behaviour for isolcpus without flags */
> -- 
> 2.24.1
> 

-- 
Peter Xu

