Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C9ECA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4EC205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIH2EZXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgEMLju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:39:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727794AbgEMLju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589369988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8iykZIXI4IdeXAxO1qeWLOQ71RfoRoi6nrusDeqTAHA=;
        b=eIH2EZXKC6tGzYiFF20bTgvt3ll/LOIH0hVE1ISxkY7fx5/irJolcJVh+0GQ/K4DjY44Fc
        C0Is4Hw1fw21KM5pL0I0+AyL1XYQWE6NZWhZn2Mo+BiEDKVNy+oWW3/BjDLI8rw59LsQih
        X0CIAkYQZE21S5l05BAnMj5ZRYyas1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-5QuVWD6CMLuBDbs3J0yzuA-1; Wed, 13 May 2020 07:39:47 -0400
X-MC-Unique: 5QuVWD6CMLuBDbs3J0yzuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A976835B41;
        Wed, 13 May 2020 11:39:45 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 33A885D9C5;
        Wed, 13 May 2020 11:39:42 +0000 (UTC)
Date:   Wed, 13 May 2020 13:39:41 +0200
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
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
Message-ID: <20200513113941.GK3158213@krava>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:20:23PM +1000, Anand K Mistry wrote:
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
> 
> Signed-off-by: Anand K Mistry <amistry@google.com>
> 
> ---
> 
> Changes in v3:
> - Move done_fd creation to below session initialisation
> - Close done_fd on exit
> - Log errno when write(done_fd) fails

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

