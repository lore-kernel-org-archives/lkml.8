Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F951C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5008F20814
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUw+jloG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgEVIH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 04:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 04:07:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDAEC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 01:07:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so9240455wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zppcH1s4Oxd9ORuhue+rbyDT8Mi3Zp/h1C3Ys2rA0bk=;
        b=DUw+jloGGhc299DIfCy40tPz3gnwkcYQEQKxyHqY+7liR//WJ5twv8oOqLHVGGT/h2
         nhE3OWCX3YfCCQyfX5bqWQWJ459cXsPhhW6UgbmzIVpvf99rIZyH0Z5o58iCtIh7Zqe3
         QnpyISth4jD1kx67+Vf1mlwYdrkhFDW7RvhxZ0LD/t8MgQAq1sTHd/tbIc3STDAIoeVY
         4+K3ztvNxWxSqHPhk0RH1gitNa62JMMxGFfAqS1PJyksLtl6lq2uq8HYSFbs4DOtdxU3
         VzMLvTU1WuUEvmxtbhWVne0ESHlfo55Jdz8j44QsRAs08h4Upz/hHw1lNeX9PxZCF/ZM
         BdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zppcH1s4Oxd9ORuhue+rbyDT8Mi3Zp/h1C3Ys2rA0bk=;
        b=FlgDEjBLa6HSOV2KjKKuIGFtuM01a+usrMrdtFIzs/WcTd6xyaATNkR17GGRJSfr24
         CGvDBtSosCEjRHpK0b8ocGz6QtIFdTVEb6TTMkqm/jcEp1WOJGyNNPplKXfZwswk6+85
         NeY9UD4kWaebbcXaEz4ogvfO5cGDw0q6yakG/DIsJl4ch9seo+SY4igRu1BKsVtHIhhn
         Y1LEaJbyh2oopbunXxP5wHqBbBsN4lqnXU550sI0SS5d5VS+eRvAUtmvRJA5wCiyBtXy
         jG2uIud9gWJy3mXUnoGQRRZ7KeAPG7f1BsFxsfYNce4SmuASyvH0zxzJoKUrryX8FGfH
         eXbg==
X-Gm-Message-State: AOAM531HEjQ8/OG65rNviZ9T2bMgPKLaRZRi8Bqk5838yYLRY7ablt9s
        AF2phePZd4v4qgdis77E5/eFnQ==
X-Google-Smtp-Source: ABdhPJxTRIndbgM1G4xc0xtn0ArdBndodyCpPDChjjPUgMyAMk3EPgXZrXgG0o3HZf2ei4pqk1TCFw==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr2274668wrw.319.1590134842818;
        Fri, 22 May 2020 01:07:22 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id r11sm7336139wre.25.2020.05.22.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 01:07:22 -0700 (PDT)
Date:   Fri, 22 May 2020 09:07:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/4] mfd: wm8994: Fix unbalanced calls to
 regulator_bulk_disable()
Message-ID: <20200522080720.GS271301@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2@eucas1p2.samsung.com>
 <20200427074832.22134-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427074832.22134-3-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Marek Szyprowski wrote:

> When runtime PM is enabled, regulators are being controlled by the
> driver's suspend and resume callbacks. They are also unconditionally
> enabled at driver's probe(), and disabled in remove() functions. Add
> more calls to runtime PM framework to ensure that the device's runtime
> PM state matches the regulators state:
> 1. at the end of probe() function: set runtime PM state to active, so
> there will be no spurious call to resume();
> 2. in remove(), ensure that resume() is called before disabling runtime PM
> management and unconditionally disabling the regulators.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm8994-core.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
