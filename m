Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90465C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6EB20829
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zb+lDWr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKDCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:02:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:60083 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:02:09 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200911030207epoutp04ffe9d69bb2d8368e412b156d581179a7~zm44kFMCc1075610756epoutp04E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:02:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200911030207epoutp04ffe9d69bb2d8368e412b156d581179a7~zm44kFMCc1075610756epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599793327;
        bh=x5wR8Mxidx7euf67etz55F+o9XUqeyWPDOy717zfU5w=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=Zb+lDWr9HuCYdjkPXPpA5Y8fWozXqSPlxpnsGclr09O9lBzx/ymMjx1MADNoc7Lj0
         nrMIyIkrv4xpSPJGgm07WdalqHUDOwlmsdLPkWt6mR+V3/qZ9Jc5AxrmfW2gT9BHmt
         NTuztQnMAHtOo1oxyDyMeSrrgO+HH4OeCO/kAe6Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200911030206epcas1p33f8bb241ad2ef86965ed5a994f49cc88~zm44EuZyW2115921159epcas1p3R;
        Fri, 11 Sep 2020 03:02:06 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BngXF4xH2zMqYkb; Fri, 11 Sep
        2020 03:02:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.03.19033.DA8EA5F5; Fri, 11 Sep 2020 12:02:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200911030204epcas1p38be67c1420a6d3672de2ae9ea4911d56~zm415zq3t0051700517epcas1p3W;
        Fri, 11 Sep 2020 03:02:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200911030204epsmtrp12fdfdca07706a492c09a534b6f8b8ad3~zm415KdqW3122631226epsmtrp1l;
        Fri, 11 Sep 2020 03:02:04 +0000 (GMT)
X-AuditID: b6c32a36-6ed22a8000004a59-ae-5f5ae8ade48d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.FA.08303.CA8EA5F5; Fri, 11 Sep 2020 12:02:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200911030204epsmtip1d33bf518eff6e7ebdf3d1008d1316523~zm41pptxq2582025820epsmtip1g;
        Fri, 11 Sep 2020 03:02:04 +0000 (GMT)
Subject: Re: [PATCH 1/2] extcon: ptn5150: Use defines for registers
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7571e535-f0ff-2371-1669-734c3996aacf@samsung.com>
Date:   Fri, 11 Sep 2020 12:14:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200909150129.12476-1-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTX3fti6h4g1crxS3On9/AbnF51xw2
        i9uNK9gsXu6fzurA4rFz1l12j02rOtk8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITvj8IwdjAXbeCva9uU1ME7i7mLk
        5JAQMJE4eHIrE4gtJLCDUeJfh14XIxeQ/YlR4mZ3OxuE85lRYs+0B+wwHVtf32aFSOxilGh4
        +hzKec8o8eDoL0aQKmEBZ4kr7dPA5ooILGOU2HsvF8RmE9CS2P/iBhuIzS+gKHH1x2Owel4B
        O4mdX76B2SwCqhJNJ2+BbRMVCJM4ua0FqkZQ4uTMJywgNqeAqUTr/5XMIDazgLjErSfzmSBs
        eYntb+cwgxwkIfCVXWLd3enMEGe7SOy68pQJwhaWeHV8C9Q7UhIv+9ug7GqJlSePsEE0dzBK
        bNl/gRUiYSyxf+lkoGYOoA2aEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6JjjYhiBJlicsP
        7kKtlZRY3N7JBmF7SOyd9JllAqPiLCSvzULyziwk78xCWLyAkWUVo1hqQXFuemqxYYERcmRv
        YgSnRi2zHYyT3n7QO8TIxMF4iFGCg1lJhDcpPzJeiDclsbIqtSg/vqg0J7X4EKMpMLAnMkuJ
        JucDk3NeSbyhqZGxsbGFiaGZqaGhkjjvw1sK8UIC6YklqdmpqQWpRTB9TBycUg1MxqaGTD+e
        WJ9l+FG6cI7azuV7fRn3nbn60ful1ee2R1f39lUdn9p9wvqW14q59a5mbTntQltdrHjkp66a
        XRAZJHJvme7ph2tfLzzc9fHl43kXV7y70O138ut87oO/Hmzjvz2LK/Ln14eO8W8LmEQtFv1M
        mjdv3tTGJVsF9p5tv7bi08mY0hnsnmrSMgZclxxXvarvNjgzVS1hCYfQRQOZ+g0X7jyuDQkJ
        qYy9yBzGO/s2h2bzd/GlgScvnlsvXBTfo/XkrvafkvyL+/fXL7+0kL/w26lzyb2CQrw9R178
        2rxQassctr4m5mV61ef3vvu8drr529KN09YyytWoMcUlWTfnd97P77+7tLxJXYyJw1qJpTgj
        0VCLuag4EQDVaJf3FgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO6aF1HxBv+/SlqcP7+B3eLyrjls
        FrcbV7BZvNw/ndWBxWPnrLvsHptWdbJ59G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8bhGTsY
        C7bxVrTty2tgnMTdxcjJISFgIrH19W3WLkYuDiGBHYwScx99YINISEpMu3iUuYuRA8gWljh8
        uBii5i2jRFf3bWaQGmEBZ4kr7dOYQBIiAisYJVY+eM4MUdXBKPH+7x4mkCo2AS2J/S9ugE3l
        F1CUuPrjMSOIzStgJ7Hzyzcwm0VAVaLp5C12EFtUIExi55LHTBA1ghInZz5hAbE5BUwlWv+v
        BNvMLKAu8WfeJShbXOLWk/lMELa8xPa3c5gnMArNQtI+C0nLLCQts5C0LGBkWcUomVpQnJue
        W2xYYJSXWq5XnJhbXJqXrpecn7uJERwPWlo7GPes+qB3iJGJg/EQowQHs5IIb1J+ZLwQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUamAqyr52omnvfbHnA
        jf0feJ990jWxf7B28Qe7/eFXtv+Um3V60r1X70TdU1ZvYLOJTXM2Oy/EbsgavOmRNs86G+m9
        Z0NORc36v2BRxd2EG68Dog2+7/XYEqLyI2VWYeK2imztvB89HUtU0zde3/k8NC7+1x+/mBqm
        rZdNkxaLJnbP/e/Y/Gn79/KTF3Y+mPPo5NGYnCPn7ltt1TZ7ybzX4GnDi+Tc0Mn2pmmBToG+
        hwzCb12MX7w2567ebVGBhzIxMlYHF19ZH12bb8j846xE48ycya0Ptmbos4buCdh2teuHzCUl
        lykJdZNW1W5oW+sm2Z9Vat0j0zg9nFX1T61K0ftNAYtcD377UrpH8OAK9kAlluKMREMt5qLi
        RABOf7u59gIAAA==
