Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A131A2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YAE6FBIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgHDCna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:43:30 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17532 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgHDCn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:43:27 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200804024323epoutp03df44790cef9f346255975e163a0fbb28~n8Hr50bIL1181411814epoutp03K
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 02:43:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200804024323epoutp03df44790cef9f346255975e163a0fbb28~n8Hr50bIL1181411814epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596509003;
        bh=efUF3OauyIYy2ZeInIYQX3y3ABVq603mybX5XsvlbC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YAE6FBIzmlF76u6mhGP2BKUSsXCAqTEjT8Lc0e5owINDVFqakB2Cua4ZapgnUxoDp
         exa1SzKmfYS0V3YCW0TJdT7eG+BN91le+7EesCNhoH8WenwLP5jVS+8UQgFqGBbKUO
         979KmiD0d0FQ3UD8KjRmnIiwZj5vbm3MM+bCk3xo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200804024323epcas2p49da0b5af8c88f847159e4035e466b2bf~n8HrhLRrf2035120351epcas2p41;
        Tue,  4 Aug 2020 02:43:23 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BLJw91nh4zMqYkk; Tue,  4 Aug
        2020 02:43:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.B3.19322.94BC82F5; Tue,  4 Aug 2020 11:43:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200804024320epcas2p1340f90f12a938fd459d0ff695723befe~n8HolDU2Y0232102321epcas2p1c;
        Tue,  4 Aug 2020 02:43:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200804024320epsmtrp269d541f3c42a5aaae44f3879299a249b~n8Hokcpq_1325213252epsmtrp2Z;
        Tue,  4 Aug 2020 02:43:20 +0000 (GMT)
X-AuditID: b6c32a45-d2296a8000004b7a-67-5f28cb49bd4a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.28.08303.84BC82F5; Tue,  4 Aug 2020 11:43:20 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200804024320epsmtip1545a534f872b1e80e2427e6ec3d2ca2d~n8HoXkX340266102661epsmtip1N;
        Tue,  4 Aug 2020 02:43:20 +0000 (GMT)
Date:   Tue, 4 Aug 2020 11:35:48 +0900
From:   Cho KyongHo <pullip.cho@samsung.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, janghyuck.kim@samsung.com
Subject: Re: [PATCH] mm: sort freelist by rank number
Message-ID: <20200804023548.GA186735@KEI>
MIME-Version: 1.0
In-Reply-To: <ebea485c-7cce-3a4a-2ac4-7a608efe2844@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmma7naY14g6fHOC3mrF/DZvF1/S9m
        i7+dF1gtNs8ptri8aw6bxb01/1ktZjf2MTqwe2z6NInd48SM3ywe7/ddZfPo27KK0ePMgiPs
        Hp83yQWwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQs0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMmYf3Qta8E90Yqjnb+YGxjvCXYxcnJICJhIrD9/mrmLkYtDSGAHo8SkjTsYIZxP
        jBLt1+6xQTifGSXOT/7ODNMyccV9qJZdjBJz9nZBOQ8ZJQ79+wdWxSKgIvHiSBsTiM0moCWx
        eu5xRhBbBCj+aMNRVpAGZoHVjBLfN10GaxAWMJU43NnJAmLzCmhK9Ez5wAxhC0qcnPkEKM7B
        wSlgLfFhYT2IKQo059XBepAxEgJ/2SXeL38BdZ2LRNOdvYwQtrDEq+Nb2CFsKYnP7/ayQTRM
        Z5R4N/8QG0RiM6PEt93Q0DCWmPWsHayZWSBDYv33FrC9EgLKEkdusUCE+SQ6Dv9lhwjzSnS0
        CUF0qkjsnHqNBWZV394bULaHRPuTbnZI+PxnlHi6bB3TBEb5WUg+m4VkG4StI7Fg9ye2WUAr
        mAWkJZb/44AwNSXW79JfwMi6ilEstaA4Nz212KjAEDm2NzGC06mW6w7GyW8/6B1iZOJgPMQo
        wcGsJML78bN6vBBvSmJlVWpRfnxRaU5q8SFGU2A8TWSWEk3OByb0vJJ4Q1MjMzMDS1MLUzMj
        CyVx3lzFC3FCAumJJanZqakFqUUwfUwcnFINTN0bBLi23cuzuvRPz8Tx7YLnp49/iBTJ+rSt
        6umKTo5XTySjnj3f4hO788u5hV17vUX2LzfO3XZSoHjL2aPvfjjYzjXe3vp/7ZW2PtZFTCf/
        Kugff9qSun7t2mkTsjZVp+TkHAzdVeObXyLvViCwZodFo1vvtarXa/TveXeHXfv/9++ZrVw7
        nQ23pCx3s7JwqZDs6J55wj+a8fGyWfmlk/cer5j7VVmbMTjTbWaUcGPpofMZswNO13NKulzZ
        41nL88r6WHey4ikLj5cXnD9Fzw0M3p669kHsJXbRZabWf/j1FC+80TW+GOhv9i0nr7P3zCYF
        /18pnhpbBEI+ZzNeaUif5HX50qf7DhZ8oXvFTyuxFGckGmoxFxUnAgCXKHFqMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK7HaY14gwXXuS3mrF/DZvF1/S9m
        i7+dF1gtNs8ptri8aw6bxb01/1ktZjf2MTqwe2z6NInd48SM3ywe7/ddZfPo27KK0ePMgiPs
        Hp83yQWwRXHZpKTmZJalFunbJXBlbP13hKlgnnDFryPLmRoYt/N3MXJySAiYSExccZ8ZxBYS
        2MEoceZwOURcSmJe91omCFtY4n7LEdYuRi6gmvuMEl9vfQdLsAioSLw40gZmswloSayee5wR
        xBYBij/acBSsgVlgNaPEuh0v2EESwgKmEoc7O1lAbF4BTYmeKR+YIab+Z5RY8r2DDSIhKHFy
        5hOwImagqTf+vQTawAFkS0ss/8cBYnIKWEt8WFgPYooC7Xp1sH4Co+AsJL2zkPTOQuhdwMi8
        ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOBK0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe
        j5/V44V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgmy8TBKdXAtOTG
        D61T8ssXPs1dqTHZQNItce9bnjyVuXsCHL56c9j9K43syFU4cK9Yc1bGd0X+xunT6rJ6md/Z
        v9QUzI918zSK1p2XLWHMaOAYJOcVcMLteUnvJd5W7XXsBTW/WCpyMj679d+P2HkynSOniLHn
        4FQv0UnrT71y/2N3605WymPXxMSemb8/VE3m/PAnQ+OD/XH3ay6vLvitXnTyQr/K8r9z70z3
        cPbrOWkb4/lu+12ewO9+5bdSVygJJJ3374992hyU+9fe5egZ3Vseu98mLnzX+L0nOvas5iRX
        9fnp5RyP/BZMmbRG8t/+VzH7zqaduiUWveDiIZO7LdV5j5926SaZZW5X87qVsqRlhmimEktx
        RqKhFnNRcSIAf8p65/MCAAA=
