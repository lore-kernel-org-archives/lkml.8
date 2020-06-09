Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D5FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B66A207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591717036;
	bh=3nKS9nvh6ZEopoO4uY4Sbrc9TYsSWEMTgTcU3kcNFr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b8NURRcbvle0D471pBfnFciHFoJifmnmTrUQ4BCmlk2QybpGqoYc17FnqYf6ZCVni
	 dSqmyKHoHFmDJ+ijs8gcOk3PlxttQfNvun12GjCJnozv5yAMkDDiK09tWjwDIn6puR
	 JEOScstPG7msXDHFw+D9S3lBJVs0X9NH1u3ZIa8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgFIPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgFIPhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:37:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D8320774;
        Tue,  9 Jun 2020 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591717033;
        bh=3nKS9nvh6ZEopoO4uY4Sbrc9TYsSWEMTgTcU3kcNFr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYsDg7vpYoQIAnv07rNNJ4rONVnN5glNqDRVYJnarX1+2bfNNHoMK9pmcu7LNaokh
         lruX+1XidWBIbzBwv/gHj7jdXukkI3+ethkT0kmC5W+vIKbOOlm3OVZAwtGhenGx7f
         z3GaKMzH0UprZY0fLHcfkI9FqINvDkpcFpXKd9Wg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31A5B40AFD; Tue,  9 Jun 2020 12:37:11 -0300 (-03)
Date:   Tue, 9 Jun 2020 12:37:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf parse-events: fix an old style declaration
Message-ID: <20200609153711.GH24868@kernel.org>
References: <20200609053610.206588-1-irogers@google.com>
 <20200609053610.206588-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609053610.206588-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 08, 2020 at 10:36:10PM -0700, Ian Rogers escreveu:
> Fixes: a26e47162d76 (perf tools: Move ALLOC_LIST into a function)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index d4e076c9c2ab..acef87d9af58 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -26,7 +26,7 @@ do { \
>  		YYABORT; \
>  } while (0)
>  
> -static struct list_head* alloc_list()
> +static struct list_head* alloc_list(void)
>  {
>  	struct list_head *list;

Thanks, applied.

- Arnaldo
