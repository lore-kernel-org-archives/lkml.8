Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE602C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2EF2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595850190;
	bh=KhPxVdrXN8wLnAx0MqDssY9fDUsiTaVpHEdtykstJgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ynk6AnJFGzLeWGTtmxPUbltdK+ROYiah/kMuHeaGpOqS7FLRLkIlDvIYbgVjC2BxV
	 wKVoaqKGqW2Qr333XoHjGqPxs7V3hUiT80I0qsotsibq04ANC5MnuTD3CXADiuIfPL
	 sSe0Pow4qdsvNOVM5JjYpNf58iTJXzncvaQP7zZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG0LnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgG0LnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:43:08 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E583C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:43:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i26so8576363edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=npsW02qfGd4D5Pq9wgHcEBxBe/85HbrjVblV94aw6Go=;
        b=Wdsz9cvlvfFPZWTZRmq4crM4Vi2tSSHPhOy9Vwqu535Xzvabkb3H6TEIuRRs2j4Yg+
         WNE5bCe5sXeTzkIuaNOU+WLnkWojzQUmR8XVwQuncjmHEvKNQMp1WfdgytbIxuD4XEr+
         TWs/gp+tFzAm/gxN7j+H8iK7SByvebNFrJF57oMnGIz2wnTc7o4lQ2h+8iinEWkIOcTs
         r5twNj6VHDr4JaLl+osmnFMUT6aON0Srtt49JsRT0m3afEsaRNIvGBPFkxtlZodM4Rn2
         hq6K6dHlHgkBvk6ygcXC6dpGdX8Ke1p3movKlD1b+owlYP/frOLUS9aWB/IQ6gxIs6lE
         vbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=npsW02qfGd4D5Pq9wgHcEBxBe/85HbrjVblV94aw6Go=;
        b=kuz5cIqWHWtypvSWgs/b/T9c+W+UJ2Oy6WGoz2Z8sGeVun9yx2a10Z+AJONzDigWl3
         JSWe+3XYKenRhHiCConUqXkK8eyVsvlzdwR2Cf1euz2+rYZz7lI/N2b1KQFZbPskR9U8
         JCgQIReHVbur4EnN1BVut3gOlrXz/IKzKqfDAM2kT2szitL9qqxfNh++hObEF053eW/m
         hQ1U9G23dEWRqpbDizwk2+jKw9P8Je1UGbpN7w3fDW1tj3AyAOKjNXtO43h0Zy0lJtPb
         ltcEfhrBr2d71qYnQIgj++5IoLMJ5G3K6eXYbrnFPAAsOS6sLxDKkhTAJ80RmnGCTpWb
         M5wg==
X-Gm-Message-State: AOAM530akmlwXsnsEWkDIbxtC/yqe/ZeSQUpNDWS53chwfaN1FSC79O0
        VWDbksNu0OZn+HExFZpQYrw=
X-Google-Smtp-Source: ABdhPJxqsaRnbuSFkpkmHFcKxmLBK9brfFzN3IGPkGGgziIBKCSDwOfmr2YL2WCfjX5i2xTGiksKBw==
X-Received: by 2002:aa7:c45a:: with SMTP id n26mr1709689edr.45.1595850186068;
        Mon, 27 Jul 2020 04:43:06 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id qn10sm3794945ejb.39.2020.07.27.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:43:05 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:43:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de,
        namit@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] smp: Fix a potential usage of stale nr_cpus
Message-ID: <20200727114303.GA57241@gmail.com>
References: <20200721034239.72013-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721034239.72013-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Muchun Song <songmuchun@bytedance.com> wrote:

> When the cmdline of "nr_cpus" is not valid, the @nr_cpu_ids is assigned
> a stale value. The nr_cpus is only valid when get_option() return 1. So
> check the return value to prevent this.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> changelog in v3:
>  1) Return -EINVAL when the parameter is bogus. 
> 
> changelog in v2:
>  1) Rework the commit log.
>  2) Rework the return value check.
> 
>  kernel/smp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index a5a66fc28f4e..0dacfcfcf00b 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -772,9 +772,13 @@ static int __init nrcpus(char *str)
>  {
>  	int nr_cpus;
>  
> -	get_option(&str, &nr_cpus);
> +	if (get_option(&str, &nr_cpus) != 1)
> +		return -EINVAL;
> +
>  	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
>  		nr_cpu_ids = nr_cpus;
> +	else
> +		return -EINVAL;

Exactly what does 'not valid' mean, and why doesn't get_option() 
return -EINVAL in that case?

Thanks,

	Ingo
