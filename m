Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3769DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02FF2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W5nSRs7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgH0D1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:27:03 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58028 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH0D1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:27:02 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200827032658epoutp04c5e2d8415ff09bbfc1fe4b5c3a956faf~vAjTKZJ-j2856428564epoutp045
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 03:26:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200827032658epoutp04c5e2d8415ff09bbfc1fe4b5c3a956faf~vAjTKZJ-j2856428564epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598498818;
        bh=U76Vdtc7EDVWhqSvRaNyZOwX1cE/x5mdcyecTRFpnuI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W5nSRs7jkS+BZOba32IyyWKCk0+Jt7Gv70iSarL5Gma6rO33Mi+LxqK9LMMDh6Nfh
         pcXHJvq/8C1fyFbyz07X/J4tIhG3DllWLaJF/6f8KZk/WSVe9KjlM3cG/KsGCTv47R
         Zwxq7yd0iLjbBiHVZbI3j4m44A7QW2Zsacjxud+o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200827032657epcas1p3f3ace6d41dade59aba39fab5707f0354~vAjShAP8f0956209562epcas1p3P;
        Thu, 27 Aug 2020 03:26:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BcSnq4PTLzMqYkZ; Thu, 27 Aug
        2020 03:26:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.ED.18978.FF7274F5; Thu, 27 Aug 2020 12:26:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200827032654epcas1p2b00fa3f451b029a211530916c8498873~vAjPgxCNO2982229822epcas1p2g;
        Thu, 27 Aug 2020 03:26:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200827032654epsmtrp23b7960c41672b94b487cfaf3ff21f79e~vAjPfwIYV2007320073epsmtrp2T;
        Thu, 27 Aug 2020 03:26:54 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-a9-5f4727ff3390
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.A6.08303.EF7274F5; Thu, 27 Aug 2020 12:26:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200827032654epsmtip23dc4e3a6970ef64beedbf011b519f219~vAjPSRgiZ1840218402epsmtip2Z;
        Thu, 27 Aug 2020 03:26:54 +0000 (GMT)
Subject: Re: [PATCH v2] extcon: ptn5150: Deduplicate parts of
 dev_err_probe()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7441c256-d680-ed47-e29d-3eb7d89e8566@samsung.com>
