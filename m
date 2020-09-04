Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A85C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8033D20716
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQIa8Aj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgIDA72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgIDA71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 20:59:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D59CC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 17:59:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so6331092ejo.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 17:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=qvfCuz0yuh3MsTm69717RI4Gp9IbhKPEeIA+SE5rkxE=;
        b=AQIa8Aj6RUic6TSZZuyxkYyKhejkbrDibWkAqUSRozIVY7YGfnjw/4ELqOl9Eu0Ldd
         Hh5rJ5oWy2GFLESM2kMmZHrZvL/OU7Zcz4WG7PzAqLfGmGzwlAimgYJ1oz8r6mdGLbKU
         hf6Kyz8hL6ttt0dquUCFa6xj6RCcnjjy9GX4ZkK4CvAcN32d83LQ6wwyFqgiWNuUDeye
         kc2Jc3iCqTQ9hY1s9XJvBPgQx1Gc8Vy3abPvM86K+4y5otR3dIoCYS7planxcPeX/GiN
         rgRBUlYS7TivxOAzKLKr/JEJGTFcv9qW3/VMUe63c+NKqVYbFEtLrfWIBTWnSJuiJKy1
         YyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=qvfCuz0yuh3MsTm69717RI4Gp9IbhKPEeIA+SE5rkxE=;
        b=nTL6aDxOD8jBaeS2+TZHuCiLvQFNkNNLjX81u769In0aZw6jNm6d3BndxOwZh6z0oP
         zxdqjmgog6e1vX/DnRkvHsjGfunXtbLcVA4WBB2ont7hk/jKRVxrVBlbkTwOrMNs+BQq
         DxrBxRiRCk24c3KK+5386Ht48SypzbGXNX0ykeQ0n081U3kRi2Iva9DOgx/YC+pUMNIB
         KuWQH9BZRiemEkk+vokbvh147FOnAyAPA7Bo73SsYaJRPb7776+zdmxsvYSYUWUh46sW
         mLgNCMGceLB/Y0V4Kr/r4rjzpLi21n08FTD5OQFt/4i9Z+u2LgeZj7DlyAerVU84zzv9
         hjiA==
X-Gm-Message-State: AOAM5329Z199JCIAyfJLq0zQBYMrx2COo1ohhQvi4xd+YY9aP+eaSS0r
        D9KUTn8QRvPVcgiQHHBd5GrQAlp3nJnN5XArAJn5IunDFwSENysA
X-Received: by 2002:a17:906:bc47:: with SMTP id s7mt4686597ejv.354.1599181165713;
 Thu, 03 Sep 2020 17:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200904003408.452999-1-anant.thazhemadam@gmail.com>
In-Reply-To: <20200904003408.452999-1-anant.thazhemadam@gmail.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Date:   Fri, 4 Sep 2020 06:29:14 +0530
Message-ID: <CAKBsNOkn+kx1VGc9274qT7-RDskoFNank27vG5g7Vt51+zvgmA@mail.gmail.com>
Subject: Re: [PATCH] Remove unused variables
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was generated, and sent by a script I was working on (and
apparently, still am), that would run sparse,
detect unused variables and eliminate them. However, upon manual
inspection, it became clear
to me that these functions are in fact necessary. I'm sorry this
mistake happened. Kindly ignore and discard this patch.
My sincere apologies.

Thanks,
Anant

On Fri, Sep 4, 2020 at 6:04 AM Anant Thazhemadam
<anant.thazhemadam@gmail.com> wrote:
>
> A few unused variables that were defined were found and removed.
>
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/staging/comedi/drivers/dt2814.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/staging/comedi/drivers/dt2814.c
> index bcf4d5444faf..1a36d8612d9f 100644
> --- a/drivers/staging/comedi/drivers/dt2814.c
> +++ b/drivers/staging/comedi/drivers/dt2814.c
> @@ -190,7 +190,6 @@ static irqreturn_t dt2814_interrupt(int irq, void *d)
>         struct comedi_device *dev = d;
>         struct dt2814_private *devpriv = dev->private;
>         struct comedi_subdevice *s = dev->read_subdev;
> -       int data;
>
>         if (!dev->attached) {
>                 dev_err(dev->class_dev, "spurious interrupt\n");
> @@ -229,7 +228,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>         struct dt2814_private *devpriv;
>         struct comedi_subdevice *s;
>         int ret;
> -       int i;
>
>         ret = comedi_request_region(dev, it->options[0], 0x2);
>         if (ret)
> --
> 2.25.1
>
