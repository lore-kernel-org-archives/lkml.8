Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0F7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DE20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L248HdTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404397AbgFYLgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404239AbgFYLgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:36:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E2C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:36:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q90so2405691pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zQMqcazx04oPZQDkNalK3c+oZ7+4RMlmpEj0gizKox0=;
        b=L248HdTsPVnj/dY7XKrltNkz4VYCOnOgsSQfRfZu/tPmRa0oZMbcjKF+5ejsPs/2Y1
         NL5I8SsxCo24n66/lBXA+bygwjzf5iJTi/DZlzUczZbpR7wRK1iWGCbwRKOcb9cvc/f/
         gJslRoo/GTy/cuYo1p55x5m4tK+urvm5yXU10mM1U1oaUKX14HbI3DdE3d16qXqww8Pp
         K0YpNhy99bRpIj+9f5r7EgDls76+B/xn9bxjFPIbXXRc833qLbghfPmrba7L95Y3CKx8
         Yjqh3hPP1F5kprbOpUPbOWSQTvlef3cYCeVh7vnXxZQYLEZRa1if4spadTWe2wiNiiiK
         w8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQMqcazx04oPZQDkNalK3c+oZ7+4RMlmpEj0gizKox0=;
        b=BUyfiG75m1d9vCpznvahJHEWSzGS8HxEC5SfGoXW3cT/xhwqbiHrEd0uoPfDl4hmU8
         8qRTtN1xgvPs5iLW1z1nWkNjq8AztLzixMGO0A6D0ZQggCjpu2+7M9BgfZe4rodAMcEV
         Z5A4y4jFf1lEWiTptmZIQIsDjm5+PatBZPO7dwnubMNF92FkLZ+LqycTOahAdSaWNRf0
         LNyymeruQ72+rduU0Omt/vCqUY5JngESgaElpJzjZEHoOyzZJYSA0l87Ttr/sMix5TlN
         bPIp2NHSyDnJhguHtaCrDMAbWXSPE3jejVqvbvPVl44/FY49Rf9O9wzuWFmGKgeCLNMb
         GxFA==
X-Gm-Message-State: AOAM531YJctZGnoX66d5wx+PRGbFFwKbHkxhBVZuXwN8EVDd1kQU7ap9
        nbFRrnKng2JnMEMopbs76PJbVQ==
X-Google-Smtp-Source: ABdhPJwuUmK8E9MFP4gCexgTFH6CLEAZn2UkSkrEV9QFJ0/Po7aUxoQVoHBtPpVEHTgbwLK9Ms70Qg==
X-Received: by 2002:a17:902:7787:: with SMTP id o7mr9561302pll.327.1593084965635;
        Thu, 25 Jun 2020 04:36:05 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id r4sm19096550pgp.60.2020.06.25.04.36.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 04:36:04 -0700 (PDT)
Date:   Thu, 25 Jun 2020 17:06:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623142138.209513-3-qperret@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After your last email (reply to my patch), I noticed a change which
isn't required. :)

On 23-06-20, 15:21, Quentin Perret wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0128de3603df..4b1a5c0173cf 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -50,6 +50,9 @@ static LIST_HEAD(cpufreq_governor_list);
>  #define for_each_governor(__governor)				\
>  	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
>  
> +static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
> +static struct cpufreq_governor *default_governor;
> +
>  /**
>   * The "cpufreq driver" - the arch- or hardware-dependent low
>   * level driver of CPUFreq support, and its spinlock. This lock
> @@ -1055,7 +1058,6 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
>  
>  static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_governor *def_gov = cpufreq_default_governor();
>  	struct cpufreq_governor *gov = NULL;
>  	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
>  
> @@ -1065,8 +1067,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  		if (gov) {
>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 policy->governor->name, policy->cpu);
> -		} else if (def_gov) {
> -			gov = def_gov;
> +		} else if (default_governor) {
> +			gov = default_governor;
>  		} else {
>  			return -ENODATA;
>  		}


> @@ -1074,8 +1076,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  		/* Use the default policy if there is no last_policy. */
>  		if (policy->last_policy) {
>  			pol = policy->last_policy;
> -		} else if (def_gov) {
> -			pol = cpufreq_parse_policy(def_gov->name);
> +		} else if (default_governor) {
> +			pol = cpufreq_parse_policy(default_governor->name);

This change is not right IMO. This part handles the set-policy case,
where there are no governors. Right now this code, for some reasons
unknown to me, forcefully uses the default governor set to indicate
the policy, which is not a great idea in my opinion TBH. This doesn't
and shouldn't care about governor modules and should only be looking
at strings instead of governor pointer.

Rafael, I even think we should remove this code completely and just
rely on what the driver has sent to us. Using the selected governor
for set policy drivers is very confusing and also we shouldn't be
forced to compiling any governor for the set-policy case.

-- 
viresh
