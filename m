Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DDD20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RxmLMlDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgFAIEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:04:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16518 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgFAIEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:04:30 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200601080427epoutp012274ed6c33197899acebea22473d48b0~UXNvaObQA2746627466epoutp01K
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:04:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200601080427epoutp012274ed6c33197899acebea22473d48b0~UXNvaObQA2746627466epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590998667;
        bh=P7GA9PWjsoMvj3TvzJB3RdkJx43yLm5nxvQQ1bKDWjE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RxmLMlDmcA2EMm6XQlXKN/qpztV+NzN5T7Uk6qgy3O2+IOi9LkOTwy+VTMWwq10qW
         KhBwSZhjZ21F0Qw8EMpM2wNoLl5Dlj9gd+Kc22CO6wPihrvos6bys2qM9vNU3Ruzac
         gswXV3Nx3l/tzrjs2/Lc+OTbQuVVpMnymcbosY9c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601080426epcas1p100e5356dbdcee626c7848626d4624968~UXNucs9HQ2629326293epcas1p1C;
        Mon,  1 Jun 2020 08:04:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49b7484mW3zMqYkY; Mon,  1 Jun
        2020 08:04:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.5C.19033.886B4DE5; Mon,  1 Jun 2020 17:04:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601080423epcas1p16933750793a617b8f2222bce81a76771~UXNr3V2ni2866728667epcas1p15;
        Mon,  1 Jun 2020 08:04:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601080423epsmtrp2cea0b28b39bf7b1c4e09c058285a31ab~UXNr2Du1C2368523685epsmtrp2d;
        Mon,  1 Jun 2020 08:04:23 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-dd-5ed4b6882017
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.04.08382.786B4DE5; Mon,  1 Jun 2020 17:04:23 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200601080423epsmtip27af1f3a3f1b99375067f4c33829c140f~UXNrjg2Df2903429034epsmtip2O;
        Mon,  1 Jun 2020 08:04:23 +0000 (GMT)
Subject: Re: [PATCH v3] drm/exynos: Remove dev_err() on platform_get_irq()
 failure
