Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2434CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3050222B9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NRCM9Lbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgIHMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:53:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43388 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbgIHLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:39:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200908113741euoutp0205486972bc1d65816b91ca5b68b297ae~yy-Ls2oBd3214932149euoutp02h
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:37:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200908113741euoutp0205486972bc1d65816b91ca5b68b297ae~yy-Ls2oBd3214932149euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599565061;
        bh=QuitxZQBOIQ19NncwIG/YnTvX6FhNS3m7J4VbZY5Bt0=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=NRCM9Lbih/VTmkZ3FE8ZJs8IkxsNhlrAJDrHK/az56zZenk9Kx7QSSfgbLhusVMc+
         hlwLkIzuAfh14RMcNBAAFxeiAy/nTwO6wExAgh2JH0F4lwfAj4Dd+vhxliYqC9FoQY
         FZf0eGnF//dsif9ala31OmhTaMgpcGnR4psytbh4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908113741eucas1p1cfc35d4e53cbf9a9aab4ff993eb1e7f9~yy-Lf68pq0524005240eucas1p10;
        Tue,  8 Sep 2020 11:37:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 12.65.05997.50D675F5; Tue,  8
        Sep 2020 12:37:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200908113741eucas1p21d6fb2c42f863d634454ed326af248a9~yy-LHidDE1615916159eucas1p2z;
        Tue,  8 Sep 2020 11:37:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200908113741eusmtrp272ff657bcf89c57b5e34f4456e4f91af~yy-LG9axG3046530465eusmtrp2p;
        Tue,  8 Sep 2020 11:37:41 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-01-5f576d051c5e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 33.C4.06017.50D675F5; Tue,  8
        Sep 2020 12:37:41 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200908113740eusmtip1f9fe9174bcdd4e4fecd7f30db5724f5f~yy-KmQNB20553405534eusmtip1B;
        Tue,  8 Sep 2020 11:37:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] coccinelle: api: fix kobj_to_dev.cocci warnings
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>,
        Bernie Thompson <bernie@plugable.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Message-ID: <9e553578-a8dd-847e-0d19-8c34ce4bf1bc@samsung.com>
Date:   Tue, 8 Sep 2020 13:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2008262252270.2522@hadrien>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7qsueHxBm+a1C0u3v/GYnHl63s2
        iyundjNaNK3qZ7Y4232N0eJE3wdWi8u75rA5sHtMenGIxePJlelMHt2z/7F43O8+zuTxdGoX
        m8fnTXIBbFFcNimpOZllqUX6dglcGTMfT2csOMpXsfjPLLYGxjfcXYycHBICJhJ/v19m7mLk
        4hASWMEo0Xd0FQuE84VR4vz0JiYI5zOjxOLpdxm7GDnAWp5dlYaIL2eUePtmDiuE85ZR4sX6
        5Swgc9kErCQmtq9iBLGFBVwkLs1YBNYsIqAhsfmpMEg9s8BxRok9Wy+B1fAK2En8fzKLFcRm
        EVCRmLWphw3EFhWIkPj04DArRI2gxMmZT1hA5nAK2Eqs35oKEmYWEJe49WQ+E4QtL7H97Ryw
        dyQEDrFLtCx5yQbxp4vE7BfbmSFsYYlXx7ewQ9gyEv93zmeCaFjHKPG34wVU93ZGieWT/0F1
        W0vcOfeLDWQzs4CmxPpd+hBhR4klL0HqQaHCJ3HjrSDEEXwSk7ZNhwrzSnS0CUFUq0lsWLaB
        DWZt186VzBMYlWYh+WwWkndmIXlnFsLeBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3
        MQKT0el/x7/sYNz1J+kQowAHoxIP7wevsHgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRbl
        xxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cDoZckrpyy15rap4MU9mstE
        YldIqu6PcNv/ffGjZdWllqqfFZle6fmzFGot9y/zP3tqkdb8TsHruz/EvnjM8GbPPqfb7iXP
        i2tXX9flkuLu804s/DonutzG7uScIKGwb8yyNs3/GYwTVpycouC82f2DS4pk6CzTm7VV6t/f
        //1Sqc1YxBjc7KPEUpyRaKjFXFScCACLkr9TQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7qsueHxBu83M1tcvP+NxeLK1/ds
        FldO7Wa0aFrVz2xxtvsao8WJvg+sFpd3zWFzYPeY9OIQi8eTK9OZPLpn/2PxuN99nMnj6dQu
        No/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov0
        7RL0MmY+ns5YcJSvYvGfWWwNjG+4uxg5OCQETCSeXZXuYuTiEBJYyijxeNtKVoi4jMTx9WVd
        jJxAprDEn2tdbBA1rxklTuw/zQSSYBOwkpjYvooRxBYWcJG4NGMRI0iviICGxOanwiD1zAJH
        GSUurJvHBNE8gVFi+r3nLCANvAJ2Ev+fzGIFsVkEVCRmbephA7FFBSIkDu+YxQhRIyhxcuYT
        FpChnAK2Euu3poKEmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGoVlIumchaZmFpGUWkpYF
        jCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmNv27GfW3Ywdr0LPsQowMGoxMP7wSssXog1
        say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MC3kl8YamhuYW
        lobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgjSiaUdzSxfenfaLd9zkRz/hYG
        AYP6X3MPCwvH/9lwU06x3+DKpYzZN6JPz//8RmrljLu9W859r32hWffz/KQbS6O+Vpwrzihw
        +qAeai4U+Frr/578asW/f72CWNoyZz6vdC9xy1DT/Fnmvvfi6nO9qlZXF29X2OtamLlYUV9e
        Uqn81PJanXNKLMUZiYZazEXFiQAjBPRy0wIAAA==
