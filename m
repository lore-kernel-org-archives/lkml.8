Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD07C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457062076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAGe9Efg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgFHK2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgFHK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:28:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D63CC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 03:28:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n9so6505225plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39m+2LLbv6DmBKnk5P51Aj/s0CDKaXKRY6RVZpmO47k=;
        b=WAGe9EfgYRXcs6oNuDgg+A5B5DLZKzh4sjoqPNRbHSPYUsD654Ef1u0NL1YTyBQJbH
         3AAQHDRAFqZYQHcRUlc7swh6QESQXgVdWti12n2MKx0W1qMmCYiJOf3wVNg3llo5qVzU
         jeLX7I4WOEoskkTxzZilOnuhERrqKx2CArW9Ay9eBSsErMEDyjfiinrbF1tbnOIfRVKT
         zYqOwFTR6JxFVjVfjYdV1Ozd+PV88T94fYPeucXCSGHFqpmfTc6v3FhZUeqIRJwyqwLC
         6pGwNOxhVFiddns9nUl45WEcBbvoHqPVAC2h8E95E+7t447c4eMegnPjx9xnAmolpzvJ
         4j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39m+2LLbv6DmBKnk5P51Aj/s0CDKaXKRY6RVZpmO47k=;
        b=JPorqSVQatEAA4eBf4TTj9Rayxp59ctHgfOiLwZFzUxHCp5eJoU+FZ8eHPljz0ErPV
         BdhkngMWontKtljvokVlFhjV/n4myoerHlIKu5OTHowrcZNaU6VgntF9ukvUHNp5ex6f
         9gTLE9S+rCYYchhVE4MhbkQqtKZblxbvgdyPV8c4UfLOPYrGCs6ccNmcu8KCnBzAFPmx
         +0L1iYV0pG4yVUaVQvQ1sspgFPPXjwnDHFn0izEQGGf8lDnOetjqrR1q5ZO9z+bBnL2k
         UwVF5MXhvTHBEKbtzU9b+Y1BJqHb0aVphuGoe6ofkj8J+EHFZS7JquIGwrQp2J+Ioz/b
         2zkA==
X-Gm-Message-State: AOAM531JJmqf5aCMahoSZ8WwKHEVjN9GoHQj021ZUJXFj1OxGVLgIdLI
        b2JHuVQcmzzp8JW8yHijmVVeAw==
X-Google-Smtp-Source: ABdhPJy7tUDmw7E2+N2dP4+jFgxDi565u5EZbJy/npJ1/aTQhfV9kSuAXl9CPg0tBQD4hXT6yfe9gg==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr20467004plt.138.1591612080996;
        Mon, 08 Jun 2020 03:28:00 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id n24sm14806270pjt.47.2020.06.08.03.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 03:28:00 -0700 (PDT)
Date:   Mon, 8 Jun 2020 15:57:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        mka@chromium.org, nm@ti.com, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 0/5] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Message-ID: <20200608102758.54vdswjievx3cc7l@vireshk-i7>
References: <20200605213332.609-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605213332.609-1-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-20, 03:03, Sibi Sankar wrote:
> This patch series aims to extend cpu based scaling support to L3/DDR on
> SDM845 and SC7180 SoCs.
> 
> Patches [1-2] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
> Patches [3-5] - Update bw levels based on cpu frequency change
> 
> Based on Viresh's opp-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=opp/linux-next
> 
> V6:
>  * Add global flag to distinguish between voltage update and opp add.
>    Use the same flag before trying to scale ddr/l3 bw [Viresh]
>  * Use dev_pm_opp_find_freq_ceil to grab all opps [Viresh] 
>  * Move dev_pm_opp_of_find_icc_paths into probe [Viresh]

Picked for 5.9, will push to my branch after rc1 is out.

-- 
viresh
