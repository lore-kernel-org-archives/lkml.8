Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E324C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 22:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E750420658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 22:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZWXLQT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGNWt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 18:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGNWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 18:49:26 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 15:49:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id p6so6222549uaq.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNJcN6mLND7hGUFH8LxiuF8orLzpAOdT0rwg30+KdFo=;
        b=WZWXLQT7HVMEVUxBOVYq/jrKsoJ4OeZpXcWk+hh+6MGg5SlIPAFyQT8iyjybZx/FLp
         13/ba7iy/rNmIW9cjgWbdS33xvpxAOb0eHAIVN3tgC7xukGJjp2NrwAR6AAcFfYQRj3P
         Z8HyBiPej8K57PY269Yf/5/WRp8BrUb1UOih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNJcN6mLND7hGUFH8LxiuF8orLzpAOdT0rwg30+KdFo=;
        b=LhwsiYUTAuw0gpJPtBIctY5jcRIuKcG/GKnuI1nYJX9rKXp7E3nxA1iy8jOIrwRP36
         JuneUfUQgpV7aX0ai8KeyvNS40jJZuwYddRqZox2JcIEbKkwfBLoLCFdK8pXslTOvWOV
         kbfl176J8a8bXX6uwHmgY3B3DLUS1yuRRcYhyiZ6ZzokviS2dtyf+ShgR6uSgqbNw0wS
         XGQhbq0EnTByppeVHN1Uxb5KdLOS98UND8nGrBXyMPDXj9CX2xDzlPRnCNyq6Rat8vPj
         gtiBgsxsG++RjP1hKcNeBaAdFl6pq6OATC6rop6hue+C35EsaJRwr7f4l/d+f+0GUYjH
         wePA==
X-Gm-Message-State: AOAM533NVAhcuZMEtBgzNrpf9bVX7qV2nf6WVXcIicaMApR75Ytm+b+X
        VP0eyxhObB24b9YimQfwTNMP+kw+3rs=
X-Google-Smtp-Source: ABdhPJxFTUEH4B6oPyJ+WuD5UlwsDUCJEVunFbrcg+HkScEmActBzhy5elLtAoFJ9l9wKczjW1mfQA==
X-Received: by 2002:ab0:2eab:: with SMTP id y11mr4955600uay.22.1594766964293;
        Tue, 14 Jul 2020 15:49:24 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id i184sm31461vsc.18.2020.07.14.15.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 15:49:23 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id p6so6222538uaq.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 15:49:22 -0700 (PDT)
X-Received: by 2002:ab0:486d:: with SMTP id c42mr5270405uad.64.1594766962230;
 Tue, 14 Jul 2020 15:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200710143520.1206846-1-dianders@chromium.org>
In-Reply-To: <20200710143520.1206846-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jul 2020 15:49:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-OUSO6E5+1SFZrFbWSxqzEYXKuE-CqCcjp++ytmL0ow@mail.gmail.com>
Message-ID: <CAD=FV=V-OUSO6E5+1SFZrFbWSxqzEYXKuE-CqCcjp++ytmL0ow@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] nvmem: qfprom: Patches for fuse blowing on
 Qualcomm SoCs
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     sparate@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        mturney@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>, dhavalp@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas,

On Fri, Jul 10, 2020 at 7:35 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This series enables blowing of fuses on Qualcomm SoCs by extending the
> existing qfprom driver with write support.
>
> A few notes:
> - Though I don't have any firsthand knowledge of it, it's my
>   understanding that these changes could be used on any Qualcomm SoC.
>   However, it's likely not very useful on most boards because the
>   bootloader protects against this.  Thus the write support here is
>   likely only useful with a cooperating bootloader.
> - Blowing fuses is truly a one-way process.  If you mess around with
>   this and do something wrong you could irreparably brick your chip.
>   You have been warned.
>
> Versions 1 and 2 of this series were posted by Ravi Kumar Bokka.  I
> posted version 3 containing my changes / fixups with his consent.  I
> have left authorship as Ravi but added my own Signed-off-by.
>
> Version 4 is a minor spin over version 3.
>
> Version 5 is an even more minor spin and just bumps up some timings to
> fix a failure reported by Ravi on one device.  I've collected Rob
> Herring's reviews and (as far as I know) this is ready to land.
>
> Changes in v5:
> - QFPROM_FUSE_BLOW_POLL_US 10 => 100
> - QFPROM_FUSE_BLOW_TIMEOUT_US 100 => 1000
>
> Changes in v4:
> - Maintainer now listed as Srinivas.
> - Example under "soc" to get #address-cells and #size-cells.
> - Clock name is "core", not "sec".
> - Example under "soc" to get #address-cells and #size-cells.
> - Only get clock/regulator if all address ranges are provided.
> - Don't use optional version of clk_get now.
> - Clock name is "core", not "sec".
> - Cleaned up error message if couldn't get clock.
> - Fixed up minor version mask.
> - Use GENMASK to generate masks.
> - Clock name is "core", not "sec".
>
> Changes in v3:
> - Split conversion to yaml into separate patch new in v3.
> - Use 'const' for compatible instead of a 1-entry enum.
> - Changed filename to match compatible string.
> - Add #address-cells and #size-cells to list of properties.
> - Fixed up example.
> - Add an extra reg range (at 0x6000 offset for SoCs checked)
> - Define two options for reg: 1 item or 4 items.
> - No reg-names.
> - Add "clocks" and "clock-names" to list of properties.
> - Clock is now "sec", not "secclk".
> - Add "vcc-supply" to list of properties.
> - Fixed up example.
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
> - Name is now 'efuse' to match what schema checker wants.
> - Reorganized ranges to match driver/bindings changes.
> - Added 4th range as per driver/binding changes.
> - No more reg-names as per driver/binding changes.
> - Clock name is now just "sec" as per driver/binding changes.
>
> Ravi Kumar Bokka (4):
>   dt-bindings: nvmem: qfprom: Convert to yaml
>   dt-bindings: nvmem: Add properties needed for blowing fuses
>   nvmem: qfprom: Add fuse blowing support
>   arm64: dts: qcom: sc7180: Add properties to qfprom for fuse blowing
>
>  .../bindings/nvmem/qcom,qfprom.yaml           |  96 ++++++
>  .../devicetree/bindings/nvmem/qfprom.txt      |  35 --
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       |   4 +
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          |  10 +-
>  drivers/nvmem/qfprom.c                        | 314 +++++++++++++++++-
>  5 files changed, 411 insertions(+), 48 deletions(-)

I know it's a little early to ping and that folks are busy, but I'm
getting to a bit of a time crunch to land this driver in the Chrome OS
kernel tree.  I'd prefer for it to land upstream first so I can pick
exactly what landed but if not then I'll just pick what I posted to
the mailing list.

Any chance you can give an approximate timeline for when it might land
so I can either wait a little while longer or stop waiting and just
take what I posted to the lists?

Thanks!  :-)

-Doug
