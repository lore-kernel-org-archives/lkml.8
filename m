Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F1EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E312078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIKNSfD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHZPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:54:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34410 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726803AbgHZPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598457289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rj3yRvfO9+lX66rFGH3OmR+ew75YBPEa+QrnmV2WCI8=;
        b=XIKNSfD15Uk54Lo+Nw/FWuEJw3USQnGJutuyCXBOFeFNTHPDBQFcv3Nml0ZUzlBKk5d/MZ
        ByTkQEUpd/ZqBZopRlCAymi39JpE4ygn1ml7xEgLLXN/yhJmw8bPWrzbDVh/B/Vgct0fau
        kEhdPqK9v+7ZU5Fszd9blvHMsGha5A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-YKA-DGg6MqmtGY9OvzxmxA-1; Wed, 26 Aug 2020 11:54:45 -0400
X-MC-Unique: YKA-DGg6MqmtGY9OvzxmxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50650425D3;
        Wed, 26 Aug 2020 15:54:44 +0000 (UTC)
Received: from krava (unknown [10.40.192.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7AE105C1C2;
        Wed, 26 Aug 2020 15:54:42 +0000 (UTC)
Date:   Wed, 26 Aug 2020 17:54:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH 0/4] TopDown metrics support for Ice Lake (perf tool)
Message-ID: <20200826155441.GA783610@krava>
References: <20200820164532.8011-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820164532.8011-1-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:45:28AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The kernel patches have been merged into the tip's perf/core branch.
> The patch set is on top of commit 2cb5383b30d4 ("perf/x86/intel: Support
> per-thread RDPMC TopDown metrics") of the tip's perf/core branch.
> 
> The changes for the perf tool include:
> - Extend --topdown option to support per thread TopDown metrics
> - Support sample-read topdown metric group
> - Add a complete document for the TopDown usage.
> 
> Ice Lake has support for measuring the level 1 TopDown metrics
> directly in hardware. This is implemented by an additional METRICS
> register, and a new Fixed Counter 3 that measures pipeline SLOTS.
> 
> New in Icelake
> - Do not require generic counters. This allows to collect TopDown always
>   in addition to other events.
> - Measuring TopDown per thread/process instead of only per core
> 
> For the Ice Lake implementation of performance metrics, the values in
> PERF_METRICS MSR are derived from fixed counter 3. Software should start
> both registers, PERF_METRICS and fixed counter 3, from zero.
> Additionally, software is recommended to periodically clear both
> registers in order to maintain accurate measurements. The latter is
> required for certain scenarios that involve sampling metrics at high
> rates. Software should always write fixed counter 3 before write to
> PERF_METRICS.
> 
> IA32_PERF_GLOBAL_STATUS. OVF_PERF_METRICS[48]: If this bit is set,
> it indicates that some PERF_METRICS-related counter has overflowed and
> a PMI is triggered. Software has to synchronize, e.g. re-start,
> PERF_METRICS as well as fixed counter 3. Otherwise, PERF_METRICS may
> return invalid values.
> 
> Limitation
> - To get accurate result and avoid reading the METRICS register multiple
>   times, the TopDown metrics events and SLOTS event have to be in the
>   same group.
> - METRICS and SLOTS registers have to be cleared after each read by SW.
>   That is to prevent the lose of precision.
> - Cannot do sampling read SLOTS and TopDown metric events
> 
> Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
> TopDown metrics.
> 
> Andi Kleen (2):
>   perf stat: Support new per thread TopDown metrics
>   perf, tools: Add documentation for topdown metrics
> 
> Kan Liang (2):
>   perf tools: Rename group to topdown
>   perf record: Support sample-read topdown metric group

I don't have Ice lake to actualy check, but it looks good

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

