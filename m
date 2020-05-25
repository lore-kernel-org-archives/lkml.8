Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61134C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3419B20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnOIkPx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbgEYJRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgEYJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:17:36 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3917C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:17:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v16so19997385ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kO5vtDW6efTPWMJdT/IeulhOhr/Shn99sWBgLzctM/I=;
        b=WnOIkPx9Iho6akm/1otb3bzxcZJDFFWZUf0ZjYnagW3G3rEtAz/XI2cTG4Lmrs+lh/
         uBwn9VGTsCsRHjRxCmEv60TCrrlcOA5JJI3AxviDtqbJ3irKCEL0R27GEnM9uT5hV38f
         bPQ3nYPD42R4MAlowsgym120v3L/+zSTn1//Guj0XdlwR8QbIwlCJmsXHhkQh3Uh1OzL
         VFM4s9fjlUaOnjMt6dmVpCM0WDEvzScRcDxUFsq64+kCzT/z0p3pbp+kTWGfnh5Hzh2u
         i5YHaWguB7kt6FD5BQKe5mirOW+yxm8TZl3lHm3vNw3ouA1OOyDp8ZET5jiVHRtjO2oz
         luhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kO5vtDW6efTPWMJdT/IeulhOhr/Shn99sWBgLzctM/I=;
        b=ZDgOizAwpcqYb76VPxz0zVPLRrgpZ1N57Nz4FPg+8aCb1gLTm6/qJb6Jr7FH2TtsxI
         8vaarAyW6q5SpnDjJXdkpYvgvfG0lDNdy/AZ7EB9uf7//eYq1uVmdjsVLBgeTaGEDOwy
         9CTK9o/Gn5BEZcrgjP6k600Q0Cneau9DuQnrp+vKKDXi+qjygLMeIhAh1DQpEx/NuZoK
         l7tFPNlTaOb1A1G/5CWPuwwaJ6UjiYt0rvUkwcU9SP8lWl15f65G3iQyIA+YmH1SkILU
         b3cjkodLhwe/Y8SBSFOIe1IwOS3iyV1wTtRUUuaS+78WjbO3njlha4ER7ZxfedxHC3sW
         NaOg==
X-Gm-Message-State: AOAM531Ve2d3zfAEnnZefcY+BILZ6VIK9OD/GPXHatQZAmuukMxuLbX/
        Yasv9PVP0axTKffYHDfA2OEEecvocU5RF27jcp+5mg==
X-Google-Smtp-Source: ABdhPJwFBs5dI5yirBLSFwiXWY52PiIXgZlGCLWwULeUThanyG8/0gUHFgUFcCvEjDwM9cabi1NMWxCRZgAoHBkp9KM=
X-Received: by 2002:a05:651c:32d:: with SMTP id b13mr2970920ljp.283.1590398254315;
 Mon, 25 May 2020 02:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200520032150.165388-1-weiyongjun1@huawei.com>
In-Reply-To: <20200520032150.165388-1-weiyongjun1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 11:17:23 +0200
Message-ID: <CACRpkdYXmziVfd0ZDTq_3ReCdcw9cWPXXD1H9jfxvLiE=7EDDA@mail.gmail.com>
Subject: Re: [PATCH -next] bus: arm-integrator-lm: Fix return value check in integrator_ap_lm_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Wed, May 20, 2020 at 5:18 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> In case of error, the function of_find_matching_node() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>
> Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

I applied this and signed it off and sent it over to the ARM SoC
maintainers.

Yours,
Linus Walleij
