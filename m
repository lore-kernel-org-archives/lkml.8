Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4708AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7F121D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQK7Mlcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIJDnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIJDnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:43:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0ADC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 20:43:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so2361083pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 20:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZmS2T2jFD4Mhxd1SucoAel5AcWUGDJSMEH/6aOpQ3E4=;
        b=xQK7MlcvpwgA7zVon4fYwgsjjBXLD1QDVQO0Y/wxK4TpVqAOuOsyHTfnz61IDHZ2n5
         TGXB9Ozsm5y9yYIWBSZihicx99cw8Tqy45Kzki86JArCPtrddKx8cx77jJLwOpYMGaGK
         M7L2/yKx7qk6TgLvU71F2gSNpHGQNerD4WBLdX/GKAstcJMfIlHlelhbu9G4XmmlB47K
         vvZ5OFuqcsxwTb0J/ulV+DTtR8GWtu+++Va24XqlOa+K3nMYat+XJPH7FLd09HLwP1TH
         083BY7CAp5HdCGyDtmJmOb0fZYTgNC3uZZhOlqvGsm/C6UlMfNwTL7XcG7+LYgwmCgj3
         O5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmS2T2jFD4Mhxd1SucoAel5AcWUGDJSMEH/6aOpQ3E4=;
        b=sQKq0HcYNC0UFZWqGPNw+tUAxp0KZD1mjVHaHRMI/hJntmVFtcVfnnx5Tw8ywausyU
         ktYTRAXrz/nXvPfezxpTZvi5ccR1Hrfx2WMhagLbxdz7uu7leKnr93Aehs7fplNjsYQp
         /ghxE2h2wGZoBz0VoCFyHMdOwwZ4TyvolT5YJp1kGR1Uk/78kxNyhKH8RfYm6+Oq/Hpb
         XfSByJYVYeXXMcDXs19YDVMb2xnvlt6TCx2C78P6JdjHnCTPjoSJRAT8dyS/y+Jx2jVs
         F2fFQuOuMuxySwF7db/tpWewLWcYreG4UGrAeHfKHl6syQMnZEz0LZifa7O4u6rtiYN/
         ExHg==
X-Gm-Message-State: AOAM530hPGLXVAJ2pRH8/fIz6LKDelHD6205L/81XS5BIY/p+SGV6ThO
        D/8lmXqOGLzlbJyGCPk+uyyvTg==
X-Google-Smtp-Source: ABdhPJxRgu58IL1rniuVlRLSIpomG8nzd42RuHvTf3NVD6MC0hy7wZ/evpSgjCdMunvXwKBg/3c4Tg==
X-Received: by 2002:a17:902:10f:: with SMTP id 15mr3733723plb.121.1599709379966;
        Wed, 09 Sep 2020 20:42:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z129sm3423532pgb.84.2020.09.09.20.42.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 20:42:58 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:12:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v6 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200910034245.eqya625p7la33dkc@vireshk-i7>
References: <1599658476-16562-1-git-send-email-hector.yuan@mediatek.com>
 <1599658476-16562-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599658476-16562-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-20, 21:34, Hector Yuan wrote:
> +static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
> +{
> +	struct cpufreq_mtk *c;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;

Why didn't you drop policy as we discussed in previous version ?

> +	c = mtk_freq_domain_map[cpu];
> +
> +	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;

policy->freq_table and c->table are same, isn't it ?

> +}
> +
> +static struct platform_driver mtk_cpufreq_hw_driver = {
> +	.probe = mtk_cpufreq_hw_driver_probe,
> +	.remove = mtk_cpufreq_hw_driver_remove,
> +	.driver = {
> +		.name = "mtk-cpufreq-hw",
> +		.of_match_table = mtk_cpufreq_hw_match,
> +	},
> +};
> +

Remove this blank line.

> +module_platform_driver(mtk_cpufreq_hw_driver);
> +
> +MODULE_DESCRIPTION("mtk CPUFREQ HW Driver");

Maybe write this is "Mediatek cpufreq-hw driver" ?

> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5

-- 
viresh
