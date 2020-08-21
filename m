Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1952078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598012013;
	bh=iepkrC52e+w/P9w3zSYEwWNZWt6A/JuNd4RbEzvQ7Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zrXCGZOkQOVO4RKLkhl6fdgjtP4oGrXBg4gjGXia/AfeT87kEH3XY8z4di9fm0rzr
	 0gnGqrNfizh+skY6QWPu5hs1jGdiGwraQWnESS67jn0ntLlDY7qcxhDCp+8jEKNlZT
	 QQKkKLkJ/06ljWgz1pk6U+HQdDbWukZMY5Ofg15I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHUMNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgHUMNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:13:16 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.208.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A7B2078D;
        Fri, 21 Aug 2020 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598011996;
        bh=iepkrC52e+w/P9w3zSYEwWNZWt6A/JuNd4RbEzvQ7Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wyc9WConBpZi46FFB/+bQTwCjXbF2h0HCT98dbsMXQhuXPFtmajhiLGGFfK3hUwH1
         b7Y0bs+8YCJnMyY8yRrJEAsOOHMfEjpsjLgO2NuGo93EjdyLrORyE8SS43MSGQXmH+
         klWI41olCD/BFXhqDCtEnm7emK3q66JLTYD6apdo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACDD940D3D; Fri, 21 Aug 2020 09:13:10 -0300 (-03)
Date:   Fri, 21 Aug 2020 09:13:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH] perf tools: Use %zd for size_t printf formats on 32b
Message-ID: <20200821121310.GF2667554@kernel.org>
References: <20200820212501.24421-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820212501.24421-1-chris@chris-wilson.co.uk>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 20, 2020 at 10:25:01PM +0100, Chris Wilson escreveu:
> A couple of trivial fixes for using %zd for size_t.

Added Jiri and Namhyung, that are perf tooling reviewers, and Alexey
Budankov, that added the ZSTD code.

Applied,

- Arnaldo
 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  tools/perf/util/session.c | 2 +-
>  tools/perf/util/zstd.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index ffbc9d35a383..7a5f03764702 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -87,7 +87,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  		session->decomp_last = decomp;
>  	}
>  
> -	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> +	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index d2202392ffdb..48dd2b018c47 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -99,7 +99,7 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
>  	while (input.pos < input.size) {
>  		ret = ZSTD_decompressStream(data->dstream, &output, &input);
>  		if (ZSTD_isError(ret)) {
> -			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
> +			pr_err("failed to decompress (B): %zd -> %zd, dst_size %zd : %s\n",
>  			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
>  			break;
>  		}
> -- 
> 2.20.1
> 

-- 

- Arnaldo
