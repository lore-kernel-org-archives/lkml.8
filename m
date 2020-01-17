Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C353C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4870F2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLz+DeXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAQPgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:36:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44089 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:36:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so9995693plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwBF42N8bOInUjU3mqsM9gMbAa/G/sJJUIKIesRfdeA=;
        b=dLz+DeXdaoeUIACOt7xvx6JZ/KdgW4elO6F4OJiTi95bhZNv5d0fTi8sf2esjEeHve
         jrYJvTvtuTwk9455w9u6uWdHWVRnE2Jb+jmlZYKTHRxuESeUvLSApCr070QeGHnCUSHQ
         WMwSgYvTh9T6hzji33cRrFwCpRBljihZmZYy5U11TO1jyUAqzKJ6fCEHy8e3bV4O/wxR
         OAwCrbd7XqNaPEZBQQMj15F4sfT051R1jES7hQ/M3/UigVmN0OjjBXiLETRdBMmDnRnG
         nC8arJzl3mRUBtRUIpf67KeJ0HgjqXZk6xkCP6pgJgGauSqz4fetpCLJ3l5+GefWmOyv
         +nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwBF42N8bOInUjU3mqsM9gMbAa/G/sJJUIKIesRfdeA=;
        b=OxAoDB38gogQo/wUWfDX2NN/1/tFncRevQ3lwkzCfN3bV6dqHTccqaMPRKD/JLi49k
         iPYz4ANbipPQ0ZD4Og1VScZ1PqtKvM9a0A7s+G/WDmcqf8pzHFoCTUkXyhMcNMQK2uDP
         Yi6lOuGN6k7/mdX+BiIaSve4Zz69AahdScLhjRO9Vn9iua9JwEup4S+7KdhijXdfnqZO
         xs/bOi3t7zeVt95eLymDTZRSXcLjkbNWAYnzMjmAe7KW0XzJzjz8AR+vvzgMhRcNdAQt
         CspeciuUrTot+yd7dTnkCmmCy46hx9dF+qOAjYB5D8gKT7eo5HM8KBJ6x/8wKOjF+dxr
         KE9g==
X-Gm-Message-State: APjAAAVkmaMjllFRzH9W2q3Am+d6VvFQZ0mxl3a/NQaG1RSxbctAauNd
        O0tPKscBWO4cLe84KKGvlbwPPQ==
X-Google-Smtp-Source: APXvYqyD8/HZXE/aMpUdpii4a83GeHFpYoYCaaceWICf147EcnNFrFFn2yGKuJYhU1mhHZIjnA4P9Q==
X-Received: by 2002:a17:90a:330c:: with SMTP id m12mr6335610pjb.18.1579275403850;
        Fri, 17 Jan 2020 07:36:43 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li96-55.members.linode.com. [74.207.254.55])
        by smtp.gmail.com with ESMTPSA id b15sm29770249pft.58.2020.01.17.07.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 07:36:43 -0800 (PST)
Date:   Fri, 17 Jan 2020 23:36:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v6 2/2] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200117153630.GA22019@leoy-ThinkPad-X240s>
References: <20200117055251.24058-1-leo.yan@linaro.org>
 <20200117055251.24058-2-leo.yan@linaro.org>
 <20200117133409.GB3323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117133409.GB3323@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:34:09AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 17, 2020 at 01:52:51PM +0800, Leo Yan escreveu:
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
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/evsel.c        | 2 ++
> >  tools/perf/util/evsel_config.h | 1 +
> >  tools/perf/util/parse-events.c | 7 ++++++-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 549abd43816f..6fe9e28180e5 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
> >  
> >  	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
> >  		list_del_init(&term->list);
> > +		if (term->free_str)
> > +			free(term->val.str);
> 
> I'm replacing this with zfree, so that we can catch possible bugs where
> term gets used after freed, just like you do below, in ADD_CONFIG_TERM_STR()

Thanks a lot, Arnaldo.

> >  		free(term);
> >  	}
> >  }
> > diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> > index b4a65201e4f7..e026ab67b008 100644
> > --- a/tools/perf/util/evsel_config.h
> > +++ b/tools/perf/util/evsel_config.h
> > @@ -32,6 +32,7 @@ enum evsel_term_type {
> >  struct perf_evsel_config_term {
> >  	struct list_head      list;
> >  	enum evsel_term_type  type;
> > +	bool		      free_str;
> >  	union {
> >  		u64	      period;
> >  		u64	      freq;
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index f59f3c8da473..c01ba6f8fdad 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1240,7 +1240,12 @@ do {								\
> >  #define ADD_CONFIG_TERM_STR(__type, __val)			\
> >  do {								\
> >  	ADD_CONFIG_TERM(__type);				\
> > -	__t->val.str = __val;					\
> > +	__t->val.str = strdup(__val);				\
> > +	if (!__t->val.str) {					\
> > +		zfree(&__t);					\
> > +		return -ENOMEM;					\
> > +	}							\
> > +	__t->free_str = true;					\
> >  } while (0)
> >  
> >  	struct parse_events_term *term;
> > -- 
> > 2.17.1
> 
