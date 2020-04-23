Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BAC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCD320736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6bj9dPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDWL3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:29:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbgDWL3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587641372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ak2/xqcDfE6mCFXaoyYqstq84WV0bpXKw1y+hjWvB3w=;
        b=X6bj9dPqbSXl/miEYlZLxm1tfqxtzzNvawc5vExoLo54XyVTUC6+woCgID07jLPSawI6zj
        VK+5gw6+1KzFUJoZvUvVTjFL/ZqjAkH/TVxsc0QDNwS0psZAVSv1C6Nhwz0FaJy+pHiz9K
        exzPF8bXib9u3CskSFuREIh8wwCtDrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-UbZ-Sy2yP02mp7GXcGPC-A-1; Thu, 23 Apr 2020 07:29:25 -0400
X-MC-Unique: UbZ-Sy2yP02mp7GXcGPC-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AAA91009619;
        Thu, 23 Apr 2020 11:29:22 +0000 (UTC)
Received: from krava (unknown [10.40.196.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CBE419167;
        Thu, 23 Apr 2020 11:29:18 +0000 (UTC)
Date:   Thu, 23 Apr 2020 13:29:15 +0200
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
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 05/11] perf expr: increase max other
Message-ID: <20200423112915.GH1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-6-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:24PM -0700, Ian Rogers wrote:
> Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
> need more space.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 0938ad166ece..4938bfc608b7 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,7 +2,7 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>  
> -#define EXPR_MAX_OTHER 20
> +#define EXPR_MAX_OTHER 64
>  #define MAX_PARSE_ID EXPR_MAX_OTHER
>  
>  struct expr_parse_id {
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

ok, and we should probably start to think about what Andi suggested
in here: https://lore.kernel.org/lkml/20200224210308.GQ160988@tassilo.jf.intel.com/

jirka

