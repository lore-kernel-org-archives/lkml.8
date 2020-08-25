Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C64220706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9RY+o6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgHYIcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgHYIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:32:10 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0410C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:32:08 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x64so5007916lff.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8VBcmM6sRKWlq0/anJb0wKs91ISNtH5ktL2MLmE99og=;
        b=X9RY+o6sC9Ppm0S92JcWuGapwVP6vGdg7BjmyO+bVW0rj1WTbhhQsV4pHkqkwAjjaN
         8H/JJC5//XVna28iO68xRVOv9wU5x6YXvvotlGw4lLejKAMz/7Q00mTo0f967W4aMtUw
         fPiG3HQHt/fd2KN89nN8sEf0oVh56pcOds4wS0HQdO+5Lb+PNySRcvEGwgy4lHZefIy5
         rpPA57c8RiRxZCxSfGlU1duSCLz3LMQ8/pSg+8uvHvNSWoz0nBeDuyncKVeR1U7EwtMq
         czWKRkH2JC3rN+Vs1JuY98vwSztqYkw2+2QSwv4wCzy/Zrvk0+76s1xbiZ0f2HRzJS2N
         lsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VBcmM6sRKWlq0/anJb0wKs91ISNtH5ktL2MLmE99og=;
        b=Y//GTeNLTRpAPYetutPiqMC/JavDP5vSWmdN7u3GfnLybNG1B4m8YE/0EcXPloRdNH
         5r5qWoi/yRil543NUiu9/de2cEZq6siPOx0QUnRH06SjHi86KGRZ6qrzxQ/6fzyIfDW2
         Kamm5FcBiP5b16cBawmCeJzIzJluyugZ28nvimYleS2II7T10JvA/OM2pJGbJvRXdSPm
         MfITl1WmdYj57UnKwI7thTwfsJvhPS+ULlLGkw7F/RVLtuwyizxREgjIafUURACszwcB
         +jEuqlYgblpTHf9YfEt0m5KNrcrxgWxOZdUEZnqZzOgf4g7/7hZIWSFyZG4eif1R0/Py
         X9UQ==
X-Gm-Message-State: AOAM5301h1ieeQs2JCoqKwZNhA4vw9u4U7Q/p8k7oyDsW4vKbpuUn940
        dJq2WiFev3RvTZGbWfr+5FwtnQ==
X-Google-Smtp-Source: ABdhPJyvP5CCC/9K1+399P66A5Xf4E5azNewtsF/LKST22V5Yw1PmUGF53lGY/lu2kWSsQNejxGZUA==
X-Received: by 2002:ac2:4570:: with SMTP id k16mr4396381lfm.60.1598344327410;
        Tue, 25 Aug 2020 01:32:07 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id f14sm2666979ljp.138.2020.08.25.01.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 01:32:06 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:32:04 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     John Hubbard <jhubbard@nvidia.com>
List-Id: <soc.lore.kernel.org>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, soc@kernel.org,
        tee-dev@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3] tee: convert convert get_user_pages() -->
 pin_user_pages()
Message-ID: <20200825083204.GA2068961@jade>
References: <CAHUa44FrxidzSUOM_JchOTa5pF6P+j8uZJA5DpKfGLWaS6tCcw@mail.gmail.com>
 <20200824211125.1867329-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824211125.1867329-1-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:11:25PM -0700, John Hubbard wrote:
> This code was using get_user_pages*(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages*() + put_page() calls to
> pin_user_pages*() + unpin_user_pages() calls.
> 
> Factor out a new, small release_registered_pages() function, in
> order to consolidate the logic for discerning between
> TEE_SHM_USER_MAPPED and TEE_SHM_KERNEL_MAPPED pages. This also
> absorbs the kfree() call that is also required there.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
> 
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: tee-dev@lists.linaro.org
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> OK, one more try, this time actually handling the _USER_MAPPED vs.
> _KERNEL_MAPPED pages!
> 
> thanks,
> John Hubbard
> NVIDIA

Looks good and it works too! :-) I've tested it on my Hikey board with
the OP-TEE test suite.
I'm picking this up.

Thanks,
Jens
