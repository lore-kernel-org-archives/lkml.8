Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDEDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F643207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TxOpB36O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbgEYD1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 23:27:03 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42264 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388466AbgEYD1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 23:27:03 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200525032700epoutp0479b4cd9fde878b84f4b8d40b89ec5a18~SJ6fvobkC0254102541epoutp041
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:27:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200525032700epoutp0479b4cd9fde878b84f4b8d40b89ec5a18~SJ6fvobkC0254102541epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590377220;
        bh=o3gUq4zFJOh5zKx/sCBYzTJGdBWtSZiG4a6vdbeS3A4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TxOpB36OWIqw3qRo5BHLTO5R807oTq5JIMi4vCAuJScoFB1RAO8X1qRgX9zOXE4mv
         pGSKU0KR6JvlKtV6KWGEMLGDxsJGj6heZFp9FIL1uQ+uR9HN9mlZucb+/DhMS+HGSz
         4q3DilBJTfltOHdhIxv05WN50Ebhrae4yHBxu/qc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200525032700epcas1p462d628ccfc5371e8af29379b916c9bd5~SJ6fhFN7e1340113401epcas1p4W;
        Mon, 25 May 2020 03:27:00 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49VjFG0XSTzMqYkj; Mon, 25 May
        2020 03:26:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.5C.04395.CFA3BCE5; Mon, 25 May 2020 12:26:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200525032652epcas1p3aa7e62b1308ed517d2ce9b4bd64b4a03~SJ6YG_4ub1059810598epcas1p3r;
        Mon, 25 May 2020 03:26:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200525032652epsmtrp1200b47bbf84187d1e453c7e1b6e40b07~SJ6YGYFr62020820208epsmtrp1Q;
        Mon, 25 May 2020 03:26:52 +0000 (GMT)
X-AuditID: b6c32a39-f63ff7000000112b-2a-5ecb3afcbad3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.6D.08382.CFA3BCE5; Mon, 25 May 2020 12:26:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200525032652epsmtip13dd0b6700c5e5aa42cba7467c330e55d~SJ6X7z5Hi1511015110epsmtip1E;
        Mon, 25 May 2020 03:26:52 +0000 (GMT)
Subject: Re: [PATCH] [v2] extcon: arizona: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4a97ca96-0c0c-e895-ba03-9987b59229da@samsung.com>
Date:   Mon, 25 May 2020 12:37:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200523061726.25903-1-dinghao.liu@zju.edu.cn>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmru4fq9NxBl9e61ts/97IYnFi3ll2
        i8u75rBZ3G5cwWbx+f1+VgdWj+lz/jN69G1ZxehxdWETu8fnTXIenbvesgWwRmXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ5zeM5O9YKlE
        xa7JC9kaGCcIdzFyckgImEg0fTnIAmILCexglDg8O6KLkQvI/sQocfbUATYI5xujRNv9naww
        HZ8ObWGFSOxllLj3bx8ThPOeUeL5mzVgs4QFfCRuNUxgA7FFBMwkts9exQhiMwtkSTzccg9s
        EpuAlsT+FzfAavgFFCWu/ngMVsMrYCdxY+oWsDiLgKpEy7PNzCC2qECYxMltLVA1ghInZz4B
        2sXBwSlgI/HwlyvEeHGJW0/mM0HY8hLb385hBrlNQqCTQ+L//aUsEB+4SDx6/p0dwhaWeHV8
        C5QtJfGyvw3KrpZYefIIG0RzB6PElv0XoN43lti/dDITyGJmAU2J9bv0IcKKEjt/z4X6kU/i
        3dceVpASCQFeiY42IYgSZYnLD+4yQdiSEovbO9kmMCrNQvLNLCQvzELywiyEZQsYWVYxiqUW
        FOempxYbFpgiR/YmRnC61LLcwXjsnM8hRgEORiUe3oCpp+KEWBPLiitzDzFKcDArifC6uwGF
        eFMSK6tSi/Lji0pzUosPMZoCA3sis5Rocj4wleeVxBuaGhkbG1uYGJqZGhoqifNOvZ4TJySQ
        nliSmp2aWpBaBNPHxMEp1cA4+dvdiUF+3O83SARv6V17cOLifWusv/AtesHL+vy0pfa6Zcuu
        6J1tzDfrP7Ka9+aBmLtzVl5gE1E6ca/6feyTE9zXJJyfhxyfcKpL/72kLHPUkgVOD9+f2WRR
        7rxirXzGesXMgs9NYlyPjv67wvWC8e2RVUX/FgXGKfheeJuluE3/09dcI9GvtkosxRmJhlrM
        RcWJAC5vbjitAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO4fq9NxBt8WiVls/97IYnFi3ll2
        i8u75rBZ3G5cwWbx+f1+VgdWj+lz/jN69G1ZxehxdWETu8fnTXIenbvesgWwRnHZpKTmZJal
        FunbJXBlnN4zk71gqUTFrskL2RoYJwh3MXJySAiYSHw6tIUVxBYS2M0ocXKvAERcUmLaxaPM
        XYwcQLawxOHDxV2MXEAlbxklPq1axwRSIyzgI3GrYQIbiC0iYCaxffYqRhCbWSBLouf6NEaI
        hn5GicYH85lBEmwCWhL7X9wAa+AXUJS4+uMxWAOvgJ3EjalbwOIsAqoSLc82g9WLCoRJ7Fzy
        mAmiRlDi5MwnLCAHcQrYSDz85QqxS13iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSehaR7FpKW
        WUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhutDR3MG5f9UHvECMT
        B+MhRgkOZiURXne3U3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0tSC2C
        yTJxcEo1MF1cIcauuU9VSuzyDxte1kpXjq7LZzTCQia5+wlM9ytc6FtudmzDSuW1Se53tgut
        3Ph4QkaoZMGbP09eHTVO8nIPZnLnmVpn/e3fjE+bNiksP59xPOzozr1hjtcKDt0++KiHeYvY
        ta+utRu7lXd8NnDeFzCXT6nhclDpzRz3XYd41TOMmzS5Ky94nL12cr/nYxbzxj0vd5UdL1Kv
        9xQRn3lT2H7tNBavivXt1nExszICOJ22HDhhH3N30mvHw33ywoqhL5m29OpoC+Twzr2xWTdv
        2fQ7FWXvbJ9wyp7jL7J8ev+r4ye++T7FDwq29PrULbr37u41BjMTkZdtiTY8u6W4OM8zL/y+
        M2ryI8NMcSWW4oxEQy3mouJEABTmTP4KAwAA
