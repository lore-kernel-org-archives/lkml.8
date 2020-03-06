Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA920726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOduI9UW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCFPFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:05:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726171AbgCFPFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583507128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ClbrAitKr0poeN9xg8y3C6UET4g/5wEOgBcbihysLtE=;
        b=WOduI9UW9H+QJCqhm7F1v0AjXMzda+oeQtcclERxmCVN/TskO0pwX2vZvx7qXhfM35BA2X
        9oMSDBbAWUOC+SgLwDazLmfNItwGPY7WrSEwWyfPWHqfNJ6FpKmvhRZcs8Dt43Mon8mLK8
        Us5sgp7dpnf5EFO18DM13Ncze/5LNAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Ha7l0eppNsiOhcw_mGBSXw-1; Fri, 06 Mar 2020 10:05:24 -0500
X-MC-Unique: Ha7l0eppNsiOhcw_mGBSXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A8398017DF;
        Fri,  6 Mar 2020 15:05:22 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B82D1001902;
        Fri,  6 Mar 2020 15:05:18 +0000 (UTC)
Date:   Fri, 6 Mar 2020 16:05:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Message-ID: <20200306150514.GE290743@krava>
References: <20200224043749.69466-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:37:39PM +0900, Namhyung Kim wrote:
> Hello,
> 
> This work is to improve cgroup profiling in perf.  Currently it only
> supports profiling tasks in a specific cgroup and there's no way to
> identify which cgroup the current sample belongs to.  So I added
> PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> integer having file handle of the cgroup.  And kernel also generates
> PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> cgroup name (path in the cgroup filesystem).  The cgroup id can be
> read from userspace by name_to_handle_at() system call so it can
> synthesize the CGROUP event for existing groups.
> 
> So why do we want this?  Systems running a large number of jobs in
> different cgroups want to profiling such jobs precisely. This includes
> container hosting systems widely used today. Currently perf supports
> namespace tracking but the systems may not use (cgroup) namespace for
> their jobs. Also it'd be more intuitive to see cgroup names (as
> they're given by user or sysadmin) rather than numeric
> cgroup/namespace id even if they use the namespaces.
> 
> From Stephane Eranian:
> > In data centers you care about attributing samples to a job not such
> > much to a process.  A job may have multiple processes which may come
> > and go. The cgroup on the other hand stays around for the entire
> > lifetime of the job. It is much easier to map a cgroup name to a
> > particular job than it is to map a pid back to a job name,
> > especially for offline post-processing.
> 
> Note that this only works for "perf_event" cgroups (obviously) so if
> users are still using cgroup-v1 interface, they need to have same
> hierarchy for subsystem(s) want to profile with it.
> 
>  * Changes from v4:
>   - use CONFIG_CGROUP_PERF
>   - move cgroup tree to perf_env
>   - move cgroup fs utility function to tools/lib/api/fs
>   - use a local buffer and check its size for cgroup systhesis

the perf top tui should all cgroup id as 0 and the headers are
misaligned

	Samples
	Overhead  cgroup id (dev/inode        Pid:Command
	  83.78%  0/0x0                 N/A     6508:perf
	   8.82%  0/0x0                 N/A        0:swapper
	   2.59%  0/0x0                 N/A     6466:perf
	   1.69%  0/0x0                 N/A     6509:perf-top-UI
	   0.56%  0/0x0                 N/A       12:rcu_sched
	   0.29%  0/0x0                 N/A      429:kworker/0:2-mm_
	   0.15%  0/0x0                 N/A     1416:sshd
	   0.12%  0/0x0                 N/A      187:migration/35


jirka

