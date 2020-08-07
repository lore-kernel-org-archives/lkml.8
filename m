Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA602177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596763380;
	bh=taVUPcZZG/PWKJC217fUi0ps3ehP0TVRSPgn7VkId3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Jnu0//zWvWMi9RMeLiGktD4njy32Sso35mFqexrnMeAkvW+5QZD1h8CBfRIxRZ6Mx
	 dcfjLj0tWu/Z3CZ1jIYJ7P7e6Hj4ZbTu/k2jS05RYFpc55sfmXB+bVE8jnk++O7gJX
	 Bw1dnmp7ozU0npsjTH/wjosf0ibyKgVuCyc0U4X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHGBW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgHGBW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:22:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC31F206B5;
        Fri,  7 Aug 2020 01:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596763377;
        bh=taVUPcZZG/PWKJC217fUi0ps3ehP0TVRSPgn7VkId3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/x8BUWd+/8S2SPzeeZX0ZEBkmC/kgdEn44bpSuR6MN8Jpku6wnUXnriH85QTteDi
         nc584DAU+eZD+PYvvb7li6pPAlGLKaEvEJqpDBDhBQtglPSig6nadpIo7+OdYnDYgG
         rudNx0RnNOiKuEWiHCkson/aTL4X80TzTaE0G+/o=
Date:   Thu, 6 Aug 2020 18:22:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, David Rientjes <rientjes@google.com>,
        mgorman@suse.de, Michel Lespinasse <walken@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4] mm/hugetlb: add mempolicy check in the reservation
 routine
Message-Id: <20200806182256.7aab51726cd91301d53cff2d@linux-foundation.org>
In-Reply-To: <CAMZfGtVE4BJppEHrh=+E4+mo+K5Q9M5q+oBv64q_94x0YyGpqA@mail.gmail.com>
References: <20200728034938.14993-1-songmuchun@bytedance.com>
        <CAMZfGtVE4BJppEHrh=+E4+mo+K5Q9M5q+oBv64q_94x0YyGpqA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 15:45:14 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> On Tue, Jul 28, 2020 at 11:49 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > In the reservation routine, we only check whether the cpuset meets
> > the memory allocation requirements. But we ignore the mempolicy of
> > MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
> > memory allocation may fail due to mempolicy restrictions and receives
> > the SIGBUS signal. This can be reproduced by the follow steps.
> >
> >  1) Compile the test case.
> >     cd tools/testing/selftests/vm/
> >     gcc map_hugetlb.c -o map_hugetlb
> >
> >  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
> >     system. Each node will pre-allocate one huge page.
> >     echo 2 > /proc/sys/vm/nr_hugepages
> >
> >  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
> >     numactl --membind=0 ./map_hugetlb 4
> >
> > With this patch applied, the mmap will fail in the step 3) and throw
> > "mmap: Cannot allocate memory".
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reported-by: Jianchao Guo <guojianchao@bytedance.com>
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Hi Andrew,
> 
> Any comments or forgot to add this to the queue for the
> merge window?

I think Baoquan He's comment threw me off.

I worry about the use of `current' in mempolicy.h.  It's the first time
this header has referenced current and the patch forgot to include
sched.h to get the definition.  Presumably it works by accident.  I
could toss in the #include but sometimes that blows up.

But it's unlikely that we'll be getting circular includes or other such
nastiness between those two header files, so fingers crossed...

--- a/include/linux/mempolicy.h~mm-hugetlb-add-mempolicy-check-in-the-reservation-routine-fix
+++ a/include/linux/mempolicy.h
@@ -6,7 +6,7 @@
 #ifndef _LINUX_MEMPOLICY_H
 #define _LINUX_MEMPOLICY_H 1
 
-
+#include <linux/sched.h>
 #include <linux/mmzone.h>
 #include <linux/dax.h>
 #include <linux/slab.h>
_

