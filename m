Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D91C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9BB208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lfx4UNDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFQUKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgFQUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:10:37 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:10:37 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b5so3575912iln.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYyY279bFVSqHZN7j7QhgUSFWu8HvAxoUkk6Gpa4t5Q=;
        b=lfx4UNDYeJ2TH/ZktRHDrEoj5KHrbsTWx8r3EXDl84S6GNudf769udhm+aSik/1p1Y
         wUG14CpzhHRyBf+D8fxA0Z1QBfslBi+ZwsjkKJ5GNDKmlW4fkfZNHk4pss1/ieQ/OvSZ
         3MK4hGSQnkUL1MRFNUxqCZlsBjvoPmvFxQt4NVkcMzQU+uC9AQkauyfM/SiinElIM704
         7JKdz3nLE6d8zHF2p/hQ8M5/2xoHtjfZGzH/jEg7i7DalwDX7P9FmMWT1DDlzYXZg0hw
         8cWxxWSRYhKAGzD+RxBlBUaK1gelmIPuwRJrxMh7/4sx5hWKj2odVuo/MvqRodPBbW7+
         Qm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYyY279bFVSqHZN7j7QhgUSFWu8HvAxoUkk6Gpa4t5Q=;
        b=kF27U8ejlKrBERTzW185ub4R1avYZYvUd8r4MATWZBGjAJy4e+ELE1Ui2HTk1QEdte
         3K2bKqrTmE1LFE4RbtjrTYpOQQG0LxfC+kTED10HU+Aix+iqHLmpvYCD85g66NnY6xDX
         Rc3mRDR1iCwzqEqMMM8I2YL42gCyjCUuyM+RF8Rzk0x7fp0Yp/vI0ghpWNqBIoWfRd3x
         MfTIbhERWapphCvP0vbNHJHuK4qaqOjhmpgJ+s+uAYOV13DIhvUIORv98XUVxUwCOlqa
         DB272WWy/tDvkLdnrv9kVrJd7VzlTKbuVT1UcNpMSD3/oWvA9D8gEvOZkDQDgfebEjrg
         fSow==
X-Gm-Message-State: AOAM531RIeDRQ82Q4iWUhgBu0sOb6bW3bihhYqpnCRNrjNF+B7FNXW1E
        3zoCiFwtwJLtjjRd9RNveN+liWrteWJCB9UsZAJ+Lw==
X-Google-Smtp-Source: ABdhPJyFv0O2BgDe1GrZJ/aiFUNq2AjXgC1q9iH48VtEFFe/MfcvfCliYQpUV03OLGwKUoyRa+2FvUNPZMPArOT5PpA=
X-Received: by 2002:a92:5856:: with SMTP id m83mr663167ilb.72.1592424636630;
 Wed, 17 Jun 2020 13:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200617195326.732863-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200617195326.732863-1-christophe.jaillet@wanadoo.fr>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 17 Jun 2020 13:10:25 -0700
Message-ID: <CAOesGMjC_KttO0T89UbWpnsWsGqWeSnpqJr9JTEn2OtQ=xWtoQ@mail.gmail.com>
Subject: Re: [PATCH] pcmcia/electra_cf: Fix some return values in
 'electra_cf_probe()' in case of error
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:54 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'status' is known to be 0 at this point. It must be set to a meaningful
> value in order to return an error code if one of the 'of_get_property()'
> call fails.
>
> Return -EINVAL in such a case.
>
> Fixes: 2b571a066a2f("pcmcia: CompactFlash driver for PA Semi Electra boards")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pcmcia/electra_cf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
> index 35158cfd9c1a..40a5cffe24a4 100644
> --- a/drivers/pcmcia/electra_cf.c
> +++ b/drivers/pcmcia/electra_cf.c
> @@ -229,6 +229,8 @@ static int electra_cf_probe(struct platform_device *ofdev)
>
>         cf->socket.pci_irq = cf->irq;
>
> +       status = -EINVAL;
> +
>         prop = of_get_property(np, "card-detect-gpio", NULL);
>         if (!prop)
>                 goto fail1;

The pcmcia_register_socket() call site sets status explicitly before
jumping to fail1, which is a bit clearer.

Still, this is a legacy driver, I'm not sure there are any active
users of it these days, and surely nobody that's tinkering around and
editing the device tree (it comes from CFE on these systems, not from
a .dts in the kernel tree). The fix isn't invalid, but it's also not
likely to be an issue in the real world. So, let's just say:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
