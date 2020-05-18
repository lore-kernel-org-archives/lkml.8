Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6FC2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDsKryn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgERNUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgERNUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:20:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E2C061A0C;
        Mon, 18 May 2020 06:20:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so4944018pfa.1;
        Mon, 18 May 2020 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOhtb6aDUYF/bby4eFhEdjPKdJJNHZhrs2dy1zRqvRg=;
        b=rDsKryn799wrGML6USURKvFtsAV/uzTijzNVu9hI6FTQEj3AFhZ911irHK3ovzhsUH
         gY5LA7X6RURa29N0a9uH5OFLBvFxKgmCVL+S2LHar2ZloaGB+HW7AjVNvR4EFgCBxpsy
         po8m+4EEsdKOq83PhP0pKwMOFemPBi2NghEI8xaASNmmmpuisFOXxp8CYt4r9RUzxxu1
         M3GB8LGBpgcFswMHRmJSEf6wc8sgbA4QBO4WBLxXI/N36soCP3yyMdGiZf7r3pEYznqk
         6vi0oRLO6oAzTU8/YQKG1+FHZVrR4xGNGcqOGbViiKsPYwbG3i5aRhnYKp6FmwbGWmsi
         ut+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOhtb6aDUYF/bby4eFhEdjPKdJJNHZhrs2dy1zRqvRg=;
        b=pJgTHGpUWBLOfOik5MMvYbjSRYYfclikW/Zt/Fc9ihoEBjp0dW/S+idO8QiOxzCW47
         jkqllKUN1lEmsJnN0et5DRfzQ4A3322qwcIgqG+jObqlzS6m1TIrlSYTEEQnjKUQIGfu
         c64yCx/SNDD0SQ1ARGQK6XXDQ+HbowC7NLxv5hnthZhBDQvXjzhrJU+irFAg62ikEjWc
         JJzH/UaPYhjhezCJsqqhgE2O/Jsz7LSdb6QTRgdKrDUHZlJWFf1fdqza/OqBXV8rfRts
         6he309FNV049jSmnbK0fUoSW3j8dPkRYCZqLVXtVg3kAiRZmTVLuPVHlxmSNPON/6sio
         JBbg==
X-Gm-Message-State: AOAM5329nrl/7ygyMHDR6KSrNXHlF+NoxJ6CefEVF7ccDsJaweVIkelr
        U/B8ar/rvMoqlsNsKIEyENYkvwyd6dTCQZsq0Fc=
X-Google-Smtp-Source: ABdhPJxEWo37sbtLGrnXVQllcXNP02GCyiWRVMGVtQCaOaZDXATQdRF9Fzdajl4gBo0tRari+NEpX4OkjNg1wYKmxcw=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr15312040pgb.203.1589808022426;
 Mon, 18 May 2020 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <202005152142.AWvx4xc5%lkp@intel.com> <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
 <CAK8P3a3RKJo-C5=19oAppx212s7T8NdnKJVmkj+h=34a8aKMNA@mail.gmail.com>
 <5180e734-ff56-db5a-ab49-8a55cfa2f2c0@linux.intel.com> <CAHp75Ve_XjvvGBEQyhy=qVVJMFS+18j3aKxNxSQpGK5qJmzfBg@mail.gmail.com>
 <CAK8P3a25GbMwbtvkxgmuGss6nEfAW4_vVbOXPxOYuDOaU_zcjA@mail.gmail.com>
In-Reply-To: <CAK8P3a25GbMwbtvkxgmuGss6nEfAW4_vVbOXPxOYuDOaU_zcjA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 May 2020 16:20:10 +0300
Message-ID: <CAHp75VfFsdjAT0P4m3O=VQ1e_L7cVyQx6HB7MCN+G_XcFisqZQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
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

On Mon, May 18, 2020 at 2:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 18, 2020 at 1:43 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, May 18, 2020 at 2:39 PM Ramuthevar, Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> > > On 15/5/2020 10:30 pm, Arnd Bergmann wrote:
> > > > On Fri, May 15, 2020 at 4:25 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > >> On Fri, May 15, 2020 at 4:48 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > > > iowrite_be32() is the correct way to store word into a big-endian mmio register,
> > > > if that is the intention here.
> > > Thank you for suggestions to use iowrite32be(), it suits exactly.
> >
> > Can you before doing this comment what is the real intention here?
> >
> > And note, if you are going to use iowrite*() / ioread*() in one place,
> > you will probably need to replace all of the read*() / write*() to
> > respective io* API.
>
> The way that ioread/iowrite are defined, they are required to be a superset
> of what readl/writel do and can take __iomem pointers from either
> ioremap() or ioport_map()/pci_iomap() style mappings, while readl/writel
> are only required to work with ioremap().
>
> There is no technical requirement to stick to one set or the other for
> ioremap(), but the overhead of ioread/iowrite is also small enough
> that it generally does not hurt.

Right, my suggestion is solely for consistency. It would be a bit
weird to see readl() along with ioread32() in the same driver (in case
there are no differentiated callbacks specifically for different type
of IP).

-- 
With Best Regards,
Andy Shevchenko
