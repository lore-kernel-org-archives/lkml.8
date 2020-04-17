Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E22C21841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="opu3YuLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgDQCzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:55:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:31503 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbgDQCzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:55:48 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200417025546epoutp0411b7511b75725d8b3338865c398530dd~Ge_YYBXt-2928429284epoutp04S
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:55:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200417025546epoutp0411b7511b75725d8b3338865c398530dd~Ge_YYBXt-2928429284epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587092146;
        bh=HBC3znJv7wTOjbDwmJrvVlbQN+na6LD4DK1J6T2DOes=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=opu3YuLuFhThENhOSu4DbnC/1Ye1lqTAnRtytV+WYzW2gBxrScpdlKNqtS+YpQh7w
         t8lYfL8yCSFfPANIdHBLA982xwv3T0N+ld1Aoqg8x2A/Ziawe6t10PNtBpWwJ7CEA+
         78BkhSYqmpS2IcAm8Mn4M0r8P4s2Emq/s0Wv+7as=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200417025546epcas1p1dca7a0e8772cb9c060223cd6d5f54046~Ge_XxOjHo0790707907epcas1p1s;
        Fri, 17 Apr 2020 02:55:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 493LLl738WzMqYkg; Fri, 17 Apr
        2020 02:55:43 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.54.04744.DAA199E5; Fri, 17 Apr 2020 11:55:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200417025540epcas1p3c621542c72f321662f97d9a6c8392238~Ge_Spe1yW2089220892epcas1p3B;
        Fri, 17 Apr 2020 02:55:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200417025540epsmtrp1e0f26c40585d46bb3bee9dd973e9834e~Ge_SoXOdq0082200822epsmtrp1q;
        Fri, 17 Apr 2020 02:55:40 +0000 (GMT)
X-AuditID: b6c32a38-253ff70000001288-8d-5e991aad6fc4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.62.04158.CAA199E5; Fri, 17 Apr 2020 11:55:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200417025540epsmtip21a6192e55e306786da78fc5783428d64~Ge_Sdjgu32894428944epsmtip2q;
        Fri, 17 Apr 2020 02:55:40 +0000 (GMT)
Subject: Re: [PATCH] extcon: remove redundant assignment to variable idx
To:     Colin King <colin.king@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f88c8ae7-a9bc-1bc2-9c21-d8395fa33409@samsung.com>
Date:   Fri, 17 Apr 2020 12:05:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200415230821.1567410-1-colin.king@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTV3et1Mw4g303FC1+r+5ls9h6S9ri
        8q45bBa3G1ewObB4zGroZfPo27KK0ePzJrkA5qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
        MwNDXUNLC3MlhbzE3FRbJRefAF23zBygZUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7IyepwfZC56wV/RPOcTawDiVrYuRk0NCwERi
        +8oJQDYXh5DADkaJx1dnMEI4nxgl1vY9YYFwvjFKXF68jQmmZeuSLmaIxF5Gifnbp7BCOO8Z
        Jc5dO8gMUiUs4CExtW8CK4gtIhAicfrCRHYQm1nAUWLd/DssIDabgJbE/hc3wA7hF1CUuPrj
        MSOIzStgJ7FtyT+wOIuAqsSC3RfBNosKhEmc3NYCVSMocXLmE7A5nAIOEk0bn0PNF5e49WQ+
        E4QtL7H97RywSyUEjrBJnNz7H6iIA8hxkXh/lQXiG2GJV8e3sEPYUhIv+9ug7GqJlSePsEH0
        djBKbNl/gRUiYSyxf+lkJpA5zAKaEut36UOEFSV2/p7LCLGXT+Ld1x5WiFW8Eh1tQhAlyhKX
        H9yFBqKkxOL2TrYJjEqzkHwzC8kHs5B8MAth2QJGllWMYqkFxbnpqcWGBSbIsb2JEZwQtSx2
        MO4553OIUYCDUYmHN8F+RpwQa2JZcWXuIUYJDmYlEV4+U6AQb0piZVVqUX58UWlOavEhRlNg
        YE9klhJNzgcm67ySeENTI2NjYwsTQzNTQ0Mlcd6p13PihATSE0tSs1NTC1KLYPqYODilGhg7
        VUR/XbXWOSvI1yrV6CrzRWzWym3s3PvW/bj0/qH/7+cTSvRb5Qp1Us1X2ks9Cng7+1KvVXOU
        5etzvfd9bLKMbly2nJ/46bPKL1fx7IzVXcFzC7+EvDRUeTN30p6lux7WPWdY+kllZsCNFX/e
        LN2hLlbfXjTPoPTx7m+mXges4rPzQm5K5vQpsRRnJBpqMRcVJwIAUmdRzZ4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvO4aqZlxBpvuqVr8Xt3LZrH1lrTF
        5V1z2CxuN65gc2DxmNXQy+bRt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGT1PD7IXPGGv6J9y
        iLWBcSpbFyMnh4SAicTWJV3MXYxcHEICuxkl7j1/zwKRkJSYdvEoUIIDyBaWOHy4GKLmLaPE
        hCmHmEBqhAU8JKb2TWAFsUUEQiRmTd/ECGIzCzhKrJt/hwWiYTKjxJedX8GK2AS0JPa/uAG2
        mV9AUeLqj8dgDbwCdhLblvwDi7MIqEos2H0RbIGoQJjEziWPmSBqBCVOznwCdhyngINE08bn
        7BDL1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nz
        iw0LjPJSy/WKE3OLS/PS9ZLzczcxgmNDS2sH44kT8YcYBTgYlXh4E+xnxAmxJpYVV+YeYpTg
        YFYS4eUzBQrxpiRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpg
        LLz0spwt0CRO/NPpft7/odrr7p6bnpmle6S+kyuz5ub2WWZsG/+nO9w/O+Fu7okFpgF8N6T0
        psesc1l5W8rp6i/n6IrwizYpyx4uSbI6wvT6pd3Ojza1N1qZZqo+UTNYr9gz0eGX+8KdEvb5
        M89dXaJo4MnkkJdsPe3UZ5lVf+ZlPBL59OHNOiWW4oxEQy3mouJEAMndIjGJAgAA
X-CMS-MailID: 20200417025540epcas1p3c621542c72f321662f97d9a6c8392238
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200415230903epcas1p2bc2dd8edb6ca123086f44cb158406439
References: <CGME20200415230903epcas1p2bc2dd8edb6ca123086f44cb158406439@epcas1p2.samsung.com>
        <20200415230821.1567410-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 8:08 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable idx is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/extcon/extcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 2dfbfec572f9..0a6438cbb3f3 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -900,7 +900,7 @@ int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
>  			     struct notifier_block *nb)
>  {
>  	unsigned long flags;
> -	int ret, idx = -EINVAL;
> +	int ret, idx;
>  
>  	if (!edev || !nb)
>  		return -EINVAL;
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
