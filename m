Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C868C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5362187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pZleq9BS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAOQEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:04:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39175 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgAOQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:04:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200115160409euoutp02a0afdc5a16a231e287c303c448559523~qGvLRr7WT3205732057euoutp02r
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 16:04:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200115160409euoutp02a0afdc5a16a231e287c303c448559523~qGvLRr7WT3205732057euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579104249;
        bh=JNoHgjvybzOR918hCf0sW82RgR6qUXdh7J7cH64kGnQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pZleq9BSydWIxgcIfq15BjdstwrVvVUfyY+swrMWTl182dMDAZfMY0MujNW9uyiLX
         GbOlu01j9TE7IsWlUdIs1YI5fKX/akRP0x1p10dm1gXqUjaU43ts5Ui383RQNrH1uq
         8LluMxVNfVz5N8e7xjwK5v+M/qOPSZ3vW2bL7pRg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115160409eucas1p1e6151b5882ac620595bed5741dc7d075~qGvK-wjEX0715807158eucas1p15;
        Wed, 15 Jan 2020 16:04:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DE.77.60698.9F73F1E5; Wed, 15
        Jan 2020 16:04:09 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200115160408eucas1p2934b15554794b0d286d52fecd0ac159c~qGvKlEsLR1927219272eucas1p2r;
        Wed, 15 Jan 2020 16:04:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115160408eusmtrp1dd2fde83dde46a4861541748dc72a10c~qGvKkceYj0755607556eusmtrp1d;
        Wed, 15 Jan 2020 16:04:08 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-f6-5e1f37f91b85
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.23.08375.8F73F1E5; Wed, 15
        Jan 2020 16:04:08 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115160408eusmtip1ffa3439495cd450599e31ddbc03818fb~qGvKTCImt1313113131eusmtip1a;
        Wed, 15 Jan 2020 16:04:08 +0000 (GMT)
Subject: Re: [PATCH 07/16] video: sa1100fb: constify copied structure
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <84714bc2-1c5b-7428-a8ae-102f43605f67@samsung.com>
Date:   Wed, 15 Jan 2020 17:04:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1577864614-5543-8-git-send-email-Julia.Lawall@inria.fr>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87o/zeXjDO6d4ba48vU9m0XTqn5m
        i623pC1O9H1gtbi8aw6bA6vHpBeHWDzudx9n8vi8SS6AOYrLJiU1J7MstUjfLoEr4/XU86wF
        b9krntxaxtrAuJqti5GTQ0LAROJS2232LkYuDiGBFYwSi57OYIZwvjBKXNz0ng3C+cwo8WbN
        HbiWew2nWSASyxkl1rR9Z4Vw3jJKPFjSzAJSJSzgKnHt2V+wDhEBDYmlG1eAdTALNDJKzNqy
        ByzBJmAlMbF9FSOIzStgJ/H4zSkwm0VAVeLkwqdgtqhAhMSnB4dZIWoEJU7OfAI0iIODE2jB
        7cecIGFmAXGJW0/mM0HY8hLb384B+0FCYDK7xKJtDxkhznaRWPtwIwuELSzx6vgWdghbRuL0
        5B4WiIZ1jBJ/O15AdW9nlFg++R/U09YSd879YgPZzCygKbF+lz5E2FHi7+p7TCBhCQE+iRtv
        BSGO4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWezkLwzC8k7sxD2LmBkWcUo
        nlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYXE7/O/51B+O+P0mHGAU4GJV4eDP+yMUJsSaW
        FVfmHmKU4GBWEuE9OUM2Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWp
        RTBZJg5OqQbGoxdmTv7Ecv+teQfn4yo72X/LayI7D/cZzPcNkN/+QKlv1tGlX8ui3epSNjOe
        M+z8ciPx8Qv5re8+LOCdXGWt0vH4gLnmy/YGPuX87sX+wTmvZ6WKLjwTwafhavhzu4SfkoJW
        a3/FelvViC4Z39B8v4Cpjy0Megr3y9xp2bxi0neDpjlFM9OVWIozEg21mIuKEwGPJ4yPKgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7o/zOXjDJ4d07W48vU9m0XTqn5m
        i623pC1O9H1gtbi8aw6bA6vHpBeHWDzudx9n8vi8SS6AOUrPpii/tCRVISO/uMRWKdrQwkjP
        0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4/XU86wFb9krntxaxtrAuJqti5GTQ0LA
        ROJew2mWLkYuDiGBpYwSv3oWAzkcQAkZiePryyBqhCX+XOtig6h5zShxZ9oyRpCEsICrxLVn
        f8EGiQhoSCzduAJsELNAI6NE/56NTBAdlxklDjycxQ5SxSZgJTGxfRVYN6+AncTjN6fAbBYB
        VYmTC5+C2aICERKHd8yCqhGUODnzCdhFnEDbbj/mBAkzC6hL/Jl3iRnCFpe49WQ+E4QtL7H9
        7RzmCYxCs5B0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExtK2Yz83
        72C8tDH4EKMAB6MSD2/GH7k4IdbEsuLK3EOMEhzMSiK8J2fIxgnxpiRWVqUW5ccXleakFh9i
        NAX6bSKzlGhyPjDO80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1
        MIrdm//pplKs220hEQPuq7edHVc2P2ndqZXiK1OmcPlmw9uixyeNq2pWLex9dnXPsow2m1X5
        AfXyTgblnX/nLE1SifQTUHPd6vL/dcJpoZOKWnE/fjtcu/Ww76Kcykm+Fc+nsa5M+vElNKVi
        nZPTlWv+Kqu3fnr3K89x17G5R0VtgjVb36bqKyuxFGckGmoxFxUnAgAr47NSuwIAAA==
X-CMS-MailID: 20200115160408eucas1p2934b15554794b0d286d52fecd0ac159c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200101082012epcas5p2b0169522e476fa40aba6bbdd569ca0f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200101082012epcas5p2b0169522e476fa40aba6bbdd569ca0f0
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
        <CGME20200101082012epcas5p2b0169522e476fa40aba6bbdd569ca0f0@epcas5p2.samsung.com>
        <1577864614-5543-8-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/1/20 8:43 AM, Julia Lawall wrote:
> The monspecs structure is only copied into another structure,
> so make it const.
> 
> The opportunity for this change was found using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sa1100fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
> index 4680cc3efb81..c77b43dbc256 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -1053,7 +1053,7 @@ static int sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
>  }
>  
>  /* Fake monspecs to fill in fbinfo structure */
> -static struct fb_monspecs monspecs = {
> +static const struct fb_monspecs monspecs = {
>  	.hfmin	= 30000,
>  	.hfmax	= 70000,
>  	.vfmin	= 50,
> 
