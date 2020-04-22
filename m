Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A33C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE91A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGgpj1Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDVIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:20:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28023 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbgDVIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587543635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h9sdbrr2N7++3Tl1ZR7K/rxjw4jvgt+CV+/7OZIYPM=;
        b=gGgpj1KtE9s9KcCHV+xtDN67+vrAuezB4SEOhSsoGTmEKgbWG8Q9+ZeDk5T/rT/co7hgB4
        7QhW1W+pVtsUSNt9/Sec6EHanuEURpOoMvZSOT5qEXGdeQvHo0q4hJhEvHckFXD23Ydw9H
        zoO3ZY9/cZlHcTPWQZqYArUCFee57WA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-VgxUb8phNK6X18Z7mNTh9g-1; Wed, 22 Apr 2020 04:20:30 -0400
X-MC-Unique: VgxUb8phNK6X18Z7mNTh9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50F1D107B786;
        Wed, 22 Apr 2020 08:20:29 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CDF65C219;
        Wed, 22 Apr 2020 08:20:19 +0000 (UTC)
Date:   Wed, 22 Apr 2020 10:20:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf script: avoid null dereference on symbol
Message-ID: <20200422082016.GE962614@krava>
References: <20200421004329.43109-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421004329.43109-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 05:43:29PM -0700, Ian Rogers wrote:
> al->sym may be null given current if conditions and may cause a segv.
> 
> Fixes: cd2bedb7863e9 (perf script: Allow --symbol to accept hexadecimal addresses)

seems it's wrong commit number, I see it under d2bedb7863e9


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index dc0e11214ae1..f581550a3015 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -626,7 +626,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  			ret = strlist__has_entry(symbol_conf.sym_list,
>  						al->sym->name);
>  		}
> -		if (!(ret && al->sym)) {
> +		if (!ret && al->sym) {

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  			snprintf(al_addr_str, sz, "0x%"PRIx64,
>  				al->map->unmap_ip(al->map, al->sym->start));
>  			ret = strlist__has_entry(symbol_conf.sym_list,
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

