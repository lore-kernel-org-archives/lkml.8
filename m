Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0C9CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0202A206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAYVD7ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgEMLdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:33:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47180 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728930AbgEMLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589369632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LRUoCKtlXHJ46xoUgnC/etCJOTrU/b9ynoKVd4gTyFc=;
        b=ZAYVD7veetJacorI73OsR/IyhdgpVhYDLpU2A+OHpaiVbhAnOlFHBehSB34ioH85XkZPic
        Oa0HAk+vvFQ82zpx2BYnbZ77yFgkxwcpKy8tGzHlSdvf4gNaR7D/IoDAUcYl9gp4pRhYpB
        bKq+r5rnh4Sc1rCzzM0XBvY9QWdbfLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-lEQl-fVjN_2UtkpBD_nS2A-1; Wed, 13 May 2020 07:33:50 -0400
X-MC-Unique: lEQl-fVjN_2UtkpBD_nS2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7480460;
        Wed, 13 May 2020 11:33:48 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 219BB5C1BB;
        Wed, 13 May 2020 11:33:45 +0000 (UTC)
Date:   Wed, 13 May 2020 13:33:45 +0200
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
Subject: Re: [PATCH 3/4] perf stat: Add --metrics-file option
Message-ID: <20200513113345.GI3158213@krava>
References: <20200511205307.3107775-1-jolsa@kernel.org>
 <20200511205307.3107775-4-jolsa@kernel.org>
 <CAP-5=fU5bbWWyWXDMoMvsMY4BbUsRUqgrOtGUrdiYjSsJZ+t-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU5bbWWyWXDMoMvsMY4BbUsRUqgrOtGUrdiYjSsJZ+t-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:04:55AM -0700, Ian Rogers wrote:

SNIP

> > +METRICS FILE
> > +------------
> > +The file with metrics has following syntax:
> > +
> > +  NAME = EXPRESSION ;
> > +  NAME = EXPRESSION ;
> > +  ...
> > +
> > +where NAME is unique identifier of the metric, which is later used in
> > +perf stat as -M option argument (see below).
> > +
> > +The EXPRESSION is the metric's formula with following grammar:
> > +
> > +  EXPR: EVENT
> > +  EXPR: EXPR if EXPR else EXPR
> 
> Not introduced by this patch, but this patch is exposing it as an API.

yea, I was thinking about this and I think we will put a disclaimer in
here that this is not an API and the interface can change.. it's really
mostly intended to help out with running a custom metric which is not
compiled in ... I don't want to be commited to support old API

> This notion of if-else is really weird. For one thing there are no
> comparison operators. The unit test doesn't really help:
>         ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
> What kind of comparison is "3*4"? If 0.0 causes the else clause then will -0.0?
> A typical expression I see written in C is to give a ratio such:
>   value = denom == 0 ? 0 : nom / denom;
> I've worked around encoding this by extending expr.y locally.

AFAICS it's used only with #SMT_on in the condition, aybe we could limit
the condition only for #SMT_on term?


> 
> > +  EXPR: NUMBER
> > +  EXPR: EXPR | EXPR
> > +  EXPR: EXPR & EXPR
> > +  EXPR: EXPR ^ EXPR
> 
> Again, it's odd that these cast the double to a long and then assign
> the result back to a double.

is this even used anywhere? perhaps it was added just to be complete

SNIP

> > +       2.002460174                 0.86                23.37                 0.86
> > +       3.003969795                 1.03                23.93                 1.03
> > +  ...
> 
> A feature request would be to allow metrics in terms of other metrics,
> not just events :-) For example, it is common to sum all cache
> hit/miss events. It is laborious to copy that expression for hit rate,
> miss rate, etc.
> 
> Perhaps the expression parsing code should be folded into the event
> parsing code.

nice idea, but let's finish straighten up what we have first ;-)

I'll try to go through all the fixes/tests you posted and let's
get it in first

thanks,
jirka

