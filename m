Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB58C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7EB20866
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6xLMitE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgHZLCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbgHZK5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598439434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgLSMjRHWPLLE0TzbEBLz1QQLMzRlMx2WrSWoJBXSIA=;
        b=J6xLMitEESkJv+PdUTfXtmH7Bogfq9vf++W/DBpRO43OByXAi3VeAFMpniid3s8Daw35Jf
        ne7So6/bOaq6h8BLQE8cYDN4GtLN0RnDHQEYVTFgMXKnAkpYVx15s34rJ72JQPNsD43RFb
        I9olbRabbYlaBWq5EVflFkslRkNevA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-zLsQ7xhKOae5M5-YPU7uIA-1; Wed, 26 Aug 2020 06:57:10 -0400
X-MC-Unique: zLsQ7xhKOae5M5-YPU7uIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B64189E602;
        Wed, 26 Aug 2020 10:57:08 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE8271002D42;
        Wed, 26 Aug 2020 10:57:06 +0000 (UTC)
Date:   Wed, 26 Aug 2020 12:57:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Message-ID: <20200826105705.GD703542@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> index 2afc8304529e..e696edf70e9a 100644
> --- a/tools/perf/pmu-events/jevents.h
> +++ b/tools/perf/pmu-events/jevents.h
> @@ -2,14 +2,28 @@
>  #ifndef JEVENTS_H
>  #define JEVENTS_H 1
>  
> +#include "pmu-events.h"
> +
> +struct json_event {
> +	char *name;
> +	char *event;
> +	char *desc;
> +	char *topic;
> +	char *long_desc;
> +	char *pmu;
> +	char *unit;
> +	char *perpkg;
> +	char *metric_expr;
> +	char *metric_name;
> +	char *metric_group;
> +	char *deprecated;
> +	char *metric_constraint;
> +};
> +
>  int json_events(const char *fn,
> -		int (*func)(void *data, char *name, char *event, char *desc,
> -				char *long_desc,
> -				char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint),
> -		void *data);
> +		int (*func)(void *data, struct json_event *je),
> +			void *data);

please also add typedef for the function,
it's used in other places as well

thanks,
jirka

