Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1EC2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgEVWES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:04:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:32896 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731156AbgEVWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:04:17 -0400
Received: by mail-il1-f193.google.com with SMTP id y17so10041686ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=973NC73pjk2NBifwj8WHpMk/zDWJCDkNGu1zxBkh+HU=;
        b=pnG398FlhLshHiw329/3Y9eCcycpwia6MAXkwdqqLHXvKTow2CEiwyHiEgD6KkZ5/c
         ybppnI4tXHxe3FYkRKjibbNfFfMnxOr9rjyqF50smpWIfxuLFRjeqJIaZSZuKdK9Fmdv
         +5beBjo4/zPX2pGNalul6w3T769mmm39sX5dl3h//VeIlhrGMQk7eVaOul6CQuDR7MhW
         gHH1MywjKxYRc80+V4IeTLZOKbQBqGlzVo4GfMCwdjuaiHr3Anm76r0lXT9YDrBspI1x
         WvI9P702rY4kCDRTJHdmCZ6F6azJQoPVImBj6sUS8jXPgmuV61oNlUF/WtVX/bJADsW+
         YNPg==
X-Gm-Message-State: AOAM532lnkdmbouMdWCMYBgk+oH450VDjWvgVVzcai2eSgcQIf4y/m0+
        Z3cP2r+ZTA7hwGiP6FGgb39D4enzrVw=
X-Google-Smtp-Source: ABdhPJyYMul10MLN8/0RuNemnHlg/7RGIY8JawSioG0PC/DiuKgLRb8q7iIa6Xh80EGbiwbqCzzJ3g==
X-Received: by 2002:a92:5a5d:: with SMTP id o90mr15265718ilb.206.1590185056059;
        Fri, 22 May 2020 15:04:16 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id v14sm5090279ilm.66.2020.05.22.15.04.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:04:15 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id c20so12264214ilk.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:04:14 -0700 (PDT)
X-Received: by 2002:a92:c401:: with SMTP id e1mr15993370ilp.134.1590185054260;
 Fri, 22 May 2020 15:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200427134003.45188-1-max.krummenacher@toradex.com> <20200427134003.45188-5-max.krummenacher@toradex.com>
In-Reply-To: <20200427134003.45188-5-max.krummenacher@toradex.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 17:03:50 -0500
X-Gmail-Original-Message-ID: <CADRPPNT8FQJ4vZUkk-t=o2GnNB=JSxkadjxiH0LZcQhC1e8VMg@mail.gmail.com>
Message-ID: <CADRPPNT8FQJ4vZUkk-t=o2GnNB=JSxkadjxiH0LZcQhC1e8VMg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] arm64: defconfig: add MEDIA_PLATFORM_SUPPORT
To:     Max Krummenacher <max.oss.09@gmail.com>
List-Id: <soc.lore.kernel.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 8:43 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> Commit 06b93644f4d1 ("media: Kconfig: add an option to filter in/out
> platform drivers") adds a new Kconfig symbol which now hides drivers
> currently enabled in the arm64 defconfig. Enable it to get those
> drivers back.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

This is pretty important otherwise some of the drivers enabled in
defconfig will no longer build.

>
>
> ---
>
> Changes in v3:
> - new patch: added 'arm64: defconfig: add MEDIA_PLATFORM_SUPPORT' now
>   needed for some enabled drivers or these drivers will silently not
>   be built.
>
> Changes in v2: None
>
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b8259814065dc..472aa82b9feee 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -569,6 +569,7 @@ CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
>  CONFIG_MEDIA_SDR_SUPPORT=y
>  CONFIG_MEDIA_CONTROLLER=y
>  CONFIG_VIDEO_V4L2_SUBDEV_API=y
> +CONFIG_MEDIA_PLATFORM_SUPPORT=y
>  # CONFIG_DVB_NET is not set
>  CONFIG_MEDIA_USB_SUPPORT=y
>  CONFIG_USB_VIDEO_CLASS=m
> --
> 2.20.1
>
