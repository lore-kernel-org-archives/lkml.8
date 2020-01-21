Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C256C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4121B217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nE5+BnUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAUJEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:04:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59805 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:04:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200121090432euoutp02f7b7ebd0e3075913118ae5a0733723b4~r24goDlKk0390003900euoutp02F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 09:04:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200121090432euoutp02f7b7ebd0e3075913118ae5a0733723b4~r24goDlKk0390003900euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579597472;
        bh=ifddvjexljeaaOXd6+kau9EW+a8o6z/1Nn9174QwJXc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nE5+BnUtvRUUkZDbaBz2s+ZM60KHDxdyVZPjZby7XbP0gap7v5VHyhVBcjFtx62Q2
         q6Dai44pGFRGntxgjEdDMf3GmBIqbQYTupiJB1rSe1szvn33kpobgqWACCc8ELmZve
         qv9d/FXCS5lHpQH//nrUWeqRy2987UD+lKVqWqLI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200121090431eucas1p2a612a10162a53f7f9a81a8f880584e57~r24gUCaZk2181921819eucas1p2K;
        Tue, 21 Jan 2020 09:04:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.39.60679.F9EB62E5; Tue, 21
        Jan 2020 09:04:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121090431eucas1p298648de3b791714802d433caf17352c1~r24fr1Vr62054420544eucas1p23;
        Tue, 21 Jan 2020 09:04:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200121090431eusmtrp23b6e2f338f4a6035ac1c7b096bac1b8b~r24fq7Jw-2280922809eusmtrp2J;
        Tue, 21 Jan 2020 09:04:31 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-7c-5e26be9f8042
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C0.75.08375.F9EB62E5; Tue, 21
        Jan 2020 09:04:31 +0000 (GMT)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200121090430eusmtip102ee2f0654405702bfc40ae1f99dfc10~r24e3qjOz1475114751eusmtip1y;
        Tue, 21 Jan 2020 09:04:30 +0000 (GMT)
Subject: Re: [PATCH v4 1/3] drm: bridge: adv7511: Remove DRM_I2C_ADV7533
 Kconfig
To:     Bogdan Togorean <bogdan.togorean@analog.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, gregkh@linuxfoundation.org,
        tglx@linutronix.de, sam@ravnborg.org, alexander.deucher@amd.com,
        matt.redfearn@thinci.com, robdclark@chromium.org,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <c10a8079-e9d7-0c18-c31b-353e2af1efa0@samsung.com>
