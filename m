Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85311C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573262076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZteWt5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgDUMvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33201 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728719AbgDUMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587473462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VQx7vBDubdqeq6vbUpGhjqdpwRyZm3JoiWtX88v3CA=;
        b=OZteWt5yn33uD31FPBkrHFZkKVZ7Id85vNoxfLrcOD1O9qWhG/ONB1grVj5ceL76ZACyP3
        6zbNwhJhbaRBqUEzH0toJATuw+rde7SZuWkxZE9RfGSdQK4LkmUxD6lP0TCt136pR9ccMt
        cPdm6rU8JCmfE9zR6Ls5Yqu49u2LobQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-p6BdAMSrMWmfiBBhi8JTZQ-1; Tue, 21 Apr 2020 08:50:58 -0400
X-MC-Unique: p6BdAMSrMWmfiBBhi8JTZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 147FC802560;
        Tue, 21 Apr 2020 12:50:56 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8C635DA66;
        Tue, 21 Apr 2020 12:50:52 +0000 (UTC)
Date:   Tue, 21 Apr 2020 14:50:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 13/15] perf intel-pt: Add support for text poke events
Message-ID: <20200421125050.GG809467@krava>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-14-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405201327.7332-14-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 11:13:25PM +0300, Adrian Hunter wrote:
> Select text poke events when available and the kernel is being traced.
> Process text poke events to invalidate entries in Intel PT's instruction
> cache.
> 
> Example:
> 
>   The example requires kernel config:
>     CONFIG_PROC_SYSCTL=y
>     CONFIG_SCHED_DEBUG=y
>     CONFIG_SCHEDSTATS=y
> 
>   Before:
> 
>     # perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M &
>     # cat /proc/sys/kernel/sched_schedstats
>     0
>     # echo 1 > /proc/sys/kernel/sched_schedstats
>     # cat /proc/sys/kernel/sched_schedstats
>     1
>     # echo 0 > /proc/sys/kernel/sched_schedstats
>     # cat /proc/sys/kernel/sched_schedstats
>     0
>     # kill %1
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 3.341 MB perf.data.before ]
>     [1]+  Terminated                 perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M
>     # perf script -i perf.data.before --itrace=e >/dev/null
>     Warning:
>     474 instruction trace errors
> 
>   After:
> 
>     # perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
>     # cat /proc/sys/kernel/sched_schedstats
>     0
>     # echo 1 > /proc/sys/kernel/sched_schedstats
>     # cat /proc/sys/kernel/sched_schedstats
>     1
>     # echo 0 > /proc/sys/kernel/sched_schedstats
>     # cat /proc/sys/kernel/sched_schedstats
>     0
>     # kill %1
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 2.646 MB perf.data.after ]
>     [1]+  Terminated                 perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M
>     # perf script -i perf.data.after --itrace=e >/dev/null


I'm still seeing some, probably I'm missing some CONFIG, will check

	# ./perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
	[1] 5880
	# cat /proc/sys/kernel/sched_schedstats
	0
	# echo 1 > /proc/sys/kernel/sched_schedstats
	# cat /proc/sys/kernel/sched_schedstats
	1
	# echo 0 > /proc/sys/kernel/sched_schedstats
	# kill %1
	# [ perf record: Woken up 1 times to write data ]
	[ perf record: Captured and wrote 6.181 MB perf.data.after ]
	[1]+  Terminated              ./perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M
	# ./perf script --itrace=e -i perf.data.after > /dev/null
	Warning:
	18837 instruction trace errors

	# ./perf script --itrace=e -i perf.data.after | head
	instruction trace error type 1 time 9274.420582345 cpu 9 pid 845 tid 845 ip 0xffffffff814e6cf2 code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422229726 cpu 39 pid 5880 tid 5880 ip 0xffffffffa030a320 code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422231972 cpu 39 pid 5880 tid 5880 ip 0xffffffffa0315c1c code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422236141 cpu 39 pid 5880 tid 5880 ip 0xffffffff81143263 code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422237424 cpu 39 pid 5880 tid 5880 ip 0xffffffff8115c388 code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422239028 cpu 39 pid 5880 tid 5880 ip 0xffffffff811428c9 code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422239028 cpu 39 pid 5880 tid 5880 ip 0xffffffffa13279fb code 5: Failed to get instruction
	instruction trace error type 1 time 9274.422242556 cpu 39 pid 5880 tid 5880 ip 0xffffffff814e9c73 code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422258915 cpu 39 pid 5880 tid 5880 ip 0xffffffff810d7da2 code 6: Trace doesn't match instruction
	instruction trace error type 1 time 9274.422258915 cpu 39 pid 5880 tid 5880 ip 0xffffffffa030a0b2 code 6: Trace doesn't match instruction

jirka

