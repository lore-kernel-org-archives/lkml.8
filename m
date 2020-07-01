Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD4C433E5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B67A2070C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ew3NrNwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGAEwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGAEwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 00:52:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC31C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:52:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so9418280plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7eYb9sQ67BQ+n6ANY+Ph2Puop3csMsMIF7Sv6LdAfmE=;
        b=Ew3NrNwW4KiwmImm6a47YMFZgv/8YcShRwIFUCg1sbr33opr6FVq7cshuzjy9Dn1xX
         mg1hGWAzWcdAUA5vIejnimpTrOM+92CsytLaVIbisFUVYe6vWk4JzoYM5FcnNv4VHmOq
         IR3lea0LZIywRrHdCG/i/FBZYv6jZjuSQI5XhNezS1ao71anKq3pnUm+STn0ygZNyNlY
         JbM1ArJqM7QtjVxlj6NyS41jRmmXsd2aa683vEtUcDPHu2XRrxMatf7R3ej1GHPbw4Es
         LG9jH4Hqna7PY4gHCTPaNIR6/DXD7eZbHFE9siIfQnoiulUo3LuGs1w7JQntNgWGGH++
         shQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7eYb9sQ67BQ+n6ANY+Ph2Puop3csMsMIF7Sv6LdAfmE=;
        b=GeeT3Ld+/lcvdCl+sZzAiSnxEHm6kWbgv0zttzUnS8TLc+BgqJhOfJ2pb9hrSf591C
         35p2Z4aVBkvQe7AYI1LjOsWGu60yG3P6TTLuwItS9+0DtsDDWvNudjwUENf8xo4rwRDR
         BeY6+Ebt8wi5YnjJZ2C8jP+PQGYPCscViP/Qdqq5y4N9/2QbxwnBzo179p/xa++07pfd
         dwyljBIFh62sVZdaoePAuj8qTYViA5BPwvjnfftUoVo6Gq5mFmJNLwZdiG8Xc4JejHzu
         CMaK0h45Jgwnr5cGQbRKHshkQS3uV27o9GMtAJy3mGtydZEpN5LjZQFuoZ1E/8Cb1rZn
         Qhfw==
X-Gm-Message-State: AOAM532/c1quzmCqdDskBOLzUbSWeJ5O6JYlyG9heVMsIwLNqug4kBk3
        5xiFkNk/NnW+HAtEIoi/LZBMe5AypDk=
X-Google-Smtp-Source: ABdhPJw7WLjPrEgQDUgRPosBAR1pD2cN4A1I9ovdVdigC3+ZESc7even4HQ3ZZRxdBZjC1XmipWoOg==
X-Received: by 2002:a17:90a:898a:: with SMTP id v10mr24899274pjn.95.1593579150490;
        Tue, 30 Jun 2020 21:52:30 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id h9sm3499383pjs.50.2020.06.30.21.52.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 21:52:29 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:22:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]  cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
Message-ID: <20200701045227.epojzjwuky5kkdzj@vireshk-i7>
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701042007.13333-1-xhao@linux.alibaba.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 12:20, Xin Hao wrote:
>  The 'caps' variable has been defined, so there is no need to get
>  'highest_perf' value through 'cpu->caps.highest_perf', you can use
>  'caps->highest_perf' instead.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726a4456..051d0e56c67a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
>  		if (!max_khz)
>  			max_khz = cppc_get_dmi_max_khz();
>  		mul = max_khz;
> -		div = cpu->perf_caps.highest_perf;
> +		div = caps->highest_perf;
>  	}
>  	return (u64)perf * mul / div;
>  }
> @@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
>  	} else {
>  		if (!max_khz)
>  			max_khz = cppc_get_dmi_max_khz();
> -		mul = cpu->perf_caps.highest_perf;
> +		mul = caps->highest_perf;
>  		div = max_khz;
>  	}

Applied. Thanks.

-- 
viresh
