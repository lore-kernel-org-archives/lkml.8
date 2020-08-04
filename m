Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D260722C9F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BftS9Ibr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHDK2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:28:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27321 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHDK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:28:33 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200804102828epoutp012a349c2c8fcd9e78166233663bcbc7d9~oCdwZmZ-y1205712057epoutp01J
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 10:28:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200804102828epoutp012a349c2c8fcd9e78166233663bcbc7d9~oCdwZmZ-y1205712057epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596536908;
        bh=yEjfWIpgQWCQOveI+hrDVf+t5T+VUeqL6+lnJtCLd9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BftS9IbrC9KToD8nPKKps2wOmbaaAe0ey2kyedjSMvp7qcfqm+ZtjeugxgpK9hcVt
         viYsS0X9WZqeknyEGmYxOCldZye9/OduNLQiDt2MDNmo1O+Hrq7ma4rJwJu+g97+LK
         wd4OLrw2z5HCaY5tfi4HZequE7MQGGbI+eEvsu1Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200804102828epcas2p3cebe2fa63a68cffaf3daba0c24bb64b2~oCdwJ1xSO3041530415epcas2p3Q;
        Tue,  4 Aug 2020 10:28:28 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BLWDp3tKlzMqYkg; Tue,  4 Aug
        2020 10:28:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.55.19322.948392F5; Tue,  4 Aug 2020 19:28:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200804102824epcas2p41b70fcd3d02d70bc878997c4f6d08ac0~oCdsqcCce2819128191epcas2p4r;
        Tue,  4 Aug 2020 10:28:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200804102824epsmtrp299417e9ccaa05b7215f6d7d78c274069~oCdspwBDb3009130091epsmtrp2R;
        Tue,  4 Aug 2020 10:28:24 +0000 (GMT)
X-AuditID: b6c32a45-797ff70000004b7a-31-5f29384993f5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.3B.08382.848392F5; Tue,  4 Aug 2020 19:28:24 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200804102824epsmtip2255bb06f76e70354540375bce8853065~oCdsg63es3065630656epsmtip2N;
        Tue,  4 Aug 2020 10:28:24 +0000 (GMT)
