Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2569C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB90206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="se9/USjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgHRJCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:02:31 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:29422 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:02:27 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200818090222epoutp014bdae101aff61f7f72d17b7fd610323a~sUUkdQ-jh1928219282epoutp01U
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:02:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200818090222epoutp014bdae101aff61f7f72d17b7fd610323a~sUUkdQ-jh1928219282epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597741342;
        bh=WlouaiWxgrlvlKKOk9bP5btBhyi4Q6VHCR6S/oVE4PI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=se9/USjF0J4FuB85QjbIml2ulE2AvO52N03OPxuzm8wxAkGi533StWRBel9tvCLho
         H9/RM3LCtttAmTEY7DsSJiijlLJUGFS7nBnJRHFTrJr1BwW56xzQQUDhfswXQjlqDo
         OTYerXphJIvJZwWw1Ti6dTL/GyOvkdijRrnb5nus=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200818090221epcas2p1a6b3de3597197c5ca7545b7741c161ac~sUUj1heLi2594925949epcas2p1i;
        Tue, 18 Aug 2020 09:02:21 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.187]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BW4fz3VGmzMqYkb; Tue, 18 Aug
        2020 09:02:19 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.85.27013.B199B3F5; Tue, 18 Aug 2020 18:02:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200818090217epcas2p293323defec7446342f8f99091dcfe7ad~sUUfwq9_s0952609526epcas2p2e;
        Tue, 18 Aug 2020 09:02:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200818090217epsmtrp2a98e7799a065a251f18a4ef7d556e27c~sUUfv-Ts_0637006370epsmtrp2Z;
        Tue, 18 Aug 2020 09:02:17 +0000 (GMT)
X-AuditID: b6c32a48-d1fff70000006985-bb-5f3b991bfbe2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.46.08382.9199B3F5; Tue, 18 Aug 2020 18:02:17 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200818090217epsmtip1ac66adf41b470f43bd73318759dc1008~sUUfjix8O2454224542epsmtip1Q;
        Tue, 18 Aug 2020 09:02:17 +0000 (GMT)
Date:   Tue, 18 Aug 2020 17:54:44 +0900
From:   Cho KyongHo <pullip.cho@samsung.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pekka Enberg <penberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, hyesoo.yu@samsung.com,
        janghyuck.kim@samsung.com
Subject: Re: [PATCH] mm: sort freelist by rank number
Message-ID: <20200818085444.GA72202@KEI>
MIME-Version: 1.0
In-Reply-To: <c0e87116-2633-c408-455b-c00c86607491@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmqa70TOt4g8vnOSzmrF/DZvF1/S9m
        i7+dF1gtNs8ptri8aw6bxb01/1ktVszZweLA7rFz1l12j02fJrF7nJjxm8Xj/b6rbB59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCwQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISejZ/cFtoJHihVHH31ibGA8Lt3FyMEhIWAi8f1dQBcjF4eQwA5GiSO7elghnE+M
        Eq+aTrB3MXICOd8YJfp7I0FskIbPX05BFe1llNjc/54ZwnnIKDGhdx8rSBWLgKrEw57pzCA2
        m4CWxOq5xxlBbBEBDYlNbRvAGpgFrjNKLD/TCtYgLGAqcbizkwXE5gUqujxhCTuELShxcuYT
        sDingJ3E4r/H2EDuFhVQkXh1sB5kjoRAI4fE3TlvmCHOc5HYPXcFI4QtLPHq+BZ2CFtK4vO7
        vWwQDdMZJd7NP8QGkdjMKPFttyCEbSwx61k7WDOzQIbE3EXrWCCBpCxx5BYLRJhPouPwX3aI
        MK9ER5sQRKeKxM6p11hgVvXtvQFle0i0P+lmhwTQSSaJ7zfeME1glJ+F5LVZSLZB2DoSC3Z/
        YpsFtIJZQFpi+T8OCFNTYv0u/QWMrKsYxVILinPTU4uNCkyQI3sTIziZannsYJz99oPeIUYm
        DsZDjBIczEoivEknzOOFeFMSK6tSi/Lji0pzUosPMZoCI2ois5Rocj4wneeVxBuaGpmZGVia
        WpiaGVkoifO+s7oQJySQnliSmp2aWpBaBNPHxMEp1cA00XbajXeS7IWbp/5q1l/M5W7pOLeK
        /TcT+8GTm/uWRfItk9nS8LPINXoPp8DuT9bv7iaW7ZvjPznugVdPiL/nzoDSuV7zPS4uLlNe
        UP5mr/MsfoMJjuI8SxrST72Xm1WQe8GQI/CB9ztnoW/yM+UKz6ecvhh2++WBp5EcipLPfJcH
        3LDKueHKaOd7qDPLp1j1sSf77LyIadaXN9ywXXnJUcvA6e6qBsVC6Svbd0/+wdesyLurbcWk
        f7MlX+vaCctzS6xvfPXugtKL9NCV5bPmbOTd/Xtv4Ll3PR2LxcKNtqV/9J3t43WgVlxS/ZoB
        Y+BSpTaF0za9LXXPLpXaHz36THbjv4dJPTz7f27O7a9RYinOSDTUYi4qTgQAiJkWNC8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnK7kTOt4gzXNbBZz1q9hs/i6/hez
        xd/OC6wWm+cUW1zeNYfN4t6a/6wWK+bsYHFg99g56y67x6ZPk9g9Tsz4zeLxft9VNo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKeNl9mq1gkXzFjabl7A2MCyS7GDk5JARMJD5/OcXaxcjF
        ISSwm1FiVuskNoiElMS87rVMELawxP2WI1BF9xkl9k/cyQySYBFQlXjYMx3MZhPQklg99zgj
        iC0ioCGxqW0DM0gDs8BNRokLDY/ApgoLmEoc7uxkAbF5gYouT1jCDmILCZxkkpj6JQ8iLihx
        cuYTsBpmoKE3/r0EuoIDyJaWWP6PAyTMKWAnsfjvMTaQsKiAisSrg/UTGAVnIWmehaR5FkLz
        AkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwbGgpbmDcfuqD3qHGJk4GA8xSnAw
        K4nwJp0wjxfiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6NwYZyQQHpiSWp2ampBahFMlomDU6qB
        6eKLiw2W9zUL2FO+dzSvvLqHTdFWdCXL4qcxeRdPZvDZMf2tTnq/bU7S/jXNDkvzs/JW3rJU
        v1cc0ssQemJ5V5Ol3/416zKndBr22x2unPPmRfGHZTP2cr6xVrhxXeV/W0nWiSeXfFXUA006
        sub7/rRyqXuifuJ7ucH0EPmDc82URZbUvFW8wKjvpdAc9iP9U0jkwUfb7uZo2vVZGO59cm/7
        YiPGRv2ulRMercrj9q92ET9m53C6yThJkv30IR/dYFc/hurZbC1LahV7/FecMMsPfMbxd6rK
        mdp9GQ+kUvSXbLJR7f+9epe2D1fAh16Wp91VC2MMTio+sv0Wsttt5Z66vUpJ7zf/FK/5NkVO
        iaU4I9FQi7moOBEAOQ5Ra/QCAAA=
