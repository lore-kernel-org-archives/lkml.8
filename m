Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B49C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61C4208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGeci5SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD2Rtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:49:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39169 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726423AbgD2Rtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588182579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fUqOddpdx9XG5JA8XF43s3WsYPLEIhrV8wroid1CJFo=;
        b=KGeci5SDOc20Ypgh+GYznO/U1XWW2tGGUcFqtaE1pCWXNji2zpj9f/pfML8A2WIgushT0J
        lzTb6SDKT1kZdoZdEuF77MjFwXACeB2h03voYjVpcK8Cv7KIqtAfhGieyU3FmOz72r/cC+
        GL8GDcQEb+5Ol4hS9uQlTxT9v7i0kh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-S1NbgM8hMlGU9UCl4v5vBw-1; Wed, 29 Apr 2020 13:49:35 -0400
X-MC-Unique: S1NbgM8hMlGU9UCl4v5vBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFBD21800D4A;
        Wed, 29 Apr 2020 17:49:33 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18BB260607;
        Wed, 29 Apr 2020 17:49:33 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 676A61B0; Wed, 29 Apr 2020 14:49:29 -0300 (BRT)
Date:   Wed, 29 Apr 2020 14:49:29 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     zhe.he@windriver.com, jolsa@kernel.org, ak@linux.intel.com,
        meyerk@hpe.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Add NULL pointer check for cpu_map iteration and
 NULL assignment for all_cpus.
Message-ID: <20200429174929.GA3777@redhat.com>
References: <1583665157-349023-1-git-send-email-zhe.he@windriver.com>
 <20200318103224.GE821557@krava>
 <20200318133435.GA14726@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318133435.GA14726@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 10:34:35AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 18, 2020 at 11:32:24AM +0100, Jiri Olsa escreveu:
> > On Sun, Mar 08, 2020 at 06:59:17PM +0800, zhe.he@windriver.com wrote:
> > > From: He Zhe <zhe.he@windriver.com>
> > > 
> > > NULL pointer may be passed to perf_cpu_map__cpu and then cause crash,
> > > such as the one commit cb71f7d43ece ("libperf: Setup initial evlist::all_cpus value")
> > > fix.
> > > 
> > > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> > 
> > > ---
> > >  tools/perf/lib/cpumap.c | 2 +-
> > >  tools/perf/lib/evlist.c | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> this is in tools/lib/perf/ for some time already, I'll do the changes
> there, thanks,

Fixed up from tools/perf/lib to tools/lib/perf and applied.
 
> - Arnaldo
> 
> > > 
> > > diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> > > index f93f4e7..ca02150 100644
> > > --- a/tools/perf/lib/cpumap.c
> > > +++ b/tools/perf/lib/cpumap.c
> > > @@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
> > >  
> > >  int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
> > >  {
> > > -	if (idx < cpus->nr)
> > > +	if (cpus && idx < cpus->nr)
> > >  		return cpus->map[idx];
> > >  
> > >  	return -1;
> > > diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
> > > index 5b9f2ca..f87a239 100644
> > > --- a/tools/perf/lib/evlist.c
> > > +++ b/tools/perf/lib/evlist.c
> > > @@ -127,6 +127,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
> > >  	perf_cpu_map__put(evlist->cpus);
> > >  	perf_thread_map__put(evlist->threads);
> > >  	evlist->cpus = NULL;
> > > +	evlist->all_cpus = NULL;
> > >  	evlist->threads = NULL;
> > >  	fdarray__exit(&evlist->pollfd);
> > >  }
> > > -- 
> > > 2.7.4
> > > 

