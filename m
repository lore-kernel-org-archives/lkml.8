Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0FF206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLeeQLWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgFHIqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:46:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729161AbgFHIqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591605960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6DJV5qlyuRw+4tTLfMsK1spBMTNlV7JJ+jRzp/eAJE=;
        b=QLeeQLWMJxQtpm5TGK4dFLuucHZQDKwADF8Pz+8u19eCOfvOThNfe1MPpFJ7NnYvXyVzZh
        ycQ5iwIigXqbe+qfENVF7YM+zGE2nbOn1JE6Q0KPO19gQjWcwCHVxpxofoInAQ8MlMk+di
        pmJhCwtqnuNrUnBkb43TKYdfHJbgTgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-g3KUImWcN4iRIAvHdIEaOA-1; Mon, 08 Jun 2020 04:45:57 -0400
X-MC-Unique: g3KUImWcN4iRIAvHdIEaOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9DAC8014D4;
        Mon,  8 Jun 2020 08:45:54 +0000 (UTC)
Received: from krava (unknown [10.40.195.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 946955C241;
        Mon,  8 Jun 2020 08:45:52 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:45:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
Message-ID: <20200608084551.GB1520715@krava>
References: <937c8cc1-b4c2-8531-3fa4-d0ad9df6a65f@linux.intel.com>
 <20200601233732.GA691017@tassilo.jf.intel.com>
 <1bc7c72b-9d78-5184-a27c-8025beadaaf0@linux.intel.com>
 <d7924d7c-e2e5-c067-b9e0-cfea919e7780@linux.intel.com>
 <935187e8-6fc8-5f47-b88d-6e8c92a27286@intel.com>
 <20200605105108.GB1404794@krava>
 <3ac6d0b8-5fae-348f-8556-4bf7a66285f6@linux.intel.com>
 <20200605135743.GD1404794@krava>
 <c4f3fc64-0ea1-8a5a-ee9d-7d581510c70b@linux.intel.com>
 <0d1d9c45-a880-9a5d-e35d-c80fb3b71eab@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1d9c45-a880-9a5d-e35d-c80fb3b71eab@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 06:23:17PM +0300, Alexey Budankov wrote:

SNIP

> >>>>>> Or even clearer:
> >>>>>>
> >>>>>> --ctl-fifo /tmp/my-perf --ctl-fifo-ack /tmp/my-perf-ack
> >>>>>
> >>>>> If people are OK with having so many options, then that is fine by me.
> >>>>
> >>>> the single option Adrian suggested seems better to me:
> >>>>
> >>>>  --control
> >>>>  --control 11
> >>>>  --control 11,15
> >>>
> >>> What if a user specifies fifos named like this above, not fds?
> >>>
> >>>>  --control 11,15,disabled
> >>>>  --control 11,,disabled
> >>>>  --control /tmp/my-perf.fifo
> >>>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
> >>>
> >>> What if a user wants not fifos but other type of comm channels?
> >>>
> >>>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
> >>>>  --control /tmp/my-perf.fifo,,disabled
> >>>>
> >>>> we already support this kind of options arguments, like for --call-graph
> >>>>
> >>>> jirka
> >>>>
> >>>
> >>> IMHO,
> >>> this interface, of course, looks more compact (in amount of options) however
> >>> the other side it is less user friendly. One simple option for one simple
> >>> purpose is more convenient as for users as for developers. Also complex
> >>> option syntax tends to have limitations and there are probably more
> >>> non-obvious ones.
> >>>
> >>> Please speak up. I might have missed something meaningful.
> >>
> >> how about specify the type like:
> >>
> >> --control fd:1,2,...
> > 
> > What do these ... mean?
> 
> After all,
> if you want it this way and it now also fits my needs I could convert
> --ctl-fd[-ack] to --control fd:<ctl-fd>,<ack-fd> with use cases like
> --control fd:<ctl-fd> and --control fd:<ctl-fd>,<ack-fd>. Accepted?

looks good

jirka

