Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E84C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E472075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ADQBlNiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgHUNi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:38:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51878 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgHUNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:38:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200821133850euoutp01e4c8cc24e314e14c4600614255c27818~tTB0bAvGh2915129151euoutp01V
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200821133850euoutp01e4c8cc24e314e14c4600614255c27818~tTB0bAvGh2915129151euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598017130;
        bh=PKDp4H0K8uyocu7NrFxiqQ4LluS5nl44yexs6EOXu0w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ADQBlNiRT6H4+nd6odQYVYj5TWyHLgs0gZ2np3pADtOwQsvPb/5aqZgJwS1Ncvovr
         1OOGsD8XoLofSZorTuxYdJDJLUb+fGv78e6Mrg1qaz8HFbino5iCxnvY788zPcewg0
         HJTMvWcX8HXvYlvFxvAPGptFjHkXdGKzTYbCOyAM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821133850eucas1p294fd936bcd85ec542b9338f3109cd763~tTBz_Sp0E2703427034eucas1p2l;
        Fri, 21 Aug 2020 13:38:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.7A.06456.A6ECF3F5; Fri, 21
        Aug 2020 14:38:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821133849eucas1p1c5312c4053aac0878841b048755991b5~tTBzqvsBZ0285102851eucas1p1B;
        Fri, 21 Aug 2020 13:38:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200821133849eusmtrp17099eddedfe77d945724c5cd1d30d153~tTBzqHfDc0848908489eusmtrp1f;
        Fri, 21 Aug 2020 13:38:49 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-64-5f3fce6a8eea
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.28.06314.96ECF3F5; Fri, 21
        Aug 2020 14:38:49 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200821133849eusmtip1dab3a1fdf015c62eedc9b014cb4f8d45~tTBzUQE5p1814218142eusmtip1O;
        Fri, 21 Aug 2020 13:38:49 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y
 && PPC_PMAC=n
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, sam@ravnborg.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <cd4324bb-67f7-5ae0-af7b-42681d72d85f@samsung.com>
Date:   Fri, 21 Aug 2020 15:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200821104910.3363818-1-mpe@ellerman.id.au>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87pZ5+zjDS4t57BY+PAus8WVr+/Z
        LE70fWC1uLxrDpvF/xtvWCy2NBxis1jxcyujA7vHopcNLB57vy1g8bjffZzJY+Wli+weS6Zd
        ZfP4vEkugC2KyyYlNSezLLVI3y6BK6Pr9SW2goPcFW9evGRpYNzH2cXIySEhYCIxafcWVhBb
        SGAFo8S651FdjFxA9hdGield+9ggnM+MErffdbPAdBy/vZURIrGcUeLj91PMEO1vGSU2N3iA
        2MICURJLz15hA7FFBDQlru5exgrSwCywlFHiyeOFTCAJNgEriYntqxhBbF4BO4neZY1AcQ4O
        FgFViYZeVZCwqECExKcHh1khSgQlTs58AnYEJ1DrsmtXweYzC4hL3HoynwnClpdo3jqbGWSX
        hMA+dolrTZuZIK52kfg78yIzhC0s8er4FnYIW0bi9OQeFoiGdYwSfzteQHVvZ5RYPvkfG0SV
        tcSdc7/YQK5jBnpn/S59EFNCwFFi+zdeCJNP4sZbQYgb+CQmbZvODBHmlehoE4KYoSaxYdkG
        NpitXTtXMk9gVJqF5LNZSL6ZheSbWQhrFzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/d
        xAhMRaf/Hf+0g/HrpaRDjAIcjEo8vD8O2ccLsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUo
        P76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbGRWzNhav5xL9GS2aVBOaI
        X3OK2Cs1wV69K/6o2qRFi5atDW5Nzv3oyMrhMsN727m0f3qxMwutvHqPXKt4vTd5O0POZIFb
        7z2FytvYbr6TuqbR3VDxI23t86pjF7/tElywKmK1bbih0+tr62tsW1nPBoiqP93udEJFnydX
        su7H8a6ViZNX1i1RYinOSDTUYi4qTgQAAktlTUEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7qZ5+zjDY5sNLRY+PAus8WVr+/Z
        LE70fWC1uLxrDpvF/xtvWCy2NBxis1jxcyujA7vHopcNLB57vy1g8bjffZzJY+Wli+weS6Zd
        ZfP4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
        3y5BL6Pr9SW2goPcFW9evGRpYNzH2cXIySEhYCJx/PZWxi5GLg4hgaWMEps3HmbpYuQASshI
        HF9fBlEjLPHnWhcbRM1rRomvc7aygySEBaIkbkx9xghiiwhoSlzdvYwVpIgZZNDL2UfYITp6
        GSU+bOljA6liE7CSmNi+CqyDV8BOondZIxPINhYBVYmGXlWQsKhAhMThHbOgSgQlTs58wgJi
        cwK1Lrt2FWwMs4C6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUmoWkfRaSlllIWmYhaVnAyLKK
        USS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMP62Hfu5eQfjpY3BhxgFOBiVeHh/HLKPF2JNLCuu
        zD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOg3yYyS4km5wNTQ15JvKGpobmFpaG5
        sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkb/oFvq71tmTP5vdmG9Q77Iogjvi6t3
        ZYhr+6Xv2HKUn/l6nv1dQ74G9iUPV4hPaFv+9NGjnVZNCpVLjeuqUj48bYv/lWJcyqH0buvc
        PVJS6/b/c+L8328i3bbzt+NJoQ2mPfHuL2Tmer1/eMn+TfnU23J7s33zZOpmCLZc3SN47mSJ
        vuIJlSolluKMREMt5qLiRABNJS5i1QIAAA==
X-CMS-MailID: 20200821133849eucas1p1c5312c4053aac0878841b048755991b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821104924eucas1p1e4b848e88fe460b9b7063669714a36f3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821104924eucas1p1e4b848e88fe460b9b7063669714a36f3
References: <CGME20200821104924eucas1p1e4b848e88fe460b9b7063669714a36f3@eucas1p1.samsung.com>
        <20200821104910.3363818-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/21/20 12:49 PM, Michael Ellerman wrote:
> The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:
> 
>   linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
>   linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
>     276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
>         |  ^~~~~~~~~~~~~~~~~~~~
> 
> Fix it by including btext.h whenever CONFIG_BOOTX_TEXT is enabled.
> 
> Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for fixing this.

> ---
>  drivers/video/fbdev/controlfb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Does anyone mind if I apply this via the powerpc tree for v5.9?
> 
> It would be nice to get the build clean.

No objections from my side.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> cheers
> 
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
> index 9c4f1be856ec..547abeb39f87 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -49,6 +49,8 @@
>  #include <linux/cuda.h>
>  #ifdef CONFIG_PPC_PMAC
>  #include <asm/prom.h>
> +#endif
> +#ifdef CONFIG_BOOTX_TEXT
>  #include <asm/btext.h>
>  #endif
>  
