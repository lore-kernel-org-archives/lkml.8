Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F70C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4D4206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmSSWDGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgA0Mbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:31:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbgA0Mbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580128304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKjG1/5cA7SZH1QMU5AvJ91rZVjHPgjPOojbBcC6/cs=;
        b=hmSSWDGppddJFJzBL92IHyBLK7a6WMHErEPoGy/m+qe4qiRpbU6beFqML5InkD9QHjcpnX
        HlKc7uMd8kVkdsDyWvSVs7DWkO0Zppp/EIn2J4Ej8Fvnq0UWomGdUDS++EvArd48M4dJZR
        +WV3MBxhFrYWCK2Vb+tg3VXXSQRoZBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-7tc7XUzxOJe_owBE1WQQ9Q-1; Mon, 27 Jan 2020 07:31:39 -0500
X-MC-Unique: 7tc7XUzxOJe_owBE1WQQ9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6CEE8017CC;
        Mon, 27 Jan 2020 12:31:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EADC451F;
        Mon, 27 Jan 2020 12:31:32 +0000 (UTC)
Date:   Mon, 27 Jan 2020 13:31:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, gengdongjiu@huawei.com,
        wxf.wang@hisilicon.com, liwei391@huawei.com,
        liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com,
        linux-perf-users@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/7] perf tools: Add support for "report" for some spe
 events
Message-ID: <20200127123129.GE1114818@krava>
References: <20200123160734.3775-1-james.clark@arm.com>
 <20200123160734.3775-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123160734.3775-3-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 04:07:29PM +0000, James Clark wrote:

SNIP

> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 749d72cd9c7b..b47108599280 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -111,6 +111,22 @@ struct itrace_synth_opts {
>  	int			range_num;
>  };
>  
> +/**
> + * struct arm_spe_synth_opts - ARM SPE tracing synthesis options.
> + * @set: indicates whether or not options have been set
> + * @llc_miss: whether to synthesize last level cache miss events
> + * @tlb_miss: whether to synthesize TLB miss events
> + * @branch_miss: whether to synthesize Branch miss events
> + * @remote_access: whether to synthesize Remote access events
> + */
> +struct arm_spe_synth_opts {
> +	bool			set;
> +	bool			llc_miss;
> +	bool			tlb_miss;
> +	bool			branch_miss;
> +	bool			remote_access;

hum, why don't you add that to itrace_synth_opts instead? seems generic enough

I don't follow the code much, but I assume itrace_synth_opts is generic object,
as it's already used by some of the s390 and x86 code.. also I don't like new
pointer to synth_ops in perf_session

jirka

> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index f76480166d38..cee134d7643f 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -19,6 +19,7 @@ struct thread;
>  
>  struct auxtrace;
>  struct itrace_synth_opts;
> +struct arm_spe_synth_opts;
>  
>  struct perf_session {
>  	struct perf_header	header;
> @@ -26,6 +27,7 @@ struct perf_session {
>  	struct evlist	*evlist;
>  	struct auxtrace		*auxtrace;
>  	struct itrace_synth_opts *itrace_synth_opts;
> +	struct arm_spe_synth_opts *arm_spe_synth_opts;
>  	struct list_head	auxtrace_index;
>  	struct trace_event	tevent;
>  	struct perf_record_time_conv	time_conv;
> -- 
> 2.25.0
> 

