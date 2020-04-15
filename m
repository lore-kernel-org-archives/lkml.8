Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE4C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F032076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcpO7VAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505727AbgDONCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505573AbgDOM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:59:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58880C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:59:33 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k28so2523620lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DI2AFHL2tx49XNx60DqvVugAFBZg+6vnc4k/tFews4w=;
        b=pcpO7VATwXbQgRo4gDRrisKgiqAhNg4kooWvscgbiAxACXrbuk6q6rB0qUtUbGdYuY
         H2lD3k7Xsb5HZvF2rNoQOcFEHHJTpGYqBLUtokuiXQ0x386I1agfawl4xjeNKeocBWAW
         PFMI63Gs9KSUVuxama69onANow47fHEzrBRgdW1sZwD9uZT1QIJfi4a+KQyCFSKczhzr
         LiL1E6/yf9xkU2bOFPyVkOXiawIoN+VtzHqR/GX9a2MvHVQ2O70aft0ZT6B+W8bCq+ic
         rMUrCWrGutxkwrVda6/xbdIF+IFCCriYE6ACMkQTjss64U77lu6YuA5dlsP6Tg2Idfdz
         1UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DI2AFHL2tx49XNx60DqvVugAFBZg+6vnc4k/tFews4w=;
        b=nACdFxyCfzudKzFiqH3Uc95XJvc40bjWnMXgUXWiup9zeqpy8g3Bpw6I9D9V1c5FJJ
         MFSkDkAf05wXNWK6giLQnm4U8tBuCzuTWcNAD9THkrOnL+zsk8HpGWmPAdXYrU64Tr41
         dS4JMGh3TG38a70B26w/h5LKyTiXfxOzOAQZ8t+jz+37bSGtGkDEhNE/QgNrSdQ3M2Hi
         bxx7Xa2lD4Cay66B99AKb0pjL/3QLIZHTjEMgG5jqOTsmmZeYAfaqrRHLEOrdaDoCgOF
         NtasddcBFsNfZtJNnMrCRXfjeZSeQhEcSTqxvuA/fZ/a5b95i6VBsqQ7sTS9B42Tmbah
         dDUg==
X-Gm-Message-State: AGi0PuZqtapExtTD9S5Yvpp7h4vpOSE8RuNtjUOG0pkoeq+ALamq0svI
        ppL0J2fpcJOK0p6fY2ZqosuPfQvdj+ADoC9qe20=
X-Google-Smtp-Source: APiQypKdHRnG1jLXD546lADoQJVvI8dmouDB4eFL8ge91ANINXKAaEDi1lrwQj1WqbczqeOKIvJm09XmsCELPL9SPKw=
X-Received: by 2002:ac2:5042:: with SMTP id a2mr3033068lfm.13.1586955571854;
 Wed, 15 Apr 2020 05:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586757922.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586757922.git.baolin.wang7@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 15 Apr 2020 20:59:20 +0800
Message-ID: <CADBw62p7Z9tLYknc6Jev5dhSrbDpJ_Lr8w8-dC0DG-3gYsMcMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Add new reg_update_bits() support
To:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Apr 13, 2020 at 2:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> The Spreadtrum platform uses a special set/clear method to update
> registers' bits, thus this patch set registers a physical regmap
> bus into syscon core to support this feature instead of using the
> MMIO bus, which is not a physical regmap bus.
>
> Any comments are welcome. Thanks.

I saw Mark had applied patch 2 already. Thanks Mark.

How do you think the syscon changes? As Mark pointed out, we can not
add update_bits() for MMIO regmap bus, which is not a real physical
regmap bus, so I introduced a new helper to allow a  physical regmap
bus to be registered.

And I wonder if you can apply the SPRD SoC driver through your tree if
no objections from your side? Thanks.

> Changes from RFC v1:
>  - Add new helper to registers a physical regmap bus instead of
>  using the MMIO bus.
>
> Baolin Wang (3):
>   mfd: syscon: Support physical regmap bus
>   regmap: Add bus reg_update_bits() support
>   soc: sprd: Add Spreadtrum special bits updating support
>
>  drivers/base/regmap/regmap.c   |  1 +
>  drivers/mfd/syscon.c           | 16 ++++++-
>  drivers/soc/Kconfig            |  1 +
>  drivers/soc/Makefile           |  1 +
>  drivers/soc/sprd/Kconfig       | 16 +++++++
>  drivers/soc/sprd/Makefile      |  2 +
>  drivers/soc/sprd/sprd_syscon.c | 76 ++++++++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h     |  7 ++++
>  8 files changed, 118 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/sprd/Kconfig
>  create mode 100644 drivers/soc/sprd/Makefile
>  create mode 100644 drivers/soc/sprd/sprd_syscon.c
>
> --
> 2.17.1
>


-- 
Baolin Wang
