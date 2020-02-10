Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF11C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC2620733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fHKUzuic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJLkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:40:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33929 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:40:23 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210114021euoutp02bfb5fbd6352065c4e58a934d448e6afd~yB6RU2gpV1931019310euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:40:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210114021euoutp02bfb5fbd6352065c4e58a934d448e6afd~yB6RU2gpV1931019310euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581334821;
        bh=sql+OYh6KxpF7toLwqx0dwiowWTueC4WVmqzlhdVi+U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fHKUzuicfrYZ3RmGAgz3aEmXYocedn+t2ZT6o+kK0LZtWiRU0+3sxUzCxtG6J+BeT
         QO3B/rtXYQUaRXwjtItjrm9OyqRtCt0hXFkg/TJDskzbCILQxppd+Ol6R6bdlTORwr
         jZSO43whwRTIC2b+sNL4Rk692V3W6JoUw2zQliCk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210114021eucas1p283d7a897abd0041294ffabe84c521fd0~yB6Q-rpDb2419424194eucas1p2n;
        Mon, 10 Feb 2020 11:40:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 40.54.60679.521414E5; Mon, 10
        Feb 2020 11:40:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210114020eucas1p1f8b7a4cdcb378afcd4161ed44b715541~yB6Qnq6ZQ1706617066eucas1p1k;
        Mon, 10 Feb 2020 11:40:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210114020eusmtrp23b5906d2d96c5996435db29166e0f442~yB6QnHRZm2615626156eusmtrp2p;
        Mon, 10 Feb 2020 11:40:20 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-87-5e414125f219
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 31.EC.08375.421414E5; Mon, 10
        Feb 2020 11:40:20 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210114020eusmtip135bea80cbf878ae3d586d57069c78bb4~yB6QTQLcu3194131941eusmtip1v;
        Mon, 10 Feb 2020 11:40:20 +0000 (GMT)
Subject: Re: [PATCH] libfdt: place new nodes & properties after the parent's
 ones
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bc380fd8-71bb-897e-f060-b51386dec9be@samsung.com>
Date:   Mon, 10 Feb 2020 12:40:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205054508.GG60221@umbus.fritz.box>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87qqjo5xBg8+c1psnLGe1WLnoVZm
        iw8HtzFZXN41h82BxWPigvdsHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXxcuJh5oJnvBU/
        7sxnbWBs4+5i5OSQEDCReNl1kaWLkYtDSGAFo8SlWX+hnC+MEk0T29ghnM+MEv073zN1MXKA
        tex4LAQRX84o8fzVPFYI5y2jxLKL11hA5goLBEt07p/CCmKLCOhJ3Ju7lhnEZhaolfh6cwI7
        iM0mYCjR9baLDWQor4CdxPlVBSBhFgFViS0LzzKC2KICsRJnjn0HG8MrIChxcuYTsPGcAqYS
        Ha86GSFGyktsfzsHary4xK0n85lA7pEQ6GaXaDq5mw3iTxeJdddfsUPYwhKvjm+BsmUk/u+E
        aWhmlHh4bi07hNPDKHG5aQYjRJW1xJ1zv8AuZRbQlFi/Sx8i7Chx6H07NFT4JG68FYQ4gk9i
        0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTU
        YqO81HK94sTc4tK8dL3k/NxNjMCEcvrf8S87GHf9STrEKMDBqMTD62DvECfEmlhWXJl7iFGC
        g1lJhNdS2jFOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6p
        BsaWey+UNZ/weHi5sLOd2abFUHbux6pqvni2T+xyTP1fZ1c+eln/hmXKZf0j/uuniv47Gl9R
        /4x129yKYqvrWtol4Sc98/4JS+ptbu5Piv4iV2HJuuzbkxP79+W9nTCLfXb/A5Nt54t/cTtr
        zZFodOiwnOrTMuGGmXWFVTVL0CRj+/ScU0u2uCixFGckGmoxFxUnAgDk7PwCJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7oqjo5xBi3XNCw2zljParHzUCuz
        xYeD25gsLu+aw+bA4jFxwXs2j74tqxg9Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4OfEwc8Ez3oofd+azNjC2cXcxcnBICJhI7Hgs
        1MXIxSEksJRR4tCzw8xdjJxAcRmJk9MaWCFsYYk/17rYIIpeM0ps+HEXrEhYIFiic/8UsCIR
        AT2Je3PXgsWZBWolTj3YzgLRsIdR4ujB50wgCTYBQ4mutyCTODh4Bewkzq8qAAmzCKhKbFl4
        lhHEFhWIlTi2vY0dxOYVEJQ4OfMJC4jNKWAq0fGqkxFivpnEvM0PoXbJS2x/OwfKFpe49WQ+
        0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNo27Gfm3cw
        XtoYfIhRgINRiYfXwd4hTog1say4MvcQowQHs5IIr6W0Y5wQb0piZVVqUX58UWlOavEhRlOg
        5yYyS4km5wOjO68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2Me
        i9KVd1MUFL58fKNefXiSwO5EvRN6rcVrF1nXXjydeKdfoM7F8ZGG+6GTykXVIWKfJigltzGX
        a1x7z1qy9pRK4FXfROGK+DtbO5OiudvXHS39wG+QyTjxxMX1fXWdU/dHCFqs/6pzU0PAWl1k
        wXKrXEW3Yw6BNqlXUk+5mU3zixGY9TpqkxJLcUaioRZzUXEiAFIuCZG2AgAA
X-CMS-MailID: 20200210114020eucas1p1f8b7a4cdcb378afcd4161ed44b715541
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
        <20200204125844.19955-1-m.szyprowski@samsung.com>
        <20200205054508.GG60221@umbus.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 05.02.2020 06:45, David Gibson wrote:
> On Tue, Feb 04, 2020 at 01:58:44PM +0100, Marek Szyprowski wrote:
>> While applying dt-overlays using libfdt code, the order of the applied
>> properties and sub-nodes is reversed. This should not be a problem in
>> ideal world (mainline), but this matters for some vendor specific/custom
>> dtb files. This can be easily fixed by the little change to libfdt code:
>> any new properties and sub-nodes should be added after the parent's node
>> properties and subnodes.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> I'm not convinced this is a good idea.
>
> First, anything that relies on the order of properties or subnodes in
> a dtb is deeply, fundamentally broken.  That can't even really be a
> problem with a dtb file itself, only with the code processing it.

I agree about the properties, but generally the order of nodes usually 
implies the order of creation of some devices or objects. This sometimes 
has some side-effects.

For comparison, the other lib used for fdt manipulation (libufdt) 
applies overlays in a such way, that the order of properties and nodes 
is not reversed.

> I'm also concerned this could have a negative performance impact,
> since it has to skip over a bunch of existing things before adding the
> new one.  On the other hand, that may be offset by the fact that it
> will reduce the amount of stuff that needs to be memmove()ed later on.

This code is already slow (especially in the way the uboot's use it for 
'fdt apply' command), but in practice I've didn't observe negative 
impact on the performance of applying large overlays at all.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

