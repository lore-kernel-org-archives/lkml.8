Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F66DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591482076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz2bWsiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEOOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:25:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A478C061A0C;
        Fri, 15 May 2020 07:25:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g11so952659plp.1;
        Fri, 15 May 2020 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49t3MoXqM17BH4PLPJ14eJW4i3hdwXhMbbVc4qSxdOU=;
        b=Fz2bWsiqdptvWYwhZebHUhc7rMuBMDCX4uTwcs5ceuql0+cViaytGDFp/j9mBgjdWW
         lRJNX/naOqb3ZSYr1mWFWT1wdMxJ1lWqpcAbqnSYBcvtRmGFn6y8lcWtwVEkiAXYdyvT
         eGUh577Y3lREjPqwr3l7usDOHyyeGQcktBjQTwlXiHUrLG4F4cy5pMupnxw9sGvFjrWF
         8MO8KYjxjVcKlnpXq64N9CTY4TGlRdnHlAzQ9V2z87BDaWh4Q1W4/9Pl1bRZifXrVcab
         YPLygDao+UrsS7bgmi26QPlbVm7Ux5yHOo5vG4WuKwwjsoz/Tt6Ll7sPAAHd1LMnoIBb
         mD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49t3MoXqM17BH4PLPJ14eJW4i3hdwXhMbbVc4qSxdOU=;
        b=NvXxUw320wG+UecGtB88k2v40pOuRTuSUhxRwdLNy31PNdOqfvtvWYrOwYtra8ig9y
         dlh/CO8q2ntnBNzYjTGRSYLQL9+3iOcynbaOrG8BsocnvmOslxZGSi0kJ1hIfFg64+qi
         cfsjkiFFoBckG/XN9AYux4yvopKf++//oxkr5BzrcHjCEOBErdXBV3w2q6B5kYXFnkXT
         VIlXVnAl0oEQccnuQW5gy963gDjNtKHB4w4lWYAKFaW6ELy4U0QCPPKXQ2sAnspmAIkY
         MgKVqfJQqblfnaqKI01c8q8iLgbq7eiQsV1fhRJ/0sYV9zxmBTxnKx8R7RWwvhdroGnI
         BsUQ==
X-Gm-Message-State: AOAM532moFL543r0MchCE3rUYngQS1l56Bul42zrDCk16pKkA/jpjEbz
        RnS9Xv5tvx84ZOcBOOtf1dRAJXjLGT6UbYSQAd8ELCzC
X-Google-Smtp-Source: ABdhPJx9WsseUUaDU5aQqbAWqexIuw50ii00Xe8pgIuJOUKQiPtL7+0zN6dlHyzFIKqHVICZ6VuV7lnKAhfkRv72a4M=
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr3921780pjb.129.1589552738686;
 Fri, 15 May 2020 07:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <202005152142.AWvx4xc5%lkp@intel.com>
In-Reply-To: <202005152142.AWvx4xc5%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 May 2020 17:25:32 +0300
Message-ID: <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
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

On Fri, May 15, 2020 at 4:48 PM kbuild test robot <lkp@intel.com> wrote:

> sparse warnings: (new ones prefixed by >>)
>
> >> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
> >> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    expected unsigned int val
> >> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    got restricted __be32 [assigned] [usertype] reg
>    drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
>    drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    expected unsigned int val
>    drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    got restricted __be32 [assigned] [usertype] reg
>
>    440                  reg = cpu_to_be32(*pdata++);
>  > 441                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_0);
>    442
>    443                  reg = cpu_to_be32(*pdata);
>    444                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_1);

On BE:
cpu_to_be32 -> no-op
writel() -> converts reg to LE

On LE:
cpu_to_be32 -> converts to BE
writel() -> no-op (in terms of conversion)

Seems to me that the proper API (if above is intended) should be swab32().
But something tells me that above is broken (or my understanding is wrong).

-- 
With Best Regards,
Andy Shevchenko
