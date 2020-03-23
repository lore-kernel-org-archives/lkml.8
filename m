Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319EBC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E790520714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUxoa5we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCWD7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:59:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44353 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbgCWD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584935941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VgrWRsz0mib8JqDkUkkSf0D7ZrcQJQkL69wmdKsejDg=;
        b=NUxoa5wef08/FeCU9w59AdQUYR87zCODDEcPpabfQGlG/j8qwm2tPHokTWb78Ntir5HHVJ
        1NGnWR8dJ3wQNTNUwtLOKVtct+xx/4S6O+vjisUdDc1+l4czWymRdBYVo0SVko27EujpLr
        bvMFnPwLgLjBIF2Hwbys49IwVQIHzfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-b5XX35X6Pv2UfrnjnuuxxQ-1; Sun, 22 Mar 2020 23:58:52 -0400
X-MC-Unique: b5XX35X6Pv2UfrnjnuuxxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1BE1005514;
        Mon, 23 Mar 2020 03:58:50 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7AF219C4F;
        Mon, 23 Mar 2020 03:58:46 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:58:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 1/2] mm/page_alloc: use ac->high_zoneidx for
 classzone_idx
Message-ID: <20200323035843.GH2987@MiWiFi-R3L-srv>
References: <1584693135-4396-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584693135-4396-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20200320103000.GB3039@MiWiFi-R3L-srv>
 <CAAmzW4PVguD0jEEAt0ZUPqMykswuq2an21jRpP2ZuwRL6PYwCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAmzW4PVguD0jEEAt0ZUPqMykswuq2an21jRpP2ZuwRL6PYwCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 at 12:50pm, Joonsoo Kim wrote:
> Hello, Baoquan.
>=20
> 2020=EB=85=84 3=EC=9B=94 20=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 7:3=
0, Baoquan He <bhe@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> >
> > On 03/20/20 at 05:32pm, js1304@gmail.com wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > Currently, we use the zone index of preferred_zone which represents
> > > the best matching zone for allocation, as classzone_idx. It has
> > > a problem on NUMA systems when the lowmem reserve protection exists
> > > for some zones on a node that do not exist on other nodes.
> > >
> > > In NUMA system, it can be possible that each node has different pop=
ulated
> > > zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone=
 and
> > > node 1 could have only NORMAL zone. In this setup, allocation reque=
st
> > > initiated on node 0 and the one on node 1 would have different
> > > classzone_idx, 3 and 2, respectively, since their preferred_zones a=
re
> > > different. If the allocation is local, there is no problem. However=
,
> > > if it is handled by the remote node due to memory shortage, the pro=
blem
> > > would happen.
> >
> > Hi Joonsoo,
> >
> > Not sure if adding one sentence into above paragraph would be make it
> > easier to understand. Assume you are only talking about the high_zone=
idx
> > is MOVABLE_ZONE with calculation of gfp_zone(gfp_mask), since any oth=
er
> > case doesn't have this problem. Please correct me if I am wrong.
>=20
> You're right. This example is for the allocation request with
> gfp_zone(gfp_mask),
> MOVABLE_ZONE.
>=20
> > In NUMA system, it can be possible that each node has different popul=
ated
> > zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone a=
nd
> > node 1 could have only NORMAL zone. In this setup, if we get high_zon=
eidx
> > as 3 (namely MOVABLE zone), with gfp_zone(gfp_mask), allocation reque=
st
> > initiated on node 0 and the one on node 1 would have different
> > classzone_idx, 3 and 2, respectively, since their preferred_zones are
> > different. If the allocation is local, there is no problem. However,
> > if it is handled by the remote node due to memory shortage, the probl=
em
> > would happen.
>=20
> I'm okay with your change but I try again to be better. Please check th=
e
> following rewritten commit message and please let me know if it is bett=
er
> than before.

Yeah, this new one looks very detailed, I believe anyone interested can
get what's going on. Thanks for doing this.

