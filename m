Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C49C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FB7206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5H/s/s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHaLZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgHaLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:23:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54CC0619CE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:14:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so2851251plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nzvu9JSHr7RK/LFEk+l7520aORfzy7sOwYYyoim9rCI=;
        b=r5H/s/s7DpXIflWMEZE0METpZNKTTtMqR482C8ot3WSiqkfTqGf12SQ1Fmb11YWCNN
         Hb+z7P+aWkkrBMme+lps94SiFkupZib9Y1PKOWSChOSPbWegOm1Npn65lZyxxgpUP5ll
         DU9i3gIFliaBeoCxCpHzl8rM5qotA4dX2erVDpK7lWkcezAb6o0GK31t4Gp9+gH8kMrI
         k0qoVFUcFInyQ1cjuiaw/Ipekr2njnpgXkW+qzPMN5ibsmOMRJZ+X6ltcpoFRiMvfnQa
         zcfRiayeD2WP8pQ5mTGaDjJGqNRKpym0PbTJ7S8E6RyVVwVKO2bNIGd45NCSSDIltL3N
         x5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nzvu9JSHr7RK/LFEk+l7520aORfzy7sOwYYyoim9rCI=;
        b=AAKLB3H4l3ijE3qCxvhYxzXNqYBSqVJMc3eR8c8i8AYfRKYSEKLzvfRW1vD5onuhTd
         r38iYVAyU9lKcjCfa9eOXIOr1MVtqt7LhMTLwopPQrm99n6Tt2iR9NUK1lDlzIXDXnml
         MaDqqGLa84p286Iggzg4wNjBjemngExP+6427sbSXf+6kh0sMS5MKpVWj0xKk/0Tla1g
         6tQ9oso5u4nUjlmD1ERbq3fWp/tSRvXAjYHTi9sGnBf5DBe1fhf8bZB0LkBfg2CJ5Vd7
         DkVmsIVegIhk8ZMKckbkRQ6+ZbBzgMUfjJTWmK1IjpwC3GKkdiv7y/Kb9yKZ6SCnReC/
         wNpw==
X-Gm-Message-State: AOAM531uJMN5263n8OyM/j6T8i+d/qpgFvMBrhTMJbbu6VUog6ISQ4Rc
        ttw+qf3GBtXyZezMwWcxwobWLA==
X-Google-Smtp-Source: ABdhPJyDeeogBk0lluDOhsC09yle3T1/VPEb4FU+vPpigkNdXZMXQ6VkP/LotNnjrlzNiG8DXywloA==
X-Received: by 2002:a17:90a:5609:: with SMTP id r9mr939358pjf.194.1598872450748;
        Mon, 31 Aug 2020 04:14:10 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id e13sm3819332pfl.44.2020.08.31.04.14.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:14:09 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:44:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200831111408.a2q22cqaxjkbmw6v@vireshk-i7>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
 <20200828173303.11939-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828173303.11939-4-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 18:33, Ionela Voinescu wrote:
> Now that the update of the FI scale factor is done in cpufreq core for
> selected functions - target(), target_index() and fast_switch(),
> we can provide feedback to the task scheduler and architecture code
> on whether cpufreq supports FI.
> 
> For this purpose provide an external function to expose whether the
> cpufreq drivers support FI, by using a static key.
> 
> The logic behind the enablement of cpufreq-based invariance is as
> follows:
>  - cpufreq-based invariance is disabled by default
>  - cpufreq-based invariance is enabled if any of the callbacks
>    above is implemented while the unsupported setpolicy() is not
> 
> The cpufreq_supports_freq_invariance() function only returns whether
> cpufreq is instrumented with the arch_set_freq_scale() calls that
> result in support for frequency invariance. Due to the lack of knowledge
> on whether the implementation of arch_set_freq_scale() actually results
> in the setting of a scale factor based on cpufreq information, it is up
> to the architecture code to ensure the setting and provision of the
> scale factor to the scheduler.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++++++
>  include/linux/cpufreq.h   |  5 +++++
>  2 files changed, 21 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
