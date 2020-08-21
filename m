Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17014207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Go5cdtDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgHUKJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHUKJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:09:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14D2C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:09:34 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c4so1132523otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJN3wZD2Iadhta+J9lF+eLKxZbEwH6T5LBO7jjWL+UY=;
        b=Go5cdtDw/2+rDAroF0NL2B1fIr6RE7CQ8LHkDCxS2qcKqj25C3XoWf8vXu/Zrkz2PE
         og4/7bXHMt+MQt3ZxSsTe+v71X31CqLGXEEcx6rZmNU8roR2f7OmYO5KjJlgSkwCtoV2
         n5bkoD6hUyYWaMMMkBiCnDNglxv8X/KImOgD+9lASXGRVJ8qk8tPz19tH1SPDmon47DX
         2CdHiTG+K0UESi9+k/xSZ+exC3c4dDklPFPjgcIUw7Ut6Nsh1DjVz3EGV0mc5MBtWdD4
         zm3OLquTJZrhOWZNHEaqtlXidtzUDmZ6VxL+3bPfOGtWVwEKEOPv50kZkpnYhaptT1uV
         2tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJN3wZD2Iadhta+J9lF+eLKxZbEwH6T5LBO7jjWL+UY=;
        b=jSAnppx1pFH1p5oyEFf4YCl0I32yKPZfLeyOIQVOAtm/4oguCzu45AQbmfgRM53XVp
         gVwZUfgKudOcjkTVP+6F3GNF4wSizBro4tKFR9ul/8XjcgbkTPlrl0pEBdXcFdwr6ejh
         QDP1POLrwk3EjB5DUAkuhmA6nfLYmrHllZ/OGr0WpBCh6qF7TXU9Bb87EB2qUaMlr91a
         X3QAy9UP/grijcHKWCBrNeMFlh20B4sCKg6jmqO9D5gxIGkkaUUJpChEHvqaVEFesxDk
         9xK6hbpb5rAg1Fubo2t9ZYyYneTZDvY0iXhh122EqLe4grmXVrY/eD8N2g2E9576JGAw
         kadg==
X-Gm-Message-State: AOAM530ashzpwUtUTTWcwowgEhFKEB2xyPQZKo5NEHnccGxm7umGRZ0c
        k4KAtRJgWwHyZXxGJuPoMY3Vux4If+hyd4tsaKu2Yv10+zI=
X-Google-Smtp-Source: ABdhPJxzqjOcT7nUk1v/EmEVCP82O+3t3KHPfKmS5jfJQNWxh1JZVhwbf1CcogoJ64Tnea3FfHuuo8fQujw2DY8DRNA=
X-Received: by 2002:a05:6830:11cc:: with SMTP id v12mr1461109otq.268.1598004574028;
 Fri, 21 Aug 2020 03:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200710101808.1316522-1-jens.wiklander@linaro.org>
In-Reply-To: <20200710101808.1316522-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 21 Aug 2020 12:09:22 +0200
Message-ID: <CAHUa44GKffKTBdrfchtj=wuM_4EMcFPw35DyXT7pRuqDYQ6VYA@mail.gmail.com>
Subject: Re: [PATCH] driver: tee: Handle NULL pointer indication from client
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Cc:     Cedric Neveux <cedric.neveux@nxp.com>,
        Michael Whitfield <michael.whitfield@nxp.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Jerome Forissier <jerome@forissier.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:18 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> From: Cedric Neveux <cedric.neveux@nxp.com>
>
> TEE Client introduce a new capability "TEE_GEN_CAP_MEMREF_NULL"
> to handle the support of the shared memory buffer with a NULL pointer.
>
> This capability depends on TEE Capabilities and driver support.
> Driver and TEE exchange capabilities at driver initialization.
>
> Signed-off-by: Michael Whitfield <michael.whitfield@nxp.com>
> Signed-off-by: Cedric Neveux <cedric.neveux@nxp.com>
> Reviewed-by: Joakim Bech <joakim.bech@linaro.org>
> Tested-by: Joakim Bech <joakim.bech@linaro.org> (QEMU)
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c      |  7 +++++
>  drivers/tee/optee/optee_smc.h |  3 +++
>  drivers/tee/tee_core.c        | 49 ++++++++++++++++++++++-------------
>  include/linux/tee_drv.h       |  3 +++
>  include/uapi/linux/tee.h      | 13 ++++++++++
>  5 files changed, 57 insertions(+), 18 deletions(-)

I almost forgot this one. I'm picking this up.

Cheers,
Jens