X-CMS-MailID: 20200908113741eucas1p21d6fb2c42f863d634454ed326af248a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826205412eucas1p16c748e9d73f4cd924aae1d6386ab450c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826205412eucas1p16c748e9d73f4cd924aae1d6386ab450c
References: <CGME20200826205412eucas1p16c748e9d73f4cd924aae1d6386ab450c@eucas1p1.samsung.com>
        <alpine.DEB.2.22.394.2008262252270.2522@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/26/20 10:54 PM, Julia Lawall wrote:
> From: kernel test robot <lkp@intel.com>
> 
>  Use kobj_to_dev() instead of container_of()
> 
> Generated by: scripts/coccinelle/api/kobj_to_dev.cocci
> 
> Fixes: a2fc3718bc22 ("coccinelle: api: add kobj_to_dev.cocci script")
> CC: Denis Efremov <efremov@linux.com>
> Signed-off-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Julia Lawall <julia.lawall@inria.fr>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux.git for-5.10
> head:   a2fc3718bc22e85378085568ecc5765fb28cabce
> commit: a2fc3718bc22e85378085568ecc5765fb28cabce [3/3] coccinelle: api: add kobj_to_dev.cocci script
> :::::: branch date: 5 days ago
> :::::: commit date: 5 days ago
> 
>  udlfb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1457,7 +1457,7 @@ static ssize_t edid_show(
>  			struct file *filp,
>  			struct kobject *kobj, struct bin_attribute *a,
>  			 char *buf, loff_t off, size_t count) {
> -	struct device *fbdev = container_of(kobj, struct device, kobj);
> +	struct device *fbdev = kobj_to_dev(kobj);
>  	struct fb_info *fb_info = dev_get_drvdata(fbdev);
>  	struct dlfb_data *dlfb = fb_info->par;
> 
> @@ -1479,7 +1479,7 @@ static ssize_t edid_store(
>  			struct file *filp,
>  			struct kobject *kobj, struct bin_attribute *a,
>  			char *src, loff_t src_off, size_t src_size) {
> -	struct device *fbdev = container_of(kobj, struct device, kobj);
> +	struct device *fbdev = kobj_to_dev(kobj);
>  	struct fb_info *fb_info = dev_get_drvdata(fbdev);
>  	struct dlfb_data *dlfb = fb_info->par;
>  	int ret;
> 