X-CMS-MailID: 20200818090217epcas2p293323defec7446342f8f99091dcfe7ad
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_297f1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
        <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
        <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
        <CAOJsxLHTL__N3KE_HUhQrVR=rkri80=kU1e64-6nBgMKHZRi4g@mail.gmail.com>
        <c0e87116-2633-c408-455b-c00c86607491@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_297f1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Aug 10, 2020 at 09:32:18AM +0200, David Hildenbrand wrote:
> On 07.08.20 09:08, Pekka Enberg wrote:
> > Hi Cho and David,
> > 
> > On Mon, Aug 3, 2020 at 10:57 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 03.08.20 08:10, pullip.cho@samsung.com wrote:
> >>> From: Cho KyongHo <pullip.cho@samsung.com>
> >>>
> >>> LPDDR5 introduces rank switch delay. If three successive DRAM accesses
> >>> happens and the first and the second ones access one rank and the last
> >>> access happens on the other rank, the latency of the last access will
> >>> be longer than the second one.
> >>> To address this panelty, we can sort the freelist so that a specific
> >>> rank is allocated prior to another rank. We expect the page allocator
> >>> can allocate the pages from the same rank successively with this
> >>> change. It will hopefully improves the proportion of the consecutive
> >>> memory accesses to the same rank.
> >>
> >> This certainly needs performance numbers to justify ... and I am sorry,
> >> "hopefully improves" is not a valid justification :)
> >>
> >> I can imagine that this works well initially, when there hasn't been a
> >> lot of memory fragmentation going on. But quickly after your system is
> >> under stress, I doubt this will be very useful. Proof me wrong. ;)
> >>
> >> ... I dislike this manual setting of "dram_rank_granule". Yet another mm
> >> feature that can only be enabled by a magic command line parameter where
> >> users have to guess the right values.
> >>
> >> (side note, there have been similar research approaches to improve
> >> energy consumption by switching off ranks when not needed).
> > 
> > I was thinking of the exact same thing. PALLOC [1] comes to mind, but
> > perhaps there are more recent ones?
> 
> A more recent one is "Footprint-Based DIMM Hotplug"
> (https://protect2.fireeye.com/v1/url?k=adc28c8b-f0128447-adc307c4-000babff3793-131bb23ec7a60bc9&q=1&e=4c1c9d3c-07c1-4d9a-bb4a-510a0304194a&u=https%3A%2F%2Fdl.acm.org%2Fdoi%2Fabs%2F10.1109%2FTC.2019.2945562), which triggers
> memory onlinng/offlining from the kernel to disable banks where possible
> (I don't think the approach is upstream material in that form).
> 
> Also, I stumbled over "Towards Practical Page Placement for a Green
> Memory Manager" (https://ieeexplore.ieee.org/document/7397629),
> proposing an adaptive buddy allocator that tries to keep complete banks
> free in the buddy where possible. That approach sounded quite
> interesting while skimming over the paper.

The researches look like a linux support for partial array self-refresh.
Instead of choosing predefined memory array (bank, rank or segment) it
hot-removes in a channel(DIMM) granule.

Thank you for addressing the research. I need to look into the paper. I
also intersted in that area.

> > 
> > I also dislike the manual knob, but is there a way for the OS to
> > detect this by itself? My (perhaps outdated) understanding was that
> > the DRAM address mapping scheme, for example, is not exposed to the
> > OS.
> 
> I guess one universal approach is by measuring access times ... not what
> we might be looking for :)
> 
> > 
> > I think having more knowledge of DRAM controller details in the OS
> > would be potentially beneficial for better page allocation policy, so
> > maybe try come up with something more generic, even if the fallback to
> > providing this information is a kernel command line option.
> > 

I don't find if there is a way to deliver detailed DRAM information
through ACPI, ATAG or something similar. But I didn't find.
As you mentiond above, if the kernel has knowledge of DRAM controllers,
it would be also beneficial for power management as well as page allocations.
PASR has not come to Linux due to the complexity, for example. If kernel
knows the granule of hot-add/remove for PASR, we can start discussions
how to support PASR in Linux.

Thank you for the opinions.

KyongHo

------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_297f1_
Content-Type: text/plain; charset="utf-8"


------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_297f1_--
