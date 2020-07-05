Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94942C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637CF206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q7F/QuCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgGEXxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 19:53:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:41532 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgGEXxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 19:53:16 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200705235314epoutp023d9a821d8452194d6d35df3ad807a377~fAF1qLr4V1567115671epoutp02e
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 23:53:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200705235314epoutp023d9a821d8452194d6d35df3ad807a377~fAF1qLr4V1567115671epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593993194;
        bh=hEhIFmdzez0ObkbJEBfN24ECiX83dYNTVYEH4Ta0f4s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=q7F/QuCKX4asj2neGax0MQwMsbVLs/KPf5AEusg7sBawVcPTgvIBdVtMHqMjPmDIq
         Wb6MOVxBvf1qwULBzoK2OnIRdxPxiP7j5PHO5oihpBqTOniiS9OoFVBvp6zDj4MEu/
         ino9SGOqfCyPI9mqBue4NWEhJ5/IsNcTq6KjOX/c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200705235313epcas1p15afbb9753200e076ba0701f76a5f2399~fAF1LncrQ2507925079epcas1p13;
        Sun,  5 Jul 2020 23:53:13 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4B0QWC4JZLzMqYkm; Sun,  5 Jul
        2020 23:53:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.60.29173.0E7620F5; Mon,  6 Jul 2020 08:53:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200705235303epcas1p4ce973bc91323e6a537c5f99b3fc61e04~fAFrWT0G90882708827epcas1p4M;
        Sun,  5 Jul 2020 23:53:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200705235303epsmtrp1d4311be7825e60e1ccf1b47de5942d43~fAFrVhcIz3120331203epsmtrp1F;
        Sun,  5 Jul 2020 23:53:03 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-b9-5f0267e07d4e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.B0.08303.FD7620F5; Mon,  6 Jul 2020 08:53:03 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200705235302epsmtip2fa9f1463e0277343bdf2ddf92df79ce9~fAFq8ifxV3043230432epsmtip2N;
        Sun,  5 Jul 2020 23:53:02 +0000 (GMT)
Subject: Re: [PATCH 08/15] mmc: host: dw_mmc-exynos: Add kerneldoc
 descriptions of for 'dev' args
