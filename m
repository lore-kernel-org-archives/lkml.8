Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382AC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B5D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReG51ffh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEKL2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:28:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42850 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730048AbgEKL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589196519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMThpkceIHVkmBtaCW1DTUS61tjMEkTTbd1IFAK0wUA=;
        b=ReG51ffhaegyAspANLL/LnKwUeh+VltMTQKDaBgXZ/TLbVU8Z18UlpKavOusqAajdvSi/X
        mNHXTMzPzmeN9CvsfkIQyxgg5OKQ2/b3viwj6GMF/vwr5YcIH6Qnv/kggpdYoJGggkFDJ3
        8nRXcwHjD6M4CxB5bNtB0a7jW2JosGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-isU4oOttPfiFwIgzJyiw7A-1; Mon, 11 May 2020 07:28:37 -0400
X-MC-Unique: isU4oOttPfiFwIgzJyiw7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4019E107ACCD;
        Mon, 11 May 2020 11:28:36 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4414B9CB9;
        Mon, 11 May 2020 11:28:34 +0000 (UTC)
Date:   Mon, 11 May 2020 13:28:33 +0200
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
Message-ID: <20200511112833.GE2986380@krava>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:56:43PM +1000, Anand K Mistry wrote:
> The setting and checking of 'done' contains a rare race where the signal
> handler setting 'done' is run after checking to break the loop, but
> before waiting in evlist__poll(). In this case, the main loop won't wake
> up until either another signal is sent, or the perf data fd causes a
> wake up.
> 
> The following simple script can trigger this condition (but you might
> need to run it for several hours):
> for ((i = 0; i >= 0; i++)) ; do
>   echo "Loop $i"
>   delay=$(echo "scale=4; 0.1 * $RANDOM/32768" | bc)
>   ./perf record -- sleep 30000000 >/dev/null&
>   pid=$!
>   sleep $delay
>   kill -TERM $pid
>   echo "PID $pid"
>   wait $pid
> done
> 
> At some point, the loop will stall. Adding logging, even though perf has
> received the SIGTERM and set 'done = 1', perf will remain sleeping until
> a second signal is sent.

so it's just few instructions in between the check and the evlist__poll

         if (done || draining)
               break;
         err = evlist__poll(rec->evlist, -1);

nice catch!

SNIP

> @@ -518,15 +519,19 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
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

could you please put some explaining comment in here,
so we are not confused by this in few months ;-)

> +	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> +		pr_err("failed to signal wakeup fd\n");
>  }
>  
>  static void sigsegv_handler(int sig)
> @@ -1424,6 +1429,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	int fd;
>  	float ratio = 0;
>  
> +	done_fd = eventfd(0, EFD_NONBLOCK);
> +	evlist__add_pollfd(rec->evlist, done_fd);

both of those can fail, please check the return values

thanks,
jirka

> +
>  	atexit(record__sig_exit);
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGINT, sig_handler);
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

