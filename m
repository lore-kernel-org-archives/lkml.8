Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7636C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7898D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="h5wCvxA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBXLTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:19:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36850 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXLTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:19:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so8947880wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wONJGVe9s4Bl7gjgZbahAyOuf9jGgAtF+ecHMa9lp0=;
        b=h5wCvxA4bLUMMqSuoshcjszaDujgZ8dr7gAzD+iwMC4yEe4kWLffr49NHhKbTzxUmd
         uSElXTHIzon7iNn4WkgFHaIOgF7OQ7CE/fwUEIFjKLuOORCMcG1TwGFfCIVq/PNYE734
         aQ+ygQ8rI3u7eoPWw50I0XSst9PdCRCj1WAaQFNe/J+23ChJWEnd+GBG4Dx0WUFBHCeu
         XY4aa9AaCQP8mD0zqECOEAwMt6qxQesN1DE135oaXLyjcnqzcaz5d57UrBr4tn8b1vc4
         2hP5jw+dntMIbu9TjlLkEOZAU4ZC0ktHbKJaAD94S/g2aV++vTSj6dQErva9rXqn/Orf
         mB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wONJGVe9s4Bl7gjgZbahAyOuf9jGgAtF+ecHMa9lp0=;
        b=UGDuK6nSchojWxQUlRh2qkf7YCQsDjnv7RGEhYMJsJjduWabziC+bddlt/zReHeELs
         9xt5kXvdaofthE62QtO8I1ISVFSjcOwL47t5fNix1KzqfT1+BH6wIqMXNs8v8e5H1MXP
         AlIhcUZe0CaZIwduzRg36Kdc06Z3vvOWZvBS25YYbGie2M/dKdP5HUPrJ7m1gYIxbiQi
         z9DgdAsBfN6impt8/6viZdK4nxC93fRYmDJ2iczfRgp7FokGXk5mSrbzF7XFWOo9IRNh
         gGV/Gd43st7oWOdgtOT0F/IZbJ8TpjMKRgtubKJkLKlfZmIKND3F39Z4KFPpZhB6z1jQ
         XoQg==
X-Gm-Message-State: APjAAAUbV5eUK+xZ/7KRPL0nnsjpVtZ+s1BReiKmFqSvo8rLHJfIPoii
        PboL1zY82YvsnjoQiCn5GhKl2BPROLz8zHM579vh1AFuWxc=
X-Google-Smtp-Source: APXvYqycb24P6xnhqDp+pucIPGBoyjUZamefvvdgMMxrUmkzHU6x2m3TH8DrBUtyLkYM4JILsHZKBVp1aMwUqaUynFQ=
X-Received: by 2002:a1c:3204:: with SMTP id y4mr20955022wmy.166.1582543150802;
 Mon, 24 Feb 2020 03:19:10 -0800 (PST)
MIME-Version: 1.0
References: <06e23d4a305d87bb1f3403b3130f130d784399c1.1581426806.git.michal.simek@xilinx.com>
In-Reply-To: <06e23d4a305d87bb1f3403b3130f130d784399c1.1581426806.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 24 Feb 2020 12:18:59 +0100
Message-ID: <CAHTX3dL6=fBTX4sVzJrvbPpbBDdiQN5LNkZC1PZcRG8qO8PjQw@mail.gmail.com>
Subject: Re: [PATCH v2] microblaze: Kernel parameters should be parsed earlier
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 11. 2. 2020 v 14:13 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> Kernel command line should be parsed before cma initialization to be able
> to get cma sizes from command line. That's why call parse_early_param()
> before dma_continugous_reserve().
>
> Unfortunately it can't be called earlier in machine_early_init() because
> if earlycon is passed in the command line the parse_early_param() attempt=
s
> an ioremap which fails as the memory params are not set yet.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>
> Changes in v2:
> - Fix case with earlycon
>
>  arch/microblaze/kernel/setup.c | 1 -
>  arch/microblaze/mm/init.c      | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setu=
p.c
> index 511c1ab7f57f..a8fc15ac4291 100644
> --- a/arch/microblaze/kernel/setup.c
> +++ b/arch/microblaze/kernel/setup.c
> @@ -54,7 +54,6 @@ void __init setup_arch(char **cmdline_p)
>         *cmdline_p =3D boot_command_line;
>
>         setup_memory();
> -       parse_early_param();
>
>         console_verbose();
>
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 1056f1674065..9899ff2ef9b6 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -347,6 +347,8 @@ asmlinkage void __init mmu_init(void)
>          * inside 768MB limit */
>         memblock_set_current_limit(memory_start + lowmem_size - 1);
>
> +       parse_early_param();
> +
>         /* CMA initialization */
>         dma_contiguous_reserve(memory_start + lowmem_size - 1);
>  }
> --
> 2.25.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
