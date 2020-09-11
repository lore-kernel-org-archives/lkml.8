Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06E6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6575E2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDgsuAR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgIKHtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgIKHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599810581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F74XmnvmIOv7/0c83mboFgtyfFoiNlg6s2uPMowubsw=;
        b=IDgsuAR7Z2RA9lyNW23cfJfzWIc4pkLJDk5puAhtgGKsGhDyXxrsIYx9xxb0Nk7CHeJlsT
        SQu3C2b7JuuTxulfmv6w4qvIFUOxxFhYrpxqFvfqsWEw1vUmnzmB73k0nRkmg9GOLWz2xS
        J6YJpCSSNP13A7tUQZSuLQGs5hNnAIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-MTOhIK0iOxCrDHiCDOuZuA-1; Fri, 11 Sep 2020 03:49:37 -0400
X-MC-Unique: MTOhIK0iOxCrDHiCDOuZuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FDF91017DC7;
        Fri, 11 Sep 2020 07:49:36 +0000 (UTC)
Received: from krava (unknown [10.40.192.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id B2A2181C40;
        Fri, 11 Sep 2020 07:49:32 +0000 (UTC)
Date:   Fri, 11 Sep 2020 09:49:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: [PATCH] perf: Fix race in perf_mmap_close function
Message-ID: <20200911074931.GA1714160@krava>
References: <20200910104153.1672460-1-jolsa@kernel.org>
 <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
 <20200910144744.GA1663813@krava>
 <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 12:05:10PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Thu, Sep 10, 2020 at 11:50 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Sep 10, 2020 at 10:48:02PM +0900, Namhyung Kim wrote:
> >
> > SNIP
> >
> > > >   _do_fork+0x83/0x3a0
> > > >   __do_sys_wait4+0x83/0x90
> > > >   __do_sys_clone+0x85/0xa0
> > > >   do_syscall_64+0x5b/0x1e0
> > > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >
> > > > Using atomic decrease and check instead of separated calls.
> > > > This fixes CVE-2020-14351.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  kernel/events/core.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index 7ed5248f0445..29313cc54d9e 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -5903,8 +5903,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> > > >                 mutex_unlock(&event->mmap_mutex);
> > > >         }
> > > >
> > > > -       atomic_dec(&rb->mmap_count);
> > > > -
> > > >         if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > > >                 goto out_put;
> > >
> > > But when it takes the goto, rb->mmap_count won't decrement anymore..
> >
> > event->mmap_count is per event, so if we have have race in here,
> > 2 threads can go through with each event->mmap_count reaching zero
> 
> Maybe I'm missing something.
> 
> But as far as I can see, perf_mmap_close() always decremented both
> rb->mmap_count and event->mmap_count.  But with this change,
> it seems not decrement rb->mmap_count when event->mmap_count
> doesn't go to zero, right?

ugh, that's right.. how about change below

jirka


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ed5248f0445..8ab2400aef55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5868,11 +5868,11 @@ static void perf_pmu_output_stop(struct perf_event *event);
 static void perf_mmap_close(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
-
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
 	int mmap_locked = rb->mmap_locked;
 	unsigned long size = perf_data_size(rb);
+	bool detach_rest = false;
 
 	if (event->pmu->event_unmapped)
 		event->pmu->event_unmapped(event, vma->vm_mm);
@@ -5903,7 +5903,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		mutex_unlock(&event->mmap_mutex);
 	}
 
-	atomic_dec(&rb->mmap_count);
+	if (atomic_dec_and_test(&rb->mmap_count))
+		detach_rest = true;
 
 	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
 		goto out_put;
@@ -5912,7 +5913,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mutex_unlock(&event->mmap_mutex);
 
 	/* If there's still other mmap()s of this buffer, we're done. */
-	if (atomic_read(&rb->mmap_count))
+	if (!detach_rest)
 		goto out_put;
 
 	/*

