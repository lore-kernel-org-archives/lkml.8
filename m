Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E47C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586DB20758
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjGOvu0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgGLS5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:57:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729222AbgGLSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594580152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOO24P1Kw1BazGoIMhHEgrfr+8DufTQryiwtvJAc0bM=;
        b=bjGOvu0Kfsp3o2Zoo7xbJS2q/F19+H4Ep/RobPPFgodS7tJTQGOGl4iVjhwHKTkEIPY+H/
        4Z6Hwla78mPjxT0Za988KUU9bFd+N5hkmoh272qwY57YlKtTprnayCbQHuBBbtm0y/vI/6
        UB1AAAR8yDY41TaSelbLgNXNhccQcyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-fr99_ehEPMy9FBiyT_xRDQ-1; Sun, 12 Jul 2020 14:55:50 -0400
X-MC-Unique: fr99_ehEPMy9FBiyT_xRDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9C57800FF1;
        Sun, 12 Jul 2020 18:55:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 515261CA;
        Sun, 12 Jul 2020 18:55:44 +0000 (UTC)
Date:   Sun, 12 Jul 2020 20:55:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
Subject: Re: [RFC v2 5/5] perf/tools/pmu_events/powerpc: Add hv_24x7 core
 level metric events
Message-ID: <20200712185543.GC147742@krava>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
 <20200707122314.624400-6-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707122314.624400-6-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:53:14PM +0530, Kajol Jain wrote:
> This patch adds hv_24x7 core level events in nest_metric.json file
> and also add PerChip/PerCore field in metric events.
> 
> Result:
> 
> power9 platform:
> 
> command:# ./perf stat --metric-only -M PowerBUS_Frequency -C 0 -I 1000
>      1.000070601                        1.9                        2.0
>      2.000253881                        2.0                        1.9
>      3.000364810                        2.0                        2.0
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  .../arch/powerpc/power9/nest_metrics.json       | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index c121e526442a..2a471cb5dd7a 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -3,17 +3,26 @@
>          "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
>          "MetricName": "Memory_RD_BW_Chip",
>          "MetricGroup": "Memory_BW",
> -        "ScaleUnit": "1.6e-2MB"
> +        "ScaleUnit": "1.6e-2MB",
> +	"AggregationMode": "PerChip"
>      },
>      {
>  	"MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
>          "MetricName": "Memory_WR_BW_Chip",
>          "MetricGroup": "Memory_BW",
> -        "ScaleUnit": "1.6e-2MB"
> +        "ScaleUnit": "1.6e-2MB",
> +	"AggregationMode": "PerChip"

please keep the same indentation, also below

jirka

>      },
>      {
>  	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
>          "MetricName": "PowerBUS_Frequency",
> -        "ScaleUnit": "2.5e-7GHz"
> -    }
> +        "ScaleUnit": "2.5e-7GHz",
> +	"AggregationMode": "PerChip"
> +    },
> +    {
> +	"MetricExpr": "(hv_24x7@CPM_CS_32MHZ_CYC\\,domain\\=3\\,core\\=?@ )",
> +        "MetricName": "CPM_CS_32MHZ_CYC",
> +        "ScaleUnit": "1MHz",
> +	"AggregationMode": "PerCore"
> +     }
>  ]
> -- 
> 2.26.2
> 

