Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACFEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949DE206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXRj6nyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgFELir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:38:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgFELiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591357123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPLjknwiyhPl/s/r7c/4ZdmJ2YUuDqdRA7TA/XOryP8=;
        b=SXRj6nyWAqrransvtDowxm3rha2s0RT4D1WYCZkjOw3DC/mUMXri1R9Uij3woFeGjRW5KB
        5DhJVR/FBVtDHiObDE4vkdxE2PG3+AkORDWcnAh6hVygURq/f4tcuS7yJ8U3fwD/WCWrfJ
        QawhmGOdyW5oC4NJG48gnn+lm32NWZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-KGBmWjNyMKS2-bl6r5FrZg-1; Fri, 05 Jun 2020 07:38:40 -0400
X-MC-Unique: KGBmWjNyMKS2-bl6r5FrZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8539C19200C1;
        Fri,  5 Jun 2020 11:38:38 +0000 (UTC)
Received: from krava (unknown [10.40.193.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id E3E0475294;
        Fri,  5 Jun 2020 11:38:35 +0000 (UTC)
Date:   Fri, 5 Jun 2020 13:38:34 +0200
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
Message-ID: <20200605113834.GC1404794@krava>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605105051.GA1404794@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:50:54PM +0200, Jiri Olsa wrote:
> On Wed, Jun 03, 2020 at 06:52:59PM +0300, Alexey Budankov wrote:
> > 
> > Implement adding of file descriptors by fdarray__add_stat() to
> > fix-sized (currently 1) stat_entries array located at struct fdarray.
> > Append added file descriptors to the array used by poll() syscall
> > during fdarray__poll() call. Copy poll() result of the added
> > descriptors from the array back to the storage for analysis.
> > 
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > ---
> >  tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
> >  tools/lib/api/fd/array.h                 |  7 ++++
> >  tools/lib/perf/evlist.c                  | 11 +++++++
> >  tools/lib/perf/include/internal/evlist.h |  2 ++
> >  4 files changed, 61 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> > index 58d44d5eee31..b0027f2169c7 100644
> > --- a/tools/lib/api/fd/array.c
> > +++ b/tools/lib/api/fd/array.c
> > @@ -11,10 +11,16 @@
> >  
> >  void fdarray__init(struct fdarray *fda, int nr_autogrow)
> >  {
> > +	int i;
> > +
> >  	fda->entries	 = NULL;
> >  	fda->priv	 = NULL;
> >  	fda->nr		 = fda->nr_alloc = 0;
> >  	fda->nr_autogrow = nr_autogrow;
> > +
> > +	fda->nr_stat = 0;
> > +	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
> > +		fda->stat_entries[i].fd = -1;
> >  }
> >  
> >  int fdarray__grow(struct fdarray *fda, int nr)
> > @@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
> >  	return pos;
> >  }
> >  
> > +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
> > +{
> > +	int pos = fda->nr_stat;
> > +
> > +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
> > +		return -1;
> > +
> > +	fda->stat_entries[pos].fd = fd;
> > +	fda->stat_entries[pos].events = revents;
> > +	fda->nr_stat++;
> > +
> > +	return pos;
> > +}
> > +
> >  int fdarray__filter(struct fdarray *fda, short revents,
> >  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> >  		    void *arg)
> > @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
> >  
> >  int fdarray__poll(struct fdarray *fda, int timeout)
> >  {
> > -	return poll(fda->entries, fda->nr, timeout);
> > +	int nr, i, pos, res;
> > +
> > +	nr = fda->nr;
> > +
> > +	for (i = 0; i < fda->nr_stat; i++) {
> > +		if (fda->stat_entries[i].fd != -1) {
> > +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
> > +					   fda->stat_entries[i].events);
> 
> so every call to fdarray__poll will add whatever is
> in stat_entries to entries? how is it removed?
> 
> I think you should either follow what Adrian said
> and put 'static' descriptors early and check for
> filter number to match it as an 'quick fix'
> 
> or we should fix it for real and make it generic
> 
> so currently the interface is like this:
> 
>   pos1 = fdarray__add(a, fd1 ... );
>   pos2 = fdarray__add(a, fd2 ... );
>   pos3 = fdarray__add(a, fd2 ... );
> 
>   fdarray__poll(a);
> 
>   num = fdarray__filter(a, revents, destructor, arg);
> 
> when fdarray__filter removes some of the fds the 'pos1,pos2,pos3'
> indexes are not relevant anymore
> 
> how about we make the 'pos indexes' being stable by allocating
> separate object for each added descriptor and each poll call
> would create pollfd array from current objects, and entries
> would keep pointer to its pollfd entry
> 
>   struct fdentry *entry {
>        int              fd;
>        int              events;
>        struct pollfd   *pollfd;
>   }
> 
>   entry1 = fdarray__add(a, fd1 ...);
>   entry2 = fdarray__add(a, fd2 ...);
>   entry3 = fdarray__add(a, fd3 ...);
> 
>   fdarray__poll(a);
> 
>   struct pollfd *fdarray__entry_pollfd(a, entry1);
> 
> or smoething like that ;-)

maybe something like below (only compile tested)

jirka


---
diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 58d44d5eee31..f1effed3dde1 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -22,8 +22,8 @@ int fdarray__grow(struct fdarray *fda, int nr)
 	void *priv;
 	int nr_alloc = fda->nr_alloc + nr;
 	size_t psize = sizeof(fda->priv[0]) * nr_alloc;
-	size_t size  = sizeof(struct pollfd) * nr_alloc;
-	struct pollfd *entries = realloc(fda->entries, size);
+	size_t size  = sizeof(struct fdentry *) * nr_alloc;
+	struct fdentry **entries = realloc(fda->entries, size);
 
 	if (entries == NULL)
 		return -ENOMEM;
@@ -58,7 +58,12 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow)
 
 void fdarray__exit(struct fdarray *fda)
 {
+	int i;
+
+	for (i = 0; i < fda->nr; i++)
+		free(fda->entries[i]);
 	free(fda->entries);
+	free(fda->pollfd);
 	free(fda->priv);
 	fdarray__init(fda, 0);
 }
@@ -69,18 +74,25 @@ void fdarray__delete(struct fdarray *fda)
 	free(fda);
 }
 
