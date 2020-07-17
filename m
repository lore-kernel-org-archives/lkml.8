Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE2C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF102070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGQEiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:38:08 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:32859 "EHLO
        mx.tkos.co.il" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQEiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:38:08 -0400
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 3EE76440A64;
        Fri, 17 Jul 2020 07:38:04 +0300 (IDT)
Date:   Fri, 17 Jul 2020 07:38:02 +0300
From:   Baruch Siach <baruch@tkos.co.il>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] i2c: digicolor: Use fallthrough pseudo-keyword
Message-ID: <20200717043802.uvorspihdh6cvby3@tarshish>
References: <20200716220055.GA19603@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716220055.GA19603@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Thu, Jul 16, 2020 at 05:00:55PM -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

This URL is likely to break at some point as documentation contest changes. 
Just refer to in kernel Documentation/process/deprecated.rst file.

Other than that:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/i2c/busses/i2c-digicolor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
> index 332f00437479..f67639dc74b7 100644
> --- a/drivers/i2c/busses/i2c-digicolor.c
> +++ b/drivers/i2c/busses/i2c-digicolor.c
> @@ -187,7 +187,7 @@ static irqreturn_t dc_i2c_irq(int irq, void *dev_id)
>  			break;
>  		}
>  		i2c->state = STATE_WRITE;
> -		/* fall through */
> +		fallthrough;
>  	case STATE_WRITE:
>  		if (i2c->msgbuf_ptr < i2c->msg->len)
>  			dc_i2c_write_buf(i2c);

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
