Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB8C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E079520801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2DkaAzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgBQRXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:23:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgBQRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PPQfNLv2aAcjlRivWg3mw/uzZPYTTEjDciukTCgbV4A=; b=O2DkaAzXd2yZj9YfTbFPFeVhv5
        m8019CGU7SR+84mZYOFrg+l82l7yha1iZ/0fKLblqnXQIU/604pW38OzS8+SdtCn9Yh5tQ4rO0QlJ
        Xi4ylvdONfifUHCSUxCE7XSPPPPZaJAKKcU1sx8lVdqouRBzC7gJGVJklWVyadI9GilF3CmmNw5Rq
        ps0INrTd4++3oCa9kpdH8nmPhargHVglyV+8FCqNpQhKLWgaxjVWjAwaSSfIaPBwwk1J5xaJ0Jm8K
        yOj8aCwhqpSRj8BPKWtKuacBv+SCb0ChJs74S3zO41lOFZrDbpyKxNmm/f+kKV0c2glfhkTEQ34le
        ajvWXBAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3k70-0003EB-Bq; Mon, 17 Feb 2020 17:23:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 217ED300446;
        Mon, 17 Feb 2020 18:21:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C2202B9265B8; Mon, 17 Feb 2020 18:23:11 +0100 (CET)
Date:   Mon, 17 Feb 2020 18:23:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 3/6] perf: Use min_heap in visit_groups_merge
Message-ID: <20200217172311.GP14879@hirez.programming.kicks-ass.net>
References: <20200214075133.181299-1-irogers@google.com>
 <20200214075133.181299-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214075133.181299-4-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:51:30PM -0800, Ian Rogers wrote:
>  
> -		*evt = perf_event_groups_next(*evt);
> +		next = perf_event_groups_next(itrs[0]);
> +		if (next) {
> +			min_heap_pop_push(&event_heap, &next,
> +					&perf_min_heap);
> +		} else
> +			min_heap_pop(&event_heap, &perf_min_heap);
>  	}

Like this:

@@ -3585,9 +3581,9 @@ static noinline int visit_groups_merge(s
 		if (ret)
 			return ret;
 
-		next = perf_event_groups_next(*evt);
-		if (next)
-			min_heap_pop_push(&event_heap, &next, &perf_min_heap);
+		*evt = perf_event_groups_next(*evt);
+		if (*evt)
+			min_heapify(&event_heap, 0, &perf_min_heap);
 		else
 			min_heap_pop(&event_heap, &perf_min_heap);
 	}

That's an 'obvious' replace and resort and obviates the need for that
weird pop that doesn't return nothing operation.