Date:   Thu, 27 Aug 2020 12:39:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200826152341.56741-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTQPe/unu8wcc5yha9TdOZLM6f38Bu
        cXnXHDaL240r2Cxe7p/O6sDqsXPWXXaPTas62TzmnQz06NuyitHj8ya5ANaobJuM1MSU1CKF
        1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoN1KCmWJOaVAoYDE4mIl
        fTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8XCtDAwMjU6DChOyMxsXz2AruClac
        2beOrYFxAl8XIyeHhICJRNO0JnYQW0hgB6PEt5/ZXYxcQPYnRombbQeYIJzPjBIPr75m62Lk
        AOvoPF0B0bCLUeLA6ziImveMErN3b2MGSQgL+Es0zmwGaxYRaGCUuPPgOAtIglkgVmLNwptg
        69gEtCT2v7jBBmLzCyhKXP3xmBHE5hWwk2j7fYUVZBmLgKrE4vVgraICYRInt7VAlQhKnJz5
        BCzOKeAu8XwDSDnIeHGJW0/mM0HY8hLb385hBrlBQqCTQ+LLimWsEC+7SPxtaGODsIUlXh3f
        wg5hS0l8frcXKl4tsfLkETaI5g5GiS37L0A1G0vsXzqZCeQ4ZgFNifW79CHCihI7f89lhFjM
        J/Huaw8rJLB4JTrahCBKlCUuP7jLBGFLSixu72SbwKg0C8k7s5C8MAvJC7MQli1gZFnFKJZa
        UJybnlpsWGCIHNebGMGpUst0B+PEtx/0DjEycTAeYpTgYFYS4RW86BwvxJuSWFmVWpQfX1Sa
        k1p8iNEUGL4TmaVEk/OByTqvJN7Q1MjY2NjCxNDM1NBQSZz34S2FeCGB9MSS1OzU1ILUIpg+
        Jg5OqQamgly1i3vqCiTbEhotOwr2XN/YsjLktPhO7hkFbHf3/+YxOlMxd9P+T1In9jqovms6
        lvHsyoQXaSVqi5YrXEtv2ct3R3Hneq7EVqm5nTJfPWxe/02JZbgfenWCvYn3jqMi06+VO0YW
        WnOsOGq3T+LtAgOLd7GzRWYvDWBT+zrfbW3QDIPvm59bT457N9mJq3KyadLjTc86az7qHFF/
        O32ewOXuvIVszw59Uphx4e/aP7tYvn2/GS/+kIM1ueFSbQM7v10R3+ypj/7Ocv2t5uxwIGJJ
        tMBF3Qv6nS5mZz7+ZF+zi9uNuytx9ZOqmM0WGXlTo7MqZTz2ro9vPJauf4SvIlp4tX78K+kr
        3wMT/6W8UmIpzkg01GIuKk4EAJe4qhAeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvO4/dfd4g1mzZCx6m6YzWZw/v4Hd
        4vKuOWwWtxtXsFm83D+d1YHVY+esu+wem1Z1snnMOxno0bdlFaPH501yAaxRXDYpqTmZZalF
        +nYJXBmNi+exFdwVrDizbx1bA+MEvi5GDg4JAROJztMVXYxcHEICOxglVj3+zNrFyAkUl5SY
        dvEoM0SNsMThw8UgYSGBt4wSbS9lQWxhAV+JzsbZzCC9IgINjBKzl/1nBEkwC8RKHJy8iAVi
        6CxGidZ5L8ASbAJaEvtf3GADsfkFFCWu/ngMFucVsJNo+32FFWQZi4CqxOL1LCBhUYEwiZ1L
        HjNBlAhKnJz5BCzOKeAu8XzDFVaIXeoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPwLCTts5C0
        zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFRo6W1g3HPqg96hxiZ
        OBgPMUpwMCuJ8ApedI4X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvt11sI4IYH0xJLU7NTUgtQi
        mCwTB6dUA1Npi8ZyW/FFpWHOy6Lml8W9/7bg64E9ElIOu767Cx/M1TZpK/v0T9Y1zXrXivD3
        uY0smZrzX03c5Prk+N5p6Vs+n78afWqz0Nent3aVno1LdVM6ZPBY8122/0/bI5NZdjJILzzs
        IS3SLMbL0p2b3vK/3/XXyZPB5UemHErzrb2ixrPzd+/j2JsV2xnebpFOs9jdZpKuV6/vUpJs
        Z5J+uu51EtuDXbHOqaEPqtTmuhyK7L+2Ler4LJEPVUxZ87ZyiMWHR9jXb8vVaPx+9WCX0Lsf
        gf9U6gJX/bv0s/mr3k7jhj4JsZ7OH7GTq1/o+uz5LnrhUSR7m9nG+o7MXuWDP9+m/ro7mdVu
        b0cii7P2WSWW4oxEQy3mouJEAO3r8HMJAwAA
X-CMS-MailID: 20200827032654epcas1p2b00fa3f451b029a211530916c8498873
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200826152348epcas1p28c09ca69c54287c9c55f5403f2c0e4a1
References: <CGME20200826152348epcas1p28c09ca69c54287c9c55f5403f2c0e4a1@epcas1p2.samsung.com>
        <20200826152341.56741-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 8/27/20 12:23 AM, Andy Shevchenko wrote:
> dev_err_probe() is designed to be used like
> 
> 	return dev_err_probe(dev, ret, "Error message\n");
> 
> Hence no need to have a separate return statement. Besides that
> dev_err_probe() prints already returned error code, no need to repeat
> that either.
> 
> Cc: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> v2: dropped Fixed tag (Krzysztof)
>  drivers/extcon/extcon-ptn5150.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 8ba706fad887..051bf374b43f 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -242,8 +242,7 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  			dev_info(dev, "No VBUS GPIO, ignoring VBUS control\n");
>  			info->vbus_gpiod = NULL;
>  		} else {
> -			dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
> -			return ret;
> +			return dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
>  		}
>  	}
>  
> @@ -253,10 +252,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  
>  	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
>  	if (IS_ERR(info->regmap)) {
> -		ret = PTR_ERR(info->regmap);
> -		dev_err_probe(info->dev, ret, "failed to allocate register map: %d\n",
> -			      ret);
> -		return ret;
> +		return dev_err_probe(info->dev, PTR_ERR(info->regmap),
> +				     "failed to allocate register map\n");
>  	}
>  
>  	if (i2c->irq > 0) {
> @@ -264,9 +261,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  	} else {
>  		info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
>  		if (IS_ERR(info->int_gpiod)) {
> -			ret = PTR_ERR(info->int_gpiod);
> -			dev_err_probe(dev, ret, "failed to get INT GPIO\n");
> -			return ret;
> +			return dev_err_probe(dev, PTR_ERR(info->int_gpiod),
> +					     "failed to get INT GPIO\n");
>  		}
>  
>  		info->irq = gpiod_to_irq(info->int_gpiod);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
