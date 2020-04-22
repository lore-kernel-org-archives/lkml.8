Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAEEC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA81A2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiKywaJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgDVLli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:41:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55169 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725961AbgDVLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587555696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=an4GqdMcPxXVQzFDku1airXJ7n+SdoQGwHtPe0RDm3k=;
        b=hiKywaJKoQ00JimyUuyTYS3bRrslx+WNUDKk5CM4mLSIJYRzfEHw0ZmIHuO2yAJOZ5xUXp
        PcjJW8zibPs3M8uPcdZU93ZlmVHiiM0Q5XOD7BXmGHXwSE8RxX5/7X8Z63go1OyVV/woOw
        tNI1MjaE6C+fdb+enY6ZBBRFFBLlvDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-ISRUNEiqPdS2sQXWa87y5A-1; Wed, 22 Apr 2020 07:41:32 -0400
X-MC-Unique: ISRUNEiqPdS2sQXWa87y5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8AE0107ACCD;
        Wed, 22 Apr 2020 11:41:29 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BBC528988;
        Wed, 22 Apr 2020 11:41:25 +0000 (UTC)
Date:   Wed, 22 Apr 2020 13:41:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, irogers@google.com, robin.murphy@arm.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 07/13] perf pmu: Add pmu_id()
Message-ID: <20200422114122.GG962614@krava>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-8-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587120084-18990-8-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 06:41:18PM +0800, John Garry wrote:
> Add a function to read the PMU id sysfs entry. We only do it for uncore
> PMUs where this would be relevant.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/pmu.c | 36 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.h |  1 +
>  2 files changed, 37 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ef6a63f3d386..6a67c6a28d08 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -594,6 +594,7 @@ static struct perf_cpu_map *__pmu_cpumask(const char *path)
>   * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
>   * may have a "cpus" file.
>   */
> +#define CPUS_TEMPLATE_ID	"%s/bus/event_source/devices/%s/identifier"
>  #define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
>  #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
>  
> @@ -632,6 +633,39 @@ static bool pmu_is_uncore(const char *name)
>  	return file_available(path);
>  }
>  
> +static char *pmu_id(const char *name)
> +{
> +	char path[PATH_MAX], *id;
> +	const char *sysfs;
> +	FILE *file;
> +	int n;
> +
> +	sysfs = sysfs__mountpoint();
> +	snprintf(path, PATH_MAX, CPUS_TEMPLATE_ID, sysfs, name);
> +
> +	id = malloc(PATH_MAX);
> +	if (!id)
> +		return NULL;
> +
> +	file = fopen(path, "r");
> +	if (!file) {
> +		free(id);
> +		return NULL;
> +	}
> +
> +	n = fscanf(file, "%s", id);
> +
> +	fclose(file);
> +
> +	if (!n) {
> +		free(id);
> +		return NULL;
> +	}
> +
> +	return id;
> +}

I still need to go through this patchset in more detail,
but just quick note, that we have sysfs__read_str that you
could use in here

jirka

