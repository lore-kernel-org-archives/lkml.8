Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C082320714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahv/ItDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgC3TgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:36:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51960 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbgC3TgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585596959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkeaEvbSYfzOX+Od6LnDOCD/zgBzApumAiZCHA1KVA8=;
        b=ahv/ItDQ63qYz71LfhIrcqFkc/gKeNzLStujrgVy4AbpBqoYVU9DLYg5ZySq5+U8bi8s8n
        AdpT4TlLho6Ezk8GP1AYh81ls8IrHldGeGiNbZHCgadWynBZBBS8tHSbvvBMxoMT1p81vu
        BkcNy5HTrE0cKylRDP8qbdj3bq6kIu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-U2ZVlOMWOJiAovnZCjU4og-1; Mon, 30 Mar 2020 15:35:55 -0400
X-MC-Unique: U2ZVlOMWOJiAovnZCjU4og-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB5113F9;
        Mon, 30 Mar 2020 19:35:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8D41001B2B;
        Mon, 30 Mar 2020 19:35:38 +0000 (UTC)
Date:   Mon, 30 Mar 2020 21:35:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v7 4/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200330193536.GC2490231@krava>
References: <20200327102528.4267-1-kjain@linux.ibm.com>
 <20200327102528.4267-5-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327102528.4267-5-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:55:26PM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index ea10fc4412c4..516504cf0ea5 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -10,7 +10,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
>  {
>  	double val;
>  
> -	if (expr__parse(&val, ctx, e))
> +	if (expr__parse(&val, ctx, e, 1))
>  		TEST_ASSERT_VAL("parse test failed", 0);
>  	TEST_ASSERT_VAL("unexpected value", val == val2);
>  	return 0;
> @@ -44,15 +44,15 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  		return ret;
>  
>  	p = "FOO/0";
> -	ret = expr__parse(&val, &ctx, p);
> +	ret = expr__parse(&val, &ctx, p, 1);
>  	TEST_ASSERT_VAL("division by zero", ret == -1);
>  
>  	p = "BAR/";
> -	ret = expr__parse(&val, &ctx, p);
> +	ret = expr__parse(&val, &ctx, p, 1);
>  	TEST_ASSERT_VAL("missing operand", ret == -1);
>  
>  	TEST_ASSERT_VAL("find other",
> -			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other) == 0);
> +			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other, 1) == 0);
>  	TEST_ASSERT_VAL("find other", num_other == 3);
>  	TEST_ASSERT_VAL("find other", !strcmp(other[0], "BAR"));
>  	TEST_ASSERT_VAL("find other", !strcmp(other[1], "BAZ"));

could we add test case for runtime param > 1 in here?
expr_parse should return value that would depend on this value..

jirka

