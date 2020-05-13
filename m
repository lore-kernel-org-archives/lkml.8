Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18935C4345E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BA420820
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgZQQ933"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbgEMOqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:46:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388806AbgEMOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589381179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILCVL7vlVG92bS37yQ7N2fhfcb84nVhCr32QqOAFlPM=;
        b=hgZQQ933WfacEJJi3effy6x7C3JtNzX4rSAJv20HtV0o7qpttBzdA9QUVxfP2hQteYNxMw
        z+0Yl+Gc1PaXVmbou2GmhhjtPsz6RKt3EJLWXwcOPuNxwq/lZCnusZYIu+uCU2rcLT/yi6
        RkzfqyaDHBirk7p7oK2akohsA1pvPKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-UX_yJiyJPkSpmvhEJGb99A-1; Wed, 13 May 2020 10:46:18 -0400
X-MC-Unique: UX_yJiyJPkSpmvhEJGb99A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67D6E461;
        Wed, 13 May 2020 14:46:16 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5059C99D6;
        Wed, 13 May 2020 14:46:11 +0000 (UTC)
Date:   Wed, 13 May 2020 16:46:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 4/4] perf expr: Report line number with error
Message-ID: <20200513144610.GM3158213@krava>
References: <20200511205307.3107775-1-jolsa@kernel.org>
 <20200511205307.3107775-5-jolsa@kernel.org>
 <CAP-5=fVa+=4cQzw47qSGFQZfqw7Bvx85ZBTJwkHReuJbi4ZGiA@mail.gmail.com>
 <20200513113424.GJ3158213@krava>
 <20200513140825.GG5583@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513140825.GG5583@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:08:25AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 13, 2020 at 01:34:24PM +0200, Jiri Olsa escreveu:
> > On Wed, May 13, 2020 at 12:09:30AM -0700, Ian Rogers wrote:
> > > On Mon, May 11, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Display line number on when parsing custom metrics file, like:
> > > >
> > > >   $ cat metrics
> > > >   // IPC
> > > >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> > > >
> > > >   krava
> > > >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> > > >   failed to parse metrics file: ./metrics:4
> > > >
> > > > Please note that because the grammar is flexible on new lines,
> > > > the syntax could be broken on the next 'not fitting' item and
> > > > not the first wrong word, like:
> > > >
> > > >   $ cat metrics
> > > >   // IPC
> > > >   krava
> > > >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> > > >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> > > >   failed to parse metrics file: ./metrics:3
> > > 
> > > A line number is better than nothing :-) It'd be nice to be told about
> > > broken events and more information about what's broken in the line. A
> > > common failure is @ vs / encoding and also no-use or misuse of \\.
> > > Perhaps expand the test coverage.
> > 
> > yep, error reporting needs more changes.. but the line is crucial ;-)
> 
> So I had started processing this patchkit, I assume you will send a v2
> and I should drop what I had processed, is that ok?

yes, I will resubmit on top of the other expr changes
we have now pending

jirka

