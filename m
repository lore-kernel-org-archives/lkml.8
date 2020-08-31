Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A455C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2009220693
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEwUCWrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:08:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C902DC061573;
        Mon, 31 Aug 2020 03:08:35 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a12so4832365eds.13;
        Mon, 31 Aug 2020 03:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i8mDMEkMlEKb7YAMGET4QjohLG3lZw/hOxyAJzH3u8k=;
        b=WEwUCWrglXyoan/T/4uUfI0wUuwhac//uqp5zLQmnbUYajGE2FMcVhgReaIf0QR9e5
         ur2y3QvrYINxyl5xnMmQBOfmXInLcf0ha3OUCihv23tK2ceO7NEN+XDftvp8ZW4PxMN3
         wR8wDpLMqhgovV4eGum10KsLmRq8j7FzimCXkwPqaXCtwTr3g3D7buNlmaXkjNiwMXE5
         EU2L6azgMfmj1XpsfpIKxUvYoHsZVcnQ9asJ7LzWEIW0E6qWo+94amkrXDcNuCgZsRDs
         cpA/npXjf8hhU96gx6CJbpElmtxFA54eFfd37fc8sVDSSj01VFLDrzkZDAjNzMhduVRj
         x/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8mDMEkMlEKb7YAMGET4QjohLG3lZw/hOxyAJzH3u8k=;
        b=E7hOJHHlfLanmoSZFtUgLsGAnP/MEz4OnAigncRXS3xCrnifjsEbIdTLEYRQ79tf0c
         MGYAf56cf7pOp8YvFxaBLQF580KYe0UZyPeBoiGzjUjmdzBPucLD+TQMswH1VOK8rvhJ
         CUpxpm2Fh1lUfrZKqN1DaQddLbJbxbWiqSJufabQPDOI4wP97nRv0/Rj5E+T4AtS5VMw
         t88/nhfCC00Rkj+SXgTElTTMGG+KN0XHO9/P6YnQ/pLQ4Odk2grXCBlzRaqIDqppjNqk
         OEcx9low/vI2pyN6JC9udUidNp1sqkJRgS6kTlyml5QsAFUu3Tc5E1GL1/qQ66Za/tNr
         /snw==
X-Gm-Message-State: AOAM532GP6MaNGjOWBDlkTIRl49DRwy3hKVS7LhxPMDJpUN1LsMO8xay
        ezWw4i6yb1XvXGPoctFJRl4=
X-Google-Smtp-Source: ABdhPJzoo5VnXqrCIaiiNgpxdD7Ek9UGl4eBBccGJaHD/tjO8nJ8Ivcxxni7HOtuM9GyjXuMDwajqw==
X-Received: by 2002:aa7:dd94:: with SMTP id g20mr481362edv.238.1598868514539;
        Mon, 31 Aug 2020 03:08:34 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r3sm7643620ejy.95.2020.08.31.03.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:08:34 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] arm64: dts: rockchip: px30: Add Engicam C.TOUCH
 2.0
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
 <20200831082917.17117-7-jagan@amarulasolutions.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <0e286dbd-36e7-54cf-b901-4718d5f7ee6d@gmail.com>
Date:   Mon, 31 Aug 2020 12:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831082917.17117-7-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

A dtsi file with only an include and no changes isn't useful.
Are you planning to add something to it?
Else combine in single dts file for now.
Same for px30-engicam-edimm2.2.dtsi

On 8/31/20 10:29 AM, Jagan Teki wrote:
> Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose
> carrier board with capacitive touch interface.
> 
> Genaral features:
> - TFT 10.1" industrial, 1280x800 LVDS display
> - Ethernet 10/100
> - Wifi/BT
> - USB Type A/OTG
> - Audio Out
> - CAN
> - LVDS panel connector
> 
> SOM's like PX30.Core needs to mount on top of this Carrier board
> for creating complete PX30.Core C.TOUCH 2.0 board.
> 
> Add support for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> Changes for v3:
> - add Amarula Solutions copyright
> Changes for v2:
> - none
> 
>  arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
> new file mode 100644
> index 000000000000..58425b1e559f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +#include "px30-engicam-common.dtsi"
> 

