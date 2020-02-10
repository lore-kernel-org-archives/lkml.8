Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE62C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E911B2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwJxeGzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJMZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:25:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42371 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726796AbgBJMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581337520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8bOZtM38ft0UNzkfcKXCCm45plDuDA+WiWNvbXuXVks=;
        b=HwJxeGzE/OYw5mulHKaxc9fMbQ6UlDa7xIC9CCRUYSgdfvu6Pj+x/2hzJCYQAuGfC/mDDC
        XLgii+twnHO+He95baV4u2x/AiYpTVDAnB6SK7Clo8e+9civlTOvSMelwgx8vbXk9cyQsl
        kq0LWSX5P82+8UwWEcb74sBZw7dIZ/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-7misDm8vMPqaE4WoYJh8YQ-1; Mon, 10 Feb 2020 07:25:16 -0500
X-MC-Unique: 7misDm8vMPqaE4WoYJh8YQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE50107ACC5;
        Mon, 10 Feb 2020 12:25:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FC2B5C1D6;
        Mon, 10 Feb 2020 12:25:12 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:25:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     liwei391@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nd@arm.com,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 4/4] perf tools: Support "branch-misses:pp" on arm64
Message-ID: <20200210122509.GA2005279@krava>
References: <20200127123108.GC1114818@krava>
 <20200207152142.28662-1-james.clark@arm.com>
 <20200207152142.28662-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207152142.28662-5-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:21:42PM +0000, James Clark wrote:

SNIP

>  
>  #define ITRACE_HELP \
>  "				i:	    		synthesize instructions events\n"		\
> @@ -728,6 +729,11 @@ void auxtrace__free(struct perf_session *session __maybe_unused)
>  {
>  }
>  
> +static inline
> +void auxtrace__preprocess_evlist(struct evlist *evlist __maybe_unused)
> +{
> +}
> +
>  static inline
>  int auxtrace_index__write(int fd __maybe_unused,
>  			  struct list_head *head __maybe_unused)
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1548237b6558..84136d0adb29 100644
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
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index dc14f4a823cd..c212e2eeeeb2 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -174,7 +174,6 @@ void perf_evsel__exit(struct evsel *evsel);
>  void evsel__delete(struct evsel *evsel);
>  
>  struct callchain_param;
> -

hum? ;-)

jirka

>  void perf_evsel__config(struct evsel *evsel,
>  			struct record_opts *opts,
>  			struct callchain_param *callchain);
> -- 
> 2.17.1
> 

