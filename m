Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70625C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B329207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mehKCxEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgEOO10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:27:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5FC061A0C;
        Fri, 15 May 2020 07:27:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id a4so1037397pgc.0;
        Fri, 15 May 2020 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53n0NXxNogGd/faDRXKVA/bWobWfXTC9lWKhBDbKv8I=;
        b=mehKCxEZtPNkQpDx0oskocLvG7NqA4fkwi1nzfp/DL6XUhZeUGQyhh8OKJqroIdvcc
         f0Z02rs/kq5fx8LwLA/4HMHsnIWyjjYfp3vMuZrrcjiLZUE6IMugbRUxlLBHlsL7Od64
         8fqJQnGVKGzQrYU8DXxxzIRJEJ+Q+3uSdg8YOyBL/K9fxgyp26zcPuk/Etkkxnf4PGg2
         rX36wn8V/tZty5sO4IdIra7L5yyDQ6LTzlr7zjakz/+POV/t0Vo4GcP607WF2ftVXS8L
         GGAGDKBDF+vsh8P+k9/O9E4Z1xrAa9/X4FylchFHv5pGteJdUJCMl4MvWvaZTM+3CeIB
         y3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53n0NXxNogGd/faDRXKVA/bWobWfXTC9lWKhBDbKv8I=;
        b=JqpOLdgrZevS8EPikxczfgrl0auX36DRJUN2C8XX2HFAcU9fCJqU2CnwOa0k3dldAC
         dmD/ux+vq2pOwYspmUrlSiFgAcmimLC0VeUmBqQwcuN8NQZRhX7YJAbe4Z5whMmaFukR
         6Xlv8ivYNsnBWcjnYNLBx8ovIwu4tVSx60dWoufi15rpAbR4iibYGlTx8V/FvTEYtoFF
         Wau6B4hNyL8f+TXfGjbnbzLCzVBR2qLwGS7VCtlXM2pylhZN5HLkZTy2++Yt+EwmB8vs
         +N7t8+gE4FMOlahM+atJ2bkIc7ybofpsJDjYwAQAi3YIqJWN3N0gDN9z34CE7JgKpzUY
         WTpw==
X-Gm-Message-State: AOAM532nIXvpLzr3b0PSZDRWtygOayv2LpJdwvmm09atRrjkMPVdgsMn
        84KRtR62GaO0ja2EGJiLn4UQPiw3EdmnWASUGvw=
X-Google-Smtp-Source: ABdhPJzS92KlQk6vGXcM8Vw9uXpx1E9E3au/e/+UxJQc18uHeaoAkWxn4K/nuitAUBEbmThwq+nxIpkDbhjQiOMUJLo=
X-Received: by 2002:a62:f908:: with SMTP id o8mr4096022pfh.170.1589552845598;
 Fri, 15 May 2020 07:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <202005152142.AWvx4xc5%lkp@intel.com> <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
In-Reply-To: <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 May 2020 17:27:19 +0300
Message-ID: <CAHp75VdUWaEAuStEQZD4yOWcxBT0EkxiX90u1_9vppFb5JniGQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     kbuild test robot <lkp@intel.com>
Cc:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        masonccyang@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, May 15, 2020 at 4:48 PM kbuild test robot <lkp@intel.com> wrote:

> >    440                  reg = cpu_to_be32(*pdata++);
> >  > 441                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_0);
> >    442
> >    443                  reg = cpu_to_be32(*pdata);
> >    444                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_1);
>
> On BE:
> cpu_to_be32 -> no-op
> writel() -> converts reg to LE
>
> On LE:
> cpu_to_be32 -> converts to BE
> writel() -> no-op (in terms of conversion)
>
> Seems to me that the proper API (if above is intended) should be swab32().
> But something tells me that above is broken (or my understanding is wrong).

And perhaps it should use lo_hi_writeq() or something like that.

-- 
With Best Regards,
Andy Shevchenko
