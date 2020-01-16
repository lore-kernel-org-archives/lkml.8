Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E502C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30A42073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDs7ULy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgAPXgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:36:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391725AbgAPXgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:36:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so20923850wrn.7;
        Thu, 16 Jan 2020 15:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bF3317OGHK5krTcjjbGSkGwDhwphNfmQD5j464wXOIU=;
        b=WDs7ULy3CVS+9iYfA/uB0wYPil83dz50LkBF9KNZwmshPSasfn3BYIC4m5XuJRwO61
         df7ja6uqCjtAyFCyHU2OhUANcR58YrZVowl6/oJXV4y3SnnCaVZdumXIqdVrOIGvWvhR
         vwf7Help7agnC25Ynsy6QnnXyQcYOiZqcPDG4wJ8pJ0gcBHc9ZNypb9O+2dPrkZw3maK
         8hgVFRIOXqzbAeF1JaODBtfq31bMms3Gzd7Y3aj1EvKVLS/T9HtvaPC7UmmIaE/Y2v+B
         qUffVEGJNimwW/9xf5yNYwOZop03NeiXCeslZSXPYkOkKtLFaUEwDVBF6+n2PREwsHo8
         I30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bF3317OGHK5krTcjjbGSkGwDhwphNfmQD5j464wXOIU=;
        b=jPmxhAgOyzp8AdeCESh812N2zHnjeAdZFGbIB1n8jKkuAD4soGdWHl4kq9hjdgdjU4
         bXEEb1VtMVzt+cLGylJKQOVb3NJWLuMjKZU5wosiYa2vAgHx0C8Yyf0CHnWxvRHKzR3R
         PGKKiqKh3tzTEe1VrpM364uOWc70pxGWXhdAEF1uk9IhvgvRvyfm4YE0QLgkAdL65KHs
         /lJloOsBHzD/hZ0U68z7KuOdnanUKdjWCiVGewl+aVCOb9ekFxDWOsBHVPiVRwCB+R5g
         jKtc+/2CGvCZT08iBgZHTVdGHuDmYU3cepO7+sVyFNv8Xoa9u3dSS99i9uOeaAO1s9R0
         USQA==
X-Gm-Message-State: APjAAAWoeoXqCHJ2Yr12Jla4GuuiISp5UYokcb02olEJXr+622loeIek
        +DkZCPTrz1wPFB9427Vk3tRZbaE7DImP+tsP+qc=
X-Google-Smtp-Source: APXvYqwp34QgYzpaQTk3I5h4ff2xMWUbBxY86gwE9O7Q81Pi8YEFrvCVPdsmJzanpQx1SHOiplE2IKkdo/FyXRllplw=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr5708414wrn.214.1579217794610;
 Thu, 16 Jan 2020 15:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20191127062002.23746-1-yuehaibing@huawei.com>
In-Reply-To: <20191127062002.23746-1-yuehaibing@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 17 Jan 2020 00:36:23 +0100
Message-ID: <CAFLxGvyqyhCa7gvhRHT6oNML0+XJ-Fyexf4xK=bm7bViusuGFg@mail.gmail.com>
Subject: Re: [PATCH -next] mtd: ubi: wl: remove set but not used variable 'prev_e'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 7:22 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/mtd/ubi/wl.c: In function 'find_wl_entry':
> drivers/mtd/ubi/wl.c:322:27: warning:
>  variable 'prev_e' set but not used [-Wunused-but-set-variable]
>
> It's not used any more now, so remove it.
>
> Fixes: f9c34bb52997 ("ubi: Fix producing anchor PEBs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mtd/ubi/wl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied. Thanks!

-- 
Thanks,
//richard