Date:   Tue, 21 Jan 2020 10:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121082719.27972-2-bogdan.togorean@analog.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc+dOp0NDcSgoJy5RGyXRgCiguVFEcYmT+OBCSIxEsOqwRCik
        FRQftC4guBQVlwBKK7sIwYBFrEGwGhDRBhAEDBENqIALMRYJuGDb0cjbd//zn3Puf3NZrLjK
        zGRj1QcEjVoVp2RkdE3juNXX8MA7YmlHiR85Z22myJXe+xJyPPUSJpM1FzDpGB1hyImCSoZ0
        jg1h0vypkyYZFwql5IX5GkOKutooYu4zUsSiDycvx/sxSa17LCWl4yZEqqsuY6K3blqr4FPb
        fzH8cGcIX55XjviR7lQpn6tro/m670aaz03PlvBVZRkM/+R8O8V/sVql/N3vbyR8/fVyKd93
        poniC690Mvz7G5U033Aui96q2CkL2ifExSYLGr/g3bKYhuxJKjGPOvQ6P43WoRF0GrmwwAWC
        ruu0nWWsgitFMGKoZcSDDUH+RTMtHr4h6M14a6+wzpa8U26iXoKg/1HJX9NnBK1fm7Bjrge3
        HbJ/WCUO9uRCYfRrltOEOT0GW8Uxp4nhFsGv6h7GwXIuGO4OW5xMcwvhUnEx5eDp3A4Y6OiX
        iB53aM4eoB3swq2Fj/pep465uXDClItF9oJXAwbKsQy4ZyycbdXTYtINUDqWyYjsAcNNd6Qi
        z4bJewZK5KPQV3oSi83pCEy372GxsAp6rRPO/Nh+60qznyiHQEuajRafxQ26P7uLd3CDizVX
        sSjLIT1NIbrnQ99z09+BXlDUOsqcR8qcKclypqTJmZIm5/9eI6LLkJeQpI2PFrT+auHgEq0q
        Xpukjl6yNyG+Ctm/a8vvJlstMv/cY0Eci5Su8sGshREKiSpZmxJvQcBipafceNwuyfepUg4L
        moRITVKcoLWgWSyt9JIH5A/tUnDRqgPCfkFIFDT/qhTrMlOH5r1NeroxM6rW/YHhfsiE7Oaa
        I+EtwT+fP/u9vn5w9+qVCxI0tq6C6IAtQzPoqCCNP1Pv57vsXWN4SnFbaGBmQWSJYfbyTH9v
        756Hjaayupo3rivObE9PS5T98Jzma9K3j60fdDf67/eJY8OGNk9sM+kGwtS3girW7fkQ4ju/
        as5Bn5VKWhujWrYYa7SqP+EfD+2qAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85O5vm4rgpvkmQLEwKmh2vr6VmRHQEP0RGSV6XntRyTnam
        aZ9EW15CUVNps+YstRLN8hqal1akFq1caVqWYSY0Mw3S8JZNV+C3H8//+fHwwF+Ai+7ynAWJ
        ySpWmSxLkpC2xIs/fR/3Vnbvito3fo1EBcYBDJWPdfJQlroUR2ttxTh6Oz9LouxbjSQa+v0N
        RwPfhwiUV1zNR286rpOo5t0ghjrG9RgyFIaj4cUvOFJ3PeWjO4utADU3leGo0Hg0SMSoTask
        Yx46xNTr6gEzO6LmMxWZgwTTtaAnmIpcDY9pqssjmf4iE8b8MBr5TPvCZx7Tc6Oez4xf6cOY
        6vIhkpmqaiSY3oKrxDHRaam/UpGqYl0SFJwqQBJOIw8p7YekHl5+UtrTN3K/h7fEPdA/jk1K
        TGOV7oEx0oRezRqWosPSP928TGSCWZAPBAJIeUFdztZ8YCsQUTUAmvt1/HxgY5k7wc7KGdzK
        YrgynE9al6YBXB4z89YDMXUcapaNG+xAhcKfqyMbMk4V4vDlkqtVGACwqspIrAcktRuuNo+S
        6yykAmG72bDBBOUKS2trsXV2pMLgzPIoz7pjDwc0kxuuDRUEpwvHeNYDbnBFZ8KtvANmt1b8
        Yyf4frISKwIi7SZdu0nRblK0mxQ9IOqAA5vKyePlHC3lZHIuNTleGquQNwFLTdqeLTY/BKYH
        oQZACYDEThhU7hol4snSuAy5AUABLnEQ6rMsI2GcLOMiq1REK1OTWM4AvC3PFePOjrEKS+mS
        VdG0N+2L/GhfT19PHyRxEuZSjyNEVLxMxZ5n2RRW+d/DBDbOmSD3dvpXuTFmbu6J0aWlUVtu
        H9ztR7bYhXAh5z6E1Nos1flI2l4H7+x/RcY2q6fmJxvuZW3JwztNE+NebtuT2koiqEt6U445
        26A6GynetpgepDnFTTeIc+1d6cCQIwdyDg8HkLJfz93FfSfLRBM9hvt5JdlU1cGwfvGJJfWZ
        RxckBJcgo/fgSk72Fx9v7Hg8AwAA
X-CMS-MailID: 20200121090431eucas1p298648de3b791714802d433caf17352c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121083857eucas1p2d62144f4f264cf751def772341a72c9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121083857eucas1p2d62144f4f264cf751def772341a72c9b
References: <20200121082719.27972-1-bogdan.togorean@analog.com>
        <CGME20200121083857eucas1p2d62144f4f264cf751def772341a72c9b@eucas1p2.samsung.com>
        <20200121082719.27972-2-bogdan.togorean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2020 09:27, Bogdan Togorean wrote:
> This commit remove DRM_I2C_ADV7533 resulting a simpler driver and less
> choices in Kconfig.
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

