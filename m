Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE7C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D982184D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiZmAOCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEAK2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:28:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30917 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728493AbgEAK2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588328901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXAZzMd4Qe7W9Dpt2E1WM6UlO4H8S212I1Fmkwri2G8=;
        b=IiZmAOCFr8nsT2vra3rWrL/ebHK3Kog5hbs/KzcR3JS+mMIWGt3LVZ9aZDgi4Keba1hBZC
        /cWR8bW5+dyuet+X+88EvQ8Jbnsp4M4c9X52nMu1fUGs8A7DrcqjtwDw6S2ixa0O/dq/vI
        +bPz1s0dl1oIRNsm1AYcsHjHnxomxR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-fYGFRK8jMx2xx78I-zW35g-1; Fri, 01 May 2020 06:28:19 -0400
X-MC-Unique: fYGFRK8jMx2xx78I-zW35g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D28C45F;
        Fri,  1 May 2020 10:28:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 999DA648CF;
        Fri,  1 May 2020 10:28:16 +0000 (UTC)
Date:   Fri, 1 May 2020 12:28:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v2] perf: fix compilation failure on i386
Message-ID: <20200501102813.GA1789042@krava>
References: <20200501082537.4740-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501082537.4740-1-caoj.fnst@cn.fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:25:37PM +0800, Cao jin wrote:
> Compilation on i386 complains as following:
> 
> util/session.c: In function 'perf_session__process_compressed_event':
> util/session.c:91:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
>   pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
>            ^
> 
> util/zstd.c: In function 'zstd_decompress_stream':
> util/zstd.c:102:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
>     pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
>            ^
> 
> Fix them by pairing "%zd" to size_t.
> 
> Also revert an unnecessary conversion: "(long)src_size" to plain "src_size"
> with conversion specifier "%zd".
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/session.c | 2 +-
>  tools/perf/util/zstd.c    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0b0bfe5bef17..50c2ffa388ad 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -88,7 +88,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  		session->decomp_last = decomp;
>  	}
>  
> -	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> +	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index d2202392ffdb..877bfb79e4af 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -74,8 +74,8 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t
>  		ret = ZSTD_compressStream(data->cstream, &output, &input);
>  		ZSTD_flushStream(data->cstream, &output);
>  		if (ZSTD_isError(ret)) {
> -			pr_err("failed to compress %ld bytes: %s\n",
> -				(long)src_size, ZSTD_getErrorName(ret));
> +			pr_err("failed to compress %zd bytes: %s\n",
> +				src_size, ZSTD_getErrorName(ret));
>  			memcpy(dst, src, src_size);
>  			return src_size;
>  		}
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
> 2.21.0
> 
> 
> 

