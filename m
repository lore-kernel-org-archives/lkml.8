Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A039C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354602073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5CwCT72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgHaIoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgHaIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:44:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0ECC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:44:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j11so2687455plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DRJYDAyveACX46Lr396yykK8uV/AaFMfwoz36CHmrS4=;
        b=C5CwCT72qPzLfBzqemlPScZPWg98V0m6dm1i3SJVyBV2B44dIqewYO2bBFZ82CtQV7
         LCziMiasTjzxSSG5/0w7337Dvkb9t+KWXcb1rdRTIisbpQhYE2eVQWN1DNjqy5MlPMpE
         a0dcXss6UpG1QvNUQk+qT0mbFTKigcuA4z0r8ftiOgPtSrOyMI7ksp6GYs+NmqFwlTMj
         tW8muvYk5/Tgi1tl0ljEU0eFM+kz2U/NB87Ybzh76zNVB0GSgXglDGxrJB/KIwtTDtqU
         u91l8vdCPoXy5fnuX9J2s0wTs4IC5KWSgqqYEWq31a/qNvsBAgTQbdUA8jNkhBs3RqAK
         EVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DRJYDAyveACX46Lr396yykK8uV/AaFMfwoz36CHmrS4=;
        b=WlzsL/aMeS16cuo0CWkgd6rU5G9TmbY9wVkJCs0uqz158EFuCkd5t71lFVKE6t9lSS
         syGu05XuhyIh13T7F7GIIx6KxybKqgU4E8jgRLIpUO+M9dynprMKDlS0TKcDnCvjZfOU
         +ibKGcLCN2BHjY8On7P1c94h70kpNgjCyOFzUqeij0CNkBWXrlQcbyfzK8InVm0IcHrO
         vF65Whaaun4TM1Bo82nYNuCVRD2VZYncjCN5Md+me0pMS1x336tan9ayF1EVJuh0BvJx
         aKCSYGDQ742kYEK+1sLBz7Fcp3CTDR7aY4aikd0uXTTYf7k5ji1arU8ToRq2pOKEJJ6O
         fhzQ==
X-Gm-Message-State: AOAM532BJOA653YXD+S/KdZfKR2BVbYgBIeH8bMyX2Nn/dkuEtJXnCmX
        X1l+TNHBuPIr0AysFAU47Rznig==
X-Google-Smtp-Source: ABdhPJyOOR4bbqMjSPPbjsyBe0p+IjO4CvEXT8z5BLWVAnT19nhB5HGRmi0FINZ3syRLYb9mSdpMkQ==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr292473plk.209.1598863483604;
        Mon, 31 Aug 2020 01:44:43 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id o30sm6895855pgc.45.2020.08.31.01.44.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 01:44:43 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:14:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     rjw@rjwysocki.net, lgirdwood@gmail.com, broonie@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: dt: delay the clk/regulator check
Message-ID: <20200831084441.uvw4jx4cbfh5y3e6@vireshk-i7>
References: <20200831084858.2398-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831084858.2398-1-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 16:48, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> cpufreq_init could be used to do check clk/regulator check,
> there is no need to duplicate the work in resources_available.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Hi can you please see if this happens on linux-next as well ? The
routine resources_available() isn't there anymore.

-- 
viresh
