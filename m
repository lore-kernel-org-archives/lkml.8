Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB66C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF582065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4tMopG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgGOHJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbgGOHJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:09:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED99C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:09:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so2638990pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3/+/JizBB9UQLJfhtqguGOljzJveaCcNdmGC7ffhA2o=;
        b=a4tMopG+oXnDuDX+F1azBv1ggm+c1KoU9xitqNX6wtNaqyMC/O7/O5g3usYzPvR8oP
         WFPScCAnrDgo7HL+weSnzF97a+oLajDLj/F3cghrcTbPdbjQbTY94cH0AtDieRUfUJ/u
         gw4ziMVx25R+rDrK6C4KaRcZwiO2wjfgp1eBBOQCCbvJbl7V5DwjXdjjgpHh6LPwSQxI
         4oA1tfpZ6Ptti9af1Z/kWo1NiHxdsYR8OJr36y4Y/GrCg56pQ/ADJCLBpdHcLEVMF1MJ
         9EUBwVU5wreWUAjTQWOl1ZbF+lMjj+cl4X8VSngSDFew0EUHnJddNp88gxbwXgLUY5Ui
         BVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3/+/JizBB9UQLJfhtqguGOljzJveaCcNdmGC7ffhA2o=;
        b=TsM7A9Qs3uaahnkLlMQkwh5IsKdt72hsuMbuXTrqgI7iU43sB9uyiZuJHwRVRrBap/
         n5C/B724QYRd0XLCic0dNlangW9AqBy6Kd3sBcCua9OVRSsflS449ZzjeCAu5auB8bF/
         Osv0AurJuq3icnntWHvujpuoYZXJhpyjgSpua8aopo/W6Pho7b63R1UfYdq+byZjf7bb
         VlJCr2XlBMkX3jN6V8b7xiuQazefxbQivb37Lr0jG83l+tzfweJN3yLd99dPjaqPS0uY
         i4sEJibi1b7f6k3jux+/7+7esjDmOD1LjcGGISat8az+BugbewoArWpp4lCTccQ+2myf
         PUgw==
X-Gm-Message-State: AOAM531HRs9pLbOZRk/YTAdmQAkk8ScvuxZVPIBqPR1l1oY0FSJkSB5s
        iGGXtZWI36rkzOaRCVE6VmHMpQ==
X-Google-Smtp-Source: ABdhPJxHdbacRbRq1btUZ46xKsE1jmPTXxacVtnB3TaMKFvudSxtfQe5zuPohnqNN8b5slN2XxnrBg==
X-Received: by 2002:a63:7a57:: with SMTP id j23mr6790300pgn.408.1594796982392;
        Wed, 15 Jul 2020 00:09:42 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id b13sm1092458pjl.7.2020.07.15.00.09.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 00:09:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:39:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dominik Brodowski <linux@brodo.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH 02/13] cpufreq: cpufreq: Demote lots of function headers
 unworthy of kerneldoc status
Message-ID: <20200715070938.d2rtkvsk7n4sla3h@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-3-lee.jones@linaro.org>
 <20200715024951.zr36iuagany5ii56@vireshk-i7>
 <20200715064716.GT1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715064716.GT1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 07:47, Lee Jones wrote:
> On Wed, 15 Jul 2020, Viresh Kumar wrote:
> 
> > On 14-07-20, 15:50, Lee Jones wrote:
> > > -/**
> > > +/*
> > >   * cpufreq_remove_dev - remove a CPU device
> > 
> > Because cpufreq_add_dev() is part of kernel doc, we better keep it.
> > 
> > >   *
> > >   * Removes the cpufreq interface for a CPU device.
> > > @@ -2373,6 +2374,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
> > >   * cpufreq_get_policy - get the current cpufreq_policy
> > >   * @policy: struct cpufreq_policy into which the current cpufreq_policy
> > >   *	is written
> > > + * @cpu: CPU to find the policy for
> > >   *
> > >   * Reads the current cpufreq policy.
> > >   */
> > > @@ -2759,7 +2761,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_register_driver);
> > >  
> > > -/**
> > > +/*
> > >   * cpufreq_unregister_driver - unregister the current CPUFreq driver
> > 
> > And this should be there for sure.
> 
> Where is the *.rst file that references this kerneldoc entry?
> 
> Also, what do you mean by "there"?  We're not removing the function
> header.  It's still documented, it's just not kerneldoc.

Yeah, I meant from kernel-doc by "there".

Lets conclude the discussion on the other patch for what should be in
kernel-doc.

> > >   *
> > >   * Unregister the current CPUFreq driver. Only call this if you have
> > 
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
viresh