To:     Tamseel Shams <m.shams@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaik.ameer@samsung.com, krzk@kernel.org, alim.akhtar@samsung.com
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <9e5608ba-a714-8bde-573d-21bd1a70757e@samsung.com>
Date:   Mon, 1 Jun 2020 17:09:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200521142210.17400-1-m.shams@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmgW7HtitxBh0zlCx6z51ksngwbxub
        xf9tE5ktrnx9z2bx4t5FFovz5zewW5xtesNusenxNVaLy7vmsFnMOL+PyeJu62J2iyMPd7Nb
        zJj8ks2B12PvtwUsHptWdbJ5bP/2gNXjfvdxJo/NS+o9+rasYvT4vEkugD0q2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGqq3dLAU72Cte
        PzrG1MD4n7WLkZNDQsBE4kvHQXYQW0hgB6PE2q28XYxcQPYnRoljXz4yQTjfGCXu79sB1MEB
        1vG2ywWiYS+jxPuzEhA17xklenpfgE0SFgiReP34KRtIQkRgFqPE4mfNLCAJZoGLjBLdK4JA
        bDYBVYmJK+6zgdi8AnYSa5+fA7NZBFQkWi73gy0TFYiQOP01EaJEUOLkzCdgYzgFLCWmPd8H
        NVJc4taT+UwQtrxE89bZzBCfHeGQ+LOXF8J2kfj0+BUThC0s8er4FnYIW0ri87u9YHdKCDQz
        SkyccZoJwulglLj7+DoLRJWxxP6lk5lADmIW0JRYv0sfIqwosfP3XEaIxXwS7772QAOIV6Kj
        TQiiREni2MUbjBC2hMSFJRPZIGwPiV8fNjJOYFScheS1WUjemYXknVkIixcwsqxiFEstKM5N
        Ty02LDBCjutNjOB0rGW2g3HS2w96hxiZOBgPMUpwMCuJ8E5WvxQnxJuSWFmVWpQfX1Sak1p8
        iNEUGNYTmaVEk/OBGSGvJN7Q1MjY2NjCxNDM1NBQSZxXTeZCnJBAemJJanZqakFqEUwfEwen
        VANTu4d5xEFFz/gVvJd2XXh29mLamX/7awtEOqPUWpe9P/OLbeGyqbqL9X8sj/G/+tD1nvUR
        oaeTjAv5s/vMq6ucj3+Z8sAw5n2AdqjZovV1CbN0bwfcXnhLfZV7xRv90CPzKv6pvH7y6XR4
        jKProZNn3QrP5W32v8Ug7eL42LDJOPvqtwTDA3u4Upc4WlipG/1YF6WZHPaVbduJw++Xl+o7
        mP5ruOl78E3dX8l3Pw3alD4Kl9/r7GJ3mPlFaesp5hMqb74uk09oWSPs/TrSWfHizmjTt6t5
        xGew6Oe6+DUn8Wpf2F2w2lxujpTbCgeHFfG+2xxeZD4IO2BZxjdvZrsdv5zW7n/TTJ84r7ko
        JWGnxFKckWioxVxUnAgA6ht4wFAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvG77titxBnOm6Fj0njvJZPFg3jY2
        i//bJjJbXPn6ns3ixb2LLBbnz29gtzjb9IbdYtPja6wWl3fNYbOYcX4fk8Xd1sXsFkce7ma3
        mDH5JZsDr8febwtYPDat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAHsUl01Kak5mWWqR
        vl0CV8aqrd0sBTvYK14/OsbUwPiftYuRg0NCwETibZdLFyMXh5DAbkaJ+Xv+s0HEJSS2bOWA
        MIUlDh8uhih5yyjx7s5coBJODmGBEInXj5+C2SICsxgl2j5Wg9jMAhcZJbbuz4No6GGUuNhw
        kQkkwSagKjFxxX2wBl4BO4m1z8+B2SwCKhItl/tZQWxRgQiJ59tvMELUCEqcnPmEBcTmFLCU
        mPZ8HwvEAnWJP/MuMUPY4hK3nsxngrDlJZq3zmaewCg0C0n7LCQts5C0zELSsoCRZRWjZGpB
        cW56brFhgWFearlecWJucWleul5yfu4mRnAEamnuYNy+6oPeIUYmDsZDjBIczEoivJPVL8UJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES571RuDBOSCA9sSQ1OzW1ILUIJsvEwSnVwFSkt3tjrMay
        9x/YFu3m1cru+KMo77gjU9aAZwazurn5swMte2R0fs+aceLxsWc1vw8tOJxRNfn9+8U/Nh3Q
        e3j+V5iKVCF3Uv2CKP7lEyKv+b/8tLvt6oIz9b4HSu/VR9h9X7Bt21Qehp5f/7UfmS18O+dv
        zSWuWfYfjWrzOy9vVck96eYSPXObrsONOeuv3jFxcr7zvuOu0eTL2ncvnLlmk2yxpn36rbSb
        rg9DLnusUZf0mzrhTJbv/xom1lesCxfYZTl1vohw/akzlfngSld3zoK7lnaHOK1etamuMnir
        N/3srt1G/ueaH2w/d9AlwPSR7qk/byUaPY53Or9l3FbAqXD19rTetr1+2vlKNqmnlViKMxIN
        tZiLihMBE8XPgi8DAAA=
X-CMS-MailID: 20200601080423epcas1p16933750793a617b8f2222bce81a76771
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200521143647epcas5p279d486b29125419c67ff96e0b5b1454e
References: <CGME20200521143647epcas5p279d486b29125419c67ff96e0b5b1454e@epcas5p2.samsung.com>
        <20200521142210.17400-1-m.shams@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



20. 5. 21. 오후 11:22에 Tamseel Shams 이(가) 쓴 글:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.

Picked it up.

Thanks,
Inki Dae

> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
> - Changes since v2:
> * Addressed Inki Dae comments
> 
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index fcee33a43aca..03be31427181 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -1498,7 +1498,6 @@ static int g2d_probe(struct platform_device *pdev)
>  
>  	g2d->irq = platform_get_irq(pdev, 0);
>  	if (g2d->irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
>  		ret = g2d->irq;
>  		goto err_put_clk;
>  	}
> 
