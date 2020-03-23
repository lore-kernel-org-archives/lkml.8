Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22042C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBFD2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxRClrga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCWX4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:56:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38178 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCWX4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:56:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id t28so15409148ott.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ix8wgcI17GVIT6csUF0tAYBE2LaGOYJ65o4zi4Z+Z6c=;
        b=cxRClrgaWN/fpDic28j6dquzcmGVw+xYCBcb9evltHJpyFpceHUzfKZJMIJhOLclFx
         Yn2A3TP5Stbe0rKKKA/IDNeP6sQu7YUUq74s5fXrAmxwnECa9lFLzGP2bXzZ2DmVKPgL
         UDLguXXmIlABThiCSt5lssfGYmuDsDVHy3ovX3K/B0/plnPrQcOqebITxOQuZ/DZffwT
         OhGqRBkkNp3UqEPletWR4FAIHWjJFvKqYVN8qCAzkXSZ9bQ7aH/jjGGf8ucrXstsZArj
         gA7y7Jxp7obe4aoMrhUye9oj3Q9UqQfJGy1EH69U31823NIqpoSP5pj6ibFOe6U4weCd
         K+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ix8wgcI17GVIT6csUF0tAYBE2LaGOYJ65o4zi4Z+Z6c=;
        b=L2Jd7VnfjNXhEJ3hMMaxdYzXpEVfPSbV/83J1NQ8FRETuXy0i+sabRa5HEIUwUrvX9
         p3ZacUAKNLgI6pHMzysNkcqmGNrOO7/dn3ASMotI6JYwYYpijtwASYdCH10NUAg/L2dH
         /5gmTEn6M+ilxn6aHf9mSIoiBB18mX7I/GzOAqlU2xsjvxcMpH1w9HfsGr9jVjF0DCo7
         qeKwXl/C6ZhGJd78pSSGJQwGiI1CGKs88wH1qBSC2Y4046c4/7wtP+Mgqqj5sgHa+H7R
         CTylFJv75xioojo4MxillzSGyeLjQwv6F9XbTUtm2H3I4SlR6gbUtpWKciWUofdO2aDT
         ndaQ==
X-Gm-Message-State: ANhLgQ0iazQvUNYdtJ65ivKwcwAK/jvm6ar9u6rM7NuU5G3+aFQsL7PD
        IhoBhkEHZHaflLjJCJnZLuF3p/Rbq+d1XIe/iSDwtQ==
X-Google-Smtp-Source: ADFU+vuDPdpSQy4eIZVOQE+DA/YA6x9KuEZDOGaV/GyUNXkAFHrjBMzNKJjNEWfmfUZNmYn+XKHPMpfaDEYyQ1QtrIo=
X-Received: by 2002:a05:6830:1e10:: with SMTP id s16mr4024265otr.33.1585007814217;
 Mon, 23 Mar 2020 16:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-3-mike.kravetz@oracle.com> <2ca058dc-47e6-1d08-154b-77d2cbe98e34@c-s.fr>
In-Reply-To: <2ca058dc-47e6-1d08-154b-77d2cbe98e34@c-s.fr>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 23 Mar 2020 16:56:43 -0700
Message-ID: <CAHS8izOeYeVi-W7z-DKw3Uv0rAqwuD1__uTr-oF6Lx=V9ekm3g@mail.gmail.com>
Subject: Re: [PATCH 2/4] hugetlbfs: move hugepagesz= parsing to arch
 independent code
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:04 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 18/03/2020 =C3=A0 23:06, Mike Kravetz a =C3=A9crit :
> > Now that architectures provide arch_hugetlb_valid_size(), parsing
> > of "hugepagesz=3D" can be done in architecture independent code.
> > Create a single routine to handle hugepagesz=3D parsing and remove
> > all arch specific routines.  We can also remove the interface
> > hugetlb_bad_size() as this is no longer used outside arch independent
> > code.
> >
> > This also provides consistent behavior of hugetlbfs command line
> > options.  The hugepagesz=3D option should only be specified once for
> > a specific size, but some architectures allow multiple instances.
> > This appears to be more of an oversight when code was added by some
> > architectures to set up ALL huge pages sizes.
> >
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   arch/arm64/mm/hugetlbpage.c   | 15 ---------------
> >   arch/powerpc/mm/hugetlbpage.c | 15 ---------------
> >   arch/riscv/mm/hugetlbpage.c   | 16 ----------------
> >   arch/s390/mm/hugetlbpage.c    | 18 ------------------
> >   arch/sparc/mm/init_64.c       | 22 ----------------------
> >   arch/x86/mm/hugetlbpage.c     | 16 ----------------
> >   include/linux/hugetlb.h       |  1 -
> >   mm/hugetlb.c                  | 24 ++++++++++++++++++------
> >   8 files changed, 18 insertions(+), 109 deletions(-)
> >
>
> [snip]
>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 2f99359b93af..cd4ec07080fb 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3149,12 +3149,6 @@ static int __init hugetlb_init(void)
> >   }
> >   subsys_initcall(hugetlb_init);
> >
> > -/* Should be called on processing a hugepagesz=3D... option */
> > -void __init hugetlb_bad_size(void)
> > -{
> > -     parsed_valid_hugepagesz =3D false;
> > -}
> > -
> >   void __init hugetlb_add_hstate(unsigned int order)
> >   {
> >       struct hstate *h;
> > @@ -3224,6 +3218,24 @@ static int __init hugetlb_nrpages_setup(char *s)
> >   }
> >   __setup("hugepages=3D", hugetlb_nrpages_setup);
> >
> > +static int __init hugepagesz_setup(char *s)
> > +{
> > +     unsigned long long size;
> > +     char *saved_s =3D s;
> > +
> > +     size =3D memparse(s, &s);
>
> You don't use s after that, so you can pass NULL instead of &s and avoid
> the saved_s
>

+1

Acked-by: Mina Almasry <almasrymina@google.com>