Date:   Tue, 4 Aug 2020 19:20:53 +0900
From:   Cho KyongHo <pullip.cho@samsung.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, janghyuck.kim@samsung.com
Subject: Re: [PATCH] mm: sort freelist by rank number
Message-ID: <20200804102044.GA4655@KEI>
MIME-Version: 1.0
In-Reply-To: <947a09ba-968b-4c4d-68bb-d13de9c885a1@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmqa6nhWa8wauZQhZz1q9hs/i6/hez
        xd/OC6wWm+cUW1zeNYfN4t6a/6wWsxv7GB3YPTZ9msTucWLGbxaP9/uusnn0bVnF6HFmwRF2
        j8+b5ALYonJsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn5haX5qXrJefnWhka
        GBiZAlUm5GTM336evWCyfMX7DbcYGxibJLsYOTkkBEwkLjUuZe9i5OIQEtjBKPF29i1mCOcT
        o8TENQ+hnG+MEtMmtDLDtKzv2QOV2MsoMaO1Bcp5yChx/Mp0RpAqFgEVifWHW5lAbDYBLYnV
        c4+DxUWA4o82HGUFaWAWWM0o8X3TZbCxwgKmEoc7O1lAbF4BdYlva+8zQtiCEidnPgGLcwpY
        S3xs6AEaysEhCjTo1cF6kDkSAq0cEtcfvWaBOM9F4uLKi+wQtrDEq+NboGwpic/v9rJBNExn
        lHg3/xAbRGIzo8S33YIQtrHErGftYIuZBTIkHs85wgiyTEJAWeLILRaIMJ9Ex+G/7BBhXomO
        NiGIThWJnVOvscCs6tt7A8r2kGh/0g0N4HNMEsenHmCfwCg/C8lrs5Bsg7B1JBbs/sQ2C2gF
        s4C0xPJ/HBCmpsT6XfoLGFlXMYqlFhTnpqcWGxUYIkf3JkZwQtVy3cE4+e0HvUOMTByMhxgl
        OJiVRHg/flaPF+JNSaysSi3Kjy8qzUktPsRoCoyoicxSosn5wJSeVxJvaGpkZmZgaWphamZk
        oSTOm6t4IU5IID2xJDU7NbUgtQimj4mDU6qBKfmtvmbS70/brJO//FhZu7JQL0QsVSZihmri
        svuLEs+cq2AyXNi4wUqwIqbqVXr2gheZNf3qSenTpjcmLWJIYDcoOyc0z03CQKm/4EyAMZO/
        7NUf/ySWx4TY/JXIjzDsKe85mrj2R0tC4nn9BYFLr6/fYLY75YDWnv5W46/5kxjST26RWuzr
        +98hVsyu/Zi/fc2dDmbBGdMTudWF7f9Z/ssJODI5XOtdzvXnjM43DPLnhVjoLHZib3XY5XVj
        9QKR7T1nk++c1EtWndD9gG2t1nljv8UTo7+alc2/9WxWrbuZUWieY3v0hVWn0/XFFWZ77Zda
        tbBg3f0ZV2e+l6rxS1ES7Z+4LXO3d93H4holluKMREMt5qLiRADHNwvbMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvK6HhWa8wYSTuhZz1q9hs/i6/hez
        xd/OC6wWm+cUW1zeNYfN4t6a/6wWsxv7GB3YPTZ9msTucWLGbxaP9/uusnn0bVnF6HFmwRF2
        j8+b5ALYorhsUlJzMstSi/TtErgyDh38xVZwWaZi4q7NrA2Mt8W6GDk5JARMJNb37GHuYuTi
        EBLYzSgx63gTG0RCSmJe91omCFtY4n7LEVYQW0jgPqPEg2cpIDaLgIrE+sOtYDVsAloSq+ce
        ZwSxRYDijzYcZQUZyiywmlFi3Y4X7CAJYQFTicOdnSwgNq+AusS3tfcZIYZeYJJ4uqEOIi4o
        cXLmE7AaZqChN/69BFrAAWRLSyz/xwES5hSwlvjY0AMWFgXa9epg/QRGwVlImmchaZ6F0LyA
        kXkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwJGhp7mDcvuqD3iFGJg7GQ4wSHMxK
        IrwfP6vHC/GmJFZWpRblxxeV5qQWH2KU5mBREue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cA0
        TZDpnfk27n2/zm8IXSX6+L9dnPqcY3PM7f/ekmDc+Xn63lNt+cZrf1y9sbTzUI+Gw+7qzSu/
        TDE8XsJgGHjR4tHKdUaXnLcpLQreOf34OZf7/x+zTd+hvz1kTYty4fmXC7VUDuk7P+oPnpE9
        S+7iGxeRNXfOiVuV9zTp/XimOP/Eoewf99s4XkZHRX9/LcktohFazVX/7sHcnVrxRvkqz27/
        TxKKc5jA8XW2Z3mR+s/rtaf+5+XF3Zp2ZF3z44dC+ZMrUk7E/WCfdW7KgyXX+7QEJqZu/fvL
        PZv1j+uf7UVar74apqscO7lr+asHMqwsczdNnfCZVdzY5EWASZN6f+gtq64luXVRSyU/bWG0
        faTEUpyRaKjFXFScCACLgo4x8wIAAA==
X-CMS-MailID: 20200804102824epcas2p41b70fcd3d02d70bc878997c4f6d08ac0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----WPg.tCICMYbzZ7ve.jqv9RPBMPMK9aB2ZS3srN1dKdMJkgZl=_65316_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
        <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
        <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
        <ebea485c-7cce-3a4a-2ac4-7a608efe2844@suse.cz> <20200804023548.GA186735@KEI>
        <947a09ba-968b-4c4d-68bb-d13de9c885a1@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------WPg.tCICMYbzZ7ve.jqv9RPBMPMK9aB2ZS3srN1dKdMJkgZl=_65316_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Aug 04, 2020 at 11:12:55AM +0200, Vlastimil Babka wrote:
