Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2138BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2E22100A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkkJRoHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgHaIn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:43:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbgHaIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598863437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4K8rXeyJc2+QDNAjPYsrpXyE/fuhyVNVpHCkaWg2ME=;
        b=bkkJRoHQAnMONuoWZQ/JTdSeRxKdcDhVvWm/vYGYgIUQz4uXUihUA02anXHPzvMdTtFHuP
        Yuo6XISkaOXok+23y1pePxV/54oRPDYGY+aKGSirVRyOJp7NjCWxStfsqL8pknHydCLmB4
        DSRhbNco6j9gS0FfcSp1cUnHm02dzAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-tB9Ocn1rO9CHbTbYSuByCA-1; Mon, 31 Aug 2020 04:43:55 -0400
X-MC-Unique: tB9Ocn1rO9CHbTbYSuByCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 673B21DDEC;
        Mon, 31 Aug 2020 08:43:53 +0000 (UTC)
Received: from krava (unknown [10.40.193.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id C8C2B19C4F;
        Mon, 31 Aug 2020 08:43:49 +0000 (UTC)
Date:   Mon, 31 Aug 2020 10:43:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
Subject: Re: [PATCH v6 1/5] perf/jevents: Remove jevents.h file
Message-ID: <20200831084348.GB287892@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827130958.189146-2-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 06:39:54PM +0530, Kajol Jain wrote:
> This patch removes jevents.h file and add its data inside
> jevents.c as this file is only included there.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c |  9 ++++++++-
>  tools/perf/pmu-events/jevents.h | 23 -----------------------
>  2 files changed, 8 insertions(+), 24 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/jevents.h
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..1c55cc754b5a 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -48,11 +48,18 @@
>  #include <linux/list.h>
>  #include "jsmn.h"
>  #include "json.h"
> -#include "jevents.h"
>  
>  int verbose;
>  char *prog;
>  
> +#ifndef min
> +#define min(x, y) ({				\
> +	typeof(x) _min1 = (x);			\
> +	typeof(y) _min2 = (y);			\
> +	(void)(&_min1 == &_min2);		\
> +	_min1 < _min2 ? _min1 : _min2; })
> +#endif
> +
>  int eprintf(int level, int var, const char *fmt, ...)
>  {
>  
> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> deleted file mode 100644
> index 2afc8304529e..000000000000
> --- a/tools/perf/pmu-events/jevents.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef JEVENTS_H
> -#define JEVENTS_H 1
> -
> -int json_events(const char *fn,
> -		int (*func)(void *data, char *name, char *event, char *desc,
> -				char *long_desc,
> -				char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint),
> -		void *data);
> -char *get_cpu_str(void);

I think you can also remove get_cpu_str from jevents.c

thanks,
jirka

