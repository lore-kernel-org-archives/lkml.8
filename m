Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8285BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D32075B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg0xmjE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgGFHNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgGFHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:13:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF35C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 00:13:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so15016785wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y6aItrK3ggYlleH0/viUOY6qolHTQy/1u/+BpOihMeo=;
        b=Hg0xmjE2A2QgB70rmuXJ5Pw8tCPqmCSk8JyeYpHNJadeb74FDA/UNMbzhfZk64RUnP
         Zr1rpnoAHP8vavTwaW59I5ARloISn3axV1g6YgmRwGj5OWiSj+WmXPOmPtEbzqknfQWU
         ZEub0cl9lD2LDwyIaNdZxbMfO0V7M5aBmDE7L9N2p3GkyLma3aAtEVmjt1kQl/1CfoLJ
         8G9W1b0Lti/IYKiuN1mAlMLdlrJFH51PHTACl4zbOUDV3kuYMT4KnNzeIJlnnTDm4kA2
         PyqBePTZPGxmSCPnXDR9CrS1Vy9NuS/x9NqZ8lMU11tTceRZNBArWLIisVl+XdKf+pmi
         BywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y6aItrK3ggYlleH0/viUOY6qolHTQy/1u/+BpOihMeo=;
        b=rVpps7kShoFZOUeUwQXSgseh/4GIUNUpF5QUWXSRH1JUC1Ynx4QXod65nFko7ewBCP
         mHM6k3dSoGOxs4Wnk1IL+X1PXS/DUn4XzihrZG8c07CyDyvCKBs/jmOin0WLRELKFt0O
         DsYyrgk1alelmW3bwwS11PcYJweCrkIde5xLKKVybjLTomdF9jAhrz4gcMxSl38IIBGn
         Zw4hFQ4N/nALpNQU74QPgXm9nVp9tXvFokXFlPduxzAQCv6gy8d70T3pgeG3FEjFzd0F
         19bwODrw8TEtxynL5yq+fIXAd14Gwraj1ItK6UUxsFh+EmUxKxM9LuSOjs8LBu4h1skA
         OsWw==
X-Gm-Message-State: AOAM532TiJUoEeuPt3hIrqnCqH9HfgYscI3I3iXrefMyb8MSUqaPEYQL
        TPqe5p9dCkPlxWqQbddqGXpbIA==
X-Google-Smtp-Source: ABdhPJxWsjw1xgjYJUFiPLMMd5RNjJNu0hJkWTnvqG5HIkpSNJgHQAoTPWkdT0q52MWphuM5cnUMdA==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr47190853wma.161.1594019623028;
        Mon, 06 Jul 2020 00:13:43 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id l3sm6561303wrx.22.2020.07.06.00.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:13:42 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:13:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Message-ID: <20200706071340.GC2821869@dell>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Lee Jones wrote:

> Attempting to clean-up W=1 kernel builds, which are currently
> overwhelmingly riddled with niggly little warnings.
> 
> Lee Jones (8):
>   backlight: lms501kf03: Remove unused const variables
>   backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
>   backlight: ili922x: Add missing kerneldoc descriptions for
>     CHECK_FREQ_REG() args
>   backlight: ili922x: Remove invalid use of kerneldoc syntax
>   backlight: ili922x: Add missing kerneldoc description for
>     ili922x_reg_dump()'s arg
>   backlight: backlight: Supply description for function args in existing
>     Kerneldocs
>   backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
>   backlight: qcom-wled: Remove unused configs for LED3 and LED4
> 
>  drivers/video/backlight/backlight.c  | 2 ++
>  drivers/video/backlight/ili922x.c    | 8 ++++++--
>  drivers/video/backlight/lcd.c        | 1 +
>  drivers/video/backlight/lm3630a_bl.c | 4 ++--
>  drivers/video/backlight/lms501kf03.c | 8 --------
>  drivers/video/backlight/qcom-wled.c  | 8 --------
>  6 files changed, 11 insertions(+), 20 deletions(-)

All applied to Backlight.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
