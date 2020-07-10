Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C24C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6CB20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGJKsz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:48:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:27836 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgGJKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:48:51 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmAvw4TuZw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id V07054w6AAmb7rG
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 10 Jul 2020 12:48:37 +0200 (CEST)
Subject: Re: [PATCH] [stable v5.4.x] pwm: jz4740: Fix build failure
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20200710102758.8341-1-u.kleine-koenig@pengutronix.de>
Date:   Fri, 10 Jul 2020 12:48:36 +0200
Cc:     stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de
Content-Transfer-Encoding: 8BIT
Message-Id: <DB8C7C01-0FBB-4A9F-B068-15C06BBC0873@goldelico.com>
References: <20200710102758.8341-1-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 10.07.2020 um 12:27 schrieb Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
> 
> When commit 9017dc4fbd59 ("pwm: jz4740: Enhance precision in calculation
> of duty cycle") from v5.8-rc1 was backported to v5.4.x its dependency on
> commit ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver") was not
> noticed which made the pwm-jz4740 driver fail to build.

Please can you add my "reported by?"

> As ce1f9cece057 depends on still more rework, just backport a small part
> of this commit to make the driver build again. (There is no dependency
> on the functionality introduced in ce1f9cece057, just the rate variable
> is needed.)

BR and thanks,
Nikolaus

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> @Paul: Can you please check this is correct? I only build-tested this
> change.
> 
> Best regards
> Uwe
> 
> drivers/pwm/pwm-jz4740.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index d0f5c69930d0..77c28313e95f 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -92,11 +92,12 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> {
> 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> 	unsigned long long tmp;
> -	unsigned long period, duty;
> +	unsigned long rate, period, duty;
> 	unsigned int prescaler = 0;
> 	uint16_t ctrl;
> 
> -	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
> +	rate = clk_get_rate(jz4740->clk);
> +	tmp = rate * state->period;
> 	do_div(tmp, 1000000000);
> 	period = tmp;
> 
> -- 
> 2.27.0
> 

