Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4DC20720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/2mPXua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHaAEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHaAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:04:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B0C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:04:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t9so3601790pfq.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUdSvk5J8DTI5Xr+3CE/Zt/bx+WPT72VmT5LjNqwFtM=;
        b=L/2mPXuaXAvKNhkkTk5J/NKPLUghKUXkDkan9fTIWgOlhEWQFsKYi8Fx1aCHKoN6hb
         kJ9JODK7tYFEjeu7AhaP9Wlhz8hbqHaT/DRu494hnxcrI7pbU/+sF4QBvgyqJOxYwXRZ
         6MnMqdvbjUJ+1FhTKtxlLVdd/odTPuDoHO17bW8jNls+eye/7a2aq8QlXu9l+jzt4pZX
         fRxfGkgn4kEZwOTE1lx2cq3FhnGqq9iCNiNI3goE4+QgCVz7GGkI98qgh7wmTePjNsQZ
         HdewTQsTunDTyj5Rd/OjHY4iWSlCaBgbBnppfBu9rc4mWJ304lp4iQio8zKNK/Tc/ySC
         Vk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUdSvk5J8DTI5Xr+3CE/Zt/bx+WPT72VmT5LjNqwFtM=;
        b=I/Ttw4f4CoAw4g0N7Q1dSPEv8PXR9wVbBTV7JOqCIHt424amjDw3y8kcIUfbfy765y
         YHf4TY+pRa5gq9ZNDGMrzQjZ2ItRHV5HxAakxSTtG7lzHkl/OYGQf+bjMITpJgbMVVTV
         muXRgOy60kd8cwJrwbkpb8mww6PCOy8YMG3baYk9p6v8qALlorlfQOP2hN+tfqRWZfSZ
         R0pgqqY4apXPSt/g5ZIaRrWUU5bmozsVz4aEQnN2wvtplJSDmyTCVZNGX7kr+pyTvmIL
         pFnNeS2zHjgp43y0aflp9Dbfg7aBvSd/3MS9VFPrb1Y2OIRYYrurnqLpN67CWMgPpCJc
         WxuA==
X-Gm-Message-State: AOAM5307mbcOtcfUILBla2cfddnQBbGxtixvrZydNMfTiJ9ZWpNzg02a
        Rx1sCff8T63hcAAaFNkDRJ3F/AztOeo9/6A/
X-Google-Smtp-Source: ABdhPJxg/ZwGZH6yTleWALtbXSO2u0NTDMXd5PjRa28U19Zb8c97rFw+uArdIPjbOAYHXF3uOOly7Q==
X-Received: by 2002:a62:7551:: with SMTP id q78mr948027pfc.140.1598832280504;
        Sun, 30 Aug 2020 17:04:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l13sm5391701pgq.33.2020.08.30.17.04.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 17:04:39 -0700 (PDT)
Date:   Mon, 31 Aug 2020 08:04:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20200831000432.GA4715@leoy-ThinkPad-X240s>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200827205354.GE22307@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827205354.GE22307@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu, Aug 27, 2020 at 02:53:54PM -0600, Mathieu Poirier wrote:
> Hi Leo and Al,
> 
> On Wed, Aug 19, 2020 at 04:47:50PM +0800, Leo Yan wrote:
> > From: Al Grant <al.grant@arm.com>
> > 
> > Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > changed the format of branch stacks in perf samples. When samples use
> > this new format, a flag must be set in the corresponding event.
> > Synthesized branch stacks generated from CoreSight ETM trace were using
> > the new format, but not setting the event attribute, leading to
> > consumers seeing corrupt data. This patch fixes the issue by setting the
> > event attribute to indicate use of the new format.
> > 
> > Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > Signed-off-by: Al Grant <al.grant@arm.com>
> > Reviewed-by: Andrea Brunato <andrea.brunato@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index c283223fb31f..a2a369e2fbb6 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1344,8 +1344,15 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
> >  		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
> >  	}
> >  
> > -	if (etm->synth_opts.last_branch)
> > +	if (etm->synth_opts.last_branch) {
> >  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> > +		/*
> > +		 * We don't use the hardware index, but the sample generation
> > +		 * code uses the new format branch_stack with this field,
> > +		 * so the event attributes must indicate that it's present.
> > +		 */
> > +		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> > +	}
> 
> I've see this patch before...  I thought it had been merged - what happened?

This patch before has been sent by Al to CoreSight mailing list but has
not sent to LKML, this is why I resent it to LKML in case it's missed.

Thanks,
Leo
