Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC51207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKkSjnvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGIUCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGIUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:02:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CE5C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:02:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so1461372pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3z14lY97vXASMj1PrDNEz8cKF4lZZq/EFvNs+z/7mOc=;
        b=MKkSjnvRAxx4/qVf+1YXmxCkrWHU0nEIbp2Jc9g/L9G4C1axUGYI25wNrdlx2WXyqR
         92eNdEM2lpnJYewa4usNccDoiCKaorIzTMzV/vetehFfngQbriv518KpLcVt1P2wz+Cs
         cL02C+7bRcrtPg484JK9xWW1/LcFdnNPfUwzoDvw1yaZneAW6AdlJQMTle4aW/AHAn/0
         XKM20oalN87ow358jbkhFtcGxsXgO7enY9UFYyVsfZUX6UZ9sJmPC54oUmqYbhWuxdrx
         0FIOQrQUiyLFOqOYHHAc8nSZRoLZpP7V7ylu0i4Doo6HjhslNF3aqW8Ix78RD4/Y1QqY
         2ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3z14lY97vXASMj1PrDNEz8cKF4lZZq/EFvNs+z/7mOc=;
        b=E2RdYYRlr/o1n1u8n7umUfbvgTwApss+5qC2aKGPMDfPA3J2bA7PCBYAQSigLy/ELN
         w75LXT13+Nvqj6NGW/Lu5rN3BMRxwh08wu/o44nEGhIl3T4Pa7jBgI3YSQ1VLiKpHMTW
         3DzIGViPdkweLtD6ksSpzNpCS5firhZ75P5AAOckYi+5SGOO4m/+222NJJD+bBAMyiDc
         8Bjdt0+TMBxW7EIUTOchWizAj6FcX9vXvrtwKFqldDDi/+TKWTa0K3qnoBBBAmfCpFBG
         sFJOtC9dat4l/PhLIc8dpzWYg3Joa89fMThYqnmJzNn01aGAfJwZyaqSrEz/kSCigkJI
         vAqw==
X-Gm-Message-State: AOAM530SocJhQsoiLJhkiWj5wH8+EkfEeHgZ/1PmAARvzkSOHhEngB7P
        Q1t+W64Dynr2e20iZpnf60FUW8F2iXgwh60ZZsE=
X-Google-Smtp-Source: ABdhPJzQ5gFNblMOR4BmUWDLXOWG/XqyZSTZN3n5FDRGxPL3uMGt4ALEUO+9GsmhbNdJEGV7YHhfN/qFC2/2PutzcSA=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr48709589pgn.4.1594324964993;
 Thu, 09 Jul 2020 13:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <202007100247.bJq2hgt6%lkp@intel.com>
In-Reply-To: <202007100247.bJq2hgt6%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 23:02:28 +0300
Message-ID: <CAHp75VfpC6rX41dts3KeyMLPh8QD3ojEH6Moyu-1naE-_cfrFg@mail.gmail.com>
Subject: Re: drivers/pinctrl/pinctrl-mcp23s08_spi.c:129:1-3: WARNING:
 PTR_ERR_OR_ZERO can be used
To:     kernel test robot <lkp@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 9:34 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
> commit: 0f04a81784fe3ddc00cae74c517265b3ddb8825c pinctrl: mcp23s08: Split=
 to three parts: core, I=E6=B6=8E, SPI
> date:   3 months ago
> config: i386-randconfig-c001-20200709 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

>    128          mcp->regmap =3D devm_regmap_init(dev, &mcp23sxx_spi_regma=
p, mcp, copy);
>  > 129          if (IS_ERR(mcp->regmap))
>    130                  return PTR_ERR(mcp->regmap);
>    131
>    132          return 0;

Right.

I expect LKP to generate such patches and submit :-)

--=20
With Best Regards,
Andy Shevchenko
