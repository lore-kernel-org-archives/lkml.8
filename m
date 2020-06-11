Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB148C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53C62074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+nqjy+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFKFkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgFKFkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:40:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E4C08C5C1;
        Wed, 10 Jun 2020 22:40:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d6so1912194pjs.3;
        Wed, 10 Jun 2020 22:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N3UrA+L6fKKCkym6ASMJYc2jRNYVOVnvVJE5werYGnw=;
        b=d+nqjy+4dUFQIg+J7rUYD67mgnGPhyWqgBudPF6w+rSZlq/KfbJbVmdiKBinBCNo4e
         XqihGj7fGfpJUr9AKyRJuZsSPS4jAIVsR1RaqVH2ri3bGI96f1OqmAExijXBGJQFjeVZ
         5mDhEDzq4LQr9cpcqVVEZY2AhNa09dLlmdJtwIyyFwDLmBV+8JEU9VCN/CExVS6JJDH3
         p3rfO81wkPJOcva7I/m0r0SqGwAFOmvPF8pmNAgkn/TWFTgGlKhzeiuHYBhLFEs9fknD
         mH9D1QR0KZ8xgTFHImkXGpHF/YYlRi8ZUCQtZfZ9atnvpBYBI2w4YgNs+7KES9d0Hf3K
         gxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3UrA+L6fKKCkym6ASMJYc2jRNYVOVnvVJE5werYGnw=;
        b=HXMhygv5tr/iRFQV1lTdKZgBWzhglkFT34l4m34Lf4leK8Q/5oTw9JJCgclQ8EZE/7
         jaJeEK3Vmd2IhxFyexmGmf+jKk0dxJiWVy4g1ocuPegaW+o3rOLELYlafGWTt0gOJ7+V
         yuvUlULNKLzHfOU72cMVtm2zOKkzJkrEJZr7XweKlqnQOq25CviI6oZnwbCpKnLmDSyi
         RZQE0aFJmlzKbrfPFY2jG/c+jTxEQOVrr9tMY0STTV2N8Cp3fjWCufD3iXcV5UjN3A8t
         biuQvvddraGiI2c6BQEJ+mqefl0caPS8/BFBo6QLrn48z/NdMr/i2ogObFIvRujyqBDO
         nugQ==
X-Gm-Message-State: AOAM531sfJD6gs54YbSRncjv2aGQl+0gLjWyaryy7PB/cIQhdHRE0d+6
        h+7oNqNd++L+7SkZfldXUd1Ej09x2CfB/nmH
X-Google-Smtp-Source: ABdhPJy15V32sZVFTROxJJwV3ePEVFwMYm9dYGuNHyquDslsLMT4bbOHF9vhKYSZ75x5MpfJBaampg==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr5772701plp.19.1591854005732;
        Wed, 10 Jun 2020 22:40:05 -0700 (PDT)
Received: from home-desktop ([114.204.138.55])
        by smtp.gmail.com with ESMTPSA id s1sm1392337pjp.14.2020.06.10.22.40.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 22:40:04 -0700 (PDT)
Date:   Thu, 11 Jun 2020 14:40:00 +0900
From:   Hyeonki Hong <hhk7734@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>, khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] pinctrl: meson: fix drive strength register and bit
 calculation
Message-ID: <20200611053958.GA3687@home-desktop>
References: <20200610041329.12948-1-hhk7734@gmail.com>
 <1jo8prnk2x.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jo8prnk2x.fsf@starbuckisacylon.baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 03:09:42PM +0200, Jerome Brunet wrote:
> 
> On Wed 10 Jun 2020 at 06:13, hhk7734@gmail.com wrote:
> 
> > From: Hyeonki Hong <hhk7734@gmail.com>
> >
> > If a GPIO bank has greater than 16 pins, PAD_DS_REG is split into two
> > registers. However, when register and bit were calculated, the first
> > register defined in the bank was used, and the bit was calculated based
> > on the first pin. This causes problems in setting the driving strength.
> >
> > Solved the problem by changing the bit using a mask and selecting the
> > next register when the bit exceeds 15.
> 
> This fixes the case of GPIOX on g12 which goes up to 18 yes but the same
> problem will happen again a if bank ever goes past 31 pins. In such case
> the problem would apply to all reg types.
> 
> I would prefer if it was solved in a more generic fashion, like defining
> a "stride" table with the values of each reg type. This table can common
> to all aml SoCs for now but eventually it probably need to be SoC
> specific.
> 
> This would allow to :
> A) handle the case you are reporting in a generic (future proof) way
> B) remove the weird "bit = bit << 1;" calc in place in the get/set of
> the drive strengh pinconf

If all amlogic SoC has same register style, I think the code below is fine.

static const unsigned int meson_bit_strides[] = {
	0, 0, 0, 0, 0, 1, 0
};

static void meson_calc_reg_and_bit(struct meson_bank *bank, unsigned int pin,
				   enum meson_reg_type reg_type,
				   unsigned int *reg, unsigned int *bit)
{
	struct meson_reg_desc *desc = &bank->regs[reg_type];

	*bit = (desc->bit + pin - bank->first) << meson_bit_strides[reg_type];
	*reg = (desc->reg + (*bit / 32)) * 4;
	*bit &= 0x1f;
}

How about this?

> >
> > Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
> > ---
> >  drivers/pinctrl/meson/pinctrl-meson.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> > index bbc919bef2bf..ef66239b7df5 100644
> > --- a/drivers/pinctrl/meson/pinctrl-meson.c
> > +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> > @@ -98,6 +98,13 @@ static void meson_calc_reg_and_bit(struct meson_bank *bank, unsigned int pin,
> >
> >  	*reg = desc->reg * 4;
> >  	*bit = desc->bit + pin - bank->first;
> > +
> > +	if (reg_type == REG_DS) {
> > +		if (*bit > 15) {
> > +			*bit &= 0xf;
> > +			*reg += 4;
> > +		}
> > +	}
> >  }
> >
> >  static int meson_get_groups_count(struct pinctrl_dev *pcdev)
> 
