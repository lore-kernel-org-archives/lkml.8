Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEEDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E70D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaA5Gci+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgDPWX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:23:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgDPWX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587075837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=thP110RWC9V2lBT1UZm7pYYAB5Rx9MHjI99nftGtv50=;
        b=QaA5Gci+PB9H8ZwIlI1u+LNvorc9vFA7PQuSrffz7Cw+izhKyRUhc+mqoylGiwtrKa8Mhg
        90UG0ZA1g/Ilpgt4Uvy6ZWV1B5wdRmpwCZTWRCWNzaj8Di0vwqGVpAUhGoWUjtTd6wJ7x4
        xA/cl60n8C7ja62EYqsGPGtVq//8BMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-5SxAEzt4Pu-pjVS5qRoHKw-1; Thu, 16 Apr 2020 18:23:55 -0400
X-MC-Unique: 5SxAEzt4Pu-pjVS5qRoHKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 945F8107ACC9;
        Thu, 16 Apr 2020 22:23:54 +0000 (UTC)
Received: from krava (unknown [10.40.195.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2091311A023;
        Thu, 16 Apr 2020 22:23:52 +0000 (UTC)
Date:   Fri, 17 Apr 2020 00:22:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] perf parse: Avoid false uncore matches
Message-ID: <20200416222251.GC414900@krava>
References: <20200416162119.619956-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416162119.619956-1-andi@firstfloor.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:21:19AM -0700, Andi Kleen wrote:

SNIP

> ---
>  tools/perf/util/parse-events.y | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 94f8bcd83582..f38c90756476 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -286,7 +286,8 @@ PE_NAME opt_pmu_config
>  		parse_events_terms__delete(orig_terms);	\
>  		free(list);				\
>  		free($1);				\
> -		free(pattern);				\
> +		if ($1 != pattern)			\
> +			free(pattern);			\
>  		YYABORT;				\
>  	} while(0)
>  
> @@ -303,7 +304,9 @@ PE_NAME opt_pmu_config
>  		struct perf_pmu *pmu = NULL;
>  		int ok = 0;
>  
> -		if (asprintf(&pattern, "%s*", $1) < 0)
> +		if ($1[0] && isdigit($1[strlen($1) - 1]))
> +			pattern = $1;
> +		else if (asprintf(&pattern, "%s*", $1) < 0)
>  			CLEANUP_YYABORT;
>  
>  		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> @@ -320,6 +323,8 @@ PE_NAME opt_pmu_config
>  				parse_events_terms__delete(terms);
>  			}
>  		}
> +		if ($1 != pattern)
> +			free(pattern);

good catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

