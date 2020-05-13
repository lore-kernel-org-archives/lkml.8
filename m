Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2315C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E8D207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxU6V9R8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbgEMPDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgEMPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:03:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FBC061A0C;
        Wed, 13 May 2020 08:03:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n11so7890542pgl.9;
        Wed, 13 May 2020 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAK/6f4l7khR9D9MeksEsqPLBqxBSGeZguJ9NMxZ/KM=;
        b=hxU6V9R83V11Jvt+uutKDwAvcJQREw6Y0smqveaz1L2sQdtprbG9yEJI7VibSClGa/
         jpDG1sAWBa/x+Ltmf8lG2mqYkRC+n/WwYTL1NPa2aO1T2ERDPvEmK3J77hsyDvq+oc4z
         72IuZkDk+1O+/PEHVG8zs63ke7GjlaU4eCk+b7srvxrxVRAZSMt1tFkBYHVY8jq4CH8M
         Oa7gljf83XkkxlG02lWINffuFFUMzOC4c3NQ0OdSPKuiynjyMm+Re8abyp2rluoXIvMz
         HsH7A4PUH+fHlsoFi8+lARbXYkeSDffPJXUc2JICwA/PDklHNDQiFxVzzutmsevIUFFR
         VrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAK/6f4l7khR9D9MeksEsqPLBqxBSGeZguJ9NMxZ/KM=;
        b=rQ24lXpXefbc0HD7tA6GRoc7XvRWTJ6jAyNHT9JdW8I+rTb2/7kqcmG9GUKYMGbqa/
         vQSh8KYoS2SPHA/6wF/P9vPZi47m1TqXzBSOeuwbj17/ydJxXRr1pzrtQWj3Ql9panF8
         AJZGHU7eCWFLsSlEudGhiMkl/kJrf13p51KdVPLre3/ZSaHsnMA8YpR5EVR+kjT/g7o5
         j4qYwohgkfKg78rIov2oQDXUqvDeHNq4XAp1zDerHqlDci1raDwkgb65iQ92GDfYcBEF
         0VIcGnlixXixGl8vM86epIuHa3i4EBn0eY9sqQrFRNQAiL8Cc90DwLlvR1wn9HNgx+rE
         dvnA==
X-Gm-Message-State: AGi0PubaJPl5yiJQVN65CX9ejRuaA8FxJ979PCIhqcmzyi/josjCk72F
        OvaNGcbfwhkDUNVOiiiOyD8ESVp5SYvETh+wGMUcjLxd
X-Google-Smtp-Source: APiQypIRYsyGfiDl3QKzXSyGYv9eoVbFwDg/I113aXCiUGoanxmPfa92fLc84XJlH3CWW7YX96GpEBknOEiAvRfVsDg=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr25501011pfb.130.1589382222681;
 Wed, 13 May 2020 08:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <1589370694-14327-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589370694-14327-1-git-send-email-alencar.fmce@imbel.gov.br>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 May 2020 18:03:35 +0300
Message-ID: <CAHp75VfggycwYpsi024MWZYEgOpnst9NR3q-D5n30SDgmSB9Pw@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: ssd1307fb: Added support to Column offset
To:     Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alencar.fmce@imbel.gov.br
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 2:51 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
>
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.

You forgot
1) version of the patch (series) to be bumped
2) Cc to fbdev maintainer (I did here FYI)

> -       ret = ssd1307fb_write_cmd(par->client, 0x0);
> +       ret = ssd1307fb_write_cmd(par->client, par->col_offset);
>         if (ret < 0)
>                 return ret;
>
> -       ret = ssd1307fb_write_cmd(par->client, par->width - 1);
> +       ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
>         if (ret < 0)
>                 return ret;
>
> @@ -626,6 +627,9 @@ static int ssd1307fb_probe(struct i2c_client *client)
>         if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
>                 par->page_offset = 1;
>
> +       if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
> +               par->col_offset = 0;

This won't work on non-OF systems, but easy to fix: simple see around
and do in the same way.

>         if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
>                 par->com_offset = 0;

-- 
With Best Regards,
Andy Shevchenko
