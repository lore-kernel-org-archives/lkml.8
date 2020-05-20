Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A448C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32D320829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJPxz70g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgETCjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:39:44 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:39:44 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c2so210003ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6QM/HVw8KxrWDPwRBTY73h2pxHfUePZZ0jcVAcHgoOE=;
        b=EJPxz70gSivpus1FbKISOp9xW9c7PcCCzeNxF8kF5xUEiU+vLyh42albiNrR5LtiHJ
         jHlrdjEWOx4TMMn8PXjMHzi3LC7q1Af+xX5pBg5cxubUtBkvUDQT3TYvUx3z916SmdC1
         PMBxKrle3sl85GeJCzpHmAaoM2aO7HbFfOs1FWscfmCJLiiG0y6kmN52r8BOgiukPsQq
         J+hlDRjigLBPJavcbp5o39ZE/jOKm6/h2esXTA2ejHK4DP/WvOGvrJNQnaNWQAt7/2HK
         el2NMVukEYT76n3cNoXwdOA8y+iD/nBJ3Vea/oCzw+3fDx9UfSI3kvol6gF6lHPol5Yb
         2KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6QM/HVw8KxrWDPwRBTY73h2pxHfUePZZ0jcVAcHgoOE=;
        b=dvcHN5HLrY9D3VCEQWUeSqgDaTwTK+ukKWaTOwcSAoVpqg2Js0K0N7ikmOSFex+t56
         E+7NlHu+QIm9MeDvWyqaK7tZ+C2+fEG0JrnsCcXqCTcYIpVdrFP2t1mMggTofyTVUpYr
         HpmR4064N/TgmDv5ks6QFwseGGp2Uv8gfSt0gTRpT5Kri/nyDQbfEzE93mdDxAYygGMo
         hto4/7ZHffxPN8UwotUxV53GYWwF49mpVNbkbpk8N5z8ZqZhTDZLUYPGwMMlUeo46P3r
         GxRzqwuULSCbJ0hytcwdZkedqF6O3I95L0X1XmxuJMZhOVykaiBg2ULGqyl6KLmYm86z
         8FTg==
X-Gm-Message-State: AOAM530X2J8EEIZr3BL+Z7St3Nj9ZhfMmGmzgyuAvPEJyyXc2c65N1xr
        BsyNRyxCErgWE0QW45UmAwnnQ2FRyt+w5AaN2hy6HQ==
X-Google-Smtp-Source: ABdhPJy3K2a9M09qe/aV5Rp2+wjAzkuaWzDIDnBwhuo0KKzoSokAZozeRsiglS5XgPmQFS+gWcj02aWcHH7m+TVxXg4=
X-Received: by 2002:a25:845:: with SMTP id 66mr3770341ybi.7.1589942383442;
 Tue, 19 May 2020 19:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200422001422.232330-1-walken@google.com> <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org> <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org> <20200424012612.GA158937@google.com>
 <20200424013958.GC158937@google.com> <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
 <20200519131009.GD189720@google.com> <7c540ac9-ba44-7187-5dc2-60b4c761e91c@linux.ibm.com>
 <20200519153251.GY16070@bombadil.infradead.org> <10d48b77-5c6e-2e10-84e6-16cdd76a45f1@nvidia.com>
In-Reply-To: <10d48b77-5c6e-2e10-84e6-16cdd76a45f1@nvidia.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 19 May 2020 19:39:30 -0700
Message-ID: <CANN689EubtJL2mbcz5Au05nW87gVuY-19r7nZd9x0y320PUb0g@mail.gmail.com>
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:15 AM John Hubbard <jhubbard@nvidia.com> wrote:
> On 2020-05-19 08:32, Matthew Wilcox wrote:
> > On Tue, May 19, 2020 at 03:20:40PM +0200, Laurent Dufour wrote:
> >> Le 19/05/2020 =C3=A0 15:10, Michel Lespinasse a =C3=A9crit :
> >>> On Mon, May 18, 2020 at 03:45:22PM +0200, Laurent Dufour wrote:
> >>>> Le 24/04/2020 =C3=A0 03:39, Michel Lespinasse a =C3=A9crit :
> >>>>> Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> >>>>> should now go through the new mmap locking api. The mmap_lock is
> >>>>> still implemented as a rwsem, though this could change in the futur=
e.
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/dr=
m/etnaviv/etnaviv_gem.c
> >>>>> index dc9ef302f517..701f3995f621 100644
> >>>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> >>>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> >>>>> @@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct=
 etnaviv_gem_object *etnaviv_obj)
> >>>>>           struct etnaviv_gem_userptr *userptr =3D &etnaviv_obj->use=
rptr;
> >>>>>           int ret, pinned =3D 0, npages =3D etnaviv_obj->base.size =
>> PAGE_SHIFT;
> >>>>> - might_lock_read(&current->mm->mmap_sem);
> >>>>> + might_lock_read(&current->mm->mmap_lock);
> >>>>
> >>>> Why not a mm_might_lock_read() new API to hide the mmap_lock, and ad=
d it to
> >>>> the previous patch?
> >>>
> >>> I'm not sure why this is needed - we may rework the lock to be
> >>> something else than rwsem, but might_lock_read should still apply to
> >>> it and make sense ? I'm not sure what the extra API would bring...
> >>
> >> I guess at one time the API would become might_lock_read_a_range(), is=
n't it?

I don't think this should be necessary - from lockdep perspective,
there should not be a difference between locking a range vs the entire
address space.

> >> Furthermore this would hiding the lock's name which the goal of this s=
eries.

Actually to me the name is very secondary - the goal of the series is
to add an api abstracting the mmap locking. The lock name is secondary
to that, it only gets renamed because mmap_sem was too specific (if we
are to change the mmap locking) and to ensure we convert all direct
uses to use the api instead.

> > I think this assertion should be deleted from this driver.  It's there
> > in case get_user_pages_fast() takes the mmap sem.  It would make sense =
to
> > have this assertion in get_user_pages_fast() in case we take the fast p=
ath
> > which doesn't acquire the mmap_sem.  Something like this:

I like this idea a lot - having might_lock assertions in
get_user_pages_fast makes a log more sense than doing the same at the
call sites.

> There are a couple of recent developments in this code to keep in mind. I=
 don't
> *think* either one is a problem here, but just in case:
>
> a) The latest version of the above routine [1] is on its way to mmotm as =
of
> yesterday, and that version more firmly divides the fast and slow parts,
> via a new FOLL_FAST_ONLY flag. The fall-back to slow/regular gup only occ=
urs
> if the caller does not set FOLL_FAST_ONLY. (Note that it's a gup.c intern=
al
> flag, btw.)
>
> That gives you additional options inside internal_get_user_pages_fast(), =
such
> as, approximately:
>
> if (!(gup_flags & FOLL_FAST_ONLY))
>         might_lock_read(&current->mm->mmap_lock);
>
> ...not that that is necessarily a great idea, seeing as how it merely cha=
nges
> "might lock" into "maybe might lock".  :)

I think that is completely fine, makes sure everyone not using
FOLL_FAST_ONLY realizes that the call could block.

Can I ask you to add that assertion in your patchset ? Based on
Matthew's feedback, I would do it in my patchset, but it doesn't seem
worth doing if we know this will conflict with your changes.

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
