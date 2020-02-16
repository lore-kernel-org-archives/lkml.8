Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B6C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 21:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982D020857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 21:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofDYar0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgBPVDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 16:03:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38489 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgBPVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 16:03:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so14854926oii.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 13:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=boy+272Q42BZrKtBn6oGELmOqisldlVVBXU96cqWNxs=;
        b=ofDYar0WvORYC8UWTy10cR+k5gboP1riF7JVqOMApNUCiQjpSTpeIRDaEm5+F0uGpl
         inrtW34sxW38aINIjfK23JRBeeNcSWufVAjRGYSzB5CNQR8PN2UTYG+VYxCQHu6HqLi7
         2vq0eauxAxvMx/cM1mjkYXWJiuwKBXLj+rHMsJT4NRM8X1tWDnQF1AI7DqnHraG4iJf1
         M5MjbY38Z/WROUCokGp41JVhILCzaPGscjIUrcuZtIImZ7a73+PTVSkAhWLVRHJhx0ra
         vOXnlJOPu9/zbmGh3QVDMKrNS8bgq+p3KB8Ir1GoY+ak0MelhNc/Ed7bfQATD1ttF3z3
         ebgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=boy+272Q42BZrKtBn6oGELmOqisldlVVBXU96cqWNxs=;
        b=ontq9UmGY1I+QhSHckvUdP6/fMeXurQWOiN8GLNaKF1XkLDjgvf+RI0364DxstwTLQ
         /ITjIw0aRSrkuQ4jAQcasIZtruLRCgCL6zWbzzHVUjUmXgHiUts1gWkY7GCSfBJ2pFxL
         iAF3OsjMcZX1O3J4GOa2+snqq78DFuTAzDO9DLSl1dJ1sv2+UZUbX04dqdq3Hg/2+vyT
         uvNSElkQsWUgDsiUqN53vFM+Jw2RMem6vCvOLQrw/DDQdMpYIW1F/+Vkyn1ECeaz5pia
         Tt8e50RVtddx2wIfb83VUL74QxXlNwZzJ2zJfvjOW+JUyjIxFIX7OnPmpuCuoAQrnp+W
         AhIA==
X-Gm-Message-State: APjAAAWKY59FyPVM5X8DdavqJrzZl3V4jF58POmm/WWUaDA77EwQkflj
        tys7HZU8JPYNErVpXILn/795MSK+O2j7kDWGbCHB+jqTeaCQ1g==
X-Google-Smtp-Source: APXvYqyBvDPsL8vuYyaGM4INjehFe/hFvq4ZSgy0dMHlY9Zm5LzEHplkCNBlVgwotzOHMRZch2NZtz31uORzQmx3jr4=
X-Received: by 2002:aca:af50:: with SMTP id y77mr8391661oie.8.1581887029833;
 Sun, 16 Feb 2020 13:03:49 -0800 (PST)
MIME-Version: 1.0
References: <7ff9e944-1c6c-f7c1-d812-e12817c7a317@oracle.com>
 <20200214204544.231482-1-almasrymina@google.com> <CAHS8izMjyLzCsSga59dE+zDC3sLBuA=_u4EtsShN+EZQ1EQitw@mail.gmail.com>
 <5237b9bc-2614-0a3a-afa5-5015f30d28bc@infradead.org> <f0fd4a6b-1d4a-8e7d-65c0-a454fbf550a2@infradead.org>
 <CAHS8izP36oTFJdrV7+NSc1sc1fuGB48QDMCkamRM2nW2ni=tSg@mail.gmail.com>
In-Reply-To: <CAHS8izP36oTFJdrV7+NSc1sc1fuGB48QDMCkamRM2nW2ni=tSg@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 16 Feb 2020 13:03:38 -0800
Message-ID: <CAHS8izOTc_7RKHoJVG_dOKEjT1d4KxNOUwMqqZwyqZm0fe=HcA@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: fix CONFIG_CGROUP_HUGETLB ifdefs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-mm@kvack.org, linux-next@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 12:40 PM Mina Almasry <almasrymina@google.com> wrot=
e:
>
> On Fri, Feb 14, 2020 at 5:57 PM Randy Dunlap <rdunlap@infradead.org> wrot=
e:
> >
> > On 2/14/20 5:17 PM, Randy Dunlap wrote:
> > > On 2/14/20 1:00 PM, Mina Almasry wrote:
> > >> On Fri, Feb 14, 2020 at 12:46 PM Mina Almasry <almasrymina@google.co=
m> wrote:
> > >>>
> > >>> Fixes an #ifdef bug in the patch referred to below that was
> > >>> causing a build error when CONFIG_DEBUG_VM &&
> > >>> !CONFIG_CCGROUP_HUGETLB.
> > >
> > > Hi Mina,
> > >
> > > I don't know if this was supposed to fix the 2 build reports that I m=
ade,
> > > but this does not apply cleanly to mmotm (and it's a reply email so i=
t's
> > > more difficult to apply anyway):
> > >
> > > Applying patch mm-hugetlb-fix-CONFIG_CGROUP_HUGETLB.patch
> > > patching file mm/hugetlb.c
> > > Hunk #1 succeeded at 289 with fuzz 1.
> > > Hunk #2 succeeded at 325 with fuzz 2.
> > > Hunk #3 FAILED at 435.
> > > 1 out of 3 hunks FAILED -- rejects in file mm/hugetlb.c
> > >
> >
> > OK, I applied this patch manually and it does fix most of the reported =
build problems.
> > The only one remaining is this:
> >
> >   CC      mm/migrate.o
> > In file included from ../mm/migrate.c:39:0:
> > ../include/linux/hugetlb_cgroup.h:146:21: warning: =E2=80=98struct file=
_region=E2=80=99 declared inside parameter list will not be visible outside=
 of this definition or declaration
