Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D60C7619C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D53820729
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcwB7o9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBPUkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 15:40:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37065 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:40:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id l2so7953030otp.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 12:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9J/KQizesxMDkuidN0A3es048k1LLzuTtJmLstHvM1w=;
        b=mcwB7o9O+MIGThoNYhSVu2IyTilmWafP+EKBNyabE8vAVsSurprUoFLET5DWFH6w/S
         susm8YhYlkjgv1AtQw2yAZhBM4keMWyj4R7vbm5beUHQiCwUW8V/t4hxN1cu+5TeQZjL
         VQBodjn+rFcwLrcV4CCgCr9sFApHaYEDWlO6Y6bYEmQYYuCgqdm1sMHRI4Fte/epr5TY
         VShq4DgTjeDJ+NBjD685WAPzdqkvAbqK6WBNiwwJfXT8LFQXGhCKw+9SZ7DskakKHAbt
         /CrxOkBp4lYw7MsLamBtnlJpUx5KHIo0HI+aL9i7RyGmw06zDPfVR2Bate3H4oxJSV9v
         Cc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9J/KQizesxMDkuidN0A3es048k1LLzuTtJmLstHvM1w=;
        b=TJcKNif2xlCvfehKzIjQNwV8EldthKESOMMmjKyqOW16TZzfsT9BhQ0pJRNWXKqNSk
         OTKJEBSF/1COYgsoySYjZdCfcnMCLZkhlJ+5fTsHcLxHYrgn0PHeprSdbqYPeqkVcJiO
         2s4BhCVnoNfxeOkCiN5VsrSHGjWypalmp6uVze7cod+tpiw9r6VkNGD93Dpqz5AF3/RF
         /Gd22kSUBx/hvCHsnjkM96O5pnDwDJCWy0QlUg4XRBBaL7Okb+R9sMzymWhoAbYOZwlI
         AxjwYcJ5c7vgp8SXpy/QiC8SbN0giJtAzGX27zuPJCjwkAG0JG+knO3nh5E+4+ZTHfdi
         UZ3Q==
X-Gm-Message-State: APjAAAWxQBsOhQVYZGUS8+T5SBEUwE1r3nSxd2upablKz+f6a/74jBMP
        sahSH+XEef8UbJQLwpBz3MBbQ2eAQqFlLEupf01O5g==
X-Google-Smtp-Source: APXvYqzmrS7iWEXAG+beDMxytbeXTRC8OW89vGCw8YHCB077aibexvhLwT4+0qycZ9lEvobCMH2e6PdNYfchPhh8psI=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr9951984oto.355.1581885612213;
 Sun, 16 Feb 2020 12:40:12 -0800 (PST)
MIME-Version: 1.0
References: <7ff9e944-1c6c-f7c1-d812-e12817c7a317@oracle.com>
 <20200214204544.231482-1-almasrymina@google.com> <CAHS8izMjyLzCsSga59dE+zDC3sLBuA=_u4EtsShN+EZQ1EQitw@mail.gmail.com>
 <5237b9bc-2614-0a3a-afa5-5015f30d28bc@infradead.org> <f0fd4a6b-1d4a-8e7d-65c0-a454fbf550a2@infradead.org>
In-Reply-To: <f0fd4a6b-1d4a-8e7d-65c0-a454fbf550a2@infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 16 Feb 2020 12:40:01 -0800
Message-ID: <CAHS8izP36oTFJdrV7+NSc1sc1fuGB48QDMCkamRM2nW2ni=tSg@mail.gmail.com>
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

On Fri, Feb 14, 2020 at 5:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/14/20 5:17 PM, Randy Dunlap wrote:
> > On 2/14/20 1:00 PM, Mina Almasry wrote:
> >> On Fri, Feb 14, 2020 at 12:46 PM Mina Almasry <almasrymina@google.com>=
 wrote:
