Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7769C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E1A206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF5rt1Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgFAIRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgFAIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:17:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45255C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 01:17:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so645432pjv.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kqzX8bfnhuwwbKY1yObZQk6AEOe++Br6zCRCcqTuYOo=;
        b=KF5rt1NcZPsLJLiXgSligGtQMsZjvWp/e/qzbPtQmJ5xDxXTK6vechQH3XTaZi80b/
         LbP2R92erioVOwqsdsGB73GqVeNPjMV0WcZQRl6CvonIgtMxFfg2MDTPFgl3SxxJI5Nl
         biFDNzf8cEXR5vy0kL2lBs4jcfGmLucbHDP4bDYztvHaqropD3bJdQDowXmEDj/EGawy
         WMXEXHYMSBA+OfftR2Bgol6wrh0fWJZnlOZaCqsPqxJmboh/T8QFG1N3Uilizwh1EcAn
         VDCeXLVNWr6K9WiJb7zE10WA2ctEuz3jNFsitLbRVCJluNq5xuCn8xAygKpQ7WlcqNr5
         Ttww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqzX8bfnhuwwbKY1yObZQk6AEOe++Br6zCRCcqTuYOo=;
        b=cvjNIGwrajUUwTsWvN+MHRZxLY+DOz9vbYaqapY1/LvtxuKxpScU6onEB41+igWfzZ
         XsRgSXdw85yEz4Bz/KbwL351n7Gw1ODJsEjU+I24X/HLYg0FLBUcDzKN7htSMCrM5QjS
         lXFYPSQ5wJCctMxXzSLOGcrJ0lQwv1j5VV8UM+WvjzNdGOIHfHHxbjVqFkJmq8NVQ+nB
         wAWzOqA1GUMj6+fMT1mUHUbrSgAST370rJAVS7G37DJMKa+OfK0Ix0xU9aCvkXt+zxu7
         cHYytXmdcLcEhHiSXjqRsmRHtRJpySBVlDf4WMjLXo7ZIVhQgYW9f0hzcNYycQp2/nyS
         2EFA==
X-Gm-Message-State: AOAM533qsUiqsYOonHKaDqWvPEpGqXdk1C1IHV1Us7HoQgnJERRnLhBa
        MAVnvC1g8576FkB8hRvjr9A+tg==
X-Google-Smtp-Source: ABdhPJx9xSU0nlxKt+3NjhYK5L8xaBuMxp8L3p9v3qIMDmSunPapVAWh8nUrzKCi0e05I3RWxfvPnA==
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr21409594pjs.165.1590999452727;
        Mon, 01 Jun 2020 01:17:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y6sm6596587pjw.15.2020.06.01.01.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 01:17:32 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:17:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Al Grant <al.grant@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>
Subject: Re: [PATCH v8 2/3] perf auxtrace: Add four itrace options
Message-ID: <20200601081746.GB28016@leoy-ThinkPad-X240s>
References: <20200530122442.490-1-leo.yan@linaro.org>
 <20200530122442.490-3-leo.yan@linaro.org>
 <aaacf3f6-daab-098e-d1fb-1509e1cf9c84@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaacf3f6-daab-098e-d1fb-1509e1cf9c84@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:24:00AM +0300, Adrian Hunter wrote:
> On 30/05/20 3:24 pm, Leo Yan wrote:
> > From: Tan Xiaojun <tanxiaojun@huawei.com>
> > 
> > This patch is to add four options to synthesize events which are
> > described as below:
> > 
> >  'f': synthesize first level cache events
> >  'm': synthesize last level cache events
> >  't': synthesize TLB events
> >  'a': synthesize remote access events
> > 
> > This four options will be used by ARM SPE as their first consumer.
> > 
> > Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Tested-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks a lot for reviewing, Adrian.

Leo
