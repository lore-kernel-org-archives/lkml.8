Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F1FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6448214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhxXHjiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIJUyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:54:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49941 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730921AbgIJOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599749402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bvnl+oZNY7fSyrT1rYfr08kEJ6c9MI0yMW+cHdyj6Us=;
        b=BhxXHjiTwtv9WHCCuq+wUgPt6McGP5ocihLphql9cXHjoyClq/VbdGQ9yAbbBg55pJMfU7
        0xAB+L2r7aml4jojc3cuZ6E6vbx6Pzw2FYYSjZj6FZmXsvpuN6yAhRAjoAN9sEm22X3z6x
        sqe0tixqPMzGgY6iR/06iexiM0mX1bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-1fCbfGeXMlCHyZyhcD0t6g-1; Thu, 10 Sep 2020 10:49:13 -0400
X-MC-Unique: 1fCbfGeXMlCHyZyhcD0t6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01AF5425CE;
        Thu, 10 Sep 2020 14:47:48 +0000 (UTC)
Received: from krava (unknown [10.40.192.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id D79865C22E;
        Thu, 10 Sep 2020 14:47:45 +0000 (UTC)
Date:   Thu, 10 Sep 2020 16:47:44 +0200
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
Message-ID: <20200910144744.GA1663813@krava>
References: <20200910104153.1672460-1-jolsa@kernel.org>
 <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:48:02PM +0900, Namhyung Kim wrote:

SNIP

> >   _do_fork+0x83/0x3a0
> >   __do_sys_wait4+0x83/0x90
> >   __do_sys_clone+0x85/0xa0
> >   do_syscall_64+0x5b/0x1e0
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Using atomic decrease and check instead of separated calls.
> > This fixes CVE-2020-14351.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 7ed5248f0445..29313cc54d9e 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5903,8 +5903,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> >                 mutex_unlock(&event->mmap_mutex);
> >         }
> >
> > -       atomic_dec(&rb->mmap_count);
> > -
> >         if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> >                 goto out_put;
> 
> But when it takes the goto, rb->mmap_count won't decrement anymore..

event->mmap_count is per event, so if we have have race in here,
2 threads can go through with each event->mmap_count reaching zero

jirka

