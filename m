Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721EAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F63A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjUh+yhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgENIV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:21:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50792 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589444486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kl5WghKFSG6qiDX0jxtO9H3IVeWRyQCZbxGFzfUqkBA=;
        b=YjUh+yhZhiKR50VPXLBMGO7kB+onXkSnOgtXyKnTg3Gj6djof0KKgLk/VgtWqgdfsg7ceS
        3jaOEsiPYnhxFk4XDizG7X1Tp+LttAtMh5kl0zbRO9kXOhpAErjL95EMiaPTie+GH9RR9s
        +AgwM/hn3E2eUY/HZOiXdryYtcMoQTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-fa97e8jhMy6zV-MXNWQHQA-1; Thu, 14 May 2020 04:21:22 -0400
X-MC-Unique: fa97e8jhMy6zV-MXNWQHQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24EF2107ACCA;
        Thu, 14 May 2020 08:21:20 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id A98B35C1BE;
        Thu, 14 May 2020 08:21:16 +0000 (UTC)
Date:   Thu, 14 May 2020 10:21:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf parse-events: Make add PMU verbose output clearer
Message-ID: <20200514082115.GI3343750@krava>
References: <20200513220635.54700-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513220635.54700-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:06:35PM -0700, Ian Rogers wrote:

SNIP

> found event unc_iio_data_req_of_cpu.mem_read.part3
> adding {unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.mem_read.part3}:W,{unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.mem_read.part3}:W
> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> Attempting to add event pmu 'uncore_iio_free_running_5' with 'unc_iio_data_req_of_cpu.mem_read.part0,' that may result in non-fatal errors
> After aliases, add event pmu 'uncore_iio_free_running_5' with 'fc_mask,ch_mask,umask,event,' that may result in non-fatal errors
> Attempting to add event pmu 'uncore_iio_free_running_3' with 'unc_iio_data_req_of_cpu.mem_read.part0,' that may result in non-fatal errors
> After aliases, add event pmu 'uncore_iio_free_running_3' with 'fc_mask,ch_mask,umask,event,' that may result in non-fatal errors
> Attempting to add event pmu 'uncore_iio_free_running_1' with 'unc_iio_data_req_of_cpu.mem_read.part0,' that may result in non-fatal errors
> After aliases, add event pmu 'uncore_iio_free_running_1' with 'fc_mask,ch_mask,umask,event,' that may result in non-fatal errors
> Multiple errors dropping message: unknown term 'fc_mask' for pmu 'uncore_iio_free_running_3' (valid terms: event,umask,config,config1,config2,name,period,percore)
> ...
> 
> So before you see a 'WARNING: multiple event parsing errors' and
> 'Invalid event/parameter'. After you see 'Attempting... that may result
> in non-fatal errors' then 'Multiple errors...' with details that
> 'fc_mask' wasn't known to a free running counter. While not completely
> clean, this makes it clearer that an error hasn't really occurred.
> 
> v2. addresses review feedback from Jiri Olsa <jolsa@redhat.com>.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