> >               struct file_region *rg,
> >                      ^~~~~~~~~~~
> > ../include/linux/hugetlb_cgroup.h:145:63: warning: =E2=80=98struct resv=
_map=E2=80=99 declared inside parameter list will not be visible outside of=
 this definition or declaration
> >  static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map=
 *resv,
> >                                                                ^~~~~~~~
> > ../include/linux/hugetlb_cgroup.h:233:59: warning: =E2=80=98struct resv=
_map=E2=80=99 declared inside parameter list will not be visible outside of=
 this definition or declaration
> >  static inline void hugetlb_cgroup_uncharge_counter(struct resv_map *re=
sv,
> >                                                            ^~~~~~~~
> >
>
> Hi Randy,
>
> Yes this was supposed to fix the build errors. I'm having trouble
> reproducing the one you have pending above. This is my development
> environment:
>
> =E2=9E=9C  prodkernel2 git:(mm-build-fix) git remote show github-akpm
> * remote github-akpm
>   Fetch URL: https://github.com/hnaz/linux-mm.git
>   Push  URL: https://github.com/hnaz/linux-mm.git
>
> =E2=9E=9C  prodkernel2 git:(mm-build-fix) git s
> ## mm-build-fix...github-akpm/master [ahead 1]
>
> =E2=9E=9C  prodkernel2 git:(mm-build-fix) make -j80 mm/migrate.o
> (succeeds with no warnings).
>
> =E2=9E=9C  prodkernel2 git:(mm-build-fix) make -j80
> (succeeds with no warnings)
>
> Is my development environment wrong? Shouldn't I be able to reproduce
> this build warning on this tree with my fix?
> https://github.com/hnaz/linux-mm.git
>
> I'm using config-r9887 that you sent earlier.
>
> I'm probably supposed to use a different branch since you also say
> that my patch doesn't apply cleanily, but the mmotm readme says that
> github mirrors Andrew's tree?
>

Just looking at the build error without being able to reproduce, it
looks like this diff would fix it?

=E2=9E=9C  prodkernel2 git:(mm-build-fix) =E2=9C=97 git diff
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.=
h
index a09d4164ba910..5f66cdcbe9b10 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -15,6 +15,7 @@
 #ifndef _LINUX_HUGETLB_CGROUP_H
 #define _LINUX_HUGETLB_CGROUP_H

+#include <linux/hugetlb.h>
 #include <linux/mmdebug.h>

 struct hugetlb_cgroup;

Can you let me know? Or any insight into why I can't reproduce the
warning? Wrong tree perhaps?

I suspect a forward declaration of struct resv_map and struct
file_region in hugetlb_cgroup.h would also fix.

> > >
> > >>> Fixes: b5f16a533ce8a ("hugetlb: support file_region coalescing agai=
n")
> > >>> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >>> Cc: David Rientjes <rientjes@google.com>
> > >>> Cc: Greg Thelen <gthelen@google.com>
> > >>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > >>> Cc: Shakeel Butt <shakeelb@google.com>
> > >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> > >>> ---
> > >>>  mm/hugetlb.c | 8 +++++---
> > >>>  1 file changed, 5 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > >>> index ee6d262fe6ac0..95d34c58981d2 100644
> > >>> --- a/mm/hugetlb.c
> > >>> +++ b/mm/hugetlb.c
> > >>> @@ -289,7 +289,7 @@ static bool has_same_uncharge_info(struct file_=
region *rg,
> > >>>  #endif
> > >>>  }
> > >>>
> > >>> -#ifdef CONFIG_DEBUG_VM
> > >>> +#if defined(CONFIG_DEBUG_VM) && defined(CONFIG_CGROUP_HUGETLB)
> > >>>  static void dump_resv_map(struct resv_map *resv)
> > >>>  {
> > >>>         struct list_head *head =3D &resv->regions;
> > >>> @@ -325,6 +325,10 @@ static void check_coalesce_bug(struct resv_map=
 *resv)
> > >>>                 }
> > >>>         }
> > >>>  }
> > >>> +#else
> > >>> +static void check_coalesce_bug(struct resv_map *resv)
> > >>> +{
> > >>> +}
> > >>>  #endif
> > >>>
> > >>>  static void coalesce_file_region(struct resv_map *resv, struct fil=
e_region *rg)
> > >>> @@ -431,9 +435,7 @@ static long add_reservation_in_range(struct res=
v_map *resv, long f, long t,
> > >>>         }
> > >>>
> > >>>         VM_BUG_ON(add < 0);
> > >>> -#ifdef CONFIG_DEBUG_VM
> > >>>         check_coalesce_bug(resv);
> > >>> -#endif
> > >>>         return add;
> > >>>  }
> > >>>
> > >>> --
> > >>> 2.25.0.265.gbab2e86ba0-goog
> >
> >
> > --
> > ~Randy
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
