Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8843CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C04F2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cADNuqVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgCRKcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:32:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58925 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbgCRKcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584527552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3nbsiG+klM2sjKVktcnQOTdfzMlCDVbpVHCVvOHKDk=;
        b=cADNuqVU7ZtzF6+CCxEfmnFPzEnbxYAO9TdBaC3OxRejKEhXJYZWqBxfXJVndiN6KgNIR0
        8fytwEDWBwk9SZ0DmoTEyymFsyD3Ur4hx4POKRpZ72drBEut/UrNjnhnhm2KMqLYhoAtRP
        NaN5PGhZ1s2eORCbLkff26Wf/LhsPlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-6UrzpLuuNZyVHYkHpPN7sg-1; Wed, 18 Mar 2020 06:32:30 -0400
X-MC-Unique: 6UrzpLuuNZyVHYkHpPN7sg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69B1218A8C85;
        Wed, 18 Mar 2020 10:32:28 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2D7773865;
        Wed, 18 Mar 2020 10:32:26 +0000 (UTC)
Date:   Wed, 18 Mar 2020 11:32:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     zhe.he@windriver.com
Cc:     acme@redhat.com, jolsa@kernel.org, ak@linux.intel.com,
        meyerk@hpe.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Add NULL pointer check for cpu_map iteration and
 NULL assignment for all_cpus.
Message-ID: <20200318103224.GE821557@krava>
References: <1583665157-349023-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583665157-349023-1-git-send-email-zhe.he@windriver.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 06:59:17PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> NULL pointer may be passed to perf_cpu_map__cpu and then cause crash,
> such as the one commit cb71f7d43ece ("libperf: Setup initial evlist::all_cpus value")
> fix.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/lib/cpumap.c | 2 +-
>  tools/perf/lib/evlist.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> index f93f4e7..ca02150 100644
> --- a/tools/perf/lib/cpumap.c
> +++ b/tools/perf/lib/cpumap.c
> @@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  
>  int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
>  {
> -	if (idx < cpus->nr)
> +	if (cpus && idx < cpus->nr)
>  		return cpus->map[idx];
>  
>  	return -1;
> diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
> index 5b9f2ca..f87a239 100644
> --- a/tools/perf/lib/evlist.c
> +++ b/tools/perf/lib/evlist.c
> @@ -127,6 +127,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
>  	perf_cpu_map__put(evlist->cpus);
>  	perf_thread_map__put(evlist->threads);
>  	evlist->cpus = NULL;
> +	evlist->all_cpus = NULL;
>  	evlist->threads = NULL;
>  	fdarray__exit(&evlist->pollfd);
>  }
> -- 
> 2.7.4
> 

