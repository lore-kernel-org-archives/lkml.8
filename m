Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4907620774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah9XHSxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgFIO4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:56:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730110AbgFIO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591714578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qr3nrQh9qomXHmW9GCwYIwW3Az1MoBpcgu3kHuXjuL4=;
        b=Ah9XHSxlwrXYn7axikghvqPLbRrdTPAJw14lxB5vZJCuteY+fVr+lZ+pypSyOs4l5oXzE8
        LEF5+ZYCRyYV52ukUyzk5wwf2PyvlQeYhhzurXrYKA2boNYFYaIUIUgN08r+G9Sx/gd9po
        ezHyKcrXG5WWjXaUCOWZA2M2iLhgGW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-vmhmauY3NJizL7ESP_JM7Q-1; Tue, 09 Jun 2020 10:56:16 -0400
X-MC-Unique: vmhmauY3NJizL7ESP_JM7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7313461;
        Tue,  9 Jun 2020 14:56:14 +0000 (UTC)
Received: from krava (unknown [10.40.192.219])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1AAC35C1D2;
        Tue,  9 Jun 2020 14:56:12 +0000 (UTC)
Date:   Tue, 9 Jun 2020 16:56:11 +0200
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
Message-ID: <20200609145611.GI1558310@krava>
References: <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava>
 <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <345e3f6e-627d-89fc-364d-59f76071ccaa@linux.intel.com>
 <6a861ce4-3769-fc2a-5f9d-3003238a9736@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a861ce4-3769-fc2a-5f9d-3003238a9736@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:18:20PM +0300, Alexey Budankov wrote:

SNIP

> >>>>> So how is it about just adding _revents() and _del() for fixed fds with
> >>>>> correction of retval to bool for fdarray__add()?
> >>>>
> >>>> I don't like the separation for fixed and non-fixed fds,
> >>>> why can't we make generic?
> >>>
> >>> Usage models are different but they want still to be parts of the same class
> >>> for atomic poll(). The distinction is filterable vs. not filterable.
> >>> The distinction should be somehow provided in API. Options are:
> >>> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
> >>>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
> >>> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
> >>>    use the type in __filter() and __poll() and, perhaps, other internals;
> >>>    expose less API calls in comparison with option 1
> >>>
> >>> Exposure of pos for filterable fds should be converted to bool since currently
> >>> the returned pos can become stale and there is no way in API to check its state.
> >>> So it could look like this:
> >>>
> >>> fdkey = fdarray__add(array, fd, events, type)
> >>> type: filterable, nonfilterable, somthing else
> >>> revents = fdarray__get_revents(fdkey);
> >>> fdarray__del(array, fdkey);
> >>
> >> I think there's solution without having filterable type,

so with the changes I proposed it could no longer be called fdarray ;-)
which I think was the idea at the begning.. just an array of fds

I'd like to have fully flaged events object.. but that's bigger change

> > 
> > and still making the atomic fdarray__poll()?
> 
> How is it about design like this?
> 
>     int fdarray__poll(struct fdarray *fda, int timeout)
> 
> with additional external array of fds to simultaneously poll() on:
> 
>     int fdarray__poll(struct fdarray *fda, int timeout,
>                       int *fds, size_t fds_size)
> 
> fds would be added to array just prior poll() call.

yep, I was considering something like this, having:

  fdarray__poll2(fda1, fda2)
  fdarray__pollx(fda, ...)

but it would need to create an pollfd array and write
the poll results back to arrays.. might be expensive

another idea is to forbid filter to screw the array
and return only remaining number, like below

jirka


---
diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 58d44d5eee31..89f9a2193c2d 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -93,22 +93,21 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
+		if (!fda->entries[fd].events)
+			continue;
+
 		if (fda->entries[fd].revents & revents) {
 			if (entry_destructor)
 				entry_destructor(fda, fd, arg);
 
+			fda->entries[fd].revents = fda->entries[fd].events = 0;
 			continue;
 		}
 
-		if (fd != nr) {
-			fda->entries[nr] = fda->entries[fd];
-			fda->priv[nr]	 = fda->priv[fd];
-		}
-
 		++nr;
 	}
 
-	return fda->nr = nr;
+	return nr;
 }
 
 int fdarray__poll(struct fdarray *fda, int timeout)
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index c7c81c4a5b2b..d0c8a05aab2f 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -12,6 +12,7 @@ static void fdarray__init_revents(struct fdarray *fda, short revents)
 
 	for (fd = 0; fd < fda->nr; ++fd) {
 		fda->entries[fd].fd	 = fda->nr - fd;
+		fda->entries[fd].events  = revents;
 		fda->entries[fd].revents = revents;
 	}
 }
@@ -29,7 +30,7 @@ static int fdarray__fprintf_prefix(struct fdarray *fda, const char *prefix, FILE
 
 int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int nr_fds, expected_fd[2], fd, err = TEST_FAIL;
+	int nr_fds, err = TEST_FAIL;
 	struct fdarray *fda = fdarray__new(5, 5);
 
 	if (fda == NULL) {
@@ -55,7 +56,6 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 
 	fdarray__init_revents(fda, POLLHUP);
 	fda->entries[2].revents = POLLIN;
-	expected_fd[0] = fda->entries[2].fd;
 
 	pr_debug("\nfiltering all but fda->entries[2]:");
 	fdarray__fprintf_prefix(fda, "before", stderr);
@@ -66,17 +66,9 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_delete;
 	}
 
-	if (fda->entries[0].fd != expected_fd[0]) {
-		pr_debug("\nfda->entries[0].fd=%d != %d\n",
-			 fda->entries[0].fd, expected_fd[0]);
-		goto out_delete;
-	}
-
 	fdarray__init_revents(fda, POLLHUP);
 	fda->entries[0].revents = POLLIN;
-	expected_fd[0] = fda->entries[0].fd;
 	fda->entries[3].revents = POLLIN;
-	expected_fd[1] = fda->entries[3].fd;
 
 	pr_debug("\nfiltering all but (fda->entries[0], fda->entries[3]):");
 	fdarray__fprintf_prefix(fda, "before", stderr);
@@ -88,14 +80,6 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_delete;
 	}
 
-	for (fd = 0; fd < 2; ++fd) {
-		if (fda->entries[fd].fd != expected_fd[fd]) {
-			pr_debug("\nfda->entries[%d].fd=%d != %d\n", fd,
-				 fda->entries[fd].fd, expected_fd[fd]);
-			goto out_delete;
-		}
-	}
-
 	pr_debug("\n");
 
 	err = 0;

