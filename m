Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F98C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F92B22225
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hx8CI0aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgIHMnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:43:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45571 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbgIHLjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:39:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200908113726euoutp0150cc93a45bd86af37d5aa80ae148eedf~yy_8_mumZ0628106281euoutp01a
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:37:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200908113726euoutp0150cc93a45bd86af37d5aa80ae148eedf~yy_8_mumZ0628106281euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599565046;
        bh=YX5Ozfb/CjfLlm36wfddM3hg5/EdwEKcQNMZa2vnYhE=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=hx8CI0ajE7vQqi1irmaQvP1SWqxPVpQFveUg9/9xHEdEIG+Q1XPX4uaobvJYi6qjW
         Tw5Rpu68Hk1s7pshrfkv1d94EbYNwjIqfQm94Rf+RPM2nXo+kk6StVt8etYJ6o+2EL
         uiH+3Nfk/e12eSd8u8sESb/PbBTKLdgaIvFotRjU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908113725eucas1p1b8d5f3d985cdc1e55ecc4ac172617191~yy_8wSc6I1728817288eucas1p1L;
        Tue,  8 Sep 2020 11:37:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AE.4E.06456.5FC675F5; Tue,  8
        Sep 2020 12:37:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200908113725eucas1p18452307ce859b6b9d7af4a9334790621~yy_8e-m1_0545005450eucas1p1-;
        Tue,  8 Sep 2020 11:37:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200908113725eusmtrp175e41df502f8f8b693466f0d00b4a4d3~yy_8eYWvV2045820458eusmtrp1n;
        Tue,  8 Sep 2020 11:37:25 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-df-5f576cf5c793
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.D1.06314.5FC675F5; Tue,  8
        Sep 2020 12:37:25 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200908113725eusmtip268fe25a2781131603481e6f7efd103bd~yy_8KSQfB1658216582eusmtip2Y;
        Tue,  8 Sep 2020 11:37:25 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] docs: fb: Correcting the location of
 FRAMEBUFFER_CONSOLE option.
To:     Bilal Wasim <bilalwasim676@gmail.com>
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Message-ID: <35fef2e8-dafd-c1dc-711d-fdbdf80c36a8@samsung.com>
Date:   Tue, 8 Sep 2020 13:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200824145155.42502-1-bilalwasim676@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87pfc8LjDVb9NrCY2GJg8eRAO6PF
        la/v2SwWti1hsTjR94HV4vKuOWwObB47Z91l97jffZzJY3HfZFaPz5vkAliiuGxSUnMyy1KL
        9O0SuDI2rvvMVLCUu2LjhzXMDYwbObsYOTkkBEwk7n7dzNzFyMUhJLCCUeLxlTssEM4XRonn
        /3cwQjifGSUuN1xhh2m5vraDCSKxnFHi2rIdbBDOW0aJK08usYJUsQlYSUxsX8UIYgsLhEts
        OfeFDcQWEdCU+Pp+JdhYZoFeRomGdR1gRbwCdhKnL35gBrFZBFQkjr7YwQRiiwpESHx6cJgV
        okZQ4uTMJywgNqeArcStuQvBbGYBcYlbT+YzQdjyEtvfzgH7SEJgFbvE97bDbBB3u0jce3ub
        CcIWlnh1fAvUPzISpyf3sEA0rGOU+NvxAqp7O6PE8sn/oLqtJe6c+wVkcwCt0JRYv0sfxJQQ
        cJQ4c0EewuSTuPFWEOIGPolJ26YzQ4R5JTrahCBmqElsWLaBDWZr186VzBMYlWYh+WwWkm9m
        IflmFsLaBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQITzul/xz/tYPx6KekQowAH
        oxIP7wevsHgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQy
        VkggPbEkNTs1tSC1CCbLxMEp1cDIuC8pV6V+z0/F0Logp08vz7HJbl8Sb7bV7fERj6Qt2hl/
        tAxCez8pm37VXdMfcWpTtfGc5b/7VjsqNm398XzHiby/W6Ser729NG7fl6n5VxdG3tFN6Tyx
        /laWy4G4xi+3VwRlvDHc2+rf0GZ0MVLiW+GSktyL7QJ+gtfWB0iJ6Ho/it8u0VCixFKckWio
        xVxUnAgA7YivtTQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7pfc8LjDboPyVpMbDGweHKgndHi
        ytf3bBYL25awWJzo+8BqcXnXHDYHNo+ds+6ye9zvPs7ksbhvMqvH501yASxRejZF+aUlqQoZ
        +cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkb131mKljKXbHxwxrm
        BsaNnF2MnBwSAiYS19d2MHUxcnEICSxllFj15SZLFyMHUEJG4vj6MogaYYk/17rYIGpeM0o8
        6fnDDpJgE7CSmNi+ihHEFhYIlzj8+iwriC0ioCnx9f1KRpAGZoFeRomNUx4wQ3RPYJRo/76a
        CaSKV8BO4vTFD8wgNouAisTRFzvA4qICERKHd8xihKgRlDg58wkLiM0pYCtxa+5CMJtZQF3i
        z7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgx
        t7g0L10vOT93EyMwwrYd+7l5B+OljcGHGAU4GJV4eD94hcULsSaWFVfmHmKU4GBWEuF1Ons6
        Tog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgdGfVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
        ID2xJDU7NbUgtQimj4mDU6qBscsz5OhFPaH46XX2899ebjU5VMKR+bWyQkLM5mbkMYPXFvaH
        emqOHb4RW3Zjp4dv2KsDc+rEU/Y7TjScpFPUUns5iP0vS3zb4lSB84+nqSvHNfv/le3YUrsw
        6+fiQr4ndd5XlJrerz2j1M3YERq5ubvJO0CjyEsuUu6g+8409quH3cIMNh1RYinOSDTUYi4q
        TgQAAF8E/8YCAAA=
X-CMS-MailID: 20200908113725eucas1p18452307ce859b6b9d7af4a9334790621
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200824145242eucas1p1ed74d79e952a573a80d43864b500e0ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200824145242eucas1p1ed74d79e952a573a80d43864b500e0ca
References: <CGME20200824145242eucas1p1ed74d79e952a573a80d43864b500e0ca@eucas1p1.samsung.com>
        <20200824145155.42502-1-bilalwasim676@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added linux-fbdev ML to Cc: ]

On 8/24/20 4:51 PM, Bilal Wasim wrote:
> fbcon doc mentions FRAMEBUFFER_CONSOLE option to be under
> Device Drivers->Graphics Support->Frame buffer Devices->
> Console display driver support->Framebuffer Console Support,
> while its under Device Drivers->Graphics Support->
> Console display driver support->Framebuffer Console Support.
> 
> Correcting it in the docs.
> 
> Signed-off-by: Bilal Wasim <bilalwasim676@gmail.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  Documentation/fb/fbcon.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index e57a3d1d085a..a7b487cba307 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -20,8 +20,8 @@ A. Configuration
>  ================
>  
>  The framebuffer console can be enabled by using your favorite kernel
> -configuration tool.  It is under Device Drivers->Graphics Support->Frame
> -buffer Devices->Console display driver support->Framebuffer Console Support.
> +configuration tool.  It is under Device Drivers->Graphics Support->
> +Console display driver support->Framebuffer Console Support.
>  Select 'y' to compile support statically or 'm' for module support.  The
>  module will be fbcon.
>  
