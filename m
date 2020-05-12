Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0CC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D2420674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsHJVIRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgELMMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:12:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56147 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELMMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589285559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=asu/+mb4aQxasBk4gTFYsedBOKgWTv0nv0/dQGL9xlg=;
        b=VsHJVIRgBi1bx/wmjsfvCeu9nGZO2on2zhZBtLcpaIgeOY9dkjv34os/ptiA122AtNii2O
        tjtt8YDb/cyYxsXF+uy5lftJKOG1W98JejGKxBoHci+qiZNhxrLBJ0mFT9l1jLdNBErVL8
        gD9fN9iqUzhmmnfjW7UwSJ71P8JY24E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-DBqH8HW2M8uXf1iJrx3s8w-1; Tue, 12 May 2020 08:12:37 -0400
X-MC-Unique: DBqH8HW2M8uXf1iJrx3s8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6048835B40;
        Tue, 12 May 2020 12:12:35 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B18C610AF;
        Tue, 12 May 2020 12:12:33 +0000 (UTC)
Date:   Tue, 12 May 2020 14:12:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Anand K Mistry <amistry@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Use an eventfd to wakeup when done
Message-ID: <20200512121232.GB3150977@krava>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200512145930.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512145930.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:59:36PM +1000, Anand K Mistry wrote:

SNIP

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe90469..099ecaa66732a2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -53,6 +53,7 @@
>  #include <unistd.h>
>  #include <sched.h>
>  #include <signal.h>
> +#include <sys/eventfd.h>
>  #include <sys/mman.h>
>  #include <sys/wait.h>
>  #include <sys/types.h>
> @@ -518,15 +519,28 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  
>  static volatile int signr = -1;
>  static volatile int child_finished;
> +static int done_fd = -1;
>  
>  static void sig_handler(int sig)
>  {
> +	u64 tmp = 1;
>  	if (sig == SIGCHLD)
>  		child_finished = 1;
>  	else
>  		signr = sig;
>  
>  	done = 1;
> +
> +	/*
> +	 * It is possible for this signal handler to run after done is checked
> +	 * in the main loop, but before the perf counter fds are polled. If this
> +	 * happens, the poll() will continue to wait even though done is set,
> +	 * and will only break out if either another signal is received, or the
> +	 * counters are ready for read. To ensure the poll() doesn't sleep when
> +	 * done is set, use an eventfd (done_fd) to wake up the poll().
> +	 */
> +	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> +		pr_err("failed to signal wakeup fd\n");
>  }
>  
>  static void sigsegv_handler(int sig)
> @@ -1424,6 +1438,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	int fd;
>  	float ratio = 0;
>  
> +	done_fd = eventfd(0, EFD_NONBLOCK);
> +	if (done_fd < 0) {
> +		pr_err("Failed to create wakeup eventfd, error: %m\n");
> +		return -1;
> +	}
> +	err = evlist__add_pollfd(rec->evlist, done_fd);
> +	if (err < 0) {
> +		pr_err("Failed to add wakeup eventfd to poll list\n");
> +		return -1;
> +	}

sorry I did not notice before, but I think we also
need to close done_fd descriptor on the exit path

also please change subject to PATCHv3 for the next version

thanks,
jirka

> +
>  	atexit(record__sig_exit);
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGINT, sig_handler);
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

