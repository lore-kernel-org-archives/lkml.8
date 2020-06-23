Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703DFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E652070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDh1Fl94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgFWGUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbgFWGUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:20:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A71C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:20:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p11so913385pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xkEZLfW1ArYgf+mEiL+b5tURW9CFpN3REEce4uqJNH0=;
        b=mDh1Fl94b3/LSZ+hMlztNtRD33tkWnaxz8jVAg3XWYW8wZ8vRi1lGAMFXvmC+ld9oq
         yoj1BYpiF4qp/PUndN/UrCjFRgoxGIVbP7WdIa/Og1WXc5/3wG9C91iC1qcV50TlhZ6m
         XBllvcUyb3wDmPZK3Etsz833H3UWSiNLXTZlbHuC0a/stsEgjxQDg6gu5q309hEyTJNc
         VA6U6mtmGjjwP7IWZrxUg9ih8rRJMMh8IC5Jqvi9wNZq8UAohIxZndVvX0mI5xnYvPxJ
         EmHNG66dntMreD3T8r2oyjt9i/uD//9Mo0vhNQEblG0eGl2WJqHcpUUNoZqCbP92pq5k
         B5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xkEZLfW1ArYgf+mEiL+b5tURW9CFpN3REEce4uqJNH0=;
        b=TI3HjxyGwQRnOcpLXwb0v76Yl5EdzT4bko8Jncl/pF6i/loJaNq+PSyh8Mx9zInJSE
         ll6l20mcfNr9XGCF0ACpO1obBiPUAvLfRotoukFZrbk7pe5zT++9iEW8Fa/iN3MZNzw6
         ksGbd32SaoUVXn920rMUkWN3NyQ6X7Ue3/PrT78AYLH1feO+QlZobwKA35+6qWHgSIVV
         iOTC/OUqyLeM7FiOq2CtnsCcgX2ZmbQ9bEaFUZEY4KN7rd9QNBTRSEMkyesLdXgx2NVM
         4foDQR1qlcgoRiE9PCMlt4F1XgIRBP+03M6rFkM6Aibuz9gRdUF/U/xAVzaz0GGyrFNY
         DwZA==
X-Gm-Message-State: AOAM530lG96IDCzOheFDI2VAu1plPr6etoPZCa9Gy1eCKPA8tPJ2+T2F
        F6I6VvyaL2bcUTMclGUM8AHRBg==
X-Google-Smtp-Source: ABdhPJzPhO4piZUlhyX41kRvKT0EgrKEBSKMGlr2VTKP7RKfZOV4lMU0w2m7uDvwx/uYcjh4UjbI6g==
X-Received: by 2002:a63:3f42:: with SMTP id m63mr16314448pga.310.1592893223436;
        Mon, 22 Jun 2020 23:20:23 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id np5sm1408030pjb.43.2020.06.22.23.20.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:20:22 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:50:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch v3 3/4] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200623062020.weg6h4uygelkih7d@vireshk-i7>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
 <1592775274-27513-4-git-send-email-sumitg@nvidia.com>
 <20200622072052.uryxo4hri6gzrkku@vireshk-i7>
 <ed6956a3-3f77-2943-6387-5affc25b59d2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6956a3-3f77-2943-6387-5affc25b59d2@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-20, 10:49, Sumit Gupta wrote:
> Hi Viresh,
> 
> Thank you for the review. please find my reply inline.
> 
> 
> > > +++ b/drivers/cpufreq/tegra194-cpufreq.c
> > > @@ -0,0 +1,403 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved
> > 
> >                      2020

You missed this ?

> T194 supports four CPU clusters, each with two cores. Each CPU cluster is
> capable of running at a specific frequency sourced by respective NAFLL to
> provide cluster specific clocks. Individual cores within a cluster write
> freq in per core register. Cluster h/w forwards the max(core0, core1)
> request to per cluster NAFLL.

Okay, this is clear now. Add a comment about this max thing in the
target routine to show why you need to do this on all CPUs.

-- 
viresh
