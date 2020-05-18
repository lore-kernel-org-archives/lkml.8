Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D818C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D242065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWTdxHqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgERPtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:49:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56252 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbgERPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589816939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwzIE0QSZVOtMPCqsUuN0MrPT3Xf0Z1CID8/L7WKrps=;
        b=MWTdxHqQDi+YjIQHEPIJTHCTbva5HR+2kHj5TAzJ5my7BxHnDNcGEILH8PJGMDCBZfaN5h
        TDP0M63qhupy10U8HSBoBYtRDGE5mMxlUxNxbhDWtdMmMKC8Yb41+pHR/S5PXk1O0qzifE
        kvu8k0y3GIOnyX9oALdcds64zkHLgj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-rr5WJ3aZNH2HZcRDY4usZQ-1; Mon, 18 May 2020 11:48:54 -0400
X-MC-Unique: rr5WJ3aZNH2HZcRDY4usZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A0A280058A;
        Mon, 18 May 2020 15:48:52 +0000 (UTC)
Received: from krava (unknown [10.40.192.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5728B60BF3;
        Mon, 18 May 2020 15:48:49 +0000 (UTC)
Date:   Mon, 18 May 2020 17:48:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf stat: Fix duration_time value for higher intervals
Message-ID: <20200518154848.GA11620@krava>
References: <20200518131445.3745083-1-jolsa@kernel.org>
 <20200518152351.GD24211@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518152351.GD24211@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:23:51PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 18, 2020 at 03:14:45PM +0200, Jiri Olsa escreveu:
> > Joakim reported wrong duration_time value for interval bigger
> > than 4000 [1].
> > 
> > The problem is in the interval value we pass to update_stats
> > function, which is typed as 'unsigned int' and overflows when
> > we get over 2^32 (happens between intervals 4000 and 5000).
> > 
> > Retyping the passed value to unsigned long long.
> 
> Thanks, applied and added this:
> 
> Fixes: b90f1333ef08 ("perf stat: Update walltime_nsecs_stats in interval mode")
> 
> Ok?

yep, thanks
jirka

> 
> - Arnaldo
> 
> > [1] https://www.spinics.net/lists/linux-perf-users/msg11777.html
> > 
> > Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index e0c1ad23c768..4deb2d46a343 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -367,7 +367,7 @@ static void process_interval(void)
> >  	}
> >  
> >  	init_stats(&walltime_nsecs_stats);
> > -	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
> > +	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000ULL);
> >  	print_counters(&rs, 0, NULL);
> >  }
> >  
> > -- 
> > 2.25.4
> > 
> 
> -- 
> 
> - Arnaldo
> 

