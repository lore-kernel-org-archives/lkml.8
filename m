Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99547C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B65206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UQYFZcj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgFJNJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgFJNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:09:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF209C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:09:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so1941959ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hN4wVu7c1HZmNsRAprCKs7uo3bA/4E5kOO/AWz4PAB4=;
        b=UQYFZcj9mxtPTw97Es6oj/OR2iUlY5qrWDFvHpq+VMTee2QWT4CLG91bil7g+DNOKx
         l42eEyiPdTPNNWDIoPNk92GG2j+9fXAGij9RGHwrBITksWgbiVYw5wh8YJ0dJXUI6mDQ
         2bw5QharfQ0PkAald8DvcQLnahJJ5HVACQzJHNqWklEjILxX0+eBMSDfYEAwXl/VlspO
         Oi9qb8oDP5tdGz0apkqlG2sSxkM4o8YqMPfufdz0MQCFxmpZ448b0L0Y0wwaQx3SiyKa
         PodYSusNWy31wlSxvBNYKeaQxBDQ/EwKkM3apQgvVYtyBW0GX7c01SpdjNplstjh4tv0
         xa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hN4wVu7c1HZmNsRAprCKs7uo3bA/4E5kOO/AWz4PAB4=;
        b=KlHevEzbR+8EbY368RHom6lg21QCg+4rAUuVpoRwJxjiVXAGDf1C6cWR8nSvJP67g6
         AHFF+GM93Wyiv7Ja31Xov2IBvavV/E/J5sQVJuWPrrmOTDNH4g7poCVdPfnQ/0KACJxC
         7afA6I7xFJ3viQ+objfV7kSCuk2aMtRMx5EebDmumbMINbei4sph5elfcGrkb3ZcVckD
         V/CnL5tF6WPfyV4DtrDU9r08TWiyv6s75u7NjOysHUMx/iaTucRs2sqd/5IMIT2ezdLS
         u/a5SQ5yRAkzrH+dfKA+5HKILouoYAMzEgGxAdpZE/3N+RIiGARmC5+M9Kzap28V91iq
         FY7w==
X-Gm-Message-State: AOAM531SF+n9aWZAIpO1BQIDKO7c4GPbiPCUevaH5nDDKR7XOMh8n51W
        dDDl4UTq2H2XZ3/oXGMbh9MMdyHT4sk=
X-Google-Smtp-Source: ABdhPJwFedDlbzm+dYX6gyNm93Xyr1Jcg5woX1Qp7tJ8WSlNK7uiPvjIAx6Ib7uFiK7cAaMr2dIeUA==
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr3246267ejr.436.1591794585380;
        Wed, 10 Jun 2020 06:09:45 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id ox27sm15373147ejb.101.2020.06.10.06.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 06:09:43 -0700 (PDT)
References: <20200610041329.12948-1-hhk7734@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     hhk7734@gmail.com, linus.walleij@linaro.org, khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] pinctrl: meson: fix drive strength register and bit calculation
In-reply-to: <20200610041329.12948-1-hhk7734@gmail.com>
Date:   Wed, 10 Jun 2020 15:09:42 +0200
Message-ID: <1jo8prnk2x.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 10 Jun 2020 at 06:13, hhk7734@gmail.com wrote:

> From: Hyeonki Hong <hhk7734@gmail.com>
>
> If a GPIO bank has greater than 16 pins, PAD_DS_REG is split into two
> registers. However, when register and bit were calculated, the first
> register defined in the bank was used, and the bit was calculated based
> on the first pin. This causes problems in setting the driving strength.
>
> Solved the problem by changing the bit using a mask and selecting the
> next register when the bit exceeds 15.

This fixes the case of GPIOX on g12 which goes up to 18 yes but the same
problem will happen again a if bank ever goes past 31 pins. In such case
the problem would apply to all reg types.

I would prefer if it was solved in a more generic fashion, like defining
a "stride" table with the values of each reg type. This table can common
to all aml SoCs for now but eventually it probably need to be SoC
specific.

This would allow to :
A) handle the case you are reporting in a generic (future proof) way
B) remove the weird "bit = bit << 1;" calc in place in the get/set of
the drive strengh pinconf

>
> Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index bbc919bef2bf..ef66239b7df5 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -98,6 +98,13 @@ static void meson_calc_reg_and_bit(struct meson_bank *bank, unsigned int pin,
>
>  	*reg = desc->reg * 4;
>  	*bit = desc->bit + pin - bank->first;
> +
> +	if (reg_type == REG_DS) {
> +		if (*bit > 15) {
> +			*bit &= 0xf;
> +			*reg += 4;
> +		}
> +	}
>  }
>
>  static int meson_get_groups_count(struct pinctrl_dev *pcdev)

