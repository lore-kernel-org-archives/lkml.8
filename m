Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D09021835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb38uIUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAWQQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:16:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36098 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAWQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:16:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so3755673wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3wg8gOrVYdMUWA9+fse4PsjZpTdzVA7/z9UyxnCJfNQ=;
        b=Cb38uIUJp0jMTwJ0E5yH8vzy5T9Soz0UlHK1JVnva3ss9OdTf61o7IFGnH+pxHfR67
         jST75Xd0oFFEJjatfLTXktSTyflyn+b4K7OlFPABTdBOhgTs3UcCOSKb27Vz8l1MdZ0c
         /Bdp8cbOVevZetkKDvtQSKElHsQKwGX9EojAAsuvDtEbPlw7F9onNHg9ZrPZSNlHaqdL
         50keozoLuBTRC0Yyq6rnMYwv3HXMztrhqK0TLZV0Vr5UwW9eOWzFwoHHLehoikHsp09r
         9MkAozLrDW8NvDcCclSWiu34RUJgpXLYgElAsAzSfsTo5ycsLdmF5+JVrFaLqNxoMxFX
         BfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3wg8gOrVYdMUWA9+fse4PsjZpTdzVA7/z9UyxnCJfNQ=;
        b=LaWhxSDRA8DphKAiRIWna+zqcHuJe7UoL/otUDVwvdK2pwm+nTQUL1WzN1aW77gzdk
         Lc4R2yTTUfwlpQxLtBmV0dJ8nb70FyDIXhSTDWVjw29rfKrm0ZSEn+Jw/lt7KLnvwpq1
         ghVqqauVdREGJUVrgtlii2snd+HRtYl+Ixu9KvFHccLwj39zLZviuv9c7WKBRErd0P2m
         LiQnyGPETegqFnMF4jSCtzt/+7tMHqrAS5v8NU+MqMdrc4bjA/mIJmqqoIxQYX8A7kFP
         F8NSBxI+3smaVfLeviUG4MJBrZRDjeN/lADcdKPS24BnKOI8lvYqbc+9PsWFRpDeDG7y
         LXPg==
X-Gm-Message-State: APjAAAUv/Pf6hELe2hrZ9ypFtLq/wiD0qkTFkPOw2dOG8LhesL6OXUq2
        jnb6ayeV6EnYkMpumrx7KJyG4g==
X-Google-Smtp-Source: APXvYqz2OF9zgokJR54BriRuGctuH59RTy0BPgQ0BEA6zvcdl0w0J4GK/zkkuAGysmN8uaoPskaboA==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr19015715wrv.358.1579796208751;
        Thu, 23 Jan 2020 08:16:48 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a132sm3254265wme.3.2020.01.23.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:16:48 -0800 (PST)
Date:   Thu, 23 Jan 2020 16:16:44 +0000
From:   Quentin Perret <qperret@google.com>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power()
 into get_next_freq()
Message-ID: <20200123161644.GA144523@google.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-4-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122173538.1142069-4-douglas.raillard@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 Jan 2020 at 17:35:35 (+0000), Douglas RAILLARD wrote:
> @@ -210,9 +211,16 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned int freq = arch_scale_freq_invariant() ?
>  				policy->cpuinfo.max_freq : policy->cur;
> +	struct em_perf_domain *pd = sugov_policy_get_pd(sg_policy);
>  
>  	freq = map_util_freq(util, freq, max);
>  
> +	/*
> +	 * Try to get a higher frequency if one is available, given the extra
> +	 * power we are ready to spend.
> +	 */
> +	freq = em_pd_get_higher_freq(pd, freq, 0);

I find it sad that the call just below to cpufreq_driver_resolve_freq()
and cpufreq_frequency_table_target() iterates the OPPs all over again.
It's especially a shame since most existing users of the EM stuff do
have a cpufreq frequency table.

Have you looked at hooking this inside cpufreq_driver_resolve_freq()
instead ? If we have a well-formed EM available, the call to
cpufreq_frequency_table_target() feels redundant, so we might want to
skip it.

Thoughts ?

Quentin
