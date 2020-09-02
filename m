Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1BC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D994E2068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeJietJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIBCMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBCML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:12:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23D1C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 19:12:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j11so1524804plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 19:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIQg3hGOGZDEbnEgKN9rno53rGgVoGKdA4lvwe81pyI=;
        b=JeJietJoUP+3hUqO2AK3vMds6kzEX3khbyD1sYrdfdXcnTJ6Y0jLM8Yg5NuhrQU4el
         9uFxo1HcHpJOTJaQMmKHHhkrXXd72QHxz2LC64tIf0RAze1oIWyusImdHWohckMFaZpJ
         /nD9VQ1aNOibQA/8NX/nQ788eEtGTgMen3zCE7QL612ft+8xV2D4bh3JgEZ+qW2V89kK
         RMy4gQ/LKNB/ge86yYSRbJalUVo9r4hJPHJczLVZI1dSxgRkHwduC0FbmEvTIRgAM1H0
         2o7oinr7RsgHj1M9KbQj0XGJAzAarVpP4GEMSZzv4irq3QCiaSxelVBGDkvvAdI4FAn9
         jpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIQg3hGOGZDEbnEgKN9rno53rGgVoGKdA4lvwe81pyI=;
        b=X3f5Ve/zuacAaVBo9JOE4oxlykoncwdfYKQw27IvSi6bIrEnnUC5MXYLYz5kivkHMd
         HpsvULEy4GT/obdrJyebCfQ2SsFlK8czKjxh2YOUrXPtsc2Lm1nkFMZMO0cybtd+c3C4
         m5O0VhBREBUO8nDpEzHWyAZLyhm2J9NMvxROmiS/29A2ppiNZhnfk14qWxZ2chOXBWyx
         3hyKTs5fOJAxeLFd9CmxzgotGYfugsuMk5UB43LHQdgn6mbbkQCuEbZ22YXfknes8xcW
         IN92EKKbT39faUjWzdS3uxiDHH5oRkiKoASWyWzGl51WWjG6KgP4csNPbUmoi9aUFxBv
         tsDg==
X-Gm-Message-State: AOAM531OGrEfC4jMKZN8mYauRziZr+KjoPKi9fGTqQtT5WIWA/5kN/IR
        57l10RCY3UAfLqx3JS0VZY7QFQ==
X-Google-Smtp-Source: ABdhPJyD4eKW2dczy1RzDAGyNeS7fnA2FQwwtccz6/0MCkJ+yYFTle6wtIkVqxaCPjxtGGBVx/Focg==
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr119988plr.226.1599012730862;
        Tue, 01 Sep 2020 19:12:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 143sm3408230pfc.66.2020.09.01.19.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 19:12:10 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:12:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Al Grant <al.grant@arm.com>
Subject: Re: [PATCH 1/2] perf cs-etm: Fix corrupt data after perf inject from
Message-ID: <20200902021203.GC3306@leoy-ThinkPad-X240s>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200827205354.GE22307@xps15>
 <20200831000432.GA4715@leoy-ThinkPad-X240s>
 <20200901145432.GB1422817@kernel.org>
 <20200902003931.GA3306@leoy-ThinkPad-X240s>
 <20200902014754.GA3444345@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902014754.GA3444345@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 10:47:54PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 02, 2020 at 08:39:32AM +0800, Leo Yan escreveu:
> > On Tue, Sep 01, 2020 at 11:54:32AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Aug 31, 2020 at 08:04:32AM +0800, Leo Yan escreveu:
> > > > On Thu, Aug 27, 2020 at 02:53:54PM -0600, Mathieu Poirier wrote:
> > > > > On Wed, Aug 19, 2020 at 04:47:50PM +0800, Leo Yan wrote:
> > > > > I've see this patch before...  I thought it had been merged - what happened?
> 
> > > > This patch before has been sent by Al to CoreSight mailing list but has
> > > > not sent to LKML, this is why I resent it to LKML in case it's missed.
> 
> > > So, was it Acked on the CoreSight mailing list? Are we missing any
> > > Acked-by or Reviewed-by for this 1/2 patch as we got for 2/2?
>  
> > The CoreSight mailing list has some discussion for this patch set,
> > when respin this patch set, I confirmed we don't miss any 'Acked' or
> > 'Reviewed' tags.
> 
> So, this patch was included in today's
> perf-tools-fixes-for-v5.9-2020-09-01 signed tag sent to Linus in a pull
> req, please update your perf/urgent branch, and go on from there, I'll
> merge that into my perf/core branch as soon as Linus merges it.

Thanks for the info!

Leo
