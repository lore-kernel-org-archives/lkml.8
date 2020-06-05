Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB2DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3579E2067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gud1FwD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFEKvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:51:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48997 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbgFEKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591354276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yb/WJFNxIDbt1ayPcCFIZTqtwIOkkV9f+xD0nyjCVKM=;
        b=gud1FwD8f05+LkkBGtROarj/RfSsXDPsrYBrznt0udq1nuIuWCpKEH7ujHZr6Oqsbp3y/k
        wxXNJNTSA/2i00FPkiOTOIxy0YigkiqZ53rDk2T/jre5LaFrw57WFWQvj+QbjpZMd6lJlC
        d6wfsog2SslYJojMHRUVbNJw/1KEfow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-31d3Pkx5OyeE34C7L7sD-g-1; Fri, 05 Jun 2020 06:51:13 -0400
X-MC-Unique: 31d3Pkx5OyeE34C7L7sD-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0621030980;
        Fri,  5 Jun 2020 10:51:11 +0000 (UTC)
Received: from krava (unknown [10.40.193.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 66CE361985;
        Fri,  5 Jun 2020 10:51:09 +0000 (UTC)
Date:   Fri, 5 Jun 2020 12:51:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
Message-ID: <20200605105108.GB1404794@krava>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
 <8ffc9f9f-af58-deea-428b-f8a69004e3cb@linux.intel.com>
 <923c40c7-7c0b-9fad-314d-69e7acbee201@intel.com>
 <937c8cc1-b4c2-8531-3fa4-d0ad9df6a65f@linux.intel.com>
 <20200601233732.GA691017@tassilo.jf.intel.com>
 <1bc7c72b-9d78-5184-a27c-8025beadaaf0@linux.intel.com>
 <d7924d7c-e2e5-c067-b9e0-cfea919e7780@linux.intel.com>
 <935187e8-6fc8-5f47-b88d-6e8c92a27286@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935187e8-6fc8-5f47-b88d-6e8c92a27286@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:43:58PM +0300, Adrian Hunter wrote:
> On 2/06/20 12:12 pm, Alexey Budankov wrote:
> > 
> > On 02.06.2020 11:32, Alexey Budankov wrote:
> >>
> >> On 02.06.2020 2:37, Andi Kleen wrote:
> >>>>> or a pathname, or including also the event default of "disabled".
> >>>>
> >>>> For my cases conversion of pathnames into open fds belongs to external
> >>>> controlling process e.g. like in the examples provided in the patch set.
> >>>> Not sure about "event default of 'disabled'"
> >>>
> >>> It would be nicer for manual use cases if perf supported the path names
> >>> directly like in Adrian's example, not needing a complex wrapper script.
> >>
> >> fds interface is required for VTune integration since VTune wants control
> >> over files creation aside of Perf tool process. The script demonstrates
> >> just one possible use case.
> >>
> >> Control files could easily be implemented on top of fds making open operations
> >> for paths and then initializing fds. Interface below is vague and with explicit
> >> options like below it could be more explicit:
> >> --ctl-file /tmp/my-perf.fifo --ctl-file-ack /tmp/my-perf-ack.fifo
> > 
> > Or even clearer:
> > 
> > --ctl-fifo /tmp/my-perf --ctl-fifo-ack /tmp/my-perf-ack
> 
> If people are OK with having so many options, then that is fine by me.

the single option Adrian suggested seems better to me:

 --control
 --control 11
 --control 11,15
 --control 11,15,disabled
 --control 11,,disabled
 --control /tmp/my-perf.fifo
 --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
 --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
 --control /tmp/my-perf.fifo,,disabled

we already support this kind of options arguments, like for --call-graph

jirka

