Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B0D205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXeDKxhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgHSCYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgHSCYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:24:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC4C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 19:24:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so186214pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+YB8c/32gnBqWGnSfQI+bCq0DgA/loOsHUu6NV2HL7s=;
        b=DXeDKxhx8zQHi8DW+Bmibs0iBMRCuXLOa1h+F6KnKHjq8nBlYdV2DuJ9is0IM1lqM4
         zTcZ7kKdl1OldWmb0IUelvHf8ByE99NORuR9icO23tcU6Apzw+wMh5vRaymAZ7FsV6VH
         PBrBospTSExcJIPuCqVRQot6c/iaSxdilAPFp0iYOMpmMMlL3HQUtrTVilIEtl/tHkoJ
         6UEpaZARV5nZDar4sFxlOieXNjrXGGIKyd/gN7LjymDaRkO/y/GT0Ix2yPhslTz/WT3a
         r/sgiG4l1sbE6tw3lA4anqE93cbm3as6646jYQwexNAre7svON3LIgH+I5S/bjo+9EwX
         /ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+YB8c/32gnBqWGnSfQI+bCq0DgA/loOsHUu6NV2HL7s=;
        b=BvZk6iGFvBUctVS5TGGzSlZp5hXaYdzia9oyx+mQtFpoWoAx6PqkjPnBvxpM/RB8Zf
         v8YxzndB+E7/9qrzYEoWJyAUykoRGcF9hJC/YZRDNiglP1WyyKfDg7rqGuH/e1Lg1jc5
         kRPvwylQI4ocZ+80r8+pfAMZxKLBkSKVFYbEBiaQClL9Cqbspj1F3OrmS0dbkc6xb9Fk
         hnuF+B6ieWdvPOtg5P1SEDJHpYdMxRva+dxoYY26JyTruef7IyCFbO40hN9i/WS3zEGr
         SZeTcFxibvw91rY5w5x1G0JoY3OxT46tUqViUvrNNMUh/BVy0M9+KvN5m07nMy1hIT+t
         UnaA==
X-Gm-Message-State: AOAM532jMI/tA436mDQIiF7UwJKCKULaj2HGlz1J5wjtzpxh5nn4z7xi
        I5qjCHNVltocqfBo4FPxAneG7A==
X-Google-Smtp-Source: ABdhPJz03ylGVmeoObCriMjY7SQr5y40aHxlznfGFDFaNqt9LeADIsF/OIanpIY6zcYR5GK9eQ2ZGg==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr2403570pjt.172.1597803849135;
        Tue, 18 Aug 2020 19:24:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id q11sm26153519pfn.170.2020.08.18.19.24.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Aug 2020 19:24:08 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:24:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>, acme@kernel.org,
        will@kernel.org, linux-kernel@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for CoreSight and Arm SPE
Message-ID: <20200819022402.GB9556@leoy-ThinkPad-X240s>
References: <20200817193140.3659956-1-mathieu.poirier@linaro.org>
 <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 06:54:28PM +0100, John Garry wrote:
> On 17/08/2020 20:31, Mathieu Poirier wrote:
> > Add entries for perf tools elements related to the support of
> > Arm CoreSight and Arm SPE.
> 
> Thanks for doing this...
> 
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   MAINTAINERS | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4e2698cc7e23..f9bb76baeec9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13427,8 +13427,18 @@ F:	tools/perf/
> >   PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> >   R:	John Garry <john.garry@huawei.com>
> >   R:	Will Deacon <will@kernel.org>
> > +R:	Mathieu Poirier <mathieu.poirier@linaro.org>
> > +R:	Leo Yan <leo.yan@linaro.org>
> >   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >   S:	Supported
> > +F:	tools/build/feature/test-libopencsd.c
> > +F:	tools/perf/arch/arm/util/auxtrace.c
> > +F:	tools/perf/arch/arm/util/cs-etm.*
> > +F:	tools/perf/arch/arm/util/pmu.c
> > +F:	tools/perf/arch/arm64/util/arm-spe.c
> > +F:	tools/perf/util/arm-spe.h
> > +F:	tools/perf/util/cs-etm-decoder/*
> > +F:	tools/perf/util/cs-etm.*
> 
> But from the previous discussion, I thought that we wanted an entry to cover
> all tools/perf/arch/arm64/ and other related folders. Or was it just put all
> special interest parts (like SPE support) under one entry and leave the
> other arm/arm64 parts to be caught by "PERFORMANCE EVENTS SUBSYSTEM" entry?

Yes, I think we need to add below two items for Arm SPE:

F:	tools/perf/util/arm-spe-decoder/*
F:	tools/perf/util/arm-spe.*

Thanks,
Leo

> >   F:	tools/perf/pmu-events/arch/arm64/
> >   PERSONALITY HANDLING
> > 
> 
