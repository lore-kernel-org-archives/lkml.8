Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA5DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B123207F9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5DprF4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFEKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:51:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51609 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726637AbgFEKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591354259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBPNXeumoB2edMU7rBwZo/XR6v1tVQAaNzjEQzvK0+w=;
        b=b5DprF4IPtbaFPjIWiKXqEX47S+skBDeZGcCwabyJoGY1qsXD/vx0opsgJF2rUGHePIUsS
        PZ/miKW4z9Y6Iu7LbYctQzXauXd4M8lnkid43Cq5Oq10zfA7DVPXl68chOndKMbpHD8y5z
        apKJ3ZszqMKroR6DHNEcPynh6rEXKAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-avP1jYz7PEG9B5RZuDWbAA-1; Fri, 05 Jun 2020 06:50:56 -0400
X-MC-Unique: avP1jYz7PEG9B5RZuDWbAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA12D464;
        Fri,  5 Jun 2020 10:50:54 +0000 (UTC)
Received: from krava (unknown [10.40.193.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 85A72100238D;
        Fri,  5 Jun 2020 10:50:52 +0000 (UTC)
Date:   Fri, 5 Jun 2020 12:50:51 +0200
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
Message-ID: <20200605105051.GA1404794@krava>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:52:59PM +0300, Alexey Budankov wrote:
> 
> Implement adding of file descriptors by fdarray__add_stat() to
> fix-sized (currently 1) stat_entries array located at struct fdarray.
> Append added file descriptors to the array used by poll() syscall
> during fdarray__poll() call. Copy poll() result of the added
> descriptors from the array back to the storage for analysis.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
>  tools/lib/api/fd/array.h                 |  7 ++++
>  tools/lib/perf/evlist.c                  | 11 +++++++
>  tools/lib/perf/include/internal/evlist.h |  2 ++
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 58d44d5eee31..b0027f2169c7 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -11,10 +11,16 @@
>  
>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
>  {
> +	int i;
> +
>  	fda->entries	 = NULL;
>  	fda->priv	 = NULL;
>  	fda->nr		 = fda->nr_alloc = 0;
>  	fda->nr_autogrow = nr_autogrow;
> +
> +	fda->nr_stat = 0;
> +	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
> +		fda->stat_entries[i].fd = -1;
>  }
>  
>  int fdarray__grow(struct fdarray *fda, int nr)
> @@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
>  	return pos;
>  }
>  
> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
> +{
> +	int pos = fda->nr_stat;
> +
> +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
> +		return -1;
> +
> +	fda->stat_entries[pos].fd = fd;
> +	fda->stat_entries[pos].events = revents;
> +	fda->nr_stat++;
> +
> +	return pos;
> +}
> +
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>  		    void *arg)
> @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  
>  int fdarray__poll(struct fdarray *fda, int timeout)
>  {
> -	return poll(fda->entries, fda->nr, timeout);
> +	int nr, i, pos, res;
> +
> +	nr = fda->nr;
> +
> +	for (i = 0; i < fda->nr_stat; i++) {
> +		if (fda->stat_entries[i].fd != -1) {
> +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
> +					   fda->stat_entries[i].events);

so every call to fdarray__poll will add whatever is
in stat_entries to entries? how is it removed?

I think you should either follow what Adrian said
and put 'static' descriptors early and check for
filter number to match it as an 'quick fix'

or we should fix it for real and make it generic

so currently the interface is like this:

  pos1 = fdarray__add(a, fd1 ... );
  pos2 = fdarray__add(a, fd2 ... );
  pos3 = fdarray__add(a, fd2 ... );

  fdarray__poll(a);

  num = fdarray__filter(a, revents, destructor, arg);

when fdarray__filter removes some of the fds the 'pos1,pos2,pos3'
indexes are not relevant anymore

how about we make the 'pos indexes' being stable by allocating
separate object for each added descriptor and each poll call
would create pollfd array from current objects, and entries
would keep pointer to its pollfd entry

  struct fdentry *entry {
       int              fd;
       int              events;
       struct pollfd   *pollfd;
  }

  entry1 = fdarray__add(a, fd1 ...);
  entry2 = fdarray__add(a, fd2 ...);
  entry3 = fdarray__add(a, fd3 ...);

  fdarray__poll(a);

  struct pollfd *fdarray__entry_pollfd(a, entry1);

or smoething like that ;-)

jirka

