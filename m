Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F9FC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825B32078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bbBaBWco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgGJOXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:23:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36859 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgGJOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:23:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200710142336euoutp027b71ca1e68c61499ed416d2a06df3dac~gai6y2LPl0760207602euoutp026
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:23:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200710142336euoutp027b71ca1e68c61499ed416d2a06df3dac~gai6y2LPl0760207602euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594391016;
        bh=k3JSFO5eGGDgdqwjQhLkYWYwXYgt1cqYio32K0vqcxE=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=bbBaBWco7EoqwPsd1m2kuX6tt3D7TImh6YnAGKbXmrFUdpbUJmwvtSMLAqJtjuzyg
         TtBLb2JQDWUO42SVwpzwqXlfmu2yx8iCiH2LMw774uy85d9zjG6xzyu1DsgNE4bXST
         NUkFVQPi7MwTqLLZZdevOS4BghmRVIwoGbPtz0qY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710142336eucas1p2667d56def20b47773580a2a449e890f9~gai6fNZ9K2122921229eucas1p2E;
        Fri, 10 Jul 2020 14:23:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7F.CE.06318.8E9780F5; Fri, 10
        Jul 2020 15:23:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200710142336eucas1p1b50636467635991d95f8de79465e163e~gai6H-TJZ2928929289eucas1p1B;
        Fri, 10 Jul 2020 14:23:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710142336eusmtrp1aaa89345fa2898f0f444067b2107b7c2~gai6HYqSK1070610706eusmtrp1g;
        Fri, 10 Jul 2020 14:23:36 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-0e-5f0879e84f5a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.D1.06314.8E9780F5; Fri, 10
        Jul 2020 15:23:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710142335eusmtip22885cfcc5d2ece2d12cf6f3bc6baee61~gai5xRJZx1450814508eusmtip2V;
        Fri, 10 Jul 2020 14:23:35 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH][next] fbdev/fb.h: Use struct_size() helper in kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <0a245efa-fa37-539c-4e2a-81d6bcf17670@samsung.com>
Date:   Fri, 10 Jul 2020 16:23:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200617175647.GA26370@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7ovKjniDRoWKFpc+fqezWLrHlWL
        XxensVqc6PvAanF51xw2B1aPdQdVPTat6mTzuN99nMnj8ya5AJYoLpuU1JzMstQifbsEroye
        rcsZCxo5K8589G1gXMjexcjJISFgIjHh/GpGEFtIYAWjxJVbIhD2F0aJ7ddzuxi5gOzPjBIH
        O3cxwjQc+beaCSKxnFGi9/FZJoiOt4wSp6+Jg9hsAlYSE9tXgTUIC/hIXDr/gLWLkYNDRMBQ
        YueqBJBeZoEJjBLPeueB1fAK2Em0tL1kBrFZBFQlXl76BDZTVCBC4tODw6wQNYISJ2c+YQGx
        OQUMJKZ0bgWrYRYQl7j1ZD6ULS+x/e0cZpAFEgLz2CWerJrEAnG1i8Sy4zOZIWxhiVfHt0C9
        LyNxenIPC0TDOkaJvx0voLq3M0osn/yPDaLKWuLOuV9sIC8wC2hKrN+lDxF2lPi54iBYWEKA
        T+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6dK5knMCrNQvLaLCTvzELyziyEvQsY
        WVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJpfT/45/3cG470/SIUYBDkYlHt4FiRzx
        QqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2
        ampBahFMlomDU6qB0eH3W7VMh6311r97l/278zXZv1hMVXFhnVbVwYrS/rCNV6blOAXcl5uV
        /vCVz5aC3E2C7/Kad1hdXXVgT5OMYG639d2T15h7ex9xnv5R3OL+02jd7e8+E1LUX4sniRxY
        d/+oltcudbFHf1P2T1jCX7FpS9uMhSluP2Sz+qSmCQSznHfkbCixUmIpzkg01GIuKk4EAMCJ
        aE4qAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7ovKjniDaZPY7G48vU9m8XWPaoW
        vy5OY7U40feB1eLyrjlsDqwe6w6qemxa1cnmcb/7OJPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk9W5czFjRyVpz56NvAuJC9i5GT
        Q0LAROLIv9VMXYxcHEICSxkl7hw5xtLFyAGUkJE4vr4MokZY4s+1LjaImteMEn0z3jOCJNgE
        rCQmtq8Cs4UFfCQunX/ACtIrImAosXNVAkg9s8AERokll86zQzQ3M0p0flnMBtLAK2An0dL2
        khnEZhFQlXh56RMTiC0qECFxeMcsRogaQYmTM5+wgNicAgYSUzq3gtUwC6hL/Jl3iRnCFpe4
        9WQ+VFxeYvvbOcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/d
        xAiMqG3Hfm7ewXhpY/AhRgEORiUe3gWJHPFCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3K
        jy8qzUktPsRoCvTcRGYp0eR8YLTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1I
        LYLpY+LglGpgnG7HzaGy0LGJc7rOzhaVtV8jNR9VPzMqnRIQxZEm6r/lpHLCxq/bX9e9ONX0
        rcN9Z/vuG/6Sk6PaOiNMgmQO+/NZ/Z20cPMHuQbftNiNiYIftjG+rVtkutllycJloj7XSzx7
        lgdofLngIcrTeGTqvQk3p19yND/74qH1garUKTwONTbPYyfVKbEUZyQaajEXFScCAKirriq+
        AgAA
X-CMS-MailID: 20200710142336eucas1p1b50636467635991d95f8de79465e163e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200617175132eucas1p2f1ea5f3b2f0d5cdb3277577ac8564c3f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200617175132eucas1p2f1ea5f3b2f0d5cdb3277577ac8564c3f
References: <CGME20200617175132eucas1p2f1ea5f3b2f0d5cdb3277577ac8564c3f@eucas1p2.samsung.com>
        <20200617175647.GA26370@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/17/20 7:56 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/linux/fb.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 3b4b2f0c6994..2b530e6d86e4 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -506,8 +506,9 @@ struct fb_info {
>  };
>  
>  static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
> -	struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
> -			+ max_num * sizeof(struct aperture), GFP_KERNEL);
> +	struct apertures_struct *a;
> +
> +	a = kzalloc(struct_size(a, ranges, max_num), GFP_KERNEL);
>  	if (!a)
>  		return NULL;
>  	a->count = max_num;
> 
