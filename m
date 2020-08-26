Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B072083B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJESFxd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgHZLjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:39:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729027AbgHZLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598441644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8w9qvTgsSj+61KuULjmZxV/U5oE0aAJ8Za6AVF1mAmg=;
        b=XJESFxd5c2yO8R4VUTVWPX6GwuuWgAqzt5LthPGdOLCVlLxIsg/AQm1Ry+VCV7AJlDLJP5
        8accPBGG4gNDWJKJxQzfErt3JmOLZ3sBw7QjV/HsuL9rfYI0MF7BKVZZI70VVCDLNJwi5/
        3MkKxZ50jwcMz5gKtQS1LcA6TwjDIiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-SqgwGgjuNICBN0BCeauBWg-1; Wed, 26 Aug 2020 07:34:02 -0400
X-MC-Unique: SqgwGgjuNICBN0BCeauBWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94691801AFC;
        Wed, 26 Aug 2020 11:33:59 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id E6B627D4E7;
        Wed, 26 Aug 2020 11:33:55 +0000 (UTC)
Date:   Wed, 26 Aug 2020 13:33:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf expr: Force encapsulation on expr_id_data
Message-ID: <20200826113354.GB753783@krava>
References: <20200826042910.1902374-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826042910.1902374-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:29:09PM -0700, Ian Rogers wrote:
> This patch resolves some undefined behavior where variables in
> expr_id_data were accessed (for debugging) without being defined. To
> better enforce the tagged union behavior, the struct is moved into
> expr.c and accessors provided. Tag values (kinds) are explicitly
> identified.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.c        | 64 ++++++++++++++++++++++++++++++-----
>  tools/perf/util/expr.h        | 17 +++-------
>  tools/perf/util/expr.y        |  2 +-
>  tools/perf/util/metricgroup.c |  4 +--
>  4 files changed, 62 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 53482ef53c41..1ca0992db86b 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -17,6 +17,25 @@
>  extern int expr_debug;
>  #endif
>  
> +struct expr_id_data {
> +	union {
> +		double val;
> +		struct {
> +			double val;
> +			const char *metric_name;
> +			const char *metric_expr;
> +		} ref;
> +		struct expr_id	*parent;
> +	};
> +
> +	enum {
> +		EXPR_ID_DATA__VALUE,
> +		EXPR_ID_DATA__REF,
> +		EXPR_ID_DATA__REF_VALUE,
> +		EXPR_ID_DATA__PARENT,
> +	} kind;

I like that, it's more clear than current state ;-)

could you still put a small comment for each enum above,
as a hint what it's used for?

thanks,
jirka