> On 8/4/20 4:35 AM, Cho KyongHo wrote:
> > On Mon, Aug 03, 2020 at 05:45:55PM +0200, Vlastimil Babka wrote:
> >> On 8/3/20 9:57 AM, David Hildenbrand wrote:
> >> > On 03.08.20 08:10, pullip.cho@samsung.com wrote:
> >> >> From: Cho KyongHo <pullip.cho@samsung.com>
> >> >> 
> >> >> LPDDR5 introduces rank switch delay. If three successive DRAM accesses
> >> >> happens and the first and the second ones access one rank and the last
> >> >> access happens on the other rank, the latency of the last access will
> >> >> be longer than the second one.
> >> >> To address this panelty, we can sort the freelist so that a specific
> >> >> rank is allocated prior to another rank. We expect the page allocator
> >> >> can allocate the pages from the same rank successively with this
> >> >> change. It will hopefully improves the proportion of the consecutive
> >> >> memory accesses to the same rank.
> >> > 
> >> > This certainly needs performance numbers to justify ... and I am sorry,
> >> > "hopefully improves" is not a valid justification :)
> >> > 
> >> > I can imagine that this works well initially, when there hasn't been a
> >> > lot of memory fragmentation going on. But quickly after your system is
> >> > under stress, I doubt this will be very useful. Proof me wrong. ;)
> >> 
> >> Agreed. The implementation of __preferred_rank() seems to be very simple and
> >> optimistic.
> > 
> > DRAM rank is selected by CS bits from DRAM controllers. In the most systems
> > CS bits are alloated to specific bit fields in BUS address. For example,
> > If CS bit is allocated to bit[16] in bus (physical) address in two rank
> > system, all 16KiB with bit[16] = 1 are in the rank 1 and the others are
> > in the rank 0.
> > This patch is not beneficial to other system than the mobile devices
> > with LPDDR5. That is why the default behavior of this patch is noop.
> 
> Hmm, the patch requires at least pageblock_nr_pages, which is 2MB on x86 (dunno
> about ARM), so 16KiB would be way too small. What are the actual granularities then?

16KiB is just an example. pageblock_nr_pages is 4Mb on both ARM and
ARM64. __perferred_rank() works if rank granule >= 4MB.

> >> I think these systems could perhaps better behave as NUMA with (interleaved)
> >> nodes for each rank, then you immediately have all the mempolicies support etc
> >> to achieve what you need? Of course there's some cost as well, but not the costs
> >> of adding hacks to page allocator core?
> > 
> > Thank you for the proposal. NUMA will be helpful to allocate pages from
> > a specific rank programmatically. I should consider NUMA if rank
> > affinity should be also required.
> > However, page allocation overhead by this policy (page migration and
> > reclamation ect.) will give the users worse responsiveness. The intend
> > of this patch is to reduce rank switch delay optimistically without
> > hurting page allocation speed.
> 
> The problem is, without some control of page migration and reclaim, the simple
> preference approach will not work after some uptime, as David suggested. It will
> just mean that the preferred rank will be allocated first, then the
> non-preferred rank (Linux will fill all unused memory with page cache if
> possible), then reclaim will free memory from both ranks without any special
> care, and new allocations will thus come from both ranks.
> 
In fact, I did't considered about NUMA in that way. I now need to check
NUMA if it gives us the same result with this patch.

Thank you again for your comments about NUMA :)
NUMA

------WPg.tCICMYbzZ7ve.jqv9RPBMPMK9aB2ZS3srN1dKdMJkgZl=_65316_
Content-Type: text/plain; charset="utf-8"


------WPg.tCICMYbzZ7ve.jqv9RPBMPMK9aB2ZS3srN1dKdMJkgZl=_65316_--
