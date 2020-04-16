Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF3C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAE9206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrikCjo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635522AbgDPM1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635437AbgDPM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:27:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF7C061A0C;
        Thu, 16 Apr 2020 05:27:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cl8so1320435pjb.3;
        Thu, 16 Apr 2020 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+zoPumabDR7wfNBhA607mfTPqFnvtYyNRR6pkJeNRc=;
        b=rrikCjo6OmPHVrOCaLm+Gva1H4yWEszY4mga/U1BhLvHHvvxk+RJGnSk8pXyWGDTgr
         ArZtQrXxCKbrMHwqCytmTWKdLrkD+mr9kWeBopESSnNTEUA6HwR18Bkpdg4+3EWHk+o/
         xOXwi90aVScXBzuqmuuquFT7mOyKeS0eAKYQRF3N6HM6P81Dl89CnOdCI2PIDo3bfAVb
         OL48EkapNSlDBThy5XhtEXvkOG6atbCLx2m23ifH//EO8ch2NKiuNU4hxZz9z2o/UrzZ
         AKN/dhyxPRoqSMtcHzhsflPexM1QwhfQXOejLz7kBkK1fSV5DIkhjRUBs9AltBnBTIsS
         aGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+zoPumabDR7wfNBhA607mfTPqFnvtYyNRR6pkJeNRc=;
        b=LN5W4JxgHksgxHpl453SFZ8qdupwKp45muqTbyHM7d/7T8jaRQGZtB0/eqgd/Mjn6a
         tsUHN4Nnbc3SdYM21xynyEOU4ruAIR2A0GGs9nCOHJKJKJKcWrq4kSPc9oW34/OLiar8
         qYKEWAqPOJHqIFP1+QM/ZRa/o6KYgU2tpdLp7J6vYzFAXKScV19tOEOUsgDaSfGItVBH
         4saPxW79fVysQMMmsr2ukllzLhmvAkvfxCnEY8S5/3XIzD+muiXXB8LUwLBpZsGX/oCe
         8gsqnmstFhUBsDmTwvyf9LsS+EtSMB6LhmPC1Hiwi4YQ448znsW8QrMJ6/6h21eGDc6K
         E5ug==
X-Gm-Message-State: AGi0PuYtZ1i/GWAHqXLQCfPlkAuuqDzJ++TOFwUowLm2efz1P2ns9AYq
        O/QpmvAU1PkOboO8wjYYaLyWquBfSl2IvDJHac4=
X-Google-Smtp-Source: APiQypJvkQh5+ugyct9yZGir74K1nYeyAEbWt+sAtjy2EG/owrAN5ZW/CfDb6rC12X8DVkuLLWoZMoJZIEJSmzjKy0U=
X-Received: by 2002:a17:902:854a:: with SMTP id d10mr8026966plo.262.1587040022687;
 Thu, 16 Apr 2020 05:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com> <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com> <20200416122619.2c481792@collabora.com>
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com> <20200416131725.51259573@collabora.com>
 <de9f50b8-9215-d294-9914-e49701552185@linux.intel.com> <20200416135711.039ba85c@collabora.com>
In-Reply-To: <20200416135711.039ba85c@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Apr 2020 15:26:51 +0300
Message-ID: <CAHp75Vcpb-556imBuhsY-asrKqx7LjvQbq+P-ysK-+ii91YpWQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        cheol.yong.kim@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        masonccyang@mxic.com.tw, Miquel Raynal <miquel.raynal@bootlin.com>,
        piotrs@cadence.com, qi-ming.wu@intel.com,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 3:03 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Thu, 16 Apr 2020 19:38:03 +0800
> "Ramuthevar, Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> > On 16/4/2020 7:17 pm, Boris Brezillon wrote:
> > > On Thu, 16 Apr 2020 18:40:53 +0800
> > > "Ramuthevar, Vadivel MuruganX"
> > > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

...

> > There are different features involved and lines of code is more, if we
> > add new driver patches over xway-nand driver
>
> How about retro-fitting the xway logic into your driver then? I mean,
> adding a 100 lines of code to your driver to get rid of the 500+ lines
> we have in xway_nand.c is still a win.
>
> >
> > is completely looks ugly and it may disturb the existing functionality
> > as well since we don't have platform to validate:'(.
>
> How ugly? Can you show us? Maybe we can come with a solution to make it
> less ugly.
>
> As for the testing part, there are 4 scenarios:
>
> 1/ Your changes work perfectly fine on older platforms. Yay \o/!
> 2/ You break the xway driver and existing users notice it before this
>    series gets merged. Now you found someone to validate your changes.
> 3/ You break the xway driver and none of the existing users notice it
>    before the driver is merged, but they notice it afterwards. Too bad
>    this happened after we've merged the driver, but now you've found
>    someone to help you fix the problem :P.
> 4/ You break things for old platforms but no one ever complains about
>    it, either because there's no users left or because they never
>    update their kernels. In any case, that's no longer your problem.
>    Someone will remove those old platforms one day and get rid of the
>    unneeded code in the NAND driver.
>
> What's more likely to happen is #3 or #4, and I think the NAND
> maintainer would be fine with both.
>
> Note that the NAND subsystem is full of unmaintained legacy drivers, so
> every time we see someone who could help us get rid or update one of
> them we have to take this opportunity.

Don't we rather insist to have a MAINTAINERS record for new code to
avoid (or delay at least) the fate of the legacy drivers?

-- 
With Best Regards,
Andy Shevchenko
