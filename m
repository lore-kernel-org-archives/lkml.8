Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D3C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01436206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmjG1V6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDTJFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:05:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43426 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbgDTJFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587373512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gJtJYhwAi5omWX+yALxrJj5CbwmC8TzExgCZurnBeE=;
        b=TmjG1V6HajYg4XaasLv0TVXVGpjkm9A/jdVU7DpGNd9yHGLMsuDUw7iZWdxrfAPMUrwn7Z
        0fe+z4OiNqQAIYuBBubmBVCB6EsGgQ4WCVJzRIkiQYHMYLf0OtCJWI+lx1gnn4gOQbWfdn
        Qeg8wkx6ONk0GsGoyNqulmAdiI66e54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-Z5RS7GqfOyKxzeMgmZ3AFQ-1; Mon, 20 Apr 2020 05:05:08 -0400
X-MC-Unique: Z5RS7GqfOyKxzeMgmZ3AFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625561005510;
        Mon, 20 Apr 2020 09:05:06 +0000 (UTC)
Received: from krava (ovpn-115-153.ams2.redhat.com [10.36.115.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 106C4129F96;
        Mon, 20 Apr 2020 09:05:02 +0000 (UTC)
Date:   Mon, 20 Apr 2020 11:05:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf tools: Fix segfaults due to missing zstd
 decompressor initialization
Message-ID: <20200420090500.GE718574@krava>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
 <20200417132330.119407-3-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417132330.119407-3-tommi.t.rantala@nokia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:23:28PM +0300, Tommi Rantala wrote:
> Initialization of zstd decompressor state is done for "perf report" and
> "perf inject", but missing for other tools, causing segfaults e.g. with
> "perf script" and "perf annotate" when zstd compressed data is used:
> 
>   # ./perf record -z -a -- sleep 1
>   # gdb -q --args ./perf script
>   (gdb) run
>   Program received signal SIGSEGV, Segmentation fault.
>   0x00007ffff771d4cb in ZSTD_decompressStream () from /lib64/libzstd.so.1
>   (gdb) bt
>   #0  0x00007ffff771d4cb in ZSTD_decompressStream () from /lib64/libzstd.so.1
>   #1  0x00000000005c92a8 in zstd_decompress_stream (data=0xc3f8e0, src=0x7ffff6dd3038, src_size=255, dst=0x7ffff61ec028, dst_size=528384) at util/zstd.c:100
>   #2  0x00000000005262ba in perf_session__process_compressed_event (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:73
>   #3  0x000000000052a596 in perf_session__process_user_event (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:1581
>   #4  0x000000000052ab4b in perf_session__process_event (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:1713
>   #5  0x000000000052bed6 in process_simple (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:2209
>   #6  0x000000000052bcfe in reader__process_events (rd=0x7fffffffb400, session=0xc38cc0, prog=0x7fffffffb420) at util/session.c:2175
>   #7  0x000000000052bfc2 in __perf_session__process_events (session=0xc38cc0) at util/session.c:2232
>   #8  0x000000000052c0f3 in perf_session__process_events (session=0xc38cc0) at util/session.c:2265
>   #9  0x0000000000447266 in __cmd_script (script=0x7fffffffb5c0) at builtin-script.c:2608
>   #10 0x000000000044ba79 in cmd_script (argc=0, argv=0x7fffffffd330) at builtin-script.c:3988
>   #11 0x00000000004bf2b8 in run_builtin (p=0xa398f8 <commands+408>, argc=1, argv=0x7fffffffd330) at perf.c:312
>   #12 0x00000000004bf525 in handle_internal_command (argc=1, argv=0x7fffffffd330) at perf.c:364
>   #13 0x00000000004bf66c in run_argv (argcp=0x7fffffffd18c, argv=0x7fffffffd180) at perf.c:408
>   #14 0x00000000004bfa38 in main (argc=1, argv=0x7fffffffd330) at perf.c:538
> 
> Split zstd_init() into zstd_decomp_init() and zstd_comp_init(), so that
> we can do lazy initialization for the decompressor, and handle it all in
> perf_session to make it easily available to all the tools.

Alexey, could you please check on this one?

thanks,
jirka

> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  tools/perf/builtin-inject.c |  3 ---
>  tools/perf/builtin-record.c |  2 +-
>  tools/perf/builtin-report.c |  3 ---
>  tools/perf/util/compress.h  | 10 ++++++++--
>  tools/perf/util/session.c   |  3 +++
>  tools/perf/util/zstd.c      | 14 +++++++++++++-
>  6 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 1ffb8393357a..8cc9dff9e66b 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -803,9 +803,6 @@ int cmd_inject(int argc, const char **argv)
>  	if (IS_ERR(inject.session))
>  		return PTR_ERR(inject.session);
>  
> -	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
> -		pr_warning("Decompression initialization failed.\n");
> -
>  	if (inject.build_ids) {
>  		/*
>  		 * to make sure the mmap records are ordered correctly
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8ed00de1ca29..fa9c59fc4fe0 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1461,7 +1461,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	fd = perf_data__fd(data);
>  	rec->session = session;
>  
> -	if (zstd_init(&session->zstd_data, rec->opts.comp_level) < 0) {
> +	if (zstd_comp_init(&session->zstd_data, rec->opts.comp_level) < 0) {
>  		pr_err("Compression initialization failed.\n");
>  		return -1;
>  	}
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index e06e14980264..b85fcdebdb5a 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1355,9 +1355,6 @@ int cmd_report(int argc, const char **argv)
>  	if (ret)
>  		return ret;
>  
> -	if (zstd_init(&(session->zstd_data), 0) < 0)
> -		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
> -
>  	if (report.queue_size) {
>  		ordered_events__set_alloc_size(&session->ordered_events,
>  					       report.queue_size);
> diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
> index 0cd3369af2a4..aff9ce60dfb8 100644
> --- a/tools/perf/util/compress.h
> +++ b/tools/perf/util/compress.h
> @@ -26,7 +26,8 @@ struct zstd_data {
>  
>  #ifdef HAVE_ZSTD_SUPPORT
>  
> -int zstd_init(struct zstd_data *data, int level);
> +int zstd_comp_init(struct zstd_data *data, int level);
> +int zstd_decomp_init(struct zstd_data *data);
>  int zstd_fini(struct zstd_data *data);
>  
>  size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
> @@ -37,7 +38,12 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
>  			      void *dst, size_t dst_size);
>  #else /* !HAVE_ZSTD_SUPPORT */
>  
> -static inline int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
> +static inline int zstd_comp_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static inline int zstd_decomp_init(struct zstd_data *data __maybe_unused)
>  {
>  	return 0;
>  }
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 64e8b794b0bc..2bba731e7cbf 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -45,6 +45,9 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
>  	struct decomp *decomp, *decomp_last = session->decomp_last;
>  
> +	if (zstd_decomp_init(&session->zstd_data) < 0)
> +		return -1;
> +
>  	if (decomp_last) {
>  		decomp_last_rem = decomp_last->size - decomp_last->head;
>  		decomp_len += decomp_last_rem;
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index d2202392ffdb..d789665e8c0c 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -5,10 +5,13 @@
>  #include "util/compress.h"
>  #include "util/debug.h"
>  
> -int zstd_init(struct zstd_data *data, int level)
> +int zstd_decomp_init(struct zstd_data *data)
>  {
>  	size_t ret;
>  
> +	if (data->dstream)
> +		return 0;
> +
>  	data->dstream = ZSTD_createDStream();
>  	if (data->dstream == NULL) {
>  		pr_err("Couldn't create decompression stream.\n");
> @@ -18,9 +21,18 @@ int zstd_init(struct zstd_data *data, int level)
>  	ret = ZSTD_initDStream(data->dstream);
>  	if (ZSTD_isError(ret)) {
>  		pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
> +		ZSTD_freeDStream(data->dstream);
> +		data->dstream = NULL;
>  		return -1;
>  	}
>  
> +	return 0;
> +}
> +
> +int zstd_comp_init(struct zstd_data *data, int level)
> +{
> +	size_t ret;
> +
>  	if (!level)
>  		return 0;
>  
> -- 
> 2.25.2
> 

