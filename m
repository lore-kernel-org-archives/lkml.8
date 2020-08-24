Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282C72074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LcfH3zh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgHXLPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:15:43 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53919 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHXLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:14:56 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200824111447epoutp03bd05d20eb5cb5b452b6451c07a8cfe8e~uL-52EmqR2867628676epoutp039
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:14:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200824111447epoutp03bd05d20eb5cb5b452b6451c07a8cfe8e~uL-52EmqR2867628676epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598267687;
        bh=8WDpye9ll5Rw3/XZ5sZwXTyq5y6EIcg6tb3iQpuN7nQ=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=LcfH3zh1rVVHhyJ1biTKfoMiSbJf0dd7GKnFBApXDT5E/g2F9a2DkXYJttlL/8e1M
         dWqKi/Flh6E6gFaDAAF9ONIfiB/F0RcjgHuAmvt4jeA/zRAwTQrmtiWl7F3Lj7h9tp
         0EL5I69Gbv8QkC49aLccXfzAGqAdc6pUreFSbMBE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200824111446epcas1p26f0d23ab5f2ed77e5d10ceeb84d978c7~uL-41-DtW1227812278epcas1p2d;
        Mon, 24 Aug 2020 11:14:46 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BZqJz2vKczMqYkf; Mon, 24 Aug
        2020 11:14:43 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.A5.29173.321A34F5; Mon, 24 Aug 2020 20:14:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200824111442epcas1p44030022c3b9f5efba6e4613b45d6b1aa~uL-1HRWfa0548505485epcas1p4E;
        Mon, 24 Aug 2020 11:14:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200824111442epsmtrp2db6ed69b9c84d0021aa06bc8da1ddfdc~uL-1GnnZi2446424464epsmtrp28;
        Mon, 24 Aug 2020 11:14:42 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-0e-5f43a12387e8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.00.08382.221A34F5; Mon, 24 Aug 2020 20:14:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200824111442epsmtip2035faacd7f7c3884733c992f84b486e1~uL-08yOxs2184021840epsmtip2M;
        Mon, 24 Aug 2020 11:14:42 +0000 (GMT)
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <028fb879-dc74-b822-c399-7f3c9628ec47@samsung.com>
Date:   Mon, 24 Aug 2020 20:27:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTV1d5oXO8waefAhbzj5xjtTh/fgO7
        xeVdc9gsbjeuYLNo3XuE3eLl/umsDmweO2fdZffYtKqTzaNvyypGj8+b5AJYorJtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM05PXsVa0MxU
        sWP3AZYGxn2MXYycHBICJhKLVs5lA7GFBHYwSpyaU93FyAVkf2KUeD7jPSuE841R4vKrZeww
        He17nrBDJPYySsx8d44RwnnPKLGw5QkrSJWwgKvEsW//wKpEBJ4xSjTfvsIMkmAT0JLY/+IG
        2EJ+AUWJqz8egx3CK2An8evhQyYQm0VAVeLJsVlg60QFwiRObmuBqhGUODnzCQuIzQl0xvzH
        F8BqmAXEJW49mc8EYctLbH87hxlksYRAI4fElbebWSDudpE4u/Yt1A/CEq+Ob4GypSQ+v9vL
        BmFXS6w8eYQNormDUWLL/gusEAljif1LJwNt4ADaoCmxfpc+RFhRYufvuYwQi/kk3n3tYQUp
        kRDglehoE4IoUZa4/OAuE4QtKbG4vRNqlYfE5+8XmCYwKs5C8tosJO/MQvLOLITFCxhZVjGK
        pRYU56anFhsWGCNH9yZGcMrUMt/BOO3tB71DjEwcjIcYJTiYlUR4b2+yjxfiTUmsrEotyo8v
        Ks1JLT7EaAoM7InMUqLJ+cCknVcSb2hqZGxsbGFiaGZqaKgkzvvwlkK8kEB6YklqdmpqQWoR
        TB8TB6dUA9O17rVbrL4sfVjmlLL1UPCdiObz12ftbFD9/NwgKIl1wu5r1af3r0gs/2tbm23B
        I5SzLF7pUPXb84p+wmbuQibLJmfzrM+P3tRinVI06y/jBFd1fUbh5in8j3+8nzWHxXtpf+/5
        iAWz1647eF9uTv5JK+bo2qbV5d5TJMOSj8x4szlvs1kuh+Edx4bvTucCuF7ukkoJcf8/QfHj
        g9dflx7Vc+NK3dZs8PrWv8r65MRgvfQHeSn/GV4/7slg2jX9SSWzd0t3jeNFuchszsCEGSsa
        t376ITBZzTExnWedutuU1kkF8Y9NXqtufPeNQ1IiougK3/4ZdmFuF3085CJLOKZurZSVd6ix
        TZASabjlq8RSnJFoqMVcVJwIAK0BwX0iBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvK7SQud4g3WtShbzj5xjtTh/fgO7
        xeVdc9gsbjeuYLNo3XuE3eLl/umsDmweO2fdZffYtKqTzaNvyypGj8+b5AJYorhsUlJzMstS
        i/TtErgyTk9exVrQzFSxY/cBlgbGfYxdjJwcEgImEu17nrB3MXJxCAnsZpQ48+giE0RCUmLa
        xaPMXYwcQLawxOHDxRA1bxklrrX+YAWpERZwlTj27R9Ys4jAM0aJ01NuQU1qZ5T4umk3M0gV
        m4CWxP4XN9hAbH4BRYmrPx6DreYVsJP49fAh2DYWAVWJJ8dmsYPYogJhEjuXPGaCqBGUODnz
        CQuIzQl06vzHF8BqmAXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYF
        jCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCo0RLcwfj9lUf9A4xMnEwHmKU4GBW
        EuG9vck+Xog3JbGyKrUoP76oNCe1+BCjNAeLkjjvjcKFcUIC6YklqdmpqQWpRTBZJg5OqQam
        Etun2Ut+K74XVRKLqRaYVv/sTuT5M7E1CZtmrTl1fYb1hKO1L6+YnGLs+xX68eNmhZdeDp1x
        bjvc27yzF5xR5DrYcNaXQ2/5vMtNCrlN624pesycUbXjxdXusoDVC9PyNjoKM5eddbZeK1X9
        tzC6gu399usvQzU/ighz3TPk3N/x7pbgglNqAS+/n36beWV/9q2ZJx+3Kdw4820ao90qLdYD
        paoLX/BpJrNPX2q7NUvqrvDjLHf7pjl/0sK4pjxX7vfPbG38u2TWxs/T0+ezXCpi1XJ328m6
        2FZeq389D2vN7XMXb1WJzvp7cb9S9yX9lsLzOs80GnYuWRihOP+q9xrlMM9Osx2rP1oGLZvG
        p8RSnJFoqMVcVJwIAO7Mx8kBAwAA
X-CMS-MailID: 20200824111442epcas1p44030022c3b9f5efba6e4613b45d6b1aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200817070046epcas1p4c047a86ccef2e5604f31e674782c9c6c
References: <CGME20200817070046epcas1p4c047a86ccef2e5604f31e674782c9c6c@epcas1p4.samsung.com>
        <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 8/17/20 3:59 PM, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1:
> 1. Mutex unlock fix in patch 8/13.
> 
> Best regards,
> Krzysztof
> 
> 

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
