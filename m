Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B7C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D237D208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgZ+VlN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgHaJL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:11:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43439 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728216AbgHaJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598865083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+JqshhNpPVNnhGHJKO6L4g90YtK9/JkTr418DUGXswM=;
        b=PgZ+VlN1bkvSz1DRl3vbms8MNThwSMGgasiBkfYvA0dK/3IFFqorTOYRUZCUX+ftFUQkuR
        GGCVN4DIG/FTA4eroGGeTN6ltJZQ8kNpdxKq9aIXIqeWJFiDSmSUvefutCtk5U1Iebw8a1
        VmqFUPnH+XaAMzOPwfK5GzZ41fSvOso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-jGeupWj7PIWkIUWKuBAZlA-1; Mon, 31 Aug 2020 05:11:18 -0400
X-MC-Unique: jGeupWj7PIWkIUWKuBAZlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D97341006701;
        Mon, 31 Aug 2020 09:11:16 +0000 (UTC)
Received: from krava (unknown [10.40.193.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id C21707EB6D;
        Mon, 31 Aug 2020 09:11:13 +0000 (UTC)
Date:   Mon, 31 Aug 2020 11:11:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH v2 9/9] perf: Remove x86 specific rdpmc test
Message-ID: <20200831091113.GA406859@krava>
References: <20200828205614.3391252-1-robh@kernel.org>
 <20200828205614.3391252-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828205614.3391252-10-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:56:14PM -0600, Rob Herring wrote:
> Now that we have a common libperf based userspace counter read test
> with the same functionality as the x86 specific rdpmc test, let's remove
> it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This one is optional. On the plus side, it eliminates a copy of the read
> loop. The main downside I see is loosing the ability to test in 'perf test'.
> 
> 
>  tools/perf/arch/x86/include/arch-tests.h |   1 -
>  tools/perf/arch/x86/tests/Build          |   1 -
>  tools/perf/arch/x86/tests/arch-tests.c   |   4 -
>  tools/perf/arch/x86/tests/rdpmc.c        | 182 -----------------------
>  4 files changed, 188 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c
> 
> diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> index c41c5affe4be..d9c32ba0cdac 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -6,7 +6,6 @@
>  struct test;
> 
>  /* Tests */
> -int test__rdpmc(struct test *test __maybe_unused, int subtest);

we don't currently run libperf tests as part of perf test suite,
so before we do that, I rather not remove the tests..

feel free to add the code that runs libperf tests within 'perf test'
command ;-)

thanks,
jirka

