Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548EEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2721220702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfbsiiPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgA0Mbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:31:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729081AbgA0Mbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580128292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1hhEdcDWCEgGN0YrQx/xF84TmWOWm/XDVRZuqvlPeOI=;
        b=JfbsiiPNDqlc02HG5vHt43/sRsb7/cCU59wRNbHZaLbcYEAlaM58nb+dagt9LeSvNEy11i
        6l76cqnODbwJeA0IL95uUGW7kd6vrjrTc2/42ia4WhDe4VfyeBzt83UrrnKvbM+n/OLfBi
        PlNfQtTBgElSCMi6DGT1b5C8uLPfWaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-XumPK1NYNvKbzopPmVyKfg-1; Mon, 27 Jan 2020 07:31:28 -0500
X-MC-Unique: XumPK1NYNvKbzopPmVyKfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 001F31005510;
        Mon, 27 Jan 2020 12:31:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EBA98E60E;
        Mon, 27 Jan 2020 12:31:22 +0000 (UTC)
Date:   Mon, 27 Jan 2020 13:31:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, gengdongjiu@huawei.com,
        wxf.wang@hisilicon.com, liwei391@huawei.com,
        liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com,
        linux-perf-users@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 4/7] perf tools: Support "branch-misses:pp" on arm64
Message-ID: <20200127123120.GD1114818@krava>
References: <20200123160734.3775-1-james.clark@arm.com>
 <20200123160734.3775-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123160734.3775-5-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 04:07:31PM +0000, James Clark wrote:

SNIP

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1548237b6558..b9c7e5271611 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -9,6 +9,7 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <poll.h>
> +#include "arm-spe.h"
>  #include "cpumap.h"
>  #include "util/mmap.h"
>  #include "thread_map.h"
> @@ -179,6 +180,7 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
>  	struct evsel *evsel, *temp;
>  
>  	__evlist__for_each_entry_safe(list, temp, evsel) {
> +		arm_spe_precise_ip_support(evlist, evsel);

this is 'splice' function, you can't configure precise in here

do you need this 'config thing' to be executed on arm only?

if yes, please add something like arch_evsel__config, make it
weak for generic code and define it for arm

if no, just add the call at the end perf_evsel__config I guess

thanks,
jirka

>  		list_del_init(&evsel->core.node);
>  		evlist__add(evlist, evsel);
>  	}
> -- 
> 2.25.0
> 

