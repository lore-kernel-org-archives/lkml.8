Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F09AC433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2762C206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BhswSfmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgGJOXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:23:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55107 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgGJOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:23:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710142347euoutp01b693d8926c859399eb75b3cce030bfd1~gajEnD16H3221032210euoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:23:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710142347euoutp01b693d8926c859399eb75b3cce030bfd1~gajEnD16H3221032210euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594391027;
        bh=PlstbiKm3cPwBADaMmi2+Qk5ARIjmu4xkazEWUSOlNc=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=BhswSfmuQT3d4MpZsCmmA0ftTpOZ4Sl+Kn0NN3NoNfdvB/EaiB8o1nnEEY/M9fSMn
         g1FbIP6yG0syIm0+vNUyboP5NwmQlo1LGtfcMecI6LQCfJI15DjC492dzftW5tPwzr
         NRkEe2PZ6qyszkCjqrTPjLDZ7CXhWnUpTQz/i2qI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710142347eucas1p25a6f07f3ae8266c670aa28e413879fed~gajEW9WTe0258602586eucas1p25;
        Fri, 10 Jul 2020 14:23:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.66.05997.3F9780F5; Fri, 10
        Jul 2020 15:23:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200710142346eucas1p13f359ce9c4fcefd5e1a0bad646b5b6b3~gajD1ATwg0594505945eucas1p1M;
        Fri, 10 Jul 2020 14:23:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200710142346eusmtrp251b10a2890712073504e3c9a3da66be1~gajD0ejmk1267512675eusmtrp2n;
        Fri, 10 Jul 2020 14:23:46 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-6a-5f0879f3a4be
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.71.06017.2F9780F5; Fri, 10
        Jul 2020 15:23:46 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710142346eusmtip291012f45757c9f62751624657cdf4e8c~gajDfPGNl1514315143eusmtip2B;
        Fri, 10 Jul 2020 14:23:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: savage: fix memory leak on error handling
 path in probe
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Message-ID: <8ea4d604-3d42-7d73-f19a-5699635c362b@samsung.com>
Date:   Fri, 10 Jul 2020 16:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200619162136.9010-1-novikov@ispras.ru>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7qfKzniDf4uYbH42f2FzeLK1/ds
        Fsu7u1gsTvR9YLW4vGsOm8XifQ3sDmweO2fdZfeY8W8qo8ed139ZPe53H2fy+LxJLoA1issm
        JTUnsyy1SN8ugSvj1tHXTAVLuCs+fJnN3MC4jLOLkZNDQsBEYv7Nu4xdjFwcQgIrGCW6b35l
        BkkICXxhlOg4rweR+Mwo8fvNPxaYjiPv/jBBJJYzSmy58QXKecsocejBdrAqNgEriYntqxhB
        bGGBGIm3x96DxUUE1CQaWk+ygDQwCyxllPg5fS4rSIJXwE7i6IKjYA0sAqoScz/cYwOxRQUi
        JD49OAxVIyhxcuYToGYODk4BM4nWh0kgYWYBcYlbT+YzQdjyEtvfzmEGmS8hsIldYt2Zdcwg
        9RICLhJ3r8VDfCAs8er4FnYIW0bi/875TBD16xgl/na8gGreziixfPI/Nogqa4k7536xgQxi
        FtCUWL9LHyLsKNH49AI7xHw+iRtvBSFu4JOYtG061FpeiY42IYhqNYkNyzawwazt2rmSeQKj
        0iwkj81C8s0sJN/MQti7gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmDiOf3v+Jcd
        jLv+JB1iFOBgVOLhXZDIES/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhjVZljpCInbZDh5iXXIR1lrmlpybZWumPLi
        2ZnAeHOh758PyLnuPMoltcs8b8FsUb8te9hute9+dS5khceVlt7pW+wnOj+/6aXnzHwrdfK0
        uxpnAzL+Xj2wN3n2+tXtk75crBELyORhfz3jzzu1VLPYh2/sXs2J3vn42Or2k0zZMr6zjtqe
        W7hQiaU4I9FQi7moOBEA1daJKDgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7qfKjniDba0Kln87P7CZnHl63s2
        i+XdXSwWJ/o+sFpc3jWHzWLxvgZ2BzaPnbPusnvM+DeV0ePO67+sHve7jzN5fN4kF8AapWdT
        lF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx6+hrpoIl
        3BUfvsxmbmBcxtnFyMkhIWAiceTdH6YuRi4OIYGljBJrXl1k72LkAErISBxfXwZRIyzx51oX
        G0TNa0aJ55dvsIMk2ASsJCa2r2IEsYUFYiTeHnvPAmKLCKhJNLSeZAFpYAYZuqF7GTtEdyej
        xOW+ZrBuXgE7iaMLjoJ1swioSsz9cI8NxBYViJA4vGMWI0SNoMTJmU9YQC7iFDCTaH2YBBJm
        FlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZiHpnoWkZRaSlllIWhYwsqxiFEktLc5Nzy02
        0itOzC0uzUvXS87P3cQIjLVtx35u2cHY9S74EKMAB6MSD++CRI54IdbEsuLK3EOMEhzMSiK8
        TmdPxwnxpiRWVqUW5ccXleakFh9iNAX6bSKzlGhyPjAN5JXEG5oamltYGpobmxubWSiJ83YI
        HIwREkhPLEnNTk0tSC2C6WPi4JRqYAzJ+f7zzPeWBuO53g99wy3v2/ofczyxYOes2AWlojft
        Fq8Jtz7045nVynX8+aIlKm65QgdsDwjeKJy20vf+nO35p/ZUzd0x5/3zDv+rwdm9Agf8J1QJ
        nxGWOfmgc3mF9Vu2zq/zRNZwntV79uDn/4j9cidEn05ikt0StuTreZXN5Zf6l6bOSDBUYinO
        SDTUYi4qTgQAW1TjSMsCAAA=
X-CMS-MailID: 20200710142346eucas1p13f359ce9c4fcefd5e1a0bad646b5b6b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619162158eucas1p14eb0836fe3079ebc2dedec4b7a821a85
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619162158eucas1p14eb0836fe3079ebc2dedec4b7a821a85
References: <CGME20200619162158eucas1p14eb0836fe3079ebc2dedec4b7a821a85@eucas1p1.samsung.com>
        <20200619162136.9010-1-novikov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/19/20 6:21 PM, Evgeny Novikov wrote:
> savagefb_probe() calls savage_init_fb_info() that can successfully
> allocate memory for info->pixmap.addr but then fail when
> fb_alloc_cmap() fails. savagefb_probe() goes to label failed_init and
> does not free allocated memory. It is not valid to go to label
> failed_mmio since savage_init_fb_info() can fail during memory
> allocation as well. So, the patch free allocated memory on the error
> handling path in savage_init_fb_info() itself.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
> index 3c8ae87f0ea7..3fd87aeb6c79 100644
> --- a/drivers/video/fbdev/savage/savagefb_driver.c
> +++ b/drivers/video/fbdev/savage/savagefb_driver.c
> @@ -2157,6 +2157,8 @@ static int savage_init_fb_info(struct fb_info *info, struct pci_dev *dev,
>  			info->flags |= FBINFO_HWACCEL_COPYAREA |
>  				       FBINFO_HWACCEL_FILLRECT |
>  				       FBINFO_HWACCEL_IMAGEBLIT;
> +		else
> +			kfree(info->pixmap.addr);
>  	}
>  #endif
>  	return err;
> 
