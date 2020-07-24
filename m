Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48072074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUjgZVlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGXIcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGXIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:32:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A229AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:32:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so4829742pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qyOT+srqW/4ticn66C2lEkMT6M5pMOVqqYYTMOJY7n4=;
        b=xUjgZVlR3sBn6VzmB0HqPvVQadG6JVd9ZYfR3mp+M5ExPlFkKnyR0XQK6TuWPmhgU4
         E1diM3LlwsW/xN7B5T80ylCBEKeL42zpuGgu1FWVaoyAQVKftSVRPFEZeVSwQOWAk3Te
         HrSHa0wigbOggBD9pCiFx/wjTxKEBxZ+ZQON92HASRHe4XsqEJqNLMX52H/QI2Bc7yT8
         dzX1j+kFMWryjV9opmMMmz+knl6CwpMRrI1WUUktuxJoxrgKW7bEPRj4aaRd1yH64LVT
         66Omth2ZDzDR1ywzCJCLLGrTJ7qEk/Bgj2sbzGErOOBOwcQbZGyWlnEjaK0CkED8wfwp
         wAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qyOT+srqW/4ticn66C2lEkMT6M5pMOVqqYYTMOJY7n4=;
        b=FB7dWd9tTeYKZKo53vQxkg+xoQG9l8ah4KO+VkS/DCrczToQI7GHNR5PYbdENe6ex6
         E/buMo873nyfKBHqShHqALm6AEMMlXzUbwTMEPd1N3QaeGKd4RYnHM8/HaASaFA49Ynf
         zGKeI3lCHIUmngePby49tM4GKwqtqk4OoTPlCYhnT4sEqlrxMxBLC1Ze2VJUOrebh47P
         beAJl0u/S6VLzN+ujvEeKty+lVplfjgL3Dss889lnJzFy4dbdMkS/BXRKJVmup7zRLAo
         H68OKmsRPzPfcQMReAQMVaswLxmfEz1xCuMBbvLnb1YMAzq0ZqFQDvh3FYkZdjryNjkW
         ajdg==
X-Gm-Message-State: AOAM530tq1tPG71L8f+OqeuMiOEqbn5EVt0X1Bx3HfsfaYSke94gtrWy
        5Xp+oDdjsfAf+VLnn99q3N8dsV8gMyRSgg==
X-Google-Smtp-Source: ABdhPJzo9OYy5SuD2vBDwqQ8X9hEC0OXDXYZrNWoCzOgG/UbU8AiHfGSxuR1jcPT/b1BV3vXhZYPIA==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr7186597plz.8.1595579553945;
        Fri, 24 Jul 2020 01:32:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([117.136.120.151])
        by smtp.gmail.com with ESMTPSA id x3sm5392267pfn.154.2020.07.24.01.32.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 01:32:33 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:32:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, guohanjun@huawei.com
Subject: Re: [PATCH] perf: arm-spe: Fix check error when synthesizing events
Message-ID: <20200724083218.GA5185@leoy-ThinkPad-X240s>
References: <20200724072628.35904-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724072628.35904-1-liwei391@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Fri, Jul 24, 2020 at 03:26:28PM +0800, Wei Li wrote:
> In arm_spe_read_record(), when we are processing an events packet,
> 'decoder->packet.index' is the length of payload, which has been
> transformed in payloadlen(). So correct the check of 'idx'.
>
> Signed-off-by: Wei Li <liwei391@huawei.com>

Good catch.  I checked the ARMv8 ARM and the function payloadlen(),
can confirm the fixing is correct.

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 302a14d0aca9..93e063f22be5 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -182,15 +182,15 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  			if (payload & BIT(EV_TLB_ACCESS))
>  				decoder->record.type |= ARM_SPE_TLB_ACCESS;
>  
> -			if ((idx == 1 || idx == 2 || idx == 3) &&
> +			if ((idx == 2 || idx == 4 || idx == 8) &&
>  			    (payload & BIT(EV_LLC_MISS)))
>  				decoder->record.type |= ARM_SPE_LLC_MISS;
>  
> -			if ((idx == 1 || idx == 2 || idx == 3) &&
> +			if ((idx == 2 || idx == 4 || idx == 8) &&
>  			    (payload & BIT(EV_LLC_ACCESS)))
>  				decoder->record.type |= ARM_SPE_LLC_ACCESS;
>  
> -			if ((idx == 1 || idx == 2 || idx == 3) &&
> +			if ((idx == 2 || idx == 4 || idx == 8) &&
>  			    (payload & BIT(EV_REMOTE_ACCESS)))
>  				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
>  
> -- 
> 2.17.1
> 
