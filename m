Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6837C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E9F2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHmM76d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgGOJqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgGOJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:46:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:46:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so2822085pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ta5eB8n1j7394YSOV3FTjLEgFK5+gJYa0yXjRVjvKzc=;
        b=qHmM76d85REKWg3SKZsETSfnmNFLAxVm2cJUMkbujT3RGqc9CoIY7YAy4DEbR7KaAV
         mgn87zNqG9v1a2P3E0AhydpJDfL2kP8NdJdbSBrp2YmG7Faaf//U+YOnr7UNQkADonYg
         TUnR3UClJ3xp17gA9ZKv6vkdjf29YVQMSy9urGPhbnziIzd++0MJOjIdxhsqL4NHhpFI
         vOHrQoQgLArlWSNibZ6zrfoBqd4rMc+UW37NokY9Mf4ZkR4h3Cl1A4LWEwORZzU7mPBC
         dydy2vhcbETegjiRbuVyCl/DHUzqbMp7r94482uwcfX3rIBbHslqqI1doNi0199xaVlr
         gjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ta5eB8n1j7394YSOV3FTjLEgFK5+gJYa0yXjRVjvKzc=;
        b=FxXZFZ2783TveEaCbVSqHLo/xFTlSfgc8g6KTwhwo2vNUIrhuXesrl4o+Vr3j8cv/y
         pargCOlKH6LFPDVBHl/0G8iAGHoZ4CyQRk9jydXQ0q16+cUosM2MGRMX7UonZo6puWeq
         jp/hWdWSkGzmljOt15pmJbw/daL4Ts2XnZLP8xGpapXWH04juB7QQ2wjfMyC6XVwWWii
         eosy18fkx26QwdnN3to4l7rzEO8HY6icb/wybNtuI97N1HsNG/o0dgQddEoLYk9QbC/E
         rtBKMRuW1QCiZPSWM9CivvquRs/U2pn29PH/CM5WHFWsJrzu7VcPTnIlqaiLAc52kS4G
         bCbQ==
X-Gm-Message-State: AOAM532PYS0uLOLBYGMXxC0qKk5dY8cCOdFHGjApwQd19f71zw9iY4P3
        F7DWdhc45E1HTCElh4DXnq20rw==
X-Google-Smtp-Source: ABdhPJz0ztYWypN5Sqepyw/Es6Ia33xwOYh3KQcd7uKjiWwIyveN/f7pPS+8Qp3He5haCyq1lfe8Kw==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr9099735pjb.156.1594806383451;
        Wed, 15 Jul 2020 02:46:23 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id c71sm1808745pje.32.2020.07.15.02.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:46:22 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:16:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Pal Singh <ajitpal.singh@st.com>
Subject: Re: [PATCH v2 04/13] cpufreq: sti-cpufreq: Fix some formatting and
 misspelling issues
Message-ID: <20200715094620.jxh3wwhvchpuhj5o@vireshk-i7>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
 <20200715082634.3024816-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715082634.3024816-5-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 09:26, Lee Jones wrote:
> Kerneldoc format for attribute descriptions should be '@.*: '.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/sti-cpufreq.c:49: warning: cannot understand function prototype: 'struct sti_cpufreq_ddata '
> 
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Pal Singh <ajitpal.singh@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 8f16bbb164b84..a5ad96d29adca 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -40,11 +40,11 @@ enum {
>  };
>  
>  /**
> - * ST CPUFreq Driver Data
> + * struct sti_cpufreq_ddata - ST CPUFreq Driver Data
>   *
> - * @cpu_node		CPU's OF node
> - * @syscfg_eng		Engineering Syscon register map
> - * @regmap		Syscon register map
> + * @cpu:		CPU's OF node
> + * @syscfg_eng:		Engineering Syscon register map
> + * @syscfg:		Syscon register map
>   */
>  static struct sti_cpufreq_ddata {
>  	struct device *cpu;

I already applied the one from V1 earlier this morning.

-- 
viresh
