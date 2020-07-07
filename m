Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29055C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08604206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E+bxNd6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGGPDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:03:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60417 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgGGPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:03:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200707150333euoutp01b9302d7d5e5b37bb1489e22cc5d667e5~fgJ8Mw1-F2912829128euoutp01h
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 15:03:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200707150333euoutp01b9302d7d5e5b37bb1489e22cc5d667e5~fgJ8Mw1-F2912829128euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594134213;
        bh=hk/DfneiVCf5C/kH9g4BprrBZAhJ2KT4gY96kZGu7gU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E+bxNd6QpVP4ExzT0wPyHDNhKQjGZNfkx30ts8FsfWySlhXjczgfImM4ledr0qwOo
         0ARn6IYHdEAb2qqhbG+g+tt6C9wwGxrtcTmLMtvi62K7s89+CTrOp9bs1eyc1KdS1M
         N6/YvduMcxg0nZ3rRgr5qvBf41Tj+tSq7AG5UgTk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200707150333eucas1p2016c62f474b51099a4b3a76d4a9ea068~fgJ70hWK11670216702eucas1p27;
        Tue,  7 Jul 2020 15:03:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 97.06.06318.5CE840F5; Tue,  7
        Jul 2020 16:03:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200707150333eucas1p2de2f3b86b1c10435e92e6f549832f77b~fgJ7i7kcd1667716677eucas1p25;
        Tue,  7 Jul 2020 15:03:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200707150333eusmtrp200ed6e52ae7721ac5fa68c14a1196432~fgJ7iMCfG1418414184eusmtrp2N;
        Tue,  7 Jul 2020 15:03:32 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-87-5f048ec5fe9c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.69.06314.4CE840F5; Tue,  7
        Jul 2020 16:03:32 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200707150331eusmtip20f37390f9a1deb175f1afd49ef1f61ac~fgJ6Q_f3X0693806938eusmtip2d;
        Tue,  7 Jul 2020 15:03:31 +0000 (GMT)
Subject: Re: [PATCH v7 01/36] drm: prime: add common helper to check
 scatterlist contiguity
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <0c120714-a31f-f966-5077-673d4fdf1203@samsung.com>
Date:   Tue, 7 Jul 2020 17:03:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b74fc6a2-31d1-3e2b-db84-954e41949ed9@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djP87pH+1jiDTbc5bfoPXeSyWLjjPWs
        Fle+vmezWLn6KJPFgv3WFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHwwxNWiy1vJrI6cHusmbeG
        0WP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fm09UenzfJBXBFcdmkpOZk
        lqUW6dslcGXcXNTFWnCLuWLBz6csDYxNzF2MnBwSAiYS2269YQOxhQRWMErM/ZkPYX9hlHg4
        xbKLkQvI/swo8XX2JSaYhucfLrBDJJYzSqzesoodouM9o0T3f3UQW1ggVuL4g02MIDabgKbE
        3803wTaICGxhlGie6gbSzAwy9fybLawgCV4BO4k5x2awgNgsAioSx2fdBGsWFYiTWP9yOxNE
        jaDEyZlPwGo4Bewllk/4CLaYWUBeYvvbOcwQtrhE05eVrCALJAS+skvcf/yNHeJsF4kNa35D
        2cISr45vgbJlJP7vnA/1Wr3E/RUtzBDNHYwSWzfshAaStcSdc7+AXuAA2qApsX6XPkTYUeLi
        obOsIGEJAT6JG28FIW7gk5i0bTozRJhXoqNNCKJaUeL+2a1QA8Ulll74yjaBUWkWks9mIflm
        FpJvZiHsXcDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwqZ3+d/zrDsZ9f5IOMQpw
        MCrx8GYkssQLsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKX
        sUIC6YklqdmpqQWpRTBZJg5OqQZGUZ4Dtyt/z3vHOHHLQiPNn5KT+06t3rzvxZfr3lqsUVtM
        bjoyerL135CdXq55+muugfmBMIfni4xCQu3nLGZY/uNd9JzNC15nK7oc9/2htzWhlkXycVTv
        h37LnfzFoqkToz//EA+18S+eO79ugd2N1zlHdc2qv16xkleVDEyuf+/a0PIyLI1LiaU4I9FQ
        i7moOBEA7nVru2YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xe7pH+ljiDQ49MrfoPXeSyWLjjPWs
        Fle+vmezWLn6KJPFgv3WFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHwwxNWiy1vJrI6cHusmbeG
        0WP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fm09UenzfJBXBF6dkU5ZeW
        pCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXcXNTFWnCLuWLB
        z6csDYxNzF2MnBwSAiYSzz9cYO9i5OIQEljKKPF9Ri8rREJcYvf8t1BFwhJ/rnWxQRS9ZZS4
        +nc1G0hCWCBW4viDTYwgNpuApsTfzTfBikQEtjBKPFtxmBHEYRb4zCjxaX0X2CghgV+MEssn
        F4DYvAJ2EnOOzWABsVkEVCSOz7oJNklUIE5i+Zb57BA1ghInZz4Bq+EUsJdYPuEjWJxZwExi
        3uaHzBC2vMT2t3OgbHGJpi8rWScwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhb
        XJqXrpecn7uJERjN24793LyD8dLG4EOMAhyMSjy8GYks8UKsiWXFlbmHGCU4mJVEeJ3Ono4T
        4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgoskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQ
        nliSmp2aWpBaBNPHxMEp1cBYX2F66aQss8aK15JZ14/uuLnk0Kw1ak0Fn7TuVzT9tlt0QdXj
        Xn4vh9L2VPZrU2tiRU/ef7a/9peE4gnH7CntUfu8ysU4/p1eqeZrUqomxTlNd3Lx7jlz8s8c
        ynLa/1brxQTt/p6NPiV6u7/sP72Pt5fdaUqxxg3TldcUZ+psb9Srq4p/ff20EktxRqKhFnNR
        cSIAnJC+n/wCAAA=
X-CMS-MailID: 20200707150333eucas1p2de2f3b86b1c10435e92e6f549832f77b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103653eucas1p2542a7f42db61b22a43919666368dbbfa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103653eucas1p2542a7f42db61b22a43919666368dbbfa
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103653eucas1p2542a7f42db61b22a43919666368dbbfa@eucas1p2.samsung.com>
        <20200619103636.11974-2-m.szyprowski@samsung.com>
        <b74fc6a2-31d1-3e2b-db84-954e41949ed9@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.07.2020 16:30, Andrzej Hajda wrote:
> On 19.06.2020 12:36, Marek Szyprowski wrote:
>> It is a common operation done by DRM drivers to check the contiguity
>> of the DMA-mapped buffer described by a scatterlist in the
>> sg_table object. Let's add a common helper for this operation.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---

Just fixing my signature :)

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards
Andrzej

