Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22027C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 04:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD0A24679
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 04:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA2Mz1e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgARE4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:56:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45205 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgARE4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 23:56:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so24240302edw.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 20:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGfzZJsZ0VtDznG+v4hqVkMXMM2o+Qib9rqwsOawLjI=;
        b=mA2Mz1e0+1QH4c76CBa0KmVxaiS+ZjaA7PatSw1qFGgXo4B7tlTXAIDXqSo00cjj7p
         8okvp6aS1MgANiKuXRaOz+0jX/MOGUvHaF7LYPNSHlHGkVazfISUsxrHIEKrWTgMwPHb
         CW8fu1n8xAl044tUeJhoKctrrJNBqNCblhS+42aUtoMduIbSeIpik1MgcvINJA79LPQp
         px+uASLwtsM0V0j4xBNZKexQGl3viWQhleJfdfaOP9qDaqgkjab5bgn0N+MEu/ZaCVli
         Ed+evrSQWI0s6bntVq3lXl8FX7EtISpqOpT4/uULFifz1vZyo19pao8C1xSn4TUEZTuU
         3Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGfzZJsZ0VtDznG+v4hqVkMXMM2o+Qib9rqwsOawLjI=;
        b=V26BYjM0ZdGXdU09ABdYSNo4mpGdYvwowSEJ3tK4SopLqSdmRgjfOiLwR73uD4nRI7
         4CKjto2b3YQo5wBfiAFbGFlt/xsZq9odbvRkDvw/VaMlmLGjxr2R4nsTAQIPIyVhpnUF
         GUCujvZEbHVHT0JseiO8wNlLdiqhRW8KfGuRQLPT0HdW1PnnuiKzfsM10ytWzesZlocb
         rXSUeqXAGekOKmXaq/j5oWI8UuuF7obHg6mvyZ1ycJCSvpuvGCUzRKvt+/M3b9sUqiPk
         IUKOgqpDz/5Qf55miAl82SvF65YwIqZ1NXsI833BBLIo8uyQlClkIYBZxHYMhZ1C247B
         5fQQ==
X-Gm-Message-State: APjAAAUBWwrLFvzI9j4NnIzeyGLGm8sbBMnQAZxs4gPkQdNLBuxo4R0R
        77nNWJTbzSiMzCfoVgj/SgnNJErhByxv4qVwWaU=
X-Google-Smtp-Source: APXvYqx+jz4TgPGI03z0x/iIqA9YWUg26zNr7AFDoL5PZpXHu7tG773pZy2Ro1cHaked/ixSThtKt5NNY5dEp6slocs=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr7684258edb.200.1579323402121;
 Fri, 17 Jan 2020 20:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
 <20200117222740.GB29229@richard> <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
 <20200117234829.GA2844@richard>
In-Reply-To: <20200117234829.GA2844@richard>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Jan 2020 20:56:27 -0800
Message-ID: <CAHbLzko_UC47Y0gBsRRK0oJS5fvhJ80EpvrjTsFi8+PuTCHGEQ@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate.c: also overwrite error when it is bigger than zero
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 3:48 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Fri, Jan 17, 2020 at 03:30:18PM -0800, Yang Shi wrote:
> >On Fri, Jan 17, 2020 at 2:27 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >>
> >> On Fri, Jan 17, 2020 at 03:45:34PM +0800, Wei Yang wrote:
> >> >If we get here after successfully adding page to list, err would be
> >> >the number of pages in the list.
> >> >
> >> >Current code has two problems:
> >> >
> >> >  * on success, 0 is not returned
> >> >  * on error, the real error code is not returned
> >> >
> >>
> >> Well, this breaks the user interface. User would receive 1 even the migration
> >> succeed.
> >>
> >> The change is introduced by e0153fc2c760 ("mm: move_pages: return valid node
> >> id in status if the page is already on the target node").
> >
> >Yes, it may return a value which is > 0. But, it seems do_pages_move()
> >could return > 0 value even before this commit.
> >
> >For example, if I read the code correctly, it would do:
> >
> >If we already have some pages on the queue then
> >add_page_for_migration() return error, then do_move_pages_to_node() is
> >called, but it may return > 0 value (the number of pages that were
> >*not* migrated by migrate_pages()), then the code flow would just jump
> >to "out" and return the value. And, it may happen to be 1.
> >
>
> This is another point I think current code is not working well. And actually,
> the behavior is not well defined or our kernel is broken for a while.

Yes, we already spotted a few mismatches, inconsistencies and edge
cases in these NUMA APIs.

>
> When you look at the man page, it says:
>
>     RETURN VALUE
>            On success move_pages() returns zero.  On error, it returns -1, and sets errno to indicate the error
>
> So per my understanding, the design is to return -1 on error instead of the
> pages not managed to move.

So do I.

>
> For the user interface, if original code check 0 for success, your change
> breaks it. Because your code would return 1 instead of 0. Suppose most user
> just read the man page for programming instead of reading the kernel source
> code. I believe we need to fix it.

Yes, I definitely agree we need fix it. But the commit log looks
confusing, particularly "on error, the real error code is not
returned". If the error is returned by add_page_for_migration() then
it will not be returned to userspace instead of reporting via status.
Do you mean this?

>
> Not sure how to include some user interface related developer to look into
> this issue. Hope this thread may catch their eyes.
>
> >I'm not sure if it breaks the user interface since the behavior has
> >been existed for years, and it looks nobody complains about it. Maybe
> >glibc helps hide it or people just care if it is 0 and the status.
> >
> >>
> >> >Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> >---
> >> > mm/migrate.c | 2 +-
> >> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> >diff --git a/mm/migrate.c b/mm/migrate.c
> >> >index 557da996b936..c3ef70de5876 100644
> >> >--- a/mm/migrate.c
> >> >+++ b/mm/migrate.c
> >> >@@ -1677,7 +1677,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
> >> >       err1 = do_move_pages_to_node(mm, &pagelist, current_node);
> >> >       if (!err1)
> >> >               err1 = store_status(status, start, current_node, i - start);
> >> >-      if (!err)
> >> >+      if (err >= 0)
> >> >               err = err1;
> >> > out:
> >> >       return err;
> >> >--
> >> >2.17.1
> >>
> >> --
> >> Wei Yang
> >> Help you, Help me
> >>
>
> --
> Wei Yang
> Help you, Help me
