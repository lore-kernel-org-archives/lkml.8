Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64869C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AA62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyUt0QfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgBJMIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:08:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727640AbgBJMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581336449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4M76XTB9sAOomIvEeEdwDoPllW+ZIvVf68kWvwXXC6A=;
        b=dyUt0QfMtlOjqINznMdXx59Xokm/soDAxHdbH3BnQw7lcyIbwn4H8AAGjVajxbsmxf7qPj
        u9Q7aoR1cwe9M1JPS23X7aczjoDhhY8w1HbEu5PcvPmEbUg6y1APKP4FdTZG+TfCKwjWAt
        Q2tpEgXMLjXgg5JM0LK/fpCsU49UM1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-YSv7_ONjOOiohpLZfF_7Qg-1; Mon, 10 Feb 2020 07:07:25 -0500
X-MC-Unique: YSv7_ONjOOiohpLZfF_7Qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20659477;
        Mon, 10 Feb 2020 12:07:23 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 521CD5C1D4;
        Mon, 10 Feb 2020 12:07:17 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:07:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 4/7] perf pmu: Rename uncore symbols to include
 system PMUs
Message-ID: <20200210120715.GC1907700@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579876505-113251-5-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:35:02PM +0800, John Garry wrote:

SNIP

>  		/* Only split the uncore group which members use alias */
> -		if (!evsel->use_uncore_alias)
> +		if (!evsel->use_uncore_or_system_alias)
>  			goto out;
>  
>  		/* The events must be from the same uncore block */
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8b99fd312aae..569aba4cec89 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -623,7 +623,7 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
>  	return NULL;
>  }
>  
> -static bool pmu_is_uncore(const char *name)
> +static bool pmu_is_uncore_or_sys(const char *name)

so we detect uncore PMU by checking for cpumask file

I don't see the connection here with the sysid or '_sys' checking,
that's just telling which ID to use when looking for an alias, no?
shouldn't that be separated?

jirka

