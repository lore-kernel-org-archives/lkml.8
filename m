Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228DEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44B820644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itDE7aS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbgFYFAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFYFAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:00:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:00:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so2460233pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gNtbIZ568VO1hTjCxcIyUTJVwIpNwttbY91p1QqsdC4=;
        b=itDE7aS4I50IkCwOnZKTfUWfju44bYUDoiNCiZT06igwGbt4AypALVfBSnRQE+UE5O
         MCGjc4V4zkDKnPLjgijrdHTJ1W9zHDPLWbfuOGJwzHDj8Cfc6Pg4ozFdmxpGNbxZbOaH
         BepHUKCntSEv7ip2c/PQHxRoY4IBIyXZ7/wScKKy1i4F53C+nh5WGOX3P/mudcjMhiyF
         Z4Ut03GDayTQfhXPOc73e/HyYxqIM0nWdhvySpMedRmW71CvTAc262gqR4SSd+TjboM2
         FgYNrAJHFaYfO6aj6YB8MIY1vdSB3ZKXjqE4zMmztIgcWQIUE3JV5Ih17HAkWqLE8M9J
         jzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gNtbIZ568VO1hTjCxcIyUTJVwIpNwttbY91p1QqsdC4=;
        b=V6GpWG2BO65lvhIv+alZZn/CDA5vq+D71Gx2n8RoWicb6mSK8B78tq7qfx5laNBMk1
         urkjiUbrsBONchWtwcvyFNR3M9TfZ9/scwPrP8PUj7nNApraRZbdTCxrgI+3YXu39gTb
         BU0q68zmX4V9HGu2Hw5QnWgVL+FSt7VO5R6C8nSmmxiIJ53mTk2pDTds4KxdB7MPBJhV
         1lf8VYDtrOuC/mI3TFg/VpHwkloAXQxwfr5BdnQ5DFBaHeLsd5QyIeQeFEYCj3hUbt7K
         3Azj2bbXFmZLAK9BlBuO5RFWpnRcAFJtPtvyivDzVuB7D6smHWjWAN1qgJAxFfDpQMp6
         cBxQ==
X-Gm-Message-State: AOAM532WzKN0lMGcofIsxw2Kabef7fszCLVXk+l9vW8WAv7UbmfcT6iO
        XsMFQ7fsbQvNR4tfaVdTOAr4ow==
X-Google-Smtp-Source: ABdhPJwh9JC1nam0V/DJQyApj/Ye+dnlgpcjMSQVecblYDk0/KQNNSpYA3pCrHD9eiNJbOSmczVeQA==
X-Received: by 2002:a62:3041:: with SMTP id w62mr31621996pfw.205.1593061202490;
        Wed, 24 Jun 2020 22:00:02 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v9sm21531382pfe.198.2020.06.24.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 22:00:01 -0700 (PDT)
Date:   Wed, 24 Jun 2020 21:57:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org, wsa@the-dreams.de,
        broonie@kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        swboyd@chromium.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mka@chromium.org, dianders@chromium.org, evgreen@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 0/8] Add interconnect support to QSPI and QUP drivers
Message-ID: <20200625045720.GV128451@builder.lan>
References: <1592908737-7068-1-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592908737-7068-1-git-send-email-akashast@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 03:38 PDT 2020, Akash Asthana wrote:

> This patch series is based on tag "next-20200622" of linux-next tree.
> 

Series applied to the qcom tree, thank you and thanks for the Acks.

Regards,
Bjorn

> High level design:
>  - QUP wrapper/common driver.
>    Vote for QUP core on behalf of earlycon from probe.
>    Remove BW vote during earlycon exit call
> 
>  - SERIAL driver.
>    Vote only for CPU/CORE path because driver is in FIFO mode only
>    Vote/unvote from qcom_geni_serial_pm func.
>    Bump up the CPU vote from set_termios call based on real time need
> 
>  - I2C driver.
>    Vote for CORE/CPU/DDR path
>    Vote/unvote from runtime resume/suspend callback
>    As bus speed for I2C is fixed from probe itself no need for bump up.
> 
>  - SPI QUP driver.
>    Vote only for CPU/CORE path because driver is in FIFO mode only
>    Vote/unvote from runtime resume/suspend callback
>    Bump up CPU vote based on real time need per transfer.
> 
>  - QSPI driver.
>    Vote only for CPU path
>    Vote/unvote from runtime resume/suspend callback
>    Bump up CPU vote based on real time need per transfer.
> 
> Changes in V2:
>  - Add devm_of_icc_get() API interconnect core.
>  - Add ICC support to common driver to fix earlyconsole crash.
> 
> Changes in V3:
>  - Define common ICC APIs in geni-se driver and use it across geni based
>    I2C,SPI and UART driver.
> 
> Changes in V4:
>  - Add a patch to ICC core to scale peak requirement
>    as twice of average if it is not mentioned explicilty.
> 
> Changes in V5:
>  - As per Georgi's suggestion removed patch from ICC core for assuming
>    peak_bw as twice of average when it's not mentioned, instead assume it
>    equall to avg_bw and keep this assumption in ICC client itself.
>  - As per Matthias suggestion use enum for GENI QUP ICC paths.
> 
> Changes in V6:
>  - No Major change
> 
> Changes in V7:
>  - As per Matthias's comment removed usage of peak_bw variable because we don't
>    have explicit peak requirement, we were voting peak = avg and this can be
>    tracked using single variable for avg bw.
>  - As per Matthias's comment improved print log.
> 
> Changes in V8:
>  - Add [PATCH V8 5/8] to factor out common code for clock setting.
>  - Combine ICC voting and clock setting to single API. [PATCH V8 6/8]
>  - Add ICC voting per transfer because in case of multi message,
>    transfer frequency can vary for each message/transfer.[PATCH V8 6/8]
> 
> Akash Asthana (7):
>   soc: qcom: geni: Support for ICC voting
>   soc: qcom-geni-se: Add interconnect support to fix earlycon crash
>   i2c: i2c-qcom-geni: Add interconnect support
>   tty: serial: qcom_geni_serial: Add interconnect support
>   spi: spi-geni-qcom: Add interconnect support
>   spi: spi-qcom-qspi: Add interconnect support
>   arm64: dts: sc7180: Add interconnect for QUP and QSPI
> 
> Douglas Anderson (1):
>   spi: spi-geni-qcom: Combine the clock setting code
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi  | 127 ++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-qcom-geni.c    |  26 +++++-
>  drivers/soc/qcom/qcom-geni-se.c       | 150 ++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-geni-qcom.c           | 100 +++++++++++++++--------
>  drivers/spi/spi-qcom-qspi.c           |  56 ++++++++++++-
>  drivers/tty/serial/qcom_geni_serial.c |  38 ++++++++-
>  include/linux/qcom-geni-se.h          |  40 +++++++++
>  7 files changed, 496 insertions(+), 41 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
> 
