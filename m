Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD225C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43C720732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="weB3LAGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBXKsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:48:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35048 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:48:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so8842521wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DlS9HvBeJ40C/txSt07sCwih0YUG8h5KLHioIGiWog4=;
        b=weB3LAGarjV2WryBzxjWn93uxEzAa6HvBZ+ZsQexkSc2sZnWRUUthgdeTkLri+9MzM
         oZMMrELL7KqxQU9+KOidn+3/LdCnUl3+xL7SFrJN1C+rsX4h1tK13srwP+BtbYuC58ID
         jOpps72H1/OPwudWSxLhRDhzFdJi9bfmBLvvvJwCygP6DHtN6qmihvWHJJX//uD9QptP
         Q4a6NfCee2B+PcGRRFHu9oRAXqLDVF3a0mUcCEfISNh8x0nlR8pKVVKPax6NBT8aObWE
         hXmOTSSYJ4YCWZFQ/ta6uFjkhbygSy1IPMLWipCFgAmmcSC4w+Vl6p53tsYlt9VA6aX1
         NvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DlS9HvBeJ40C/txSt07sCwih0YUG8h5KLHioIGiWog4=;
        b=rf96ef78QYeA/pIONmP4kTq7WiXV5UXcGwcF1yhXloHquVqDVdhq9P/AlTJa4OsGEV
         57uTkm0v/9MfFUsac14J57FdFdcvijVlwuYD1UIO3x7sw0X9WFf5Ry4pSUwad4BUc0qe
         F8EVncuyRE8WWB2iR3PAIpM/Oldy58u/4Rt9vzf97HXHJmDZX0jvbhJdeZvvntVPKJK+
         br/I/hzrPw3qe53gpNO8b7WMzYxABHRHZG8uniV/gZSipNyWbFl8UJgxN2TpHjjPXVel
         tTybR6auFqb6W9ZRlWq51gSzAXVmJUEjVWbrlnQnOtXtaMSdZQi7pd0I6FmPqE1OAE+T
         nHPg==
X-Gm-Message-State: APjAAAXxgIbvdiJUtqz6IL6LOUyGwn1w4alsIOzbGIHkBk+FTD6GedAU
        pgXZ3UuanORy9kSmt/uiuMPTuL+u6jQ=
X-Google-Smtp-Source: APXvYqysLZLszWQRkkFDtdkz0vqL9kByB/8xkSBa91ZWllcVHRPpcTzSJsPfX0RQyNQTE4qG0xBX9g==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr22204894wma.171.1582541295301;
        Mon, 24 Feb 2020 02:48:15 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id i204sm17574955wma.44.2020.02.24.02.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:48:14 -0800 (PST)
Date:   Mon, 24 Feb 2020 10:48:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: omap-usb-tll: Replace zero-length array with
 flexible-array member
Message-ID: <20200224104845.GP3494@dell>
References: <20200212235642.GA19206@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235642.GA19206@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020, Gustavo A. R. Silva wrote:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mfd/omap-usb-tll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
