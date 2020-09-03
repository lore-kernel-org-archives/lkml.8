Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8563CC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6680620716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599162976;
	bh=5IpTGMxuZ7gcqM0wZeoo9zCPw09JFw2xsZPxuG701+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rTi3c0ChEn0wl3dhT9+3l9BTnrd/e2rsSrqrPjqL796hLNweSvgMn7zs9RQlaYJaw
	 C85WaswP06O+PamSM2AymqfSAYhSceV2CTbFpJ+67rp7eNBOZJVf7QKGHxhzJikFZm
	 vIhxBYzmGxJhkSzK54fMKgv8GHOwaECMZld56tkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgICT4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgICT4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:56:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DA8C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 12:56:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t7so4519069ljo.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HyCacCrUTSO04Bcz2fAaxbtZLHd8zOfhLgllifmbhk=;
        b=B/wF0S73fEkmrWeW78FVYp9qaLcNFtik9sGGBc1uklYgCiZlOnL6UKyw8zxdwXKlmM
         yZe+asx0TMiJqjKXU+9nuISZd3LkJxAOGu4NBUmczdu3m4VNq8bXfQHWIGfk/u5osF/7
         jhDBu8BCJd9u28EonQab6s+MaaNgFFzQ7//vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HyCacCrUTSO04Bcz2fAaxbtZLHd8zOfhLgllifmbhk=;
        b=VsZcK7Ptv0q20d7z9KxzWqpbWOmPl6vjvbV0QDlvoUiyJob1CQxVmH0CnQvRcOPx7p
         kKvnSJMwHlAbRS1sTsBEbIgGzaFWP0yJkYnmlhJdJcy++APLlXHHKKMTLkybxFI2RqF6
         MmqUYKmffbHtDRQkjPPp8IY1PZhQnf2iGMbMUN/iG5soxwsAi24ibPTXYJBQ9Fk0XQ3S
         NZZ7li2waaZcCtdz2BYkRa8Lb/Mc833Ud7bHK0F9WkEjB9q8iZPMHFup4x83PrxgQY8s
         AABQ4f/BcVAjuUi0ptYaAZpmroVV1QToa1JvOyRd/uWkn+TGbZJyP+HhjLkQiXU7ut6a
         todg==
X-Gm-Message-State: AOAM533dMyduIm5U2ypKGYyFbJyfJb+o2f6f1ls7zl+Lsd0NPjFxoBfv
        4cR13EhXt69hKda3IYVZx771NFmaKkrZdg==
X-Google-Smtp-Source: ABdhPJxGt+83BkWRC3isKW34iMAOVnodRYnrwbN6hyjydfc9UcCsAfCkm/XoKjX08SW74xPrCLDjeg==
X-Received: by 2002:a2e:2c0e:: with SMTP id s14mr400460ljs.174.1599162971688;
        Thu, 03 Sep 2020 12:56:11 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 69sm791194lfm.83.2020.09.03.12.56.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 12:56:10 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v23so5260603ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:56:10 -0700 (PDT)
X-Received: by 2002:a2e:3611:: with SMTP id d17mr6508lja.314.1599162969764;
 Thu, 03 Sep 2020 12:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Sep 2020 12:55:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
Message-ID: <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
Subject: Re: a crash when running strace from persistent memory
To:     Mikulas Patocka <mpatocka@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 12:24 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> There's a bug when you run strace from dax-based filesystem.
>
> -- create real or emulated persistent memory device (/dev/pmem0)
> mkfs.ext2 /dev/pmem0
> -- mount it
> mount -t ext2 -o dax /dev/pmem0 /mnt/test
> -- copy the system to it (well, you can copy just a few files that are
>    needed for running strace and ls)
> cp -ax / /mnt/test
> -- bind the system directories
> mount --bind /dev /mnt/test/dev
> mount --bind /proc /mnt/test/proc
> mount --bind /sys /mnt/test/sys
> -- run strace on the ls command
> chroot /mnt/test/ strace /bin/ls
>
> You get this warning and ls is killed with SIGSEGV.
>
> I bisected the problem and it is caused by the commit
> 17839856fd588f4ab6b789f482ed3ffd7c403e1f (gup: document and work around
> "COW can break either way" issue). When I revert the patch (on the kernel
> 5.9-rc3), the bug goes away.

Funky. I really don't see how it could cause that, but we have the
UDDF issue too, so I'm guessing I will have to fix it the radical way
with Peter Xu's series based on my "rip out COW special cases" patch.

Or maybe I'm just using that as an excuse for really wanting to apply
that series.. Because we can't just revert that GUP commit due to
security concerns.

> [   84.191504] WARNING: CPU: 6 PID: 1350 at mm/memory.c:2486 wp_page_copy.cold+0xdb/0xf6

I'm assuming this is the WARN_ON_ONCE(1) on line 2482, and you have
some extra debug patch that causes that line to be off by 4? Because
at least for me, line 2486 is actually an empty line in v5.9-rc3.

That said, I really think this is a pre-existing race, and all the
"COW can break either way" patch does is change the timing (presumably
due to the actual pattern of actually doing the COW changing).

See commit c3e5ea6ee574 ("mm: avoid data corruption on CoW fault into
PFN-mapped VMA") for background.

Mikulas, can you check that everything works ok for that case if you
apply Peter's series? See

    https://lore.kernel.org/lkml/20200821234958.7896-1-peterx@redhat.com/

or if you have 'b4' installed, use

    b4 am 20200821234958.7896-1-peterx@redhat.com

to get the series..

                     Linus
