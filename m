Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDA8206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/Glpljm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgHKKup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:50:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728464AbgHKKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597143038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nmyx2UdRvq7Iu84Oic8xZ8d1B/WpUnFI8Ebnoq7B4AY=;
        b=O/Glpljmg/uf81j0Rm8bATWHMUw5R1J3QZ4jxRJZ3/q1EliDPcYKIvowoHp7r63FiKwrOz
        vpfTEcY6pSa+fkNtUqd+mwK9tfe+qdIarucJTNI7ObO9ObcAQSkY0LmtczGycdQl+nRpVf
        jxXhAK2ZSbTGLlFs60BpxMcZiXAHhrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-C1RI_Y4bOHGUZiHwZUK3Jg-1; Tue, 11 Aug 2020 06:50:34 -0400
X-MC-Unique: C1RI_Y4bOHGUZiHwZUK3Jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A704106B249;
        Tue, 11 Aug 2020 10:50:32 +0000 (UTC)
Received: from krava (unknown [10.40.195.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id C8F001001281;
        Tue, 11 Aug 2020 10:50:28 +0000 (UTC)
Date:   Tue, 11 Aug 2020 12:50:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] libperf: Add support for user space counter access
Message-ID: <20200811105027.GD699846@krava>
References: <20200807230517.57114-1-robh@kernel.org>
 <20200808102208.GA619980@krava>
 <CAL_Jsq+gfqyqCx3Yuc6TsbXjYSLfJQhhPUnwRVjpJgwL24v1Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+gfqyqCx3Yuc6TsbXjYSLfJQhhPUnwRVjpJgwL24v1Qg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:11:23PM -0600, Rob Herring wrote:
> On Sat, Aug 8, 2020 at 4:22 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Aug 07, 2020 at 05:05:17PM -0600, Rob Herring wrote:
> > > x86 and arm64 can both support direct access of event counters in
> > > userspace. The access sequence is less than trivial and currently exists
> > > in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> > > projects such as PAPI and libpfm4.
> > >
> > > Patches to add arm64 userspace support are pending[1].
> > >
> > > For this RFC, looking for a yes, seems like a good idea, or no, go away we
> > > don't want this in libperf.
> >
> > hi,
> > looks great!
> >
> > I wanted to add this for very long time.. so yes, we want this ;-)
> 
> Thanks for the quick feedback. Would this be better implemented as a
> fast path for perf_evsel__read()? If so, how to get the mmap data

if it works for all events, which I'm not sure of

> which is associated with a evlist rather than a evsel?

not sure what you mean, you can mmap evsel, not evlist

jirka

