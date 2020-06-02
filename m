Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E795C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398E9207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591107006;
	bh=5kdWcRvjyQscoknTE3/+ligCbxi7dlo+MyoefG7KHJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qe5yJPFmAJoyOEzbqmM+FLr9Fu99cZJbVETBhJBvpAB6ohpsfKv3rwsx1ruc/Jb74
	 5kREI5P8vLUBStGi+ne68XDYbHIxlmi5Qk89WLcUNEDO6GyHDTP/nq3AeLrfGTLcIi
	 gZhMgDl4NpVA6hUGhbNZb95IwYcRkBWAHcR1RThU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgFBOKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBOKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:10:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD1F206E2;
        Tue,  2 Jun 2020 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591107004;
        bh=5kdWcRvjyQscoknTE3/+ligCbxi7dlo+MyoefG7KHJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGoNIc14TGzxGSo/15xBUc4QG/xmyGlKO6P5uk5ErbVyP7Fv3gC0HuiDd+aviFoYy
         N9Zau/QFkOIIptzOPY6xgFnQU8aqvdqrJNBks/8n1DCQO6juRouhsKRfPXSwL8SPwc
         RkLAlYzsmHoVycHtOInRoFwYL73GIwJHBXoQy8uk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F9D440AFD; Tue,  2 Jun 2020 11:10:02 -0300 (-03)
Date:   Tue, 2 Jun 2020 11:10:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/2] perf tools: Remove some duplicated includes
Message-ID: <20200602141002.GQ31795@kernel.org>
References: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
 <1591071304-19338-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591071304-19338-2-git-send-email-yangtiezhu@loongson.cn>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 02, 2020 at 12:15:04PM +0800, Tiezhu Yang escreveu:
> There exists some duplicated includes in tools/perf, remove them.

Applied, thanks.

- Arnaldo
 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/perf/builtin-report.c | 1 -
>  tools/perf/util/annotate.c  | 1 -
>  tools/perf/util/auxtrace.c  | 1 -
>  tools/perf/util/config.c    | 1 -
>  tools/perf/util/session.c   | 1 -
>  5 files changed, 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index ba63390..5425a2c 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -47,7 +47,6 @@
>  #include "util/time-utils.h"
>  #include "util/auxtrace.h"
>  #include "util/units.h"
> -#include "util/branch.h"
>  #include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
>  #include "ui/progress.h"
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index d828c2d..76bfb4a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -41,7 +41,6 @@
>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> -#include <bpf/libbpf.h>
>  #include <subcmd/parse-options.h>
>  #include <subcmd/run-command.h>
>  
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 749487a..94a8f4f 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -55,7 +55,6 @@
>  #include "util/mmap.h"
>  
>  #include <linux/ctype.h>
> -#include <linux/kernel.h>
>  #include "symbol/kallsyms.h"
>  #include <internal/lib.h>
>  
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index ef38eba..64f14a5 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -20,7 +20,6 @@
>  #include "build-id.h"
>  #include "debug.h"
>  #include "config.h"
> -#include "debug.h"
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <stdlib.h>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index c11d89e..5550e26e 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -33,7 +33,6 @@
>  #include "../perf.h"
>  #include "arch/common.h"
>  #include <internal/lib.h>
> -#include <linux/err.h>
>  
>  #ifdef HAVE_ZSTD_SUPPORT
>  static int perf_session__process_compressed_event(struct perf_session *session,
> -- 
> 2.1.0
> 

-- 

- Arnaldo
