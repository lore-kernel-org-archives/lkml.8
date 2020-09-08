Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247BEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F87221ED
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V090EhWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgIHNKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 09:10:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42706 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbgIHLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:37:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200908113650euoutp0205ee215d12bf545da362e72e29374bca~yy_b85Lei3237932379euoutp02t
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:36:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200908113650euoutp0205ee215d12bf545da362e72e29374bca~yy_b85Lei3237932379euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599565010;
        bh=g5440TnfUUbLi30vNa07P7jouFmRBB7rucNUoU6i/8E=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=V090EhWDFrTzsPdP/INxD7HxK8udml6ICXBHv37R5dewamurmh5/BLBm0VhZkFwit
         eEgZtTnFxefnBq6b7rvpR7q+s/f4/SPLW2pcQ6P93YoyagooMRGUJKaeQNS0SQhLga
         sSQ7ssmdksVPndzwaGvxcGkDlzE+WYu7ps2ob2wk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908113650eucas1p1fdcd72f2a4c03cf2c852203be2ffb75a~yy_bkCV6k0524005240eucas1p1k;
        Tue,  8 Sep 2020 11:36:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2F.85.06318.2DC675F5; Tue,  8
        Sep 2020 12:36:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200908113649eucas1p2c2fd05202aa5795554058866e11e571e~yy_bRI5cF0080300803eucas1p28;
        Tue,  8 Sep 2020 11:36:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200908113649eusmtrp1648c91b18ae53c7a17db386efd24449a~yy_bQliCs2002320023eusmtrp1n;
        Tue,  8 Sep 2020 11:36:49 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-11-5f576cd28ec8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.94.06017.1DC675F5; Tue,  8
        Sep 2020 12:36:49 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200908113649eusmtip1c65e586662a29c729c5ddbee20ef9cfc~yy_a4yt_k0553105531eusmtip15;
        Tue,  8 Sep 2020 11:36:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4] video: fbdev: ssd1307fb: Added support to Column
 offset
To:     Rob Herring <robh@kernel.org>,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <2f18ec01-6041-d3f2-787e-16490faf2fbe@samsung.com>
Date:   Tue, 8 Sep 2020 13:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200727204016.GA836415@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qXcsLjDS5uZrf4ePcrs8X8I+dY
        La58fc9mcaLvA6vF5V1z2Cz+79nB7sDmsXPWXXaPTas62Tzudx9n8vi8SS6AJYrLJiU1J7Ms
        tUjfLoErY++V04wF09kqVn3/x9jA+JWli5GTQ0LAROLasRbGLkYuDiGBFYwSx+9dYYFwvjBK
        XJr8iw3C+cwosWn9fkaYlp4VZ5ghEssZJdq7TrCCJIQE3jJKfHttAmKzCVhJTGxfBdTAwSEs
        EChx9oE9SFhEIETicts9JhCbWaBGYtGRg8wgNq+AncSqeXPBbBYBFYmFzy6xgdiiAhESnx4c
        ZoWoEZQ4OfMJ2NmcAjoSj068YYGYIy5x68l8qJnyEtvfzgG7TUJgEbvEo8vzoY52kfj7cC0r
        hC0s8er4FnYIW0bi9OQeFoiGdYwSfzteQHVvZ5RYPvkfG0SVtcSdc6Cw4ABaoSmxfpc+RNhR
        4s2jR8wgYQkBPokbbwUhjuCTmLRtOlSYV6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwz
        C8k7sxD2LmBkWcUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYbk7/O/51B+O+P0mHGAU4
        GJV4eD18w+KFWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHL
        WCGB9MSS1OzU1ILUIpgsEwenVANjyEH+5d9iDmbnpP2LurGW/6bNUvOjE1PEL5hfPXRVnTfq
        wK7e780uAQ7MS4uzjy2Y3z7JqGK19Zm0FTsU9h1+ofmR+9hExo4pyUtmzPvBtnMF91qLKY86
        E/9b7lGvaLz43mPOBs1A/5X3JvWwfF0abrYme+ohfWvNuG1Nc+7tnnSsb1bXbF/xCUosxRmJ
        hlrMRcWJANjodZ8zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7oXc8LjDfad17f4ePcrs8X8I+dY
        La58fc9mcaLvA6vF5V1z2Cz+79nB7sDmsXPWXXaPTas62Tzudx9n8vi8SS6AJUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY++V04wF09kqVn3/
        x9jA+JWli5GTQ0LARKJnxRnmLkYuDiGBpYwSLdN3ADkcQAkZiePryyBqhCX+XOtig6h5zShx
        8tUuZpAEm4CVxMT2VYwg9cICgRJnH9iDmCICIRJtS8NAKpgFaiS+Pt3NBNF6iFHi1OyFbCAJ
        XgE7iVXz5oKNYRFQkVj47BJYXFQgQuLwjlmMEDWCEidnPgG7k1NAR+LRiTcsEEPVJf7Mu8QM
        YYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS
        9ZLzczcxAqNr27GfW3Ywdr0LPsQowMGoxMP7wSssXog1say4MhfoKQ5mJRFep7On44R4UxIr
        q1KL8uOLSnNSiw8xmgI9N5FZSjQ5Hxj5eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
        U1MLUotg+pg4OKUaGHvC4gQSNfQCQt4sXtx25v+N9BOlrSfkN81zv/aXVf0l08HnGjJpL/pc
        8hha90/1Ydlr6zr9379H/Ocy/f7ohgukGdiefLIt9tCyBiON6Ub8Wv8TDE88cL+p9X7OK+sD
        2ypYY/zPB82N/Dxhaf5Ju4xJ6ia/vHU0pYQVXDZlOvamNWj92uW6VYmlOCPRUIu5qDgRAOyu
        cxLEAgAA
X-CMS-MailID: 20200908113649eucas1p2c2fd05202aa5795554058866e11e571e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200727204022eucas1p2e9b7da30fb7157d3d6802833c0625e5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200727204022eucas1p2e9b7da30fb7157d3d6802833c0625e5d
References: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
        <CGME20200727204022eucas1p2e9b7da30fb7157d3d6802833c0625e5d@eucas1p2.samsung.com>
        <20200727204016.GA836415@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added dri-devel ML to Cc: ]

On 7/27/20 10:40 PM, Rob Herring wrote:
> On Fri, 24 Jul 2020 17:22:18 -0300, Rodrigo Alencar wrote:
>> This patch provides support for displays like VGM128064B0W10,
>> which requires a column offset of 2, i.e., its segments starts
>> in SEG2 and ends in SEG129.
>>
>> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
>>  drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to drm-misc-next tree, thanks and sorry for the delay.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
