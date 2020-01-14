Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB9BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B42B24655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZATTa1i1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgANQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:29:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53941 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbgANQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579019343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPYT5vQh2Yd4w7szH352o1kr3SakRWqAyBbk7sSmaIs=;
        b=ZATTa1i1ovuqN7g7acAoF8nX1tK2R9PgT10vbIVVEEcGyhG/+ouKzm2R/5O9QZKsNDlq6b
        nzqxlLQx9p+cEk2bvt5uV9/ZxEqOrW9VhvPPhNUkiP+We7V+dAnHpB9VSd3VUlIOwGnjaf
        +BNEZBS7xjOnHGbP2i4Pp5oFQKyFalM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-jZQy2EB5PPidwbylHzvu8Q-1; Tue, 14 Jan 2020 11:29:02 -0500
X-MC-Unique: jZQy2EB5PPidwbylHzvu8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63A771143798;
        Tue, 14 Jan 2020 16:29:00 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-20.phx2.redhat.com [10.3.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C395550A8F;
        Tue, 14 Jan 2020 16:28:59 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 78A26119; Tue, 14 Jan 2020 13:28:55 -0300 (BRT)
Date:   Tue, 14 Jan 2020 13:28:55 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andres Freund <andres@anarazel.de>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH] perf c2c: Fix sorting.
Message-ID: <20200114162855.GD3115@redhat.com>
References: <20200109043030.233746-1-andres@anarazel.de>
 <20200109084822.GD52936@krava>
 <20200109170041.wgvxcci3mkjh4uee@alap3.anarazel.de>
 <20200109214611.GC82989@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109214611.GC82989@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 09, 2020 at 10:46:11PM +0100, Jiri Olsa escreveu:
> On Thu, Jan 09, 2020 at 09:00:41AM -0800, Andres Freund wrote:
> 
> SNIP
> 
> > > >  tools/perf/builtin-c2c.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > > > index e69f44941aad..f2e9d2b1b913 100644
> > > > --- a/tools/perf/builtin-c2c.c
> > > > +++ b/tools/perf/builtin-c2c.c
> > > > @@ -595,8 +595,8 @@ tot_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> > > >  {
> > > >  	struct c2c_hist_entry *c2c_left;
> > > >  	struct c2c_hist_entry *c2c_right;
> > > > -	unsigned int tot_hitm_left;
> > > > -	unsigned int tot_hitm_right;
> > > > +	uint64_t tot_hitm_left;
> > > > +	uint64_t tot_hitm_right;
> > > 
> > > that change looks right, but I can't see how that could
> > > happened because of change in Fixes: tag
> > > 
> > > was the return statement of this function:
> > > 
> > >         return tot_hitm_left - tot_hitm_right;
> > > 
> > > considered to be 'unsigned int' and then converted to int64_t,
> > > which would treat negative 'unsigned int' as big positive 'int64_t'?
> > 
> > Correct. So e.g. when comparing 1 and 2 tot_hitm, we'd get (int64_t)
> > UINT_MAX as a result, which is obviously wrong. However, due to
> > hist_entry__sort() returning int at the time, this was masked, as the
> > int64_t was cast to int. Thereby again yielding a negative number for
> > the comparisons of hist_entry__sort()'s result.  After
> > hist_entry__sort() was fixed however, there never could be negative
> > return values (but 0's are possible) of hist_entry__sort() for c2c.
> 
> I see.. ok
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

