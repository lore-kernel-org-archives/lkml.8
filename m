Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E8EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BF72145D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590158885;
	bh=YLq0x5cSgrhk66zTJdZ7pmJdS1wmd1wNzBQ1/+Q2ohc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rS35BIyKin4dG0w6zs0z0YknxaOWeMlpb9TEmz6tuU4ysrFbfkv5jPASDttxCi0ia
	 R7JXDrm5KyHINLku9KIWcyHQzexDbQaqWuaCXg3VfB77zDBL7UNbHr4G+QHW/ZAoy1
	 DbQ2OkduxZrPamRLe+zWkpYr9vzvh8uie8NAdVwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgEVOsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgEVOsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:48:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 105F62053B;
        Fri, 22 May 2020 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158884;
        bh=YLq0x5cSgrhk66zTJdZ7pmJdS1wmd1wNzBQ1/+Q2ohc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNsFobQv5JWZPYkZvQ+EE4JWaMHaRwnlkSTdBlPq1oXLkvMSYXlF5XILdzCUiTVx5
         TL4vJh25zQHD1HLM8zb1Tef+McAGCqE2ggzImxzdOOT4ReoumOsV5bf0XCzFLoRdCM
         cHIU+vnN5Rj3GLsOKCGw2N5PZJRbMfL3dD8fFX3Y=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D799940AFD; Fri, 22 May 2020 11:48:01 -0300 (-03)
Date:   Fri, 22 May 2020 11:48:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf list: Add metrics to command line usage
Message-ID: <20200522144801.GH14034@kernel.org>
References: <20200522064546.164259-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522064546.164259-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 21, 2020 at 11:45:46PM -0700, Ian Rogers escreveu:
> Before:
>  Usage: perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]
> After:
>  Usage: perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 965ef017496f..0a7fe4cb5555 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -42,7 +42,7 @@ int cmd_list(int argc, const char **argv)
>  		OPT_END()
>  	};
>  	const char * const list_usage[] = {
> -		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
> +		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]",
>  		NULL
>  	};
>  
> -- 

Thanks, applied.
