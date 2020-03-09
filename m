Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E7C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10FB20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U1S9abl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCIAlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 20:41:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:15732 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgCIAlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 20:41:04 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200309004101epoutp0238f01e9c5e2fc06eb6ae03feca9a175c~6e_lxArd11286912869epoutp02s
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 00:41:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200309004101epoutp0238f01e9c5e2fc06eb6ae03feca9a175c~6e_lxArd11286912869epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583714461;
        bh=XZ9yoeNX+hkQonqKUDRvDFm0GYq1xg16IKUz5yY2Agg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U1S9abl/M9uAQuxA6mcrhyCxx1h/ZmK/61fJjbAwYswoYazXmoHm+wSwYqARcha9q
         Y893G1zvo0uvUHMzDqc7d59P43x2UpizXiai+9CLPg/TWhP6jXezBPE84u0c6/de/t
         JQyGy7esVyZSy+fnvVi5L5Xfe2epwsKhHYpYckGU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200309004100epcas1p3e13fae332c5d0350ab3e4b092091110e~6e_k6cll71944319443epcas1p3h;
        Mon,  9 Mar 2020 00:41:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48bKCF5TBfzMqYkZ; Mon,  9 Mar
        2020 00:40:57 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.7A.48019.890956E5; Mon,  9 Mar 2020 09:40:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200309004056epcas1p264978098770f6a81ea6d7a9c1c1df256~6e_hACnr33000430004epcas1p2g;
        Mon,  9 Mar 2020 00:40:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200309004056epsmtrp1720d241cefb1d59063b2a4f3468e626e~6e_g-JLgC2492024920epsmtrp1F;
        Mon,  9 Mar 2020 00:40:56 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-71-5e659098584f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.FD.10238.890956E5; Mon,  9 Mar 2020 09:40:56 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200309004056epsmtip22b2048432a3af7077f66fa5ae195b41e~6e_gqbYL42713127131epsmtip2d;
        Mon,  9 Mar 2020 00:40:56 +0000 (GMT)
Subject: Re: [PATCH] drm/exynos: Fix memory leak and release IOMMU mapping
 structures
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        kgene@kernel.org, krzk@kernel.org, b.zolnierkie@samsung.com,
        a.hajda@samsung.com, Dietmar.Eggemann@arm.com
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <c69c1163-a75b-6667-1979-f3aa356dc0b4@samsung.com>
Date:   Mon, 9 Mar 2020 09:45:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200304220022.8003-1-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTZxjOd3e9HsTOWxF50yUCly2mJNiepfrpKNkyt5yZ2UiWbW4m1Ev5
        AoT22vQKG+oyhMUodoMOY7rCNk0YQ8KmVAUlMBQTGRp+zZ9xU1A0E5mSaGAubba1PZfx3/O8
        3/PmfZ73+z6ONv7GmrgKJUD8iuwW2HSm55zZmh9uIiXWjvtmfOPHMR3+fGyEwt3hozr8T0+I
        xveaTtL48sI8i+/fmmRw48wcjcfHj+nxaN0fehyduarDl/paWRwe/4nCh+s+0+Nw8yz7ynKp
        65suJA0sHmKkaOc+VupdnNZJU/uHKel426fSFyc6kfQkuqqY+7CysJzIpcSfQxSXt7RCKXMI
        b77jfM1pX2cV88UNeL2Qo8ge4hA2bSnOf6PCnTAv5FTL7qpEqVhWVcFSVOj3VgVITrlXDTgE
        4it1+zb41qiyR61Syta4vJ6NotW61p4Qbq8snwvW074+8eP4dJ2uFv26ugFxHPAFcHwwuwGl
        c0b+FIL2eJzWyGMEwSsxSiOLCOb7DqAGlJbq6J6L6bWDAQRHgpdZjcwjODbSRiVVGfz7cObW
        n6mDFXw3gutdp1GS0PwMgn3Rg0xSxfIvQahjik1iA18EU8PfpzDDvwgPwhN00mEmvxUuLsia
        5HkY+eoukyyn8RjafxGTZZrPght3v6U0nA31J1tSGYDv0cOFnqeUZnsTBEPtrIYz4MHwCb2G
        TTDbuEevNdQjCIUvUhrZi+DmzDVGU9lg8LtmKjmZ5s1wtM+ilXPhdOxrpE1+Dh4tBHXaVg2w
        d49RkwhwfvL6s9UBTLSFnnmQYHI2zjSh3MiSaJEleSJL8kT+H3wIMZ1oJfGpnjKiir6Cpdcd
        RamXnYdPof6xLUOI55CwzDCdTUqMOrlarfEMIeBoYYVhd56rxGgolWt2EL/X6a9yE3UI2ROL
        D9GmTJc38U+UgFO0r7XZbLhAXGcXRSHLcPsDc4mRL5MDpJIQH/H/10dxaaZa9HLwrKu/d3mx
        bZv3yO+R/R07c2OWuPOF1idPW5TRhzXNm69lZGWeO3vhbcdul6/3LUuWeDC4K65O+He4Y04O
        Br9c3Hj49VhL/MzqmLly9Pyl9Q/vCNtfze7+ZFg80Fpk/msVpFf/YNm22fSectORW2ud+3nn
        u393NO4q7B+4+lF0a6HAqOWymEf7Vflf7AsHAu8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvO6MCalxBrPn8lncWneO1aL33Ekm
        i40z1rNa/N82kdni6YStzBZXvr5ns3hx7yKLRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz
        mHF+H5PFwqYWdosZk1+yOfB7rJm3htFj77cFLB6bVnWyeWz/9oDV4373cSaPzUvqPfq2rGL0
        +LxJLoAjissmJTUnsyy1SN8ugSvjdU8zc8Euw4o/D5pYGxhvq3cxcnJICJhIbHz9m72LkYtD
        SGA3o8SzU7eAHA6ghITElq0cEKawxOHDxRAlbxklrj9rYgHpFRYIlzhw7zsbSEJEYCOjxPzz
        K1hAHGaBx4wSzVvOMkO0dDNKrJnRzQbSwiagKjFxxX0wm1fATuL+8eVgNouAisSrGReYQWxR
        gQiJ59tvMELUCEqcnPmEBeQMTgELiWWXDEHCzALqEn/mXWKGsMUlbj2ZzwRhy0s0b53NPIFR
        aBaS7llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgGNXS3MF4
        eUn8IUYBDkYlHt4H8qlxQqyJZcWVuYcYJTiYlUR4G7WS44R4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpg1FgpPOPbvr+LGniqVa8+mGpvN02l2ezbqtdy
        /A98P8WXyjsE7DxgXPWXgaOnNzrB5+bhbd+qc/ol2XWCf71sf5LKOF+8229fSiKHxSwTTa20
        f7ul2vVnnGwX/25/LNU5tYG3ff35x3ufJdvqXos5Xbhc73mFhcBW0ZSn3ZkfWU/xnzdpn/tT
        iaU4I9FQi7moOBEA86vmLM0CAAA=
