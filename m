Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1505F206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLUBXAls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgFAVoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgFAVod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:44:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE31C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:44:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so1290348wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqOi9XVkzEqBE1rgTfwzfPJ8XwX72091Extww43XdB0=;
        b=BLUBXAlsbcW7Id0UV+YkyUmxE0jzUe0/jTCXnNN4S8dLK5/1aj1C/RlHrWFxV1AwyH
         6GbdjWZyiEzX2SGei8S9rFvzqJyLKzA9Iy1wx2DpNKBEIC7EvyM/NTa3QPflZz7Q+ctF
         ymXXXQNdt5EUCszEr9mNqRiaL85A+fJwEzmckf2Kn1c5Kj4vkhgcAvTDk3fbqqPaWI6M
         cirigyYvKk2PguC2yqvcAtCchyS4BOP//JBSjBzcOvPA9eIXC1GzF9l4PAcWwI/C7xU5
         L3laXdnfYY+55kcVzKEzfzrpIagABRawHXTr1HqGHv8f0SlrtfRQGIBxyD8Oa8lGahS5
         e7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqOi9XVkzEqBE1rgTfwzfPJ8XwX72091Extww43XdB0=;
        b=XV2urZMrLNFGrHUn1a8Ojj91Ei5EY88qKNFLgCssPjn3Nd+Pr92/9WlSI+X8nFPYus
         RDe/fcJ65AGs1IWonC3X4ZdgoMOZlFJ7S+ZaJ6dc/pOYVa00a+CsUD9I+0rWssqN85Mv
         BkP//e9XhmWM0Ob2HNchmAkJs8g1NbtHRpVg1QJ0R9ZVI1k7GoNWNolFeGUGT7D/YA/i
         5WM8+UeHRGdnU4aNshlYQIn73BtstxQ5++0vq1dZUxm0HhfY5f0LU27BMAzUzpcgfHy2
         Ei4t/oFsF+ohj21D6BtHn+ac/x+GevcNhR73qZeqZfa34IEcEIdfulVfY699us9HrX3/
         NW7Q==
X-Gm-Message-State: AOAM532y1RYyjJ43sMb3Q2QZEigzKoIqMP9/RA1hxUDAFCbb+/y4tT2G
        zvZOEAkfUAk4+yAi6MOKUcOB/w==
X-Google-Smtp-Source: ABdhPJxAkSTXgDmNloFKRd9lVGwwLE5uAp68LgGpm5gXOB9wVVSaY/AqsZoSHbg0AzWXmkv4CYHlkA==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr23274786wrq.259.1591047871147;
        Mon, 01 Jun 2020 14:44:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e125:f600:eb3c:705b? ([2a01:e34:ed2f:f020:e125:f600:eb3c:705b])
        by smtp.googlemail.com with ESMTPSA id q4sm781499wma.47.2020.06.01.14.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 14:44:30 -0700 (PDT)
Subject: Re: [PATCH v8 4/8] PM / EM: add support for other devices than CPUs
 in Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200527095854.21714-1-lukasz.luba@arm.com>
 <20200527095854.21714-5-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d45e5592-8e11-858b-d3a3-2ec9ce1d1f54@linaro.org>
Date:   Mon, 1 Jun 2020 23:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527095854.21714-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2020 11:58, Lukasz Luba wrote:
> Add support for other devices than CPUs. The registration function
> does not require a valid cpumask pointer and is ready to handle new
> devices. Some of the internal structures has been reorganized in order to
> keep consistent view (like removing per_cpu pd pointers).
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

[ ... ]

>  }
>  EXPORT_SYMBOL_GPL(em_register_perf_domain);
> +
> +/**
> + * em_dev_unregister_perf_domain() - Unregister Energy Model (EM) for a device
> + * @dev		: Device for which the EM is registered
> + *
> + * Try to unregister the EM for the specified device (but not a CPU).
> + */
> +void em_dev_unregister_perf_domain(struct device *dev)
> +{
> +	if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
> +		return;
> +
> +	if (_is_cpu_device(dev))
> +		return;
> +
> +	mutex_lock(&em_pd_mutex);

Is the mutex really needed?

If this function is called that means there is no more user of the
em_pd, no?

> +	em_debug_remove_pd(dev);
> +
> +	kfree(dev->em_pd->table);
> +	kfree(dev->em_pd);
> +	dev->em_pd = NULL;
> +	mutex_unlock(&em_pd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
