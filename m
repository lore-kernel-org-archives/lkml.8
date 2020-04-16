Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337F2C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C28E20784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTUUxmnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503023AbgDPIzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502965AbgDPIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:51:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2787C0610D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:51:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d77so3687973wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aQURq1REwHEPMxWj0A/UhXFxGHBPx1Zt6Uxv60umXok=;
        b=iTUUxmnxUoqM1iP5zj7BbzhwKQK2NqYbdVMK0rIh0CiAAy9/it6DIt1DL4Ooif9/bE
         Pul6F77qct+LdTVwj/1QFZe9JzU7U365RE9K2ngJq6+qZ15SxAPXTQR3XQRAdySjswRR
         9JYky000loQpUPX3wnZRvPFFa45uhJxKiqbju2/rslkJy7h3NmXl0ZIYzg2ZbfnCQ5dc
         AsNg7kMa9TiJe/4kUyOORB8GNBgxQrV21VfhsiPqvwyuyliDY3hqDbicfevTFn5hB8rm
         ++qfzQ5FGFbm9rT/GFdYCl8cOGCJR7Yj/AL+Xc5pcZgU+6DZeOb6aSyklfhfqZMu9KiT
         XbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aQURq1REwHEPMxWj0A/UhXFxGHBPx1Zt6Uxv60umXok=;
        b=cTOzUW0d4tX243Vqq1TTceCBwt8UlBhimJIFBJFJhNdHlLQe12bQUFkfMfs0sJ0OVc
         1j4Vj3vVBGisISp8bjkPf94M7eIY7bvrgITTy3SNiddqUiDkDLqbsbjT9Rf16F/+adxU
         OpXOQP7PYtojFVNYUJ70mXIc+Of0aX22qFZn1UkqY+SA6KCsmpG/owv+6i47uWgZHCnV
         pP9O2zveKFK93aR2T/FdXvU28t0QemZNLf54nldG+hrq5F4DgzFMgJlGRyAF6v9M72lb
         pduukDvSHLMxlrCXUxH2w3xnf4HH4OQdFKqFF/4WseEymJmK0u7X3z+GSxzrgoZebzN5
         9+0w==
X-Gm-Message-State: AGi0PuYgYJfvHBpJZTucToyCs8wZV7+N6DtkPLoqtXlZMTMAhqS7oPOr
        qhL1D2peCTZD6kpGiG0z/INUxA==
X-Google-Smtp-Source: APiQypKU3qRZVCXuxnBOouk3e3DEAX4zubXTv+zywdpux61f+2SAQwvIpImS075eYrYQxApgGH0znw==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr4036229wmi.52.1587027093347;
        Thu, 16 Apr 2020 01:51:33 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id q8sm2740501wmg.22.2020.04.16.01.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:51:32 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:52:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v12 2/6] mfd: mt6397: Trim probe function to support
 different chips more cleanly
Message-ID: <20200416085233.GY2167633@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1586333531-21641-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586333531-21641-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Apr 2020, Hsin-Hsiung Wang wrote:

> Add new struct members for mfd-cells and irq initial function, so we can
> call devm_mfd_add_devices() only once.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
