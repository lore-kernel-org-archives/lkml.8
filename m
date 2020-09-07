Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CAFC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FA120768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHpXhgWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgIGKrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgIGKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:46:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A159FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:46:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m15so3206358pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHqP26qj43N4RBV6m+y6Vmj2dP7/Hi68DySAIyks+G0=;
        b=NHpXhgWjWGlByubbaTjCKAj60noin3QEkegdu4B4US8ebMNrw5KB0h6P2myNVcYlXW
         5K8hC+akao3PBsFCY82wWI9h+yNknJBkrh2Va4qOxA+9IRP9l+wAewfVV2Ryg6ohYmPw
         GPSuhoR+tHBKGNdglwj09UP4Fi8MKyAPWmVIzYyM819jxLIoRqYG7R1jRVlGhazmSR1D
         QmfXDEbCc/TIJSiHkuW09Vp79T5E2b8pB4mryYU8yhNC5kdeAXSkbhZ8CW+AXbGIoUuj
         +kJexsgZLvvdcRdXrWEVUZKN4jtF+buYwOxJaeVhVUk0NnkjMcYLaptUJ9sjQhLEg9Xd
         yFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHqP26qj43N4RBV6m+y6Vmj2dP7/Hi68DySAIyks+G0=;
        b=AzqO15sNjLsI70HQyTfIKi6yCS/iaf5WirBno0bpaMutLMOc20dK619/UPVvvtfAaB
         xMvhaAvjOCw+f8VCMnxpOUSuwujJrzOtITy3n2d4fj5MpvVm5pFygk9EuDITtbLoKQca
         uPSI1XeZazfp6rzr18uP/ZcSsR01boxxZGQlHIjur5iWAsN0/9I+8K27IbwxO78btPGT
         SldSAlHqD72tOZ/iyy721VXIE+xdcnUK1G3lXcG/J7C0I94o0va8+qXBMRV5vE6wLHuM
         txRvxs9DP+PU87jRRTgtA9xN8tiLFl/fJdLrquFVTiVG4qBqrgQZzvM1yInLyc61nIyq
         PBJg==
X-Gm-Message-State: AOAM533Z92+ihI3H/SIOF/JlLFqeeo32gyeWejesphP8IuNqqzFyE/HU
        WQ5nXI+khklGDV3Tlb37vkRnIg==
X-Google-Smtp-Source: ABdhPJyvOthwoEeoNO/6CVTJe8x8r1dDxqw7Y0ZYDMK+h6BeTNL7+ljl/PHbcwvP8sKPe/khV3LSmQ==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr19588449pjv.108.1599475617167;
        Mon, 07 Sep 2020 03:46:57 -0700 (PDT)
Received: from localhost ([122.181.47.55])
        by smtp.gmail.com with ESMTPSA id h35sm2261938pgl.31.2020.09.07.03.46.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 03:46:56 -0700 (PDT)
Date:   Mon, 7 Sep 2020 16:16:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
Message-ID: <20200907104649.rra566kfygqdr24x@vireshk-i7>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
 <20200906230452.33410-2-rikard.falkeborn@gmail.com>
 <20200907102200.GB17330@bogus>
 <20200907102551.3f7zwrmd3uqthaxs@vireshk-i7>
 <20200907104418.GC17330@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907104418.GC17330@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-20, 11:44, Sudeep Holla wrote:
> On Mon, Sep 07, 2020 at 03:55:51PM +0530, Viresh Kumar wrote:
> > On 07-09-20, 11:22, Sudeep Holla wrote:
> > > Hi Viresh,
> > >
> > > On Mon, Sep 07, 2020 at 01:04:50AM +0200, Rikard Falkeborn wrote:
> > > > The perf_ops are not modified through this pointer. Make them const to
> > > > indicate that. This is in preparation to make the scmi-ops pointers in
> > > > scmi_handle const.
> > > >
> > >
> > > Your ack needed to take this as series via {arm-,}soc
> >
> > Can I just pick the first patch and you do the rest ? Will it result
> > in any warnings at either end ?
> >
> 
> Initially I thought out suggesting the same, but then I realised(not
> checked though), without this change in arm-soc the scmi-cpufreq driver
> might produce warnings as the const value gets assigned to non const.
> No ?

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
