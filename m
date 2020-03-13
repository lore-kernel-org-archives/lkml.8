Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C72C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ABE2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc7aR29q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgCMEWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:22:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43821 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgCMEWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:22:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so8990281ljp.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 21:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olUQnOtxqUHQTHVWU+Py6tKfskOSahAGyMtt/l31rlY=;
        b=hc7aR29qbeCsqEqD0qfar4gjSHZOqGTuq1sPxpGay1+JtZbsD/Z6Fl2Bg/AzsuzWdT
         GRqoPXv+gsHj+FHI0yhQAZKvztZwIBZ2FvxvdFG+K62/A3ZRocl4SiWkGPALWUg0s/7r
         THHyQIVJuMtCBHouXC5tIF8h1+vDnr46kEJYqUkFamOywOvNJVlsxIidOSJ2EKIbdQEe
         ASHRmg8UBljlrWDOgtdTxml4yRMUH+0FBONCWECTeyGPBkCP7GIbs+rPDf7aUUcZDar8
         9kntmQ49CsFPlWybX0uOdDzb988brg9N8ABfBxgj8BQlhahGF/A1op8pub5WMVzsvYrc
         iJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olUQnOtxqUHQTHVWU+Py6tKfskOSahAGyMtt/l31rlY=;
        b=Up89DqaQPK89QFhgbBlDb98OOax5ho5flzibjUa2zDCuHNsrZPGpSZ15clzYcjm6Es
         PHdBk0/O0cLbK6XJy2JShWxIh8xBJ19yZTCy0+gCWqBUpG2bSIupAcv2d2VtKSmIgXeX
         2IPtjxYgjoSLi1xEjatQ6Kyoo7CWdpxSXcxOqr+xp7SVkAkOaZ3dxYrm96RKgIxADUMn
         O1sg/E2mdIxl+p2ndCle2LOwaYtCAHLbuquKWJ1FdHDHaRKanYSJlww5mZH8/sClDcae
         IidvnM6aDr6oszPAStDEmz0KkTf9wNkT8i1mmA6MKrAC/8/nKr+LMtVpAvkxIB+ffu5m
         qbgQ==
X-Gm-Message-State: ANhLgQ2brlUxkLEkaATnqQ7u3B/APsBMb0hn1cB6grt0Q1InnMmFRKeb
        3pPzhTBIHqEIYeo46kw4gN/5g2KrRd2ZrS20giE=
X-Google-Smtp-Source: ADFU+vsehS3C4VbFHy4XCELwQ2FRXuBEI3yQKxgLuL75ztXwYbMESOEt8fq4I+6ZKmuOmkUrGDRxCZIClzonL+fBx0g=
X-Received: by 2002:a2e:9008:: with SMTP id h8mr7005623ljg.217.1584073364517;
 Thu, 12 Mar 2020 21:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com>
 <20200312195850.29693d4e55ec27ae11443c0f@linux-foundation.org>
 <CAFqt6zZ4ceum_SHmQgub8EKJxNQ26_-UfzvK-kcejqH67QHHtA@mail.gmail.com> <20200312205741.e97a201037103bbf51e1df40@linux-foundation.org>
In-Reply-To: <20200312205741.e97a201037103bbf51e1df40@linux-foundation.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 13 Mar 2020 09:52:32 +0530
Message-ID: <CAFqt6zbh8pQ+UpPLLhQjpr+e=j-RUET7uX=XkG7AQqH9qysQaQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hmm.c : Remove additional check for lockdep_assert_held()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 9:27 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Mar 2020 09:17:22 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > On Fri, Mar 13, 2020 at 8:28 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 13 Mar 2020 07:41:00 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > > walk_page_range() already has a check for lockdep_assert_held().
> > > > So additional check for lockdep_assert_held() can be removed from
> > > > hmm_range_fault().
> > > >
> > > > ...
> > > >
> > > > --- a/mm/hmm.c
> > > > +++ b/mm/hmm.c
> > > > @@ -681,7 +681,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
> > > >       struct mm_struct *mm = range->notifier->mm;
> > > >       int ret;
> > > >
> > > > -     lockdep_assert_held(&mm->mmap_sem);
> > > >
> > > >       do {
> > > >               /* If range is no longer valid force retry. */
> > >
> > > It isn't very obvious that hmm_range_fault() is and will only be called
> > > from walk_page_range() (is it?)
> > >
> >
> > Sorry Andrew, didn't get this part ?
> > * hmm_range_fault() is and will only be called
> >  from walk_page_range() (is it?) *
>
> The patch assumes that hmm_range_fault() will only ever be called via
> walk_page_range().  How do we know this is the case?  And that it
> always will be the case?
>

Ahh, Sorry, I think change log creates confusion.

The patch assumes that walk_page_range() is called from hmm_range_fault().
currently there are two caller for hmm_range_fault().
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c, line 859
drivers/gpu/drm/nouveau/nouveau_svm.c, line 544

in both case, * &mm->mmap_sem * lock is taken before calling hmm_range_fault().
Now inside hmm_range_fault() there is a check for
lockdep_assert_held(&mm->mmap_sem)
and again inside loop walk_page_range() is called which cross check
same lockdep_assert_held().

So the idea is to remove the first check
lockdep_assert_held(&mm->mmap_sem) in hmm_range_fault().
