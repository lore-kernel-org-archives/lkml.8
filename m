Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19D6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA42206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3p7nbML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHCLgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:36:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbgHCLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596454572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCtVsAq27Rguno+ZBtzk38dyURdoRvH1j0hpCY8qr+g=;
        b=Q3p7nbMLvTOEGLu0ylKNidJkvepi7d4kArthtDyfhW2SbM+oQX8oALW1cFnNsrIrK8MKiR
        HZWlRJCBXEjjHc4wiMx2ND4Gve1BI5qPRfgqPg3oMzWouF8CHQBpf2gWDxtTTFjjaD4HtI
        YAm+j93PYDdrFEZcCEEHQ9BvaHHptkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-S1xSutV5PHGdZOCyzvj-9A-1; Mon, 03 Aug 2020 07:36:10 -0400
X-MC-Unique: S1xSutV5PHGdZOCyzvj-9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2502100A8C1;
        Mon,  3 Aug 2020 11:36:08 +0000 (UTC)
Received: from krava (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id A046971762;
        Mon,  3 Aug 2020 11:36:03 +0000 (UTC)
Date:   Mon, 3 Aug 2020 13:35:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 2/6] perf tools: Store clock references for -k/--clockid
 option
Message-ID: <20200803113559.GE139381@krava>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-3-jolsa@kernel.org>
 <20200803035550.GA686281@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803035550.GA686281@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 12:55:50PM +0900, Namhyung Kim wrote:

SNIP

> > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> > index b6472e463284..c484e81987c7 100644
> > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > @@ -389,6 +389,19 @@ struct {
> >  Example:
> >   cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
> >  
> > +	HEADER_CLOCK_DATA = 29,
> > +
> > +	Contains clock id and its reference time together with wall clock
> > +	time taken at the 'same time', both values are in nanoseconds.
> > +	The format of data is as below.
> > +
> > +struct {
> > +	u32 version;  /* version = 1 */
> > +	u32 clockid;
> > +	u64 clockid_time_ns;
> > +	u64 wall_clock_ns;
> > +};
> > +
> 
> It seems that it's slightly different than what it actually write to a file.
> Specifically the last two fields should be reversed IMHO.

oops, you're right.. wil fix in new version

> 
> 
> >  	other bits are reserved and should ignored for now
> >  	HEADER_FEAT_BITS	= 256,
> >
> [SNIP]
> 
> > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > index 1ab2682d5d2b..4098a63d5e64 100644
> > --- a/tools/perf/util/env.h
> > +++ b/tools/perf/util/env.h
> > @@ -100,6 +100,18 @@ struct perf_env {
> >  	/* For fast cpu to numa node lookup via perf_env__numa_node */
> >  	int			*numa_map;
> >  	int			 nr_numa_map;
> > +
> > +	/* For real clock time refference. */
> 
> typo: reference

ok

SNIP

> > +	else {
> > +		strftime(date, sizeof(date), "%F %T", &ltime);
> > +		scnprintf(tstr, sizeof(tstr), "%s.%06d",
> > +			  date, (int) tod_ns.tv_usec);
> > +	}
> > +
> > +	fprintf(fp, "# clockid: %s (%u)\n", clockid_name(clockid), clockid);
> > +	fprintf(fp, "# reference time: %s = %ld.%06d (TOD) = %ld.%ld (%s)\n",
> 
> Shouldn't the last one be %ld.%09ld?

sure, why not

thanks,
jirka

