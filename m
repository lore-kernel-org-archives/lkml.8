Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C84C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4048621775
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWrhuTXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMByW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHMByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:54:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC3C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 18:54:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l60so2023003pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 18:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XJxAcsayNwVZ1ZF6jxEL74eDCukOtb0Cu+vfSV+/MuM=;
        b=VWrhuTXd6+wON73NhujkBaNnz02CeJtOywZUIU9gL9QN35zmLvtwpUy4RupzLG76id
         shcnBWN+qzYvrJDQ3QqtPVK6lTBvRCahlGiZoI10bgMeDDv1RJ9FKmty/ZQ9EbcfS5mM
         tfU7QulP66OlmeZwtTf4fuhMvorEQVbTARkGyzKIbdYPCQjR8XNnBEsebeX89gf1tGbF
         2o69N68EUEQkDcWjTwtVm2OJxCDIWICyYw7OkbaB8GlETrklYZQOTGaabOeE9yDfmNJF
         ElGAFYcY9f4n3Nc2eX0AS5DXrf6HvscRwdx7wkrJgHYctQ7Lg3cGKehwjvPX18Zvz9xy
         XuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJxAcsayNwVZ1ZF6jxEL74eDCukOtb0Cu+vfSV+/MuM=;
        b=kEF5xaH20wta4wd+lPLLhjNpT9cTgEBfTVbk38Qgp8oRDSzO5RLPRvMomSBF0N0HXO
         L5VZ5cpmNVDi03kNUHfMe+jsUpw2iqwqJp777qmy6VxO80KR/LLpP8OfrcrYhSK/HNFR
         A3GzvMqgQkWap4eUGhJkRxzK2DQipgmNzmUXJilwgDBSRL5KNtnnzptsHUYS/h3WUTBg
         +5HwHAFCgDmyuZ0Ro0J9V4TBqJX6/PvTaHZVHZqAhfB+nwjng+rCGsEiEzitW1CVuBWi
         ghT7eH7aqCw6wg/zYnL6nyyQpOtbe67JGEkmVldmI/pCW1+1V/UYB8G2QNGUJ2XHSg73
         XF3w==
X-Gm-Message-State: AOAM530Rlmo9v+t7Beq90ruuSfPiSxDX/SKhUbuwAManONLoUPSFI2eA
        cVgEXU3rv+TM1ye1I90HEv/6Dw==
X-Google-Smtp-Source: ABdhPJxtebOhscBGY7nQqeEEGN2iMMIiIasJHsU11jL+2i5FXTPCFT7EaAVkpveM4qHBq3lfWNelug==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2mr1885025pls.226.1597283659267;
        Wed, 12 Aug 2020 18:54:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a16sm3860095pfr.45.2020.08.12.18.54.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 18:54:18 -0700 (PDT)
Date:   Thu, 13 Aug 2020 09:54:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
Message-ID: <20200813015410.GA8597@leoy-ThinkPad-X240s>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
 <20200812185334.GN13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812185334.GN13995@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 03:53:34PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 12, 2020 at 10:06:53AM -0600, Mathieu Poirier escreveu:
> > Hi Arnaldo,
> > 
> > On Fri, 7 Aug 2020 at 01:16, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > This patch set is to enable Arm arch timer counter and Arm SPE is the
> > > first customer to use arch timer counter for its timestamp.
> > >
> > > Patches 01 ~ 03 enables Arm arch timer counter in Perf tool; patch 01 is
> > > to retrieve arch timer's parameters from mmaped page; patch 02 provides
> > > APIs for the conversion between arch timer's counter and time; patch 03
> > > adds a test for patches 01 and 02.
> > >
> > > As the first customer to use Arm arch timer counter in perf tool, patch
> > > 04 is to generate sample's timestamp for ARM SPE AUX trace data.
> > >
> > > This patch set has been rebased on perf/core branch with the latest
> > > commit c4735d990268 ("perf evsel: Don't set
> > > sample_regs_intr/sample_regs_user for dummy event").
> > 
> > The ARM SPE perf tools code is orphan and I don't have the cycles to
> > pick it up.  Leo has spent a lot of time in that code and as such I
> > suggest that he starts maintaining it, probably following the same
> > kind of arrangement you and I have for coresight.
> 
> Thats ok with me, I think we should reflect that on the MAINTAINERS
> file, right?

Very appreciate for the promoting, Mathieu and Arnaldo.

> We have this already:
> 
> PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> R:      John Garry <john.garry@huawei.com>
> R:      Will Deacon <will@kernel.org>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Supported
> F:      tools/perf/pmu-events/arch/arm64/
> 
> I think we should have entries for CoreSight and ARM SPE, one listing
> you as the maintainer and the other listing Leo, right?
> 
> Leo, it would be good for you to try and find someone at your
> organization or elsewhere that could help with this, this way I would
> wait a bit, see if someone else Acks it, and collect those, processing
> it from you after a while if nobody chimes in.

I will follow up this and might offline to check with relevant
maintainers (Will and John) for what's good way to proceed.

> Please continue providing 'perf test' regression tests, etc, to help
> with maintaining this code being checked.

Sure, I'm glad to continue the maintaining and testing works :)

Thanks,
Leo
