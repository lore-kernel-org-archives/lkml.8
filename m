Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D86EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30C122522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vu72ipY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAUIiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:38:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43524 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:38:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so2109806wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jk5Wx13aALIRFc9OEyWr5O2M9z/s/X8a3dyscVUUbeM=;
        b=Vu72ipY46bRKQQcMO0zOsxUNH1XRZcBQX9175sZt0Z4vkWD93rkpHHRMg4bSceUiHD
         NnwG3kiEKtI7pvIXFGVoJ3aTsXCFLMmSxBxzL51EGbkSBQoCOvVTp1T+qMuPCJUJS7R3
         5VkgPuErnwfzuIzckGG3n3ks+OxbFz4rfuURVjQN2qn3IXAE8umVqYE0c0YhVxys0WmO
         cxelVH0LHVLQVmIJhdNpDvltOD8R02JCq6KXuKOeq7kocD1yc3EZXa9fuX665zzSajZA
         zzd3OUOcOWi9OXIa/4YBLgr8GBRlksdRq0mk0vEswoPJttwcG3u89QQVJma65/taCebk
         6srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jk5Wx13aALIRFc9OEyWr5O2M9z/s/X8a3dyscVUUbeM=;
        b=KI3b4JruWnhSf8Fe8JF02PO4dWImnFzp2SooH0bodKa8IXNeOO4gs+9lo7caoNwX58
         7xg3mJxPhipotelNqZ0SLWkuD30K1je1htEqvynBBaBE9CmdvxTdaWVZrl1kVqQjEgru
         OTYDlMHuY+E6DWPOyebmSetsnMJz/ra5LGqYnoijPJMnGkPlLPL6Q+ALn4zwYpf8yZZO
         oOXjrPmQCK61Ti+7v6P8E6FoGXsjaLFuYAJ1AxOegLsVyWcyoWEB9KJca0X3OO424Rk6
         HEpSqQGK/2ztF1sF1cLHN02gTNovRki2mDSlzaUaQAHuldv/ovESOsBwSADGaC7Wy6/n
         Bbuw==
X-Gm-Message-State: APjAAAXrUkexzv3SxqWT2JXM4AR77MIJWj5bzXbyr6eB9mwcN0xSGYTU
        fUS7S1fIiljhMOZTve15H83dNQ==
X-Google-Smtp-Source: APXvYqylzQd5oj+pBr35FBanKNF1RamtKyP9ljtz3C1yzs18rVM3Lpgdo/Vl7TdSYosdK7z4T0FnKA==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr3920795wru.122.1579595890851;
        Tue, 21 Jan 2020 00:38:10 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id b17sm50814845wrp.49.2020.01.21.00.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 00:38:10 -0800 (PST)
Date:   Tue, 21 Jan 2020 08:38:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Orson Zhai <orson.unisoc@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        baolin.wang@unisoc.com, chunyan.zhang@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: Re: [PATCH V5] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20200121083825.GI15507@dell>
References: <1579590578-8709-1-git-send-email-orson.unisoc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579590578-8709-1-git-send-email-orson.unisoc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020, Orson Zhai wrote:

> From: Orson Zhai <orson.zhai@unisoc.com>
> 
> There are a lot of similar global registers being used across multiple SoCs
> from Unisoc. But most of these registers are assigned with different offset
> for different SoCs. It is hard to handle all of them in an all-in-one
> kernel image.
> 
> Add a helper function to get regmap with arguments where we could put some
> extra information such as the offset value.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> Change V5:
> 	Removed unexpected preceding spaces replaced by email system.
> 	The patch has been tested for local mailing and applying.
> 
>  drivers/mfd/syscon.c       | 29 +++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h | 14 ++++++++++++++
>  2 files changed, 43 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
