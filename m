Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF007C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BEC207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upXzz8qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgATItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:49:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50383 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:49:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so13557685wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xjO9Eev+SU5Q9NPoX47dhlIyYm65ZrIzTpmYSXcC0fU=;
        b=upXzz8qeD/5BtJaGzLdwuEqBKz7Y4Y95ZLbt4pmDEhvAN4VLtUl9KSf6TyxkeN3fRV
         ypojrslYQxBfDcwhLSlJacyHxEoW2v4EonxT6YAt3v0FxmiPF3Jfw2Ea0CmO7UBuvz3g
         3BTGbfIPuoZm8iMuLLZYRaz8MBTSE3Y9n4BAQyD0wDRaZsqp0NWfFbmDEjnJSpuwwtoZ
         mNFH+UXTtF87MPsVXVYMzLE3nNICfSpl+n02Lwan1WcjSHYk0ap8iJVjFyPBKSCzbMdD
         IFLWzOXNf8nRRJT/Vx7a7OgqrXnMoHUmaOC78NMfJzWFdDNC5cEI6Oz0jLu3cdxL9YDd
         hebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xjO9Eev+SU5Q9NPoX47dhlIyYm65ZrIzTpmYSXcC0fU=;
        b=EDan3djlQbVg1bov+4PgESnDLdQ7GlgBxgR3fqLVIb7vF20PHzjF5UyI38phWX0h62
         04nk/LOBwKPSNmokFP2vfIdNrpjf2aD84AK7Tb56C+MspKjNzhtbmWklVvxrkfY+pe5o
         cDE0XTdIY8c16SCaIRB8R5SLTGzGyTOEy4IWNGKu/MXwmQylm6n7W4PS0BxQjruF2RSc
         YAfn2NcuUrRHoJhICQGkMqOWerClAT3MccOIOgkhkEy/LqCrEqKuSpc61pHIo4Sor6Hw
         OulncgQ6hZT8nJQUGOMgmIc0+dkcFUzq6TosD2tT3Gd42ID1uNCaqu7+SHDcUuLRW3qJ
         AjXQ==
X-Gm-Message-State: APjAAAWbgw6SdJHd/Seq3IPHQXEglx0cswGro5x0sjnA51QBw5SdfDxF
        NW6LA/9smRfTPH49W0BP59mkyg==
X-Google-Smtp-Source: APXvYqx0cpFv+M2+CJytRSA34riJUQ4p8jfdKQZ24wK7qihHsiYbl5xYfHDu7dN4FSwJ3ErNm2cVKQ==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr17160695wmm.157.1579510158564;
        Mon, 20 Jan 2020 00:49:18 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id 60sm47747417wrn.86.2020.01.20.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:49:18 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:49:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/5] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200120084934.GZ15507@dell>
References: <20200117215926.15194-1-andreas@kemnade.info>
 <20200117215926.15194-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117215926.15194-3-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Andreas Kemnade wrote:

> This adds a subdevice for the ADC in the RC5T619.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
