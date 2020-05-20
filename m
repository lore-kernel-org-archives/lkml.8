Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43463C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8F320823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilGfguO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgETKyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:54:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42383 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726403AbgETKyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589972053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljb9uYn19Zb7PHGQwBgUJYiH+xerA6KnBpc1W2jqFTo=;
        b=ilGfguO8kcdLDk5xj4YzAqyXLzoDd4I1qa4dt/DYir19M9jCqXUW0KG7J5KuMT/HTaH4bz
        PNsOWzrxdmvT5I6CgSVbvxlhs9dzqM4Jhdr/DvasgwRN1tpr2EzbMkQX8ER6Lix7m/zTnI
        MNs4jUDUUCi3ir53WZklyP8ZSRLvl9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-RiRqYzHaPFGzDoaP4MAyrA-1; Wed, 20 May 2020 06:54:11 -0400
X-MC-Unique: RiRqYzHaPFGzDoaP4MAyrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F833800053;
        Wed, 20 May 2020 10:54:10 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0B3135C1D0;
        Wed, 20 May 2020 10:54:06 +0000 (UTC)
Date:   Wed, 20 May 2020 12:54:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 0/5] perf stat: Support overall statistics for
 interval mode
Message-ID: <20200520105406.GB157452@krava>
References: <20200520042737.24160-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520042737.24160-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:27:32PM +0800, Jin Yao wrote:
> Currently perf-stat supports to print counts at regular interval (-I),
> but it's not very easy for user to get the overall statistics.
> 
> With this patchset, it supports to report the summary at the end of
> interval output.
> 
> For example,
> 
>  root@kbl-ppc:~# perf stat -e cycles -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000412064          2,281,114      cycles
>       2.001383658          2,547,880      cycles
> 
>   Performance counter stats for 'system wide':
> 
>           4,828,994      cycles
> 
>         2.002860349 seconds time elapsed
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000389902          1,536,093      cycles
>       1.000389902            420,226      instructions              #    0.27  insn per cycle
>       2.001433453          2,213,952      cycles
>       2.001433453            735,465      instructions              #    0.33  insn per cycle
> 
>   Performance counter stats for 'system wide':
> 
>           3,750,045      cycles
>           1,155,691      instructions              #    0.31  insn per cycle
> 
>         2.003023361 seconds time elapsed
> 
>  root@kbl-ppc:~# perf stat -M CPI,IPC -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000435121            905,303      inst_retired.any          #      2.9 CPI
>       1.000435121          2,663,333      cycles
>       1.000435121            914,702      inst_retired.any          #      0.3 IPC
>       1.000435121          2,676,559      cpu_clk_unhalted.thread
>       2.001615941          1,951,092      inst_retired.any          #      1.8 CPI
>       2.001615941          3,551,357      cycles
>       2.001615941          1,950,837      inst_retired.any          #      0.5 IPC
>       2.001615941          3,551,044      cpu_clk_unhalted.thread
> 
>   Performance counter stats for 'system wide':
> 
>           2,856,395      inst_retired.any          #      2.2 CPI
>           6,214,690      cycles
>           2,865,539      inst_retired.any          #      0.5 IPC
>           6,227,603      cpu_clk_unhalted.thread
> 
>         2.003403078 seconds time elapsed
> 
>  v6:
>  ---
>  1. Add comments in perf_evlist__save_aggr_prev_raw_counts.
>  2. Move init_stats(&walltime_nsecs_stats) under interval condition check.
> 
>  Following patches are changed in v6.
>     perf stat: Save aggr value to first member of prev_raw_counts
>     perf stat: Report summary for interval mode

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

