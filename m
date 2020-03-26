Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2521C20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMamO+S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCZJ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:29:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46421 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCZJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:29:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so6739879wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UBGWriIek5v0PtwSr6maLDwCqpBsKEE/T0ObkYjazh4=;
        b=hMamO+S9uSMmYirEaLH+WfXFn5+pTev8UTI/BfQPluXmQLkA/kXVl5thwb0WHj3NXG
         OVUFYKndO40SrzZ6qK0V1tbFuUPkiPiUTqaTM/B5UMOIiVgJgKXJwiVU4h1AC4jIkytq
         e+IGBbozBs8D/xONjMpQFLUbMQjP9CiBRVTVcY/L9/PdE8Q13bleCYZaDi6uX4en4sOd
         TdaKqyIEHYjQidJ2rJPX9MnUKBhwZjJ51Y8XxXjEwiwE7rZUBs7+pqWNoR4mIKy7T6F0
         le773exPPJCMvTvSy95qNOzkWpG6DtKzDwXVWRc1SfC7amIWxhAXvlhQMD0ndTHOsSfr
         KVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UBGWriIek5v0PtwSr6maLDwCqpBsKEE/T0ObkYjazh4=;
        b=tsTgOcWy9NX6n1KF0mAKbaikJ1mTfRGhMhpmlIy4XvPx+H9EA/J9pYHnTN1R7PcWkk
         PdUp4uvx7Ryq2F93P1Q5Gti/DqFZCCbDxVdp5WE/XbUx/H2RE7ZkokP+ZQ4WD+Fg7JLk
         HHlF8uKOj5NnhWm59LddD5S7vQMqdWzMl4cogMtP68FWNzWxmbwX3BsEI66EJ6c5LrMm
         cR3BN2eNy8tecfNU9sS3vut1ittuG6AyeRwv30dgj8r989C02vmetkSIQ6ap7xwAsKkx
         leT9OgjCJvWEFWTlY986WPTMrXDtKX9tQ6CpdKWtRh4NpSPuXeNy2arJCCkryyFpneuU
         /yig==
X-Gm-Message-State: ANhLgQ16BwFuJeDsDhCQ1Nxad06TL7A2bySfPnXvnk5BLlVoOORmWAZy
        0McrQf4lGd4hX0i8kkxz8XXvhQ==
X-Google-Smtp-Source: ADFU+vvnwukm7zzP15OgKy56b6O0Cc4OinBoGIg9TVhQc2hJN41CAQsnoNiB9+V2WiGJ2qvxwOfKzw==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr8786646wrw.53.1585214970465;
        Thu, 26 Mar 2020 02:29:30 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id h26sm2598633wmb.19.2020.03.26.02.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 02:29:29 -0700 (PDT)
Date:   Thu, 26 Mar 2020 09:30:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, icenowy@aosc.io,
        anarsoul@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        megous@megous.com
Subject: Re: [PATCH v4 2/4] mfd: anx7688: Add driver for Analogix ANX7688 chip
Message-ID: <20200326093019.GC603801@dell>
References: <20200318070730.4012371-1-enric.balletbo@collabora.com>
 <20200318070730.4012371-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318070730.4012371-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, Enric Balletbo i Serra wrote:

> The ANX7688 chip is a Type-C Port Controller, HDMI to DP converter and
> USB-C mux between USB 3.0 lanes and the DP output.
> 
> For our use case a big part of the chip, like power supplies, control
> gpios and usb-c parts are managed by an Embedded Controller, hence,
> this is its simplest form of it. Other users of this chip might
> introduce new functionalities as per their requirements.

Hmm... So first impressions is that this 'driver' doesn't really do
anything useful other than checking the running model.  I think you're
better off using "simple-mfd" and doing the ID check inside the
useful/functional child device driver(s).

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/Kconfig         | 11 +++++
>  drivers/mfd/Makefile        |  1 +
>  drivers/mfd/anx7688.c       | 87 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/anx7688.h | 39 +++++++++++++++++
>  4 files changed, 138 insertions(+)
>  create mode 100644 drivers/mfd/anx7688.c
>  create mode 100644 include/linux/mfd/anx7688.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
