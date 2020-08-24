Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9D4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096092074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tqplxy11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHXLTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:19:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22650 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHXLPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:15:54 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200824111552epoutp04aff855f1cae440b8d3c7bbaf1f92850f~uMA1vOvIF0056000560epoutp04Z
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200824111552epoutp04aff855f1cae440b8d3c7bbaf1f92850f~uMA1vOvIF0056000560epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598267752;
        bh=8W8cNXrqYNIrL1SpnMmJXymJ3jP7SON2RlFo0RKTPCo=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=Tqplxy11VCrkiYy+FyLsThHlg7xfjnfj/97LoqxPBX2vuy/hmaTkX5x5CYN1UoN0J
         XP5bxskWlb0QD9YT0im9II5y5GoWS7iyA+DlpkQRpruuZYP19HQvv2nrQGqh/yjjDr
         sBl9y7nDKIodZKspt8yHzLeDwf30U6VD2zYxPHgk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200824111550epcas1p2902f9df8958938e07886084dbda7fdbd~uMA0dsLBD0328203282epcas1p2m;
        Mon, 24 Aug 2020 11:15:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BZqLD17H9zMqYkW; Mon, 24 Aug
        2020 11:15:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.CA.18978.361A34F5; Mon, 24 Aug 2020 20:15:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200824111547epcas1p3fe21d43cdcc593bab9e9bff288923bc7~uMAxdjQU22287822878epcas1p3b;
        Mon, 24 Aug 2020 11:15:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200824111547epsmtrp2bcf0369d19a17e188b1656e9e692e667~uMAxc2Pxn2446424464epsmtrp2Z;
        Mon, 24 Aug 2020 11:15:47 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-82-5f43a1639525
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.30.08382.361A34F5; Mon, 24 Aug 2020 20:15:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200824111547epsmtip1f265e716eb7484628c13ebd7150c6af7~uMAxOHdC_1651116511epsmtip1P;
        Mon, 24 Aug 2020 11:15:47 +0000 (GMT)
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
To:     vadivel.muruganx.ramuthevar@linux.intel.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b6ec12af-5573-ce86-9f6b-16fcbc36b1a3@samsung.com>
Date:   Mon, 24 Aug 2020 20:28:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvm7KQud4g8ZtjBbzj5xjtTh/fgO7
        xeVdc9gsbjeuYLNo3XuE3WLDsftsFi/3T2d1YPfYOesuu8emVZ1sHvNOBnr0bVnF6PF5k1wA
        a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE
        7IzHc7ayFPxmrXja+IG1gfEQSxcjB4eEgInE83/1XYycHEICOxgldl1W7GLkArI/MUq8WHGG
        CcL5xijx7m0vI0zD0StQ8b2MEn/OrGWBcN4zSlzdfY0dZJSwgKvEsW//wGwRgclMEpPaJUBs
        NgEtif0vbrCB2PwCihJXfzxmBLF5BewkFn54wgxiswioSrw9sI8VxBYVCJM4ua0FqkZQ4uTM
        JywgNqeAs8Tj53+YQGxmAXGJW0/mQ9nyEs1bZzODHCQh0MshMWvOI7BlEgIuEud3T2SGsIUl
        Xh3fwg5hS0l8frcXqqZaYuXJI2wQzR2MElv2X2CFSBhL7F86mQnkfWYBTYn1u/QhwooSO3/P
        ZYRYzCfx7msPKySEeCU62oQgSpQlLj+4ywRhS0osbu9kgyjxkNh3OXoCo+IsJJ/NQvLNLCTf
        zELYu4CRZRWjWGpBcW56arFhgSFyVG9iBCdPLdMdjBPfftA7xMjEwXiIUYKDWUmE9/Ym+3gh
        3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA9M33kl8YamRsbGxhYmhmamhoZK4rwPbynECwmk
        J5akZqemFqQWwfQxcXBKNTCVKfF8X6UR8+34Fdv/i56JfLYtvbXj+GSWrsr1C4PSdr922jrj
        zjymJ0pPiueof2He2z+PafrK1RLKFXd/yzY9vBRrcvd6kIVr4rcm68MnmrZVcIdwbWE5/etd
        g5y1rvycfN5lHsFaW2Jj4oINxWI5bkwyMJNTvXpH7dEkqa26Hx0Kp8uYbT5+IrznuYCs2Q9b
        ZSH5LyLrTl36PHvTyTu7w3jFP2w8/LX3zrpvHpv6dois6HNpXXC4f9+XsN8BhaXHX4svPq54
        VbYy73Zdfnpzz0m5lS9Eb5zps07ffO1SrM7ymB3bb3p3tS8qXMW5td6i797y5Wdrpka3srlF
        Xu9c+1i3vqP7VYfqojUuj2/YKbEUZyQaajEXFScCAA8PVygnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnG7yQud4g939Qhbzj5xjtTh/fgO7
        xeVdc9gsbjeuYLNo3XuE3WLDsftsFi/3T2d1YPfYOesuu8emVZ1sHvNOBnr0bVnF6PF5k1wA
        axSXTUpqTmZZapG+XQJXxuM5W1kKfrNWPG38wNrAeIili5GDQ0LAROLoFaYuRi4OIYHdjBI7
        Lt4FcjiB4pIS0y4eZYaoEZY4fLgYouYto8SXh21gNcICrhLHvv1jB7FFBKYySUx75wZRdIBR
        4vbETkaQBJuAlsT+FzfYQGx+AUWJqz8eg8V5BewkFn54wgxiswioSrw9sI8VxBYVCJPYueQx
        E0SNoMTJmU9YQGxOAWeJx8//gMWZBdQl/sy7xAxhi0vcejIfKi4v0bx1NvMERqFZSNpnIWmZ
        haRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNGS3MH4/ZVH/QOMTJx
        MB5ilOBgVhLhvb3JPl6INyWxsiq1KD++qDQntfgQozQHi5I4743ChXFCAumJJanZqakFqUUw
        WSYOTqkGJsGVJ+vXS5jO2zvn7HqJ/tPsiUG7bTh9LZntDJ7ey/gVaN7rdFT5x0ter3yD+Dc8
        Tm1BqZOtNi8ynHNoRYRVxYr25YtdJI9ahpx5VOBzYHdfxQybCnmOzGfroz80Hpe7t2qWoPbL
        +BdVbp9Xbv12KepCQ2rkzA+RSoaKazfc2rHeTIx90bamzDlKcp/n/ni86sjsh25Gry9tq1+9
        NL29T/LnbSWRDK1JFVvbHobe/3IkuKV7+j2nC9vS3TaseNzpKL5P9+uXomVnl8h8df5wr/nH
        qiuL9me9qz3a4nEp0Kx6R+eqaOE01+qjZz/WRdq8eLe3xPnd2Z0VDYtTVj3+xva2otArllPj
        3DktPXnuO1pKLMUZiYZazEXFiQCnKn9bCAMAAA==
X-CMS-MailID: 20200824111547epcas1p3fe21d43cdcc593bab9e9bff288923bc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200824103713epcas1p4ae0d5d821fd468163ec5948dd59d0d15
References: <20200817070009.4631-1-krzk@kernel.org>
        <CGME20200824103713epcas1p4ae0d5d821fd468163ec5948dd59d0d15@epcas1p4.samsung.com>
        <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/24/20 7:36 PM, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
>  Thank you for the patches and optimized the code as well.
>  I have applied your patches and tested, it's working fine
>  with few minor changes as per Intel's LGM board.

Thanks for the test.

> 
>  can I send the patches along with patches or we need to wait until
>  your patch get merge?
> 
>  Please suggest to me go further, Thanks!

I applied these patches. You better to send your patches
based on extcon-next. Thanks.

> 
> On 17/8/2020 2:59 pm, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Changes since v1:
>> 1. Mutex unlock fix in patch 8/13.
>>
>> Best regards,
>> Krzysztof
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
