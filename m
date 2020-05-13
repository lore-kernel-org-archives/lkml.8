Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E625ACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C223120753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl+Zmt3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgEMLec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:34:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgEMLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589369671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HtclPAaVYkOroDgjLz8DtG3xfoOYXGN7ClRQrx80G0w=;
        b=Bl+Zmt3ZHhkKb6QuFOfhfCh5G64q5BJKYrw6Zm+LKMmSufKyucafBdCWb16nRo3ZodOrL3
        lr0TSoqVisRckVbSHPwQOrRZkJnIxiLrw/qrkIFQSz5Dw5S09ZqzvRw7PjiBwtYY6r7YG8
        dDQFGm0w3jxR2UvxNlY8GEW+sfD6mro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-4EUCvJYrN-iyzP9rV0-X_g-1; Wed, 13 May 2020 07:34:29 -0400
X-MC-Unique: 4EUCvJYrN-iyzP9rV0-X_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F216100CCC9;
        Wed, 13 May 2020 11:34:28 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 763AF1000079;
        Wed, 13 May 2020 11:34:25 +0000 (UTC)
Date:   Wed, 13 May 2020 13:34:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20200513113424.GJ3158213@krava>
References: <20200511205307.3107775-1-jolsa@kernel.org>
 <20200511205307.3107775-5-jolsa@kernel.org>
 <CAP-5=fVa+=4cQzw47qSGFQZfqw7Bvx85ZBTJwkHReuJbi4ZGiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVa+=4cQzw47qSGFQZfqw7Bvx85ZBTJwkHReuJbi4ZGiA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:09:30AM -0700, Ian Rogers wrote:
> On Mon, May 11, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Display line number on when parsing custom metrics file, like:
> >
> >   $ cat metrics
> >   // IPC
> >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> >
> >   krava
> >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> >   failed to parse metrics file: ./metrics:4
> >
> > Please note that because the grammar is flexible on new lines,
> > the syntax could be broken on the next 'not fitting' item and
> > not the first wrong word, like:
> >
> >   $ cat metrics
> >   // IPC
> >   krava
> >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> >   failed to parse metrics file: ./metrics:3
> 
> A line number is better than nothing :-) It'd be nice to be told about
> broken events and more information about what's broken in the line. A
> common failure is @ vs / encoding and also no-use or misuse of \\.
> Perhaps expand the test coverage.

yep, error reporting needs more changes.. but the line is crucial ;-)

jirka

