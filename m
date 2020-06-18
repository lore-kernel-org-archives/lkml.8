Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B635C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E775B21924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgCF78Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgFRKHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgFRKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:07:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D9C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:07:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so5385608wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CFOLMWfnNmFWmCXS3WsnXqGGhFh9R4n2y1mrs4wYTgA=;
        b=GgCF78UooGPORKj/H4XaMSc4Y4I+eLXTUWWmfn0WjNS8INYWIrt2KXINC3elkIU17Y
         Ska7Aks45lBvcbC1FcEJUtYMoo39TjLPdfNuIOF/ChQdvUIx6SGtNUOGK/EM+AOQX9ds
         rytLxdcpBhl+dXv4/FQIJxiDseItcrjjJwFLGYX9kjGmyRXijNMP3s/qaFpQ/6qDVUGh
         8rrsyawXqhnV8dfbE1IBdv1HX/o5zx1dGKErWNzrJhyfcwytBTf3dkP6iZv4pbmfg6Jg
         dszGi5s7g9xHYNvO0nHlDNuduhVht2B5Fuaznix9U6eJjGiO0/CwmYwXGilO6hV2rYE0
         z7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CFOLMWfnNmFWmCXS3WsnXqGGhFh9R4n2y1mrs4wYTgA=;
        b=isvwYPfhnQhc8C0fp7n9gSY0U/EJQLB5uxUt/46LaAmxUpb2WFpCcNbjea45O3IV2n
         Q8H872SfkHcJIuGe0AQzKuViEi4/CgSh/AHTjpK5ci7AR6SvOIEQpGMmtFbNxha7rcTv
         K5Pa4M85NoxJTmh/FXOCoN9IlNzXtUhATIIpgOxgQB/kZ63NPoVG6sT9XfBkXkydgVav
         dKPBQ9KoOhWasUdakd5gB5UBw7N93wXqWuw8K8RNAIycuoid7NwN8UhGjApMzaLjDxZ9
         deX59KeLwKMpj9IUebWNhPUK60KBsZcegfz3zBdQbItcLLzantj6fc2Zeuw484Yn6hf4
         MStQ==
X-Gm-Message-State: AOAM5308/1WEwak9fjmI7hzsecb41Sp9MEcCaGSOmE3NOwDNRY1MfjpR
        jCvu0gENXVFRaauR48JBc0EHUW9XtHg=
X-Google-Smtp-Source: ABdhPJzlq2IdBCf7tWdObGbMg3Qcc+qq3lOP6ca5ooyu3bmJhva9X2SKsFPQvT65ZKC1Nhcs24Bwmw==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr3582258wrs.235.1592474826529;
        Thu, 18 Jun 2020 03:07:06 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id c66sm3007519wma.20.2020.06.18.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:07:05 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:07:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     michael@walle.cc, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
Message-ID: <20200618100704.GC954398@dell>
References: <20200618080223.951737-1-lee.jones@linaro.org>
 <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020, Arnd Bergmann wrote:

> On Thu, Jun 18, 2020 at 10:03 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > The existing SYSCON implementation only supports MMIO (memory mapped)
> > accesses, facilitated by Regmap.  This extends support for registers
> > held behind I2C busses.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> The implementation looks fine to me, but can you explain how this is going to
> be used, and what the advantage is over open-coding the devm_regmap_init_i2c()
> in each driver that would use this?

Does Regmap let you register/initialise an I2C address more than once?

When I attempt it, I get:

[    0.522988] i2c i2c-0: Failed to register i2c client tmp105 at 0x32 (-16)
[    0.523341] i2c i2c-0: of_i2c: Failure registering /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32
[    0.523691] i2c i2c-0: Failed to create I2C device for /bus@4000000/motherboard/iofpga@7,00000000/i2c@16000/temp@32

> Is this about using proper locking through the regmap framework for
> shared i2c clients, or to reduce memory consumption when lots of drivers
> access the same regmap?

All of those things are valid.

My use-case is regarding MFDs sharing an I2C interfaced address space
with their children.

> My impression of the existing syscon code is that the main value-add over
> other ways of doing the same is the syscon_regmap_lookup_by_phandle()
> interface that gives other drivers a much simpler way of getting the
> regmap just based on the DT node. Are you planning to add something
> like that here as well? An ideal driver interface might allow
> syscon_regmap_lookup_by_phandle() to work for both mmio and i2c
> based syscons, or additional ones as well, but implementing this would
> be rather tricky when the i2c core is a loadable module.

I expect the API would be expanded to cover other use-cases.  This is
a bare bones implementation which has been kept as atomic as possible
for ease of review.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
