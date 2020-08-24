Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8083E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="divqktAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgHXKXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:23:32 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14EC061573;
        Mon, 24 Aug 2020 03:23:31 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so6777286iln.1;
        Mon, 24 Aug 2020 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eppDuuHLOI5VOLJzJCYhod9oPaidx9gSqKiUktHmrVk=;
        b=divqktAMZuFes1GiD35GYGhb7swEwaEccNiOc16b+dfhMMtZk7qRb38um1oHlkUk6k
         hEnYJUqQAomg3alD+ahSw12f7Mt8GwJFsBkbdRi0cUO4OqWe69Sl4VroXvy326Dez5d4
         I+gtIuakWu5UqP5K/czMywaWPccRkG3or7Y08cIDE3+3gNnVEC9bnPYA2n5hd3A1APg8
         X5S97/uPTQwwllp5uQtkKwPyyHGnhRCQd3VUCDaGEPuRyngxmAwwVbsmEWhnjRBkVCT6
         8qoitN/CE3xF45hXm3Bi/hCiK9XZTFaCqQfTxGkuCtFbt1voD1bkIwARiqQAA72Osw3D
         bhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eppDuuHLOI5VOLJzJCYhod9oPaidx9gSqKiUktHmrVk=;
        b=UQrF/v08KlIs95gN0SsqA8qx1QPbVB+mctjg4Ev4xWBG/gU0cx+mgRzYaCSvhxgqTX
         kwIhziA3yBKzAOd5hbnTKG/PmCs/xdsnNTW2eb4k0isQ7SEu/96q6r4C7RWyheuOPL3g
         XaQQdjpUj3KDhK4F8qZD4BiQZeOmRB+DPMhmC4jGwfAErQplyLs2g2c6DwHs+YMwSjhq
         c/hwo8IxAbuJd5MjKUVU69hGQgTNzF7frAeYJk+TPndNE9UgB+O/cffeSs9672CFw1Io
         Hxbr5xpJ1q8jIlBB+faLJLi0TCA9bwY1iQPS87cVx9BxHd8+sjShk4WIi1jBLkQiCYLl
         OWww==
X-Gm-Message-State: AOAM530993Hl/IahVbvcLZvNfZrlwIpys8ekfX7LWAhmkeOEzjSc8wsD
        sTuFNZdzPQqpk8peqeWJsrWpE+LcJJLcwbMMAQ8=
X-Google-Smtp-Source: ABdhPJzL/ijd0HW2Tt67za2CHZb0C24HeAy7TSZp5sLVUDfU1OLJSD+689YumyA/furfpuHuExsiBEngYTystKWMXFM=
X-Received: by 2002:a92:5f06:: with SMTP id t6mr4125876ilb.212.1598264611324;
 Mon, 24 Aug 2020 03:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-2-git-send-email-gene.chen.richtek@gmail.com> <20200820114524.GC5854@sirena.org.uk>
In-Reply-To: <20200820114524.GC5854@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 24 Aug 2020 18:23:19 +0800
Message-ID: <CAE+NS34WuWnT7zvsHhaciWVLT2y0wpwt0wXAp3UmjEuJ2its6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] regulator: mt6360: Add support for MT6360 regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Aug 20, 2020 at 03:53:41PM +0800, Gene Chen wrote:
>
> > +     mrd->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!mrd->regmap) {
> > +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
> > +             return -ENODEV;
> > +     }
>
> > +static const struct of_device_id __maybe_unused mt6360_regulator_of_id=
[] =3D {
> > +     { .compatible =3D "mediatek,mt6360-regulator", },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6360_regulator_of_id);
>
> This device only exists in the context of a single parent device, there
> should be no need for a compatible string here - this is just a detail
> of how Linux does things.  The MFD should just instntiate the platform
> device.

Trying to autoload module without of_id_table will cause run-time error:
ueventd: LoadWithAliases was unable to load
of:NregulatorT(null)Cmediatek,mt6360-regulator

https://lore.kernel.org/patchwork/patch/726691/
According to this patch, autoload can't load module which doesn't
include add id_table or of_id_table in module.alias
So I need keep of_if_table for auto load success
