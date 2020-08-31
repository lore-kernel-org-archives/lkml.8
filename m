Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F583C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFED82073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVI3Y4fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgHaIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:44:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30685 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727991AbgHaIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598863447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QL0aZteoG+qXnrJn3n8iMdhIMTVyPx3n7JIer6XMh3E=;
        b=cVI3Y4foD09rq74ouMJ2kCrnXw2drBEfv8ZxrdRnjCn3tgJYsiFdb1NGKSCcJNwvNSweej
        OJp6Dp66xp0RMxX2eNzXrk0uxcQmbjc4atswIQXzzTPI0icySHr40xjE59Bpzuvbmy5rAa
        AHSvMQ7C/4BcqC91nxQd7HZp4+Fhp0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-MvRVeGzpPv-Ncrj5sdNCIQ-1; Mon, 31 Aug 2020 04:44:03 -0400
X-MC-Unique: MvRVeGzpPv-Ncrj5sdNCIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DC438014D8;
        Mon, 31 Aug 2020 08:44:01 +0000 (UTC)
Received: from krava (unknown [10.40.193.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id 521C85D9D3;
        Mon, 31 Aug 2020 08:43:58 +0000 (UTC)
Date:   Mon, 31 Aug 2020 10:43:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
Subject: Re: [PATCH v6 2/5] perf/jevents: Add new structure to pass json
 fields.
Message-ID: <20200831084357.GC287892@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-3-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827130958.189146-3-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 06:39:55PM +0530, Kajol Jain wrote:

SNIP

> -	if (!*field)						\
> +#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
> +	je->field = strdup(es->field);				\
> +	if (!je->field)						\
>  		return -ENOMEM;					\
>  } } while (0)
>  
> @@ -428,11 +440,7 @@ static void free_arch_std_events(void)
>  	}
>  }
>  
> -static int save_arch_std_events(void *data, char *name, char *event,
> -				char *desc, char *long_desc, char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint)
> +static int save_arch_std_events(void *data, struct json_event *je)
>  {
>  	struct event_struct *es;
>  
> @@ -486,17 +494,16 @@ static char *real_event(const char *name, char *event)
>  		return NULL;
>  
>  	for (i = 0; fixed[i].name; i++)
> -		if (!strcasecmp(name, fixed[i].name))
> -			return (char *)fixed[i].event;
> +		if (!strcasecmp(name, fixed[i].name)) {
> +			strcpy(event, fixed[i].event);

hum what's this strcpy for in here? we're just replacing separated
variables with struct members, why do you need to copy the event in
here?

thanks,
jirka

