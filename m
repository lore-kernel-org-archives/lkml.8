Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E070C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B53D20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayUKx1DQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgGLS5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:57:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729213AbgGLSzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594580143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gvQwPsnsRCqn4kWGkch6m+0YOusAqru2+mmFxXJuVBM=;
        b=ayUKx1DQOZ/mNhhltjBYro23yeI3/EuxzPV1hLKNx9Yvab0GibJhzUVidF1ttyEtRN0227
        i5U/RIoJY2C1XGHwO7kVqFXPij8mgrt2JG7tF5/sW1yUH9dZAlYTqhSX9xxy2NDrchMHl/
        0oNkqqaClOezS1JPexDkw8JCzUZNnek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-WXL2Tk6GNnmfjQtLWqmaFQ-1; Sun, 12 Jul 2020 14:55:41 -0400
X-MC-Unique: WXL2Tk6GNnmfjQtLWqmaFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D23AA1080;
        Sun, 12 Jul 2020 18:55:38 +0000 (UTC)
Received: from krava (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D4675D9D3;
        Sun, 12 Jul 2020 18:55:35 +0000 (UTC)
Date:   Sun, 12 Jul 2020 20:55:34 +0200
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
Subject: Re: [RFC v2 1/5] perf/pmu-events/jevents: Add enum to store
 aggregation like PerPkg
Message-ID: <20200712185534.GB147742@krava>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
 <20200707122314.624400-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707122314.624400-2-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:53:10PM +0530, Kajol Jain wrote:

SNIP

>  			}
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 93fe72a9dc0b..3cafbb320d68 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -306,7 +306,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>  static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  				 char *desc, char *val,
>  				 char *long_desc, char *topic,
> -				 char *unit, char *perpkg,
> +				 char *unit, char *aggr_mode,
>  				 char *metric_expr,
>  				 char *metric_name,
>  				 char *deprecated)
> @@ -378,7 +378,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  			return -1;
>  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>  	}
> -	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
> +	alias->per_pkg = aggr_mode && sscanf(aggr_mode, "%d", &num) == 1 && num == 1;

should you rather use 'num == PerPkg' instead 'num == 1' ?

jirka

