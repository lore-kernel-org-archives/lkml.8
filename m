Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA49C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C022080C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGiXUyk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgCBOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:54:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40765 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:54:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so5154745otp.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FurzmzBAFlFWNngTfVal+Z475tKYkUlqMUri/NZJVtE=;
        b=NGiXUyk3wMYkIR2MtrujbZQzazImX87IQmkYguE8XHjf3ZChk71ZBvnsb6D5vHwsBd
         yHlWDCGQkG/EuxebnrvCJpQGHuopb53LdnPnb/HF2mSWXAZnoO1y5cbL8Q2UvcIunQhG
         ZAbYL3C0EY7e+nBo5VDEi8pfvSHM8tvGqu620tjJ8puLcTx1L4nW/h/QfLRWQ8IocPYo
         FIcT5ClFOl1dsyXUrGhQLVQZvE5EIiETXIX81vxh0pSLAclLX+qOt5VWguk3WJYTJDgS
         yFOXFBjO1hslXbhd3AdQLCqE/MBMyslT2giQZ0tJEdIUJVVADLZfKArjNGQq9Pse2ulM
         9zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FurzmzBAFlFWNngTfVal+Z475tKYkUlqMUri/NZJVtE=;
        b=BYab96EJi/QT+DDVaXySHexVOMQqQIpjpS7S1S8rbUI8b/zLokfbC4gkG+CZLfSb+k
         Zyx6CfqaDXtR+58Q6B8AjYAsT3JS2KFKbMkz1wBxq5t3D9zN+5628OQY2iwsYmU8fSq5
         KSFwdXGnJrDQA3h4/5gzmxEq6ddLhTOCxPR6Fpu2Emc2SvInov3mJa35lIo7vU3VA8Zi
         uTtOeGCKcVSkqoIuA6DzvfXiGfk77rPhVOT7sSSATfGuXZk+7XYpU6cg3GCYeGBmnb4u
         2wCPOIUt29rQc6WZtM5fN35DSK2hRvsSFUeflzq7OhvMM9iiVFDqqxsrlH1p3dvAgiUQ
         rWVQ==
X-Gm-Message-State: APjAAAXZCtt0UxDUXPqRB0e7I+Rxgl8jdPK4KxI+8FvMVoH5t7fiM/mT
        nIk8vpbIiUYGD643YAxhoenInCMp76+SjpszA2c2Y3Bl2abqSw==
X-Google-Smtp-Source: APXvYqzIdu6I2SNQfw1cQEOfgkuOAkBOTN8UFEHHNjhusKnXDUP5QHgLI1Dm9gFCJLfyKIb/lnW36xer+O+NDqb8eOI=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr13084373oti.32.1583160881384;
 Mon, 02 Mar 2020 06:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20200229162607.6000-1-jannh@google.com> <20200302125805.GB204976@krava>
In-Reply-To: <20200302125805.GB204976@krava>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Mar 2020 15:54:15 +0100
Message-ID: <CAG48ez2x4=Vh0Rvt-HWtWLGenqbNWfto_SHrz3V=DPsnyexTvQ@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix realloc() use in fdarray__grow()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 1:58 PM Jiri Olsa <jolsa@redhat.com> wrote:
> On Sat, Feb 29, 2020 at 05:26:07PM +0100, Jann Horn wrote:
> > If `entries != NULL`, then `fda->entries` has been freed, so whatever
> > happens afterwards, we must store `entries` in `fda->entries`.
> > If we bail out at the second realloc(), the new allocation will be bigger
> > than what fda->nr_alloc says, but that's fine.
> >
> > Fixes: 2171a9256862 ("tools lib fd array: Allow associating an integer cookie with each entry")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > To the maintainer:
> > I'm not sure about the etiquette for using CC stable in
> > patches for somewhat theoretical issues in userland tools;
> > feel free to tack a CC stable onto this if you think it
> > should go into stable.
> >
> >  tools/lib/api/fd/array.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> > index 58d44d5eee31..acf8eca1a94a 100644
> > --- a/tools/lib/api/fd/array.c
> > +++ b/tools/lib/api/fd/array.c
> > @@ -27,15 +27,13 @@ int fdarray__grow(struct fdarray *fda, int nr)
> >
> >       if (entries == NULL)
> >               return -ENOMEM;
> > +     fda->entries = entries;
> >
> >       priv = realloc(fda->priv, psize);
> > -     if (priv == NULL) {
> > -             free(entries);
>
> so we are sure we always call fdarray__exit even
> if we fail in here?  if that's the case then
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Ugh... actually, no, at least fdarray__new() does a plain free().
While other places like FDA_ADD use fdarray_delete()...
