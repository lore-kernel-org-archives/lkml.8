Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F712C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B482220D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mPS7zcZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgIHMlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:41:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50431 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbgIHLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:50:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200908113750euoutp018ba50d627cd5a2fc8af8cb2752e6f8fe~yy-T8zf-z0806108061euoutp01X
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:37:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200908113750euoutp018ba50d627cd5a2fc8af8cb2752e6f8fe~yy-T8zf-z0806108061euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599565070;
        bh=/288GAGi7cofFncgRR5tyjVBqWIquj4HXLwBEHYf7Qw=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=mPS7zcZ8sMF2zK0COeYjxEeIVew5V2dxiYFqId4ADmAZ3vbKhRsuOXnHlOv9Nd8vQ
         KOl3yjoEiYhA+Ef0obleWD/0B7q2tcLnNxwlGeN04pJv+AZgVfi4pHP7/CJrqhGHEM
         u6v5NE5KnA9NFd1Y02HmgMbHZf+UCqMZWgNbjeU8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908113750eucas1p17567859f704041cc33b779bee75e67d2~yy-T28SBo1307213072eucas1p1-;
        Tue,  8 Sep 2020 11:37:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.C5.06318.E0D675F5; Tue,  8
        Sep 2020 12:37:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200908113750eucas1p198b2d514a44cb9604a09a18f4e94554e~yy-TjJ7-t1307213072eucas1p1_;
        Tue,  8 Sep 2020 11:37:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200908113750eusmtrp1294688d346151b316eece8072df90765~yy-Tii8pG2045820458eusmtrp1k;
        Tue,  8 Sep 2020 11:37:50 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-d2-5f576d0e44a3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.E1.06314.E0D675F5; Tue,  8
        Sep 2020 12:37:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200908113749eusmtip1a1eb2d3f40ced70f90732a09ffbc7e33~yy-TPFKRh0553105531eusmtip1L;
        Tue,  8 Sep 2020 11:37:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: remove set but not used 'ulCoreClock'
To:     Jason Yan <yanaijie@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Message-ID: <7d8571f5-7f26-2507-291c-8a66ac3744bd@samsung.com>
Date:   Tue, 8 Sep 2020 13:37:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200827130028.428893-1-yanaijie@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7p8ueHxBr0LVSyufH3PZvF/+RVG
        ixN9H1gtLu+aw2axaE8nswOrR8uRt6we97uPM3l83iQXwBzFZZOSmpNZllqkb5fAldHQe5e9
        YD9PxfyXOg2Mc7i6GDk5JARMJO5vW8HexcjFISSwglHiw5LvzBDOF0aJhndvoJzPjBKv9z9n
        gmnpevmfDSKxnFHi/7TVUM5bRokFUzYyg1SxCVhJTGxfxQhiCwt4SEyft4kFxBYRUJZovD+d
        FaSBWaCBUeLe4cPsIAleATuJxd87wWwWARWJI48OgNmiAhESnx4cZoWoEZQ4OfMJ0CAODk6g
        Be/eV4OEmQXEJW49mc8EYctLNG+dzQxx6WR2iWN77EDKJQRcJC70OkGEhSVeHd/CDmHLSJye
        3MMCco6EwDpGib8dL5ghnO2MEssn/2ODqLKWuHPuFxvIIGYBTYn1u/Qhwo4SD9tOM0PM55O4
        8VYQ4gQ+iUnbpkOFeSU62oQgqtUkNizbwAaztmvnSuYJjEqzkPw1C8kzs5A8Mwth7wJGllWM
        4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBieX0v+NfdzDu+5N0iFGAg1GJh9fDNyxeiDWx
        rLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1I
        LYLJMnFwSjUwtjxw/V9QZ3J1UZGSQnXGv8xFnWEaazheLc+umfaNWTa86skt6RV9ApGRza58
        KgHhgXarZXMLOdqrJ+2y4b6gsf9cttXUK1ydO5ZaMsam3v++NvJi+6m9547s3Zl7q49/pePa
        X3lR6y6xc7esU2tP0FzG6VXaerp3a05W/Yy6zVv550qY5TgosRRnJBpqMRcVJwIAHfYGeCgD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7p8ueHxBs+mCFhc+fqezeL/8iuM
        Fif6PrBaXN41h81i0Z5OZgdWj5Yjb1k97ncfZ/L4vEkugDlKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6Oh9y57wX6eivkvdRoY53B1MXJySAiY
        SHS9/M/WxcjFISSwlFHixP5nQA4HUEJG4vj6MogaYYk/17qgal4zSny6vZQZJMEmYCUxsX0V
        I4gtLOAhMX3eJhYQW0RAWaLx/nRWkAZmgQZGiZNf2xghunsZJWZPuQvWzStgJ7H4eyc7iM0i
        oCJx5NEBMFtUIELi8I5ZjBA1ghInZz5hAbmIE2jbu/fVIGFmAXWJP/MuMUPY4hK3nsxngrDl
        JZq3zmaewCg0C0n3LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgLG07
        9nPzDsZLG4MPMQpwMCrx8H7wCosXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q
        8SFGU6DfJjJLiSbnA+M8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMH
        p1QDo15lyveLd6ynP7kfJfjgtErl8wcrvE6ruxQukjzwzy5abH2UotCm3380XeYqWAjftJDp
        2fLtt0fIJA+Lqcm5368mrXt6ieXC5VTmdWKaz9fxtDxXuv7mBs8vy3d3FSX3xFotTFnx8dOE
        pWJ/Isv8J/vmLg+tFo09WxcT2jP57bVmjzxd++kWYUosxRmJhlrMRcWJAHvS3ka7AgAA
X-CMS-MailID: 20200908113750eucas1p198b2d514a44cb9604a09a18f4e94554e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200827130059eucas1p21c6e4789266a0db0890e20ebdca8c530
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200827130059eucas1p21c6e4789266a0db0890e20ebdca8c530
References: <CGME20200827130059eucas1p21c6e4789266a0db0890e20ebdca8c530@eucas1p2.samsung.com>
        <20200827130028.428893-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/20 3:00 PM, Jason Yan wrote:
> This addresses the following gcc warning with "make W=1":
> 
> drivers/video/fbdev/kyro/STG4000InitDevice.c: In function
> ‘SetCoreClockPLL’:
> drivers/video/fbdev/kyro/STG4000InitDevice.c:247:6: warning: variable
> ‘ulCoreClock’ set but not used [-Wunused-but-set-variable] // yanaijie
> fixed
>   247 |  u32 ulCoreClock;
>       |      ^~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/kyro/STG4000InitDevice.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> index 1d3f2080aa6f..edaeec2d9590 100644
> --- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
> +++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> @@ -244,7 +244,6 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
>  {
>  	u32 F, R, P;
>  	u16 core_pll = 0, sub;
> -	u32 ulCoreClock;
>  	u32 tmp;
>  	u32 ulChipSpeed;
>  
> @@ -282,7 +281,7 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
>  	if (ulChipSpeed == 0)
>  		return -EINVAL;
>  
> -	ulCoreClock = ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
> +	ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
>  
>  	core_pll |= ((P) | ((F - 2) << 2) | ((R - 2) << 11));
>  