>=20
> Thanks.
>=20
> ------------------------>8-------------------------------
> From 3842d99d54c02c25cc6f6077fd0e97acabc10917 Mon Sep 17 00:00:00 2001
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Date: Fri, 4 May 2018 09:55:21 +0900
> Subject: [PATCH] mm/page_alloc: use ac->high_zoneidx for classzone_idx
>=20
> Currently, we use classzone_idx to calculate lowmem reserve proetection
> for an allocation request. This classzone_idx causes a problem
> on NUMA systems when the lowmem reserve protection exists for some zone=
s
> on a node that do not exist on other nodes.
>=20
> Before further explanation, I should first clarify how to compute
> the classzone_idx and the high_zoneidx.
>=20
> - ac->high_zoneidx is computed via the arcane gfp_zone(gfp_mask) and
> represents the index of the highest zone the allocation can use
> - classzone_idx was supposed to be the index of the highest zone on
> the local node that the allocation can use, that is actually available
> in the system
>=20
> Think about following example. Node 0 has 4 populated zone,
> DMA/DMA32/NORMAL/MOVABLE. Node 1 has 1 populated zone, NORMAL. Some zon=
es,
> such as MOVABLE, doesn't exist on node 1 and this makes following
> difference.
>=20
> Assume that there is an allocation request whose gfp_zone(gfp_mask) is
> the zone, MOVABLE. Then, it's high_zoneidx is 3. If this allocation is
> initiated on node 0, it's classzone_idx is 3 since actually
> available/usable zone on local (node 0) is MOVABLE. If this allocation
> is initiated on node 1, it's classzone_idx is 2 since actually
> available/usable zone on local (node 1) is NORMAL.
>=20
> You can see that classzone_idx of the allocation request are different
> according to their starting node, even if their high_zoneidx is the sam=
e.
>=20
> Think more about these two allocation requests. If they are processed
> on local, there is no problem. However, if allocation is initiated
> on node 1 are processed on remote, in this example, at the NORMAL zone
> on node 0, due to memory shortage, problem occurs. Their different
> classzone_idx leads to different lowmem reserve and then different
> min watermark. See the following example.
>=20
> root@ubuntu:/sys/devices/system/memory# cat /proc/zoneinfo
> Node 0, zone      DMA
>   per-node stats
> ...
>   pages free     3965
>         min      5
>         low      8
>         high     11
>         spanned  4095
>         present  3998
>         managed  3977
>         protection: (0, 2961, 4928, 5440)
> ...
> Node 0, zone    DMA32
>   pages free     757955
>         min      1129
>         low      1887
>         high     2645
>         spanned  1044480
>         present  782303
>         managed  758116
>         protection: (0, 0, 1967, 2479)
> ...
> Node 0, zone   Normal
>   pages free     459806
>         min      750
>         low      1253
>         high     1756
>         spanned  524288
>         present  524288
>         managed  503620
>         protection: (0, 0, 0, 4096)
> ...
> Node 0, zone  Movable
>   pages free     130759
>         min      195
>         low      326
>         high     457
>         spanned  1966079
>         present  131072
>         managed  131072
>         protection: (0, 0, 0, 0)
> ...
> Node 1, zone      DMA
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  0
>         present  0
>         managed  0
>         protection: (0, 0, 1006, 1006)
> Node 1, zone    DMA32
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  0
>         present  0
>         managed  0
>         protection: (0, 0, 1006, 1006)
> Node 1, zone   Normal
>   per-node stats
> ...
>   pages free     233277
>         min      383
>         low      640
>         high     897
>         spanned  262144
>         present  262144
>         managed  257744
>         protection: (0, 0, 0, 0)
> ...
> Node 1, zone  Movable
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  262144
>         present  0
>         managed  0
>         protection: (0, 0, 0, 0)
>=20
> - static min watermark for the NORMAL zone on node 0 is 750.
> - lowmem reserve for the request with classzone idx 3 at the NORMAL
> on node 0 is 4096.
> - lowmem reserve for the request with classzone idx 2 at the NORMAL
> on node 0 is 0.
>=20
> So, overall min watermark is:
> allocation initiated on node 0 (classzone_idx 3): 750 + 4096 =3D 4846
> allocation initiated on node 1 (classzone_idx 2): 750 + 0 =3D 750
>=20
> allocation initiated on node 1 will have some precedence than allocatio=
n
> initiated on node 0 because min watermark of the former allocation is
> lower than the other. So, allocation initiated on node 1 could succeed
> on node 0 when allocation initiated on node 0 could not, and, this coul=
d
> cause too many numa_miss allocation. Then, performance could be
> downgraded.
>=20
> Recently, there was a regression report about this problem on CMA patch=
es
> since CMA memory are placed in ZONE_MOVABLE by those patches. I checked
> that problem is disappeared with this fix that uses high_zoneidx
> for classzone_idx.
>=20
> http://lkml.kernel.org/r/20180102063528.GG30397@yexl-desktop
>=20
> Using high_zoneidx for classzone_idx is more consistent way than previo=
us
> approach because system's memory layout doesn't affect anything to it.
> With this patch, both classzone_idx on above example will be 3 so will
> have the same min watermark.
>=20
> allocation initiated on node 0: 750 + 4096 =3D 4846
> allocation initiated on node 1: 750 + 4096 =3D 4846
>=20
> One could wonder if there is a side effect that allocation initiated on
> node 1 will use higher bar when allocation is handled on local since
> classzone_idx could be higher than before. It will not happen because
> the zone without managed page doesn't contributes lowmem_reserve at all=
.
>=20
> Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Tested-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/internal.h b/mm/internal.h
> index c39c895..aebaa33 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -119,7 +119,7 @@ struct alloc_context {
>         bool spread_dirty_pages;
>  };
>=20
> -#define ac_classzone_idx(ac) zonelist_zone_idx(ac->preferred_zoneref)
> +#define ac_classzone_idx(ac) (ac->high_zoneidx)
>=20
>  /*
>   * Locate the struct page for both the matching buddy in our
> --=20
> 2.7.4
>=20

