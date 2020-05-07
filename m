Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1B4C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6EC20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQMyzljK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEGPTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:19:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbgEGPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588864771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cStW6qIKyhYd/UHlHbB5Zz+wLlj28FxKEQuFmjwQOS8=;
        b=SQMyzljK4Uz0xQTNUmkoulc27aQTli0YHYiDXhYA+tqSVwbWmnzx9iZ+FRiNj2MES/QXut
        WUOwlodXxcYJo2RJhmxLo35jv6yrNtHipbsYVVPT5eJeHWRGAu2rBcVceM8FxJ/eA+ZJu4
        axCwHkTyEP/Now04XjqJg3qBQl4oZU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-QNQvlEAyOz6hTrzlOTvZkA-1; Thu, 07 May 2020 11:19:25 -0400
X-MC-Unique: QNQvlEAyOz6hTrzlOTvZkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0095F835B41;
        Thu,  7 May 2020 15:19:24 +0000 (UTC)
Received: from krava (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D08E41053B1C;
        Thu,  7 May 2020 15:19:21 +0000 (UTC)
Date:   Thu, 7 May 2020 17:19:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/4] perf stat: Fix wrong per-thread runtime stat for
 interval mode
Message-ID: <20200507151919.GE2804092@krava>
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
 <20200507065822.8255-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507065822.8255-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 02:58:19PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e0c1ad23c768..97ee941649e6 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -351,6 +351,16 @@ static void read_counters(struct timespec *rs)
>  	}
>  }
>  
> +static void thread_stats_reset(struct perf_stat_config *config)
> +{
> +	int i;
> +
> +	if (config->stats) {
> +		for (i = 0; i < config->stats_num; i++)
> +			perf_stat__reset_shadow_per_stat(&config->stats[i]);
> +	}
> +}
> +
>  static void process_interval(void)
>  {
>  	struct timespec ts, rs;
> @@ -359,6 +369,7 @@ static void process_interval(void)
>  	diff_timespec(&rs, &ts, &ref_time);
>  
>  	perf_stat__reset_shadow_per_stat(&rt_stat);
> +	thread_stats_reset(&stat_config);

can't you call in here perf_stat__reset_stats?

and if not, I know it's threads related, but new
and delete functions are:

  runtime_stat_new, runtime_stat_delete

so let's call it runtime_stat_reset and place it next to
the new/delete functions

other than that it looks ok, thanks

jirka

>  	read_counters(&rs);
>  
>  	if (STAT_RECORD) {
> -- 
> 2.17.1
> 

