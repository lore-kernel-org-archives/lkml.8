Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC7C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9C52075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHz56Qel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANJMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:12:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578993158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZALZvhnBSZ8UpPszsBIa5IaFJFn9TLqKEGfeaXNCWf8=;
        b=HHz56QelRKmn1tYtRA0qy38WCXJKCwNJZN2q1OpvYNscJ9d5dT4X+bWE2GO4U2GWsUqYZJ
        k6nqWxIfpGQub1ZMwCohYHAPT1B/HKp6rvnedr3BlRdYfvUbzjRSHOl2Yri7X8ciA6HbIo
        XmneJNCU9vpcWOz1LLqgWxUUYJ5qiFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-s2IltAB8N3OuT-kphzjcZQ-1; Tue, 14 Jan 2020 04:12:36 -0500
X-MC-Unique: s2IltAB8N3OuT-kphzjcZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A85CC100551A;
        Tue, 14 Jan 2020 09:12:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 848D2601B3;
        Tue, 14 Jan 2020 09:12:31 +0000 (UTC)
Date:   Tue, 14 Jan 2020 10:12:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20200114091228.GA170376@krava>
References: <20200113151806.17854-1-leo.yan@linaro.org>
 <20200113151806.17854-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113151806.17854-2-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:18:06PM +0800, Leo Yan wrote:
> perf with CoreSight fails to record trace data with command:
> 
>   perf record -e cs_etm/@tmc_etr0/u --per-thread ls
>   failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
>   directory)/perf/
> 
> This failure is root caused with the commit 1dc925568f01 ("perf
> parse: Add a deep delete for parse event terms").
> 
> The log shows, cs_etm fails to parse the sink attribution; cs_etm event
> relies on the event configuration to pass sink name, but the event
> specific configuration data cannot be passed properly with flow:
> 
>   get_config_terms()
>     ADD_CONFIG_TERM(DRV_CFG, term->val.str);
>       __t->val.str = term->val.str;
>         `> __t->val.str is assigned to term->val.str;
> 
>   parse_events_terms__purge()
>     parse_events_term__delete()
>       zfree(&term->val.str);
>         `> term->val.str is freed and assigned to NULL pointer;
> 
>   cs_etm_set_sink_attr()
>     sink = __t->val.str;
>       `> sink string has been freed.
> 
> To fix this issue, in the function get_config_terms(), this patch
> changes to use strdup() for allocation a new duplicate string rather
> than directly assignment string pointer.
> 
> This patch addes a new field 'free_str' in the data structure
> perf_evsel_config_term; 'free_str' is set to true when the union is used
> as a string pointer; thus it can tell perf_evsel__free_config_terms() to
> free the string.
> 
> Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

with that checkpatch changes

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

