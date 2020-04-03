Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B85AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A61720757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atNwed4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390526AbgDCKBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:01:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727774AbgDCKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585908078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwrHjBFKCxgVZBrkT+dwsdEetk42jbePJCFYfUV5sFo=;
        b=atNwed4VXt2YZUe1DeWdLifwaoEUkkdLs9LrXNguEuFxvHfazVlHCLDfZovMBqDzrUF5xS
        g/ZQ6av+uB5uXccWQb3qOMtdj3/rqEu57HA2iVpfw5+nEddmQkWwxS+eNkDD9cuBoOGGci
        jJC3GADY8u3DoYRnkLPn7/5UP8tNgPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-YrpEKNnFPA6cRR-iibcv-Q-1; Fri, 03 Apr 2020 06:01:16 -0400
X-MC-Unique: YrpEKNnFPA6cRR-iibcv-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E518D800D5F;
        Fri,  3 Apr 2020 10:01:14 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 003CC60BF1;
        Fri,  3 Apr 2020 10:01:13 +0000 (UTC)
Date:   Fri, 3 Apr 2020 12:01:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Simplify auxiliary event printing functions
Message-ID: <20200403100111.GI2784502@krava>
References: <20200402141548.21283-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402141548.21283-1-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 05:15:48PM +0300, Adrian Hunter wrote:
> This simplifies the print functions for the following perf script
> options:
> 
> 	--show-task-events
> 	--show-namespace-events
> 	--show-cgroup-events
> 	--show-mmap-events
> 	--show-switch-events
> 	--show-lost-events
> 	--show-bpf-events
> 
> Example:
> 	# perf record --switch-events -a -e cycles -c 10000 sleep 1
>  Before:
> 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-before.txt
>  After:
> 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-after.txt
> 	# diff -s out-before.txt out-after.txt
> 	Files out-before.txt and out-after.tx are identical
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 304 ++++++++----------------------------
>  1 file changed, 66 insertions(+), 238 deletions(-)

awesome ;-)

> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 186ebf827fa1..348fec9743a4 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2040,7 +2040,7 @@ static int cleanup_scripting(void)
>  
>  static bool filter_cpu(struct perf_sample *sample)
>  {
> -	if (cpu_list)
> +	if (cpu_list && sample->cpu != (u32)-1)
>  		return !test_bit(sample->cpu, cpu_bitmap);

why is this needed? filter_cpu seems to be already called
from all the changed functions..

thanks,
jirka

