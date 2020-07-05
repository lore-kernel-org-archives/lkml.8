Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E65C206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B62N5QDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGEXx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 19:53:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50402 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgGEXx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 19:53:27 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200705235325epoutp01d16f54d455f56e4991a61a3b39979403~fAF-mdzma0410104101epoutp01_
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 23:53:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200705235325epoutp01d16f54d455f56e4991a61a3b39979403~fAF-mdzma0410104101epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593993205;
        bh=/F8gEvyHfag24TtxxVVhnqgSMMrdCfGFu91G1MGkWnU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B62N5QDszMMxlj8ddS4tSL8PuN+oi8D4q5qSOoJXzGCtq4n5B2/tBYM49wjrlORld
         NYOq1YrrFFVFXhAevOyEoN5POxbzjC//dDiZe9u0nDtzwdek4tZDfag9Tp1JkKc1P3
         H4ETzaykSSrHIsitTNnZ8tMJGwaR3tCfvHyFCa4I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200705235324epcas1p39764b5bf6c119eabc2b4d4d09056c37b~fAF_7h4N72513125131epcas1p3l;
        Sun,  5 Jul 2020 23:53:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4B0QWN6dRHzMqYkk; Sun,  5 Jul
        2020 23:53:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.FF.28581.EE7620F5; Mon,  6 Jul 2020 08:53:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200705235317epcas1p460fe653c6a39bcd60cf753181a70dc84~fAF42x2sx0536805368epcas1p46;
        Sun,  5 Jul 2020 23:53:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200705235317epsmtrp26d8d834c24bfe19613c178bcea95204b~fAF42KCou1441214412epsmtrp2q;
        Sun,  5 Jul 2020 23:53:17 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-fd-5f0267ee5f97
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.B0.08303.DE7620F5; Mon,  6 Jul 2020 08:53:17 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200705235317epsmtip29e8b2b75a24e6edc1e49e714e5ea36f3~fAF4pghvj3243532435epsmtip2J;
        Sun,  5 Jul 2020 23:53:17 +0000 (GMT)
Subject: Re: [PATCH 04/15] mmc: host: sdhci-s3c: Provide documentation for
 missing struct properties
To:     Lee Jones <lee.jones@linaro.org>, ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <6d9dfe1c-9a6c-ddc0-658e-03a16e8fc841@samsung.com>
Date:   Mon, 6 Jul 2020 08:53:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701124702.908713-5-lee.jones@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTV/ddOlO8wcMdqhaT1h1gsrj/9Sij
        xabH11gtLu+aw2ZxfG24A6vH31UvmD3uXNvD5rF5Sb3H501yASxR2TYZqYkpqUUKqXnJ+SmZ
        eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QFuVFMoSc0qBQgGJxcVK+nY2Rfml
        JakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5uVaGBgZGpkCFCdkZR6dcZC04LlCx7NIC1gbG
        K7xdjJwcEgImEkv/7GfuYuTiEBLYwSgxt+0LG4TziVFi/+fdUM5nRompt04zwrQcmfyeCSKx
        i1Gi9WsTO4TznlHi+LQvzCBVwgJpErN2X2cFsUUEbCS+LPwJZjMLZEocXjCVHcRmE9CR2P7t
        OBOIzStgJ7Gm+zOYzSKgInFhxmGwOaICERLHuyezQ9QISpyc+YQFxOYUsJZ4+fYnI8RMcYlb
        T+YzQdjyEtvfzgF7SELgJ7vEko0zmSDOdpFY2vSRDcIWlnh1fAs7hC0l8fndXqh4tcSu5jNQ
        zR2MEre2NUE1G0vsXzoZyOYA2qApsX6XPkRYUWLn77lQR/BJvPvawwpSIiHAK9HRJgRRoiJx
        6fVLJphVd5/8Z4WwPSQ2dj1lm8CoOAvJa7OQvDMLyTuzEBYvYGRZxSiWWlCcm55abFhgghzd
        mxjBSVLLYgfj3Lcf9A4xMnEwHmKU4GBWEuHt1WaMF+JNSaysSi3Kjy8qzUktPsRoCgzsicxS
        osn5wDSdVxJvaGpkbGxsYWJoZmpoqCTOe9LqQpyQQHpiSWp2ampBahFMHxMHp1QDk31yyqXZ
        1SEzFGaKPp993WynXaHbz6g/r4+baPSbhKzwlU4WXr6g7Xr9hWdyzy/ZH7n50ZDRVSYpwurN
        +n0JL/IXG89qUExoun15OcNr8anJivxF62/8Tn2kauDQomPWp7j227fJk5gMbW7EJLDtvnw1
        d8OPzjNfdL6brViQwDSdJyj03sINWUXVyp3T7Hfs5XN7fLu6esO1RbYfLKexnix9Hjh97738
        41zRj5NaXFJiRddyfmHh37LGM9aNyfw0G8uNdQxHAt65+J2Xl7qnXf7BcqqTRb6NRfy6sxFf
        rDsuzMi1W1vXUGa51OPjZpEZkocW7Xxl4qlwRfnjzHeK1s+LV81949S2RfreVN0iCyWW4oxE
        Qy3mouJEAJkP1P0bBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO7bdKZ4g4ZjahaT1h1gsrj/9Sij
        xabH11gtLu+aw2ZxfG24A6vH31UvmD3uXNvD5rF5Sb3H501yASxRXDYpqTmZZalF+nYJXBlH
        p1xkLTguULHs0gLWBsYrvF2MnBwSAiYSRya/Z+pi5OIQEtjBKDH1cCcbREJK4vPTqUA2B5At
        LHH4cDFEzVtGia8H/rCD1AgLpEnM2n2dFcQWEbCR+LLwJ5jNLJApsWDFHhaIhv2MEq++3mUG
        SbAJ6Ehs/3acCcTmFbCTWNP9GcxmEVCRuDDjMFiNqECERMt9iAW8AoISJ2c+YQGxOQWsJV6+
        /ckIsUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4KrS0djDuWfVB7xAjEwfjIUYJDmYlEd5ebcZ4Id6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rxfZy2MExJITyxJzU5NLUgtgskycXBKNTBdvnfAvXDzl3P9
        nfqz4+u74y6UTFqquOhg79u1Ry/6r+38uSB/Uco/32/ZTa9bU8S8Pu+sDkvaer1Avi1YkPGG
        uvXh6VIOnDeXlPN6Poxe0yG85bPNlPNq756tmZG4XuHq19JXYRNtlvHHL9HUfGp2SGLT/i0J
        TbdP7RRuec4340lf46qVciXBc3fr74w0njDT72iHzvTfD48s+6gjvK9vzlnTF3WFxe9O7zgl
        6CJ8+8T9OP3mM08tg810uN7OyFiU/PPXlYiZGXbv9qdrbhdIijnddspthTyj3LvmNTrZO+pf
        aTd+suDgtJi9+OikFcdeJMw6u//ixMmd/eb+/DdWPLkgtuHMwtMd8sKx239xbFFiKc5INNRi
        LipOBAD7+mEN+QIAAA==
