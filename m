Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A8621974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkTdIS7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgFRAtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFRAtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:49:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C6C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:49:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so1978347pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o9bocZzzzDNWldBOb19aL0JrD3DAgfCWT0/GuyKYFAk=;
        b=rkTdIS7MhTO2I2wBBSPfMICXPfkKNi2NtHsoGpbAbwz1dYXchXPlCSPnuLxbn/l0tp
         BYjRl0UeKvJtYFYCA+ZDwNmDZRoH7Z4KEEOIUwSBbTTRkSH2b3NChumxwKzQizsj7NSR
         t1RWZ7uJwksNI8hUSdkZuOKgbn/gMo7v3eVn3enDzpQfQgIEEfKJzPX24i11kGJMnlmu
         LszBMUIeSDLOvLxv6lVb/09WsJDi746Yx1LgXtpCCCXGipSW+nDFqd9ldeFK+KTyG0nG
         B9+5MTWwWP4hOq1u+gK+oeYLa6cbj9wA6Kfu8K1Wt7R7Auu9Rf8qQVuLgx2W8rXtYUP1
         7GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o9bocZzzzDNWldBOb19aL0JrD3DAgfCWT0/GuyKYFAk=;
        b=OCY8GnZnamgku1UK7jLK/jftIFSl35p0rJkkZ+UKZCL2vMe58lDTHRKrD5Y/hsIFr2
         rBornlVwnw2SDxxhGDhh6wK3ZtpzcXV6X+9R7JSeOdO3qHnRs8g/LyTyXqKij0xLVIOY
         xXU0dAE25mK54YBxV8myB2rfyc0JMAeeKJWK44IGAiufeXuaP7o2GLC9gaSVgylfSUvl
         dmRbp2tpc4nCQXCi7rEVmerCXXK50bfx9TK5MKBHEsQxeUSUic15j+d6FFSwHM2IPi7e
         5IorLWcaejxERI5lX9TDZLVgmPeqij5VzN8dKYbgpkTPotCfGCFPmi1Jc+hhQrDSu9DK
         Ok2Q==
X-Gm-Message-State: AOAM532bX+OMNBo9pN1OGa0t4J2NA7CkVWFd3qW1K1McyGQCpnGkyr/6
        nLDFKbCkdDkKgEwT9gDPHBA=
X-Google-Smtp-Source: ABdhPJxwAuxQgSKygXY6lXFu92hW+tAcD659N6a7lixSQcORY2EM5Sb4JB3dVmrS0rzcc1Fk5pdCEw==
X-Received: by 2002:a63:144c:: with SMTP id 12mr938274pgu.189.1592441341992;
        Wed, 17 Jun 2020 17:49:01 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id a19sm918008pfd.165.2020.06.17.17.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 17:49:01 -0700 (PDT)
Date:   Wed, 17 Jun 2020 17:48:58 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Subject: Re: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation
Message-ID: <20200618004858.GA326453@gmail.com>
References: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:22:26AM -0700, Peter Oskolkov wrote:
> From 6fbe0261204692a7f488261ab3c4ac696b91db5c Mon Sep 17 00:00:00 2001
> From: Peter Oskolkov <posk@google.com>
> Date: Tue, 9 Jun 2020 16:03:14 -0700
> Subject: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation
> 
> This is an RFC!
> 
> As Paul Turner presented at LPC in 2013 ...
> - pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
> - video: https://www.youtube.com/watch?v=KXuZi9aeGTw
> 
> ... Google has developed an M:N userspace threading subsystem backed
> by Google-private SwitchTo Linux Kernel API (page 17 in the pdf referenced
> above). This subsystem provides latency-sensitive services at Google with
> fine-grained user-space control/scheduling over what is running when,
> and this subsystem is used widely internally (called schedulers or fibers).
> 
> This RFC patchset is the first step to open-source this work. As explained
> in the linked pdf and video, SwitchTo API has three core operations: wait,
> resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
> that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
> on top of which user-space threading libraries can be built.
> 
> Another common use case for FUTEX_SWAP is message passing a-la RPC
> between tasks: task/thread T1 prepares a message,
> wakes T2 to work on it, and waits for the results; when T2 is done, it
> wakes T1 and waits for more work to arrive. Currently the simplest
> way to implement this is
> 
> a. T1: futex-wake T2, futex-wait
> b. T2: wakes, does what it has been woken to do
> c. T2: futex-wake T1, futex-wait
> 
> With FUTEX_SWAP, steps a and c above can be reduced to one futex operation
> that runs 5-10 times faster.
> 

Hi Peter,

We have a good use-case in gVisor for this new futex command.

gVisor accesses a file system through a file proxy, called the Gofer.
The gofer runs as a separate process, that is isolated from the sandbox
(sentry). Gofer instances communicate with their respective sentry using
the 9P-like protocol. We used sockets as communication channels, but
recently we switched to the flipcall (1) library which improve
performance by using shared memory for data (reducing memory copies) and
using futexes for control signaling (which is much cheaper than
sendto/recvfrom/sendmsg/recvmsg).

I modified the flipcall library to use FUTEX_SWAP and I see a
significant performance improvement.

A low level benchmarks (2) shows that req/resp is more than five time
faster with FUTEX_SWAP than with FUTEX_WAKE&FUTEX_WAIT. This is more or
less the same test what you did.

* FUTEX_WAKE & FUTEX_WAIT
BenchmarkSendRecv-8     88396     13625 ns/op

* FUTEX_SWAP
BenchmarkSendRecv-8    479604      2524 ns/op

And a more high-level test (3) which benchmarks the open syscall in
gVisor shows about 40% improvements.

* FUTEX_WAKE & FUTEX_WAIT
BM_Open/1/real_time_mean        93996 ns

* FUTEX_SWAP
BM_Open/1/real_time_mean        53136 ns

I believe there are many use-cases for FUTEX_SWAP in other projects.

1. https://github.com/google/gvisor/tree/master/pkg/flipcall
2. https://github.com/google/gvisor/blob/master/pkg/flipcall/flipcall_test.go#L361
3. https://github.com/google/gvisor/blob/master/test/perf/linux/open_benchmark.cc

Thanks,
Andrei
