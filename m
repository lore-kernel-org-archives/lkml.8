Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D63C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5841C222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFod3waq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAOM6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:58:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42907 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:58:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so15621623qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnuqtyCo79ecJMDcqIdYLzfy9F7O3a3eKV+Q3SmZ78k=;
        b=PFod3waqugMfHQRbo87NKarrvygRIbjaiMI3JhwZ/2oZCsaWWlGnbzJtNUUq/ak1S7
         vM/Fo7dSxllwaprj6ECNwLX1W6imNrWBzR7ihtPtpKZ8Sruj2Nfc0XW6iWCtQ1+Uvtlk
         JI8iJYLBGJUud8Ke207loe1bfQzUUiCz9cCCsyN5MrUSGgkp7wFwxoLrM37w0IrqgIWm
         d+ckvHqqqVJWJ+ukdPr0Wmb3ucKREsjBgftNfoGJAca4vckWCQwAZCyPM79pDsG+EpJP
         BxVDXHNLZ5WK2QC177Zqv774RaS5GKE83th6Q9TdNPazW/cqueP+dea9VSULEs9pXWAO
         b32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnuqtyCo79ecJMDcqIdYLzfy9F7O3a3eKV+Q3SmZ78k=;
        b=oTprnBu7FErQM7Sw2oRIBkRMTsQgLIRH5SQlPataYp8Rtn+r/PRkj7IQuf55Bo8hml
         lZKZ/YSML+zBnvHvQ+4c7Nr85tBzoHQjpkJO9R/9SHU20mxqVoK1CTnICPG522dbf7lA
         KPawBfzNDWLrbnN8rOD8xOarZzUGhn2QFtm+iNEfHvSpYr6YesdS+SDjZQpt8LHNHVcY
         bHVoV8tNTr31yBgdjO7RXkA6sOV6dnAym01W+m9r7caTClc+iqPTKgAQubj6TDh8BIZc
         /a1VTUBPzphr+5ZxfgXnvsDN71XWjgWk8QHvQuZEcTsaub1q/Pimlu/Sdt2eI+oa4Ake
         fNjQ==
X-Gm-Message-State: APjAAAWkv/WoMoHhPwDF2M4IAcXto0hf4d0gzixP3t8QNnpn07JZIDwz
        4k72M08nv9EyJk7iRvOYJsbTyUSl3vkUT35UF5RcoQ==
X-Google-Smtp-Source: APXvYqy3nhpgs6g7ApU9pKVNQYLycYgaxhat1ufBVvJXS6nM+pKjtXlT676RDuHYzS2q2HLqCT1ubDcr9bVajL5UVO0=
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr3316465qtt.257.1579093078944;
 Wed, 15 Jan 2020 04:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain> <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz>
In-Reply-To: <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Jan 2020 13:57:47 +0100
Message-ID: <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy.c: Fix out of bounds write in mpol_parse_str()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 1:54 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/15/20 6:54 AM, Dan Carpenter wrote:
> > What we are trying to do is change the '=' character to a NUL terminator
> > and then at the end of the function we restore it back to an '='.  The
> > problem is there are two error paths where we jump to the end of the
> > function before we have replaced the '=' with NUL.  We end up putting
> > the '=' in the wrong place (possibly one element before the start of
> > the buffer).
>
> Bleh.
>
> > Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
> > Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> CC stable perhaps? Can this (tmpfs mount options parsing AFAICS?) become
> part of unprivileged operation in some scenarios?

Yes, tmpfs can be mounted by any user inside of a user namespace.
Also I suspect there are cases where an unprivileged attacker can
trick some utility to mount tmpfs on their behalf and provide their
own mount options.

> > ---
> >  mm/mempolicy.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 067cf7d3daf5..1340c5c496b5 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2817,6 +2817,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
> >       char *flags = strchr(str, '=');
> >       int err = 1, mode;
> >
> > +     if (flags)
> > +             *flags++ = '\0';        /* terminate mode string */
> > +
> >       if (nodelist) {
> >               /* NUL-terminate mode or flags string */
> >               *nodelist++ = '\0';
> > @@ -2827,9 +2830,6 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
> >       } else
> >               nodes_clear(nodes);
> >
> > -     if (flags)
> > -             *flags++ = '\0';        /* terminate mode string */
> > -
> >       mode = match_string(policy_modes, MPOL_MAX, str);
> >       if (mode < 0)
> >               goto out;
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/d31f6069-bda7-2cdb-b770-0c9cddac7537%40suse.cz.
