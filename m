Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A04BC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AB6206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0VhaBxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGOORo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:17:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C87C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:17:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so6036715wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1JgqT9mrEdGtuuXwQt1J5C4Rwf+h8f2OaFWoY0odJro=;
        b=S0VhaBxg8cYN2y22Wc8O6G1H0W5VMl3rd5sgHxUVmhOmkptVnKaF2Atf0ycbrTZlJJ
         sND/EQFP9ttvwNC0bf7Aep2qLg+X2eS57cDpA5Y48S+1/77eLo6OmZElOADrMEqeBh7f
         k4fLSjVpyGlb6Q+Dh6qeGDi/Argdm/WmvtL5C41RmhcJ6NsfE6KAx7bxDDr08n7D4auF
         1Z1XDU61mCGt8BkkdkTjLxR2YIvWXVvaXBAy5mhit9DKMAdmxGSnbig9tLf/1awmFsYn
         ykR2apsM/CS1X95ZF1wa1lIrb3u0f/wtq6QczfxsneKAuT4a2TMYSboex0KVB6zfsKZd
         A2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1JgqT9mrEdGtuuXwQt1J5C4Rwf+h8f2OaFWoY0odJro=;
        b=oKESBryHecPnXD6aW/9Rd4aoQzTG11Xqx6UppO8Z4MqzMzN78c+1QSFvNO+eNOGmjQ
         D8Fzv/kgesxRII2fgAvmagRchtiwufzvWJtcb70efIPshDQ9wTrKTYiJZO8PBWfcT9fE
         OSugMLf+TRGqY1qcmL6vq9RWzUK1bmT/pICMPsUHNgtubz+dsuG/RVlGYf2YN5iWz2kC
         qGV3AqbaKCLj7kaPxozHXxAeo/sacY3Sj3GL4kXkhZ0Ke1eS1CejpDOT00HmMNL+oonR
         kcy+oBcYm8ODhF/I9aTjoyUoPLy+LL6/yFYXhwfhhbLk/G8KEBXlvezAqHJ2IN5xIEBS
         sjLg==
X-Gm-Message-State: AOAM531eK52Ptzl/oEAAPuPm9d/Mdw/xWhV81zrbqARgAYBrseNkxNLJ
        98MIi6hazlTf5P9IBUQBdtG9TA==
X-Google-Smtp-Source: ABdhPJxOQs7hjvQMJKZS3uHDUMnZ/0JyZLpaK8BTw6SybE8pBSddAZM6kWuOIcneFpTvLZCFPfLoXA==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr8820870wmh.130.1594822662438;
        Wed, 15 Jul 2020 07:17:42 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id p17sm3394573wma.47.2020.07.15.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:17:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:17:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Clean up aperf_mperf_shift
 description
Message-ID: <20200715141740.GG3165313@dell>
References: <1695770.kLfQgcESsc@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1695770.kLfQgcESsc@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The kerneldoc description of the aperf_mperf_shift field in
> struct global_params is unclear and there is a typo in it, so
> simplify it and clean it up.
> 
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -202,9 +202,7 @@ struct global_params {
>   * @pstate:		Stores P state limits for this CPU
>   * @vid:		Stores VID limits for this CPU
>   * @last_sample_time:	Last Sample time
> - * @aperf_mperf_shift:	Number of clock cycles after aperf, merf is incremented
> - *			This shift is a multiplier to mperf delta to
> - *			calculate CPU busy.
> + * @aperf_mperf_shift:	APERF vs MPERF counting frequency difference
>   * @prev_aperf:		Last APERF value read from APERF MSR
>   * @prev_mperf:		Last MPERF value read from MPERF MSR
>   * @prev_tsc:		Last timestamp counter (TSC) value

Definitely clearer.

Reviewed-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
