Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC72C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27557207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BUhVbI0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgHXJvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:51:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36982 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgHXIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200824083847euoutp01d6426e091e9f8b7b5f2a44e43f51b383~uJ3skE5Gb2296422964euoutp01O
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 08:38:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200824083847euoutp01d6426e091e9f8b7b5f2a44e43f51b383~uJ3skE5Gb2296422964euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598258327;
        bh=d5zBGNTG09qN8oq9xk3yatQT12ck2KU9/T4te3OQtH0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BUhVbI0FHNxXyKji/uyGzOrPdJsVp4vzOvXUCdlFmvPIdlFQbmJk4BUZY6jfDLqTq
         jOgyoapzxeCIk3f+M3jPC/T0urPvR3kJg421ZnL3a+2Lk/Ivydwlf00y4BjYEbrTkL
         dygrZb9bKhZeUpTVnN9SvdU4sGtYRp1V49FF2iGw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200824083847eucas1p2b193f5d4689865e807b13c9785e1ef94~uJ3saXGlY2165121651eucas1p2c;
        Mon, 24 Aug 2020 08:38:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2A.F4.05997.79C734F5; Mon, 24
        Aug 2020 09:38:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200824083847eucas1p2e5fee0790df8f21934d99e848dc14afe~uJ3sG3mJ80453004530eucas1p2o;
        Mon, 24 Aug 2020 08:38:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200824083847eusmtrp11aa7259a91c28ce5e12d66362cb4d44e~uJ3sGRkuy2978629786eusmtrp1m;
        Mon, 24 Aug 2020 08:38:47 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-8b-5f437c97fcdf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.41.06017.69C734F5; Mon, 24
        Aug 2020 09:38:47 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200824083846eusmtip2fc26e13e305b763d92ee4941eb445d4a~uJ3rzVv2m1261712617eusmtip2j;
        Mon, 24 Aug 2020 08:38:46 +0000 (GMT)
Subject: Re: [PATCH v1] mfd: core: Fix double-free in
 mfd_remove_devices_fn()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ac27b0cc-6ede-c7ed-19ee-2472f87f93f7@samsung.com>
Date:   Mon, 24 Aug 2020 10:38:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817235048.24577-1-digetx@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd3pNc7xBqfeiFms/viY0eL+16OM
        Fpd3zWFzYPbYOesuu8eda3vYPD5vkgtgjuKySUnNySxLLdK3S+DKeH9tNlvBee6KpjtbmRoY
        z3B2MXJySAiYSLw+NJ29i5GLQ0hgBaNE59HrUM4XRokzbQvYIJzPjBJTHt1mhWl59fUAK0Ri
        OaPEzt7JzBDOe0aJVedvMIJUCQv4S6yfcJUFxBYR8JCYPbOVCcRmFlCQ+HVvE9gkNgFDia63
        XWwgNq+AncSP9gdANRwcLAKqEgvvxICERQXiJLYev8oEUSIocXLmE7CRnAJmEvd/7WKFGCkv
        sf3tHGYIW1zi1pP5TCD3SAi0s0u86P7ACHG1i8TrU8eYIWxhiVfHt7BD2DISpyf3sEA0NDNK
        PDy3lh3C6WGUuNw0A6rbWuLOuV9sINcxC2hKrN+lDxF2lHjTAnG0hACfxI23ghBH8ElM2jad
        GSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAvJa7OQvDMLyTuzEPYuYGRZxSieWlqcm55abJSX
        Wq5XnJhbXJqXrpecn7uJEZhITv87/mUH464/SYcYBTgYlXh4fxyyjxdiTSwrrsw9xCjBwawk
        wut09nScEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYyl
        BlM/uShmc/X6urPf116osY3hD2fxlGX/i5a+m/6SxcJZuCHvucvno7xMs9XmC4U+O7PM9EvA
        r+IvxRssf3w7eJujcaGgFuO2FYubjxTNWfOiL11m+Xv9vpj8IxvlTS5f+yR8Yqo2a9ixmVdC
        K7j3fz18e+Lb5nn8ya4XZhucqdhWflE01dxbiaU4I9FQi7moOBEACQ0PbiADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7rTa5zjDb60MVqs/viY0eL+16OM
        Fpd3zWFzYPbYOesuu8eda3vYPD5vkgtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLeH9tNlvBee6KpjtbmRoYz3B2MXJySAiYSLz6eoC1i5GL
        Q0hgKaPEiRuv2CESMhInpzWwQtjCEn+udbFBFL1llFhwaAZQgp1DWMBXotkNpEREwENi9sxW
        JhCbWUBB4te9TWCtQgKmEveuTQGLswkYSnS9BRnDycErYCfxo/0BUJyDg0VAVWLhnRiQsKhA
        nMTj3v/MECWCEidnPmEBsTkFzCTu/9rFCjHeTGLe5ofMELa8xPa3c6BscYlbT+YzTWAUmoWk
        fRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMGa2Hfu5ZQdj17vgQ4wC
        HIxKPLw/DtnHC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQbxOZpUST
        84HxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgdFH7VXJ1GNa
        q742hmud0Fq0u0nFR4vJ5eO1j7tv5Up3pU3hjNJQXm58re2TMN+9WRsO57Ee3ymxfv6fvC2z
        L7pcdWF9yaNj9W9jpNuzGOaLeZtdw8OeZZ24mGLkZuDTbmj35Gr0yd+5qzj3n/yekhXTeH2Z
        0QX/kIXVF/39fi+WYlOZ1GF1WEeJpTgj0VCLuag4EQDdGaGkrwIAAA==
X-CMS-MailID: 20200824083847eucas1p2e5fee0790df8f21934d99e848dc14afe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200824083847eucas1p2e5fee0790df8f21934d99e848dc14afe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200824083847eucas1p2e5fee0790df8f21934d99e848dc14afe
References: <20200817235048.24577-1-digetx@gmail.com>
        <CGME20200824083847eucas1p2e5fee0790df8f21934d99e848dc14afe@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 18.08.2020 01:50, Dmitry Osipenko wrote:
> The pdev.mfd_cell is released by platform_device_release(), which is
> invoked by platform_device_unregister(). Hence mfd_remove_devices_fn()
> shouldn't release the cell variable. The double-free bug is reported KASAN
> during of MFD driver module removal.
>
> Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

I've reported that almost a week earlier and got information that it 
will be dropped:

https://lore.kernel.org/lkml/79bcd1b5-2247-5e00-7d49-2f94f9b40744@samsung.com/

https://lore.kernel.org/lkml/20200813080100.GI4354@dell/

Sadly it finally landed in v5.9-rc1. Would be nice to mention this in 
the revert:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

>   drivers/mfd/mfd-core.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index c3651f06684f..c50718e3db58 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -370,8 +370,6 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
>   	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
>   					       cell->num_parent_supplies);
>   
> -	kfree(cell);
> -
>   	platform_device_unregister(pdev);
>   	return 0;
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

