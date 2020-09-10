Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B16AC2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4C220756
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IjxROTk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIJFrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgIJFqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:46:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4880C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:46:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o5so5201697wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jp2JllZ5gaf/wkDbAJ0Fr7A6PIndQVfBIPe4O0e7aWQ=;
        b=IjxROTk3yBSkUFi3Qm0cueZsu6bNbsw02v2rGAaZfItp6ro+Gr9Ax7eXULiCZGwIC9
         RdRHtp9sEwZPS/+GFvKwxv5wg1Qwab1jmPJtwv1wQmjjHRZWfEafx5T1NZ6Eqxq4M+GF
         VWJ45O2Nn+YMUvaIjeqB+Mi9SLXueqyPhziH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Jp2JllZ5gaf/wkDbAJ0Fr7A6PIndQVfBIPe4O0e7aWQ=;
        b=syvgPy4T20dLta5UYkgGnXQ/LCKfEAiFlP1Sgob/DnnwDlAx4ZT+qwUyjWtvY3+vHS
         Ef1NCARDWnaHpK3YM9odC4nq6nSkw59SxvgVAyAb8KMhm62PvsmDvxnSUzvnllV2YR2x
         xW7g4TFBt0AgRa9GtvK6A0K/6IeVhEKsEJ3z9d+rfy7RChSO6G/bFY8PzJjirTJnn1Wb
         IIlE/ahZMQkY2Hh8YdLgV4Zq7avAtwQRoUbr0WU08Xob40h1MiXl0JtFbNT6+ij9ANXh
         Q97tsQzCImiuf0Y8LehnYKO8XwPlTnuCIWNRBzmjtt2lpR9RRJx6r5yLDbkYuFtvLJuT
         5n1g==
X-Gm-Message-State: AOAM532BXZa14jmNVYpbH8VvcagbGzuwgACf9/ZVeoJne38vv14GtPxw
        rpY+Gx0oGo4NjyC0SD3ZbNIbsNc5/RqLUThb
X-Google-Smtp-Source: ABdhPJxWZBT5PzZVON187FsRsdEM7wN/MV5G/4fNZ4dEwEeOo5whxFhnyb5pPRwNvLZZgKmgCRfIJA==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr7860060wrq.204.1599716798216;
        Wed, 09 Sep 2020 22:46:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u66sm2697658wme.1.2020.09.09.22.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 22:46:37 -0700 (PDT)
Date:   Thu, 10 Sep 2020 07:46:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.co, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next] drm/bridge/tc358775: Remove unneeded semicolon
Message-ID: <20200910054631.GB438822@phenom.ffwll.local>
Mail-Followup-To: Zheng Bin <zhengbin13@huawei.com>, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.co,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20200909121900.103712-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909121900.103712-1-zhengbin13@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:19:00PM +0800, Zheng Bin wrote:
> Fixes coccicheck warning:
> 
> drivers/gpu/drm/bridge/tc358775.c:488:2-3: Unneeded semicolon
> 
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Queued for 5.10, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/bridge/tc358775.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> index d951cdc58297..2272adcc5b4a 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -485,7 +485,7 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
>  		val |= TC358775_LVCFG_PCLKDIV(DIVIDE_BY_6);
>  	} else {
>  		val |= TC358775_LVCFG_PCLKDIV(DIVIDE_BY_3);
> -	};
> +	}
>  	d2l_write(tc->i2c, LVCFG, val);
>  }
> 
> --
> 2.26.0.106.g9fadedd
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
