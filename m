Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F09C11D19
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DEC2467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQemFjxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBTSRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:17:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38075 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:17:06 -0500
Received: by mail-io1-f67.google.com with SMTP id s24so5745466iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkxRzQQdsIgezztPpGEXgB6Tbmhl9XsKSgHs8oMS58Y=;
        b=jQemFjxSgs+RoEzDujDqc912isO0FUO0iIwvqLQJMChzH/Gmf/croCHJidjUYYZCqQ
         lw9uK4DfNAdkD1ouXwdr9zyhQ6VigKaKkJPZg1+hgfKhT0C3+Xe5FoiZ7heBU+OjjsM0
         y2DEJ/IzOZHgfE4ixY90KY5gtlpiaqKTeoWx6VCXN3DN+yfIpjZ6uo6KCNllAS1sQ8sU
         HGKU1F1G01iyehjfju6BPOSbJ4Atfis29U0cvBqqebpduIoBhW1PKPZ8qlV3lTgYLKLM
         2X4HqP62mlgsviOvsMA2/YpXRxYbtLOTyR4K+l+JmAp36GrNmP2ZVf7QND7JYCMmW/x+
         gboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkxRzQQdsIgezztPpGEXgB6Tbmhl9XsKSgHs8oMS58Y=;
        b=tdO4hXUAhfQSa88HFh8ttBOHPAPgBnnY3Ef1Vzdd5Xer+i+gog/4foZM1JXxkL8M8Y
         4nsDQKW09zH3UrFr6yMQdqrobPlrDqvTrXnedAPB0tE3/eWVQ+a86OafdfNdgZ/zV4R1
         hiVs+9GLcYohgpcg1x7xJF747+2vKeksNaFNbJ7pyykYem+wf4iqpsqTRSXbH0K8l12y
         4nMdMHEjNGNolGiClwI2PHJ3PZ5l8Q8417wAKYOvFNWfwo/qHlfU7rzSNQn7sJg0kLBC
         v4L9xeipWF5GvTez5ibm908BCzUY1eQUMk/5hZ36rWETQVkkNT1U3/VASzsWpNews+Q7
         etyA==
X-Gm-Message-State: APjAAAUTVp5jrNo0xazAxPshF+nGhPnOinCkEGtkIPUemK8FtY9Mk3fX
        GBmooakaP95cDwEbNr9Mxjb6l0v89AmLDaZJXfY=
X-Google-Smtp-Source: APXvYqysOLP0nXkKrh7QibdX9lVVNj1wUJPOGTNbIYlXM9+byhTu1Mczx/ZINDwIE2aoIO/UgYE+T2O1d6xPrMxlzu8=
X-Received: by 2002:a6b:6205:: with SMTP id f5mr26192797iog.42.1582222625697;
 Thu, 20 Feb 2020 10:17:05 -0800 (PST)
MIME-Version: 1.0
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 20 Feb 2020 10:16:54 -0800
Message-ID: <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP partially
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> Currently when truncating shmem file, if the range is partial of THP
> (start or end is in the middle of THP), the pages actually will just get
> cleared rather than being freed unless the range cover the whole THP.
> Even though all the subpages are truncated (randomly or sequentially),
> the THP may still be kept in page cache.  This might be fine for some
> usecases which prefer preserving THP.
>
> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> So, when using shmem THP as memory backend QEMU inflation actually doesn't
> work as expected since it doesn't free memory.  But, the inflation
> usecase really needs get the memory freed.  Anonymous THP will not get
> freed right away too but it will be freed eventually when all subpages are
> unmapped, but shmem THP would still stay in page cache.
>
> Split THP right away when doing partial hole punch, and if split fails
> just clear the page so that read to the hole punched area would return
> zero.
>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

One question I would have is if this is really the desired behavior we
are looking for?

By proactively splitting the THP you are likely going to see a
performance regression with the virtio-balloon driver enabled in QEMU.
I would suspect the response to that would be to update the QEMU code
to  identify the page size of the shared memory ramblock. At that
point I suspect it would start behaving the same as how it currently
handles anonymous memory, and the work done here would essentially
have been wasted other than triggering the desire to resolve this in
QEMU to avoid a performance regression.

The code for inflating a the balloon in virtio-balloon in QEMU can be
found here:
https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66

If there is a way for us to just populate the value obtained via
qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
which is the size I am assuming it is at since you indicated that it
is just freeing the base page size, then we could address the same
issue and likely get the desired outcome of freeing the entire THP
page when it is no longer used.

- Alex
