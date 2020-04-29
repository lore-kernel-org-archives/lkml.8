Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A4C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5776820757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2Rmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:42:50 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:40896 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2Rmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:42:50 -0400
Received: from [192.168.42.210] ([93.22.38.239])
        by mwinf5d58 with ME
        id Yhig2200R59bE5H03hig2Q; Wed, 29 Apr 2020 19:42:48 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 29 Apr 2020 19:42:48 +0200
X-ME-IP: 93.22.38.239
Subject: Re: [PATCH] video: fbdev: pxa3xx_gcu: Fix some resource leak in an
 error handling path in 'pxa3xx_gcu_probe()'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        mpe@ellerman.id.au, zhenzhong.duan@gmail.com, arnd@arndb.de,
        tglx@linutronix.de, eric.y.miao@gmail.com, daniel@caiaq.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200429043438.96212-1-christophe.jaillet@wanadoo.fr>
 <20200429122538.GO2014@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <0db91149-fa85-6ec3-1787-d5effd41a1b9@wanadoo.fr>
Date:   Wed, 29 Apr 2020 19:42:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429122538.GO2014@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/04/2020 à 14:25, Dan Carpenter a écrit :
> On Wed, Apr 29, 2020 at 06:34:38AM +0200, Christophe JAILLET wrote:
>> If an error occurs in the loop where we call 'pxa3xx_gcu_add_buffer()',
>> any resource already allocated should be freed.
>>
>> In order to fix it, add a call to 'pxa3xx_gcu_free_buffers()' in the error
>> handling path, as already done in the remove function.
>>
>> Fixes: 364dbdf3b6c3 ("video: add driver for PXA3xx 2D graphics accelerator")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/video/fbdev/pxa3xx-gcu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
>> index 4279e13a3b58..68d9c7a681d4 100644
>> --- a/drivers/video/fbdev/pxa3xx-gcu.c
>> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
>> @@ -675,6 +675,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
>>   
>>   err_disable_clk:
>>   	clk_disable_unprepare(priv->clk);
>> +	pxa3xx_gcu_free_buffers(dev, priv);
> The error handling in this function makes no sense and is buggy.  It
> should be that it unwinds in the reverse order from the allocation.  The
> goto should be "goto free_most_recently_allocated_resource;".  Since the
> unwind is done in the wrong order it causes a couple bugs.
>
> These buffers are the last thing which we allocated so they should be
> the first thing which we free.  In this case, calling
> pxa3xx_gcu_free_buffers() before the buffers are allocated is confusing
> but harmless.  The clk_disable_unprepare() is done on some paths where
> the clock was not enabled and that will trigger a WARN() so that's a
> bug.  Syzcaller will complain and if you have reboot on WARN then it's
> annoying.
>
> The second bug is that we don't deregister the misc device or release
> the DMA memory on failure when we allocate the buffers in the loop.
>
> regards,
> dan carpenter
>
Agreed. I've been a little too fast on this one.
I'll update it.

Thx for the review.

CJ


