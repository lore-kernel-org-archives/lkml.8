Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4201C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C451C2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pATiSDC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgHYF4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgHYF4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:56:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5ADC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:56:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so666951pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71pJ7QjjJTQjXRcSuqPTAeCxZZrph96zOEgdE6uAIWA=;
        b=pATiSDC3PXXEIOS5eCee9BI1TKY+gifYdWc8S3H5T9Ugb6PmWvWZiiG1zM94yJkVJg
         YR57iDUo4MW7cmhd7780f1XhepjGUzoOquzMPb/dVJNEHfOpp1OKPhsZFJFuW7+hnGMs
         zmGx7wohYpQ4/gznF6irL1C/EjihtZnLDu4W/WHbvwcaYkeCmi3n1Y/Ji040tNuxcPsy
         /474JPL02xH44nzV5S+y5yl/YV+YWTyc61eVa094QdyxBsCF3TlIqKCFYIhRd46O57wb
         NEaWBXbwYH8Wq6doaEwpxrAnHPRRkNcFXJzoJPm1ZyeGDp4gjwSC/9fhCkcQawH+cE86
         g7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71pJ7QjjJTQjXRcSuqPTAeCxZZrph96zOEgdE6uAIWA=;
        b=Q7z8HuKs16dI0eQ0fdY1BVrOZRkIeR6sZRj1g43iTOzwKkot/rOpMmQEuKWR/kKmK8
         iR2wHzuQ3xMt+nkYoYbu2YhmY8dXf0uc4Uqxz4D4MWHQLebiGP8moTsHtFphO3o+wpug
         mqPRvQU0vCGGW6z8w3qWBjbd9EkCtxZrDsYhLcDr8TyIUoYZfYgE2LsZBDMp63Z2YKzP
         28Dg9NrpGFUkR3FWKKUhdF1aLIAzk7wd0r1S8dgOgwlnveKriaKi7XrQpe4MkEVUMwJU
         8aBOadRGFBjxmIFbxi5CHbS1ZGvPbYSLqkoEeuToRSbn717/Tnyr/d4y596XyDzWmpor
         EXzQ==
X-Gm-Message-State: AOAM532q3xGLBW8EH5YS2/+bfjV6+9L3efSt47iiXnNzP1lbivq5SKrb
        fWmRvkVsSoDJipzRZZT6hhgxJQ==
X-Google-Smtp-Source: ABdhPJweOS+a1mkYGjwfO83Wk2UMcViQ1NsZH/J7DF0Ov5svgz1gpDZKEYJvuHXGVQ578h3cRMmbIQ==
X-Received: by 2002:a17:90a:d594:: with SMTP id v20mr276936pju.227.1598334981146;
        Mon, 24 Aug 2020 22:56:21 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id j3sm1355761pjw.23.2020.08.24.22.56.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 22:56:20 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:26:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arch_topology: validate input frequencies to
 arch_set_freq_scale()
Message-ID: <20200825055618.ybght3enlpuwo3va@vireshk-i7>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824210252.27486-2-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 22:02, Ionela Voinescu wrote:
> The current frequency passed to arch_set_freq_scale() could end up
> being 0, signaling an error in setting a new frequency. Also, if the
> maximum frequency in 0, this will result in a division by 0 error.
> 
> Therefore, validate these input values before using them for the
> setting of the frequency scale factor.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
>  drivers/base/arch_topology.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75f72d684294..1aca82fcceb8 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -33,6 +33,9 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  	unsigned long scale;
>  	int i;
>  
> +	if (!cur_freq || !max_freq)

We should probably use unlikely() here.

Rafael: Shouldn't this have a WARN_ON_ONCE() as well ?

> +		return;
> +
>  	/*
>  	 * If the use of counters for FIE is enabled, just return as we don't
>  	 * want to update the scale factor with information from CPUFREQ.
> -- 
> 2.17.1

-- 
viresh