X-CMS-MailID: 20200525032652epcas1p3aa7e62b1308ed517d2ce9b4bd64b4a03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200523061738epcas1p3de3e68c28c0dc34f1ef7c873ff396cd5
References: <CGME20200523061738epcas1p3de3e68c28c0dc34f1ef7c873ff396cd5@epcas1p3.samsung.com>
        <20200523061726.25903-1-dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao Liu,

On 5/23/20 3:17 PM, Dinghao Liu wrote:
> When arizona_request_irq() returns an error code, a
> pairing runtime PM usage counter decrement is needed
> to keep the counter balanced. For error paths after
> this function, things are the same.
> 
> Also, remove calls to pm_runtime_disable() when
> pm_runtime_enable() has not been executed.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Add a new label "err_pm" to balance refcount.
>       Remove 3 calls to pm_runtime_disable().
>       Move pm_runtime_put() from the front of
>       input_register_device() to the back.
> ---
>  drivers/extcon/extcon-arizona.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 7401733db08b..aae82db542a5 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -1460,7 +1460,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  	if (!info->input) {
>  		dev_err(arizona->dev, "Can't allocate input dev\n");
>  		ret = -ENOMEM;
> -		goto err_register;
> +		return ret;
>  	}
>  
>  	info->input->name = "Headset";
> @@ -1492,7 +1492,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  		if (ret != 0) {
>  			dev_err(arizona->dev, "Failed to request GPIO%d: %d\n",
>  				pdata->micd_pol_gpio, ret);
> -			goto err_register;
> +			return ret;
>  		}
>  
>  		info->micd_pol_gpio = gpio_to_desc(pdata->micd_pol_gpio);
> @@ -1515,7 +1515,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  			dev_err(arizona->dev,
>  				"Failed to get microphone polarity GPIO: %d\n",
>  				ret);
> -			goto err_register;
> +			return ret;
>  		}
>  	}
>  
> @@ -1672,7 +1672,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "Failed to get JACKDET rise IRQ: %d\n",
>  			ret);
> -		goto err_gpio;
> +		goto err_pm;
>  	}
>  
>  	ret = arizona_set_irq_wake(arizona, jack_irq_rise, 1);
> @@ -1721,14 +1721,14 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  		dev_warn(arizona->dev, "Failed to set MICVDD to bypass: %d\n",
>  			 ret);
>  
> -	pm_runtime_put(&pdev->dev);
> -
>  	ret = input_register_device(info->input);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Can't register input device: %d\n", ret);
>  		goto err_hpdet;
>  	}
>  
> +	pm_runtime_put(&pdev->dev);
> +
>  	return 0;
>  
>  err_hpdet:
> @@ -1743,10 +1743,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  	arizona_set_irq_wake(arizona, jack_irq_rise, 0);
>  err_rise:
>  	arizona_free_irq(arizona, jack_irq_rise, info);
> +err_pm:
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  err_gpio:
>  	gpiod_put(info->micd_pol_gpio);
> -err_register:
> -	pm_runtime_disable(&pdev->dev);
>  	return ret;
>  }
>  
> 

Applied it. Thanks. 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