X-CMS-MailID: 20200309004056epcas1p264978098770f6a81ea6d7a9c1c1df256
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200304220104epcas1p2d65f8ab31df6aa5373787b695b14f8ff
References: <CGME20200304220104epcas1p2d65f8ab31df6aa5373787b695b14f8ff@epcas1p2.samsung.com>
        <20200304220022.8003-1-lukasz.luba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

20. 3. 5. 오전 7:00에 Lukasz Luba 이(가) 쓴 글:
> There is a memory leak which left some objects not freed. The reference
> counter of mapping: 'mapping->kref' was 2 when calling
> arm_iommu_detach_device(), so the release_iommu_mapping() won't be called.
> Since the old mapping structure is not going to be used any more (because
> it is detached and new one attached), call arm_iommu_release_mapping()
> to trigger cleanup.
> 
> Found using kmemleak detector, the output:
> 
> unreferenced object 0xc2137640 (size 64):
>   comm "swapper/0", pid 1, jiffies 4294937900 (age 3127.400s)
>   hex dump (first 32 bytes):
>     50 a3 14 c2 80 a2 14 c2 01 00 00 00 20 00 00 00  P........... ...
>     00 10 00 00 00 80 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<3acd268d>] arch_setup_dma_ops+0x4c/0x104
>     [<9f7d2cce>] of_dma_configure+0x19c/0x3a4
>     [<ba07704b>] really_probe+0xb0/0x47c
>     [<4f510e4f>] driver_probe_device+0x78/0x1c4
>     [<7481a0cf>] device_driver_attach+0x58/0x60
>     [<0ff8f5c1>] __driver_attach+0xb8/0x158
>     [<86006144>] bus_for_each_dev+0x74/0xb4
>     [<10159dca>] bus_add_driver+0x1c0/0x200
>     [<8a265265>] driver_register+0x74/0x108
>     [<e0f3451a>] exynos_drm_init+0xb0/0x134
>     [<db3fc7ba>] do_one_initcall+0x90/0x458
>     [<6da35917>] kernel_init_freeable+0x188/0x200
>     [<db3f74d4>] kernel_init+0x8/0x110
>     [<1f3cddf9>] ret_from_fork+0x14/0x20
>     [<8cd12507>] 0x0
> unreferenced object 0xc214a280 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294937900 (age 3127.400s)
>   hex dump (first 32 bytes):
>     00 a0 ec ed 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<3acd268d>] arch_setup_dma_ops+0x4c/0x104
>     [<9f7d2cce>] of_dma_configure+0x19c/0x3a4
>     [<ba07704b>] really_probe+0xb0/0x47c
>     [<4f510e4f>] driver_probe_device+0x78/0x1c4
>     [<7481a0cf>] device_driver_attach+0x58/0x60
>     [<0ff8f5c1>] __driver_attach+0xb8/0x158
>     [<86006144>] bus_for_each_dev+0x74/0xb4
>     [<10159dca>] bus_add_driver+0x1c0/0x200
>     [<8a265265>] driver_register+0x74/0x108
>     [<e0f3451a>] exynos_drm_init+0xb0/0x134
>     [<db3fc7ba>] do_one_initcall+0x90/0x458
>     [<6da35917>] kernel_init_freeable+0x188/0x200
>     [<db3f74d4>] kernel_init+0x8/0x110
>     [<1f3cddf9>] ret_from_fork+0x14/0x20
>     [<8cd12507>] 0x0
> unreferenced object 0xedeca000 (size 4096):
>   comm "swapper/0", pid 1, jiffies 4294937900 (age 3127.400s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<3acd268d>] arch_setup_dma_ops+0x4c/0x104
>     [<9f7d2cce>] of_dma_configure+0x19c/0x3a4
>     [<ba07704b>] really_probe+0xb0/0x47c
>     [<4f510e4f>] driver_probe_device+0x78/0x1c4
>     [<7481a0cf>] device_driver_attach+0x58/0x60
>     [<0ff8f5c1>] __driver_attach+0xb8/0x158
>     [<86006144>] bus_for_each_dev+0x74/0xb4
>     [<10159dca>] bus_add_driver+0x1c0/0x200
>     [<8a265265>] driver_register+0x74/0x108
>     [<e0f3451a>] exynos_drm_init+0xb0/0x134
>     [<db3fc7ba>] do_one_initcall+0x90/0x458
>     [<6da35917>] kernel_init_freeable+0x188/0x200
>     [<db3f74d4>] kernel_init+0x8/0x110
>     [<1f3cddf9>] ret_from_fork+0x14/0x20
>     [<8cd12507>] 0x0
> unreferenced object 0xc214a300 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294937900 (age 3127.400s)
>   hex dump (first 32 bytes):
>     00 a3 14 c2 00 a3 14 c2 00 40 18 c2 00 80 18 c2  .........@......
>     02 00 02 00 ad 4e ad de ff ff ff ff ff ff ff ff  .....N..........
>   backtrace:
>     [<08cbd8bc>] iommu_domain_alloc+0x24/0x50
>     [<b835abee>] arm_iommu_create_mapping+0xe4/0x134
>     [<3acd268d>] arch_setup_dma_ops+0x4c/0x104
>     [<9f7d2cce>] of_dma_configure+0x19c/0x3a4
>     [<ba07704b>] really_probe+0xb0/0x47c
>     [<4f510e4f>] driver_probe_device+0x78/0x1c4
>     [<7481a0cf>] device_driver_attach+0x58/0x60
>     [<0ff8f5c1>] __driver_attach+0xb8/0x158
>     [<86006144>] bus_for_each_dev+0x74/0xb4
>     [<10159dca>] bus_add_driver+0x1c0/0x200
>     [<8a265265>] driver_register+0x74/0x108
>     [<e0f3451a>] exynos_drm_init+0xb0/0x134
>     [<db3fc7ba>] do_one_initcall+0x90/0x458
>     [<6da35917>] kernel_init_freeable+0x188/0x200
>     [<db3f74d4>] kernel_init+0x8/0x110
>     [<1f3cddf9>] ret_from_fork+0x14/0x20
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> 
> Hi all,
> 
> I have discovered this issue on OdroidXU4 while running some stress tests
> for upcoming Energy Model. To reproduce it, kernel must be compiled with
> DEBUG_KMEMLEAK. When the boot has finished, type:
> # echo scan > /sys/kernel/debug/kmemleak
> # cat /sys/kernel/debug/kmemleak
> You should expect similar output to the one from the commit message.
> 
> I don't know if it should go via stable tree as well. I can resend with CC
> stable, if there is a need.

Thanks for fixup. BTW, as you commented on Marek's patch thread, with Marek's patch the memory leak will be solved.
Do you want Marek to rework his patch on top of your patch or are you ok me to pick up only Marek's one?

Marek's patch is conflicted with your one.

Thanks,
Inki Dae

> 
> Regards,
> Lukasz Luba
> 
>  drivers/gpu/drm/exynos/exynos_drm_dma.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
> index 9ebc02768847..45f209ec107f 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
> @@ -74,8 +74,13 @@ static int drm_iommu_attach_device(struct drm_device *drm_dev,
>  		return ret;
>  
>  	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
> -		if (to_dma_iommu_mapping(subdrv_dev))
> +		struct dma_iommu_mapping *mapping =
> +					to_dma_iommu_mapping(subdrv_dev);
> +
> +		if (mapping) {
>  			arm_iommu_detach_device(subdrv_dev);
> +			arm_iommu_release_mapping(mapping);
> +		}
>  
>  		ret = arm_iommu_attach_device(subdrv_dev, priv->mapping);
>  	} else if (IS_ENABLED(CONFIG_IOMMU_DMA)) {
> 