X-CMS-MailID: 20200705235317epcas1p460fe653c6a39bcd60cf753181a70dc84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200701124809epcas1p18ff536dd3b7e0f735076df31c1d3edd3
References: <20200701124702.908713-1-lee.jones@linaro.org>
        <CGME20200701124809epcas1p18ff536dd3b7e0f735076df31c1d3edd3@epcas1p1.samsung.com>
        <20200701124702.908713-5-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 9:46 PM, Lee Jones wrote:
> Describe properties; ext_cd_irq, clk_rates and no_divider (x2).
> 
> Squashes the following W=1 kernel build warnings:
> 
>  drivers/mmc/host/sdhci-s3c.c:126: warning: Function parameter or member 'ext_cd_irq' not described in 'sdhci_s3c'
>  drivers/mmc/host/sdhci-s3c.c:126: warning: Function parameter or member 'clk_rates' not described in 'sdhci_s3c'
>  drivers/mmc/host/sdhci-s3c.c:126: warning: Function parameter or member 'no_divider' not described in 'sdhci_s3c'
>  drivers/mmc/host/sdhci-s3c.c:139: warning: Function parameter or member 'no_divider' not described in 'sdhci_s3c_drv_data'
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>  drivers/mmc/host/sdhci-s3c.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 64200c78e90dc..9194bb73e601b 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -107,8 +107,11 @@
>   * @ioarea: The resource created when we claimed the IO area.
>   * @pdata: The platform data for this controller.
>   * @cur_clk: The index of the current bus clock.
> + * @ext_cd_irq: External card detect interrupt.
>   * @clk_io: The clock for the internal bus interface.
> + * @clk_rates: Clock frequencies.
>   * @clk_bus: The clocks that are available for the SD/MMC bus clock.
> + * @no_divider: No or non-standard internal clock divider.
>   */
>  struct sdhci_s3c {
>  	struct sdhci_host	*host;
> @@ -128,6 +131,7 @@ struct sdhci_s3c {
>  /**
>   * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver data
>   * @sdhci_quirks: sdhci host specific quirks.
> + * @no_divider: no or non-standard internal clock divider.
>   *
>   * Specifies platform specific configuration of sdhci controller.
>   * Note: A structure for driver specific platform data is used for future
> 

