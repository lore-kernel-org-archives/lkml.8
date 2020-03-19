Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A907C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D1720753
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+kDhC6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCSI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:58:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38498 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:58:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so1127683qtq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5WXZVzgoGeWeHjXvOqVQJ1mJgWoy087Hb8hKgACB9rY=;
        b=J+kDhC6A90eyhRiUK8pvjOktXN744EyDTo7d7nq+ma7ldoaUrHSrqFWyZqc4iOw56Z
         6xtzkos9fpAij/e2YFmgBGbdbufUodJ2n82nQclswLXrHIECJzQtCG859XzAgT1/Pn8V
         VvRSQrxoQjhJHFhLUIHry0Iqd/dYsot1Fx0pPzO3m6n4LosjSCEScnHjPrP4M/Y5KStQ
         7KYjAjCUJYuuX2QsyBZjaB/iprp1HBJDJUHjT4WfWFWUxXWJj8qkQ8unHaVG/qfMWb9F
         /w2IwvKwXLKy3nRJ3dMjCbB9NKZ1U9yC4Y9y/1nJqFM6WIrOOjYuuheNIpQaVXRhItpu
         DHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5WXZVzgoGeWeHjXvOqVQJ1mJgWoy087Hb8hKgACB9rY=;
        b=QhPJuAaVc7JbdWMmEkdqPKMfKoHxfudR7frY/u9FAMeVBdYutwMufQeUKxzhhq3vTB
         Q0wR0XFZut5R2a2+YIkoPy8GPj/4c+/wdTQF4pcn1rkPDVdpVboheA3nRufBq5Vk9p8r
         jGYsUBOjAL2oT0MMqlQPoGAhWS0aAZXsd3qjWLChQH9Rmt2elsqbBwdBf1bWhtfJRQu7
         7fqxiIJXDqWdPSHk2OP3gta2Mkw0SQG2sfulNnoX5zgk8Ybz6H4MHNCPxUo2ZVRvE8bS
         2DCIVKFVZlZyP+J3iFq7f3jkIRtGTC21pl6p2dq33+lz/wLdc5boMG4bwkHrKu5tmdVN
         pLRA==
X-Gm-Message-State: ANhLgQ2GyQZBQBXtXUeUXGI3z55vbj0y4vEY0whIpej7bnuTnvQqhhGr
        78+NFP4RjDtfdaUSgbN98Er24InwB4jbj+8L+jk=
X-Google-Smtp-Source: ADFU+vuC0m7YBQEsFeajYZrHo/bWbBrLYgqn1fA+bsNLqPA9miUuH98QQbl2bb9sZB93kx72sWPO7xj+FwyWl53t7mM=
X-Received: by 2002:ac8:708f:: with SMTP id y15mr1814514qto.35.1584608289921;
 Thu, 19 Mar 2020 01:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com> <alpine.DEB.2.21.2003181419090.70237@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003181419090.70237@chino.kir.corp.google.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 19 Mar 2020 17:57:58 +0900
Message-ID: <CAAmzW4PZr6QiO=6VcM_Nbf4079awHBLULAm+_A_-2mCxrzOO2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/page_alloc: use ac->high_zoneidx for classzone_idx
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 6:29, D=
avid Rientjes <rientjes@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, 18 Mar 2020, js1304@gmail.com wrote:
>
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Currently, we use the zone index of preferred_zone which represents
> > the best matching zone for allocation, as classzone_idx. It has a probl=
em
> > on NUMA system with ZONE_MOVABLE.
> >
>
> Hi Joonsoo,

Hello, David.

> More specifically, it has a problem on NUMA systems when the lowmem
> reserve protection exists for some zones on a node that do not exist on
> other nodes, right?

Right.

> In other words, to make sure I understand correctly, if your node 1 had a
> ZONE_MOVABLE than this would not have happened.  If that's true, it might
> be helpful to call out that ZONE_MOVABLE itself is not necessarily a
> problem, but a system where one node has ZONE_NORMAL and ZONE_MOVABLE and
> another only has ZONE_NORMAL is the problem.

Okay. I will try to re-write the commit message as you suggested.

> > In NUMA system, it can be possible that each node has different populat=
ed
> > zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone and
> > node 1 could have only NORMAL zone. In this setup, allocation request
> > initiated on node 0 and the one on node 1 would have different
> > classzone_idx, 3 and 2, respectively, since their preferred_zones are
> > different. If they are handled by only their own node, there is no prob=
lem.
>
> I'd say "If the allocation is local" rather than "If they are handled by
> only their own node".

I will replace it with yours. Thanks for correcting.

