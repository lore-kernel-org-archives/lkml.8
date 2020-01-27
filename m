Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71988C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BBE206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3Kt9i3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgA0MbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:31:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729801AbgA0MbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580128282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAnLNIAG1HbXrAdqHTG2NFjfY/aBl0jW6qpN4f74QF4=;
        b=I3Kt9i3ZmW7j/9LKjNK2bZXgUYV3IfeWOWGj3ow6UK2xyyBiD89TDZp+4FUss/JLLAiUCk
        n+JgGMzpsAQOXR09Vra7AA3tpCezREuW9uE+YEw5TI7E/f905xAWj7SkBsoTXVGdP9OJfj
        T2H0XO60G4Qi56vULdEWN7Vzi+8WtWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-61GjJgf0OiuHdPJRgJqX5Q-1; Mon, 27 Jan 2020 07:31:17 -0500
X-MC-Unique: 61GjJgf0OiuHdPJRgJqX5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D651613E1;
        Mon, 27 Jan 2020 12:31:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 956628E60E;
        Mon, 27 Jan 2020 12:31:10 +0000 (UTC)
Date:   Mon, 27 Jan 2020 13:31:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, gengdongjiu@huawei.com,
        wxf.wang@hisilicon.com, liwei391@huawei.com,
        liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 5/7] perf tools: add perf_evlist__terminate() for
 terminate
Message-ID: <20200127123108.GC1114818@krava>
References: <20200123160734.3775-1-james.clark@arm.com>
 <20200123160734.3775-6-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123160734.3775-6-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 04:07:32PM +0000, James Clark wrote:
> From: Wei Li <liwei391@huawei.com>
> 
> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
> be set and the event list will be disabled by perf_evlist__disable()
> once.
> 
> While in auxtrace_record.read_finish(), the related events will be
> enabled again, if they are continuous, the recording seems to be endless.
> 
> Mark the evlist's state as terminated, preparing for the following fix.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> Tested-by: Qi Liu <liuqi115@hisilicon.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c |  1 +
>  tools/perf/util/evlist.c    | 14 ++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  tools/perf/util/evsel.h     |  1 +
>  4 files changed, 17 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4c301466101b..e7c917f9534d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1722,6 +1722,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		if (done && !disabled && !target__none(&opts->target)) {
>  			trigger_off(&auxtrace_snapshot_trigger);
>  			evlist__disable(rec->evlist);
> +			evlist__terminate(rec->evlist);
>  			disabled = true;
>  		}
>  	}
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index b9c7e5271611..b04794cd8586 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -377,6 +377,20 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
>  	return true;
>  }
>  
> +void evlist__terminate(struct evlist *evlist)
> +{
> +	struct evsel *pos;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
> +			continue;
> +		evsel__disable(pos);
> +		pos->terminated = true;
> +	}

how is this different from evlist__disable? other than it does not
follow the cpu affinity ;-) can't you just call evlist__disable and
check later on evlist->enabled instead of evlist->terminated?

jirka

