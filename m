Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F1C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2122137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSpsy+S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgDQJXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbgDQJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:23:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:23:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so2218911wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hQx3liHKLvs8KG1xUBLl9b7aHs282GI8NIiqNJg2axY=;
        b=lSpsy+S7Sn2X/KbQfai3WJSTNaliM8Ri1Y0yOHSvuslfRc1kRqawNJDOJxV4LTRfZA
         BvHie44GUkDjZTwKpGnY1s5rJUA4Jz4r6slgReY2VoLNMl0Wg98ycSjb++JqPc5629fy
         /xdB8LgPir1vW1MA5Rb2qFwWI7whDG8p3ENzv8FdQ9nNJTUJ0bMJWgB8QSMowzb61Rz0
         gYVOUE39SYpL+vBTowE/8/yQbuyxwYKUpn67SH0/Rd1Lh9TsF88Dn5VbJSN8uqWOt5Co
         ZcNK+z/iYsGu7AD/s0fUW3kbcQF2fS7ZRlmUimHMTE2L0WJ9WiZtL/itDs4K+JiV5e8u
         clgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hQx3liHKLvs8KG1xUBLl9b7aHs282GI8NIiqNJg2axY=;
        b=QzQV10vWL2KPgidXelso9ca5X5xiwNR6G0FTrTm67zIPEzykiH3rDw/ah14BibJEno
         7nrIEfnTjgYMR4ZDjs0Gtcuuh7xU6TX687CWeDuAfCG7iOHA43eFnL0IHtoiyJQ7sQrM
         bUxHM5HOMo4DH/bUz/jCfI/32t5b3ozPPH+d/tApEAohDiYV6xY9XaaWRQmrqXpC2qLj
         ZTSfPwkwz1P5AldH9grOTag7EljcALQkV3dkKAIpxHk7eMALjUbfccMKoeZTDX62suGo
         L4hAdmHCX5G4Mxc60CnSaBhUBi7ae37D0zzXrLKXw5oGNz5dKRRFW2J7QBltG33RgLLc
         9WaA==
X-Gm-Message-State: AGi0PuaZ0NFMLkBxbCsLbymxQfkl34ZiYRKMfonIw3B0o9EuQEA4iukP
        rrZt/bTder+32SPWif8E1BoSx1YMIzs=
X-Google-Smtp-Source: APiQypI4z6OYG4IexFby0kNYnD6egCZtKSdyi00rICqGFABgGDkQh2/rqWo9rP7S/j32+S1b0VRfuQ==
X-Received: by 2002:a1c:2cc6:: with SMTP id s189mr2574957wms.137.1587115389936;
        Fri, 17 Apr 2020 02:23:09 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id h26sm6940134wmb.19.2020.04.17.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:23:09 -0700 (PDT)
Date:   Fri, 17 Apr 2020 10:24:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Message-ID: <20200417092410.GF2167633@dell>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <20200416075944.GU2167633@dell>
 <AM6PR10MB22634D3B677E57EED0514DF680D80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB22634D3B677E57EED0514DF680D80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020, Adam Thomson wrote:

> On 16 April 2020 09:00, Lee Jones wrote:
> 
> > > +/*
> > > + * Raw I2C access required for just accessing chip and variant info before we
> > > + * know which device is present. The info read from the device using this
> > > + * approach is then used to select the correct regmap tables.
> > > + */
> > > +static int da9063_i2c_blockreg_read(struct i2c_client *client, u16 addr,
> > > +				    u8 *buf, int count)
> > > +{
> > > +	struct i2c_msg xfer[3];
> > > +	u8 page_num, paged_addr;
> > > +	u8 page_buf[2];
> > > +	int ret;
> > > +
> > > +	/* Determine page info based on register address */
> > > +	page_num = (addr / 0x100);
> > 
> > Please define magic numbers.
> > 
> > > +	if (page_num > 1)
> > 
> > Please define magic numbers.
> 
> I was going to but decided against it given the minimal use. Easy enough to
> change though.

It's purely for readability purposes.

> > > +		return -EINVAL;
> > 
> > Do you want to fail silently here?
> 
> Well an error message is printed in the calling code, so didn't feel like it
> was necessary to have additional debug here. Felt like bloat.

As a user, I would prefer a more specific reason.

Thus, I would provide an error message here and omit the generic one.

> > > +	paged_addr = (addr % 0x100) & 0xFF;
> > > +	page_buf[0] = DA9063_REG_PAGE_CON;
> > > +	page_buf[1] = (page_num << DA9063_I2C_PAGE_SEL_SHIFT) &
> > > +		      DA9063_REG_PAGE_MASK;
> > > +
> > > +	/* Write reg address, page selection */
> > > +	xfer[0].addr = client->addr;
> > > +	xfer[0].flags = 0;
> > > +	xfer[0].len = 2;
> > > +	xfer[0].buf = page_buf;
> > > +
> > > +	/* Select register address */
> > > +	xfer[1].addr = client->addr;
> > > +	xfer[1].flags = 0;
> > > +	xfer[1].len = 1;
> > > +	xfer[1].buf = &paged_addr;
> > > +
> > > +	/* Read data */
> > > +	xfer[2].addr = client->addr;
> > > +	xfer[2].flags = I2C_M_RD;
> > > +	xfer[2].len = count;
> > > +	xfer[2].buf = buf;
> > > +
> > > +	ret = i2c_transfer(client->adapter, xfer, 3);
> > 
> > Why is this 3?  'count' and a NULL char?
> 
> Well there are 3 messages defined above so I want to process all of them. One to
> set the page register to the page we want to read from, one to select the
> register we want to read from in that page and then finally the read back of 
> the chip id and revision/variant info.

I see.  Thank you for the explanation.

> > > +	if (ret == 3)
> > > +		return 0;
> > > +	else if (ret < 0)
> > > +		return ret;
> > > +	else
> > > +		return -EIO;
> > 
> > I think the following makes it slightly clearer.
> > 
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	if (ret == 3)
> > 		return 0;
> > 	else
> > 		return -EIO;
> >
> 
> Ok. Don't think it makes much of a difference but don't mind really. I can add a
> #define for the number of messages to be sent which will clarify this slightly
> anyway.

Yes, I think that would be good.

> > > +}
> > > +
> > > +enum {
> > > +	DA9063_DEV_ID_REG = 0,
> > > +	DA9063_VAR_ID_REG,
> > > +	DA9063_CHIP_ID_REGS,
> > > +};
> > > +
> > > +static int da9063_get_device_type(struct i2c_client *i2c, struct da9063
> > *da9063)
> > > +{
> > > +	int ret;
> > > +	u8 buf[DA9063_CHIP_ID_REGS];
> > 
> > Really small nit: Could you reverse these please.
> 
> Yep, agreed.
> 
> > 
> > > +	ret = da9063_i2c_blockreg_read(i2c, DA9063_REG_DEVICE_ID, buf,
> > > +				       DA9063_CHIP_ID_REGS);
> > > +	if (ret < 0) {
> > 
> > if (ret)
> > 
> > Or better yet, as this is a read function, you could just return
> > i2c_transfer() and do the appropriate error checking here *instead*.
> 
> I think given that the function handles all of the I2C specific stuff I'd prefer
> it be kept there. Logically that to me makes more sense. Can change this to
> 'if (ret)'

Yes, not that I understand the message length (3) has more do to with
the I2C interactions (rather than a derisive of 'count'), it makes
sense to handle that inside the function.

However, it does seem odd to handle the return value of a *_read()
function in this way.  They usually return the number of bytes read,
which in this case would be DA9063_CHIP_ID_REGS (count), right?

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
