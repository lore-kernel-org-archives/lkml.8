Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB17C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCE92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkcoScqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgD3JFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:05:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbgD3JFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588237520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJSRBzXkcibxsSPh9O1403Rk/EpaZM7bpyleRS09wg4=;
        b=VkcoScqTNRdxoyqrrvV5Zdz6MA7I/B8fn83RWmQ20xDcAq1QeugpOPEkV2+4SXB5W/Ki5S
        js9HYgPZmIha+ml64w18wMP8jehcKKtVYHkAVIJ7Pg//e2bSaPuqWLdoPnikJ2DXGNiT9d
        90EdhkFYuOuFTOTjAkKTp0n+AdeNF10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-5TO6x0G5Nuiy7rlFhRFNRQ-1; Thu, 30 Apr 2020 05:05:18 -0400
X-MC-Unique: 5TO6x0G5Nuiy7rlFhRFNRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACAF38018A5;
        Thu, 30 Apr 2020 09:05:16 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AC12579A5;
        Thu, 30 Apr 2020 09:05:10 +0000 (UTC)
Date:   Thu, 30 Apr 2020 11:05:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [RFC PATCHSET v2] Implement --switch-output-event
Message-ID: <20200430090506.GE1681583@krava>
References: <20200429131106.27974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429131106.27974-1-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:10:58AM -0300, Arnaldo Carvalho de Melo wrote:
> Hi guys,
> 
> 	Please consider reviewing, this addresses comments by Jiri in
> the V1.

small nit posted, but overall looks good

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> 
> 	Again, the example provided is too simple, using 'perf probe' to
> put probes in specific places in some workload to then get any other
> event close to the time the trigger hits comes to mind as well, using
> the signal was just to reuse the pre-existing logic and keep the
> patchkit small.
> 
> 	One other thing that occurred to me while testing is that this
> can be combined with 'perf report/perf script' --switch-off option:
> 
>   $ perf report -h --switch-off
> 
>   Usage: perf report [<options>]
> 
>         --switch-off <event>
>                           Stop considering events after the ocurrence of this event
> 
>   $
> 
> 	To remove from consideration the events that end up being
> recorded in the ring buffer after the --switch-output-event but gets in
> the ring buffer because we process the --switch-output-event
> asynchronously.
> 
>         Its available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/switch-output-event
> 
> Best regards,
> 
> - Arnaldo
> 
> 
> Arnaldo Carvalho de Melo (8):
>   perf record: Move sb_evlist to 'struct record'
>   perf top: Move sb_evlist to 'struct perf_top'
>   perf bpf: Decouple creating the evlist from adding the SB event
>   perf parse-events: Add parse_events_option() variant that creates evlist
>   perf evlist: Allow reusing the side band thread for more purposes
>   libsubcmd: Introduce OPT_CALLBACK_SET()
>   perf record: Introduce --switch-output-event
>   perf record: Move side band evlist setup to separate routine
> 
>  tools/lib/subcmd/parse-options.h         |  2 +
>  tools/perf/Documentation/perf-record.txt | 13 ++++
>  tools/perf/builtin-record.c              | 75 ++++++++++++++++++++----
>  tools/perf/builtin-top.c                 | 20 +++++--
>  tools/perf/util/bpf-event.c              |  3 +-
>  tools/perf/util/bpf-event.h              |  7 +--
>  tools/perf/util/evlist.c                 | 39 +++++++-----
>  tools/perf/util/evlist.h                 |  3 +-
>  tools/perf/util/parse-events.c           | 23 ++++++++
>  tools/perf/util/parse-events.h           |  1 +
>  tools/perf/util/top.h                    |  2 +-
>  11 files changed, 151 insertions(+), 37 deletions(-)
> 
> -- 
> 2.21.1
> 

