Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09315C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B678D21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnkJu0Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgIGK0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbgIGK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:26:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72665C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:26:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j34so2449807pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oSDBtC5AJCfIOMajLqA8j1SX26YNoE5DFwKupiwQ2NI=;
        b=gnkJu0UcBjhgouUkegI3C32hZTFy1qSXPPXOg7qF/cZYnsXOKDFGWdXVNsuDqQnAIW
         Zun4aUVK/qN/RC6xcVu0q4qg+Dg28n/5UAE4L8JewkG4yi1zH1q1UoWTG5q5dkh6jo1a
         +ISBNIAwT9QwMjHKz4f9cJa2ezCfpCMrhMmFHDn6rSr45OUFpe2hxVdcUlLPI0ED6/E4
         a+eCJZXL/bsn8Elv1VAtE4vY4tNPvdXA70r5GLN/j2FN6PBPYTfBV+OIeyHthlU45eu2
         ofmJSp/aDYVQx54K74W83M1PARxUJolksXiaKJHKI/Gj4mNIU9kLFcWe4QyRtgnmViOu
         VgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSDBtC5AJCfIOMajLqA8j1SX26YNoE5DFwKupiwQ2NI=;
        b=jGLS6rEz67ONhIrlbal+y8j4DOYtQ93XYhWx98U0vb8XkDn1bHSJySJc3tktENiZI9
         m57yrmF7UFn/rHk0H23MHETJdFd5eHAtpAlEruIAhc8gUh9/fXbpEfUv9fDTfhkbfzeH
         c8voNeGmEccdfaEXdoym2NU1cbFYZlimY5JcXikdqUjZ9TyxQi+OozakgTbvpEriHnSj
         +xq0TwwErGYmtEVdNnMXXcBMo68I+6R9bTjJ/HiCOux+wnrBOiuZl5yT+ScW3hRUvNKm
         sWLFv37IxO+VRKSvrMhJcf2bxnD8vLuQ92jTtAT5y4i9vplJja6DxL92Hw/fvC8bBqA2
         KJig==
X-Gm-Message-State: AOAM533u73sgoZgAC9odeCWY8CCazrI793YoEvHbCfPMr7GqpV3LeINl
        OGks9H6XxhwM3NdHq02FfCG3UA==
X-Google-Smtp-Source: ABdhPJxHQ/nrbmLTBJWGaFKaptxZ0KxHHZ3OMmGwTfyrCmgVoG2obssalbLYCtejCEH510sDIrsJgA==
X-Received: by 2002:a63:d216:: with SMTP id a22mr6640147pgg.339.1599474359206;
        Mon, 07 Sep 2020 03:25:59 -0700 (PDT)
Received: from localhost ([122.181.47.55])
        by smtp.gmail.com with ESMTPSA id g192sm7189734pfb.168.2020.09.07.03.25.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 03:25:58 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:55:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
Message-ID: <20200907102551.3f7zwrmd3uqthaxs@vireshk-i7>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
 <20200906230452.33410-2-rikard.falkeborn@gmail.com>
 <20200907102200.GB17330@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907102200.GB17330@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-20, 11:22, Sudeep Holla wrote:
> Hi Viresh,
> 
> On Mon, Sep 07, 2020 at 01:04:50AM +0200, Rikard Falkeborn wrote:
> > The perf_ops are not modified through this pointer. Make them const to
> > indicate that. This is in preparation to make the scmi-ops pointers in
> > scmi_handle const.
> >
> 
> Your ack needed to take this as series via {arm-,}soc

Can I just pick the first patch and you do the rest ? Will it result
in any warnings at either end ?

-- 
viresh
