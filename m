Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8423DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5929D2467B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isUzJGTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBESDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:03:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35605 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBESDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:03:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so2812346otd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4JPeEjt7Um0jnncW2xGqU+AjtbYUDQIukn/RWGYtPE=;
        b=isUzJGTJ7f76WNj3ErRloIg+GCY6ppfYFibDbF7cYNcvcP7bRHDvBg3vVrVP41nXLs
         PD07PYxEOZQqCqG5IRE3GMbWwxGcKU2rsq68DZFR+ZvP1u/m722XWWDvErZR8seAUPJF
         lJmXNrqQKx1WThrxpU0zdZL9f3fX+c3NgvQ4MzjTE+A0k3mY8hGMgUZlOpIlYwIx9S5m
         axn1qNLQiFWRnKUgyVGwi1JRtg65lw+dXxeoT8i0E4wMdPHM/G6wLJZZno+wp2aYotgQ
         VdIXRU1IW2haNgXyxDNJLYTdTXdiBOsc/mHm/TjJWbphWVF8x+egXGz5JFiSyCeALgTl
         /q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4JPeEjt7Um0jnncW2xGqU+AjtbYUDQIukn/RWGYtPE=;
        b=cOms61WjRugZQ6ASOvAIMRFrLOsSmh6GkLn4EhrEdG0fcqFzUuEaie9FQs9l/9CQT/
         sgGfcOTOscR0+bgunl5wdBJACpyCNCmRD4hflV7ZjmmLu/JLykX8hGbiHM5qa5ybH6Fd
         ywxLawY8CO0hKf8M4dYwPxTEc6eacBxtbD/kr2BvmNi9GVGXWqTHz7NIcPl5aL6iu5E9
         glPoM+K+uiKvTkPFJQuEfp7UXkvmo7uKU64LhCTnpgTyIKoFgn0PvTvcQXukRBHGsmaR
         K6eiFR4cD9DbeV/l6mrWbua+Ml0HsAom4ldp3/sEE6npV1fa8Y/c0te7gEABapDdxdoa
         BngQ==
X-Gm-Message-State: APjAAAUaPlERXuSFWzgssKDiNTD7GFAAQJKq+jIRFCmUnXPdXtCc8zDc
        a1AqhbDPqwJbcReJaANXjkqfqb6/KSRsxmoN3fu4rw==
X-Google-Smtp-Source: APXvYqwI4QpMD2okSaeJYZlKQ7m3M3grdUPeMaD894f6WIxa4tidzyKzzE/ch4oi3Il/9yMS+FGDxJwZn2N+Plr21gI=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr28112037ota.127.1580925831217;
 Wed, 05 Feb 2020 10:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-8-almasrymina@google.com> <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
 <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
 <CAHS8izNmSYumXpYXT1d8tAm36=-BRjXqdCDjLB6UNMwn5xhPZg@mail.gmail.com> <a980c9f7-2759-45a7-1add-89a390b79b39@linux.ibm.com>
In-Reply-To: <a980c9f7-2759-45a7-1add-89a390b79b39@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 5 Feb 2020 10:03:40 -0800
Message-ID: <CAHS8izNZ+_UMEDjFXxMN9ig7QFEoJn_jLqxRTKOG7CFPvbDedg@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 4:42 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
> Hi,
>
> On 05/02/20 4:03 am, Mina Almasry wrote:
> > On Tue, Feb 4, 2020 at 12:36 PM Mina Almasry <almasrymina@google.com> wrote:
> >>
> >> So the problem in this log seems to be that this log line is missing:
> >>     echo Waiting for hugetlb memory to reach size $size.
> >>
> >> The way the test works is that it starts a process that writes the
> >> hugetlb memory, then it *should* wait until the memory is written,
> >> then it should record the cgroup accounting and kill the process. It
> >> seems from your log that the wait doesn't happen, so the test
> >> continues before the background process has had time to write the
> >> memory properly. Essentially wait_for_hugetlb_memory_to_get_written()
> >> never gets called in your log.
> >>
> >> Can you try this additional attached diff on top of your changes? I
> >> attached the diff and pasted the same here, hopefully one works for
> >> you:
> >> ...
> >
> > I got my hands on a machine with 16MB default hugepage size and
> > charge_reserved_hugetlb.sh passes now after my changes. Please let me
> > know if you still run into issues.
> >
>
> With your updates, the tests are passing. Ran the tests on a ppc64 system
> that uses radix MMU (2MB hugepages) and everything passed there as well.
>

Thanks, please consider reviewing the next iteration of the patch then.

> - Sandipan
>
