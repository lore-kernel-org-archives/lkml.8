Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E5C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6AE20780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roFQ9Pgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgDQSlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbgDQSlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:41:03 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAB9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:41:03 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x2so1767689ilp.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBnUrRDDNk8XJ276R8ygyYCspd54z2pKqY+O6PbDooc=;
        b=roFQ9PgmfN3Ru6ytOF6mOiDLxD4KhVctBp6Ruuzzz85yUWf+U21WvMNLXR3AFvFTbj
         w5EhEnYlaNCo8KqDIjZIIl8xNrAGmtmfm9IpVWsBOhPGVu3vdZ5wVIZjADzspefkJM/u
         TOljNMvaQTNg6JRPgeMukoDmPbCNOf3/NSDq02YAY/B1gzTuOe0Rrysek5UJg70L3aSH
         Pevme0Q0hdXtE9nfEwiG9e3ZC2ozXl3hORncd40esHZotLPiLKaH2JfVIuo4Gc19d16z
         bIG+KH9UPPOLWNQsbbleXn/6UTLmooZE82sLntCdfWyQ1qGrzbDw7NW3qRi4BBjzv+mI
         skPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBnUrRDDNk8XJ276R8ygyYCspd54z2pKqY+O6PbDooc=;
        b=syAEzXGsO24VAwAUhwjyir84NWoEWMdMpGyS8AemwOZHwZnBDNOD2JKYrZt/e1ebsF
         ffe9dMsF0uv8c/OwhjquEO3qXGpRNRlVbqfnUqtSufbaqT3MaIeHpgeQHnMxi7q9CDGd
         lY0Q25nWiGN/XE/XXREuQhba0TjvEm12Q7l1F+zai+hAJajYrKhM0/ufua6/MNy8sC2L
         Wtr9uGgNL1gcbzfggPcS1rMNWQEvI5CtJKDwz35+6W57bu0VlZrXuq1+yeKT9swPvW3+
         7c0wxNa4fBPZ2PZ9kTC8Bz+IoNdZ0Jeht1FS/JEnDszFJaldAebcWzIY+oCrbZtQ7lsb
         ovvA==
X-Gm-Message-State: AGi0PubG9dXpmwp3/5gOv05G+mHEx4tC7puWanNoCxPDll3OfMjpXVzw
        p4MnIiLlAs8R9t5MvbHEdthar20ajRhdqWjkrzY=
X-Google-Smtp-Source: APiQypJvUJ9zH0W0ghHCenb+ebbNN41AW0ItOJQ82go2K6IrD/bPDDCAGb1LHExIuoyq9J4nCkKqK0AwnulnQHwCh4M=
X-Received: by 2002:a92:3b88:: with SMTP id n8mr2126604ilh.248.1587148863175;
 Fri, 17 Apr 2020 11:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200417101129.35556-1-yuehaibing@huawei.com>
In-Reply-To: <20200417101129.35556-1-yuehaibing@huawei.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri, 17 Apr 2020 14:40:51 -0400
Message-ID: <CAC=U0a2VfQBmHdS4eL0Fbm==aVCS0FWoBnZi7tRHzNKmm=SDVQ@mail.gmail.com>
Subject: Re: [PATCH -next] mtd: rawnand: brcmnand: Remove unused including <linux/version.h>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "R, Vignesh" <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 6:12 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove including <linux/version.h> that don't need it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index e4e3ceeac38f..57076c3d98dc 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -4,7 +4,6 @@
>   */
>
>  #include <linux/clk.h>
> -#include <linux/version.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> --
> 2.17.1
>
>
--
