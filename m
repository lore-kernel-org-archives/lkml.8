Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E76B2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/lnnY3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGJDcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJDcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:32:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A954C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 20:32:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so1895162pgv.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6M9I0N+ITvQl9xLS8Krk1EyTKkYlOBKb0aLEeu36Cv8=;
        b=W/lnnY3WTAA7T9J1NuelxckKknOIoZXKKbX/36nao31ESoCDBAuZ+OW+30GViwVfd8
         5z+0iEl48c4xcxnb5XJilpOu3XLYs6AWNo8D2ckZNgIU8Xkz/LZICnbM7OmeLdBYAfwE
         Mu12ew52Bep212m3xFB2cYiLBQpdr8qxuTeoUXi6m9TtnpD/srLkIUnaDdpzgliIupTF
         6B8WF6wprssPLXrKtgQ4aOTDu+7J6QxZmmpULDLsikCwBGME4BC/HG1W53UVTVCR+kJp
         b1dERd7Jqf/Gvg/fy6IYHXaVY+ooxDd+15OinfaHrBmqNe1s6P0x74b/Cw3b8nc/naiW
         4oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6M9I0N+ITvQl9xLS8Krk1EyTKkYlOBKb0aLEeu36Cv8=;
        b=XPR2hfIVDIUqatLmTkZln/X2dPQwibN1Kj0tIh/aXRA6EuRfJphRX/1hc4nQVus+F/
         NJYrPCJCBGXZdSnuF90AJMtSfb/DRMlLwR3eNz8p9RQSNxGX0ICOiUvgsWsGKKQbHE0z
         vMs4MhJTfDtB3iPeP+bNfnc7mMFOhkS202EK7SrQGKx8rDL4Obbf2WPm3ADOLIqi/hsA
         6pOLmcqpSu9wF/r3BfMkqmpe86wmaHOY/qzXi27zLS3hUY5mVR44y1o7ixdpTooeKlLb
         0t/Ai68KyYu4mVmEXY3JdTERE+3BWNmyial5G21lhoFYDZzup1nGmxVXp3BrlMP1d3/0
         wNGQ==
X-Gm-Message-State: AOAM532RQhLbUBlXlk3jSbSL65ekQv+xEfx+l0HtW0J/fLdhRmk125L8
        K+/cq56PHe8JrZS1V4e1+AY4ZHoPLN0=
X-Google-Smtp-Source: ABdhPJxWp7W3tDSKZHDWvomOrjvvu5VENBEUeF62wqgfTC+Phjp6QzIdRtIQ5UxiD+hL8FDDrsZcZg==
X-Received: by 2002:a62:195:: with SMTP id 143mr52866988pfb.226.1594351923564;
        Thu, 09 Jul 2020 20:32:03 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id b82sm4212684pfb.215.2020.07.09.20.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 20:32:02 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:02:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix static checker warning for
 epp variable
Message-ID: <20200710033201.batyrrr7lgqchw4j@vireshk-i7>
References: <20200709200522.3566181-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709200522.3566181-1-srinivas.pandruvada@linux.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-20, 13:05, Srinivas Pandruvada wrote:
> Fix warning for:
> drivers/cpufreq/intel_pstate.c:731 store_energy_performance_preference()
> error: uninitialized symbol 'epp'.
> 
> This warning is for a case, when energy_performance_preference attribute
> matches pre defined strings. In this case the value of raw epp will not
> be used to set EPP bits in MSR_HWP_REQUEST. So initializing with any
> value is fine.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This patch is on top of bleed-edge branch at
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm
> 
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 44c7b4677675..94cd07678ee3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -709,7 +709,7 @@ static ssize_t store_energy_performance_preference(
>  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
>  	char str_preference[21];
>  	bool raw = false;
> -	u32 epp;
> +	u32 epp = 0;
>  	int ret;
>  
>  	ret = sscanf(buf, "%20s", str_preference);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
