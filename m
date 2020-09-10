Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F9EC2D0E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B91420C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5xaxV9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgIJJQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:16:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726600AbgIJJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599729353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czuBZIOscqzQk5jqJ84r8SXPBiAZdteJChFUgK2pz/I=;
        b=O5xaxV9olVMenq2pzjZRTSPnh9pnm+D/94A2KvJxFUBfDt1+/g8VCvLjpjZ/E59WRKrKMk
        QDgw+zxDV1m0sKG043Ss+XcJfaGpoRoj6lGsqFFDrn0zQYB/SQeHU/a/AdgRmNBB++xs4U
        zMw4UwGnePPS7FohR2+0DSq4bpI1iwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-pzU5tW4tNKu4eAeCAvzTYA-1; Thu, 10 Sep 2020 05:15:49 -0400
X-MC-Unique: pzU5tW4tNKu4eAeCAvzTYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C4D3801FDA;
        Thu, 10 Sep 2020 09:15:46 +0000 (UTC)
Received: from krava (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 89C3C9CBA;
        Thu, 10 Sep 2020 09:15:43 +0000 (UTC)
Date:   Thu, 10 Sep 2020 11:15:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
Message-ID: <20200910091542.GD1627030@krava>
References: <20200908044228.61197-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908044228.61197-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 01:42:24PM +0900, Namhyung Kim wrote:
> Hello,
> 
> When we profile cgroup events with perf stat, it's very annoying to
> specify events and cgroups on the command line as it requires the
> mapping between events and cgroups.  (Note that perf record can use
> cgroup sampling but it's not usable for perf stat).
> 
> I guess most cases we just want to use a same set of events (N) for
> all cgroups (M), but we need to specify NxM events and NxM cgroups.
> This is not good especially when profiling large number of cgroups:
> say M=200.
> 
> So I added --multiply-cgroup option to make it easy for that case.  It
> will create NxM events from N events and M cgroups.  One more upside
> is that it can handle metrics too.

agreed that it's PITA to use -G option ;-)

> 
> For example, the following example measures IPC metric for 3 cgroups
> 
>   $ cat perf-multi-cgrp.sh
>   #!/bin/sh
>   
>   METRIC=${1:-IPC}
>   CGROUP_DIR=/sys/fs/cgroup/perf_event
>   
>   sudo mkdir $CGROUP_DIR/A $CGROUP_DIR/B $CGROUP_DIR/C
>   
>   # add backgroupd workload for each cgroup
>   echo $$ | sudo tee $CGROUP_DIR/A/cgroup.procs > /dev/null
>   yes > /dev/null &
>   echo $$ | sudo tee $CGROUP_DIR/B/cgroup.procs > /dev/null
>   yes > /dev/null &
>   echo $$ | sudo tee $CGROUP_DIR/C/cgroup.procs > /dev/null
>   yes > /dev/null &
> 
>   # run 'perf stat' in the root cgroup
>   echo $$ | sudo tee $CGROUP_DIR/cgroup.procs > /dev/null
>   perf stat -a -M $METRIC --multiply-cgroup -G A,B,C sleep 1

would it be easier to have new option for this? like:

  perf stat -a -M $METRIC --for-cgroup A,B,C
  perf stat -a -M $METRIC --for-each-cgroup A,B,C
  perf stat -a -M $METRIC --attach-cgroup A,B,C
  perf stat -a -M $METRIC --attach-to-cgroup A,B,C

I'm still not sure how the --multiply-cgroup deals with empty
cgroup A,,C but looks like we don't need this behaviour now?

thanks,
jirka

