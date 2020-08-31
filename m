Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97569C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E9A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gO5W+ccI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHaIoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:44:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40768 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727991AbgHaIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598863453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9/IB27HUtKQNfLVlcT5jcEAdeAeJQd1Pd87GKzR60g=;
        b=gO5W+ccIU3noNQYFQfytm9GDOuHuJjgBHuta2Rcp56t2RV7gdRiVQRu9uJVmr2iaZ7Y/Jd
        8WBH8Kxf8oEmT5Yd+1E/SrkYOHzL+hI1PD40dVl/m5I4J2cfwRU9j+6kjnbKIEMzeKSgFm
        UZ1icND2U7OstQCoQEHvOKMmBsB+YAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-JmmKUJYSMTKhCy6thK4wMw-1; Mon, 31 Aug 2020 04:44:11 -0400
X-MC-Unique: JmmKUJYSMTKhCy6thK4wMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9CFF1DDE0;
        Mon, 31 Aug 2020 08:44:08 +0000 (UTC)
Received: from krava (unknown [10.40.193.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id C70297EB75;
        Mon, 31 Aug 2020 08:44:05 +0000 (UTC)
Date:   Mon, 31 Aug 2020 10:44:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
Subject: Re: [PATCH v6 3/5] perf jevents: Add support for parsing
 perchip/percore events
Message-ID: <20200831084404.GD287892@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-4-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827130958.189146-4-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 06:39:56PM +0530, Kajol Jain wrote:
> Initially, every time we want to add new terms like chip, core thread etc,
> we need to create corrsponding fields in pmu_events and event struct.
> This patch adds an enum called 'aggr_mode_class' which store all these
> aggregation like perchip/percore. It also adds new field 'aggr_mode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c    | 16 ++++++++++++++++
>  tools/perf/pmu-events/pmu-events.h |  6 ++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index b205cd904a4f..f4ad2d403533 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -48,6 +48,7 @@
>  #include <linux/list.h>
>  #include "jsmn.h"
>  #include "json.h"
> +#include "pmu-events.h"
>  
>  int verbose;
>  char *prog;
> @@ -60,6 +61,7 @@ struct json_event {
>  	char *pmu;
>  	char *unit;
>  	char *perpkg;
> +	char *aggr_mode;
>  	char *metric_expr;
>  	char *metric_name;
>  	char *metric_group;
> @@ -74,6 +76,14 @@ struct json_event {
>  	(void)(&_min1 == &_min2);		\
>  	_min1 < _min2 ? _min1 : _min2; })
>  #endif

please add new line in here

> +enum aggr_mode_class convert(const char *aggr_mode)
> +{
> +	if (!strcmp(aggr_mode, "PerCore"))
> +		return PerCore;
> +	else if (!strcmp(aggr_mode, "PerChip"))
> +		return PerChip;
> +	return -1;

should we display some warning in here?

thanks,
jirka

