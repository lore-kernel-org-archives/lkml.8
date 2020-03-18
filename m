Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16719C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57020772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USlc4yqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCRNe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:34:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36602 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbgCRNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584538468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rwy2W2p7dMLeHMVGRHL4A2JsbSyvgsJe+2hxKr/b+dA=;
        b=USlc4yqUno+AYFMQ/n/ep+CyDqqyybGbD8t3tqX+gDSLLmm4Js8Ff4a/ljFguZaS+7MmNy
        kFl+RdudhTtuL2DcTXqBhuYywohz+pF06XBQ+FNO6ItRX401r6WjO+tVldZTUPl9Ho5FyA
        sbhWBfH4BZM4vXxMi2E/KXR/n+daji8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-wnANbA4UPDyuupoy2miDvg-1; Wed, 18 Mar 2020 09:34:23 -0400
X-MC-Unique: wnANbA4UPDyuupoy2miDvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D31149C2;
        Wed, 18 Mar 2020 13:34:22 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B248A5C219;
        Wed, 18 Mar 2020 13:34:21 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 1C5A8160; Wed, 18 Mar 2020 10:34:35 -0300 (BRT)
Date:   Wed, 18 Mar 2020 10:34:35 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     zhe.he@windriver.com, jolsa@kernel.org, ak@linux.intel.com,
        meyerk@hpe.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Add NULL pointer check for cpu_map iteration and
 NULL assignment for all_cpus.
Message-ID: <20200318133435.GA14726@redhat.com>
References: <1583665157-349023-1-git-send-email-zhe.he@windriver.com>
 <20200318103224.GE821557@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318103224.GE821557@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 11:32:24AM +0100, Jiri Olsa escreveu:
> On Sun, Mar 08, 2020 at 06:59:17PM +0800, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> > 
> > NULL pointer may be passed to perf_cpu_map__cpu and then cause crash,
> > such as the one commit cb71f7d43ece ("libperf: Setup initial evlist::all_cpus value")
> > fix.
> > 
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/lib/cpumap.c | 2 +-
> >  tools/perf/lib/evlist.c | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)

this is in tools/lib/perf/ for some time already, I'll do the changes
there, thanks,

- Arnaldo

> > 
> > diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> > index f93f4e7..ca02150 100644
> > --- a/tools/perf/lib/cpumap.c
> > +++ b/tools/perf/lib/cpumap.c
> > @@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
> >  
> >  int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
> >  {
> > -	if (idx < cpus->nr)
> > +	if (cpus && idx < cpus->nr)
> >  		return cpus->map[idx];
> >  
> >  	return -1;
> > diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
> > index 5b9f2ca..f87a239 100644
> > --- a/tools/perf/lib/evlist.c
> > +++ b/tools/perf/lib/evlist.c
> > @@ -127,6 +127,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
> >  	perf_cpu_map__put(evlist->cpus);
> >  	perf_thread_map__put(evlist->threads);
> >  	evlist->cpus = NULL;
> > +	evlist->all_cpus = NULL;
> >  	evlist->threads = NULL;
> >  	fdarray__exit(&evlist->pollfd);
> >  }
> > -- 
> > 2.7.4
> > 

