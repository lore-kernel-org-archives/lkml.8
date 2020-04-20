Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2EAC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199E3206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9N4Prb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgDTNvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgDTNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:51:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC8C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:51:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so12213664wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xL0eDIXpQBxMEh1rpP/FONQ6psNDwPofEEjDAjgV9+E=;
        b=g9N4Prb+W/MZeBAamiu3mzs0P1/HfnhajHbNf6Z+BFG6AESZOAaf9tIdcTxFockEwT
         EKWaFlouUpD/6fVZbNK0UTx2Jequz1Oq9PHEye186schaM/btM9eBXfEyafUFocZ4uoG
         9pltSmbf6ROp/xZA9nnA49VLvIueiVYem97NDOVi92BD00TMnnEYBZ1zmUTNSjkm0Z31
         VdcX8+PNRUSm0vWV05sEJ5T8GMqxfwe1n/O6bOaDggc/c8v7DZG/1gRKS6fRBhbxQKe3
         Jw1jtrmpyMbhSiH1+qiF5nHqdAbioZLiViL9DeqUIgcbbxhwd3dFKn8Nl13HJkeUL/8l
         VmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xL0eDIXpQBxMEh1rpP/FONQ6psNDwPofEEjDAjgV9+E=;
        b=dKou/T3zG1Mt/eTqWNG1AH+Pi+N+YpI53PaIbHM9nGMaq7YMOomx0s6N5N/erYaMer
         L5vKUlureZQ5DxuY0uq2G/qxajI1xCytgyXpa8isTon6LsxOmr6Yc5qinfDqRB9qhSpU
         rGo40W1gHbUQsWtJyGB7wSoc173FvM0tDQGeRr+zA+INmUblz3zlxcPFTnVVmRegBj1V
         ZElvUIR49OjzVpyPCl/SinIjvoCCl1odEPIh9FwV908KihUrvQpU+XqnYZ4FN38YlGk7
         EShpQpFs5i4WhH9OF+lhu+CLD110jJDbZEZGyfISr37fpK3WT+qzhaEZVVDoxygBtBJi
         WinQ==
X-Gm-Message-State: AGi0PubvqMQk0wi8pKu8dNtaFXNZssVU7o/7bd3K/93R6nj0DadLX0Jm
        kCsDyY4G2sF8SZtB1RLbnt4ilw==
X-Google-Smtp-Source: APiQypIkD9tDuLBwdY9svyS889RVUDhlwihT/636a3FV3sGGLOwXPv1ushYYNwKn2DXvjpEovZY5Zg==
X-Received: by 2002:adf:decb:: with SMTP id i11mr18098981wrn.140.1587390663057;
        Mon, 20 Apr 2020 06:51:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b85sm1502032wmb.21.2020.04.20.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:51:02 -0700 (PDT)
Date:   Mon, 20 Apr 2020 14:51:00 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] backlight: lms501kf03: remove unused 'seq_sleep_in' and
 'seq_up_dn'
Message-ID: <20200420135100.lhwcdkl33jzomy6p@holly.lan>
References: <20200417092257.13694-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417092257.13694-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:22:57PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/video/backlight/lms501kf03.c:96:28: warning: ‘seq_sleep_in’
> defined but not used [-Wunused-const-variable=]
>  static const unsigned char seq_sleep_in[] = {
>                             ^~~~~~~~~~~~
> drivers/video/backlight/lms501kf03.c:92:28: warning: ‘seq_up_dn’ defined
> but not used [-Wunused-const-variable=]
>  static const unsigned char seq_up_dn[] = {
>                             ^~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lms501kf03.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
> index 8ae32e3573c1..c1bd02bb8b2e 100644
> --- a/drivers/video/backlight/lms501kf03.c
> +++ b/drivers/video/backlight/lms501kf03.c
> @@ -89,14 +89,6 @@ static const unsigned char seq_rgb_gamma[] = {
>  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>  };
>  
> -static const unsigned char seq_up_dn[] = {
> -	0x36, 0x10,
> -};
> -
> -static const unsigned char seq_sleep_in[] = {
> -	0x10,
> -};
> -
>  static const unsigned char seq_sleep_out[] = {
>  	0x11,
>  };
> -- 
> 2.21.1
> 
