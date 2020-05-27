Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513D620776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYBybCvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgE0Dxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387487AbgE0Dxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:53:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FBEC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 20:53:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so9620204plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 20:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IYMd1AnUAPkMGM+mZJ4SXD6TMuAQaYu5keXEtUSwigU=;
        b=OYBybCvA4Wk60gJ0QRkPpb+8kKDOtMgLg5Msuhx1IAMH/EuJPHEk2+5QswUX2XkbTA
         uIpNhFkyGJYuBSY+mdFa7w4sPg95usp/ddDeC/CnTYEaGXfwJxVvbNMfWmKCxsKQ9vBc
         1hA0YB7FkWB+E9fKuxbpHcnilnJ9Nxu4RF9fiINeKd35PwKPeOG0Z3+ZB+ytOaSX5MfI
         88jDa/DMvYvA+X8ibB8/Szk5bJCCRBs0vqECD6/c9BaQfXmZdUkGbXVBWtcX0vmKaZrX
         8vPO+yp3unIffWr4l0TtD82PTyoZO+HZSA0bCgLxchBRcspuibBMv1bpSgjor49AL4sv
         cF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IYMd1AnUAPkMGM+mZJ4SXD6TMuAQaYu5keXEtUSwigU=;
        b=Jn1auz7/T6FTnMWYlZTg+N0YnDwv+8ekjdH4o+XafeXmhYUfrHbBWaekfat99icYr+
         wHaBer2onzhCCSAN9pSkXrXC05jp8lPzyhxKMLUe3ZL4JOFVKCp8P9Oep8/Gz/e/3GKU
         qcvv0pwdMALCkWssbgh62ruG+RWqMbijQxbgKNv2UnvEoshoRrFvwOxNCLgD9xxMMhUC
         MJMyVPkTgYvrJCmhP/HNwx7We7aJVe7v34XWrLwc0m+DzYBaCbP5PjCyWgSEJu5MGUE3
         gEmw8IFqrnRtrzrgKJdfel9hGG5M9SryYbJOVn5D0CnH1aOR8tnFRsbbNG+PHRHJ+Dcw
         1FOQ==
X-Gm-Message-State: AOAM5304PDC//4FP7cm/CeOnFPYuryYYPEEPbbsUy3KcCzCSIlbjSNAD
        q7jWE2w27cmyZ7P2Magp7RHLOw==
X-Google-Smtp-Source: ABdhPJzneh3TIZ4iWzcoexcyoNh9amW0JOGqNov81CSCdr8FsV5jm5LYXnkl+oudXPsIFda/4RQstQ==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr2842638pjz.206.1590551633445;
        Tue, 26 May 2020 20:53:53 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id w186sm819760pff.83.2020.05.26.20.53.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 20:53:51 -0700 (PDT)
Date:   Wed, 27 May 2020 09:23:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 06/12] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200527035349.mrvvxeg3lqv53jm2@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-7-sibis@codeaurora.org>
 <20200505045012.zfx2e6chqo5f3e4n@vireshk-i7>
 <8fc5b72c9af6fd6a707a280cfc678677@codeaurora.org>
 <b7e184b2da5b780a4e7e6ee47963f9b4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e184b2da5b780a4e7e6ee47963f9b4@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-20, 23:18, Sibi Sankar wrote:
> https://patchwork.kernel.org/cover/11548479/
> GPU driver uses Georgi's series
> for scaling and will need a way to
> remove the icc votes in the suspend
> path, (this looks like a pattern
> that might be used by other clients
> as well) I could probably update
> opp_set_bw to support removing bw
> when NULL opp is specified. Similarly
> opp_set_rate will need to support
> set bw to 0 when set_rate is passed
> 0 as target freq for the same use case.

Sure, please send a patch for that.

-- 
viresh
