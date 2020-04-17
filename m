Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E7C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C4622201
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RfQfUsRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgDQSqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727840AbgDQSqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:46:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA95C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VuZsWEhfzTLuKGA1NHD95YdTHFY/ejA3z6ZEjfk5sbs=; b=RfQfUsRCI/Tm6COLEP0qv9xl8M
        9LwJZgSkrVJLotE94dvoWdnWSVAXgO2ykdMQclgybPk5xDIkGxKsuac9j+I42/hFQj48q1R/FIpoB
        Dqn2fqpRqVWdpzRp8yGQ1erZ9mIpyhNIQIH/SLYIxbrm+6uARErB3Asitu97JGMXbfMvDaMwZhfG+
        Afck5MbOiNB2QEWEr+EM74NILZfdfZKozuGoBp/9OdmvnEHOCED0/eAGpn6nZs6FzHWjvhR61MwhY
        LRCtR5oof7b/+lovYI0UuUZCBnCF8b0AhKboGbJQ4Cn3eYqVvzSrpsLo03vsrIglnpFpI5L+N5SV/
        FKKpWTEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPVzd-00083Z-VF; Fri, 17 Apr 2020 18:45:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74A823010BC;
        Fri, 17 Apr 2020 20:45:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F8B02B12520A; Fri, 17 Apr 2020 20:45:36 +0200 (CEST)
Date:   Fri, 17 Apr 2020 20:45:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        KP Singh <kpsingh@google.com>
Subject: Re: [PATCH] perf/core: fix parent pid/tid in task exit events
Message-ID: <20200417184536.GK20730@hirez.programming.kicks-ass.net>
References: <20200417182842.12522-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417182842.12522-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:28:42AM -0700, Ian Rogers wrote:
> Current logic yields the child task as the parent.
> 
> Before:
> $ perf record bash -c "perf list > /dev/null"
> $ perf script -D |grep 'FORK\|EXIT'
> 4387036190981094 0x5a70 [0x30]: PERF_RECORD_FORK(10472:10472):(10470:10470)
> 4387036606207580 0xf050 [0x30]: PERF_RECORD_EXIT(10472:10472):(10472:10472)
> 4387036607103839 0x17150 [0x30]: PERF_RECORD_EXIT(10470:10470):(10470:10470)
>                                                    ^
>   Note the repeated values here -------------------/
> 
> After:
> 383281514043 0x9d8 [0x30]: PERF_RECORD_FORK(2268:2268):(2266:2266)
> 383442003996 0x2180 [0x30]: PERF_RECORD_EXIT(2268:2268):(2266:2266)
> 383451297778 0xb70 [0x30]: PERF_RECORD_EXIT(2266:2266):(2265:2265)
> 

Fixes: .... ?

> Reported-by: KP Singh <kpsingh@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
