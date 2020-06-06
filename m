Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4CAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56A7207D0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 08:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEQP4mJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgFFI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 04:28:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52374 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgFFI2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 04:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591432081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cI+J3XaYv4s5eMcqs0Xe5DiyhG/i5iBDcjDr1HvW0xY=;
        b=AEQP4mJxj9KjcpurUukjIbFBh3bkqd/5PCJtGCSs6Zkz1LZf2bl2Aw3kwzYcQHz90iUqdA
        RGXsY1QfmkPPdSTuFa5olWXMmJYLtdI8AckNMyAWRokkKjlvhA+SKrM1vcgEuXFwn/SOrj
        KQepouxfrB+z3WoJrD13PnULzfbb8u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-M5wIGaAROM6cAWbn1D6Ung-1; Sat, 06 Jun 2020 04:27:58 -0400
X-MC-Unique: M5wIGaAROM6cAWbn1D6Ung-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9F6764AD0;
        Sat,  6 Jun 2020 08:27:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id 84A31610AF;
        Sat,  6 Jun 2020 08:27:54 +0000 (UTC)
Date:   Sat, 6 Jun 2020 10:27:53 +0200
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
Message-ID: <20200606082753.GA1449048@krava>
References: <923c40c7-7c0b-9fad-314d-69e7acbee201@intel.com>
 <937c8cc1-b4c2-8531-3fa4-d0ad9df6a65f@linux.intel.com>
 <20200601233732.GA691017@tassilo.jf.intel.com>
 <1bc7c72b-9d78-5184-a27c-8025beadaaf0@linux.intel.com>
 <d7924d7c-e2e5-c067-b9e0-cfea919e7780@linux.intel.com>
 <935187e8-6fc8-5f47-b88d-6e8c92a27286@intel.com>
 <20200605105108.GB1404794@krava>
 <3ac6d0b8-5fae-348f-8556-4bf7a66285f6@linux.intel.com>
 <20200605135743.GD1404794@krava>
 <c4f3fc64-0ea1-8a5a-ee9d-7d581510c70b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f3fc64-0ea1-8a5a-ee9d-7d581510c70b@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:47:28PM +0300, Alexey Budankov wrote:
> 
> On 05.06.2020 16:57, Jiri Olsa wrote:
> > On Fri, Jun 05, 2020 at 04:15:52PM +0300, Alexey Budankov wrote:
> >>
> >> On 05.06.2020 13:51, Jiri Olsa wrote:
> >>> On Tue, Jun 02, 2020 at 04:43:58PM +0300, Adrian Hunter wrote:
> >>>> On 2/06/20 12:12 pm, Alexey Budankov wrote:
> >>>>>
> >>>>> On 02.06.2020 11:32, Alexey Budankov wrote:
> >>>>>>
> >>>>>> On 02.06.2020 2:37, Andi Kleen wrote:
> >>>>>>>>> or a pathname, or including also the event default of "disabled".
> >>>>>>>>
> >>>>>>>> For my cases conversion of pathnames into open fds belongs to external
> >>>>>>>> controlling process e.g. like in the examples provided in the patch set.
> >>>>>>>> Not sure about "event default of 'disabled'"
> >>>>>>>
> >>>>>>> It would be nicer for manual use cases if perf supported the path names
> >>>>>>> directly like in Adrian's example, not needing a complex wrapper script.
> >>>>>>
> >>>>>> fds interface is required for VTune integration since VTune wants control
> >>>>>> over files creation aside of Perf tool process. The script demonstrates
> >>>>>> just one possible use case.
> >>>>>>
> >>>>>> Control files could easily be implemented on top of fds making open operations
> >>>>>> for paths and then initializing fds. Interface below is vague and with explicit
> >>>>>> options like below it could be more explicit:
> >>>>>> --ctl-file /tmp/my-perf.fifo --ctl-file-ack /tmp/my-perf-ack.fifo
> >>>>>
> >>>>> Or even clearer:
> >>>>>
> >>>>> --ctl-fifo /tmp/my-perf --ctl-fifo-ack /tmp/my-perf-ack
> >>>>
> >>>> If people are OK with having so many options, then that is fine by me.
> >>>
> >>> the single option Adrian suggested seems better to me:
> >>>
> >>>  --control
> >>>  --control 11
> >>>  --control 11,15
> >>
> >> What if a user specifies fifos named like this above, not fds?
> >>
> >>>  --control 11,15,disabled
> >>>  --control 11,,disabled
> >>>  --control /tmp/my-perf.fifo
> >>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
> >>
> >> What if a user wants not fifos but other type of comm channels?
> >>
> >>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
> >>>  --control /tmp/my-perf.fifo,,disabled
> >>>
> >>> we already support this kind of options arguments, like for --call-graph
> >>>
> >>> jirka
> >>>
> >>
> >> IMHO,
> >> this interface, of course, looks more compact (in amount of options) however
> >> the other side it is less user friendly. One simple option for one simple
> >> purpose is more convenient as for users as for developers. Also complex
> >> option syntax tends to have limitations and there are probably more
> >> non-obvious ones.
> >>
> >> Please speak up. I might have missed something meaningful.
> > 
> > how about specify the type like:
> > 
> > --control fd:1,2,...
> 
> What do these ... mean?

other possible options

> 
> > --control fifo:/tmp/fifo1,/tmp/fifo2
> > --control xxx:....
> > 
> > this way we can extend the functionality in the future
> > and stay backward compatible, while keeping single option
> 
> Well, it clarifies more. However it still implicitly assumes
> and requires proper ordering e.g. 1 is ctl-fd and 2 is ack-fd
> and if there are some more positions there will be gaps like
> --control fd:10,,something,,something ...

right, that's what we do for other options

> 
> Why is one single option with complex syntax more preferable
> than several simple options? Also it would still consume almost
> equal amount of command line space in shell.

I think it's better for future.. say if there's going to be support
for passing file paths you'll need to add something like --ctl-fifo
and --ctl-fifo-ack no?  with single option we'd just add something
like:

  --control fifo:/tmp/my-perf.fifo,/tmp/my-perf-ack.fifo

jirka

