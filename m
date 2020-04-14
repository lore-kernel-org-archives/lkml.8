Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96585C38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741C12074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI2CbHQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505213AbgDNTsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505188AbgDNTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:47:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C2C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:47:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z26so1100345ljz.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJK+Q+UKkDQaruBYiWcWjNudKJdkietMzkyNFKfwUfY=;
        b=NI2CbHQmy0JJhl4ytQt1TbKJDLFhbGdB6cugYS+62mNdDgladQHA0hgMSpm0uXhk9o
         OenLF/9qzYoyXCkuv5tboOvQ6DYSBgPak6ZedVQ8kUkb2+i3/FPQaVyVDxSnO7vm1ajm
         O8Ee2EwUzbtxLpnuvL5B21vXVbTPdRKawqDL3gkIiIr+Jrz202HaTyAyl3ggcMnK6bgF
         aHJmI2L8Q4H3BoMBCL08Cbenfkc2Ktqw+9w5IwhZlfXIkOWQjb/acdtVBaaBe5mpT7GX
         kwMHIbu70LH9UdN5hfijW4qXB2bKDyy7J84+hu3Wd69S/RaX2rI2sxEYDfE0xTjOAuIN
         MV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJK+Q+UKkDQaruBYiWcWjNudKJdkietMzkyNFKfwUfY=;
        b=hWufysNL6BsReUyWqSw44D3w4emGDsEECdXVgPqxuEx96hx5OubOzFKbFrYXkDoJNN
         D8ZnG8bkLJ2BDYvVCbHq4+iqlH+HNKgamJHiCFuqqnt54V3sRAXmiE/0FNZZ6+C7AMVE
         l/AsnO9cJ0mcYs1M9IXCdAZJFeNE1F2bALRnBHXhvxTYTURR8yVQ2QwvARHiJKwgr/Mp
         ZUpkqhtOZhBKMsnik6znyHbRubgb21PF/eTy+DbZ8S4a02TgVA4W3r2jRr1STTfnFTSG
         o+RLOoEJZAOdJtKaJsKgkIgRAJX5QZctic1XWcPBhxWOt4HFHyJkYV6Kf75GcwDDzMpW
         U8dg==
X-Gm-Message-State: AGi0PuY6RNmhGH/6BBkGbVsU52FE2WWx0SI8kfVsiLstVERvL5nFHd9M
        z+B4t3RxyenShaQZBlgDfEZpGnWM7IqX8YCICHQ=
X-Google-Smtp-Source: APiQypLGUYk3suy/eSUDKH5ICT7nYCw/nP+Vjdcx+EdWiVN7l3yhVL9RbojbaGVteYNrgDbwy7b43T8oKlKY7EU+/X4=
X-Received: by 2002:a2e:6c05:: with SMTP id h5mr1012285ljc.217.1586893643490;
 Tue, 14 Apr 2020 12:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200407095107.1988-1-miles.chen@mediatek.com> <20200407181908.GB94792@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200407181908.GB94792@iweiny-DESK2.sc.intel.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 15 Apr 2020 01:25:07 +0530
Message-ID: <CAFqt6zYztssQEgMJtafr_ZdMYvBwAU-BZ4Z4tOWQPJ6eFnHq2Q@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix null pointer dereference detected by coverity
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 11:49 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Tue, Apr 07, 2020 at 05:51:07PM +0800, Miles Chen wrote:
> > In fixup_user_fault(), it is possible that unlocked is NULL,
> > so we should test unlocked before using it.
> >
> > For example, in arch/arc/kernel/process.c, NULL is passed
> > to fixup_user_fault().
> >
> > SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
> > {
> > ...
> >       ret = fixup_user_fault(current, current->mm, (unsigned long) uaddr,
> >                              FAULT_FLAG_WRITE, NULL);
> > ...
> > }
> >
> > Fixes: 4a9e1cda2748 ("mm: bring in additional flag for fixup_user_fault to signal unlock")
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>
> > ---
> >  mm/gup.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index da3e03185144..a68d11dc232d 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1230,7 +1230,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
> >       if (ret & VM_FAULT_RETRY) {
> >               down_read(&mm->mmap_sem);
> >               if (!(fault_flags & FAULT_FLAG_TRIED)) {
> > -                     *unlocked = true;
> > +                     if (unlocked)
> > +                             *unlocked = true;
> >                       fault_flags |= FAULT_FLAG_TRIED;
> >                       goto retry;
> >               }
> > --
> > 2.18.0
>