-int fdarray__add(struct fdarray *fda, int fd, short revents)
+struct fdentry *fdarray__add(struct fdarray *fda, int fd, short revents)
 {
-	int pos = fda->nr;
+	struct fdentry *entry;
 
 	if (fda->nr == fda->nr_alloc &&
 	    fdarray__grow(fda, fda->nr_autogrow) < 0)
-		return -ENOMEM;
+		return NULL;
+
+	entry = malloc(sizeof(*entry));
+	if (!entry)
+		return NULL;
+
+	entry->fd = fd;
+	entry->revents = revents;
+	entry->pollfd = NULL;
 
-	fda->entries[fda->nr].fd     = fd;
-	fda->entries[fda->nr].events = revents;
+	fda->entries[fda->nr] = entry;
 	fda->nr++;
-	return pos;
+	return entry;
 }
 
 int fdarray__filter(struct fdarray *fda, short revents,
@@ -93,7 +105,7 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
-		if (fda->entries[fd].revents & revents) {
+		if (fda->entries[fd]->revents & revents) {
 			if (entry_destructor)
 				entry_destructor(fda, fd, arg);
 
@@ -113,7 +125,22 @@ int fdarray__filter(struct fdarray *fda, short revents,
 
 int fdarray__poll(struct fdarray *fda, int timeout)
 {
-	return poll(fda->entries, fda->nr, timeout);
+	struct pollfd *pollfd = fda->pollfd;
+	int i;
+
+	pollfd = realloc(pollfd, sizeof(*pollfd) * fda->nr);
+	if (!pollfd)
+		return -ENOMEM;
+
+	fda->pollfd = pollfd;
+
+	for (i = 0; i < fda->nr; i++) {
+		pollfd[i].fd = fda->entries[i]->fd;
+		pollfd[i].revents = fda->entries[i]->revents;
+		fda->entries[i]->pollfd = &pollfd[i];
+	}
+
+	return poll(pollfd, fda->nr, timeout);
 }
 
 int fdarray__fprintf(struct fdarray *fda, FILE *fp)
@@ -121,7 +148,12 @@ int fdarray__fprintf(struct fdarray *fda, FILE *fp)
 	int fd, printed = fprintf(fp, "%d [ ", fda->nr);
 
 	for (fd = 0; fd < fda->nr; ++fd)
-		printed += fprintf(fp, "%s%d", fd ? ", " : "", fda->entries[fd].fd);
+		printed += fprintf(fp, "%s%d", fd ? ", " : "", fda->entries[fd]->fd);
 
 	return printed + fprintf(fp, " ]");
 }
+
+int fdentry__events(struct fdentry *entry)
+{
+	return entry->pollfd->revents;
+}
diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index b39557d1a88f..5231ce047f2e 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -6,6 +6,12 @@
 
 struct pollfd;
 
+struct fdentry {
+	int		 fd;
+	int		 revents;
+	struct pollfd	*pollfd;
+};
+
 /**
  * struct fdarray: Array of file descriptors
  *
@@ -20,7 +26,10 @@ struct fdarray {
 	int	       nr;
 	int	       nr_alloc;
 	int	       nr_autogrow;
-	struct pollfd *entries;
+
+	struct fdentry	**entries;
+	struct pollfd	 *pollfd;
+
 	union {
 		int    idx;
 		void   *ptr;
@@ -33,7 +42,7 @@ void fdarray__exit(struct fdarray *fda);
 struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
 void fdarray__delete(struct fdarray *fda);
 
-int fdarray__add(struct fdarray *fda, int fd, short revents);
+struct fdentry *fdarray__add(struct fdarray *fda, int fd, short revents);
 int fdarray__poll(struct fdarray *fda, int timeout);
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
@@ -41,6 +50,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
 int fdarray__grow(struct fdarray *fda, int extra);
 int fdarray__fprintf(struct fdarray *fda, FILE *fp);
 
+int fdentry__events(struct fdentry *entry);
+
 static inline int fdarray__available_entries(struct fdarray *fda)
 {
 	return fda->nr_alloc - fda->nr;

