Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE2BC33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 05:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BDB24681
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 05:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgH3J6aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgARFcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 00:32:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43983 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgARFcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 00:32:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so24315275edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 21:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGO7As1ACatxG0Km9ZDObq/5CWcC4DDbVgvTHZSZ69o=;
        b=DgH3J6aqNr0SkIyXXTWbwvdqt0OSx9ziGjcKa8VB0bSCWxoOhFl1CG5Bu2Mrxa/OMZ
         Qphe7I5cjOrzlZHUChYTKg+aExR0QSq6bRJgALzZomhzCXGQzbaIMECerEYW+UL/zLha
         79nEXY0MWSUF09nC7pAXctcZW4MqcsaUqdPOYJ/BkcF1G1OElMNWOPy9FmkUJMdvkETe
         GmNnPw7OpbLd+wS93b5Qrw7m2e38Gu6kRnu8nFb436xSs3PVm0CLd8tncBLhRR6Nczcz
         ePiyC7PeYJan7JagiXZB7fR8qoe0orag9C2iaxrS/NQamL8vWtBOWRBXQ1X0Ui29BDEa
         wMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGO7As1ACatxG0Km9ZDObq/5CWcC4DDbVgvTHZSZ69o=;
        b=fj0/PC12XhtrozvfZoyz3d6Y7sbdNvbCmDpO0ldDnMjZDjf+qBFzfNkTLJsimNhCJh
         mmyuVCMtHUZK+RpRmeh+1xLckUK3SNVK25MxnEo0v6M+4VC87O0ZhrCbYbolYJySndMy
         asFzw61l+/9oTviyfDpRvtGBDTiYsSC9FKucN87BNIOI84+AmlpcixocURf6ckSl+vPL
         iP5L0sNLc3tHjxN7Q9LE/iASHtZiRLYhcxRufn1AG85tQBewe+lcfnTlffLPNGxd9Mal
         mgM4usYlDVuGep82ZfGenA7Sp6LLwtJugYHB2Y9kjtooI/EicmGc/ThAzNrA/J3rkDz7
         kDHA==
X-Gm-Message-State: APjAAAULdP5hLLGdxY8xDaW+18kocHtdKRKUx7dNIIiIvmKm0qQ7MBPK
        6QBKMmyiXqSJno5uOvsqWdR724y5MLFT8oUF0Ek=
X-Google-Smtp-Source: APXvYqzjMlhU6tPuIqThx7vP/9qBNYifikvYJ+ycVTF4/jxz3XJWZSdykWesD0CMM/78tWPC5NflAQSvZDBTwcstrVI=
X-Received: by 2002:a50:ba83:: with SMTP id x3mr7442375ede.206.1579325566598;
 Fri, 17 Jan 2020 21:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
 <20200117222740.GB29229@richard> <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
In-Reply-To: <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Jan 2020 21:32:32 -0800
Message-ID: <CAHbLzkpWcyUtKC_kpMPxvgbo2OA06Yfb1zRcux4-d4zgMCUZbQ@mail.gmail.com>
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

On Fri, Jan 17, 2020 at 3:30 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Jan 17, 2020 at 2:27 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >
> > On Fri, Jan 17, 2020 at 03:45:34PM +0800, Wei Yang wrote:
> > >If we get here after successfully adding page to list, err would be
> > >the number of pages in the list.
> > >
> > >Current code has two problems:
> > >
> > >  * on success, 0 is not returned
> > >  * on error, the real error code is not returned
> > >
> >
> > Well, this breaks the user interface. User would receive 1 even the migration
> > succeed.
> >
> > The change is introduced by e0153fc2c760 ("mm: move_pages: return valid node
> > id in status if the page is already on the target node").
>
> Yes, it may return a value which is > 0. But, it seems do_pages_move()
> could return > 0 value even before this commit.
>
> For example, if I read the code correctly, it would do:
>
> If we already have some pages on the queue then
> add_page_for_migration() return error, then do_move_pages_to_node() is
> called, but it may return > 0 value (the number of pages that were
> *not* migrated by migrate_pages()), then the code flow would just jump
> to "out" and return the value. And, it may happen to be 1.

Just figured out this is another regression introduced by a49bd4d71637
("mm, numa: rework do_pages_move"). Already posted a patch to fix it.

>
> I'm not sure if it breaks the user interface since the behavior has
> been existed for years, and it looks nobody complains about it. Maybe
> glibc helps hide it or people just care if it is 0 and the status.
>
> >
> > >Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > >---
> > > mm/migrate.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/mm/migrate.c b/mm/migrate.c
> > >index 557da996b936..c3ef70de5876 100644
> > >--- a/mm/migrate.c
> > >+++ b/mm/migrate.c
> > >@@ -1677,7 +1677,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
> > >       err1 = do_move_pages_to_node(mm, &pagelist, current_node);
> > >       if (!err1)
> > >               err1 = store_status(status, start, current_node, i - start);
> > >-      if (!err)
> > >+      if (err >= 0)
> > >               err = err1;
> > > out:
> > >       return err;
> > >--
> > >2.17.1
> >
> > --
> > Wei Yang
> > Help you, Help me
> >