> > However, if they are somtimes handled by the remote node due to memory
> > shortage, the problem would happen.
> >
> > In the following setup, allocation initiated on node 1 will have some
> > precedence than allocation initiated on node 0 when former allocation i=
s
> > processed on node 0 due to not enough memory on node 1. They will have
> > different lowmem reserve due to their different classzone_idx thus
> > an watermark bars are also different.
> >
> > root@ubuntu:/sys/devices/system/memory# cat /proc/zoneinfo
> > Node 0, zone      DMA
> >   per-node stats
> > ...
> >   pages free     3965
> >         min      5
> >         low      8
> >         high     11
> >         spanned  4095
> >         present  3998
> >         managed  3977
> >         protection: (0, 2961, 4928, 5440)
> > ...
> > Node 0, zone    DMA32
> >   pages free     757955
> >         min      1129
> >         low      1887
> >         high     2645
> >         spanned  1044480
> >         present  782303
> >         managed  758116
> >         protection: (0, 0, 1967, 2479)
> > ...
> > Node 0, zone   Normal
> >   pages free     459806
> >         min      750
> >         low      1253
> >         high     1756
> >         spanned  524288
> >         present  524288
> >         managed  503620
> >         protection: (0, 0, 0, 4096)
> > ...
> > Node 0, zone  Movable
> >   pages free     130759
> >         min      195
> >         low      326
> >         high     457
> >         spanned  1966079
> >         present  131072
> >         managed  131072
> >         protection: (0, 0, 0, 0)
> > ...
> > Node 1, zone      DMA
> >   pages free     0
> >         min      0
> >         low      0
> >         high     0
> >         spanned  0
> >         present  0
> >         managed  0
> >         protection: (0, 0, 1006, 1006)
> > Node 1, zone    DMA32
> >   pages free     0
> >         min      0
> >         low      0
> >         high     0
> >         spanned  0
> >         present  0
> >         managed  0
> >         protection: (0, 0, 1006, 1006)
> > Node 1, zone   Normal
> >   per-node stats
> > ...
> >   pages free     233277
> >         min      383
> >         low      640
> >         high     897
> >         spanned  262144
> >         present  262144
> >         managed  257744
> >         protection: (0, 0, 0, 0)
> > ...
> > Node 1, zone  Movable
> >   pages free     0
> >         min      0
> >         low      0
> >         high     0
> >         spanned  262144
> >         present  0
> >         managed  0
> >         protection: (0, 0, 0, 0)
> >
> > min watermark for NORMAL zone on node 0
> > allocation initiated on node 0: 750 + 4096 =3D 4846
> > allocation initiated on node 1: 750 + 0 =3D 750
> >
> > This watermark difference could cause too many numa_miss allocation
> > in some situation and then performance could be downgraded.
> >
> > Recently, there was a regression report about this problem on CMA patch=
es
> > since CMA memory are placed in ZONE_MOVABLE by those patches. I checked
> > that problem is disappeared with this fix that uses high_zoneidx
> > for classzone_idx.
> >
> > http://lkml.kernel.org/r/20180102063528.GG30397@yexl-desktop
> >
> > Using high_zoneidx for classzone_idx is more consistent way than previo=
us
> > approach because system's memory layout doesn't affect anything to it.
> > With this patch, both classzone_idx on above example will be 3 so will
> > have the same min watermark.
> >
> > allocation initiated on node 0: 750 + 4096 =3D 4846
> > allocation initiated on node 1: 750 + 4096 =3D 4846
> >
>
> Alternatively, I assume that this could also be fixed by changing the
> value of the lowmem protection on the node without managed pages in the
> upper zone to be the max protection from the lowest zones?  In your
> example, node 1 ZONE_NORMAL would then be (0, 0, 0, 4096).

No, if lowmem_reserve of node 0 ZONE_NORMAL is (0, 0, 4096, 4096),
min watermark of the allocation initiated on node 1 is 750 +
4096(classzone_idx 2)
when allocation is tried on node 0 ZONE_NORMAL and issue would be gone.
So, I think that it cannot be fixed by your alternative.

> > One could wonder if there is a side effect that allocation initiated on
> > node 1 will use higher bar when allocation is handled on node 1 since
> > classzone_idx could be higher than before. It will not happen because
> > the zone without managed page doesn't contributes lowmem_reserve at all=
.
> >
> > Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
> > Tested-by: Ye Xiaolong <xiaolong.ye@intel.com>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Curious: is this only an issue when vm.numa_zonelist_order is set to Node=
?

Do you mean "/proc/sys/vm/numa_zonelist_order"? It looks like it's gone now=
.

Thanks.
