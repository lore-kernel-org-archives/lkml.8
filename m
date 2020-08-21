Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ADBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F159207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsAQRhu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgHUNEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgHUNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:04:05 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4146C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:04:04 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j7so387556vkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Of8B1JdNddjVmiolpjV5fIdtTFXK4mNZ1WJPME585rI=;
        b=MsAQRhu3Yz/2CxCDMuK8lKA+6IRovanKanJ+xkv2q+6NkbAawmZpclkCicAmFD/GCn
         LptyFlY1QNEZQQsXN+H9dDLRT4LBFDnWDJrOnwxLywkRMDS+y19GE8mt8p6MDEyHomi3
         PFnKlUCyzg0eXSq7GzvqfoZXMFdHwEaMcn6/BoqVc/tZEQWIZMIrQZYAZpNpAoNWL5aY
         uEMNLITtGGWZqH/4462D4EtFgtvMyRCanOIp3j+6P1azskPtkwwEgAeEiYnQyRUjuOro
         zJOhRTVrnIiLVm7oWrK0GeYEDIzSDLV5oSxTEb1GfnRw/o4yqzjwpZJ2MntLh2eC175o
         4rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Of8B1JdNddjVmiolpjV5fIdtTFXK4mNZ1WJPME585rI=;
        b=Djl3oncNBSXDvtLjZ0vkYp3fHyRouw/mzgMCjTJvznwe/RrFgMq81ywcgpVRzgVRC3
         tuj0VHynTbCqmdHP5dIGo5nEWI0g+YLCRD+B6ShVR4rDWuetiiULBKDu3pgBZ+sZNvAm
         TdOuO9TlBOwOLklQLEpEUmf0feS0oALRqISzIb1EAuGZKzrIeUYoMc9jB10AJSNQXBCz
         aas0yjSuxbFrw7Rb65qC10YkfRMhn0Z7gIcUnYVN8TzBXLtaXxjmFMI1xvygcWhdwNll
         x0l7ZUOuK8uuvQ3BZywPLoIX0V/ARHDwLHqbsIV0JK/GrcQtt2YST1ZS4tqGFhE2P472
         BNJQ==
X-Gm-Message-State: AOAM530JTst0jxRZSFdMf2EXCRkDl5orcKgOSDdgq4mDZSefDKEnzZ7O
        6dJ7z29DaC1CmZo/YmbHV/8AkV9WJGWHeTuNhEAk3BBxEfa5zA==
X-Google-Smtp-Source: ABdhPJxexRNpnHIAvgnOO637NaC3Fo+35Ifzsik1b/A6iDZxGrmVTZ55K47fA64XUTB0JSJ5J9MQb/JS1o/wJWEBAJI=
X-Received: by 2002:ac5:ccdb:: with SMTP id j27mr1509317vkn.43.1598015043981;
 Fri, 21 Aug 2020 06:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <1596887102-9743-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1596887102-9743-1-git-send-email-guoren@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:27 +0200
Message-ID: <CAPDyKFoAonef5daQy0rZFdQeUhKwryYDM0k-aiWXKZG8XBxQxw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Kconfig: Add RISCV and CSKY for MMC_DW
To:     guoren@kernel.org
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Aug 2020 at 13:45, <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Synopsys DesignWare MMC controller could be used in RISC-V and
> C-SKY architectures.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 3b706af..119adab 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -777,7 +777,7 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +       depends on ARC || ARM || ARM64 || MIPS || RISCV || CSKY || COMPILE_TEST
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
>           block, this provides host support for SD and MMC interfaces, in both
> --
> 2.7.4
>
