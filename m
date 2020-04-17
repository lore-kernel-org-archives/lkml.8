Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D060C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F41214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AxeZOeIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgDQOIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:08:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49833 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbgDQOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:08:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200417140810euoutp018e9cc3ce096faea29419c28e553d2533~GoJdqfk8G1887918879euoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:08:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200417140810euoutp018e9cc3ce096faea29419c28e553d2533~GoJdqfk8G1887918879euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587132490;
        bh=fLaWqIeK65/g1ahWZCdiAY0bKhithxNEwtt9QffX0Rs=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=AxeZOeIz6Oyw6NXEZ7HTVwftvZmoLd35738hBGEqSr7FRe3DnHz813+DmeRCzF16w
         jJC6ud2LU85S7LmDgEj9Td/XiSMvZBXECBLCvJIGVY+/UJsCpL7o/G2HzQ8Y01btNq
         FeQSMqnCD6tkmJ5POCeNtpV5JDB489MnFrL6/UN0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200417140810eucas1p24b8b56eb6790fb89ee0357889ea25283~GoJdb66MB1677816778eucas1p2l;
        Fri, 17 Apr 2020 14:08:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 17.5C.61286.A48B99E5; Fri, 17
        Apr 2020 15:08:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200417140810eucas1p1b57dacb13bd60223b474d37d5c3d12df~GoJdIRCMv0071400714eucas1p1M;
        Fri, 17 Apr 2020 14:08:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200417140810eusmtrp119c960141c4878ddddfa1d8806202662~GoJdHsbzd2228222282eusmtrp1K;
        Fri, 17 Apr 2020 14:08:10 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-5a-5e99b84a9bb8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.C2.08375.A48B99E5; Fri, 17
        Apr 2020 15:08:10 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200417140809eusmtip247323fbec38e30efe3efec7945989bbc~GoJcoSBqD2969929699eusmtip2g;
        Fri, 17 Apr 2020 14:08:09 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: aty128fb: remove unused 'sdr_64'
To:     Jason Yan <yanaijie@huawei.com>
Cc:     paulus@samba.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Message-ID: <aec78fff-4a5b-1222-7758-99e9ea892a0c@samsung.com>
Date:   Fri, 17 Apr 2020 16:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200417092318.13978-1-yanaijie@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87peO2bGGUzdqGqx8OFdZosrX9+z
        WfxffoXR4kTfB1aLy7vmsFmsObKY3WLRnk5mB3aPvd8WsHi0HHnL6nG/+ziTx9xdfYwenzfJ
        BbBGcdmkpOZklqUW6dslcGX8efCfqWAdV8WHjddZGxj/sXcxcnJICJhIzLg5C8jm4hASWMEo
        0djRwwrhfGGU2HZ7DzOE85lRYsqPp6wwLW17X7FAJJYzSmxpfQrV/5ZR4vmN/2BVbAJWEhPb
        VzGC2MICzhIv35wAWygioCzReH862A5mgTWMEsv3L2LqYuTg4BWwk7i+MQSkhkVAVeL/y/1g
        vaICERKfHhwGm8krIChxcuYTFhCbU8BS4ujSL8wgNrOAuMStJ/OZIGx5ieats8HOlhDYxi7x
        /eonFoizXSRmz5nPDGELS7w6vgUaAjISpyf3sEA0rGOU+NvxAqp7O9B1k/+xQVRZS9w594sN
        5FJmAU2J9bv0IcKOEkdXzWUGCUsI8EnceCsIcQSfxKRt06HCvBIdbUIQ1WoSG5ZtYINZ27Vz
        JfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzANHT6
        3/FPOxi/Xko6xCjAwajEw2vQMzNOiDWxrLgy9xCjBAezkgjvQTegEG9KYmVValF+fFFpTmrx
        IUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYy1i09uXZKsn8aeJjX1okTJrzkJbms1
        qtP3hnWlqkw//qr8iob1vWcb018/CH6tXCWmwmOqXjx5UdmCcPkZ/16aeE2zP8P3L1+4ROGN
        2YuIUNn4opXv/tyvfRv5OU2v181Ub8Kc2RXf9nUdTUqMFWDna68OMCned3HGC/+UqlOvuaVW
        fJu845ESS3FGoqEWc1FxIgDOsWHkPwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7peO2bGGfw9zG2x8OFdZosrX9+z
        WfxffoXR4kTfB1aLy7vmsFmsObKY3WLRnk5mB3aPvd8WsHi0HHnL6nG/+ziTx9xdfYwenzfJ
        BbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8
        efCfqWAdV8WHjddZGxj/sXcxcnJICJhItO19xdLFyMUhJLCUUeLP541ADgdQQkbi+PoyiBph
        iT/XuthAbCGB14wSk7aIg9hsAlYSE9tXMYLYwgLOEi/fnACbKSKgLNF4fzoriM0ssIZRYupE
        Noj5PYwSL063soHM5xWwk7i+MQSkhkVAVeL/y/1gc0QFIiQO75gFZvMKCEqcnPmEBcTmFLCU
        OLr0CzPETHWJP/MuQdniEreezGeCsOUlmrfOZp7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmDEbTv2c/MOxksbgw8xCnAwKvHwGvTMjBNiTSwrrsw9xCjB
        wawkwnvQDSjEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cBkkFcSb2hqaG5haWhubG5sZqEk
        ztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTFs/tTm4KT+u61rlC8nKsbq+kdN2vSuu+POvWjl
        vTb1C0SS2Fa1eehYpmkJWr0Ntv37e9+55pxj0g/jXFy46lfa/FLb9GG71V5fj6Sqznuztmkd
        Oxkcb/333/+krZeEDV8kGF/Rt8xbsdrpvbbkoUUzpxwytDuhtKRJKuy+U+bcqoarjk/qLiqx
        FGckGmoxFxUnAgBtblGRzgIAAA==
X-CMS-MailID: 20200417140810eucas1p1b57dacb13bd60223b474d37d5c3d12df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200417085705eucas1p12357601660992a5fbef90358cc7aa219
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200417085705eucas1p12357601660992a5fbef90358cc7aa219
References: <CGME20200417085705eucas1p12357601660992a5fbef90358cc7aa219@eucas1p1.samsung.com>
        <20200417092318.13978-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/20 11:23 AM, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/video/fbdev/aty/aty128fb.c:337:36: warning: ‘sdr_64’ defined but
> not used [-Wunused-const-variable=]
>  static const struct aty128_meminfo sdr_64 = {
>                                     ^~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Patch queued for v5.8, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/aty/aty128fb.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
> index d7e41c8dd533..d05d4195acad 100644
> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -334,20 +334,6 @@ static const struct aty128_meminfo sdr_128 = {
>  	.name = "128-bit SDR SGRAM (1:1)",
>  };
>  
> -static const struct aty128_meminfo sdr_64 = {
> -	.ML = 4,
> -	.MB = 8,
> -	.Trcd = 3,
> -	.Trp = 3,
> -	.Twr = 1,
> -	.CL = 3,
> -	.Tr2w = 1,
> -	.LoopLatency = 17,
> -	.DspOn = 46,
> -	.Rloop = 17,
> -	.name = "64-bit SDR SGRAM (1:1)",
> -};
> -
>  static const struct aty128_meminfo sdr_sgram = {
>  	.ML = 4,
>  	.MB = 4,
> 
