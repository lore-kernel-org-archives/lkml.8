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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903CC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7863B206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AuwiE49e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgGJOYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:24:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55224 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgGJOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:24:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710142406euoutp01c6c28150a997532977adc05d509a9161~gajWfuw8k3221032210euoutp01c
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710142406euoutp01c6c28150a997532977adc05d509a9161~gajWfuw8k3221032210euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594391046;
        bh=PJaw4qA6aoVbSe+NmWHswntCdkvYkMsimoVlG4G6jVg=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=AuwiE49ecbGMxnfmFmEauXqDbuaFLWSjFkACjlKuUQPB7uLFmOxX0wN+cM2Trl7Cr
         qNb3mMIz3Fw87hDNvdv7uhB2RMZbWFLcjJCTrVz2uWPNJSkw5zQ9l+4koWW0sfG+CM
         OutqCkgK3zp6J3LPzboQroN1TFkbEGoWF3TKh7nQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710142406eucas1p2c2986735d9cb892535dbd1e04b2b0ea4~gajWO485K0956909569eucas1p2I;
        Fri, 10 Jul 2020 14:24:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.DE.06318.60A780F5; Fri, 10
        Jul 2020 15:24:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200710142406eucas1p16bb32654aa14bf6f6b6b2cb7bb64521c~gajWA9VJa0592905929eucas1p1j;
        Fri, 10 Jul 2020 14:24:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710142406eusmtrp182d50e203d03256a2d8f59c7c8210ce3~gajWAPcGB1135411354eusmtrp1u;
        Fri, 10 Jul 2020 14:24:06 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-58-5f087a06baf9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.E1.06314.60A780F5; Fri, 10
        Jul 2020 15:24:06 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200710142405eusmtip126ac62dd2a90a7172719131e8ae07076~gajVp85MC0341503415eusmtip1V;
        Fri, 10 Jul 2020 14:24:05 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] fbdev: sm712fb: set error code in probe
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Message-ID: <6f500a1e-96d8-2238-ad26-99a39dca61ec@samsung.com>
Date:   Fri, 10 Jul 2020 16:24:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200706155328.8396-1-novikov@ispras.ru>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/Ze9jqavE7Ng0bBJKXIG0YME8sI25coP2WS6dIXtdwmm1r6
        aUJemGnmvSF5S2e2vE5NSa1FLR1JWamUooSyWcqsKaE4yflO8tvvXP7P/5zDQ2GCLsKbSpVl
        MAqZJE1I8vC+dxvjAWQOFR+sa3YXfVm3kiJtkRoXvS9ZJUSfB2tJUdOwiit6ZarARLonL9E5
        rnhAM8sV12xXIvHMLzshnisycsTmuUVSbOs+coWM5YUnMWmpWYwiKCKBl1JhHEfpDdRdTUcZ
        pkKTpBq5UECfgirLGKFGPEpAtyJ4UGx2BmsI/rY1OQMbAl3dV86epLtxFLEFLYKRgUYOG6wg
        sG1tch1dJB0GDwvakIPd6XCYap7DHexB+4Eqb3SXMfo7gqFFPwfz6QjomqjCHIzTx0BX3Us4
        2JOOgT/zbwi2xw1GHy3sal3o02D5WEOw73jBt4U6DstHoX+lFnMMBLSBC0VWs3PsCzCf14hY
        doefRj2X5cNgKr+Ps4J2BPZCi1Pdj0Bbvu280xmYGd/cYWrH4jh0DAax6UhomGxFjjTQrjC9
        4sYO4QplfdUYm+ZDYb6A7faDzpZOcs9WPfAUK0VCzb7VNPvW0exbR/Pftx7hbciLyVRKkxll
        qIy5E6iUSJWZsuTARLm0G+18JNO2cf0FGt66aUA0hYQH+fUSKl5ASLKU2VIDAgoTevDPfzDd
        EPCTJNk5jEIer8hMY5QG5EPhQi9+aONSnIBOlmQwtxkmnVHsVTmUi7cKBT5r9TDhg7/7YrT2
        5xexzcjo6E5bm8yeqxsqM10eS054HdH+Vn8yv/fTyFV/7+XSgKUDqz9ibWfNes9rSf6bURZt
        2PXZiUTfQ6uufqEFLYTvgn+xj1VumLo1HzW9cS9P3mGNU/Toaxq2mJURfkhwydLj9OVK81pP
        lcHNNzP3khBXpkhCTmAKpeQfy74840QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7psVRzxBpd3MFtc+fqezWJ5dxeL
        xYm+D6wWl3fNYbNYvK+B3eLA6SnMFmuW7GF0YPfYOesuu8eMf1MZPe68/svqcb/7OJPH8/tP
        2Tw+b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy5hy/BxjwUKOilnrJzE3MF5j62Lk5JAQMJHYtOgkYxcjF4eQwFJGiRsNu1i7GDmAEjIS
        x9eXQdQIS/y51sUGUfOaUeLF0UeMIAk2ASuJie2rwGxhARuJ60vvs4DYIgJqEg2tJ1lAGpgF
        bjNKtK56DbWhk1HizP1WdpAqXgE7iY2XpjGD2CwCqhJrpm9lBbFFBSIkDu+YxQhRIyhxcuYT
        sKmcAmYSLy7MAKthFlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZiFpn4WkZRaSlllIWhYw
        sqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjMBtx35u3sF4aWPwIUYBDkYlHt4FiRzxQqyJ
        ZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGByyCuJNzQ1NLew
        NDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwFiyP81zr8ZzDuvGlMbfqhv+Vj/f
        tsY2OD3q1LoWXn2L1aarPdfVBEWXTOQrXFzmF821bP3C2Pk778nutTmxu3PxV+vTX0MPasZV
        fdwy4cmB9gbbhrkJPEc+RcR9uvp95cQpV+rmRSyVObZTfvKMdqepPr9djETPXhDsTpTQ/LV4
        poD0gnlvSiWUWIozEg21mIuKEwEFZxT+1gIAAA==
X-CMS-MailID: 20200710142406eucas1p16bb32654aa14bf6f6b6b2cb7bb64521c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200706155341eucas1p2081ccd8bd81c097272e13e7fe84244ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200706155341eucas1p2081ccd8bd81c097272e13e7fe84244ee
References: <CGME20200706155341eucas1p2081ccd8bd81c097272e13e7fe84244ee@eucas1p2.samsung.com>
        <20200706155328.8396-1-novikov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/20 5:53 PM, Evgeny Novikov wrote:
> If smtcfb_pci_probe() does not detect a valid chip it cleans up
> everything and returns 0. This can result in various bad things later.
> The patch sets the error code on the corresponding path.
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
>  drivers/video/fbdev/sm712fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 6a1b4a853d9e..fbe97340b8e0 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -1614,7 +1614,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
>  	default:
>  		dev_err(&pdev->dev,
>  			"No valid Silicon Motion display chip was detected!\n");
> -
> +		err = -ENODEV;
>  		goto failed_fb;
>  	}
>  
> 
