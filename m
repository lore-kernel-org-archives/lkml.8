Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768AE20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njp2qXt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgGHNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgGHNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:06:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36632C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:06:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so3056314wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLDzCYJWqSNQ9M1Ha7TNoiTF86yo/dq5RVgwN+Hsw1U=;
        b=njp2qXt1BaQ9kGGg90luhkLagzFxxSHWZIvLMjW4ava2YlPKpTyY1GIKzjAH7bLwrS
         inHWc6CpR96XN/KM/jhpCmu0rpF5hbLSxq6FrbQCw8CSjwSUKgNw/feC5qcZDyfd6kdm
         fqSSom5qrymbjRD5NGi9tFXYrB0um5EGRsT7zjfn39+/2jyEmUdHDgiIOKUutaNemg3E
         qbkBmJquE063NY/LDkwIVbVwAS96Wuup42pGE5Y/2UWyC6zfXwBQ6x+GdBXbbsspgbBD
         3/0a5CUliPqvgIRb2V8+iVZj3YdbZrXEgme8zlejZWv+NQ9TSPXNC3LTdveW3kJXoBBB
         VEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLDzCYJWqSNQ9M1Ha7TNoiTF86yo/dq5RVgwN+Hsw1U=;
        b=UEjfjiI9r8/VSp7XTDMPk06HmUadvKNt34RKQsebWEXpLN/HYB8rXtsohXyLWWXpj5
         cZk6wkGLMzbeXAHFjoMeXOM/GUuVIW35J1lmHn59AYD881ssowNPdymDp3kpvdDYtIVK
         CVOksasiytlog8qLJ+hhw7l2I1ynZ7nnqYybMYHm4/6mWV194fbSwHWs77LRaJsTTNZ1
         hDrybAt3kX3dkpSxs3Kif6I9yS/SbO9n8t5JVz+h1c3pBi/zdm3tsfP7poy4ThlvM3jV
         CV9ZyLNhw0hPt7tbBnb/SuiDglNh3mig7Jl2xvSUGViQ8XBFRoQTRQZouIi50yCBqsQs
         RYZQ==
X-Gm-Message-State: AOAM532LLbsMJWAT7oDQVQ9fylI0AypxHGf1XjNEhm6H/nNYBU97IE4H
        COt59NdSp5VtQe0SUSx6QJLnwA==
X-Google-Smtp-Source: ABdhPJycffceCLL7aGQilAq3ooqxDBsNO0dVSgTCtQTuz32w5GffuQpcf1XdckbErcpZYECigf7F+A==
X-Received: by 2002:a1c:81d3:: with SMTP id c202mr9208740wmd.54.1594213596871;
        Wed, 08 Jul 2020 06:06:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z10sm6072444wrm.21.2020.07.08.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 06:06:36 -0700 (PDT)
Date:   Wed, 8 Jul 2020 14:06:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/1] video: backlight: sky81452-backlight: Fix some
 kerneldoc issues
Message-ID: <20200708130634.5tttrzlq2zfx7uho@holly.lan>
References: <20200708130419.3445042-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708130419.3445042-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:04:19PM +0100, Lee Jones wrote:
> Firstly, all lines must begin with a '*'.  Secondly, arg descriptions
> must be spelt correctly, so fix misspelling of 'gpioD_enable' and
> 'short_detecTion_threshold'
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/video/backlight/sky81452-backlight.c:46: warning: bad line:                 If it is not defined, default name is lcd-backlight.
>  drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'gpiod_enable' not described in 'sky81452_bl_platform_data'
>  drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'short_detection_threshold' not described in 'sky81452_bl_platform_data'
> 
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
