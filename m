Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F07C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F813206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598972100;
	bh=MAxRLRhpKMxTjMaTPe+Mkc3zeiFKKPVO0RG7AiViFRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fDbam8Fy0FXH+K06hIzqt9sGZasJjqAsu4FI1j/u+YdkA/d7Z9jrZ8wpZ29gkS4Dj
	 AzBkMByLbyYvMSVRREj0wNjf2LxBvWYnkkEAdO9/OP3ge4c3/h8mtx88mFAsb+uEYz
	 FF306inD3euMp82YUES18UALJZGbiKlOluA6Lz48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIAOyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgIAOyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:54:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E852078B;
        Tue,  1 Sep 2020 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598972075;
        bh=MAxRLRhpKMxTjMaTPe+Mkc3zeiFKKPVO0RG7AiViFRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCzdBfWBFNqhHaufroH8myQ/yRWFIa6uXdVJhF4tPrcHAknmxS5eVfj6fmi6++Pk8
         wiQ886QH6BMlcmMimT8XzVUpsPKXnMqTUFApAs3d9SoKP40Ny07LAac7ofP1A79t3E
         27ejYTaqjc/Bj3NtMWTyzOKNp9L5xRP6c6NyesIM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1326D40D3D; Tue,  1 Sep 2020 11:54:33 -0300 (-03)
Date:   Tue, 1 Sep 2020 11:54:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20200901145432.GB1422817@kernel.org>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200827205354.GE22307@xps15>
 <20200831000432.GA4715@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831000432.GA4715@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 31, 2020 at 08:04:32AM +0800, Leo Yan escreveu:
> Hi Mathieu,
> 
> On Thu, Aug 27, 2020 at 02:53:54PM -0600, Mathieu Poirier wrote:
> > Hi Leo and Al,
> > 
> > On Wed, Aug 19, 2020 at 04:47:50PM +0800, Leo Yan wrote:
> > > From: Al Grant <al.grant@arm.com>
> > > 
> > > Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > > changed the format of branch stacks in perf samples. When samples use
> > > this new format, a flag must be set in the corresponding event.
> > > Synthesized branch stacks generated from CoreSight ETM trace were using
> > > the new format, but not setting the event attribute, leading to
> > > consumers seeing corrupt data. This patch fixes the issue by setting the
> > > event attribute to indicate use of the new format.
> > > 
> > > Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > > Signed-off-by: Al Grant <al.grant@arm.com>
> > > Reviewed-by: Andrea Brunato <andrea.brunato@arm.com>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index c283223fb31f..a2a369e2fbb6 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -1344,8 +1344,15 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
> > >  		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
> > >  	}
> > >  
> > > -	if (etm->synth_opts.last_branch)
> > > +	if (etm->synth_opts.last_branch) {
> > >  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> > > +		/*
> > > +		 * We don't use the hardware index, but the sample generation
> > > +		 * code uses the new format branch_stack with this field,
> > > +		 * so the event attributes must indicate that it's present.
> > > +		 */
> > > +		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> > > +	}
> > 
> > I've see this patch before...  I thought it had been merged - what happened?
> 
> This patch before has been sent by Al to CoreSight mailing list but has
> not sent to LKML, this is why I resent it to LKML in case it's missed.

So, was it Acked on the CoreSight mailing list? Are we missing any
Acked-by or Reviewed-by for this 1/2 patch as we got for 2/2?

- Arnaldo
