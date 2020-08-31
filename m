Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726E8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AE320936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0tcziNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHaJLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgHaJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598865104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfpC+AqfnpGwHjV0xVxdR1qwCrWSqJH9ydS92LDsoRI=;
        b=E0tcziNVygCsZMmHTsGvvhE7F/TH1OtOAMWaIbApwU+QvJIQFsCFHmz7T7LSO04/Os/BCO
        edhnLsg1W4wQzQ5paZGfcAE5aUji/DgStYxkto5zElfrQoJEipOdwdxMfyDCCkAHIWtQ5i
        2kl9AkSGxYs+Ts+EKNwDWPZWYKMAWAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-z0pltVqoNKGm9qCJLdt-fg-1; Mon, 31 Aug 2020 05:11:42 -0400
X-MC-Unique: z0pltVqoNKGm9qCJLdt-fg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4753D18A0F14;
        Mon, 31 Aug 2020 09:11:40 +0000 (UTC)
Received: from krava (unknown [10.40.193.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id 110DB1002D4A;
        Mon, 31 Aug 2020 09:11:34 +0000 (UTC)
Date:   Mon, 31 Aug 2020 11:11:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH v2 5/9] libperf: Add support for user space counter access
Message-ID: <20200831091134.GC406859@krava>
References: <20200828205614.3391252-1-robh@kernel.org>
 <20200828205614.3391252-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828205614.3391252-6-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:56:10PM -0600, Rob Herring wrote:

SNIP

>  
> +void *perf_evsel__mmap(struct perf_evsel *evsel)
> +{
> +	int ret;
> +	struct perf_mmap *map;
> +	struct perf_mmap_param mp = {
> +		.mask = -1,
> +		.prot = PROT_READ | PROT_WRITE,
> +	};
> +
> +	if (FD(evsel, 0, 0) < 0)
> +		return NULL;
> +
> +	map = zalloc(sizeof(*map));
> +	if (!map)
> +		return NULL;
> +
> +	perf_mmap__init(map, NULL, false, NULL);
> +
> +	ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
> +	if (ret) {
> +		free(map);
> +		return NULL;
> +	}
> +
> +	evsel->mmap = map;
> +	return map->base;
> +}

so this only maps first page, I think we should use different
name and keep perf_evsel__mmap for some generic map with size

perf_evsel__mmap_user
perf_evsel__mmap_zero
...?

not sure.. or we could add size argument

jirka

