Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5109E2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9BwnfN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGIQiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgGIQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:38:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E83C08C5CE;
        Thu,  9 Jul 2020 09:38:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so1233325pfq.11;
        Thu, 09 Jul 2020 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K47jeJXopW9XQfg5rSoZEoTShjD1JLQGp5Lwb2lH9g0=;
        b=L9BwnfN69undWTDpWrRItH3G1JWpwEcmWHO9gxGmncWKjaCc5zTCwwri08W7Nqjc6f
         1LruZznoX4jJ86qtASYKqiHH7kUPGDQaSBSi/K2w2LeWwDtF8OWF2p3/P3k8DyAh5wnH
         5I4AZ8jhqbqW396r6cOX1MF17o2ULWB2wjQOaac/gWzJxVIV1itBg82dypgAZOku2Nnr
         kfWpBf1cAmemS4TGtn9MKC2qlnzBwbBBsPvmru8UmDwkMWmJznM26WI/TZ1AYG/XyVJZ
         fFf+nnnvDNyuAae/uLxoAl+SFa9oJ9ZBpQtzrAa+XGaAsV5kml14Pz05enKxYU0SKrh/
         xE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K47jeJXopW9XQfg5rSoZEoTShjD1JLQGp5Lwb2lH9g0=;
        b=O7L0Myt/TEGYVuxEEYkqBrRn3nhs1yKhVldS4qXy6yBnDw10QDW2wggdjcPW4wfaSG
         fMtd3kWLjfyHMeRbVbOt+fdzE5vYueceudYHYaMZ0vPWRuN9Z+chK3+ggcvcp8YNn/Gv
         Uel7VsbOCHIsLCrrvLZHKltpUu4SqabrshY1dcp+09DBNm9pdrldzfbnyjRHSeAFPFut
         h8lfBLPETxaeeauiYmR5hC+bjHFy+j/rJoWc/vSLvkqZ+rZW74WOJVVk1qVDz3exfomn
         W4Xe6JP7nNlAFNAffvx1XDCdYcvzKkh+3BV7N8j03QRlt1/8v2pA0keeHEOK+zu05iLX
         c00g==
X-Gm-Message-State: AOAM530c5D5IHeSYK42LsqlvnIYvPk2Qf0M+d6eIHTjLFYYnphvI+O1/
        wdLovOQzF2CARS2y14QgU9J5YWr/JDOQVF8XY+E=
X-Google-Smtp-Source: ABdhPJxb23g42kilDhlzxisAc2Ewa8w/rmC472jyHvaT7HDg3sB6/jzedyGM15HqI8czUO0l5tPFhfruhWAiRdmoO5w=
X-Received: by 2002:a63:924b:: with SMTP id s11mr53002228pgn.74.1594312681964;
 Thu, 09 Jul 2020 09:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091851.5491-1-vadimp@mellanox.com> <20200601091851.5491-6-vadimp@mellanox.com>
In-Reply-To: <20200601091851.5491-6-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 19:37:44 +0300
Message-ID: <CAHp75Vc+bK2RagNKr6abT=J9GrLwJ5bcj9Q5MhbGFo3Ho_VBDA@mail.gmail.com>
Subject: Re: [PATCH platform-next v1 5/8] platform/mellanox: mlxreg-io: Add
 support for complex attributes
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 12:19 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Add support for attributes composed from few registers.
> Such attributes could occupy from 2 to 4 sequential registers.
> For word size register space complex attribute can occupy up to two

attributes

> register, for byte size - up to four. These attributes can carry, for

registers

> example, CPLD or FPGA versioning, power consuming info, etcetera.
> Such registers contain read only data.

read-only.

...

> +        * There are four kinds of attributes: single bit, full register's
> +        * bits, bit sequence, bits in few registers For the first kind field
> +        * mask indicates which bits are not related and field bit is set zero.
> +        * For the second kind field mask is set to zero and field bit is set
> +        * with all bits one. No special handling for such kind of attributes -
> +        * pass value as is. For the third kind, field mask indicates which

the field

> +        * bits are related and field bit is set to the first bit number (from

the field

> +        * 1 to 32) is the bit sequence. For the fourth kind - the number of
> +        * registers which should be read for getting an attribute are specified
> +        * through 'data->regnum' field.
>          */

...

> +               /*
> +                * Some attributes could occupied few registers in case regmap
> +                * bit size is 8 or 16. Compose such attribute from 'regnum'

attributes

> +                * registers. Such attributes contain read only data.

read-only

> +                */
> +               if (data->regnum > 1 && !rw_flag)

This I didn't get. They contain read-only data and here you explicitly
turn down rw_flag == false.
Can you clarify this?

> +                       return -EINVAL;
> +               for (i = 1; i < data->regnum; i++) {
> +                       ret = regmap_read(regmap, data->reg + i, &val);
> +                       if (ret)
> +                               goto access_error;
> +
> +                       *regval |= rol32(val, regsize * i);
> +               }

-- 
With Best Regards,
Andy Shevchenko
