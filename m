Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E356C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EAC20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="R+7brwVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHZCrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 22:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHZCrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 22:47:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F766C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so310188pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaSYpexlLvPxI84HazJndvbg5he7BW+IBJD7sKq5YvY=;
        b=R+7brwVTpmWlsuyGRZDJ/+/lbCauCWfnMnCJ9PH2BLBG9wwLqhHe9bnQaykWJBdJwT
         n+Mq/8UHBgyOZGF5ALc2qyohMfy4V6lbqDSCGVkpVRlMYSoVltdLbvXpCz1kCJ8rTytM
         KIQhrZ4/Kgsy6a9a5/adTTZRoEmK74MeyMwnZsZsX3RqufYk4bv5vmkTJEypJTua//fh
         NukZgNfJ8lkprjRC1OIA4RSnBnrTyMGyZcWdtHlfpCgSCZ+p/97Tv2mL3MPDk/70bITQ
         uM9YKxlu3h+x+MghVoLUSptRaosHVQbAXAvHYyIVVNBw6rzUpNfn9IvZTzWUI5+WS3WH
         5P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaSYpexlLvPxI84HazJndvbg5he7BW+IBJD7sKq5YvY=;
        b=jFgGhqeGJcm6698/3c76ZaBqraXv0vqCJvWOUVctaHA3wm7aMmISui+iT0D3Uq1VDM
         /svsVmHreHzsmm5uMsKrMk3TlXRQV3DB44x9OiyCwXWZoNC3XjQEmO7z83Sf2nkR/Kzz
         o3pFOgQDGFRbwu7z28QCBaqC2bNPrYyCD6CSpFwhuEMafCGZuIlmFzVaSOg4kYNO7PQz
         f2Ypuk6uqaGOp4R4NhJHhpZ8ao7fVzyJPVyoChWAMX/HtuyGQdTW3QfkPg1fGJroLOUq
         HrxteIGIS5rqQyb7xmGktjrTo4kKjK7I6rAU6hcL+uENgojhjhelef6cCZLWr05brKJQ
         vwGw==
X-Gm-Message-State: AOAM531rRgiVCJl5U8TuYg9t3hRjRPSYNSBw2AWPNtU4wsdb0h6vfU4o
        08b3qsuW3kJsjPI4HeUboZwlN3fHvBUD2n78xJgznw==
X-Google-Smtp-Source: ABdhPJyYvSOaJYXBWmv4cag3NWnxpTjnIegW2oU0cKZ/3pkPBFG99egp09QHEhqO35GsF5jmAY9I39VgYEZurzmSgJE=
X-Received: by 2002:a63:5515:: with SMTP id j21mr8597942pgb.31.1598410064864;
 Tue, 25 Aug 2020 19:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200822095328.61306-1-songmuchun@bytedance.com>
 <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org>
 <79800508-54c9-4cda-02de-29b1a6912e75@oracle.com> <CAMZfGtXh+FP0O92ccj532Y=K4m2S==eSK8LjYEM+p6cttV0p8Q@mail.gmail.com>
 <231ec1f1-fe7a-c48a-2427-1311360d4b9b@oracle.com>
In-Reply-To: <231ec1f1-fe7a-c48a-2427-1311360d4b9b@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 Aug 2020 10:47:08 +0800
Message-ID: <CAMZfGtWj5_Uh2KFAy4DGc0vzrNm4+Nge7rOBDAFQhh2aN7wOqA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/hugetlb: Fix a race between hugetlb
 sysctl handlers
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ak@linux.intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:03 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/24/20 8:01 PM, Muchun Song wrote:
> > On Tue, Aug 25, 2020 at 5:21 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> I too am looking at this now and do not completely understand the race.
> >> It could be that:
> >>
> >> hugetlb_sysctl_handler_common
> >> ...
> >>         table->data = &tmp;
> >>
> >> and, do_proc_doulongvec_minmax()
> >> ...
> >>         return __do_proc_doulongvec_minmax(table->data, table, write, ...
> >> with __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, ...
> >> ...
> >>         i = (unsigned long *) data;
> >>         ...
> >>                 *i = val;
> >>
> >> So, __do_proc_doulongvec_minmax can be dereferencing and writing to the pointer
> >> in one thread when hugetlb_sysctl_handler_common is setting it in another?
> >
> > Yes, you are right.
> >
> >>
> >> Another confusing part of the message is the stack trace which includes
> >> ...
> >>      ? set_max_huge_pages+0x3da/0x4f0
> >>      ? alloc_pool_huge_page+0x150/0x150
> >>
> >> which are 'downstream' from these routines.  I don't understand why these
> >> are in the trace.
> >
> > I am also confused. But this issue can be reproduced easily by letting more
> > than one thread write to `/proc/sys/vm/nr_hugepages`. With this patch applied,
> > the issue can not be reproduced and disappears.
>
> There certainly is an issue here as one thread can modify data in another.
> However, I am having a hard time seeing what causes the 'kernel NULL pointer
> dereference'.

If you write 0 to '/proc/sys/vm/nr_hugepages', you will get the
    kernel NULL pointer dereference, address: 0000000000000000

If you write 1024 to '/proc/sys/vm/nr_hugepages', you will get the
    kernel NULL pointer dereference, address: 0000000000000400

The address of dereference is the value which you write to the
'/proc/sys/vm/nr_hugepages'.

>
> I tried to reproduce the issue myself but was unsuccessful.  I have 16 threads
> writing to /proc/sys/vm/nr_hugepages in an infinite loop.  After several hours
> running, I did not hit the issue.  Just curious, what architecture is the
> system?  any special config or compiler options?
>
> If you can easily reproduce, can you post the detailed oops message?
>
> The 'NULL pointer' seems strange because after the first assignment to
> table->data the value should never be NULL.  Certainly it can be modified
> by another thread, but I can not see how it can be NULL.  At the beginning
> of __do_proc_doulongvec_minmax, there is a check for NULL pointer with:

CPU0:                                     CPU1:
                                          proc_sys_write
hugetlb_sysctl_handler                      proc_sys_call_handler
hugetlb_sysctl_handler_common                 hugetlb_sysctl_handler
  table->data = &tmp;                           hugetlb_sysctl_handler_common
                                                  table->data = &tmp;
    proc_doulongvec_minmax
      do_proc_doulongvec_minmax             sysctl_head_finish
        __do_proc_doulongvec_minmax
          i = table->data;
          *i = val;     // corrupt CPU1 stack

If the val is 0, you will see the NULL.

>
>         if (!data || !table->maxlen || !*lenp || (*ppos && !write)) {
>                 *lenp = 0;
>                 return 0;
>         }
>
> I looked at the code my compiler produced for __do_proc_doulongvec_minmax.
> It appears to use the same value/register for the pointer throughout the
> routine.  IOW, I do not see how the pointer can be NULL for the assignment
> when the routine does:
>
>                         *i = val;
>
> Again, your analysis/patch points out a real issue.  I just want to get
> a better understanding to make sure there is not another issue causing
> the NULL pointer dereference.

Below is my test script. There are 8 threads to execute the following script.
In my qemu, it is easy to panic. Thanks.

#!/bin/sh

while :
do
        echo 128 > /proc/sys/vm/nr_hugepages
        echo 0 > /proc/sys/vm/nr_hugepages
done

> --
> Mike Kravetz



-- 
Yours,
Muchun
