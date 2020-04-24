Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A17C55194
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA9C218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgDXMZM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:25:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49631 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgDXMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:25:08 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1jRxOD-0003cu-DC
        for linux-kernel@vger.kernel.org; Fri, 24 Apr 2020 12:25:05 +0000
Received: by mail-wr1-f71.google.com with SMTP id f15so4695814wrj.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iU15QqomQixqJiKhJ57B4zw5mxIh/3HGMrkI1YiMp+4=;
        b=DSUqemoAvUigXFAX7NBz1b7WJAkkMZQG3mNifZWCAZ+MNwkQGCaSPZubl5DVYO6rF5
         JxuDiyUivitibEjgwUyKKQp9m34t+sCYB+BKVUX7VTZ79kNRcdDMWUU03mIHMuDhbVC1
         xJGWkgwZPlbY5k+wsaacdixBBe99UfviNhnZIb/z74EgcLGSG67WNdnVM46KmLnLDkPg
         YA17GXThKC06TPpTqaHW2vB1uNsbfserwW8VO7hp53IKz/OWi6LG5/oOzxw/5l96EXM1
         ng4fXLK7Mqbyg3ptUnXAl5tnBNgPi7wag0kTRhY16v0lwl0OHVS+3DnSYCpoQF7gBD6o
         70fg==
X-Gm-Message-State: AGi0PuaazBFIykjzkH+Z8eNRJkA09uzMfVXcih83mYd05uOOjq6KVIHE
        u6nocUFCDhzVHgyVJrIbnYuPzAg7y2o8gfF6hfBPim7NARxrXsFAd1bCvUGUmHNGuuDOUflg7we
        2C+TEjI9kRcvwPxdkSrTObP5IvxFPQfF4IUQxuxVKd6/Wa9PaVmbxwvCA3Q==
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr9850045wmj.186.1587731104554;
        Fri, 24 Apr 2020 05:25:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypK1lkjH81XnELXpEu/JUpnGyrZrjMhxVS/JiB+Xni6GjKFTD0CLjcETDJ/uPuuonmIIWQx3AILzXvOsMzDGRwk=
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr9850024wmj.186.1587731104291;
 Fri, 24 Apr 2020 05:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200423085857.93684-1-acelan.kao@canonical.com> <20200423144529.GM4808@sirena.org.uk>
In-Reply-To: <20200423144529.GM4808@sirena.org.uk>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Fri, 24 Apr 2020 20:24:53 +0800
Message-ID: <CAFv23QmNLUqWKHTjK-sFE7ChUCu9j=0p6=Rn22d0E8_HeV-8aw@mail.gmail.com>
Subject: Re: [PATCH] regmap-i2c: add 16 bits register width support
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> 於 2020年4月23日 週四 下午10:45寫道：
>
> On Thu, Apr 23, 2020 at 04:58:57PM +0800, AceLan Kao wrote:
> > This allows to access data with 16 bits register width
> > via i2c smbus block functions.
>
> > The implementation is inspired by below commit
> > https://patchwork.ozlabs.org/patch/545292/
>
> Do you actually have a system that needs this or is it just being
> implemented for completeness?  The patch you link to mentions that there
> are correctness issues with this implementation.
Yes, I'm working on an Eurotech's new platform which comes with an
EEPROM requires that patch
https://www.eurotech.com/en/news/cpu-162-24-a-new-rugged-com-express-basic-type-6
I'd like to upstream the commit, so that we don't have to maintain the
commit in our kernel,
so I migrate the code to the latest upstream driver.

> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
I'll submit v2 soon and add more description.

> > @@ -255,6 +312,10 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
> >                i2c_check_functionality(i2c->adapter,
> >                                        I2C_FUNC_SMBUS_I2C_BLOCK))
> >               return &regmap_i2c_smbus_i2c_block;
> > +     else if (config->val_bits == 8 && config->reg_bits == 16 &&
> > +             i2c_check_functionality(i2c->adapter,
> > +                                     I2C_FUNC_SMBUS_I2C_BLOCK))
> > +             return &regmap_i2c_smbus_i2c_block_reg16;
>
> OTOH we'll only use it if the device wouldn't otherwise work so I'm not
> sure that it's any worse than just hoping the bus is uncontested,
> hopefully system designers have taken this into account when building
> systems without real I2C controllers.
I'm not an expert in this field, please let me know if there is any
better way to archive this.
