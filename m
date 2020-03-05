Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30036C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3020848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6EeGLjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCEP2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:28:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbgCEP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583422082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szMYTUanak9bpgOmdh9Y4uhe2prEGOy08Ect7MjVS/Y=;
        b=E6EeGLjfrYqYmuK/TmfL0qr6d1w2G4u2q5yfGKx6sp6kNa1swsOqD/UL3Uk9tAJmBzqyK2
        hVOF56zspTyBBmcGtlGVi69IM1a+6Rn765DSla1AZwJ8mTk+y0TgDNXNPrVlPCtXVyrh7H
        GFG8lvLz5lXCfX5/yUa/nuyr5uKUcPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-7ft2CNpQM7K72aqx1wN1qA-1; Thu, 05 Mar 2020 10:28:00 -0500
X-MC-Unique: 7ft2CNpQM7K72aqx1wN1qA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 819FA805745;
        Thu,  5 Mar 2020 15:27:59 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-13.phx2.redhat.com [10.3.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7FEF60BE0;
        Thu,  5 Mar 2020 15:27:58 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id C9D1011A; Thu,  5 Mar 2020 12:27:55 -0300 (BRT)
Date:   Thu, 5 Mar 2020 12:27:55 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     zhe.he@windriver.com
Cc:     jolsa@kernel.org, ak@linux.intel.com, meyerk@hpe.com,
        linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf: Fix crash due to null pointer dereference when
 iterating cpu map
Message-ID: <20200305152755.GA6958@redhat.com>
References: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 06:47:19PM +0800, zhe.he@windriver.com escreveu:
> From: He Zhe <zhe.he@windriver.com>
> 
> NULL pointer may be passed to perf_cpu_map__cpu and then cause the
> following crash.
> 
> perf ftrace -G start_kernel ls
> failed to set tracing filters
> [  208.710716] perf[341]: segfault at 4 ip 00000000567c7c98
>                sp 00000000ff937ae0 error 4 in perf[56630000+1b2000]
> [  208.724778] Code: fc ff ff e8 aa 9b 01 00 8d b4 26 00 00 00 00 8d
>                      76 00 55 89 e5 83 ec 18 65 8b 0d 14 00 00 00 89
>                      4d f4 31 c9 8b 45 08 8b9
> Segmentation fault

I'm not being able to repro this here, what is the tree you are using?

- Arnaldo
 
> Program received signal SIGSEGV, Segmentation fault.
> 0x5677dc98 in perf_cpu_map__cpu (cpus=0x0, idx=0) at cpumap.c:250
> 250     cpumap.c: No such file or directory.
> (gdb) bt
> 0  0x5677dc98 in perf_cpu_map__cpu (cpus=0x0, idx=0) at cpumap.c:250
> 1  0x566790bd in evlist__close (evlist=0x56a6f470) at util/evlist.c:1222
> 2  0x566792aa in evlist__delete (evlist=evlist@entry=0x56a6f470)
>    at util/evlist.c:152
> 3  0x5667936b in evlist__delete (evlist=0x56a6f470) at util/evlist.c:148
> 4  0x565efd39 in cmd_ftrace (argc=1, argv=0xffffdd18) at builtin-ftrace.c:520
> 5  0x56660ee7 in run_builtin (p=0x56993004 <commands+324>, argc=4,
>    argv=0xffffdd18) at perf.c:312
> 6  0x565e7fae in handle_internal_command (argv=<optimized out>,
>    argc=<optimized out>) at perf.c:364
> 7  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:408
> 8  main (argc=<optimized out>, argv=<optimized out>) at perf.c:538
> 
> Add null pointer check for iteration and NULL assignment for all_cpus.
> And there is no need to iterate if there is no cpus.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/lib/perf/cpumap.c | 4 ++--
>  tools/lib/perf/evlist.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index f93f4e703e4c..128386647ac0 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  
>  int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
>  {
> -	if (idx < cpus->nr)
> +	if (cpus && idx < cpus->nr)
>  		return cpus->map[idx];
>  
>  	return -1;
> @@ -255,7 +255,7 @@ int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
>  
>  int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
>  {
> -	return cpus ? cpus->nr : 1;
> +	return cpus ? cpus->nr : 0;
>  }
>  
>  bool perf_cpu_map__empty(const struct perf_cpu_map *map)
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index ae9e65aa2491..d57adf3020fe 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -127,6 +127,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
>  	perf_cpu_map__put(evlist->cpus);
>  	perf_thread_map__put(evlist->threads);
>  	evlist->cpus = NULL;
> +	evlist->all_cpus = NULL;
>  	evlist->threads = NULL;
>  	fdarray__exit(&evlist->pollfd);
>  }
> -- 
> 2.24.1