X-CMS-MailID: 20200911030204epcas1p38be67c1420a6d3672de2ae9ea4911d56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200909172007epcas1p2fe01380c62ca112a19283f2dc63e75f9
References: <CGME20200909172007epcas1p2fe01380c62ca112a19283f2dc63e75f9@epcas1p2.samsung.com>
        <20200909150129.12476-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 12:01 AM, Krzysztof Kozlowski wrote:
> The register addresses are not continuous, so use simple defines for
> them.  This also makes it easier to find the address for register.
> 
> No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/extcon/extcon-ptn5150.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index dda5b3a3a908..1b68f56d8372 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -19,18 +19,16 @@
>  #include <linux/gpio/consumer.h>
>  
>  /* PTN5150 registers */
> -enum ptn5150_reg {
> -	PTN5150_REG_DEVICE_ID = 0x01,
> -	PTN5150_REG_CONTROL,
> -	PTN5150_REG_INT_STATUS,
> -	PTN5150_REG_CC_STATUS,
> -	PTN5150_REG_CON_DET = 0x09,
> -	PTN5150_REG_VCONN_STATUS,
> -	PTN5150_REG_RESET,
> -	PTN5150_REG_INT_MASK = 0x18,
> -	PTN5150_REG_INT_REG_STATUS,
> -	PTN5150_REG_END,
> -};
> +#define PTN5150_REG_DEVICE_ID			0x01
> +#define PTN5150_REG_CONTROL			0x02
> +#define PTN5150_REG_INT_STATUS			0x03
> +#define PTN5150_REG_CC_STATUS			0x04
> +#define PTN5150_REG_CON_DET			0x09
> +#define PTN5150_REG_VCONN_STATUS		0x0a
> +#define PTN5150_REG_RESET			0x0b
> +#define PTN5150_REG_INT_MASK			0x18
> +#define PTN5150_REG_INT_REG_STATUS		0x19
> +#define PTN5150_REG_END				PTN5150_REG_INT_REG_STATUS

PTN5150_REG_END should be (PTN5150_REG_INT_REG_STATUS + 1)
for regmap operation of PTN5150_REG_INT_REG_STATUS.

>  
>  #define PTN5150_DFP_ATTACHED			0x1
>  #define PTN5150_UFP_ATTACHED			0x2
> 
-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
