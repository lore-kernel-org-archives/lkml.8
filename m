Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8078620734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW4RSlzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFAHk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:40:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgFAHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590997225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SjPSf+L4VO3ad7JdbEoacITG1g9d/lLfFnXukAQhySE=;
        b=TW4RSlzjV4wXLQDjmTxrrCz2tfkZxI2z6I/0GjUE9fbCaWg0v32XiuVuLKrGDmcdomqOz3
        y+zqhH5cjQpW9ElhCr8pw+srfessabOLWLeJfY6E+dwTlQaITF7loQOLdYnuWkkDt4xvD+
        2vqvvn51ILN2WsqU9Cgw3B6zty8Mz5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-r6WynXgEMfODb2R7ip9P5w-1; Mon, 01 Jun 2020 03:40:22 -0400
X-MC-Unique: r6WynXgEMfODb2R7ip9P5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD07B8015CE;
        Mon,  1 Jun 2020 07:40:20 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id CDD4710013C1;
        Mon,  1 Jun 2020 07:40:17 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:40:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: Ensure group is defined on top of the same
 cpu mask
Message-ID: <20200601074016.GD881900@krava>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 05:04:47PM -0700, Ian Rogers wrote:
> On Sun, May 31, 2020 at 9:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Jin Yao reported the issue (and posted first versions of this change)
> > with groups being defined over events with different cpu mask.
> >
> > This causes assert aborts in get_group_fd, like:
> >
> >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> >   Aborted
> >
> > All the events in the group have to be defined over the same
> > cpus so the group_fd can be found for every leader/member pair.
> >
> > Adding check to ensure this condition is met and removing the
> > group (with warning) if we detect mixed cpus, like:
> >
> >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> >   WARNING: event cpu maps do not match, disabling group:
> >     anon group { power/energy-cores/, cycles }
> >     anon group { instructions, power/energy-cores/ }
> 
> This is really cool! I wonder if there is a better wording for 'event
> cpu maps' ? It may be useful to list what the cpu maps are for the
> events as a diagnostic aid.

right, we could display that for -v option

jirka

