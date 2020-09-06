Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5817C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B3120C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffu/pVsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgIFMnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:43:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26717 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728726AbgIFMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 08:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599396103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gA3ScU2VHrm7tZuhTSqaYwZlHEEedoUK+tPKPRBeWJg=;
        b=Ffu/pVsmXEl9oSqb1vOFwac8KwafegxLRJoOPmOGTR3TMzPkQIpgdNCMmJQ34CmRPgzWae
        dBbqwXwqPcBeRf89MVmRS3kEF/iy1CMsbXRbzFg54Pb1f3PKVxFC975wWkY3wUDjCatBi9
        EyggqJLZGPP91CAG1Y6j7+QJ5i2zfNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-5DA4mAPqMae1IiAnNNP5CA-1; Sun, 06 Sep 2020 08:41:39 -0400
X-MC-Unique: 5DA4mAPqMae1IiAnNNP5CA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 960C118A224E;
        Sun,  6 Sep 2020 12:41:37 +0000 (UTC)
Received: from krava (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id A6EF03A40;
        Sun,  6 Sep 2020 12:41:34 +0000 (UTC)
Date:   Sun, 6 Sep 2020 14:41:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 2/2] perf metric: Fix some memory leaks - part 2
Message-ID: <20200906124133.GB1199773@krava>
References: <20200905021912.621388-1-namhyung@kernel.org>
 <20200905021912.621388-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905021912.621388-2-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 11:19:12AM +0900, Namhyung Kim wrote:
> The metric_event_delete() missed to free expr->metric_events and it
> should free an expr when metric_refs allocation failed.
> 
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Fixes: 4ea2896715e67 ("perf metric: Collect referenced metrics in struct metric_expr")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/metricgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index af664d6218d6..b28c09447c10 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -85,6 +85,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
>  
>  	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
>  		free(expr->metric_refs);
> +		free(expr->metric_events);
>  		free(expr);
>  	}
>  
> @@ -316,6 +317,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  			if (!metric_refs) {
>  				ret = -ENOMEM;
>  				free(metric_events);
> +				free(expr);
>  				break;
>  			}
>  
> -- 
> 2.28.0.526.ge36021eeef-goog
> 

