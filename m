Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA92520659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4ybqWxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgFBOFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:05:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725841AbgFBOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591106718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1guZkEyTv9QiJnXWlXnMJ1k5OsQdjrJz0ik8FevwGIM=;
        b=A4ybqWxpS3tzSOE/mftjxuOJuwnnIdW4AESlEgCwpoFi4qLPtRCwdA9fZUHrZR5maapG2g
        mCRBNtS66JG5re8NHA+KXydzH5oApXySicEV4pFOyi2SlalwECHyzeptVYP4OhYmovX9XS
        pFGUTWBbWMDfg93xleGWZO7YQDSTgZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-8FGclkJYP0atDEFa4hhsNw-1; Tue, 02 Jun 2020 10:05:14 -0400
X-MC-Unique: 8FGclkJYP0atDEFa4hhsNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3867107ACF4;
        Tue,  2 Jun 2020 14:05:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 004245C1D6;
        Tue,  2 Jun 2020 14:05:08 +0000 (UTC)
Date:   Tue, 2 Jun 2020 16:05:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3] perf stat: Ensure group is defined on top of the same
 cpu mask
Message-ID: <20200602140508.GA1169993@krava>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava>
 <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <20200602101736.GE1112120@krava>
 <20200602134256.GO31795@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602134256.GO31795@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:42:56AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 02, 2020 at 12:17:36PM +0200, Jiri Olsa escreveu:
> > Jin Yao reported the issue (and posted first versions of this change)
> > with groups being defined over events with different cpu mask.
>  
> > This causes assert aborts in get_group_fd, like:
>  
> >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> >   Aborted
>  
> > All the events in the group have to be defined over the same
> > cpus so the group_fd can be found for every leader/member pair.
>  
> > Adding check to ensure this condition is met and removing the
> > group (with warning) if we detect mixed cpus, like:
>  
> >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> >   WARNING: event cpu maps do not match, disabling group:
> >     anon group { power/energy-cores/, cycles }
> >     anon group { instructions, power/energy-cores/ }
> 
> So it doesn't disable the 'group', it disables the 'grouping' of those
> events, right? I.e. reading the WARNING, I thought that it would count
> nothing, since it lists both groups as being disabled, but when I tested
> I noticed that:
> 
>   [root@seventh ~]# perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
>   WARNING: grouped events cpus do not match, disabling group:
>     anon group { power/energy-cores/, cycles }
>     anon group { instructions, power/energy-cores/ }
>   ^C
>    Performance counter stats for 'system wide':
>   
>                12.62 Joules power/energy-cores/
>          106,920,637        cycles
>           80,228,899        instructions              #    0.75  insn per cycle
>                12.62 Joules power/energy-cores/
>   
>         14.514476987 seconds time elapsed
>   
>   
>   [root@seventh ~]#
> 
>   I.e. it counted the events, ungrouped, or am I missing something?

right, it disables 'grouping', events are scheduled/counted individualy

this way we will not hit the issue when looking for group_fd FD
and there's not any, because of different cpu maps

> 
> If I do:
> 
>   [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' -a sleep 2
>   
>    Performance counter stats for 'system wide':
>   
>                 1.73 Joules power/energy-cores/                                         
>                 0.92 Joules power/energy-ram/                                           
>           12,191,658        instructions              #    0.67  insn per cycle         
>           18,275,233        cycles                                                      
>   
>          2.001272492 seconds time elapsed
>   
>   [root@seventh ~]# 
> 
> It works, grouped. One observation, shouldn't we somehow show in the
> output that the first two were indeed grouped, ditto for the second two?

yea, we don't display groups in output.. also there's no number
for the group, it's still separate events numbers in output
grouping is only used when creating events

> 
> Also, this needs improvement:
> 
>   [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' sleep 2
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (power/energy-cores/).
>   /bin/dmesg | grep -i perf may provide additional information.

yes, power events don't work with events without cpu being defined,
which is what we do for 'workload' session.. we should either check
for that and display some sensible error for power events

or perhaps check if we could monitor like perf record does with creating
events for task and every cpu in the system

thanks,
jirka

