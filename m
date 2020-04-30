Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92656C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682C02072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGLye7rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgD3MnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:43:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbgD3MnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588250598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BAg82KvpzRQfogFt02yjyfPQP7IP6UKcwesWkwykLkE=;
        b=JGLye7rdSmwMnNM7ST4YFIHAeIHi3vOMCN9k2Jj9R6lbKA+zqA0ggJA/+EqP2nHOPvLvpx
        GUuD/hmVsNUOvNP7gn5zqWJhFLScQl3aXpCCxMlEX2An05dACdrGHRThRizQDR/VMcTfUp
        wvrLooIZXly3oOtXhG+Dco+fwDC+RUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-JzxphAwAO8irvk7l5Tymgg-1; Thu, 30 Apr 2020 08:43:14 -0400
X-MC-Unique: JzxphAwAO8irvk7l5Tymgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F19211800D4A;
        Thu, 30 Apr 2020 12:43:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04515196AE;
        Thu, 30 Apr 2020 12:43:09 +0000 (UTC)
Date:   Thu, 30 Apr 2020 14:43:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCHv2 0/3] perf tools: Add support for user defined metric
Message-ID: <20200430124306.GD1694693@krava>
References: <20200421181337.988681-1-jolsa@kernel.org>
 <8df4b32b-4abc-7ea9-feaf-a16be6edf64f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df4b32b-4abc-7ea9-feaf-a16be6edf64f@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:54:41PM +0530, kajoljain wrote:
> 
> 
> On 4/21/20 11:43 PM, Jiri Olsa wrote:
> > hi,
> > Joe asked for possibility to add user defined metrics. Given that
> > we already have metrics support, I added --metrics-file option that
> > allows to specify custom metrics.
> > 
> >   $ cat metrics
> >   # IPC
> >   mine1 = instructions / cycles;
> >   /* DECODED_ICACHE_UOPS% */
> >   mine2 = 100 * (idq.dsb_uops / \ (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));
> > 
> >   $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 --metric-only -a -I 1000
> >   #           time       insn per cycle                mine1                mine2
> >        1.000536263                0.71                   0.7                 41.4
> >        2.002069025                0.31                   0.3                 14.1
> >        3.003427684                0.27                   0.3                 14.8
> >        4.004807132                0.25                   0.2                 12.1
> >   ...
> > 
> > v2 changes:
> >   - add new --metrics-file option
> >   - rebased on current perf/core expression bison/flex enhancements
> > 
> > Also available in:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/metric
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > Jiri Olsa (3):
> >       perf expr: Add parsing support for multiple expressions
> >       perf expr: Allow comments in custom metric file
> >       perf stat: Add --metrics-file option
> 
> Hi Jiri,
>      I try to look into these patches. As far as I understand we are using
> syntax "Name: Expression" for user defined events. It will be great if we mention
> this format somewhere for users.

right, Andi also asked for that, I'll describe it in a man page

> 
> Otherwise it works fine for me. Try by testing it for different metric expressions.

thanks for testing

> But still curious about reason for adding this support. Isn't json file is there for same purpose?

we've been asked by Joe about the possibility to specify metric by user
through the command line..  with json you have all them compiled in and 
you can't change them or specify your own without recompiling perf

jirka

> 
> Thanks,
> Kajol Jain
> > 
> >  tools/perf/Documentation/perf-stat.txt |  3 +++
> >  tools/perf/builtin-stat.c              |  7 +++++--
> >  tools/perf/tests/expr.c                | 13 +++++++++++++
> >  tools/perf/util/expr.c                 |  6 ++++++
> >  tools/perf/util/expr.h                 | 19 +++++++++++++++++--
> >  tools/perf/util/expr.l                 | 24 ++++++++++++++++++++++++
> >  tools/perf/util/expr.y                 | 13 ++++++++++++-
> >  tools/perf/util/metricgroup.c          | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
> >  tools/perf/util/metricgroup.h          |  3 ++-
> >  tools/perf/util/stat.h                 |  1 +
> >  10 files changed, 142 insertions(+), 13 deletions(-)
> > 
> 

