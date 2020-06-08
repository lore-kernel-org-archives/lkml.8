Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59265206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzuxoAUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgFHIn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:43:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729099AbgFHIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591605837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCogBmBVUsIQKerkK1tT0RUqcGxXyw6WQaZKC3/oA7w=;
        b=EzuxoAUdBHXmD1rjjaKk+NSmFm+EOHBoP6iwn9bwb3VIeZcyIi6BiqvOOJ3munHWDugMBv
        GjPxYTnlq7UBdqaHv0VVFs1CKS09rQxhp+lK37fbIO7w5EjLUpdIzR10EHhUzZzUBfm91/
        RA41XQQq7SITLn52nr9OoZSK4gyi7Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-WX1dDquHN3KZJ0y5wRhvrQ-1; Mon, 08 Jun 2020 04:43:49 -0400
X-MC-Unique: WX1dDquHN3KZJ0y5wRhvrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828E1188360B;
        Mon,  8 Jun 2020 08:43:48 +0000 (UTC)
Received: from krava (unknown [10.40.195.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 22CF260CD0;
        Mon,  8 Jun 2020 08:43:45 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:43:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 01/13] tools/libperf: introduce notion of static
 polled file descriptors
Message-ID: <20200608084344.GA1520715@krava>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava>
 <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:08:56AM +0300, Alexey Budankov wrote:
> 
> On 05.06.2020 19:15, Alexey Budankov wrote:
> > 
> > On 05.06.2020 14:38, Jiri Olsa wrote:
> >> On Fri, Jun 05, 2020 at 12:50:54PM +0200, Jiri Olsa wrote:
> >>> On Wed, Jun 03, 2020 at 06:52:59PM +0300, Alexey Budankov wrote:
> >>>>
> >>>> Implement adding of file descriptors by fdarray__add_stat() to
> >>>> fix-sized (currently 1) stat_entries array located at struct fdarray.
> >>>> Append added file descriptors to the array used by poll() syscall
> >>>> during fdarray__poll() call. Copy poll() result of the added
> >>>> descriptors from the array back to the storage for analysis.
> >>>>
> >>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >>>> ---
> >>>>  tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
> >>>>  tools/lib/api/fd/array.h                 |  7 ++++
> >>>>  tools/lib/perf/evlist.c                  | 11 +++++++
> >>>>  tools/lib/perf/include/internal/evlist.h |  2 ++
> >>>>  4 files changed, 61 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> >>>> index 58d44d5eee31..b0027f2169c7 100644
> >>>> --- a/tools/lib/api/fd/array.c
> >>>> +++ b/tools/lib/api/fd/array.c
> >>>> @@ -11,10 +11,16 @@
> >>>>  
> >>>>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
> >>>>  {
> >>>> +	int i;
> >>>> +
> >>>>  	fda->entries	 = NULL;
> >>>>  	fda->priv	 = NULL;
> >>>>  	fda->nr		 = fda->nr_alloc = 0;
> >>>>  	fda->nr_autogrow = nr_autogrow;
> >>>> +
> >>>> +	fda->nr_stat = 0;
> >>>> +	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
> >>>> +		fda->stat_entries[i].fd = -1;
> >>>>  }
> >>>>  
> >>>>  int fdarray__grow(struct fdarray *fda, int nr)
> >>>> @@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
> >>>>  	return pos;
> >>>>  }
> >>>>  
> >>>> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
> >>>> +{
> >>>> +	int pos = fda->nr_stat;
> >>>> +
> >>>> +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
> >>>> +		return -1;
> >>>> +
> >>>> +	fda->stat_entries[pos].fd = fd;
> >>>> +	fda->stat_entries[pos].events = revents;
> >>>> +	fda->nr_stat++;
> >>>> +
> >>>> +	return pos;
> >>>> +}
> >>>> +
> >>>>  int fdarray__filter(struct fdarray *fda, short revents,
> >>>>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> >>>>  		    void *arg)
> >>>> @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
> >>>>  
> >>>>  int fdarray__poll(struct fdarray *fda, int timeout)
> >>>>  {
> >>>> -	return poll(fda->entries, fda->nr, timeout);
> >>>> +	int nr, i, pos, res;
> >>>> +
> >>>> +	nr = fda->nr;
> >>>> +
> >>>> +	for (i = 0; i < fda->nr_stat; i++) {
> >>>> +		if (fda->stat_entries[i].fd != -1) {
> >>>> +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
> >>>> +					   fda->stat_entries[i].events);
> >>>
> >>> so every call to fdarray__poll will add whatever is
> >>> in stat_entries to entries? how is it removed?
> >>>
> >>> I think you should either follow what Adrian said
> >>> and put 'static' descriptors early and check for
> >>> filter number to match it as an 'quick fix'
> >>>
> >>> or we should fix it for real and make it generic
> >>>
> >>> so currently the interface is like this:
> >>>
> >>>   pos1 = fdarray__add(a, fd1 ... );
> >>>   pos2 = fdarray__add(a, fd2 ... );
> >>>   pos3 = fdarray__add(a, fd2 ... );
> >>>
> >>>   fdarray__poll(a);
> >>>
> >>>   num = fdarray__filter(a, revents, destructor, arg);
> >>>
> >>> when fdarray__filter removes some of the fds the 'pos1,pos2,pos3'
> >>> indexes are not relevant anymore
> > 
> > and that is why the return value of fdarray__add() should be converted
> > to bool (added/not added). Currently the return value is used as bool
> > only allover the calling code.
> > 
> > fdarray__add_fixed() brings the notion of fd with fixed pos which is
> > valid after fdarray__add_fixed() call so the pos could be used to access
> > pos fd poll status after poll() call.
> > 
> > pos = fdarray__add_fixed(array, fd);
> > fdarray_poll(array);
> > revents = fdarray_fixed_revents(array, pos);
> > fdarray__del(array, pos);
> 
> So how is it about just adding _revents() and _del() for fixed fds with
> correction of retval to bool for fdarray__add()?

I don't like the separation for fixed and non-fixed fds,
why can't we make generic?

jirka

