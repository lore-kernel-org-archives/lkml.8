Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFA7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9092D2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPeLbKIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCMJhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:37:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23434 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbgCMJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584092266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dck+RqWIyDpOLuZegJ0YcASEBidThiMoHUGQ4kc8bpw=;
        b=aPeLbKIqW5DZpxNIJ7VW1MPCveQmA3OKJiPM6vi/5ouNoCrTMtRi1628/LfGPKbfYTRfp2
        bhVLKdpgzaqvp78I/HMHsor1mK4hpLPxIeyZqXhhHiCd39UDRbBULQ4j7RVLH19kPLno20
        wuoi1YxjtMoJTJGWU9PaN+uTfGXazks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-vmo6UCbtNM-BmX7GZaSqbg-1; Fri, 13 Mar 2020 05:37:42 -0400
X-MC-Unique: vmo6UCbtNM-BmX7GZaSqbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEE12800D50;
        Fri, 13 Mar 2020 09:37:40 +0000 (UTC)
Received: from krava (ovpn-205-229.brq.redhat.com [10.40.205.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CF6392D50;
        Fri, 13 Mar 2020 09:37:37 +0000 (UTC)
Date:   Fri, 13 Mar 2020 10:37:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: print if shell directory isn't present
Message-ID: <20200313093734.GB389625@krava>
References: <20200313005602.45236-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313005602.45236-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:56:02PM -0700, Ian Rogers wrote:
> If the shell test directory isn't present the exit code will be 255 but
> with no error messages printed. Add an error message.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/tests/builtin-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 5f05db75cdd8..54d9516c9839 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -543,8 +543,11 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  		return -1;
>  
>  	dir = opendir(st.dir);
> -	if (!dir)
> +	if (!dir) {
> +		pr_err("failed to open shell test directory: %s\n",
> +			st.dir);
>  		return -1;
> +	}
>  
>  	for_each_shell_test(dir, st.dir, ent) {
>  		int curr = i++;
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

