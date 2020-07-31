Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781A52245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdbRCHnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgGaQPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:15:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728779AbgGaQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596212130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OblQAb8zJLLzk+oGwOoJ6OELXYf9Y5L/lBSvmC1zhI=;
        b=YdbRCHncT+8H20b4VaGEOM2BNN6cRMB+3hhHksxg6XCpX9LSO6XC3SDBq8bbba5YuvhylP
        Eeb1q1Md20oFwYQaVmDp2M5C+FhWxrtZvMkb3Rh7NANFVP27prWPonfXuEyzeBV015UqM3
        yuM6ykDEQwLTOsn9SuDHlEb/bjJoiJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-lQGbkDLYOZm-Vu0SnXfsew-1; Fri, 31 Jul 2020 12:15:26 -0400
X-MC-Unique: lQGbkDLYOZm-Vu0SnXfsew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C3C61005510;
        Fri, 31 Jul 2020 16:15:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with SMTP id 27F1C10013D9;
        Fri, 31 Jul 2020 16:15:19 +0000 (UTC)
Date:   Fri, 31 Jul 2020 18:15:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <20200731161519.GB4296@krava>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-3-jolsa@kernel.org>
 <9be7eb7b-4f73-84cc-95e9-e65101b30819@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be7eb7b-4f73-84cc-95e9-e65101b30819@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 06:52:36PM +0300, Alexey Budankov wrote:
> 
> On 31.07.2020 0:39, Jiri Olsa wrote:
> > Adding new CLOCK_DATA feature that stores reference times
> > when -k/--clockid option is specified.
> > 
> > It contains clock id and its reference time together with
> > wall clock time taken at the 'same time', both values are
> > in nanoseconds.
> > 
> > The format of data is as below:
> > 
> >   struct {
> >        u32 version;  /* version = 1 */
> >        u32 clockid;
> >        u64 clockid_time_ns;
> >        u64 wall_clock_ns;
> >   };
> > 
> > This clock reference times will be used in following changes
> > to display wall clock for perf events.
> > 
> > It's available only for recording with clockid specified,
> > because it's the only case where we can get reference time
> > to wallclock time. It's can't do that with perf clock yet.
> > 
> > Original-patch-by: David Ahern <dsahern@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../Documentation/perf.data-file-format.txt   |  13 ++
> >  tools/perf/builtin-record.c                   |  41 +++++++
> >  tools/perf/util/env.h                         |  12 ++
> >  tools/perf/util/header.c                      | 112 ++++++++++++++++++
> >  tools/perf/util/header.h                      |   1 +
> >  5 files changed, 179 insertions(+)
> > 
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
> >  	other bits are reserved and should ignored for now
> >  	HEADER_FEAT_BITS	= 256,
> >  
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 468c669519a6..f8280e721e1a 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -70,6 +70,7 @@
> >  #include <linux/time64.h>
> >  #include <linux/zalloc.h>
> >  #include <linux/bitmap.h>
> > +#include <sys/time.h>
> >  
> >  struct switch_output {
> >  	bool		 enabled;
> > @@ -1203,6 +1204,9 @@ static void record__init_features(struct record *rec)
> >  	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
> >  		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
> >  
> > +	if (!rec->opts.use_clockid)
> > +		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
> > +
> >  	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
> >  	if (!record__comp_enabled(rec))
> >  		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
> > @@ -1551,6 +1555,40 @@ static int record__setup_sb_evlist(struct record *rec)
> >  	return 0;
> >  }
> >  
> > +static int record__init_clock(struct record *rec)
> > +{
> > +	struct perf_session *session = rec->session;
> > +	struct timespec ref_clockid;
> > +	struct timeval ref_tod;
> > +	u64 ref;
> > +
> > +	if (!rec->opts.use_clockid)
> > +		return 0;
> > +
> > +	session->header.env.clock.clockid = rec->opts.clockid;
> > +
> > +	if (gettimeofday(&ref_tod, NULL) != 0) {
> > +		pr_err("gettimeofday failed, cannot set reference time.\n");
> > +		return -1;
> > +	}
> > +
> > +	if (clock_gettime(rec->opts.clockid, &ref_clockid)) {
> > +		pr_err("clock_gettime failed, cannot set reference time.\n");
> > +		return -1;
> > +	}
> 
> It might also want to be implemented in a loop and iteration with minimal
> time delta is chosen to improve synchronization accuracy and also mitigate
> possible context switches between gettimeofday() and clock_gettime() calls.

right, we could make this more accurate.. I'll post some follow up
change with that

thanks,
jirka

