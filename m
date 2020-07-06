Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16816C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02D720771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu9C20Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgGFM6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:58:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54527 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729143AbgGFM6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594040286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j+KY02i6bUabbwozSGcjhNsCPf+3RwTXSSg6eC05zLE=;
        b=Zu9C20PwZ+vYXAUk+2rwaJY9xV7XjEahvdYk/FnlZGodufRgkVMZCFBI5zDSxNqT4Q17Eo
        41tVKq6kPKN4LL2LgHHclfwxjzEU0bV6K9Pq70HQQ6s38WkIbE92ZL2U2NAzzkFU/9RgzG
        mL5BJ9EWJ3Mbw2MthI9zkBg9Nek/vws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-XPNHzZXzNrij33CwAIhhZA-1; Mon, 06 Jul 2020 08:58:04 -0400
X-MC-Unique: XPNHzZXzNrij33CwAIhhZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D48878015F3;
        Mon,  6 Jul 2020 12:58:01 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54BE57B405;
        Mon,  6 Jul 2020 12:57:58 +0000 (UTC)
Date:   Mon, 6 Jul 2020 14:57:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [RFC 1/3] perf jevents: Add support for parsing perchip/percore
 events
Message-ID: <20200706125757.GA3424581@krava>
References: <20200625114718.229911-1-kjain@linux.ibm.com>
 <20200625114718.229911-2-kjain@linux.ibm.com>
 <CAP-5=fWG9rxObKJ38dQ=VUf3_mQbNDCTzgU1kkyw=9uVfBa+qw@mail.gmail.com>
 <512670c2-bb61-7c2f-68bc-7752499300c6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512670c2-bb61-7c2f-68bc-7752499300c6@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:50:28AM +0530, kajoljain wrote:

SNIP

>  ]
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..dd2b14cc147c 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -53,6 +53,23 @@
>  int verbose;
>  char *prog;
>  
> +enum event_class {
> +	PerChip = 0,
> +	PerPkg = 1,
> +	PerCore = 2
> +};

could you please split this into patch that changes perpkg
into the class type string and another that adds new PerChip/PerCore?

> +
> +enum event_class convert(const char* event_class_type) {
> +
> +	if (!strcmp(event_class_type, "PerCore"))
> +		return PerCore;
> +	else if (!strcmp(event_class_type, "PerChip"))
> +		return PerChip;
> +	else if (!strcmp(event_class_type, "PerPkg"))
> +		return PerPkg;
> +	return -1;
> +}
> +
>  int eprintf(int level, int var, const char *fmt, ...)
>  {
>  
> @@ -320,7 +337,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>  
>  static int print_events_table_entry(void *data, char *name, char *event,
>  				    char *desc, char *long_desc,
> -				    char *pmu, char *unit, char *perpkg,
> +				    char *pmu, char *unit, char *event_class_type,

maybe 'aggregation' or 'aggr_mode' would be better name than event_class_type?

thanks,
jirka

