Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC720707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emNGL6+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgHZLuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:50:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729053AbgHZLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598442635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9wmniW5Tz8S3xsc1mKjzaTYOa00481Gr0C626oPAAA=;
        b=emNGL6+xb4m8LzRZimrwkLgh2YGdq2S/N/VqZfVV39dkY5xt3unI1oNbqqysuE0rZ1psmg
        jALpFaAK062N/3L8fxf3EOQJgBaWtSks5kNAOhXPb0iXj3S8YZSCC5CT6FaXTVYCXcUeeQ
        HUcV+fN0pgZm4vwho6vq6aaDFa/Lrd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-bea3UCd7Ns2hHcY0zuKRsQ-1; Wed, 26 Aug 2020 07:50:33 -0400
X-MC-Unique: bea3UCd7Ns2hHcY0zuKRsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 108151019625;
        Wed, 26 Aug 2020 11:50:31 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 192CE18B59;
        Wed, 26 Aug 2020 11:50:26 +0000 (UTC)
Date:   Wed, 26 Aug 2020 13:50:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH] perf tools: Use %zd for size_t printf formats on 32b
Message-ID: <20200826115026.GA766106@krava>
References: <20200820212501.24421-1-chris@chris-wilson.co.uk>
 <20200821121310.GF2667554@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821121310.GF2667554@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:13:10AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 20, 2020 at 10:25:01PM +0100, Chris Wilson escreveu:
> > A couple of trivial fixes for using %zd for size_t.
> 
> Added Jiri and Namhyung, that are perf tooling reviewers, and Alexey
> Budankov, that added the ZSTD code.
> 
> Applied,
> 
> - Arnaldo
>  
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > cc: Arnaldo Carvalho de Melo <acme@kernel.org>

LGTM

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> > ---
> >  tools/perf/util/session.c | 2 +-
> >  tools/perf/util/zstd.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index ffbc9d35a383..7a5f03764702 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -87,7 +87,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
> >  		session->decomp_last = decomp;
> >  	}
> >  
> > -	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> > +	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
> >  
> >  	return 0;
> >  }
> > diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> > index d2202392ffdb..48dd2b018c47 100644
> > --- a/tools/perf/util/zstd.c
> > +++ b/tools/perf/util/zstd.c
> > @@ -99,7 +99,7 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
> >  	while (input.pos < input.size) {
> >  		ret = ZSTD_decompressStream(data->dstream, &output, &input);
> >  		if (ZSTD_isError(ret)) {
> > -			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
> > +			pr_err("failed to decompress (B): %zd -> %zd, dst_size %zd : %s\n",
> >  			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
> >  			break;
> >  		}
> > -- 
> > 2.20.1
> > 
> 
> -- 
> 
> - Arnaldo
> 

