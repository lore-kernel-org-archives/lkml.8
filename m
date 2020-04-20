Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068BDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32DA20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shohTt/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDTHcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDTHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:31:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:31:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so9803253wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Irkm1t7texpDTdUbbf1TCyy80mJcHmDgDPGpxK2nECY=;
        b=shohTt/yf8dzKqAja5yZw/W0nu5rJUWnkH4GMCrvNWxjOWfSHvdGqPHblWnvz7cNc/
         wHLoKebMkLi1F7mwe5VShLwnv1iOBGdw4GlovkR4aPUdz6Gfzigr7Q+f8i6jUmsQh3dq
         mDTsITXiv85lr9ix8WBZ9axZuO8DIdt78O8zCx+Ahl8svy5UC/y/tv5xQwDC5sW9lpzg
         CmYMN+AIE1vQItJdb233MwfuIwlGjdNxW+ckrnhBJN/ozn7otWkTcCLYjoAxOmLOBvOs
         tEy6wM4XOoxRS/bTJezonmZr3h+gc/OT7MWydSWG66T3E5RPmTyg5QbfpCNqvKHQyew2
         Q2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Irkm1t7texpDTdUbbf1TCyy80mJcHmDgDPGpxK2nECY=;
        b=dfFqKqZeKiIn934TpWIMV8JliHDReLZNIrboGBs4bkXhWsAyHKer2scpHSyvE3M0Rv
         zkWyx59LhJdRq9VehfDAhxlOPqeLa3/BDLzo6sbNY2BsE3BW7agSwn02fCsjk9tEJG9X
         zHKLwnsMwqeU/A60CN0HhGTRldFr8NwLlt7a8jY+JZWHHQ5c5KhRmVnDXfoeiIpA9B7a
         5mJqgwvyqIE5Iriploe7C8oEXDvJqxbV747UMfcl+7SHAEkkPI/M6jB7kt7wq594LZyG
         PzoG0rW2y/DnojziskILOBhZlUckM7GZZTyVzrrsTadVJ8bzchKXHUnDc2FzuIqqlRcl
         1S3w==
X-Gm-Message-State: AGi0PuZ5aK1I00bFmfd9ULz3x5XJhVmO3YJ/yi+XEUjRaO1qaCiyfRit
        MFjaKZSWdnqsM0v1GMXBcXhP8YEjjyA=
X-Google-Smtp-Source: APiQypIWmIdKdy/1oq6wCDylTuILAe8zIGt4RJL7gzOKN1D2xzlvfQAJXOgmUgbaFZcGZB2rGNMlWw==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr15895325wmc.93.1587367917882;
        Mon, 20 Apr 2020 00:31:57 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id u7sm200895wmg.41.2020.04.20.00.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:31:57 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:31:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Message-ID: <20200420073155.GK3737@dell>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <20200416075944.GU2167633@dell>
 <AM6PR10MB22634D3B677E57EED0514DF680D80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200417092410.GF2167633@dell>
 <AM6PR10MB2263F5CE9B3627A256BD695880D90@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB2263F5CE9B3627A256BD695880D90@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Adam Thomson wrote:

> On 17 April 2020 10:24, Lee Jones wrote:
> 
> > > > > +		return -EINVAL;
> > > >
> > > > Do you want to fail silently here?
> > >
> > > Well an error message is printed in the calling code, so didn't feel like it
> > > was necessary to have additional debug here. Felt like bloat.
> > 
> > As a user, I would prefer a more specific reason.
> > 
> > Thus, I would provide an error message here and omit the generic one.
> 
> I can update although I'll of course then need to do similar messages for the
> other error legs of this function. FWIW, as this is only being called once in
> the same file this error leg of code currently can never occur.

As a tiny improvement, it's not a deal breaker.  If it's too much
work, you can either submit a subsequent patch or omit it completely.

> > > > > +}
> > > > > +
> > > > > +enum {
> > > > > +	DA9063_DEV_ID_REG = 0,
> > > > > +	DA9063_VAR_ID_REG,
> > > > > +	DA9063_CHIP_ID_REGS,
> > > > > +};
> > > > > +
> > > > > +static int da9063_get_device_type(struct i2c_client *i2c, struct da9063
> > > > *da9063)
> > > > > +{
> > > > > +	int ret;
> > > > > +	u8 buf[DA9063_CHIP_ID_REGS];
> > > >
> > > > Really small nit: Could you reverse these please.
> > >
> > > Yep, agreed.
> > >
> > > >
> > > > > +	ret = da9063_i2c_blockreg_read(i2c, DA9063_REG_DEVICE_ID, buf,
> > > > > +				       DA9063_CHIP_ID_REGS);
> > > > > +	if (ret < 0) {
> > > >
> > > > if (ret)
> > > >
> > > > Or better yet, as this is a read function, you could just return
> > > > i2c_transfer() and do the appropriate error checking here *instead*.
> > >
> > > I think given that the function handles all of the I2C specific stuff I'd prefer
> > > it be kept there. Logically that to me makes more sense. Can change this to
> > > 'if (ret)'
> > 
> > Yes, not that I understand the message length (3) has more do to with
> > the I2C interactions (rather than a derisive of 'count'), it makes
> > sense to handle that inside the function.
> > 
> > However, it does seem odd to handle the return value of a *_read()
> > function in this way.  They usually return the number of bytes read,
> > which in this case would be DA9063_CHIP_ID_REGS (count), right?
> 
> Well regmap_bulk_read and regmap_read return 0 for success and negative for
> failure so I'd disagree on this part.

Fair enough. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
