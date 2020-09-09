Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DBBC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BCC21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIIT0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:26:55 -0400
Received: from mail.v3.sk ([167.172.186.51]:57254 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbgIIT0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:26:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E852BDF974;
        Wed,  9 Sep 2020 19:25:33 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gTEcDb4Rjddo; Wed,  9 Sep 2020 19:25:32 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9FD99DF97D;
        Wed,  9 Sep 2020 19:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FXNrgybvDadD; Wed,  9 Sep 2020 19:25:32 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 46CDBDF974;
        Wed,  9 Sep 2020 19:25:32 +0000 (UTC)
Date:   Wed, 9 Sep 2020 21:26:49 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: ene-kb3930: Make symbol 'kb3930_power_off'
 static
Message-ID: <20200909192649.GA1105946@demiurge.local>
References: <20200909143253.66168-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909143253.66168-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 10:32:53PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/mfd/ene-kb3930.c:36:15: warning:
>  symbol 'kb3930_power_off' was not declared. Should it be static?
> 
> This variable is not used outside of ene-kb3930.c, this commit
> marks it static.
> 
> Fixes: 753bd752e181 ("mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

Thank you!
Lubo

> ---
>  drivers/mfd/ene-kb3930.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
> index 1c32ff586816..eb7312bd6361 100644
> --- a/drivers/mfd/ene-kb3930.c
> +++ b/drivers/mfd/ene-kb3930.c
> @@ -33,7 +33,7 @@ struct kb3930 {
>  	struct gpio_descs *off_gpios;
>  };
>  
> -struct kb3930 *kb3930_power_off;
> +static struct kb3930 *kb3930_power_off;
>  
>  #define EC_GPIO_WAVE		0
>  #define EC_GPIO_OFF_MODE	1
> 
