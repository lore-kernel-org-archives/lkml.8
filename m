Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B40C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11882145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tzf9Uomp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDTItZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:49:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57069 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726006AbgDTItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587372564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vl/zm2thK/L0aGu4Ipk2rJ2qCf76IiQpEKj2qZOJOww=;
        b=Tzf9UompnjreVjdefqtk1Vvnxrm8NHzD2iS0on22fLfqQFp9MwiihbZMH52/TX8tLhPAXG
        +59sOM5V7rcU3MBesXLV4/wlgQ4t3hPCN96giV7EJ5PoxSHpK1aMCGYFKcuXWGTRYyktkl
        OFLhYU4z72oZp91L2MbcJgxW5DwhdHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-qn8M2ADeOyOrePmlrSsQlg-1; Mon, 20 Apr 2020 04:49:20 -0400
X-MC-Unique: qn8M2ADeOyOrePmlrSsQlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 017E68017F3;
        Mon, 20 Apr 2020 08:49:19 +0000 (UTC)
Received: from krava (unknown [10.40.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 333D260C63;
        Mon, 20 Apr 2020 08:48:50 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:48:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] perf cgroup: Avoid needless closing of unopened fd
Message-ID: <20200420084847.GC718574@krava>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:23:26PM +0300, Tommi Rantala wrote:
> Do not bother with close() if fd is not valid, just to silence valgrind:
> 
>     $ valgrind ./perf script
>     ==59169== Memcheck, a memory error detector
>     ==59169== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
>     ==59169== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
>     ==59169== Command: ./perf script
>     ==59169==
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
>     ==59169== Warning: invalid file descriptor -1 in syscall close()
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index b73fb7823048..050dea9f1e88 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -107,7 +107,8 @@ static int add_cgroup(struct evlist *evlist, const char *str)
>  
>  static void cgroup__delete(struct cgroup *cgroup)
>  {
> -	close(cgroup->fd);
> +	if (cgroup->fd >= 0)
> +		close(cgroup->fd);
>  	zfree(&cgroup->name);
>  	free(cgroup);
>  }
> -- 
> 2.25.2
> 

