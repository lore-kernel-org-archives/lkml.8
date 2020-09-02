Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A8AC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6F5206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFpAa/jT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBAjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIBAjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:39:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4426C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 17:39:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so1476718pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvo2hDERJm2bQNlrbf+q0i6wSaskSnGigKJyQ9/nW18=;
        b=IFpAa/jTsltPFXE3lJ7gMvh8+DRJ9x+nMJ89IE7kxfU7RMvZWaWPmCOy5GkOJ0CB+H
         Fd3tl94k9Gv1RaUW1coPebBxAc2Q4jKeLIiWEsCbCrzRPkNwDlB7JfVMoGKL+npNe6dL
         NZrxsENzsPk2hghqjy/wq5MfyY3gdO8t/NuB3K8GNS0oMCw9bk+oSFct/gtNiQdyZ3HD
         DaNNO6FNo5j9+rdoviKTDvPmjH1z5oQmYJEGMNFAn04tWTLY/iPBqYiUZ7fiar4B1GkE
         l0FkQfmorhmsYIA7lgBJUMeWxJsr2LHNpSUfndyYdDbd/ZbBG40xa6AKBs4y2RJnmWTf
         KKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvo2hDERJm2bQNlrbf+q0i6wSaskSnGigKJyQ9/nW18=;
        b=midiPSEeIfHwBLsJ4unXAozCct+ha+5w8LKLhGKhO+JT4Orqx8Sgq2+8nppO5deVXT
         sWxKhtuW8fj2/f1GXwgRCoczejEZc6I+1tZQRYxs6I1fh1MwFNu9hOVQ5Nvk9ma3EhzN
         tm60qNoD4chC8rxPwcFWZ5muiEjEKEy9W69EuRjOPNdMq6Awfu/BovZ9KJZamyyOEdQD
         LCs2NOXl7MBwCGlhZyeIgX/8fNh/yrfdcH4QMtpeZ7wn/dc+jtPgQ0WvY7dsQO6g9+8Z
         M6k4JK9P2u7+lHNlQ+oxnlOwbx5hyUQhnAK6znuoJWjqeB/4K9BGVYUiZ09ZF7d2h86p
         +fxA==
X-Gm-Message-State: AOAM533uPkGzh3Lnal/YS9zq0+7LxgVB4yidvMpC/4VoYe8KXVSvmrfR
        RiU0Vjss98/l+z21uQBw77N3xQ==
X-Google-Smtp-Source: ABdhPJy6lNI/VOjCx8plTEkrJkl7CPonK8ZvM4q8NnecOOaHoGHFCfD/UWLD6RmkRzW/JBrD9ihiCw==
X-Received: by 2002:a17:902:aa89:: with SMTP id d9mr3845116plr.192.1599007180052;
        Tue, 01 Sep 2020 17:39:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r199sm3411874pfc.98.2020.09.01.17.39.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 17:39:39 -0700 (PDT)
Date:   Wed, 2 Sep 2020 08:39:32 +0800
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
Message-ID: <20200902003931.GA3306@leoy-ThinkPad-X240s>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200827205354.GE22307@xps15>
 <20200831000432.GA4715@leoy-ThinkPad-X240s>
 <20200901145432.GB1422817@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901145432.GB1422817@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Sep 01, 2020 at 11:54:32AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 31, 2020 at 08:04:32AM +0800, Leo Yan escreveu:
> > Hi Mathieu,
> > 
> > On Thu, Aug 27, 2020 at 02:53:54PM -0600, Mathieu Poirier wrote:
> > > Hi Leo and Al,
> > > 
> > > On Wed, Aug 19, 2020 at 04:47:50PM +0800, Leo Yan wrote:
> > > > From: Al Grant <al.grant@arm.com>
> > > > 
> > > > Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > > > changed the format of branch stacks in perf samples. When samples use
> > > > this new format, a flag must be set in the corresponding event.
> > > > Synthesized branch stacks generated from CoreSight ETM trace were using
> > > > the new format, but not setting the event attribute, leading to
> > > > consumers seeing corrupt data. This patch fixes the issue by setting the
> > > > event attribute to indicate use of the new format.
> > > > 
> > > > Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > > > Signed-off-by: Al Grant <al.grant@arm.com>
> > > > Reviewed-by: Andrea Brunato <andrea.brunato@arm.com>
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > >  tools/perf/util/cs-etm.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > > index c283223fb31f..a2a369e2fbb6 100644
> > > > --- a/tools/perf/util/cs-etm.c
> > > > +++ b/tools/perf/util/cs-etm.c
> > > > @@ -1344,8 +1344,15 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
> > > >  		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
> > > >  	}
> > > >  
> > > > -	if (etm->synth_opts.last_branch)
> > > > +	if (etm->synth_opts.last_branch) {
> > > >  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> > > > +		/*
> > > > +		 * We don't use the hardware index, but the sample generation
> > > > +		 * code uses the new format branch_stack with this field,
> > > > +		 * so the event attributes must indicate that it's present.
> > > > +		 */
> > > > +		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> > > > +	}
> > > 
> > > I've see this patch before...  I thought it had been merged - what happened?
> > 
> > This patch before has been sent by Al to CoreSight mailing list but has
> > not sent to LKML, this is why I resent it to LKML in case it's missed.
> 
> So, was it Acked on the CoreSight mailing list? Are we missing any
> Acked-by or Reviewed-by for this 1/2 patch as we got for 2/2?

The CoreSight mailing list has some discussion for this patch set,
when respin this patch set, I confirmed we don't miss any 'Acked' or
'Reviewed' tags.

Thanks,
Leo