> >>>
> >>> Fixes an #ifdef bug in the patch referred to below that was
> >>> causing a build error when CONFIG_DEBUG_VM &&
> >>> !CONFIG_CCGROUP_HUGETLB.
> >
> > Hi Mina,
> >
> > I don't know if this was supposed to fix the 2 build reports that I mad=
e,
> > but this does not apply cleanly to mmotm (and it's a reply email so it'=
s
> > more difficult to apply anyway):
> >
> > Applying patch mm-hugetlb-fix-CONFIG_CGROUP_HUGETLB.patch
> > patching file mm/hugetlb.c
> > Hunk #1 succeeded at 289 with fuzz 1.
> > Hunk #2 succeeded at 325 with fuzz 2.
> > Hunk #3 FAILED at 435.
> > 1 out of 3 hunks FAILED -- rejects in file mm/hugetlb.c
> >
>
> OK, I applied this patch manually and it does fix most of the reported bu=
ild problems.
> The only one remaining is this:
>
>   CC      mm/migrate.o
> In file included from ../mm/migrate.c:39:0:
> ../include/linux/hugetlb_cgroup.h:146:21: warning: =E2=80=98struct file_r=
egion=E2=80=99 declared inside parameter list will not be visible outside o=
f this definition or declaration
>               struct file_region *rg,
>                      ^~~~~~~~~~~
> ../include/linux/hugetlb_cgroup.h:145:63: warning: =E2=80=98struct resv_m=
ap=E2=80=99 declared inside parameter list will not be visible outside of t=
his definition or declaration
>  static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *=
resv,
>                                                                ^~~~~~~~
> ../include/linux/hugetlb_cgroup.h:233:59: warning: =E2=80=98struct resv_m=
ap=E2=80=99 declared inside parameter list will not be visible outside of t=
his definition or declaration
>  static inline void hugetlb_cgroup_uncharge_counter(struct resv_map *resv=
,
>                                                            ^~~~~~~~
>

Hi Randy,

Yes this was supposed to fix the build errors. I'm having trouble
reproducing the one you have pending above. This is my development
environment:

=E2=9E=9C  prodkernel2 git:(mm-build-fix) git remote show github-akpm
* remote github-akpm
  Fetch URL: https://github.com/hnaz/linux-mm.git
  Push  URL: https://github.com/hnaz/linux-mm.git

=E2=9E=9C  prodkernel2 git:(mm-build-fix) git s
## mm-build-fix...github-akpm/master [ahead 1]

=E2=9E=9C  prodkernel2 git:(mm-build-fix) make -j80 mm/migrate.o
(succeeds with no warnings).

=E2=9E=9C  prodkernel2 git:(mm-build-fix) make -j80
(succeeds with no warnings)

Is my development environment wrong? Shouldn't I be able to reproduce
this build warning on this tree with my fix?
https://github.com/hnaz/linux-mm.git

I'm using config-r9887 that you sent earlier.

I'm probably supposed to use a different branch since you also say
that my patch doesn't apply cleanily, but the mmotm readme says that
github mirrors Andrew's tree?

> >
> >>> Fixes: b5f16a533ce8a ("hugetlb: support file_region coalescing again"=
)
> >>> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >>> Cc: David Rientjes <rientjes@google.com>
> >>> Cc: Greg Thelen <gthelen@google.com>
> >>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> >>> Cc: Shakeel Butt <shakeelb@google.com>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> ---
> >>>  mm/hugetlb.c | 8 +++++---
> >>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >>> index ee6d262fe6ac0..95d34c58981d2 100644
> >>> --- a/mm/hugetlb.c
> >>> +++ b/mm/hugetlb.c
> >>> @@ -289,7 +289,7 @@ static bool has_same_uncharge_info(struct file_re=
gion *rg,
> >>>  #endif
> >>>  }
> >>>
> >>> -#ifdef CONFIG_DEBUG_VM
> >>> +#if defined(CONFIG_DEBUG_VM) && defined(CONFIG_CGROUP_HUGETLB)
> >>>  static void dump_resv_map(struct resv_map *resv)
> >>>  {
> >>>         struct list_head *head =3D &resv->regions;
> >>> @@ -325,6 +325,10 @@ static void check_coalesce_bug(struct resv_map *=
resv)
> >>>                 }
> >>>         }
> >>>  }
> >>> +#else
> >>> +static void check_coalesce_bug(struct resv_map *resv)
> >>> +{
> >>> +}
> >>>  #endif
> >>>
> >>>  static void coalesce_file_region(struct resv_map *resv, struct file_=
region *rg)
> >>> @@ -431,9 +435,7 @@ static long add_reservation_in_range(struct resv_=
map *resv, long f, long t,
> >>>         }
> >>>
> >>>         VM_BUG_ON(add < 0);
> >>> -#ifdef CONFIG_DEBUG_VM
> >>>         check_coalesce_bug(resv);
> >>> -#endif
> >>>         return add;
> >>>  }
> >>>
> >>> --
> >>> 2.25.0.265.gbab2e86ba0-goog
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
