Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD23C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B16207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHYsfVWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgFMUeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgFMUeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:34:03 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0033C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:34:02 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id t23so3063949vkt.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFT7Bod/9AoTK+hxJjFcu5z1EALQ7iKlU3WZg2UfXP8=;
        b=mHYsfVWkpWT/Ai6osOEylJ7exHOUZGF4DaYhgObEejCaq1yPbfgEyqjZbr249SlXQZ
         n3RjhizZ0d7XosGnL4EZ+tFbht3dbKGR/bCJDOIbzJ3/CRzjm3h0aviYUJfv8p/p293x
         GKoMTAv9W4HsLYRBkfNW2U/aL/Xtn8YGr+PEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFT7Bod/9AoTK+hxJjFcu5z1EALQ7iKlU3WZg2UfXP8=;
        b=oBSLiX/0hTi7+SSjk59kDmeVX7BFvbYdzZGFDXWdmSF1JyTZC6HFSTurn9/Obm9vA9
         vVDcQwvIZhdszh72W1fYn7Tjv18pWdKRoyZP/ofQfeCzdTGp30sR0p+p04rIGFwFOQyi
         0pz5qnX/e6ImvZ8x74dmJnl02QbAtT8H/9foQMoUegWLazBnkg7bLglycnbdAt41RRZQ
         06uC2MsTAz8E3xdXMImvEDn4U21xpOOvf2Czv+829xykYeJxxyXne7WWy6Ic+HyvhOPF
         at9CTHNwW9lYamobiYao/ZR9ch7izSC481h4S1/39fKfao7l3HpFpRa94u9cjt0ClVCF
         LfuA==
X-Gm-Message-State: AOAM530IlEIn5Ilix/EJkchKl6lWvF4FwZYiAxc1L/6oh5QRedT9zwV2
        9Ig1BI/INdepCi93pk4TS35yGuV+gjA=
X-Google-Smtp-Source: ABdhPJxtIJjhwEo9NLw9ta4mD0iHNgjfphcOtiXECSxeQcVyMIrvj24h2vG392dH+7rkHiaf8XtSaQ==
X-Received: by 2002:a1f:2949:: with SMTP id p70mr14088344vkp.96.1592080441396;
        Sat, 13 Jun 2020 13:34:01 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id l14sm1596761vkl.47.2020.06.13.13.34.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 13:34:00 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id s192so3059623vkh.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:34:00 -0700 (PDT)
X-Received: by 2002:a1f:5cd0:: with SMTP id q199mr13644108vkb.34.1592080439926;
 Sat, 13 Jun 2020 13:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org> <1591868882-16553-3-git-send-email-rbokka@codeaurora.org>
In-Reply-To: <1591868882-16553-3-git-send-email-rbokka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 13 Jun 2020 13:33:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSfMPehyCLB25hct+GE8JtU=5J=04KyU4AoHfg9cs50A@mail.gmail.com>
Message-ID: <CAD=FV=XSfMPehyCLB25hct+GE8JtU=5J=04KyU4AoHfg9cs50A@mail.gmail.com>
Subject: Re: [RFC v2 2/3] drivers: nvmem: Add QTI qfprom-efuse support
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 11, 2020 at 2:49 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>
> This patch adds support for QTI qfprom-efuse controller. This driver can
> access the raw qfprom regions for fuse blowing.
>
> The current existed qfprom driver is only supports for cpufreq, thermal sensors
> drivers by read out calibration data, speed bins..etc which is stored
> by qfprom efuses.
>
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---

It makes all your code reviewers much happier (and much more likely to
take the time to review your patches) if you include a changelog with
what changed from one version to the next.  If you would like some
help maintaining such a thing, might I suggest "patman":

https://gitlab.denx.de/u-boot/u-boot/-/blob/master/tools/patman/README

...pay no mind that it's hosted in the U-Boot repo--it's really quite
a great tool.


>  drivers/nvmem/Kconfig  |   1 +
>  drivers/nvmem/qfprom.c | 405 ++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 385 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d7b7f6d..623d59e 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -117,6 +117,7 @@ config QCOM_QFPROM
>         help
>           Say y here to enable QFPROM support. The QFPROM provides access
>           functions for QFPROM data to rest of the drivers via nvmem interface.
> +         And this driver provides access QTI qfprom efuse via nvmem interface.

I'm not sure it was necessary to add that line, but I won't object if
you/others really like it.


>           This driver can also be built as a module. If so, the module
>           will be called nvmem_qfprom.
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 8a91717..312318c 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c

You've still mostly not addressed most of the review feedback I've now
given you 3 times.  Rather than repeating comments, I have simply
provided a patch that makes the driver into a state that I'm happy
with:

https://crrev.com/c/2244932

Rough summary:

* There should be no reason to provide "reset" values for things.  For
anything that you change for fuse blowing, just save and restore
after.

* Use the major/minor version read from 0x6000 to pick the parameters
to use.  Please double-check that I got this right.

* Reading should still read "corrected", not "raw".  Added a sysfs
knob to allow you to read "raw", though.

* Simplified the SoC data structure.

* No need for quite so many levels of abstraction for setting clocks /
regulator.

* Don't set regulator voltage.  Rely on device tree to make sure it's right.

* Properly undo things in the case of failure.

* Don't just keep enabling the regulator over and over again.

* Enable / disable the clock each time; now we don't need a .remove
function and yet we still don't leave the clock enabled/prepared.

* Polling every 100 us but timing out in 10 us didn't make sense.
Swap those.  Also no reason for 100 us to be SoC specific.

* No need for reg-names.

* We shouldn't be creating two separate nvmem devices.


In general I'm happy to post my series to the list myself to get
review feedback.  For now I'm expecting that you can squash my changes
in and send the next version.


-Doug
