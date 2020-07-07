Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E37CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1450620771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nQs45AXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGOwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:52:54 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09948C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:52:54 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id m25so22625447vsp.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98AdsqqRjlaGJp91iQRXkQZz+bGHVBhDqISPcBVmDps=;
        b=nQs45AXPESmHetUd58Ao+aWwmBOtzz/7S1co6O1GFiXjNCivyMqRG2UQ79V74PRLhS
         0vwvOIRMP5SSEVhDnT2rYFzz66hQd1L1gU6YUFMtiOsYKEafmoRV893Ea6wOzcCs1yZL
         QBSRtabSV8YH8jooW8U58um0Xh6MhGSmsAM3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98AdsqqRjlaGJp91iQRXkQZz+bGHVBhDqISPcBVmDps=;
        b=hFE2y+R0G0/VyLJA39pPe2HFbx+OCsgD5bXow+vubK3I2r/4RHddiNPNwffWpbV+jk
         Xple6MdPP+mFI41zQyfPRr3Ta5zlcTK/dl6VBEyoWVNTStYgV/flAPylNarPhhzmUfJr
         4pc8CG/Wtqh3rnNGdOvt6MPnOzYY2V897HuSLZYSqyaLjfswzholAZDoNEPKP1CZrYwH
         pqf8Gsg/D+f2/8fCUibis0huh0ia1J5XynnaU6EYOIolbPosmCX37LjQhSMRNhMhTbKV
         /+SHgFL+T8LoALBoFX4fctqyUPNxlmTCW2A15t2q/HtJJ5+hdeX4CyuOLx8VVTNmzPFv
         +XPQ==
X-Gm-Message-State: AOAM532r7ffbQq7fLg46Q7VH1UNWbcgeznLLS+uOl2oRyd0BplTTb9Qp
        gSv6Dplfdr/2AcqZTt6Bn8uyX30YJJg=
X-Google-Smtp-Source: ABdhPJxvc9JMCEojJgaie/18fQS5710b2WS+HFxnNmpW1X3mjdmOjmUlXHhoMYtSe9SVqM3M73i2bQ==
X-Received: by 2002:a67:fa53:: with SMTP id j19mr22547957vsq.43.1594133573010;
        Tue, 07 Jul 2020 07:52:53 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id p123sm89710vsd.9.2020.07.07.07.52.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:52:52 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id p25so14865935vsg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:52:51 -0700 (PDT)
X-Received: by 2002:a67:31cc:: with SMTP id x195mr41265042vsx.101.1594133571467;
 Tue, 07 Jul 2020 07:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200622144929.230498-1-dianders@chromium.org> <20200622074845.v4.3.I68222d0b5966f652f29dd3a73ab33551a6e3b7e0@changeid>
In-Reply-To: <20200622074845.v4.3.I68222d0b5966f652f29dd3a73ab33551a6e3b7e0@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Jul 2020 07:52:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJ9fm0z-6kAm4wDCfb8Ugr53i4RciCHTJT91ec27Mm4A@mail.gmail.com>
Message-ID: <CAD=FV=UJ9fm0z-6kAm4wDCfb8Ugr53i4RciCHTJT91ec27Mm4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] nvmem: qfprom: Add fuse blowing support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     mturney@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, dhavalp@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 7:49 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> From: Ravi Kumar Bokka <rbokka@codeaurora.org>
>
> This patch adds support for blowing fuses to the qfprom driver if the
> required properties are defined in the device tree.
>
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - Only get clock/regulator if all address ranges are provided.
> - Don't use optional version of clk_get now.
> - Clock name is "core", not "sec".
> - Cleaned up error message if couldn't get clock.
> - Fixed up minor version mask.
> - Use GENMASK to generate masks.
>
> Changes in v3:
> - Don't provide "reset" value for things; just save/restore.
> - Use the major/minor version read from 0x6000.
> - Reading should still read "corrected", not "raw".
> - Added a sysfs knob to allow you to read "raw" instead of "corrected"
> - Simplified the SoC data structure.
> - No need for quite so many levels of abstraction for clocks/regulator.
> - Don't set regulator voltage.  Rely on device tree to make sure it's right.
> - Properly undo things in the case of failure.
> - Don't just keep enabling the regulator over and over again.
> - Enable / disable the clock each time
> - Polling every 100 us but timing out in 10 us didn't make sense; swap.
> - No reason for 100 us to be SoC specific.
> - No need for reg-names.
> - We shouldn't be creating two separate nvmem devices.
>
>  drivers/nvmem/qfprom.c | 314 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 303 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 8a91717600be..0a8576f2d4c6 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -3,57 +3,349 @@
>   * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>   */
>
> +#include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/io.h>
>  #include <linux/nvmem-provider.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* Blow timer clock frequency in Mhz */
> +#define QFPROM_BLOW_TIMER_OFFSET 0x03c
> +
> +/* Amount of time required to hold charge to blow fuse in micro-seconds */
> +#define QFPROM_FUSE_BLOW_POLL_US       10
> +#define QFPROM_FUSE_BLOW_TIMEOUT_US    100

A quick follow up found that, in some cases, a timeout of 100 us
wasn't enough.  Changing the above to:

poll - 100 us
timeout - 1000 us

...fixed the problems.  I'm happy to:

* Spin the whole series to change those 2 numbers.

* Have those numbers changed by a maintainer when patches are applied.

* Sit tight and wait for additional feedback before taking action.

Given that I've resolved previous feedback, I've been assuming that
the series looks fine and we're sitting waiting for Rob Herring's
blessings on the bindings before landing.  Is that correct?

-Doug
