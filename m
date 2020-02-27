Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F10C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B479224670
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNkmnInj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgB0JeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:34:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37622 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgB0JeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:34:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id a141so2549713wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cVSbm0v6H60hDajlJIbDzNZ4N5tFNUVontiUGzZdxzk=;
        b=yNkmnInjN+ivgvYu6+GYR9gx629m6C4IQpvjoWXDM3/mgTRVaNDP2fcEF2iSrEWps0
         0rqOAVADzW9vnKKovviRXTia3uUvWi2exTP5dgKaiJwBnx/IROLjWsc7pzpyyIG9BXe9
         A5ty4ZINyZzbbGhn7FPge3b9uIKzRPmE33oZYHE8fXUevg6J/xj1KnNJgB7iou7P5tCb
         EqBoEYXL4hNWvdzx3DtrAhiy1IRuzfcJKflyg/YUvcHZwmmwb0C0+i2adaZR2usLswxu
         FvgeogFSi8NtkqL87YCkjt/clK/H29ryVEDWSmXQc0QVbnQv7jdPcbqe6f/43uPY144h
         YHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cVSbm0v6H60hDajlJIbDzNZ4N5tFNUVontiUGzZdxzk=;
        b=uTI1/phv67QBYUY0QCzAZp8aoUUNv80ZeeIFJR2cV+BajiQ6gCX0LOqUkLvhYkxo/l
         MkxSZGF5RWs3zU39sojSuMEFmTAnJqnCJ5S20ptwWRuyByaAS/D/7Ec/Kx//TC1rmIxo
         E+kYShK7Goyiu3d+coxsOOx9o3F6SjZLct0FEhR+FtZjr82IESY2O84yt4OHN7oN8JTI
         0Ohi4ugd5EzDXcYcVRDBi/QN0rxCLJGhiK5GDkkcU8uFPR9oprTYyjV1kxsfh05fcFoh
         5cHBFVw34P8xDB8KxIslTwlvpbFLnfHDEgWfdXqsPcPTbPI3ZsT09w+UngMLHIu+vb6z
         7ezA==
X-Gm-Message-State: APjAAAU6CIYI+N2CNaJ6Ks3GPheiN7OX5ezqLlIyiyRJaBhE508yqoJg
        VScgpdIikozhGQ3Gn0YsN6/VYw==
X-Google-Smtp-Source: APXvYqxwIoVlEwiRIAslZNsbrD6ocYIYiQ0+UtV2unVgLcGY6hWCeawdhVkBH19JG2zqZ7MJzJkdhw==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr4336548wmi.25.1582796054671;
        Thu, 27 Feb 2020 01:34:14 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id 16sm6822479wmi.0.2020.02.27.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:34:13 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:34:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     arnd@arndb.de, zhang.lyra@gmail.com, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: sc27xx: Add USB charger type detection
 support
Message-ID: <20200227093447.GT3494@dell>
References: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Baolin Wang wrote:

> The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> function, and related registers are located on the PMIC global registers
> region, thus we implement and export this function in the MFD driver for
> users to get the USB charger type.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 include/linux/mfd/sc27xx-pmic.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
