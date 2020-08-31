Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB180C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 02:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0E12076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 02:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXzkPPaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHaCws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 22:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgHaCwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:52:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5252C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 19:52:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so2308607pfi.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A1BZl6eZWFd9hXWUqOAEKhTTMElg1LEkP6CLdsn7aD4=;
        b=wXzkPPaJTgHQTvqIqf5RTdaXzP1F+dRUNo873SRYodRN35MDEgvO+yGcHuvJsMKMB5
         rStjEc625mbHqeDd/ddud/cP9Z/qCYHvDkFABVmjNsF2RE3paTxONATzJoyvDley9d81
         krgv6RP4OsllENfyH1GgkcmSKMn5eNoF+IgRHNHc6+gDAwb88nJCdYGQA3Cqiy4QeUR0
         vQ3RgbeWCKTokv95dr0DquECkSHTmhLUaWbRIieh5qpfS3PAnO0T2DO0Iufdr3EdE9gJ
         uUYmsnnMv3lBns01YdsgGjB+Kf1+0Wbc5e+GLRy+k4eDFxHGcAdtxZm42268RrZZVHS9
         T1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1BZl6eZWFd9hXWUqOAEKhTTMElg1LEkP6CLdsn7aD4=;
        b=ZtvVWeztoV2MOCETX9+GdFofx2BrumpGnZL3rTexpP/urgYxqOAnz37bjUEmFny5p/
         rSPQztJkjRSodmAG14p1AWoEw3QKIeCED2W5ZWQqunZznoW/GNTUFJycZfx3Wvv5x/U+
         1/0o7Aqah4w61Y4GDGye32z98ZrKVKyxivKFSC4wsw9xD+XxFuTz5CKg6CfawdE48DZn
         FOZQ7SxYOlk2jWOKtzBjo0RQUdeMsr0Zk9R68RzlsomEmPFMxtbdtuHeZGbkKt/CBH3p
         KrtCbVY06GQj+sBcw12PqYMkZBhIXQ9R7IlXEODoNLyjBGeI+gzTTTWpzSPE/4yAf6pE
         w3Fg==
X-Gm-Message-State: AOAM531eDkPPELkA0jFBz6Nj4JkJNqnaVwGFWNqOyVY88cSRoPMx4/rd
        mBBLb0ge/tnrGjzEfMyyTEd2zw==
X-Google-Smtp-Source: ABdhPJwm4sB0z9LTpgZPPPTjj2JAxIyNIzf+fqvUuJiSdIIfJXAwmpn8+aUw91Yxg1s5qiB2/HBSxQ==
X-Received: by 2002:a63:2d05:: with SMTP id t5mr5541612pgt.444.1598842359730;
        Sun, 30 Aug 2020 19:52:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id k88sm5443742pjk.19.2020.08.30.19.52.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 19:52:39 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:52:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, nd <nd@arm.com>
Subject: Re: [PATCH RESEND v1 02/11] perf mem: Introduce weak function
 perf_mem_events__ptr()
Message-ID: <20200831025230.GA13217@leoy-ThinkPad-X240s>
References: <20200806030727.30267-1-leo.yan@linaro.org>
 <20200806030727.30267-3-leo.yan@linaro.org>
 <e756de3d-d41f-4b51-d434-fe12cd2da251@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e756de3d-d41f-4b51-d434-fe12cd2da251@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 04:40:29PM +0100, James Clark wrote:
> Hi Leo,
> 
> On 06/08/2020 04:07, Leo Yan wrote:
> >  
> >  	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > -		if (!perf_mem_events[j].record)
> > +		e = perf_mem_events__ptr(j);
> > +		if (!e->record)
> >  			continue;
> >  
> > -		if (!perf_mem_events[j].supported) {
> > +		if (!e->supported) {
> >  			pr_err("failed: event '%s' not supported\n",
> > -			       perf_mem_events[j].name);
> > +			       perf_mem_events__name(j));
> >  			free(rec_argv);
> >  			return -1;
> 
> Does it make sense to do something like:
> 
>    for(j = 0; e = perf_mem_events__ptr(j); j++) {
>        ...
>    }
> 
> now that it's a weak function that returns NULL when the argument out of range. That way the caller
> doesn't need to know about PERF_MEM_EVENTS__MAX as well and it could potentially be a different
> value. I don't know if it would ever make sense to have a different number of events on different platforms?

Thanks for reviewing, James.

If you look into the later patch "perf mem: Support new memory event
PERF_MEM_EVENTS__LOAD_STORE", you could find it introduces a new event
which will be only used for Arm SPE but will not be used by other
archs.

Your suggestion is good to encapsulate the macro PERF_MEM_EVENTS__MAX
into perf_mem_events__ptr(), I will try it in next spin.

Thanks,
Leo
