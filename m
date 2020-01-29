Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76615C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D242070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sw3HgBhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgA2LSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:18:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2LSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:18:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so19721034wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 03:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WdEwvXuf/f1ew5arKRFGjQIWnawCPhuYtVKO7QPsc9Y=;
        b=Sw3HgBhFTNZBQ36hs9fAypBBY7Fa4Sh5OhqWXeKEPKx1kmSDHDG26lN9LA8NuPw2qF
         p1DHCrsJ8EOijNoxlSKupI7Zxp/jNH8T5E9VvGgDRaqOitPqAwUS74HmiAa2e9jQLPbv
         89Du9baS80tY7ud1v+dhJl/UHWfb1rsw6BinQLgP7jPdxm3FsWERhB7LLxEIdmcc48pv
         IvpJw07fjov6WMjVtkzx0qF2RvIxiyEMBsvtYuAZEu6G6dxXDSHBPJDgjeuZ9nxRC4Vq
         xKwuGm14d1NEDJdCQHvkh2GjoQQsU1G/gsuEuT6g11JkYEZpLnLFNMDd8mOBL+N7a+4f
         yEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WdEwvXuf/f1ew5arKRFGjQIWnawCPhuYtVKO7QPsc9Y=;
        b=Z9xiSN5mBh0WcXlByHOK3poDmhqtbibQPpqhNVwtQUssVaSdR8cdSnnBUcvku/Br9x
         AMDyb1LdA2HW1B0pTs31IopiWq8kvxSzyf3mDLaFiZw0xYmXMx+B2QIrdQLEMCv20cyi
         WBK3F2fXSCl/FLpiEgCZDJY0MRiZ/MhC/L0xuvvD0ubgsZMwZ4COCipImlLz60RHfxJr
         Mv8n6zVhEm+ZbfuUHfiyfIkbQvj7UNxs9Vd7eOPj7qpkx5ANmkUcCB/vNB9wIgS5YYNE
         Iq8qQ1W2YPTQshNKvkEeQ9R1xKekrXZiTNNANcNWod0mDaPIrQZKDsOMkyJVHsnvC6QF
         Di5Q==
X-Gm-Message-State: APjAAAUtgbaU5tlRUy1xaVFOrinDEGqrmN0AwAue2zgsZhXhObiXru7S
        J/d0APndIIvIQDX4ErMrPWOuCQ==
X-Google-Smtp-Source: APXvYqyMoIcsyaEqYxxW6ffIc7cM/EHFn0b6ThBfRh9LHZ4nCf4C8TEqE1Hf1HzIgoqg9YnSyuDr8A==
X-Received: by 2002:adf:a109:: with SMTP id o9mr35424484wro.189.1580296726681;
        Wed, 29 Jan 2020 03:18:46 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id b17sm2448180wrx.15.2020.01.29.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:18:45 -0800 (PST)
Date:   Wed, 29 Jan 2020 11:18:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 02/11] mfd: wcd934x: add support to wcd9340/wcd9341
 codec
Message-ID: <20200129111858.GC3548@dell>
References: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
 <20191219103153.14875-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191219103153.14875-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019, Srinivas Kandagatla wrote:

> Qualcomm WCD9340/WCD9341 Codec is a standalone Hi-Fi audio codec IC.
> 
> This codec has integrated SoundWire controller, pin controller and
> interrupt controller.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig                   |  12 +
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/wcd934x.c                 | 306 +++++++++++++++
>  include/linux/mfd/wcd934x/registers.h | 531 ++++++++++++++++++++++++++
>  include/linux/mfd/wcd934x/wcd934x.h   |  31 ++
>  5 files changed, 881 insertions(+)
>  create mode 100644 drivers/mfd/wcd934x.c
>  create mode 100644 include/linux/mfd/wcd934x/registers.h
>  create mode 100644 include/linux/mfd/wcd934x/wcd934x.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
