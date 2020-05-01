Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E0EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B5A206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bruWqAV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgEAKfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:35:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51930 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728480AbgEAKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588329338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OqHx7iDK3IDohyL5HkuoHy2U+Gi9sQA0K9QupO9Uyl8=;
        b=bruWqAV3dVC/kfi6g9lyBXdN3KjnvwB4xhmouHKv3p7drA4DZbhbdHUQlD7Jc/g/tttYdc
        ThiKvkek0xTfWTZqcqTw677heAIwm+QNmMOGvoOQ5s9SpMIQS4Z5VbMWXYhyKX20KqNhZP
        1oZrgI3riGLdOcEEha3uxraaMYZY5M0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-bgsIW4lAPO66zbnxx2YIkA-1; Fri, 01 May 2020 06:35:29 -0400
X-MC-Unique: bgsIW4lAPO66zbnxx2YIkA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C98871227;
        Fri,  1 May 2020 10:35:26 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7FC95D9CA;
        Fri,  1 May 2020 10:35:21 +0000 (UTC)
Date:   Fri, 1 May 2020 12:35:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 00/12] perf metric fixes and test
Message-ID: <20200501103519.GB1789042@krava>
References: <20200430075144.132716-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:51:32AM -0700, Ian Rogers wrote:
> Add a test that all perf metrics (for your architecture) are parsable
> with the simple expression parser. Attempt to parse all events in
> metrics but only fail if the metric is for the current CPU. Fix bugs
> in the expr parser, x86 and powerpc metrics. Improve debug messages
> around add PMU config term failures.
> 
> v3 adds parse event testing of ids and improves debug messages for add
>   PMU. These messages are paticular visible with 'perf test 10
>   -vvv'. It moves the testing logic from tests/expr.c to
>   tests/pmu-events.c as suggested by John Garry
>   <john.garry@huawei.com>.  
> v2 adds Fixes tags to commit messages for when broken metrics were
>   first added. Adds a debug warning for division by zero in expr, and
>   adds a workaround for id values in the expr test necessary for
>   powerpc. It also fixes broken power8 and power9 metrics.
> 
> Ian Rogers (12):
>   perf expr: unlimited escaped characters in a symbol
>   perf metrics: fix parse errors in cascade lake metrics
>   perf metrics: fix parse errors in skylake metrics
>   perf expr: allow ',' to be an other token
>   perf expr: increase max other
>   perf expr: parse numbers as doubles
>   perf expr: debug lex if debugging yacc
>   perf metrics: fix parse errors in power8 metrics
>   perf metrics: fix parse errors in power9 metrics
>   perf expr: print a debug message for division by zero
>   perf parse-events: expand add PMU error/verbose messages
>   perf test: improve pmu event metric testing

this does not apply on top of changes from Kajol Jain
which are now in Arnaldo's perf/core.. could you please
rebase?

thanks,
jirka

