Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB086C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78771206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgD0CRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 22:17:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbgD0CRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:17:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7F4CD604439C8E50E61F;
        Mon, 27 Apr 2020 10:17:40 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 10:17:29 +0800
Subject: Re: [PATCH] staging: rtl8723bs: remove set but not used
 'pregistrypriv'
To:     <gregkh@linuxfoundation.org>, <hariprasad.kelam@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
References: <20200426094334.24346-1-yanaijie@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <d141d9e7-5310-672a-9ffd-6be1b448261a@huawei.com>
Date:   Mon, 27 Apr 2020 10:17:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200426094334.24346-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, it has already been fixed by YueHaibing. Please ignore this.

在 2020/4/26 17:43, Jason Yan 写道:
> Fix the following gcc warning:
> 
> drivers/staging/rtl8723bs/hal/sdio_halinit.c:547:24: warning: variable
> ‘pregistrypriv’ set but not used [-Wunused-but-set-variable]
>    struct registry_priv *pregistrypriv;
>                          ^~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> index 7853af53051d..e42d8c18e1ae 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> @@ -544,13 +544,9 @@ static void _InitRetryFunction(struct adapter *padapter)
>   
>   static void HalRxAggr8723BSdio(struct adapter *padapter)
>   {
> -	struct registry_priv *pregistrypriv;
>   	u8 valueDMATimeout;
>   	u8 valueDMAPageCount;
>   
> -
> -	pregistrypriv = &padapter->registrypriv;
> -
>   	valueDMATimeout = 0x06;
>   	valueDMAPageCount = 0x06;
>   
> 

