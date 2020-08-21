Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC995C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C394420724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3uOF+Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHUUef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:34:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B7FC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:34:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w2so2578709edv.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rl2kaa3w6LmV9LlXdX0qDQsxWMR1VskZDempA7/xnho=;
        b=O3uOF+Z3g6sMRe45YA0hU6snYHJ/bF6nwj//IDmUjyNvN8ELDhoi7H8HMisEjtMZXi
         6y006OmrQxe7UeeTyisEbpEPV4Xe/Qd1qJk0BxSV/SFy7e4Mo7J1wWbQZQnDpzZNobfe
         o+UcLeTDQrEu8+qDya8qgF8WwIIuy96JBBUX3N24buf1J0dYkT64xzU/uQF8ZDzc00nZ
         wuq0UuX++9PVEjP5wHchWXCLuEt9YfIvMciXdVmt43DzKZc33lTa3E32eAv9kCw1vkwW
         DCHC1ftV6DhvP8IfKoQUVbVDMh19KIn6CUq1QEGAIGgbRblUcNgcZL3AFLt5t71iWFxf
         GIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rl2kaa3w6LmV9LlXdX0qDQsxWMR1VskZDempA7/xnho=;
        b=PTM/4EjNET/aGMaPLTq4MIAYB4rYgnN6xRXGjxNMJRWQkTyXJmyHvhpLp24rwahumS
         FN2sFofEmqjt6cIRXaEkEgdDLtCB9CorFqukU5CXTiPYP+O1uI1a0YVqVG62STK0FXt+
         gkB24GIZwfLkQ/NTbiaDkU1Gwz7yGOJDz4ajn+vzEOWaFZ1Df9LJBOPicZJx9SgxVjNL
         dUZKTTvzIQNnrVpLqf95DkPtu4H/X3oWSoqVs735iozkSX7hSxgkk5s+FTJADWgxn/K4
         NTv+/AVay81xzYnVZLMt0bItTZRzjS/ORwhJM0U+zQmYoPUi/RmDATlDIRhqg2UYVt+l
         +jwA==
X-Gm-Message-State: AOAM532bXr55giA/JUC31oN5Q8X19y/7ZLDziDLa+UwhIpHzbFhs83gr
        EC/nJLhtyDvDfcZdApYsY4sZ7Y9ptiyrVmu2Jo0VNlv6FsY=
X-Google-Smtp-Source: ABdhPJzEdQbRXw+tnAj3mroyHaGUXhNpQJ3hwEu1sO4EBldWJaih6xbI6g96eIVUMUHRkiShrKMcmYuvJ93HfVsqMhA=
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr4561066edb.151.1598042071476;
 Fri, 21 Aug 2020 13:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e44b7d05ad6624df@google.com> <CAHbLzkqM-x0aD59z0mFRW37JsxRPL+5xKRRfU1qY18LKksQ3ZQ@mail.gmail.com>
 <20200821130337.f4d1f5cd665ab149e1f43ed5@linux-foundation.org>
In-Reply-To: <20200821130337.f4d1f5cd665ab149e1f43ed5@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 21 Aug 2020 13:34:17 -0700
Message-ID: <CAHbLzkpuCHquxCkN4EXpcZjidUHHyW0DrOC9uqDR7EA72aB6bg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in do_madvise
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+b90df26038d1d5d85c97@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 1:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 21 Aug 2020 10:15:45 -0700 Yang Shi <shy828301@gmail.com> wrote:
>
> > It looks the vma is gone. The below patch should be able to fix it:
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index dd1d43cf026d..d4aa5f776543 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -289,9 +289,9 @@ static long madvise_willneed(struct vm_area_struct *vma,
> >          */
> >         *prev = NULL;   /* tell sys_madvise we drop mmap_lock */
> >         get_file(file);
> > -       mmap_read_unlock(current->mm);
> >         offset = (loff_t)(start - vma->vm_start)
> >                         + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > +       mmap_read_unlock(current->mm);
> >         vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
> >         fput(file);
> >         mmap_read_lock(current->mm);
>
> Oh geeze.  Can you please send this along as a real patch, cc:stable,
> Fixes: 692fe62433d4c?  Please cc Jan!

Yes, sure. Working on a real patch now.
