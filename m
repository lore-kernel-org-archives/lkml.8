Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4303C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9156422242
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR2DKDho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgDPO5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409337AbgDPO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:57:08 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1AAC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:57:08 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id c12so2130252qvj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ayGQgUTRID9GEmunMYdarzjkWcmhCRbQvl02NWxC1jk=;
        b=nR2DKDho8XHafYwLEV0Gre/Y3+Yuh1C4Tgo9jOemer0vEV0PRHNcKVaBBJByc8ieaQ
         3ZNv/i4KHvKmRpR/kTjG+unp/OPlqGtid4rKMnnVkUAs32mRQgEtL3KZqUk6z7TvZ0wW
         ogj1Q4rk1SB/sb5X8U88QwWHnIfWD61NnxImlEBx8k897wTemNZqvBn5u5+VzhCqtzQ/
         JpqB7hAbq60ro4hXW1eu0/RCqNwr5pQBwLCtX4HiRlk42qCLcl6G4y4oKBrZqShQ6c38
         sRf5xD/nA5TPqsn3PC4pClIanKSBe2zSViWSlsD2fLCTIt0XZQXztFdHliqeAy01no8k
         EKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ayGQgUTRID9GEmunMYdarzjkWcmhCRbQvl02NWxC1jk=;
        b=a2Ro2bzPhdUUvvnuBdwNWPgKcsWvmQipLDzHtIFbi4guvYPZP0/mGCylgg261zhfO4
         3YiaBKTtdVXbPMequoyxL/g090TI1JKMQfgXrUGpqjhfmHWC9ZfQ1gX92dwDQzfHTSNu
         lI+GSWRrO9HMXmJysy1FtsOOwqXu1utYLim/OxfGptyO5OLOy+/lr7zdfOoThfmxQbu/
         V0CXvuB7wwlBmAgRoLdL8e63lQZQU7NkqtRnxkF6mBJubyTclPz4wGf1hoIFaUrUIujD
         8WkXv5EcpRjkKJQQDksacanOOB0AgfSX6gCBYfZLISs6RxreDHh09BMBL9zqCarF3ugg
         D2Jw==
X-Gm-Message-State: AGi0PubeFzLyPDivfNOpn1+kNTW488UyMkAnPwodIsd9NUavHe+c21Ai
        Abe57XcDow7rh/GP551Xnu4=
X-Google-Smtp-Source: APiQypKcf0abDkQCinb8LmismPdA6WNuKV4LRqht8eqdWB5AgNGC42NHPLB9h49AqSRDsSrHYafpvg==
X-Received: by 2002:a0c:9aea:: with SMTP id k42mr10542592qvf.91.1587049027292;
        Thu, 16 Apr 2020 07:57:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x7sm9827437qkx.36.2020.04.16.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:57:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 978BB409A3; Thu, 16 Apr 2020 11:57:04 -0300 (-03)
Date:   Thu, 16 Apr 2020 11:57:04 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] perf tools: Add support for synthesized sample type
Message-ID: <20200416145704.GA1842@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-11-adrian.hunter@intel.com>
 <20200416145426.GA31666@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416145426.GA31666@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 16, 2020 at 11:54:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 01, 2020 at 01:16:07PM +0300, Adrian Hunter escreveu:
> > For reporting purposes, an evsel sample can have a callchain synthesized
> > from AUX area data. Add support for keeping track of synthesized sample
> > types. Note, the recorded sample_type cannot be changed because it is
> > needed to continue to parse events.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/util/evsel.c |  2 +-
> >  tools/perf/util/evsel.h | 15 ++++++++++++++-
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index eb880efbce16..60e6cd49dee3 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2136,7 +2136,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >  		}
> >  	}
> >  
> > -	if (evsel__has_callchain(evsel)) {
> > +	if (type & PERF_SAMPLE_CALLCHAIN) {
> >  		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
> 
> This ends up looking unrelated, I had to go and look at the source to
> see that this is just a simplification, i.e. earlier in this function
> (perf_evsel__parse_sample) we have:
> 
>         u64 type = evsel->core.attr.sample_type;
> 
> So the above doesn't change anything, good, but slowed reviewing a bit,
> please consider next time to have this in a separate patch, I'll do it
> this time.

I've added this as the cset comment:

Using 'type' variable for checking for callchains is equivalent to using
evsel__has_callchain(evsel) and is how the other PERF_SAMPLE_ bits are checked
in this function, so use it to be consistent.
 
> Thanks,
> 
> - Arnaldo
>   
> >  		OVERFLOW_CHECK_u64(array);
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 53187c501ee8..e64ed4202cab 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -104,6 +104,14 @@ struct evsel {
> >  		perf_evsel__sb_cb_t	*cb;
> >  		void			*data;
> >  	} side_band;
> > +	/*
> > +	 * For reporting purposes, an evsel sample can have a callchain
> > +	 * synthesized from AUX area data. Keep track of synthesized sample
> > +	 * types here. Note, the recorded sample_type cannot be changed because
> > +	 * it is needed to continue to parse events.
> > +	 * See also evsel__has_callchain().
> > +	 */
> > +	__u64			synth_sample_type;
> >  };
> >  
> >  struct perf_missing_features {
> > @@ -398,7 +406,12 @@ static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
> >  
> >  static inline bool evsel__has_callchain(const struct evsel *evsel)
> >  {
> > -	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
> > +	/*
> > +	 * For reporting purposes, an evsel sample can have a recorded callchain
> > +	 * or a callchain synthesized from AUX area data.
> > +	 */
> > +	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
> > +	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
> >  }
> >  
> >  struct perf_env *perf_evsel__env(struct evsel *evsel);
> > -- 
> > 2.17.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
