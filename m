Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86959206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOcMzoL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGGMjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGGMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:39:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A04C08C5E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:39:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t25so45099286lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PR8nQ43YtQ2kzqu7CAHdusW+BG3WkQqUNKXDoqQv2Bc=;
        b=wOcMzoL9PKOfCE92T5O5jZORfBcPgPzM0JNaF/FGTlzRWnpNx4/Ts9/TwRH1muW1hG
         NtSdl2AsV52A1f8vNs8jpCg5Sf08q8JmBH+QSIUFvTTXqj6SDODu3YlIz6LgkR5Mml5d
         uWyGBXz0agObrxeH3HyQv9iCPdwcXOwztAd5URyZolZuy2Ho3Wc8lRh30jBV8yx+UK/s
         eQlHYQzaoxf+4UtJh1jgFILwyzXqmKHa6EahoUnz0l+tEO8fIGz/n54Hn9A3hN5nxOjh
         Poymz4VH+xHPQcQ5Evt8qCUXRKk228OpZRp0a3vyuyhgD4Md+wT9iTxnU1xfEifnAe0+
         bRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PR8nQ43YtQ2kzqu7CAHdusW+BG3WkQqUNKXDoqQv2Bc=;
        b=kQDTSU+emiWsbqWeeQM1MS+drU5B9koI/0I8wkQ7lRS4nASdkSBF7/COyO3X+jO6N1
         h2Pe8g5GNnrZb4TCuBMcrCj97JbQ7QCswrCPusSwjgmXEXgphHVhGW+hccV8RklQYIfJ
         Yd8EaDUBPXmwlzTQkR2RDDVGb776uw6uQau+f5MikpPzlg2IP9F2HujMFhwxjaIiSMv2
         fEO/4/luu6upAqO783qiIGmHRcvsu4JxtjMk7MpENiBuc8IVXczIIzBXWUfljlafAA+7
         Ctg6bSDc1BSQxGDQgocrJ59OSujcOVPIU9r4GCSxmy+KjTXyxmNikOoLKSnOsQoedr8G
         4uYA==
X-Gm-Message-State: AOAM5317z4S62VO4jLg8KfX6KUNV25u14oaLKc1xKZtlJR7X48QQep58
        9yCjTwFAyS854VL1A04ZdAVVbAkWGSnCdWk7YbntEg==
X-Google-Smtp-Source: ABdhPJzLxIIZvKvs0uuMjas/mWF0QR8HShPsPw1tvxHg6ZOg/jx/Zkt6iaQekUaGKH8RYIPUuoMFtXs1GM/t0jP7rH8=
X-Received: by 2002:a2e:9c3:: with SMTP id 186mr31275956ljj.293.1594125573245;
 Tue, 07 Jul 2020 05:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200625064619.2775707-1-lee.jones@linaro.org> <20200625064619.2775707-4-lee.jones@linaro.org>
In-Reply-To: <20200625064619.2775707-4-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:39:22 +0200
Message-ID: <CACRpkdYTb4MTX9YGAW9_Th1ntcE4Go_N=wGMJ9Po8KpBGehT4w@mail.gmail.com>
Subject: Re: [PATCH 03/10] mfd: db8500-prcmu: Add description for
 'reset_reason' in kerneldoc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 8:46 AM Lee Jones <lee.jones@linaro.org> wrote:

> Each function parameter should be documented in kerneldoc format.
>
> Squashes the following W=1 warnings:
>
>  drivers/mfd/db8500-prcmu.c:2281: warning: Function parameter or member 'reset_code' not described in 'db8500_prcmu_system_reset'
>  drivers/mfd/db8500-prcmu.c:3012: warning: Function parameter or member 'pdev' not described in 'db8500_prcmu_probe'
>
> Cc: <stable@vger.kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
