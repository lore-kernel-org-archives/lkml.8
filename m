Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03F4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C649A2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGMdhR+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgIARGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgIARFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:05:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60878C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:05:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so1145113pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B7oiHWaXK5gHfmhnB8vkdM5EgHYpD4CD1tmZh3/WSwY=;
        b=GGMdhR+rBEO/tSiqGxTejDVPW9ILsYjv0inAaOCyjrdSvZucIdsLpikJW1/3A4lGF2
         P5vfHGsN8IzLPv9emV53iAdi6T6szf+cJKNqsXZHMd634yFckut1cE82ER9Rll4ZBfXN
         RcVabtYMDBqZ5RGrq9TC5K5maURSucr3mr5SL8np6e7DmErcjDI5eJP8nCOk7K2zkD3W
         nRCH4/76wVJuMmfin7Tr9TlqkNZJCZgAlIwfJrIZyQbq7LibFYjxAtrX8kW6FY3mVA56
         yCM9uoIv//nbY2Gxc0wL0hu0Zw4/bT+Wjj3k2WD4CyY+N5EHduf2d56+E5FAea+yBaSq
         1KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B7oiHWaXK5gHfmhnB8vkdM5EgHYpD4CD1tmZh3/WSwY=;
        b=Wmgg+tqUzNCH5Sa5qQIrTWVXyGZzTKSP0D6rW4p0FZLLl59yI2Vpb1IkRNksHIcnSG
         z6f+P6H06/zCl7Sjb+LT/2s7HyiXi9jCjGAPSEa2mLaD0Uk7WQeHhkQh6uwaOSOIgnKI
         li2k9IEcFo/a8OKSUAaJw7eRhL24p5b5OOebQLdXh1zeIDELYkjifXQB5HCqpSreEV+e
         toJ3vUs7/vAblYeM8he14dPXmLceSV3WjNq1uTOYNSMIi+WaBGSkC7URzWTNya9Wv0yB
         7h+U1wjS2JiLHBWJ4i34sZhPoGYrwnOnSyBfo4VyuzXIL3FvD5gulo92SrzIR9Ra1SK4
         pLLA==
X-Gm-Message-State: AOAM531s9rVQZJaWTRJHJVJwYpRjAcX9/fOAzRiPlIcOJVZTRhiEQUt2
        yfroV3o2/WgYftIyLN0gYU29Jg==
X-Google-Smtp-Source: ABdhPJwjYKFWgFUlv1XxLf6dgTYcmUO5Ej6yBP6by63YisyJ4R2/ST1UnmmFaAIg6LIFJvqB1BoxZw==
X-Received: by 2002:aa7:9ecc:: with SMTP id r12mr2716361pfq.285.1598979951764;
        Tue, 01 Sep 2020 10:05:51 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z126sm2691059pfc.94.2020.09.01.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 10:05:51 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:05:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200901170549.GA236120@xps15>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
 <20200901063740.GB13784@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901063740.GB13784@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:37:40PM +0800, Tingwei Zhang wrote:
> Hi Mathieu,
> 
> May I know your comments for this patch set?

I do not maintain any of these files.

> 
> Thanks,
> Tingwei
> 
> On Thu, Aug 13, 2020 at 09:45:46AM +0800, Tingwei Zhang wrote:
> > Ftrace has ability to export trace packets to other destination.
> > Currently, only function trace can be exported. This series extends the
> > support to event trace and trace_maker. STM is one possible destination to
> > export ftrace. Use separate channel for each CPU to avoid mixing up
> > packets
> > from different CPUs together.
> > 
> > Change from v2:
> > Change flag definition to BIT(). (Steven)
> > Add comment in stm_ftrace_write() to clarify it's safe to use 
> > smp_processor_id() here since preempt is disabled. (Steven) 
> > 
> > Change from v1:
> > All changes are suggested by Steven Rostedt.
> > User separate flag to control function trace, event trace and trace mark.
> > Allocate channels according to num_possible_cpu() dynamically.
> > Move ftrace_exports routines up so all ftrace can use them.
> > 
> > Tingwei Zhang (6):
> >   stm class: ftrace: change dependency to TRACING
> >   tracing: add flag to control different traces
> >   tracing: add trace_export support for event trace
> >   tracing: add trace_export support for trace_marker
> >   stm class: ftrace: enable supported trace export flag
> >   stm class: ftrace: use different channel accroding to CPU
> > 
> >  drivers/hwtracing/stm/Kconfig  |   2 +-
> >  drivers/hwtracing/stm/ftrace.c |   7 +-
> >  include/linux/trace.h          |   7 +
> >  kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
> >  4 files changed, 159 insertions(+), 127 deletions(-)
> > 
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
