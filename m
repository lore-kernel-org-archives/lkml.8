Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13723C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE6E20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCTKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:47:24 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:58422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726955AbgCTKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:47:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 73F96182CF66A;
        Fri, 20 Mar 2020 10:47:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plant48_233358f93502b
X-Filterd-Recvd-Size: 2147
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 10:47:21 +0000 (UTC)
Message-ID: <f957b11abb70457e7bd8c2652d41e7f07024e301.camel@perches.com>
Subject: Re: [PATCH v11 08/12] pwm: stm32-lp: Use %llu format specifier for
 period
From:   Joe Perches <joe@perches.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Date:   Fri, 20 Mar 2020 03:45:35 -0700
In-Reply-To: <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
         <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-19 at 18:41 -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's
> datatype to u64, prepare for this transition by using the right
> specifier for printing a 64-bit value.
[]
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
[]
> @@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	do_div(div, NSEC_PER_SEC);
>  	if (!div) {
>  		/* Clock is too slow to achieve requested period. */
> -		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
> +		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
>  		return -EINVAL;
>  	}

Doesn't this introduce a warning now without the
actual change to the type of state->period?

Likely these patches should either not be separated
or this should also use a cast to avoid introducing
intermediate compilation warnings.


