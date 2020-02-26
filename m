Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E123C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CB22467A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsZBCXxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBZJpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:45:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33260 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgBZJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:45:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so2148058wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I2/gSehHpEGG5HyU6rvOAvWs+qM+dEuOlb2iDZhfsCc=;
        b=KsZBCXxQjP3PjDVkFMuNh4vuyBkqTdn2NRl2ChAUbpCbd+a0yef4bxD/D2MdFHPLtJ
         zRy6X3QItPqoaeaCLyD7hxPrLrxPC7WrIoGdec2Rh1VSlMStZO6y1uusJs78cIsGytZ1
         /R8mDcOOm/eo6ElG9W8aeYpM3yzruPr2oU7TfxQhRlklLSsapdrz3gvUqkT5aoTJZJuH
         kuVboEAZQmyouatkkW2PIPbVmiVp9mGKYsg81QYYF7m7LOxptVjRaE8BKe5JK5WwTbZ1
         iuKEQWHoSIY7DEKJI4DjPXvWcl5zqjnpHeyu0LjsWAKwpX7IGp6Df7aPtbmQq55K3zaa
         8nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I2/gSehHpEGG5HyU6rvOAvWs+qM+dEuOlb2iDZhfsCc=;
        b=KNFRxykEyfetWtj+e7mAi/Vxl+WrYHx5Ks95QovJiUxOUHD/JtTwV8Obpb7LCnU86I
         +SXdIdHJHJsADq2ULGDy1xzGhNrftHCTmC/LbgzrV7bDD3zSKKs/ml2sDNhVilRhj+mr
         9A4PCkYRGK9L4/qvlnvaVMMt86Nz+y6M2s99BLcd0/oQzl8Qr6ZGrUopte3bL7WGTNUI
         to2fT1m8r4qEJ4ss2mRJjqGMx8hcWx8XB7mueW5H2V4OuDd7wPWf++QVQHWbM5/SiPKA
         t6E5rIXwol6VSeX2yIsbj5ugbJYdOHKn55Czrs4sGyG1anIv2FzxLzv5hagKw7b8UB0y
         albA==
X-Gm-Message-State: APjAAAVAUm+xmwgiSrnMoqzwwNaLg8qlnBXXNdzKhMtttJYqsKWjEZ++
        cVAOlgY3JtaYBrU6YMuAmCoMug==
X-Google-Smtp-Source: APXvYqyqn5Frqh1yyiqsq68fUiGQJz3ZgSLhazc2xAd38ClGvkekkMLptXz0iZrG0SpTCGNhX32h1g==
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr4522993wro.80.1582710312601;
        Wed, 26 Feb 2020 01:45:12 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id d13sm2564418wrc.64.2020.02.26.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 01:45:11 -0800 (PST)
Date:   Wed, 26 Feb 2020 09:45:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: Re: [PATCH v2 3/5] mfd: rk808: Stop using syscore ops
Message-ID: <20200226094543.GD3494@dell>
References: <cover.1578789410.git.robin.murphy@arm.com>
 <7fdcdb900c7dc4fba38266e1db637131c3090a67.1578789410.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fdcdb900c7dc4fba38266e1db637131c3090a67.1578789410.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Robin Murphy wrote:

> Setting the SLEEP pin to its shutdown function for appropriate PMICs
> doesn't need to happen in single-CPU context, so there's really no point
> involving the syscore machinery. Hook it up to the standard driver model
> shutdown method instead. This also obviates the issue that the syscore
> ops weren't being unregistered on probe failure or module removal.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/mfd/rk808.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Going to ignore the unrelated change in this one!

(reviewing the remainder before responding)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
