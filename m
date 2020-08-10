Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC162C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E25206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcKtsfc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgHJHIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:08:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9410C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:08:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so6709557wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=47Gs9F1F8d09vZAc729o4HZeuw/VZH9JG+bx1Ajssig=;
        b=zcKtsfc8/Kleb9yRFPedZRukZN5BBfo337spqmdbUq9GEygQLbhq2BJ4pzaTY0/jUo
         91w5WkpjQW5DWV6jefPAnIRJvmGRiwiJcMfFNoOeDvuYJEa4PNoh36UhmSwof/MQAsGR
         m2xJsQK9B/9RZimDRm5uYXPUQq58wChaHdgj7XJYw6L6cMig5+QJ0+Wgg7VLEwzrU3DU
         fuRLexZM8n86RWBdX+vcqa9boVH8K2D3ntwLzct/OLmqy7m1Yy5+7NR2s0Qj1AER3+BE
         HFEDUEbuI0RitlAe4uPcyWkF19VwDo7tD381Uy/kh964R5Znw1VCtPGix9HAT4eUIFKZ
         kz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=47Gs9F1F8d09vZAc729o4HZeuw/VZH9JG+bx1Ajssig=;
        b=rpTL7TcjPtHntqmQUh6EhoWGdIaiHFOOkA31/dZ90Bm7tNMfygvKgp7QJsPGEeFfzm
         XOUINMCUPW5VK8NR4qyFGeCLiaTq4grL0aS0FR8/VMKyJPYqiJYF30Yq8DEQdj7+SSOZ
         rsGt81c6fKZg61u73mCPy1mezdaQERVddgSkRngv/wM6N27pczDR7ibkXkwM3/L2CmIW
         zEIZsf+/YMzqnhVxw17y+nhbsvPfhd4tvSCwunfFy7K7EOl2OVMQRSg8e94zVZRBEbBt
         eqIQ0UUJIV7tsxYe1cBEgxJjMWtjO9h+jCuUyQRgOwRzkym32Whg38eud1n3KD4Djj3q
         L4gg==
X-Gm-Message-State: AOAM531v0jJgGe7jloAR2xnpriX+UbLU3SiBZ3v9XgBnWBINpzwSl4xk
        a7lb5OBurBCRF3nYCsNr1HNybA==
X-Google-Smtp-Source: ABdhPJzaszzYjiz41rjzxkM5loaOj5BIe+vF8wU0E97WRWint16E9KsV5ipy0b3/vzW4w2iwnkZh7Q==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr25757680wmk.185.1597043325510;
        Mon, 10 Aug 2020 00:08:45 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id w10sm20031948wmk.0.2020.08.10.00.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:08:44 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:08:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH 9/9] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20200810070843.GA4411@dell>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
 <1596558782-3415-11-git-send-email-gene.chen.richtek@gmail.com>
 <20200805161021.GK5556@sirena.org.uk>
 <CAE+NS360iKLoGxiiz8NmQqCp2Uge98Eehe4g2sn_N0e-E3DgyQ@mail.gmail.com>
 <20200806121332.GB6442@sirena.org.uk>
 <CAE+NS37tr65GnTue89wJkPvJzddahKj__KPgzmjzwkOfWQnc8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS37tr65GnTue89wJkPvJzddahKj__KPgzmjzwkOfWQnc8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020, Gene Chen wrote:

> Mark Brown <broonie@kernel.org> 於 2020年8月6日 週四 下午8:13寫道：
> >
> > On Thu, Aug 06, 2020 at 11:30:56AM +0800, Gene Chen wrote:
> > > Mark Brown <broonie@kernel.org> 於 2020年8月6日 週四 上午12:10寫道：
> >
> > > > It's not clear why this isn't just done in the device regmap, there's
> > > > exactly one user?
> >
> > > because I use one regmap to access 4 I2C devices,
> >
> > There appears to be only one device here?
> >
> > > I need change the regmap_bus struct to fit I2C read/write with CRC bit
> > > Therefore, MFD reviewer suggests I can move the regmap api to regmap
> > > folder such as regmap-ac97.c
> >
> > AC'97 is an industry standard bus used by a range of devices in
> > different subsystems.  You can already have custom operations for a
> > device just in a regular regmap using the reg_read() and reg_write()
> > operations which are there so devices that individual device support
> > doesn't need to be added to the regmap core.
> >
> 
> I need use regmap_raw_read to access MT6360 TYPEC part, so we need
> implement bus read control
> 
> > You really also need to write a much clearer changelog, I would be hard
> > pressed to tell from the changelog that this was moving things to the
> > regmap core rather than shuffling regmaps within the device.
> 
> MT6360 has 4 I2C worker devices
> First, I increase reg_bits from 8 to 16 bits.
> Higher 8 bits, bank, indicated which worker device I want access
> Then, if worker devices is PMIC or LDO part, I need calculate or check
> CRC8 bits when we write or read data.
> CRC8 bits is calculated by 3 parts.
> 1'st part include 1 byte is worker address and R/W in LSB.
> 2'nd part include 1 byte is register address
> 3'nd part include written data or read data from MT6360
> I also need 1 dummy byte when write data
> 
> @Lee Jones,
> I found out drivers/iio/chemical/bme680_spi.c implement their own
> regmap_bus too.
> Can I move regmap control back to mt6360-core.c?

Yes, if that is the 'done thing'.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
