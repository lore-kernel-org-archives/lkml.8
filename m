Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58368C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F70D2220E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vl8bhNHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgIHMmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:42:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45575 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbgIHLjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:39:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200908113720euoutp01265945bebd1b36272e308b525f9731c8~yy_4PyYLB0798607986euoutp01K
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:37:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200908113720euoutp01265945bebd1b36272e308b525f9731c8~yy_4PyYLB0798607986euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599565041;
        bh=1h9+2inM7Mg8aWx/P256aTocGivRHYGhx4hK984Avz4=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=Vl8bhNHr9x91yG9CgwbzD3U9N31IuvuiNoAtixituJ/c4H9Mt8h474byAWljL4r9g
         EgE5NAthoMIQokSxMm4/xFJQJKIl6hd4tZjODVwFVHSF6BdYIIhUTkyBgLJEgKbIjQ
         Ja1ubHMJZ/aSIP+a9tVSeLtgaJYSiLKfvlS/HmsM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908113720eucas1p1efe13d827620f5b16bf52cad57c4f95f~yy_3-etwL2000020000eucas1p1M;
        Tue,  8 Sep 2020 11:37:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.A5.06318.0FC675F5; Tue,  8
        Sep 2020 12:37:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200908113720eucas1p228e03033858ec186c66ea45cd03fac6b~yy_3yc8cn2393723937eucas1p2A;
        Tue,  8 Sep 2020 11:37:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200908113720eusmtrp113a3f3e5681354a2c21ecb09edd21bcf~yy_3x1dlp2045820458eusmtrp1T;
        Tue,  8 Sep 2020 11:37:20 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-6c-5f576cf0c478
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.D1.06314.0FC675F5; Tue,  8
        Sep 2020 12:37:20 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200908113720eusmtip2f40cce84b018f6a8b02cf08f64f9951c~yy_3ZAvFN1663016630eusmtip2R;
        Tue,  8 Sep 2020 11:37:20 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] lib/fonts: add font 6x8 for OLED display
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de,
        Sven Schneider <s.schneider@arkona-technologies.de>
Message-ID: <421b685e-4932-9f12-e795-62e8460d9948@samsung.com>
Date:   Tue, 8 Sep 2020 13:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200820084239.GB1001857@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7ofcsLjDTr6tC2aF69ns1g1dSeL
        xYm+D6wWl3fNYbP4u30Ti8XRx7uZHNg8zt0+ze6xf+4ado/+vwYenzfJBbBEcdmkpOZklqUW
        6dslcGV82/iDueAZS8W1aZPZGhjbWboYOTkkBEwkug+tZO1i5OIQEljBKLGu5Sc7hPOFUeLc
        le1sEM5nRonzRx4xdzFygLU8fckJEV/OKHG4+x0LhPOWUeLFjB+sIHPZBKwkJravYgRpEBZw
        kGjokgYxRQRiJHaeKwMpZxboZpTovfeSCSTOK2AnsXaZFkgni4CKxLUtL5hBbFGBCIlPDw6D
        TeQVEJQ4OfMJ2NWcAoYSy490s4PYzALiEreezGeCsOUltr+dwwwyX0JgGbvEqbtXGCFudpHo
        6OWA+FhY4tXxLewQtozE6ck9LBD16xgl/na8gGreziixfPI/Nogqa4k7536xgQxiFtCUWL9L
        HyLsKLHq8moWiPl8EjfeCkLcwCcxadt0aFDxSnS0CUFUq0lsWLaBDWZt186VzBMYlWYh+WwW
        km9mIflmFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQITzel/x7/uYNz3J+kQ
        owAHoxIPr4dvWLwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzFKc7AoifMa
        L3oZKySQnliSmp2aWpBaBJNl4uCUamCc/c77R3X5nMfLQk9U7ZJgUbq6pbLldsd/vf88RsIp
        qQf+t697N33PrN6N3VwKTKsDXC/kmm+a4vTfVG4Z39MVF6S8DGI/P9i7WtKuNXr3E8GHs1b0
        rt1VuPcRO7vkwYCFG9dJ1z9fwXqQLSvz5d3SpBse36ZOuBv5zusZ1wf9GysTbT6emh4aqsRS
        nJFoqMVcVJwIANRVxugwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7ofcsLjDXr2SFo0L17PZrFq6k4W
        ixN9H1gtLu+aw2bxd/smFoujj3czObB5nLt9mt1j/9w17B79fw08Pm+SC2CJ0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4tvEHc8Ezlopr0yaz
        NTC2s3QxcnBICJhIPH3J2cXIxSEksJRR4vu5H+wQcRmJ4+vLuhg5gUxhiT/Xutggal4zSlz6
        cpsFJMEmYCUxsX0VI0i9sICDREOXNEhYRCBGYtq1GYwgNrNAN6PEn/X5EL1bGSU2/ZsMNp9X
        wE5i7TItkBoWARWJa1teMIPYogIREod3zALr5RUQlDg58wnYKk4BQ4nlR7rZIWaqS/yZd4kZ
        whaXuPVkPhOELS+x/e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al
        6yXn525iBEbWtmM/N+9gvLQx+BCjAAejEg/vB6+weCHWxLLiytxDjBIczEoivE5nT8cJ8aYk
        VlalFuXHF5XmpBYfYjQFem4is5Rocj4w6vNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5ak
        ZqemFqQWwfQxcXBKNTDG9vxYGFxSoNX5aO9OxVmKy+uZrFjDnxqtbYzpEfrgF3/fjOvv5Ifh
        f7/nynLLVN929zRc9fLk5iXFHlMkdp9k/B6/TXlu3aW5d0u4bz1Z5Ck9a931eSusfU9t7ft7
        tW/T1TMK021PPCy+uu3/norvhw2uTd9YtXFB1xpV0aepfrMD77i6tAWWKbEUZyQaajEXFScC
        AJ4z7NbCAgAA
X-CMS-MailID: 20200908113720eucas1p228e03033858ec186c66ea45cd03fac6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200820084223eucas1p19fb46e7108c6e6def42162c6881a94d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200820084223eucas1p19fb46e7108c6e6def42162c6881a94d2
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
        <CGME20200820084223eucas1p19fb46e7108c6e6def42162c6881a94d2@eucas1p1.samsung.com>
        <20200820084239.GB1001857@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/20 10:42 AM, Greg Kroah-Hartman wrote:
> On Thu, Aug 20, 2020 at 10:21:37AM +0200, Sascha Hauer wrote:
>> From: Sven Schneider <s.schneider@arkona-technologies.de>
>>
>> This font is derived from lib/fonts/font_6x10.c and is useful for small
>> OLED displays
>>
>> Signed-off-by: Sven Schneider <s.schneider@arkona-technologies.de>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
