Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78FAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E112177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSoFgVDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHFToN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:44:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43679 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgHFToM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596743051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0++OTxXTfk2wjvHLjiHnZibQfFxJzlhhcpK1AT+7Ig=;
        b=QSoFgVDq2DBUxAQI3g4mL4WfjW4lI6zf5BKwjTbsJJa9spa4XGlCa2JZyB7P5VC2sQUJVY
        cnYFl3llB8DSkGmZ1cvrYxFvRt++i0MG5j+oxerPte8AYvAplPZaVCM68iNlhZGCb/1KC+
        /jdMZE3DK6R3turFKbXBVGDlTWLEWdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-XlM89QQdNsC8WHHcK82uFQ-1; Thu, 06 Aug 2020 15:44:07 -0400
X-MC-Unique: XlM89QQdNsC8WHHcK82uFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2D9A102C7EC;
        Thu,  6 Aug 2020 19:44:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id B49CB87A61;
        Thu,  6 Aug 2020 19:44:03 +0000 (UTC)
Date:   Thu, 6 Aug 2020 21:43:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf record: Skip side-band event setup if
 HAVE_LIBBPF_SUPPORT is not set
Message-ID: <20200806194357.GA539212@krava>
References: <20200805022937.29184-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805022937.29184-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:29:37AM +0800, Jin Yao wrote:
> We received an error report that perf-record caused 'Segmentation fault'
> on a newly system (e.g. on the new installed ubuntu).
> 
>  (gdb) backtrace
>  #0  __read_once_size (size=4, res=<synthetic pointer>, p=0x14) at /root/0-jinyao/acme/tools/include/linux/compiler.h:139
>  #1  atomic_read (v=0x14) at /root/0-jinyao/acme/tools/include/asm/../../arch/x86/include/asm/atomic.h:28
>  #2  refcount_read (r=0x14) at /root/0-jinyao/acme/tools/include/linux/refcount.h:65
>  #3  perf_mmap__read_init (map=map@entry=0x0) at mmap.c:177
>  #4  0x0000561ce5c0de39 in perf_evlist__poll_thread (arg=0x561ce68584d0) at util/sideband_evlist.c:62
>  #5  0x00007fad78491609 in start_thread (arg=<optimized out>) at pthread_create.c:477
>  #6  0x00007fad7823c103 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

hum, I recall discussing the same issue,
I thought it was already fixed :-\ in any case:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> The root cause is, evlist__add_bpf_sb_event() just returns 0 if
> HAVE_LIBBPF_SUPPORT is not defined (inline function path). So it will
> not create a valid evsel for side-band event.
> 
> But perf-record still creates BPF side band thread to process the
> side-band event, then the error happpens.
> 
> We can reproduce this issue by removing the libelf-dev. e.g.
> 1. apt-get remove libelf-dev
> 2. perf record -a -- sleep 1
> 
> root@test:~# ./perf record -a -- sleep 1
> perf: Segmentation fault
> Obtained 6 stack frames.
> ./perf(+0x28eee8) [0x5562d6ef6ee8]
> /lib/x86_64-linux-gnu/libc.so.6(+0x46210) [0x7fbfdc65f210]
> ./perf(+0x342e74) [0x5562d6faae74]
> ./perf(+0x257e39) [0x5562d6ebfe39]
> /lib/x86_64-linux-gnu/libpthread.so.0(+0x9609) [0x7fbfdc990609]
> /lib/x86_64-linux-gnu/libc.so.6(clone+0x43) [0x7fbfdc73b103]
> Segmentation fault (core dumped)
> 
> To fix this issue,
> 
> 1. We either install the missing libraries to let HAVE_LIBBPF_SUPPORT
>    be defined.
>    e.g. apt-get install libelf-dev and install other related libraries.
> 
> 2. Use this patch to skip the side-band event setup if HAVE_LIBBPF_SUPPORT
>    is not set.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index b6bdccd875bc..ae97f98e2753 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1506,6 +1506,7 @@ static int record__synthesize(struct record *rec, bool tail)
>  	return err;
>  }
>  
> +#ifdef HAVE_LIBBPF_SUPPORT
>  static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
>  {
>  	struct record *rec = data;
> @@ -1550,6 +1551,12 @@ static int record__setup_sb_evlist(struct record *rec)
>  
>  	return 0;
>  }
> +#else
> +static int record__setup_sb_evlist(struct record *rec __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static int __cmd_record(struct record *rec, int argc, const char **argv)
>  {
> -- 
> 2.17.1
> 

