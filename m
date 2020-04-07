Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7980C2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FEC206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypoth03b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDGB15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:27:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33513 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:27:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id v7so141757qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yFrfK+tFik+fOM/cHfSt56CL89u4Dc4TxhZb+sXjdrU=;
        b=Ypoth03bjcScy5sQ/sj970OPLHS87XWxJdoxUNWtAhp9h/ospExbL9zZkTxomMcqqp
         j1lwgbvPDr7Nr40UXuatw0AmqjIuAFeVnFoKatJiKf6n8snALWDxT/yvJi6z3t8aRvoe
         thh+7SDLG0FX75oNyhry4j0egiW7Al0AXXoZ/IXn8PHSTCt8+TJfF59yPiTWyhye+d++
         F/7nv9xE6mNJg4wfxgyu8w4Ay9Ijui3MWPlY3vTSScpokSDG9sAZdjdTx5lgKysGGBRr
         ERh4rcM/MAxawKTc2MvFAeGa2H/jqhkAwsXEtKhZHJQtyi4Oxw5haQIZs8WtU0zuMtrT
         UZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yFrfK+tFik+fOM/cHfSt56CL89u4Dc4TxhZb+sXjdrU=;
        b=cX0+Fn5IEPX3M43XG6zKMI4qUMDH83PmjK8uAyxGicCim5UtqBmOyPAVYosAYdUq97
         gNFlGbj+QCQjiY6nUx0X7H4GNU4B73NH9WJ+QNQ82R7l1pHFdjhX+/jkK/8qcMpgh7gh
         2luaZuCZAuGkC7vggCpmtQrILb8XG4pLoNO16BRgXC4GNOsnJF4xtXjvoa6yP6Q/D1GN
         L/e0biwbU4bA5BTNWljtb38xi2bVM5BvpJE3OOojQ8sByZYAjDgC0qt0NBguKwmYZKk2
         SJ8NpY4mM2eCwVG4EAsfDn50lVVoHc1iXeQt8jvnIHsEgQ+rW411Pr80ExxbjsmNsbEn
         emAQ==
X-Gm-Message-State: AGi0PuaEK2j5bQGf74v7NsRWyZhdb7RdQv0OEMIbbgVWpQg+EQl7zFSq
        5fWgyQ3tfNiifGJbJYcNWCkbKPOUH7qlGxNs8Ps=
X-Google-Smtp-Source: APiQypKGeD71S95RmxnGo5Nm9/Ge46J6EJU/0CFU+68VQI9Z7I3oNbx8q/ewrdPHweNIU98/Q1SbeWMwbLmSss8E7Qo=
X-Received: by 2002:a05:620a:1311:: with SMTP id o17mr18030143qkj.343.1586222875309;
 Mon, 06 Apr 2020 18:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
 <CAHbLzkqdupWUv7vPpqDpOARuYkBiTxmQxNi-zaw_TWVB1FsNjQ@mail.gmail.com>
 <CAAmzW4Mr7NtOpPKpskhnMABJeVoe-CvOuC6TEfJabS7HdcwLbQ@mail.gmail.com> <CAHbLzkoL7zKOFtRghEfsfeKOERZmTkjfi8MynuHf4oKXD9mcvQ@mail.gmail.com>
In-Reply-To: <CAHbLzkoL7zKOFtRghEfsfeKOERZmTkjfi8MynuHf4oKXD9mcvQ@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 7 Apr 2020 10:27:44 +0900
Message-ID: <CAAmzW4MNqyYqH+GbOE8Ardz2BNi5whHxP0FmwgjX1zPHNCXw_g@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 7=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 9:22, Ya=
ng Shi <shy828301@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sun, Apr 5, 2020 at 6:03 PM Joonsoo Kim <js1304@gmail.com> wrote:
> >
> > 2020=EB=85=84 4=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 3:29=
, Yang Shi <shy828301@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Thu, Apr 2, 2020 at 10:41 PM <js1304@gmail.com> wrote:
> > > >
> > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > >
> > > > Currently, some swapped-in pages are not charged to the memcg until
> > > > actual access to the page happens. I checked the code and found tha=
t
> > > > it could cause a problem. In this implementation, even if the memcg
> > > > is enabled, one can consume a lot of memory in the system by exploi=
ting
> > > > this hole. For example, one can make all the pages swapped out and
> > > > then call madvise_willneed() to load the all swapped-out pages with=
out
> > > > pressing the memcg. Although actual access requires charging, it's =
really
> > > > big benefit to load the swapped-out pages to the memory without pre=
ssing
> > > > the memcg.
> > > >
> > > > And, for workingset detection which is implemented on the following=
 patch,
> > > > a memcg should be committed before the workingset detection is exec=
uted.
> > > > For this purpose, the best solution, I think, is charging the page =
when
> > > > adding to the swap cache. Charging there is not that hard. Caller o=
f
> > > > adding the page to the swap cache has enough information about the =
charged
> > > > memcg. So, what we need to do is just passing this information to
> > > > the right place.
> > > >
> > > > With this patch, specific memcg could be pressured more since reada=
head
> > > > pages are also charged to it now. This would result in performance
> > > > degradation to that user but it would be fair since that readahead =
is for
> > > > that user.
> > >
> > > If I read the code correctly, the readahead pages may be *not* charge=
d
> > > to it at all but other memcgs since mem_cgroup_try_charge() would
> > > retrieve the target memcg id from the swap entry then charge to it
> > > (generally it is the memcg from who the page is swapped out). So, it
> > > may open a backdoor to let one memcg stress other memcgs?
> >
> > It looks like you talk about the call path on CONFIG_MEMCG_SWAP.
> >
> > The owner (task) for a anonymous page cannot be changed. It means that
> > the previous owner written on the swap entry will be the next user. So,
> > I think that using the target memcg id from the swap entry for readahea=
d pages
> > is valid way.
> >
> > As you concerned, if someone can control swap-readahead to readahead
> > other's swap entry, one memcg could stress other memcg by using the fac=
t above.
> > However, as far as I know, there is no explicit way to readahead other'=
s swap
> > entry so no problem.
>
> Swap cluster readahead would readahead in pages on consecutive swap
> entries which may belong to different memcgs, however I just figured
> out patch #8 ("mm/swap: do not readahead if the previous owner of the
> swap entry isn't me") would prevent from reading ahead pages belonging
> to other memcgs. This would kill the potential problem.

Yes, that patch kill the potential problem. However, I think that swap clus=
ter
readahead would not open the backdoor even without the patch #8 in
CONFIG_MEMCG_SWAP case, because:

1. consecutive swap space is usually filled by the same task.
2. swap cluster readahead needs a large I/O price to the offender and effec=
t
isn't serious to the target.
3. those pages would be charged to their previous owner and it is valid.

Thanks.
