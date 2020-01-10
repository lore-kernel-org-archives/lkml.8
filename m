Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA8C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2065A2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si4oZXKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgAJHek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:34:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34506 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAJHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:34:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so1077158otf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 23:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPDeuXNAtQv9fBhiJzJbxRhyqm6iekz5DQDtjJ5WnyU=;
        b=Si4oZXKwDCMidho9srkC/elmtC59a2FPNKZ2pHw91A9GQpQx52p9KcAfBYRL5s/DDD
         Dl6ZxlIrVwhqTeiC1kVqfww1j9GK2/vCR+qrrnuUK3jaG1gNPZGRLRTddz2FaN4NI/fN
         JN4ns66+Vh2LrCW+Kwg6ktJPINa9yYQRIDlV1vkijDVXcTgWmQFtGMF4AjjFVg/aguzs
         2Lyec5csMpiFDZ0A4A59V8WjrJLgOIJ6E6AqNbJsd7z5pdP7qpZj1dS3C2v03+D2bjB3
         2+SAmqkEz0nvFi0uXGP5fxT8N4II7/npUG+1zyv64yiJTX0GpzFHVdT2eutqqaBvBrnt
         930Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPDeuXNAtQv9fBhiJzJbxRhyqm6iekz5DQDtjJ5WnyU=;
        b=Xspe1PNOzhsQYfi2WyieALQVYP5XnXvbxi8q+PKw3fopfmFi72w+wQY4W34tzTBk+2
         y73uNE0jkkUxA6MM3V8twMpjJ0GibNIubnHmuycoUGgS3abRs6d2cEOsvYqckLhCDxFH
         A3ODwiAXBx/dHr4H4s3LYJGNb378fkzOvhbMdPZYKLg6qXqzrV6iQoAPdhNBO0FEqpBl
         hk8ZEBiS94Y7bE45eIXd72hKfFqeCQcHFFgqyUskpuWmxgi7rNYRLP7mzz2aJC3kCy8s
         zN8hc7vRKFKmBuK1dtO8xe90j1y1F2U7ppxHqDbGKUjafkDwEMzfBXu7jz3AArCC0Yq7
         /HQw==
X-Gm-Message-State: APjAAAX0d9NKDi+mAHuDFQJ5+R+KCwALKNet8j/T3/9thYHY6cQJkG6z
        7ogqdR5CXc0hfaE8qSMJH2r/kK6Y1u8YXs6RVbRpcAJyC6Y=
X-Google-Smtp-Source: APXvYqyxzZJB5sAFRxMtJ/AJttS4I5dOEIjMdHrhGGxX3Jln0+E96ysOvYrz0U2i17vzjfDiBnntcmlMRT+RYEfp2Po=
X-Received: by 2002:a9d:6211:: with SMTP id g17mr1427847otj.168.1578641679301;
 Thu, 09 Jan 2020 23:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20200110025218.1257809-1-gch981213@gmail.com> <20200110075859.3edfae3a@collabora.com>
In-Reply-To: <20200110075859.3edfae3a@collabora.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 10 Jan 2020 15:34:28 +0800
Message-ID: <CAJsYDVK4RtX92O3M+EOsZa5qS4TxE0OVaEq=KOnAuP6DEHvw2Q@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: spi: rework detect procedure for different
 read id op
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Jan 10, 2020 at 2:59 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> [...]
> > +     ret = spinand_read_id_op(spinand, 1, 0, id);
> > +     if (ret)
> > +             return ret;
> > +     ret = spinand_manufacturer_match(spinand,
> > +                                      SPINAND_READID_METHOD_OPCODE_ADDR);
> > +     if (!ret)
> > +             return 0;
> > +
> > +     ret = spinand_read_id_op(spinand, 0, 1, id);
>
> Hm, we should probably do only one of each read_id and iterate over all
> manufacturers/chips each time instead of doing 3 read_ids per
> manufacturer.

This actually do the former instead of the latter. Maybe the function
names are a bit
misleading. spinand_manufacturer_match iterates over all manufacturers
in one call,
and spinand_manufacturer_detect is called once in spinand_detect.
Do you have suggestions on function naming?

> [...]
> > + *       SPINAND_READID_METHOD_OPCODE_DUMMY: chip id is returned after
> > + *       read_id opcode + 1 dummy byte.
> > + */
> > +struct spinand_devid {
> > +     u16 id;
>
> Can we make that field an array of u8?
>
>         const u8 *id;
>
> > +     u8 len;
> > +     enum spinand_readid_method method;
> > +};
> [...]
> >
> > +#define SPINAND_ID(__id, __len, __method)                            \
> > +     {                                                               \
> > +             .id = __id,                                             \
> > +             .len = __len,                                           \
> > +             .method = __method,                                     \
> > +     }
>
> That one can be turned into
>
> #define SPINAND_ID(__method, ...)                               \
>         {                                                       \
>                 .id = (const u8[]){ __VA_ARGS },                \
>                 .len = sizeof((u8[]){ __VA_ARGS }),             \
>                 .method = __method,                             \
>         }

Wow. I never thought of this cool trick. I'll give it a try.

Regards,
Chuanhong Guo
