Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3D320672
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiXaajlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGCLKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:10:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725984AbgGCLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593774614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvVrEZd+9e1iWBtgYYnLv0ba/uEMSttTCVZCxWK/m/U=;
        b=PiXaajlDpac1SQ1Qv+rUHeEOQXjowjoSG4K901+dfvlE/T6OopTQLF+7HMhCdp81Q5YovE
        RpJXWCXLwJTr9olVMdr7ciOF8x1vL3DhEQAp1n3c6FmznW0huXDbGMQBBzWRvp6jUusBkq
        Lv1oDbeMSwnG4YRnxQk711kzUQ7LFcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-N_pq_x-bOEGzbdzhR0gwMg-1; Fri, 03 Jul 2020 07:10:10 -0400
X-MC-Unique: N_pq_x-bOEGzbdzhR0gwMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D212E107ACCD;
        Fri,  3 Jul 2020 11:10:08 +0000 (UTC)
Received: from krava (unknown [10.40.194.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id D26D35D9CA;
        Fri,  3 Jul 2020 11:10:06 +0000 (UTC)
Date:   Fri, 3 Jul 2020 13:10:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, guohanjun@huawei.com
Subject: Re: [PATCH] perf report TUI: Fix segmentation fault in
 perf_evsel__hists_browse()
Message-ID: <20200703111005.GB3282312@krava>
References: <20200612094322.39565-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612094322.39565-1-liwei391@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 05:43:22PM +0800, Wei Li wrote:
> The segmentation fault can be reproduced as following steps:
> 1) Executing perf report in tui.
> 2) Typing '/xxxxx' to filter the symbol to get nothing matched.
> 3) Pressing enter with no entry selected.
> Then it will report a segmentation fault.
> 
> It is caused by the lack of check of browser->he_selection when
> accessing it's member res_samples in perf_evsel__hists_browse().
> 
> These processes are meaningful for specified samples, so we can
> skip these when nothing is selected.
> 
> Fixes: 4968ac8fb7c3 ("perf report: Implement browsing of individual samples")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/ui/browsers/hists.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 487e54ef56a9..2101b6b770d8 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2288,6 +2288,11 @@ static struct thread *hist_browser__selected_thread(struct hist_browser *browser
>  	return browser->he_selection->thread;
>  }
>  
> +static struct res_sample *hist_browser__selected_res_sample(struct hist_browser *browser)
> +{
> +	return browser->he_selection ? browser->he_selection->res_samples : NULL;
> +}
> +
>  /* Check whether the browser is for 'top' or 'report' */
>  static inline bool is_report_browser(void *timer)
>  {
> @@ -3357,16 +3362,16 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>  					     &options[nr_options], NULL, NULL, evsel);
>  		nr_options += add_res_sample_opt(browser, &actions[nr_options],
>  						 &options[nr_options],
> -				 hist_browser__selected_entry(browser)->res_samples,
> -				 evsel, A_NORMAL);
> +						 hist_browser__selected_res_sample(browser),
> +						 evsel, A_NORMAL);
>  		nr_options += add_res_sample_opt(browser, &actions[nr_options],
>  						 &options[nr_options],
> -				 hist_browser__selected_entry(browser)->res_samples,
> -				 evsel, A_ASM);
> +						 hist_browser__selected_res_sample(browser),
> +						 evsel, A_ASM);
>  		nr_options += add_res_sample_opt(browser, &actions[nr_options],
>  						 &options[nr_options],
> -				 hist_browser__selected_entry(browser)->res_samples,
> -				 evsel, A_SOURCE);
> +						 hist_browser__selected_res_sample(browser),
> +						 evsel, A_SOURCE);
>  		nr_options += add_switch_opt(browser, &actions[nr_options],
>  					     &options[nr_options]);
>  skip_scripting:
> -- 
> 2.17.1
> 

