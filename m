Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FAC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CC020781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4aVyCzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMIBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:01:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA33C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:01:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so4381054wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BrEukXzMOpIr1yUBLPDImeJK4OiXs06yEEaIuSegLSo=;
        b=s4aVyCzfBYOZ9LAlRHPChpmfGo/EHoj8aY/XNJLRF6RIoELYZ2aguv0L4s/jAdO8Xl
         tw4LypKX/MtFS6esS+D/BU4DMgck4FsMma6N1HA6ZAiek9m9qxBqI76494nFe/oVVLS1
         u8FUiHHksaZLEVbhci3GULIlvwRKgviU5EA5+27Gi2ZozE8Vww2rMi2Yx3/Si1E09wK0
         3ly5rbyNQYGtFEHJ+IcM75HLLSOqheB4k5WacOz1csiJkAKVhRhD7XJSKzuiLw2PVG+m
         zcRwcLXKTDItDU6ASeExsoIdt+URWp+DivmKAz3X9hbAipLjDEzmgG58vnbcDzE+dOqQ
         tA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BrEukXzMOpIr1yUBLPDImeJK4OiXs06yEEaIuSegLSo=;
        b=tqw2WH8inzpg87N2fN5gMuSBatLyFD+m3fNTA0h6zk/KgDFzMd7b2T0Pc2tq579Yww
         lRWVIa61k+VQqGL6pJJ2CJuzLt7gu9Qx0nH8bRVwL7gKdCM+Qq9vd83uNMnZKZACGu/d
         8K1dOaT9FOrk1V8hHMCZZSfzlXsETE52xNcgEQvrsyAIkYyfVZq6Xro+3wZJyCduSoqS
         HYvKEVD3/rmN9+b6tnDua71pjOiVS104hGLbD/KYJXmzdjChw8rreLRTuKxcFviUYZfb
         poAeh9UmEWhAmCXYhULpw/2qCrhTvyRjVPWyLkGHLwayZZx/kQuGyfbSvYSFWVMMMY13
         Y+ow==
X-Gm-Message-State: AOAM532TKFMk8w7P1lCjOA0vOrS56nB/uZYSuFqeQcCmMylIQ8f2XI6l
        EpSg4UDTw9B1bCp1q9GgZABX4g==
X-Google-Smtp-Source: ABdhPJyIGqBzNsCdlYHZ0GWsNu3ze9OnsM6Dlj5GmHr4gY/tvZbdmb1zq1hUdA4DhQ0iULdnaVz5eQ==
X-Received: by 2002:adf:ab55:: with SMTP id r21mr2670193wrc.332.1597305666249;
        Thu, 13 Aug 2020 01:01:06 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id q19sm8385438wrf.48.2020.08.13.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 01:01:05 -0700 (PDT)
Date:   Thu, 13 Aug 2020 09:01:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/1] mfd: core: Fix memory leak of 'cell'
Message-ID: <20200813080100.GI4354@dell>
References: <20200716142851.1669946-1-lee.jones@linaro.org>
 <072c29cf-b842-28b7-6abb-99ff8f2f5d57@samsung.com>
 <CGME20200813072409eucas1p1dd94af95802a53a5b5f2991cd535d843@eucas1p1.samsung.com>
 <79bcd1b5-2247-5e00-7d49-2f94f9b40744@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79bcd1b5-2247-5e00-7d49-2f94f9b40744@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020, Marek Szyprowski wrote:

> Hi All,
> 
> On 05.08.2020 16:26, Marek Szyprowski wrote:
> > On 16.07.2020 16:28, Lee Jones wrote:
> >> When creating a platform device from an MFD cell description, we
> >> allocate some memory and make a copy which is then stored inside the
> >> platform_device's structure.  However, care is not currently taken to
> >> free the allocated memory when the platform device is torn down.
> >>
> >> This patch takes care of the leak.
> >>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > This patch landed recently in linux-next as commit 126f33704d9d ("mfd: 
> > core: Fix memory leak of 'cell'"). Sadly it causes a regression on 
> > Samsung Exynos4412-based Trats2 board:
> > ...
> > Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >
> > I suspect that this is somehow related to the deferred probe and/or 
> > devm_ helpers, but I didn't analyze it further yet. Reverting it on 
> > top of current linux-next (and resolving conflict) fixes the boot. 
> > Bisecting it was really hard because the issue is not fully 
> > reproducible, what suggests memory trashing. Various tests of 
> > linux-next with the reverted patch have shown at least that the issue 
> > is gone.
> >
> > I've compiled the kernel from exynos_defconfig, the dts used for the 
> > test is arch/arm/boot/dts/exynos4412-trats2.dts
> 
> Finally I've found some time to analyze this issue.
> 
> Indeed this patch is wrong it causes double free on the mfd_cell. 
> mfd_cell is already properly freed by the platform_device_release() 
> function when kref of the pdev goes down to zero: 
> https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L426

Thank you for the explanation.

> I will send a revert with the explaination.

No need.  I remove it from my tree.  Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
