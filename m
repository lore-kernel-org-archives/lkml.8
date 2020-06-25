Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A333AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A8E20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B64WNWJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406700AbgFYROP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:14:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406692AbgFYROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593105253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1emsNKKRVQODfeJuv9joSCPbwXeNurKbQv14gCACCM=;
        b=B64WNWJqCLjX9tFTv6kXMuBKND+Wt4fHjQBcqxvrlxbtYYXK00zCrYy49DQu+Dmlxy42eI
        Kp9gfLQtAtu5sfubl43w9HWN+uNcGbbKdhOSI/3SnGpr16irM4We77OHagIC6+8raUSNmi
        IHp1THv+BA42otYbSkpMeDVDeDOhZ2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-UBiyFTg6OpK_UbWbNz2lAA-1; Thu, 25 Jun 2020 13:14:09 -0400
X-MC-Unique: UBiyFTg6OpK_UbWbNz2lAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD0BB800D5C;
        Thu, 25 Jun 2020 17:14:07 +0000 (UTC)
Received: from krava (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with SMTP id 28A5B5D9D3;
        Thu, 25 Jun 2020 17:14:05 +0000 (UTC)
Date:   Thu, 25 Jun 2020 19:14:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/13] tools/libperf: avoid moving of fds at
 fdarray__filter() call
Message-ID: <20200625171405.GL2719003@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <3d36dc7a-4249-096c-7554-80e6d290eac5@linux.intel.com>
 <fada6325-2e6a-0de4-918f-0bc7d1410c52@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fada6325-2e6a-0de4-918f-0bc7d1410c52@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:19:32PM +0300, Alexey Budankov wrote:
> 
> On 17.06.2020 11:35, Alexey Budankov wrote:
> > 
> > Skip fds with zeroed revents field from count and avoid fds moving
> > at fdarray__filter() call so fds indices returned by fdarray__add()
> > call stay the same and can be used for direct access and processing
> > of fd revents status field at entries array of struct fdarray object.
> > 
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > ---
> >  tools/lib/api/fd/array.c   | 11 +++++------
> >  tools/perf/tests/fdarray.c | 20 ++------------------
> >  2 files changed, 7 insertions(+), 24 deletions(-)
> > 
> > diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> > index 58d44d5eee31..97843a837370 100644
> > --- a/tools/lib/api/fd/array.c
> > +++ b/tools/lib/api/fd/array.c
> > @@ -93,22 +93,21 @@ int fdarray__filter(struct fdarray *fda, short revents,
> >  		return 0;
> >  
> >  	for (fd = 0; fd < fda->nr; ++fd) {
> > +		if (!fda->entries[fd].revents)
> > +			continue;
> > +
> 
> So it looks like this condition also filters out non signaling events fds, not only
> control and others fds, and this should be somehow avoided so such event related fds
> would be counted. Several options have been proposed so far:
> 
> 1) Explicit typing of fds via API extension and filtering based on the types:
>    a) with separate fdarray__add_stat() call
>    b) with type arg of existing fdarray__add() call
>    c) various memory management design is possible
> 
> 2) Playing tricks with fd positions inside entries and assumptions on fdarray API calls ordering
>    - looks more like a hack than a designed solution
> 
> 3) Rewrite of fdarray class to allocate separate object for every added fds
>    - can be replaced with nonscrewing of fds by __filter()
> 
> 4) Distinct between fds types at fdarray__filter() using .revents == 0 condition
>    - seems to have corner cases and thus not applicable
> 
> 5) Extension of fdarray__poll(, *arg_ptr, arg_size) with arg of fds array to atomically poll
>    on fdarray_add()-ed fds and external arg fds and then external arg fds processing
> 
> 6) Rewrite of fdarray class on epoll() call basis
>    - introduces new scalability restrictions for Perf tool

hum, how many fds for polling do you expect in your workloads?

jirka

