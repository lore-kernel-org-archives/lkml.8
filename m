Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BDC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36EC2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X1kNcKaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgEKBhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:37:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:29720 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgEKBhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:37:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200511013711epoutp03ed268240a02411d8c8129db9d4212a76~N1YneYgaD2211622116epoutp03f
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:37:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200511013711epoutp03ed268240a02411d8c8129db9d4212a76~N1YneYgaD2211622116epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589161031;
        bh=rStNRMpIxVfgkuMVc5ikSktKP/yld5dPBNbE3U3ruzM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=X1kNcKaGFNpaX4cVJ/+LaCgIYDPDPhBReNcdkykUPXXWM7/5b/2c6jtsRUoaIvoma
         UcfffJeOAJjdIphxRiEHsPXCdQaLCcoRi+17f8P02QMnQ5aWe89qFJ6OE8qatt/DQd
         mgl6I3sW8VpNNh1YYbWguvqUlJGZxvJGw0S75rYY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200511013711epcas1p1322a0260f9872eb59bde3f1273d415ae~N1Ym9PZK30619506195epcas1p1k;
        Mon, 11 May 2020 01:37:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49L3Sz6YX3zMqYkw; Mon, 11 May
        2020 01:37:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.7F.04544.24CA8BE5; Mon, 11 May 2020 10:37:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200511013705epcas1p3977ae590f3e7b43c1feabe2e2efa6a84~N1YiM2rFb1607916079epcas1p3D;
        Mon, 11 May 2020 01:37:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200511013705epsmtrp16a9aaca8dcfa56ca4623794f26e6b930~N1YiKpiyE1890818908epsmtrp1R;
        Mon, 11 May 2020 01:37:05 +0000 (GMT)
X-AuditID: b6c32a36-7ffff700000011c0-78-5eb8ac42a3a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.C0.25866.14CA8BE5; Mon, 11 May 2020 10:37:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200511013705epsmtip1de04f4042f5d2d2f48f4bf30d675ef67~N1YiBo5YG1462314623epsmtip1O;
        Mon, 11 May 2020 01:37:05 +0000 (GMT)
Subject: Re: [PATCH] extcon: adc-jack: Fix an error handling path in
 'adc_jack_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        myungjoo.ham@samsung.com, anish198519851985@gmail.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <acc38674-b94d-b738-d737-49b6a4299d25@samsung.com>
