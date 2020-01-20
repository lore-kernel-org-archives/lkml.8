Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99066C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D357207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHJe91Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATJ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:28:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgATJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579512535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iBlSiPbU11kx1FE6pEyiDrTybK6mV+iNStxOfr7SjY=;
        b=BHJe91Oskt/yxwTLU46DcrfT4WpuaeJ5TLP1VlGXg9BpOP+nJDvtnKMBBC4A+lKtD78q9M
        hAXss8J013T3As9D6DiEIWl9VN5ZLYF1Ey3HjmfMDrQUQ8GkYo1Iqv4JgfZ/pm0W54DBQB
        U63R/IsguV3l4IMDEz9ro2mZB4WlmkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-fHoWUM4WOTWhpkSy5ZLqjA-1; Mon, 20 Jan 2020 04:28:52 -0500
X-MC-Unique: fHoWUM4WOTWhpkSy5ZLqjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47A808017CC;
        Mon, 20 Jan 2020 09:28:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 295AF60C05;
        Mon, 20 Jan 2020 09:28:46 +0000 (UTC)
Date:   Mon, 20 Jan 2020 10:28:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf symbols: Update the list of kernel idle symbols
Message-ID: <20200120092844.GC608405@krava>
References: <20200115222949.7247-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115222949.7247-1-kim.phillips@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:29:48PM -0600, Kim Phillips wrote:
> "acpi_idle_do_entry", "acpi_processor_ffh_cstate_enter", and "idle_cpu"
> appear in 'perf top' output, at least on AMD systems.
> 
> Add them to perf's idle_symbols list, so they don't dominate 'perf top'
> output.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  tools/perf/util/symbol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3b379b1296f1..f3120c4f47ad 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -635,9 +635,12 @@ int modules__parse(const char *filename, void *arg,
>  static bool symbol__is_idle(const char *name)
>  {
>  	const char * const idle_symbols[] = {
> +		"acpi_idle_do_entry",
> +		"acpi_processor_ffh_cstate_enter",
>  		"arch_cpu_idle",
>  		"cpu_idle",
>  		"cpu_startup_entry",
> +		"idle_cpu",
>  		"intel_idle",
>  		"default_idle",
>  		"native_safe_halt",

ok, at some point we should put this in strlist ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com

thanks,
jirka

