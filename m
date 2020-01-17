Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3F0C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2410B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ealh4xOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgAQA5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:57:44 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:38748 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732786AbgAQA5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:57:43 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200117005741epoutp04dc5ac4381e0665c0f229730ae179a927~qhqSqT9fs0528005280epoutp04_
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 00:57:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200117005741epoutp04dc5ac4381e0665c0f229730ae179a927~qhqSqT9fs0528005280epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579222661;
        bh=2YtNRcjk3fmfAqxExx3lDdXzhOaFYJbA2NmlhZCCF8g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ealh4xOagR/9yOg24c5ZZPj37XQKQVDL33sYOHwOnniz5FX9Z/q+uXSUJLTe7r+FO
         9uJTZUqihzla8j5i1Oxy9vOHzinac/J1oj4Q3+GfqUiYhz5bB0O04XSulkd/NfXMZC
         fMG6DOaVpN+A+K6TnzvUF6Gt1L5iKIydBayWlCEI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200117005740epcas1p4dd5fb29789a1c49e83b12bbc1e95bd18~qhqSTMeRW0957909579epcas1p4j;
        Fri, 17 Jan 2020 00:57:40 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47zN2V318LzMqYkn; Fri, 17 Jan
        2020 00:57:38 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.8F.52419.F76012E5; Fri, 17 Jan 2020 09:57:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200117005734epcas1p3a7ab803d3d34efeb864b730371402dd1~qhqMblqzl1233812338epcas1p3c;
        Fri, 17 Jan 2020 00:57:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117005734epsmtrp13ff80474a5b05be9399fc3fa0ea6de96~qhqMa7WHT0556605566epsmtrp1M;
        Fri, 17 Jan 2020 00:57:34 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-c8-5e21067f84fe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.33.06569.E76012E5; Fri, 17 Jan 2020 09:57:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200117005734epsmtip2d6b7378808c38a63ed677ece6a1a3c91~qhqMQ2e7-1345313453epsmtip2L;
        Fri, 17 Jan 2020 00:57:34 +0000 (GMT)
Subject: Re: [PATCH] extcon: Remove unneeded extern keyword from extcon.h
To:     linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2f529cd0-d896-3b71-7224-299969294a3e@samsung.com>
Date:   Fri, 17 Jan 2020 10:04:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200116043947.12556-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTV7eeTTHO4OwnZouJN66wWFzeNYfN
        4nbjCjYHZo9NqzrZPPq2rGL0+LxJLoA5KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB2iRkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
        skCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y/PbFSwFE5QqrvYcZGxgXCHTxcjJISFgIjF1+kPW
        LkYuDiGBHYwSz5v/QzmfGCVm3G5jAakSEvjGKHFolw5Mx8tjD1ggivYyStyafhrKec8o8a35
        GhNIlbCAp8TTJwfBukUEFCQ29z5jBbGZBQwkHl3dB2azCWhJ7H9xgw3E5hdQlLj64zEjiM0r
        YCcxr2EDWJxFQFXi6qdHYPWiAmESJ7e1QNUISpyc+QRsPqeAtcS5tX1sEPPFJW49mc8EYctL
        bH87hxnkOAmBI2wSe86fZIZ4wUViwZ9vLBC2sMSr41vYIWwpiZf9bVB2tcTKk0fYIJo7GCW2
        7L/ACpEwlti/dDLQBg6gDZoS63fpQ4QVJXb+nssIsZhP4t3XHlaQEgkBXomONiGIEmWJyw/u
        MkHYkhKL2zvZJjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxYYI8f2JkZwItQy38G4
        4ZzPIUYBDkYlHt4ZQQpxQqyJZcWVuYcYJTiYlUR4T86QjRPiTUmsrEotyo8vKs1JLT7EaAoM
        7YnMUqLJ+cAknVcSb2hqZGxsbGFiaGZqaKgkzjvDBWiOQHpiSWp2ampBahFMHxMHp1QDYw/r
        E6NPx17uldh/WdwtoMDtQ2Xx+9Dy2uJZvjIMBRG/jq0Vauad96OrppKl0febuZLoDtHAT11/
        7+S4Mt+99eNzj2Uxg77JGpmV956d+Pyp5UHjjbWqz9eGRno/nuRmsbOidA3zj7yvLZX/Qibd
        zJ09+aWcQHa8z4bP5040yj5v3/Lnqc5TXyWW4oxEQy3mouJEAObZTVWaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvG4dm2Kcwel2UYuJN66wWFzeNYfN
        4nbjCjYHZo9NqzrZPPq2rGL0+LxJLoA5issmJTUnsyy1SN8ugStj89sVLAUTlCqu9hxkbGBc
        IdPFyMkhIWAi8fLYA5YuRi4OIYHdjBLbZr1gh0hISky7eJS5i5EDyBaWOHy4GKLmLaPEoRc/
        mUBqhAU8JZ4+OcgCYosIKEhs7n3GCmIzCxhIPLq6jxWioY9RYsKFJrChbAJaEvtf3GADsfkF
        FCWu/njMCGLzCthJzGvYABZnEVCVuPrpEdggUYEwiZ1LHjNB1AhKnJz5BGwZp4C1xLm1fWwQ
        y9Ql/sy7xAxhi0vcejKfCcKWl9j+dg7zBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sN
        C4zyUsv1ihNzi0vz0vWS83M3MYJjQktrB+OJE/GHGAU4GJV4eGcEKcQJsSaWFVfmHmKU4GBW
        EuE9OUM2Tog3JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANj
        v4tE8iWRi0cfvjD1tuteGC2Rsuz69SKm9S+6pvcdObavynm270xJNs8/gtLNb87neCUKObea
        JHDPCXCsniL7ZG2A1qmdDYLHrptHXWP9eSh1am3DyVdX9BZ/PTF5dhTvV/9wYzOnjhXtRflp
        7WdKZto7F4QG310fV7v8rkd1R4FzS6CayzQlluKMREMt5qLiRAD56WHJhQIAAA==
