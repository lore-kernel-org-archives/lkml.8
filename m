Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF66BC433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84C32078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rzsyYWdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGJOXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:23:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36873 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgGJOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:23:41 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200710142340euoutp025159fa6e8c7818f9480ed2b341712feb~gai_DRXKn0734707347euoutp02h
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:23:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200710142340euoutp025159fa6e8c7818f9480ed2b341712feb~gai_DRXKn0734707347euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594391020;
        bh=FMuMDYCukbGI4sf+7MFNtZT2CWVV/3ND7OHigsB7fSo=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=rzsyYWdqNkMDsdE2dTcFg7hvuvvjLEBNYKpHu+nz6ptIU2UyGhw+5rg6OZOnoLBtK
         vIRUCfTnhkSj1qNmzpAvtMrliSuGVnnF+Z2v+cjalVVWuK39c3zZYo8BQROPJNQsyI
         /2hDBMLRiXYoMwZ2FS8t8gDVIVOJDEJiCNZDX9SA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200710142340eucas1p1fbe95d0218461a563a23803f71927118~gai91d6hc2928929289eucas1p1I;
        Fri, 10 Jul 2020 14:23:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 04.66.05997.BE9780F5; Fri, 10
        Jul 2020 15:23:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200710142339eucas1p1e78d6b319cac935828114fb77864a9d9~gai9U1mqF0593805938eucas1p1I;
        Fri, 10 Jul 2020 14:23:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710142339eusmtrp15d30f05e49b3f83883feb2ef6676282b~gai9USsA11135411354eusmtrp1D;
        Fri, 10 Jul 2020 14:23:39 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-4e-5f0879eb8b1f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.D1.06314.BE9780F5; Fri, 10
        Jul 2020 15:23:39 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710142339eusmtip2219f6aa3c1f05a7ecc36f76031c0d2c6~gai8-oT0q1081610816eusmtip2B;
        Fri, 10 Jul 2020 14:23:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH][next] fbcon: Use array3_size() helper in scr_memcpyw()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <01ccc599-28a3-d6f0-40ca-7f1983211ce2@samsung.com>
Date:   Fri, 10 Jul 2020 16:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200615231542.GA20470@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87pvKjniDabuYbK48vU9m8XWPaoW
        vy5OY7U40feB1eLyrjlsDqwe6w6qemxa1cnmcb/7OJPH501yASxRXDYpqTmZZalF+nYJXBm7
        mm6yF7zirZh1YipzA2M7dxcjJ4eEgInE1Nt3WbsYuTiEBFYwSmw7uB7K+cIo8erCfzYI5zOj
        xK3db1m6GDnAWubeUISIL2eU6F85nxVklJDAW0aJNUuUQWw2ASuJie2rGEFsYQFviaYHL9hA
        ekUEDCV2rkoA6WUWmMAo8ax3HlgNr4CdxONft5lBalgEVCUWXY0FCYsKREh8enCYFaJEUOLk
        zCcsIDangIFE7+m1YK3MAuISt57MZ4Kw5SW2v53DDDJfQmAeu8TjCRPZId50kfi59C0LhC0s
        8er4Fqi4jMTpyT0sEA3rGCX+dryA6t7OKLF88j82iCpriTvnfoF9wCygKbF+lz5E2FHiQd8e
        Zkig8EnceCsIcQSfxKRt06HCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWw
        dwEjyypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzA9HL63/EvOxh3/Uk6xCjAwajEw7sg
        kSNeiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8s
        Sc1OTS1ILYLJMnFwSjUwVqyunad6cOqmq67+t6d9Ul69gTl/t8qSjkk35/dve9jTsPGjtjT3
        R35Rifn7dmw7Mv1Vl3TwEb87nxnWLIi5t3H+vqxXkces+SRfpT2U+PDO57J6j0jI6VcXEtbF
        7vRWUd9YGnV7xvUTB3b6y5lIrV63epP8hRsPVspYPtk+q1boxy1Jdo7XnfpKLMUZiYZazEXF
        iQBAYFDgKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7qvKzniDdbtlLO48vU9m8XWPaoW
        vy5OY7U40feB1eLyrjlsDqwe6w6qemxa1cnmcb/7OJPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehm7mm6yF7zirZh1YipzA2M7dxcj
        B4eEgInE3BuKXYxcHEICSxklNt2ezgwRl5E4vr6si5ETyBSW+HOtiw2i5jWjxMrFzWwgCTYB
        K4mJ7asYQWxhAW+Jpgcv2EB6RQQMJXauSgCpZxaYwCix5NJ5dojmZkaJg7M/soI08ArYSTz+
        dRtsGYuAqsSiq7EgYVGBCInDO2YxQpQISpyc+YQFxOYUMJDoPb0WLM4soC7xZ94lZghbXOLW
        k/lMELa8xPa3c5gnMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7
        iREYT9uO/dy8g/HSxuBDjAIcjEo8vAsSOeKFWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqU
        H19UmpNafIjRFOi3icxSosn5wFjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQ
        WgTTx8TBKdXAOJ1zX1/y48N1W/bu3eThcU/kQvvy5CerEzU82zz+57jf81armL77eHmZyIuz
        h3rvGb54ZLTNRaZqYe78W/Vp71cvcJqon+vbZ1LNutCw7NxOnp6r2+Zcvu9UtlzuJGtYwP7P
        u7iZC4ykqu4vcpJ50/b4tNPOZhueTf3Fubt+Pju+hO0S6zXmLUosxRmJhlrMRcWJAJBb/Ra9
        AgAA
X-CMS-MailID: 20200710142339eucas1p1e78d6b319cac935828114fb77864a9d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200615231029eucas1p1875c2cab0363a12afd0c5dea7ab0cb8b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200615231029eucas1p1875c2cab0363a12afd0c5dea7ab0cb8b
References: <CGME20200615231029eucas1p1875c2cab0363a12afd0c5dea7ab0cb8b@eucas1p1.samsung.com>
        <20200615231542.GA20470@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/20 1:15 AM, Gustavo A. R. Silva wrote:
> Use array3_size() helper instead of the open-coded version in scr_memcpyw()
> and scr_memsetw(). These sorts of multiplication factors need to be wrapped
> in array3_size().
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 9d28a8e3328f..6af2734f2a7b 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -639,7 +639,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  			       GFP_KERNEL);
>  		if (save) {
>  			int i = cols < new_cols ? cols : new_cols;
> -			scr_memsetw(save, erase, logo_lines * new_cols * 2);
> +			scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
>  			r = q - step;
>  			for (cnt = 0; cnt < logo_lines; cnt++, r += i)
>  				scr_memcpyw(save + cnt * new_cols, r, 2 * i);
> @@ -676,7 +676,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  		q = (unsigned short *) (vc->vc_origin +
>  					vc->vc_size_row *
>  					rows);
> -		scr_memcpyw(q, save, logo_lines * new_cols * 2);
> +		scr_memcpyw(q, save, array3_size(logo_lines, new_cols, 2));
>  		vc->vc_y += logo_lines;
>  		vc->vc_pos += logo_lines * vc->vc_size_row;
>  		kfree(save);
> 
