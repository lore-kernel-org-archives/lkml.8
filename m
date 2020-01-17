Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FDC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C174021D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmbDAwbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgAQXae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:30:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32866 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbgAQXad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:30:33 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so23862621edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 15:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCCYlDZcNgoml+0c24ZO2L5zKWUXiA9cZ58LrpH144k=;
        b=JmbDAwbXXB5RGvmeRg1WWAAKeyjsZZBtJ08W4tZoEk/CSrnPguZJgGe2lioXMXhfBL
         DCgGnk7oH10mqvkcDu5pSs5RGo0HXJ41X+4w2Zyw2HzVoy28e9v2ArnZUYbZa1qfh0n2
         X+b79T707SNPzogQ9MC8LHjmEuIZAvSTjKpKFd4UFOJG/m0fiw8W707oUNKKqGHzMNzB
         8Dt/aZeQ8u+LZ1zaemJmg4kn5PYxYeJ88m7bq6i+dg5TNdaoYaLY8jV1ZCutWGZ4r9+f
         v3iTWfxX/ovKWcAgvz669ECNXk90D2lMcAj7Md8GQWG8kdfVvjkvmCvMp04vho3Hii4g
         jeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCCYlDZcNgoml+0c24ZO2L5zKWUXiA9cZ58LrpH144k=;
        b=naGmFj1b5EdRpJhNkUy/jvAk3t/+7hHj119LCZ2BBjmcSd/y5daDiwHOxTPhDpl3Dd
         RZvsKtnGR97tn1DVdNBjBXugd2TTEBwxEAHuxt/4Ey5/kUmVzfV5Du4nYecu3xG6p3Mr
         9EvxPUkhgaIcUvn1b5AWTP5rFu48isVcUBnOv5zfPybiPEPpiAPUJ14uy9ZlSGJOzf0S
         FM8j3+5nZo5oaLiBpj9DtLAqXx0PbVtzdLnXXHvnVFowhGEqe6csQyTJh9j7k6fQWNtY
         gewFoGxENhPo8SEA2FtZgjHWgtuxEervdgU3u4zIlyi3vW7PC5SOiSB633HMMrjrVe/b
         oZjA==
X-Gm-Message-State: APjAAAWWqydHk+jPq9Be2vu68EMm4WMHcWigoZBDqAd/sHj/YyxIoJy5
        r1z+s+3Le5oy3MjHrtEQaBA4594gSrQbGMqtJzX/3gmV
X-Google-Smtp-Source: APXvYqzhO1sFOcgNuTNHMKBeKa5gMZ8L8WbFoYEU0kh57iLsbmtrLICnJDVQuCNyUQt/E8nUqaOLJxDGpcdDzZ5prVI=
X-Received: by 2002:aa7:de05:: with SMTP id h5mr6553530edv.343.1579303832030;
 Fri, 17 Jan 2020 15:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20200117074534.25324-1-richardw.yang@linux.intel.com> <20200117222740.GB29229@richard>
In-Reply-To: <20200117222740.GB29229@richard>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Jan 2020 15:30:18 -0800
Message-ID: <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
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

On Fri, Jan 17, 2020 at 2:27 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Fri, Jan 17, 2020 at 03:45:34PM +0800, Wei Yang wrote:
> >If we get here after successfully adding page to list, err would be
> >the number of pages in the list.
> >
> >Current code has two problems:
> >
> >  * on success, 0 is not returned
> >  * on error, the real error code is not returned
> >
>
> Well, this breaks the user interface. User would receive 1 even the migration
> succeed.
>
> The change is introduced by e0153fc2c760 ("mm: move_pages: return valid node
> id in status if the page is already on the target node").

Yes, it may return a value which is > 0. But, it seems do_pages_move()
could return > 0 value even before this commit.

For example, if I read the code correctly, it would do:

If we already have some pages on the queue then
add_page_for_migration() return error, then do_move_pages_to_node() is
called, but it may return > 0 value (the number of pages that were
*not* migrated by migrate_pages()), then the code flow would just jump
to "out" and return the value. And, it may happen to be 1.

I'm not sure if it breaks the user interface since the behavior has
been existed for years, and it looks nobody complains about it. Maybe
glibc helps hide it or people just care if it is 0 and the status.

>
> >Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >---
> > mm/migrate.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/mm/migrate.c b/mm/migrate.c
> >index 557da996b936..c3ef70de5876 100644
> >--- a/mm/migrate.c
> >+++ b/mm/migrate.c
> >@@ -1677,7 +1677,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
> >       err1 = do_move_pages_to_node(mm, &pagelist, current_node);
> >       if (!err1)
> >               err1 = store_status(status, start, current_node, i - start);
> >-      if (!err)
> >+      if (err >= 0)
> >               err = err1;
> > out:
> >       return err;
> >--
> >2.17.1
>
> --
> Wei Yang
> Help you, Help me
>
