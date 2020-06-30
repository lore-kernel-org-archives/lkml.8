Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8861C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8767E206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FdiPH5w2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgF3He5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:34:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54580 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbgF3He4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:34:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200630073454euoutp02a62f3338248609ff9c524a3bfe9e77e3~dQhNyueii2347723477euoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:34:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200630073454euoutp02a62f3338248609ff9c524a3bfe9e77e3~dQhNyueii2347723477euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593502494;
        bh=7394y84tn/QoCnXkp0aiwIpMkuMm1/4lmpbafY8hc0k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FdiPH5w2ewVvFGU4PHIyjabJhV1K0ZntXcPaK3Z98MAVJPsYv4hSJ3PYh6E57csrp
         C0WcCkBk+hAHEcLrN81qSR3vC5Vu5K/niq5STd+z/MvX77bC0kSe2cvKMPELIPb0OR
         T2SG7q3TZOOH4OZRJBkHzj5PMenyxktl5usv0zR8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200630073454eucas1p1063b6b0c28413eb10e6c51ce3a57a6ab~dQhNZY2n_1986419864eucas1p1x;
        Tue, 30 Jun 2020 07:34:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6F.52.05997.D1BEAFE5; Tue, 30
        Jun 2020 08:34:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200630073453eucas1p2863681e0f4c0e7b6742fe70816d11ef9~dQhNDjgNF1243012430eucas1p2i;
        Tue, 30 Jun 2020 07:34:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200630073453eusmtrp14e76104236e753835f20507c816fcb34~dQhNCyvS70694406944eusmtrp1u;
        Tue, 30 Jun 2020 07:34:53 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-74-5efaeb1d588f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.74.06017.D1BEAFE5; Tue, 30
        Jun 2020 08:34:53 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200630073452eusmtip11343709fff45fab3984d39e2dd80f5f0~dQhMZVy4G2427724277eusmtip1E;
        Tue, 30 Jun 2020 07:34:52 +0000 (GMT)
Subject: Re: [PATCH 3/4] arm64: dts: exynos: Align DMA controller bus node
 name with dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <3c1eb3fe-8eef-1f91-ff4e-3081a871fc80@samsung.com>
Date:   Tue, 30 Jun 2020 09:34:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629204442.17336-3-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7pyr3/FGTzltngwbxubxcYZ61kt
        rn95zmox/8g5Vov+x6+ZLc6f38BusenxNVaLy7vmsFnMOL+PyWLR1i/sFq17j7BbtD99yezA
        47FpVSebx+Yl9R59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CVseHWFraCJraK2bd3MzcwPmfp
        YuTkkBAwkTh54hNzFyMXh5DACkaJZ6susYMkhAS+MEpMXysIYX9mlFh73AWm4VnfSSaIhuWM
        Eg//f2aBcN4zSjQ+esYKUiUsEC/x9PJxVpCECEj35cnXmEESzAJ3GSUmTMoEsdkEDCW63nax
        gdi8AnYSv5/eA7uJRUBVYvL7c4wgtqhArETf0gVQNYISJ2c+AavhFDCVmPx4C9RMeYntb+dA
        2eISt57MBztPQuASu8SpX22sEHe7SPS/mMcEYQtLvDq+hR3ClpE4PbmHBaKhGeifc2vZIZwe
        oLObZjBCVFlL3Dn3C+gMDqAVmhLrd+lDhB0lPk2fyQ4SlhDgk7jxVhDiCD6JSdumM0OEeSU6
        2oQgqtUkZh1fB7f24IVLzBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTi43yUsv1ihNz
        i0vz0vWS83M3MQIT1el/x7/sYNz1J+kQowAHoxIPb8K5n3FCrIllxZW5hxglOJiVRHidzp6O
        E+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoGx+M3O3Yef
        iGeu/nNb+OIeRT7O/wzes7o6NdymLv2WfKztod0GyffqTPvufGi+tmz5wnJmJu1DGg3Ci3M0
        TN8edpBuDbY0zs8yFuvf7lsfqcct31z4x5tru/7hlfOrJPn8Eo0SWE4vsVnQzhviyRea8Oj0
        mYhJNYwyzZo9Ac4L7NtjdA5911ZiKc5INNRiLipOBABMNNzbUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7qyr3/FGUzpU7V4MG8bm8XGGetZ
        La5/ec5qMf/IOVaL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8li0dYv7Bate4+wW7Q/fcns
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7Hh1ha2gia2itm3dzM3MD5n6WLk5JAQMJF41neSqYuRi0NI
        YCmjxKSWFUwQCRmJk9MaWCFsYYk/17rYIIreMkrcedjDDJIQFoiXeHr5OCtIQkTgM6PEs8ZN
        zCAOs8B9RonzbT/ZQaqEBDYzSrxriQex2QQMJbregozi5OAVsJP4/fQe2B0sAqoSk9+fYwSx
        RQViJb7d2wJVIyhxcuYTsBpOAVOJyY+3gG1mFjCTmLf5IZQtL7H97RwoW1zi1pP5TBMYhWYh
        aZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzPbcd+btnB2PUu+BCj
        AAejEg9vwrmfcUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR
        5Hxg6sgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cBYa1fDfzak
        7LfjzLeBvg12WxgTdLff6fSRUTnNZCsjaj85Ma5mW+PBaW2xDLWe1nL3vQ+rz23PLK5M/po7
        RdeB7+zy4wdkN7xtLNPX7exW/bX/Z0944uLlh1/c0urmmfk6TXPB9UPfdKvNeX+/XcP7gPXF
        1JD393a2ep459p+XY4lBwrOo1VJKLMUZiYZazEXFiQCE89+i5QIAAA==
X-CMS-MailID: 20200630073453eucas1p2863681e0f4c0e7b6742fe70816d11ef9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629205541eucas1p16e9c5848ed7ac84ca87c045f3a6f928b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629205541eucas1p16e9c5848ed7ac84ca87c045f3a6f928b
References: <20200629204442.17336-1-krzk@kernel.org>
        <CGME20200629205541eucas1p16e9c5848ed7ac84ca87c045f3a6f928b@eucas1p1.samsung.com>
        <20200629204442.17336-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 29.06.2020 22:44, Krzysztof Kozlowski wrote:
> AMBA is a bus so name the node with DMA controllers just as "bus" to fix
> dtschema warnings like:
>
>      amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Do we really need a separate 'bus' for those DMA controllers?

IMHO they are not different from the hw perspective from the other 
devices available on the SoC. A separate bus is a historical thing, they 
work fine when moved directly under the 'soc' node. The separate bus 
only mimics the way Linux organizes its drivers. This comment affects 
both ARM and ARM64.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

