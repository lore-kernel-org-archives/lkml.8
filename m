Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805CBC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F06A24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBG/s5/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgANJy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:54:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33492 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:54:28 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so802245pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ab/jlRDwB+sX63oD6KjQ3FamjJL9BhbF54olV6AcIQA=;
        b=DBG/s5/1sNABlFEmsrQ5h6wCfUh1PPS1vx6ReFeXbF4XMnzk57ED5b5rmgd0w20yWo
         Br6gzijGMw3ebt/2fzK3oIlwZL46/KJC54pTb82j1jEnKMd+KZ/8sCON6rgjpYK3fEbs
         Z9oycSFjH+Xu5StZgjI/UDurlKV6+6uTNGc5jvxxyA6MfU84j4ZxEc9NrMhZH2l0VQD8
         /xEZDNznuJT6CMTT3Ty86mdtf3/wsEJ8zk8YWwQcuDbAdgnmTz95PstIv8w0XnsICFGN
         c0pnigD0xbLJkbSJvgDH/s1d0Eew2n41MrBeA5BGcpT5wlGaiX8A2DADZ3FiaEJemVEz
         ocQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ab/jlRDwB+sX63oD6KjQ3FamjJL9BhbF54olV6AcIQA=;
        b=d6ZIUzrW2hFTwkSzIIUYXcgcH1vt3/j4JjaF+REfRHyGDK/f8o7BKIeteOsq3bGt28
         bogoB63bdb1S1ZiOsbN9GdI9nhhQ12yfQSpQ1DP514LEnlxAKLaktghDX5ZdK1cucF3+
         GafJcv1DerJrP6irPqKAhVqjc0Tqk0d+W8tjM7dSejPL3uxY7UO1KKfAWEpEoxttpdSM
         ngobs0+2N/dNplq19ci1un0M/As98Jhpmp0NGwyRHg2OUfshxwmcg8VS0lClnB4waNG6
         oYsx1HlxVFNRjH8+wNgUsha8pBQ3tqdDr4rlKNO3H73VzzTDd5xO8wtS0zC1u+3zIaeb
         LDLA==
X-Gm-Message-State: APjAAAUnuucT8RCO1gjnV2f/iHqjBnW+2ekIuWAjxDfqqcyz/G9OO+kG
        AceTpOTvw54NIwF/126Ns1APHA==
X-Google-Smtp-Source: APXvYqwIphzosQtp93N2MnCeDGCAYeq4HHzWsODjt9c4fn9IIe2f07bcj0Vwuw0ys7vAIvpyRLKW/A==
X-Received: by 2002:a17:90b:3d0:: with SMTP id go16mr28213338pjb.75.1578995667153;
        Tue, 14 Jan 2020 01:54:27 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id 73sm3565016pfy.159.2020.01.14.01.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 01:54:26 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:54:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200114095418.GA6937@leoy-ThinkPad-X240s>
References: <20200113151806.17854-1-leo.yan@linaro.org>
 <20200113151806.17854-2-leo.yan@linaro.org>
 <20200114091228.GA170376@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114091228.GA170376@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:12:28AM +0100, Jiri Olsa wrote:
> On Mon, Jan 13, 2020 at 11:18:06PM +0800, Leo Yan wrote:
> > perf with CoreSight fails to record trace data with command:
> > 
> >   perf record -e cs_etm/@tmc_etr0/u --per-thread ls
> >   failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
> >   directory)/perf/
> > 
> > This failure is root caused with the commit 1dc925568f01 ("perf
> > parse: Add a deep delete for parse event terms").
> > 
> > The log shows, cs_etm fails to parse the sink attribution; cs_etm event
> > relies on the event configuration to pass sink name, but the event
> > specific configuration data cannot be passed properly with flow:
> > 
> >   get_config_terms()
> >     ADD_CONFIG_TERM(DRV_CFG, term->val.str);
> >       __t->val.str = term->val.str;
> >         `> __t->val.str is assigned to term->val.str;
> > 
> >   parse_events_terms__purge()
> >     parse_events_term__delete()
> >       zfree(&term->val.str);
> >         `> term->val.str is freed and assigned to NULL pointer;
> > 
> >   cs_etm_set_sink_attr()
> >     sink = __t->val.str;
> >       `> sink string has been freed.
> > 
> > To fix this issue, in the function get_config_terms(), this patch
> > changes to use strdup() for allocation a new duplicate string rather
> > than directly assignment string pointer.
> > 
> > This patch addes a new field 'free_str' in the data structure
> > perf_evsel_config_term; 'free_str' is set to true when the union is used
> > as a string pointer; thus it can tell perf_evsel__free_config_terms() to
> > free the string.
> > 
> > Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> with that checkpatch changes
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Will fix checkpath warnings and resend patch v6.

Thanks you/Mathieu/Andi's reviewing.

Leo
