Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70961C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482CD2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwLY+oVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgDWMRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:17:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31436 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgDWMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587644241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWoPh1RcOCCX55TwDPH9/kRfVbasvFbEjZucZpZHZug=;
        b=VwLY+oVB+7rSsK4j7cHKZA4L3U4HzvFqiodEs+rQC4qApv781VCq3KVfzyuAw5lmITHeau
        xSp0dneQFBrZ50B0dj+TRVemimgrrChjgI7YByjnvnysxhD37DWf8r6VT4zpay/pXzRSS1
        3yS/vX/DQUJmD1P7d46DE+3LhrcCayc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-ZpQyGlQKPIOL8KVuunTQhg-1; Thu, 23 Apr 2020 08:17:17 -0400
X-MC-Unique: ZpQyGlQKPIOL8KVuunTQhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBD1619057AF;
        Thu, 23 Apr 2020 12:17:15 +0000 (UTC)
Received: from krava (ovpn-115-157.ams2.redhat.com [10.36.115.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EA275C1BD;
        Thu, 23 Apr 2020 12:17:13 +0000 (UTC)
Date:   Thu, 23 Apr 2020 14:17:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test session topology: Fix data path
Message-ID: <20200423121710.GM1136647@krava>
References: <20200423115341.562782-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423115341.562782-1-tommi.t.rantala@nokia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 02:53:40PM +0300, Tommi Rantala wrote:
> Commit 2d4f27999b88 ("perf data: Add global path holder") missed path
> conversion in tests/topology.c, causing the "Session topology" testcase
> to "hang" (waits forever for input from stdin) when doing "ssh $VM perf
> test".
> 
> Can be reproduced by running "cat | perf test topo", and crashed by
> replacing cat with true:
> 
>   $ true | perf test -v topo
>   40: Session topology                                      :
>   --- start ---
>   test child forked, pid 3638
>   templ file: /tmp/perf-test-QPvAch
>   incompatible file format
>   incompatible file format (rerun with -v to learn more)
>   free(): invalid pointer
>   test child interrupted
>   ---- end ----
>   Session topology: FAILED!
> 
> Fixes: 2d4f27999b88 ("perf data: Add global path holder")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/topology.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 4a800499d7c3..22daf2bdf5fa 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -33,10 +33,8 @@ static int session_write_header(char *path)
>  {
>  	struct perf_session *session;
>  	struct perf_data data = {
> -		.file      = {
> -			.path = path,
> -		},
> -		.mode      = PERF_DATA_MODE_WRITE,
> +		.path = path,
> +		.mode = PERF_DATA_MODE_WRITE,
>  	};
>  
>  	session = perf_session__new(&data, false, NULL);
> @@ -63,10 +61,8 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  {
>  	struct perf_session *session;
>  	struct perf_data data = {
> -		.file      = {
> -			.path = path,
> -		},
> -		.mode      = PERF_DATA_MODE_READ,
> +		.path = path,
> +		.mode = PERF_DATA_MODE_READ,
>  	};
>  	int i;
>  
> -- 
> 2.25.3
> 