Date:   Mon, 11 May 2020 10:47:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200510095303.231635-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmrq7Tmh1xBlfaZC0u3+hitth6cC6r
        RfPi9WwWD5pWMVlsvSVtsWTyfFaLy7vmsFncblzB5sDhsXPWXXaPTas62Tz2z13D7rHkzSFW
        j74tqxg9Pm+S8/h8dz1rAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi
        0rx0veT8XCtDAwMjU6DChOyMRbu2shbs5q1YsHIxSwPjRO4uRk4OCQETieZLlxi7GLk4hAR2
        MEocX36dDcL5xChxdu8WdgjnM6PEgc83mWBa7lx7zwyR2MUo8XzbTaj+94wSGy6fYgepEhaI
        lLj0cj1YlYjABkaJiw93M4IkmAUcJb6cOARmswloSex/cYMNxOYXUJS4+uMxWJxXwE5i4ZWF
        rCA2i4CqxKqtq8GGigqESZzc1gJVIyhxcuYTFhCbU8BFYvbyn0wQ88Ulbj2ZD2XLS2x/Owfs
        CAmBtRwSc09MAmrgAHJcJB6siIN4R1ji1fEt7BC2lMTL/jYou1pi5ckjbBC9HYwSW/ZfYIVI
        GEvsXzqZCWQOs4CmxPpd+hBhRYmdv+dC/cgn8e5rDyvEKl6JjjYhiBJlicsP7kJDUVJicXsn
        2wRGpVlIvpmF5INZSD6YhbBsASPLKkax1ILi3PTUYsMCI+To3sQITrFaZjsYF53zOcQowMGo
        xMMboLAjTog1say4MvcQowQHs5II7/JcoBBvSmJlVWpRfnxRaU5q8SFGU2BgT2SWEk3OB6b/
        vJJ4Q1MjY2NjCxNDM1NDQyVx3qnXc+KEBNITS1KzU1MLUotg+pg4OKUaGJd8ETD71f0k+Nzi
        kPnWn8xkdjVrFcxI31j2g48p0Pbn2a6cp1kMKSf+8jmvmM11Tfn0/PhzDL9dO2tkDrXcYxPj
        5YvdN6/T9r7Y/owjc3TiF7hqVWh+eiA188HMLbMvBp/4f+Cowt/pvoHBltr8/IfUGwruHZmk
        bq4eput84strvtp37sck1ZRYijMSDbWYi4oTAfsHsSbHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnK7jmh1xBjv3mVtcvtHFbLH14FxW
        i+bF69ksHjStYrLYekvaYsnk+awWl3fNYbO43biCzYHDY+esu+wem1Z1snnsn7uG3WPJm0Os
        Hn1bVjF6fN4k5/H57nrWAPYoLpuU1JzMstQifbsEroxFu7ayFuzmrViwcjFLA+NE7i5GTg4J
        AROJO9feM3cxcnEICexglFg3eQkjREJSYtrFo0AJDiBbWOLw4WKImreMEosOXGYGqREWiJS4
        9HI9WLOIwAZGiR/n9zCBJJgFHCW+nDjECNExnVHiWfs8sASbgJbE/hc32EBsfgFFias/HoNt
        4xWwk1h4ZSEriM0ioCqxautqdhBbVCBMYueSx0wQNYISJ2c+YQGxOQVcJGYv/wm1TF3iz7xL
        zBC2uMStJ/Oh4vIS29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5x
        Ym5xaV66XnJ+7iZGcLRpae1g3LPqg94hRiYOxkOMEhzMSiK8y3N3xAnxpiRWVqUW5ccXleak
        Fh9ilOZgURLn/TprYZyQQHpiSWp2ampBahFMlomDU6qBqUXoiNteraV1rY+1HTMXBqn7c4bt
        SNH2zNiWNveXwdmTM7jfLzA4f3jqmcmpR+r0v3EsO5UfXVwrFS+07JfQteerRYuSDCUlPi7O
        NrNb97XN1WB1mkDD9xcx1T8+X/SJ9P6xajVLfm7O01CFGVt/Rq6rZlPWlPjMueSU8h2mjNK4
        2uOdG5nX8AiLbcoM5V8VpvvikpYV70N5gxm34lr+ef0IZZX7nnq+a1KBy3tfDVYutx9RJ35u
        MK2uYVw9/69ygnv67QWKVuaFWxrT45fEc9f/4lnXaKL4/+zSp0aHbeweLdi5sPR+8ZF5px5v
        yn514PBjvvLpc068FlU55Wt9IaXG0aejJSKEbX/V6pSvSizFGYmGWsxFxYkAm8lYxSUDAAA=
X-CMS-MailID: 20200511013705epcas1p3977ae590f3e7b43c1feabe2e2efa6a84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200510095313epcas1p2ee698cfbe023da47555c603260fe2188
References: <CGME20200510095313epcas1p2ee698cfbe023da47555c603260fe2188@epcas1p2.samsung.com>
        <20200510095303.231635-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 6:53 PM, Christophe JAILLET wrote:
> In some error handling paths, a call to 'iio_channel_get()' is not balanced
> by a corresponding call to 'iio_channel_release()'.
> 
> This can be achieved easily by using the devm_ variant of
> 'iio_channel_get()'.
> 
> This has the extra benefit to simplify the remove function.
> 
> Fixes: 19939860dcae ("extcon: adc_jack: adc-jack driver to support 3.5 pi or simliar devices")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch in a more complete version than commit 5a696d9760fe
> ("extcon: adc-jack: Release IIO channel on driver remove") which fixed the
> issue for the remove function only.
> ---
>  drivers/extcon/extcon-adc-jack.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
> index ad02dc6747a4..0317b614b680 100644
> --- a/drivers/extcon/extcon-adc-jack.c
> +++ b/drivers/extcon/extcon-adc-jack.c
> @@ -124,7 +124,7 @@ static int adc_jack_probe(struct platform_device *pdev)
>  	for (i = 0; data->adc_conditions[i].id != EXTCON_NONE; i++);
>  	data->num_conditions = i;
>  
> -	data->chan = iio_channel_get(&pdev->dev, pdata->consumer_channel);
> +	data->chan = devm_iio_channel_get(&pdev->dev, pdata->consumer_channel);
>  	if (IS_ERR(data->chan))
>  		return PTR_ERR(data->chan);
>  
> @@ -164,7 +164,6 @@ static int adc_jack_remove(struct platform_device *pdev)
>  
>  	free_irq(data->irq, data);
>  	cancel_work_sync(&data->handler.work);
> -	iio_channel_release(data->chan);
>  
>  	return 0;
>  }
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
