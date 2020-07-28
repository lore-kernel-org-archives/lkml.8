Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DF8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D2E20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcNG+Fd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgG1Miy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgG1Miy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:38:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C745C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:38:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so9818692pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4g7iTxi0pQvK+1PDjldeUqyZ+gKf3NktQDHtumchvKQ=;
        b=VcNG+Fd3VoebKC5oQn3y3iz+BcvT+E2SZOs/g9qfOdqjCaGQTu0lvXrlDi9ibw9rck
         iKh5+3D05iRYoKukzR7O8KaNFC49Ms+ZEgqfDgBF1KYwvdcK+fZ+m6bnPz9rYtOBECS1
         XHIwR0omC8k7yjGSKLwn1MjA65gsFM0EAAs2xEyTFLx9Uo2YpyuFowC8QePmvHgqV7Bx
         5wdFKqJauWyyisfnJdwUBv8GnCBT+spyj3IF0EflkTGBz/2AK+fpxVnuktuZfDpmCEkk
         +szzDbsb/qgd/y/W0JliNNbOAmnjjD5LLRjXLXmhBtrOp6piLkrpzDwMHxjEfY0OFvDW
         LTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4g7iTxi0pQvK+1PDjldeUqyZ+gKf3NktQDHtumchvKQ=;
        b=oLZclVPavQGqE79L3teZXmBbkukJbNf+dgLHi24mOm2hPz21W+4SXX/+4vDMvEi1Pd
         Yi3QseO29cZxR5hPUZ2Sl/AjIyr5Esgax5PDgXHs+aWZTbSlmD0Ri+6TwuF5JJzAKQQj
         dnjBIKfIGVEeicZ2zTgI3xTR1/pMXbXhMllotSKzMARpbbuibHkqLVXThuEcu4DqxWzm
         ku8RB6qtG8PeRjATNv76BRaYEN+UeaK5vAybMGTUkUbgQ6XR22wGw/i8b8VrXUE/APki
         WK+pTSgP00n5XhwLuNFl76xv984Rp6PukDx/3HSEgxgnHzl0+sPqBEldtlrvXzkAnKCL
         iWgQ==
X-Gm-Message-State: AOAM531AxHy9p2cHePCiWFWVZsgVribmmyXbo3L9NcJcrkFklrc7ISCN
        Mewt1A81YpWfAAa5wmxfF78R0w==
X-Google-Smtp-Source: ABdhPJxBZLWz+mrfdp81OQw/iibH/lD1K3X9d0oGtG1OIvJ9Veil+ItGUILGfvZeKbL2PBdWjw3sgg==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr23335947plt.42.1595939933649;
        Tue, 28 Jul 2020 05:38:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x9sm20731774pfq.216.2020.07.28.05.38.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 05:38:52 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:38:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Wei Li <liwei391@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, guohanjun@huawei.com
Subject: Re: [PATCH v2 2/2] perf tools: ARM SPE code cleanup
Message-ID: <20200728123846.GC4343@leoy-ThinkPad-X240s>
References: <20200724071111.35593-1-liwei391@huawei.com>
 <20200724071111.35593-3-liwei391@huawei.com>
 <20200727203436.GC2381376@xps15>
 <20200728120220.GA40195@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728120220.GA40195@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jul 28, 2020 at 09:02:20AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 27, 2020 at 02:34:36PM -0600, Mathieu Poirier escreveu:
> > On Fri, Jul 24, 2020 at 03:11:11PM +0800, Wei Li wrote:
> > > - Firstly, the function auxtrace_record__init() will be invoked only
> > >   once, the variable "arm_spe_pmus" will not be used afterwards, thus
> > >   we don't need to check "arm_spe_pmus" is NULL or not;
> > > - Another reason is, even though SPE is micro-architecture dependent,
> > >   but so far it only supports "statistical-profiling-extension-v1" and
> > >   we have no chance to use multiple SPE's PMU events in Perf command.
> > 
> > I find the above changelog somewhat out of touch with the patch itself.  The
> > only thing that is happening here is the removal of a useless check and a fix
> > for a memory leak.
> 
> Humm, I think the original intent of that code was to cache the results
> of find_all_arm_spe_pmus(), as the variable it is assigned to is static.
> 
> So not a leak, as there was that static reference to it to reuse it
> later, but that is strange in a function named "__init()" which usually
> is called only once, anyway, so I think that the paragraph with
> "Firstly" is kinda ok, but confusing, I think it should read:
> 
> - auxtrace_record__init() is called only once, so there is no point in
>   using a static variable to cache the results of
>   find_all_arm_spe_pmus(), make it local and free the results after use.
> 
> The second paragraph is SPE specific, so I'm not qualified to judge on
> it.
> 
> I'm replacing the first paragraph with the version I wrote and keep it
> in my local branch, please holler if you think I misunderstood.

Thanks a lot for this.  These two paragraphs were coming from reviewing
and comments, but I think your rephrasing is very sufficient to describe
what this patch is doing :)

Thanks,
Leo

> > Once again whether Arnaldo wants to make the changes by hand or not you may have
> > to resubmit.
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > > 
> > > So remove the useless check code to make it clear.
> > > 
> > > Signed-off-by: Wei Li <liwei391@huawei.com>
> > > ---
> > >  tools/perf/arch/arm/util/auxtrace.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> > > index 28a5d0c18b1d..b187bddbd01a 100644
> > > --- a/tools/perf/arch/arm/util/auxtrace.c
> > > +++ b/tools/perf/arch/arm/util/auxtrace.c
> > > @@ -57,17 +57,15 @@ struct auxtrace_record
> > >  	struct evsel *evsel;
> > >  	bool found_etm = false;
> > >  	struct perf_pmu *found_spe = NULL;
> > > -	static struct perf_pmu **arm_spe_pmus = NULL;
> > > -	static int nr_spes = 0;
> > > +	struct perf_pmu **arm_spe_pmus = NULL;
> > > +	int nr_spes = 0;
> > >  	int i = 0;
> > >  
> > >  	if (!evlist)
> > >  		return NULL;
> > >  
> > >  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> > > -
> > > -	if (!arm_spe_pmus)
> > > -		arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> > > +	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> > >  
> > >  	evlist__for_each_entry(evlist, evsel) {
> > >  		if (cs_etm_pmu &&
> > > @@ -84,6 +82,7 @@ struct auxtrace_record
> > >  			}
> > >  		}
> > >  	}
> > > +	free(arm_spe_pmus);
> > >  
> > >  	if (found_etm && found_spe) {
> > >  		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> > > -- 
> > > 2.17.1
> > > 
> 
> -- 
> 
> - Arnaldo