X-CMS-MailID: 20200804024320epcas2p1340f90f12a938fd459d0ff695723befe
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----WRrpVrAvuAaPq4m-B-8XpfgGTgMokB6fpxFiZcPqPZec0A9D=_73fc3_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
        <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
        <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
        <ebea485c-7cce-3a4a-2ac4-7a608efe2844@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------WRrpVrAvuAaPq4m-B-8XpfgGTgMokB6fpxFiZcPqPZec0A9D=_73fc3_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Aug 03, 2020 at 05:45:55PM +0200, Vlastimil Babka wrote:
> On 8/3/20 9:57 AM, David Hildenbrand wrote:
> > On 03.08.20 08:10, pullip.cho@samsung.com wrote:
> >> From: Cho KyongHo <pullip.cho@samsung.com>
> >> 
> >> LPDDR5 introduces rank switch delay. If three successive DRAM accesses
> >> happens and the first and the second ones access one rank and the last
> >> access happens on the other rank, the latency of the last access will
> >> be longer than the second one.
> >> To address this panelty, we can sort the freelist so that a specific
> >> rank is allocated prior to another rank. We expect the page allocator
> >> can allocate the pages from the same rank successively with this
> >> change. It will hopefully improves the proportion of the consecutive
> >> memory accesses to the same rank.
> > 
> > This certainly needs performance numbers to justify ... and I am sorry,
> > "hopefully improves" is not a valid justification :)
> > 
> > I can imagine that this works well initially, when there hasn't been a
> > lot of memory fragmentation going on. But quickly after your system is
> > under stress, I doubt this will be very useful. Proof me wrong. ;)
> 
> Agreed. The implementation of __preferred_rank() seems to be very simple and
> optimistic.

DRAM rank is selected by CS bits from DRAM controllers. In the most systems
CS bits are alloated to specific bit fields in BUS address. For example,
If CS bit is allocated to bit[16] in bus (physical) address in two rank
system, all 16KiB with bit[16] = 1 are in the rank 1 and the others are
in the rank 0.
This patch is not beneficial to other system than the mobile devices
with LPDDR5. That is why the default behavior of this patch is noop.

> I think these systems could perhaps better behave as NUMA with (interleaved)
> nodes for each rank, then you immediately have all the mempolicies support etc
> to achieve what you need? Of course there's some cost as well, but not the costs
> of adding hacks to page allocator core?

Thank you for the proposal. NUMA will be helpful to allocate pages from
a specific rank programmatically. I should consider NUMA if rank
affinity should be also required.
However, page allocation overhead by this policy (page migration and
reclamation ect.) will give the users worse responsiveness. The intend
of this patch is to reduce rank switch delay optimistically without
hurting page allocation speed.

------WRrpVrAvuAaPq4m-B-8XpfgGTgMokB6fpxFiZcPqPZec0A9D=_73fc3_
Content-Type: text/plain; charset="utf-8"


------WRrpVrAvuAaPq4m-B-8XpfgGTgMokB6fpxFiZcPqPZec0A9D=_73fc3_--
