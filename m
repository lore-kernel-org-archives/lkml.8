Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D085C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE0A2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bp/oVG+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCET65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:58:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59450 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgCET65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583438335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjNlsKr8cYuTWQZFPGpix1p72ETxPzBpElmBC4ikTQ0=;
        b=Bp/oVG+8Eo+GTLSyPMmCJcMuYFFxCILitXfd/rHDOdPDJ37LtVhqmOc+IvtMm7jUC6I+kP
        tMbR5st1pHin0hKcq1MbgP85Kuw//g+Z/PneDGi01gpGNqcTNx3L+weDshFP58K3TwBT1v
        AUqt3vTaozbk0kCnWxkYfsUC61cR0qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-F9cq20IJMQyPoxTd_jUKlw-1; Thu, 05 Mar 2020 14:58:50 -0500
X-MC-Unique: F9cq20IJMQyPoxTd_jUKlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AB3F8017CC;
        Thu,  5 Mar 2020 19:58:47 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-13.phx2.redhat.com [10.3.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE4110016EB;
        Thu,  5 Mar 2020 19:58:46 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6C41A121; Thu,  5 Mar 2020 16:58:43 -0300 (BRT)
Date:   Thu, 5 Mar 2020 16:58:43 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     zhe.he@windriver.com
Cc:     Andi Kleen <ak@linux.intel.com>, jolsa@kernel.org, meyerk@hpe.com,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH] perf: Fix crash due to null pointer dereference when
 iterating cpu map
Message-ID: <20200305195843.GA7262@redhat.com>
References: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
 <20200305152755.GA6958@redhat.com>
 <20200305183206.GA1454533@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305183206.GA1454533@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 10:32:06AM -0800, Andi Kleen escreveu:
> On Thu, Mar 05, 2020 at 12:27:55PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 05, 2020 at 06:47:19PM +0800, zhe.he@windriver.com escreveu:
> > > From: He Zhe <zhe.he@windriver.com>
> > > 
> > > NULL pointer may be passed to perf_cpu_map__cpu and then cause the
> > > following crash.
> > > 
> > > perf ftrace -G start_kernel ls
> > > failed to set tracing filters
> > > [  208.710716] perf[341]: segfault at 4 ip 00000000567c7c98
> > >                sp 00000000ff937ae0 error 4 in perf[56630000+1b2000]
> > > [  208.724778] Code: fc ff ff e8 aa 9b 01 00 8d b4 26 00 00 00 00 8d
> > >                      76 00 55 89 e5 83 ec 18 65 8b 0d 14 00 00 00 89
> > >                      4d f4 31 c9 8b 45 08 8b9
> > > Segmentation fault
> > 
> > I'm not being able to repro this here, what is the tree you are using?
> 
> I believe that's the same bug that Jann Horn reported recently for perf trace.
> I thought the patch for that went in.

Ok, Zhe, that patch is at the end of this message, and it is in:

[acme@five perf]$ git tag --contains cb71f7d43ece3d5a4f400f510c61b2ec7c9ce9a1 | grep ^v
v5.6-rc1
v5.6-rc2
v5.6-rc3
v5.6-rc4
[acme@five perf]$

Can you try with that?

- Arnaldo

commit cb71f7d43ece3d5a4f400f510c61b2ec7c9ce9a1
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Fri Jan 10 16:15:37 2020 +0100

    libperf: Setup initial evlist::all_cpus value
    
    Jann Horn reported crash in perf ftrace because evlist::all_cpus isn't
    initialized if there's evlist without events, which is the case for perf
    ftrace.
    
    Adding initial initialization of evlist::all_cpus from given cpus,
    regardless of events in the evlist.
    
    Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
    Reported-by: Jann Horn <jannh@google.com>
    Signed-off-by: Jiri Olsa <jolsa@kernel.org>
    Acked-by: Andi Kleen <ak@linux.intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Michael Petlan <mpetlan@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/20200110151537.153012-1-jolsa@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index ae9e65aa2491..5b9f2ca50591 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -164,6 +164,9 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
+	if (!evlist->all_cpus && cpus)
+		evlist->all_cpus = perf_cpu_map__get(cpus);
+
 	perf_evlist__propagate_maps(evlist);
 }
 