To:     Lee Jones <lee.jones@linaro.org>, ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <05231d4d-350c-b2df-ea9c-5317b8b7eb5f@samsung.com>
Date:   Mon, 6 Jul 2020 08:53:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701124702.908713-9-lee.jones@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmvu6DdKZ4g9fNkhb9j18zW5w/v4Hd
        4v7Xo4wWmx5fY7W4vGsOm8WM8/uYLI6vDXdg99i0qpPN4861PWwem5fUe3zeJBfAEpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfF/2jzG
        ghN8Fa3rF7E1ME7n6WLk5JAQMJFYf+QCYxcjF4eQwA5GiT9/ZzBDOJ8YJW4/fM4O4XxmlLi4
        ewE7TMvBxVtYIRK7GCVOdd1ggnDeM0p0X3rPBFIlLJAs8fD4fjYQW0TARuLLwp9gHcwCmxkl
        Tl+fywySYBPQkdj+7ThYA6+AncTB7y1gK1gEVCROrZ/BAmKLCkRIHO+ezA5RIyhxcuYTsDin
        gLXE2pPLweYwC4hL3HoynwnClpfY/nYO2BMSAq0cEudX/mGEuNtFYtrzMywQtrDEq+NboP6R
        knjZ3wZlV0vsaj4D1dzBKHFrWxMTRMJYYv/SyUA2B9AGTYn1u/QhwooSO3/PZYRYzCfx7msP
        K0iJhACvREebEESJisSl1y+ZYFbdffKfFcL2kFjy7Cr7BEbFWUhem4XknVlI3pmFsHgBI8sq
        RrHUguLc9NRiwwJj5PjexAhOnVrmOxinvf2gd4iRiYPxEKMEB7OSCG+vNmO8EG9KYmVValF+
        fFFpTmrxIUZTYGBPZJYSTc4HJu+8knhDUyNjY2MLE0MzU0NDJXFeX6sLcUIC6YklqdmpqQWp
        RTB9TBycUg1MpY76Qjn7XAPOneZpdPYNdBD56qOofaRqbrnZobbnwZnCZU/f7/m0anuF6p39
        X300doTeuS9xw+mESDS3QLpd23LucM7p9nVT7vxwbJ5/v4HVI40t0lr2+3mX8KndPlqXBLcd
        q7KzZN1TV/Qk4orwg1+Oa7fMnr7JhWnm3B+HkifbJkwonla31NuUTVwx7vPmi1vtzwmb9nQ0
        H+wqL5j9p/eF/p5+E/WAubr3zQ9m3TgVs7lwbkJuImvZ58mzq3znPZ9x4uvjNp9H+3VatLad
        CFNSVBed6BT/Logr10a5euHVwJMHLucKBFnwiN67Lrb779bQbQtOaydUHeexchAJFq3uKFfk
        kNRQWK9qL63EUpyRaKjFXFScCABxxQmYJgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO79dKZ4g///2S36H79mtjh/fgO7
        xf2vRxktNj2+xmpxedccNosZ5/cxWRxfG+7A7rFpVSebx51re9g8Ni+p9/i8SS6AJYrLJiU1
        J7MstUjfLoEr4/+0eYwFJ/gqWtcvYmtgnM7TxcjJISFgInFw8RZWEFtIYAejRPdWZYi4lMTn
        p1PZuhg5gGxhicOHi7sYuYBK3jJKNC1azgxSIyyQLPHw+H42EFtEwEbiy8KfrCBFzAKbGSW2
        znnEDNGxn1HizfoudpAqNgEdie3fjjOB2LwCdhIHv7eAxVkEVCROrZ/BAmKLCkRItNz/ww5R
        IyhxcuYTsDingLXE2pMQm5kF1CX+zLsEZYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUW
        kpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCI0VLawfjnlUf9A4xMnEwHmKU
        4GBWEuHt1WaMF+JNSaysSi3Kjy8qzUktPsQozcGiJM77ddbCOCGB9MSS1OzU1ILUIpgsEwen
        VANT2dSsWubifbGCSeL2Qcyd+313M3ld0DTpFA2c82iXS59iip3y3e/bpS6rzo7VOGk7QUxy
        /mMJtnCPX1y5IebrvuwpPeZ5Imzj7o7k9kP554/nssaUunYV3VVQnp37pdwo6+yiQ0YaTKxx
        f1jZzltbHE50uKO3d12u3O+5O15LhPdn3792qkDjmylTz/boNeu29tb92n9opp+9tsfkarb0
        +sZJPIennC1o/RO61k3vVM45Xu+9DLMfNawOemv7W+Wl+cXynKzoVxeW3bN8nn6SlVuezTDp
        chzHJHU3H6VD/Nwe698HSky+9CacV22GT+mP/9oWNRcDPvuuP5OzOThD0zdidvc0N7sTFu1b
        LiuxFGckGmoxFxUnAgCNk8XTAwMAAA==
X-CMS-MailID: 20200705235303epcas1p4ce973bc91323e6a537c5f99b3fc61e04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200701124745epcas1p4c988298526cf920f354c73ede56c6384
References: <20200701124702.908713-1-lee.jones@linaro.org>
        <CGME20200701124745epcas1p4c988298526cf920f354c73ede56c6384@epcas1p4.samsung.com>
        <20200701124702.908713-9-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 9:46 PM, Lee Jones wrote:
> Provide missing documentation for dw_mci_exynos_suspend_noirq() and
> dw_mci_exynos_resume_noirq() function headers.
> 
> Fixes the following W=1 kernel build warnings:
> 
>  drivers/mmc/host/dw_mmc-exynos.c:184: warning: Function parameter or member 'dev' not described in 'dw_mci_exynos_suspend_noirq'
>  drivers/mmc/host/dw_mmc-exynos.c:200: warning: Function parameter or member 'dev' not described in 'dw_mci_exynos_resume_noirq'
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 5e3d95b636769..bd59186f59b39 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -176,6 +176,7 @@ static int dw_mci_exynos_runtime_resume(struct device *dev)
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * dw_mci_exynos_suspend_noirq - Exynos-specific suspend code
> + * @dev: Device to suspend (this device)
>   *
>   * This ensures that device will be in runtime active state in
>   * dw_mci_exynos_resume_noirq after calling pm_runtime_force_resume()
> @@ -188,6 +189,7 @@ static int dw_mci_exynos_suspend_noirq(struct device *dev)
>  
>  /**
>   * dw_mci_exynos_resume_noirq - Exynos-specific resume code
> + * @dev: Device to resume (this device)
>   *
>   * On exynos5420 there is a silicon errata that will sometimes leave the
>   * WAKEUP_INT bit in the CLKSEL register asserted.  This bit is 1 to indicate
> 