X-CMS-MailID: 20200117005734epcas1p3a7ab803d3d34efeb864b730371402dd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116043228epcas1p11a74c5935b015ec85fc61da8cf12681f
References: <CGME20200116043228epcas1p11a74c5935b015ec85fc61da8cf12681f@epcas1p1.samsung.com>
        <20200116043947.12556-1-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 1:39 PM, Chanwoo Choi wrote:
> 'extern' keyword is unneeded in extcon.h because public header file
> of extcon defines the function prototype.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  include/linux/extcon.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 2bdf643d8593..1b1d77ec2114 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -170,7 +170,7 @@ struct extcon_dev;
>   * Following APIs get the connected state of each external connector.
>   * The 'id' argument indicates the defined external connector.
>   */
> -extern int extcon_get_state(struct extcon_dev *edev, unsigned int id);
> +int extcon_get_state(struct extcon_dev *edev, unsigned int id);
>  
>  /*
>   * Following APIs get the property of each external connector.
> @@ -181,10 +181,10 @@ extern int extcon_get_state(struct extcon_dev *edev, unsigned int id);
>   * for each external connector. They are used to get the capability of the
>   * property of each external connector based on the id and property.
>   */
> -extern int extcon_get_property(struct extcon_dev *edev, unsigned int id,
> +int extcon_get_property(struct extcon_dev *edev, unsigned int id,
>  				unsigned int prop,
>  				union extcon_property_value *prop_val);
> -extern int extcon_get_property_capability(struct extcon_dev *edev,
> +int extcon_get_property_capability(struct extcon_dev *edev,
>  				unsigned int id, unsigned int prop);
>  
>  /*
> @@ -196,38 +196,38 @@ extern int extcon_get_property_capability(struct extcon_dev *edev,
>   * extcon_register_notifier_all(*edev, *nb) : Register a notifier block
>   *			for all supported external connectors of the extcon.
>   */
> -extern int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
> +int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
>  				struct notifier_block *nb);
> -extern int extcon_unregister_notifier(struct extcon_dev *edev, unsigned int id,
> +int extcon_unregister_notifier(struct extcon_dev *edev, unsigned int id,
>  				struct notifier_block *nb);
> -extern int devm_extcon_register_notifier(struct device *dev,
> +int devm_extcon_register_notifier(struct device *dev,
>  				struct extcon_dev *edev, unsigned int id,
>  				struct notifier_block *nb);
> -extern void devm_extcon_unregister_notifier(struct device *dev,
> +void devm_extcon_unregister_notifier(struct device *dev,
>  				struct extcon_dev *edev, unsigned int id,
>  				struct notifier_block *nb);
>  
> -extern int extcon_register_notifier_all(struct extcon_dev *edev,
> +int extcon_register_notifier_all(struct extcon_dev *edev,
>  				struct notifier_block *nb);
> -extern int extcon_unregister_notifier_all(struct extcon_dev *edev,
> +int extcon_unregister_notifier_all(struct extcon_dev *edev,
>  				struct notifier_block *nb);
> -extern int devm_extcon_register_notifier_all(struct device *dev,
> +int devm_extcon_register_notifier_all(struct device *dev,
>  				struct extcon_dev *edev,
>  				struct notifier_block *nb);
> -extern void devm_extcon_unregister_notifier_all(struct device *dev,
> +void devm_extcon_unregister_notifier_all(struct device *dev,
>  				struct extcon_dev *edev,
>  				struct notifier_block *nb);
>  
>  /*
>   * Following APIs get the extcon_dev from devicetree or by through extcon name.
>   */
> -extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
> -extern struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
> -extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
> +struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
> +struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
> +struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
>  						     int index);
>  
>  /* Following API get the name of extcon device. */
> -extern const char *extcon_get_edev_name(struct extcon_dev *edev);
> +const char *extcon_get_edev_name(struct extcon_dev *edev);
>  
>  #else /* CONFIG_EXTCON */
>  static inline int extcon_get_state(struct extcon_dev *edev, unsigned int id)
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
