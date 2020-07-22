Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62591C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C16206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="lA4V5SfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgGVJb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:31:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:31:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so1498947eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sqOEYfYuAtbFYQshCOEmc92ess+IPZQc1F+OL5J10Vw=;
        b=lA4V5SfSK/hFUDndm9W7pBH4DWvVwiHjAeQuiPhKTxAvr3I1hVPGGieGjALxJoTKLR
         F+WnK0NmfAe7PzU4ipAgmqaYntjJgTLBkLHXw6qe42KE5qn6JMlNmOqJIJke92yvg7mX
         0y7SQ7bvB5gtZtqUTv1MOFMmsgzSiviVDtKi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sqOEYfYuAtbFYQshCOEmc92ess+IPZQc1F+OL5J10Vw=;
        b=o066aE2Jtgz4qwlPSnu/ttIj/VOJQA7DhR/qehxVyadbDoMbRUYUAqId7I0LWnPVSk
         nnTRwixu1LHRoeBUOMd79Bse58odbpQ5e6pgrjxjfKGXgLmi/kqCAZne8znBFzBhPLF0
         o471CULBbaLYfqZUMxIlGJZDDFUakxJdP/YHOttglomJ1eWIv7Zq4oVxyu7LcVw/tvhj
         j1kinpKbZQ1lskJ6m+1KSVV8WgNN2CNAAq/VqS2Z8kvXJHb0P/hulPrgmuvkRPvxqaIJ
         Qv9N8HokxusVHue7Rklvw6ROy4nyowpn6ZBybPYz5k4reEOwLbkHM/nPNPgD989g6PlP
         jZSA==
X-Gm-Message-State: AOAM530NLeeNAVeDp8Y4aF4tVjXhcquub+tix8A+IjK8PNM0ikIsEpe2
        g2LdXVi2xeomywnEcYsN5xfb8mafEgYYV1Y2Z9c=
X-Google-Smtp-Source: ABdhPJzlGpAL5RJtjD/QpfXT9TfcbuqPdUr2X/sn7PVdVOfcD50BVjqSLYDCrbTndr6uRtWOwQxMWUc/nlewcevECpM=
X-Received: by 2002:a17:906:c187:: with SMTP id g7mr28118725ejz.108.1595410315017;
 Wed, 22 Jul 2020 02:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200722084241.193470-1-joel@jms.id.au>
In-Reply-To: <20200722084241.193470-1-joel@jms.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Jul 2020 09:31:42 +0000
Message-ID: <CACPK8XcxkAiAD2UWVmVH-6TxNKyrv9z3cOB9ptxVw+kiQgCuqA@mail.gmail.com>
Subject: Re: [PATCH] spi-nor: Remove unused spi-nor.o rule
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 at 09:00, Joel Stanley <joel@jms.id.au> wrote:
>
> In "mtd: spi-nor: Prepare core / manufacturer code split" the file was
> refactored into seperate files, so the rule is no longer required.

Please ignore this patch. I misunderstood how spi-nor-objs worked, and
didn't properly test the patch.

I am still a bit confused as to how spi-nor.o gets linked in, as
there's no spi-nor.o on my filesystem. Can someone explain how it
works?

> Fixes: a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code spli=
t")
> Reported-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/mtd/spi-nor/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 653923896205..2ede5ef79b01 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -17,6 +17,5 @@ spi-nor-objs                  +=3D sst.o
>  spi-nor-objs                   +=3D winbond.o
>  spi-nor-objs                   +=3D xilinx.o
>  spi-nor-objs                   +=3D xmc.o
> -obj-$(CONFIG_MTD_SPI_NOR)      +=3D spi-nor.o
>
>  obj-$(CONFIG_MTD_SPI_NOR)      +=3D controllers/
> --
> 2.27.0
>
