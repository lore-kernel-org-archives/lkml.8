Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B162C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91872073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtEKh1Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgCMJgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:36:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbgCMJgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584092213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YVL5fqwYvvQ09XsGkNDNlhdUIVPU2+BvIMWamHoRn0=;
        b=gtEKh1MrwHRnMZ+9uJFkdMAfrtmPCZiYCI511PT9T+/AJD7LxXc/YrwHXOmf+iweSM0A1t
        IyZfA1Kbv9sHXB1dyJvP/Nc5lPtH2kd6uA3VyFarcqVBMqaZAByPkvfalSYS7CA7lDO/dN
        1LqQelfVWrv43vqsEYscwIFuUo7HeJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-7q_MAR4gOG6R0lSNhVBwzw-1; Fri, 13 Mar 2020 05:36:51 -0400
X-MC-Unique: 7q_MAR4gOG6R0lSNhVBwzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B57613F6;
        Fri, 13 Mar 2020 09:36:50 +0000 (UTC)
Received: from krava (ovpn-205-229.brq.redhat.com [10.40.205.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C1AF60E3E;
        Fri, 13 Mar 2020 09:36:44 +0000 (UTC)
Date:   Fri, 13 Mar 2020 10:36:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: give synthetic mmap events an inode
 generation
Message-ID: <20200313093639.GA389625@krava>
References: <20200313053129.131264-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313053129.131264-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:31:29PM -0700, Ian Rogers wrote:

SNIP

> 
> SUMMARY: MemorySanitizer: use-of-uninitialized-value tools/perf/util/dsos.c:23:6 in __dso_id__cmp
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/synthetic-events.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index dd3e6f43fb86..5fddb64ec8c7 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -345,6 +345,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  			continue;
>  
>  		event->mmap2.ino = (u64)ino;
> +                event->mmap2.ino_generation = 0;

please use tabs for indent, other than that

Acked-by: iri Olsa <jolsa@kernel.org>

thanks,
jirka

>  
>  		/*
>  		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

