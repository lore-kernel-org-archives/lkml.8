Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535C1C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B18A206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZZ6QXaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGUNwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgGUNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:52:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54411C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:52:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so11011566wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a/xttlG5Xmu7Wk/M4tJwIHBfITlAjLmITWDdy7PgMM8=;
        b=yZZ6QXaSmRA7KyXsnWq2IouBLSRUuYnLNl6nG/ze/pUjh+PeiAbgftj93TcMZLGIb1
         XEbbqQ38j9OzsMbSOiDaoURO4nenUnOwAopy7wubW+1Bb9bnet96gvXNS++rJg4l/kVh
         pslstSlN8mQHKviN1lk+5RRGKIOQks34LCm8QkLWAsv6duX0hUaqsm+uxFKawnCXn+42
         WlSRI0FUu0TEbBmhbYTBg35MVInwjTL7GrCuJlqHsPxKZe0iS3/VViDta+jhjTtQVY67
         NIdv/HZU2H1Q+vuE9+jzghSlMEtDB7YEHDzuJiprBaaM8pwqdIZGQmuNt3arjdH/tUz2
         Jp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a/xttlG5Xmu7Wk/M4tJwIHBfITlAjLmITWDdy7PgMM8=;
        b=IRZbg+12jPbqpFNs5BNGHzNMQHasQjkkDqlBJK8tqf3Qh1imT7eUIJBMc0fDjD8bXg
         io0ufTp4F7qwdpPbu30HaDO3XhEuHyZ+p2GdA0WYD8KCdRo+ITTHGn8vnkxYOY6B2PBx
         BQUYEGV7L8xkBHvubbbFGp6thVZRLRYCtu+ngG4QyIdPmcKA1K/axDdeE4Ux98kXfvDp
         HPmuiFys/zGisuH+bAXLa30xXX4VZImJXK5WUyUSoW445GwTvc4+50fN+lKB0DEW/PvR
         5XlldtuXdGZaC5nJ5yj7+txu3cf9eilu7dWyIJEMdwJx/heYbRjEM2tYWfLrvvCNq3s4
         aCBw==
X-Gm-Message-State: AOAM533DJVEti6rcBdDAgaHnsvPyo8VRF+fEvOKNFAby0mAY/ycePOS2
        u5qoHI090PeNbRPPZcg5Oe9BQA==
X-Google-Smtp-Source: ABdhPJx8QQ+edlbQkzaooVBvyxptignCQ9uQq5RqF/oWQQwrUwcKLUiSRqozu4UcoqmhYtAp2bsirQ==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr2026322wru.364.1595339556090;
        Tue, 21 Jul 2020 06:52:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 65sm3567880wmd.20.2020.07.21.06.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 06:52:35 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:52:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/1] video: backlight: cr_bllcd: Remove unused variable
 'intensity'
Message-ID: <20200721135233.53gmti745t66la5i@holly.lan>
References: <20200721073919.925935-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721073919.925935-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 08:39:19AM +0100, Lee Jones wrote:
> Fixes the following kernel build warning:
> 
>  drivers/video/backlight/cr_bllcd.c: In function ‘cr_backlight_set_intensity’:
>  drivers/video/backlight/cr_bllcd.c:62:6: warning: unused variable ‘intensity’ [-Wunused-variable]
>  62 | int intensity = bd->props.brightness;
>  | ^~~~~~~~~
> 
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Fixes: 24d34617c24f ("backlight: cr_bllcd: Introduce gpio-backlight semantics")
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I doubt you are awaiting this for a one line fixup... but just in case:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
