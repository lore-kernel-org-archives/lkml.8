Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950B4C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723C62077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FVPlhcN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDVWWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVWWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:22:34 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769FC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:22:32 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b18so3651239ilf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3pDdZfZ5bLsmtiaX3ho/Prc/GJlaWQtQCc0O+mFKI8=;
        b=FVPlhcN8SpwQ9kar8lLIzkCNOqERTFjDWWPdzkyz6Ph3snI/Dgm1QayGxRrtup/FYZ
         uvwjCAr4kTdVchuqSfKk4YE3zvMCIsjIsWXQYY8daJl3AlcUqfwO/f3EHzOMIUvrUVzn
         EQo3LNEU3QcAEw1oa9YnwK4Jg5j6Pzo+MbrrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3pDdZfZ5bLsmtiaX3ho/Prc/GJlaWQtQCc0O+mFKI8=;
        b=Pq7t7zCvoV2oUN8tXSDSu00R/EwrQ2Vw0lVdfz7umcNfLs0x/7wRq4lGveMTKkC+w2
         GNDPTO6wY2/MSDpZZFyqkCXF6rH1VVSLGNuwbJ9Da4NdqeJcx16efp8HLKZIySeh1vcK
         Z5ABchoMCUzOzgnYk3WUbWAzWgIkppZTH/KX+Rz/xezm8hbNvDdCEvEce3ASDNmOJn91
         qX4+IPPfVCUKSSrD7OFxBSdGgUtiEknV/uPBWmcMg/u+0Q4691tdJD2NHsfjszn8nQUM
         WbchwM8dDyjJ2ODbhwbKt2yp0EaS56g01zCLHI/ARhcEJNIntX5EtqIKENpGHqE6n9bg
         JLzQ==
X-Gm-Message-State: AGi0PubEWgID1IqRD90BFuFG27pxs7Gmi8XS+PUJ5shEjhFj6ZXFZlT3
        Y5n+/AUyVoXRKIuj8eGKClQJLg80o/tZjCJjYsdMsQ==
X-Google-Smtp-Source: APiQypKiuVyAXmTGcV8md8ByrtcR6N+7n1XLevZ5e2D1tSsN5M7OMFaWAdj4CGmVqHj4ltYZYw7z3KpjuiJzCLrizYg=
X-Received: by 2002:a92:c6c8:: with SMTP id v8mr586970ilm.129.1587594151810;
 Wed, 22 Apr 2020 15:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200421110520.197930-1-evanbenn@chromium.org>
 <20200421210403.v2.2.Ia92bb4d4ce84bcefeba1d00aaa1c1e919b6164ef@changeid>
 <CAODwPW9MtDLSL_up9W0TO1PcjyA_9cUtNo3No7XXusiwqKBLDw@mail.gmail.com>
 <CAKz_xw3-tvYoCDs07xEUBBMf024aezGMoZ35LsTN+_dXT9nC2Q@mail.gmail.com> <bbd8f97b-8479-c38e-011f-b52e2cf34403@amlogic.com>
In-Reply-To: <bbd8f97b-8479-c38e-011f-b52e2cf34403@amlogic.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 22 Apr 2020 15:22:20 -0700
Message-ID: <CAODwPW-PGzCzW9dP4UXiR5joKRLOKJVBzXwPS7n_Ne-QedfsCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: Add new arm_smc_wdt watchdog driver
To:     Xingyu Chen <xingyu.chen@amlogic.com>
Cc:     Evan Benn <evanbenn@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yonghui Yu <yonghui.yu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes I think you are correct. I got some reviews about the compatible name,
> > but I think I misinterpreted those, and arm,smc-wdt would work. I did wonder
> > if Xingyu from amlogic needed to modify the driver more, EG with different
> > SMCWD_enum values for the amlogic chip, he could then just add an
> > amlogic compatible
> > and keep our devices running with the other compatible. Although of
> > course it would be nicer if
> > the amlogic firmware could copy the values here.
> Using DTS property(arm,smc-id) or vendor's compatible to specify the
> Function ID is available for the meson-A1.The generic "arm, smc-wdt"
> looks nicer for MTK and Amlogic sec wdt, but the driver may not cover
> the other vendor's platform-specific differences in the future, so the
> platform-specific compatible string may be introduced eventually.

I think having a shared driver is only really useful if firmware
sticks to the same API anyway. Once we start implementing special
cases where every vendor uses a different SMC API, we might as well
make that totally different drivers then. For now it sounds like we
can fit existing MediaTek Chromebooks and Meson into the same API, so
let's do that (with a single arm,smc-wdt compatible string) and then
hopefully future vendors will see this interface and design their
firmware APIs to match it from the get go.
