Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02AFC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D79E20714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CR3yBp4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgH3KHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgH3KHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 06:07:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43340C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 03:07:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y26so1945372lfe.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNsRAqkpb7LZUriy3bYigquvN7E89ZUZ6a0Kz5iQgtM=;
        b=CR3yBp4eF8gKwB94L2+Av9mspgjaQGAeGq8CagVhQyQcSS5sDkiA2Bjkxows0LNG2W
         4VJM2kNR2Q0MBPpzOfSI76DXw5f7LvJXSGK8S/ZN6mk5H/JThx0Wul6RUWRMnN2ePUV8
         wYqyQaOVOjcBHxXpGUR6QyvtTnW1WC0ajzsCqO2cAJ2xBGmAWFSlBtb9pocP+iO3dHFr
         40a24lVcbeYwulKpH71uhXLpncipggPnqzjR66SE4NbEMtd71/V6df4WmmBgrdwnSjU9
         nI6teYtkcGSIovCkUWdL8z2XWKmsrPX7+eij4chqEgYPUWlLhUil66KToCQKok5boyB+
         WnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNsRAqkpb7LZUriy3bYigquvN7E89ZUZ6a0Kz5iQgtM=;
        b=k9wXtIUgR+9v5puWY+iC8PA/8YSagtAgZZR3jQW8X5nUbiiPW9mikAMsBAOL7tGJKt
         VtjQ5s7HsFNCn2F77k3uzkoXs/WPcoa+PHaNFYSdFESaOlZFzNUew48ZNthvtxMEwBq6
         TOriUoB8psGbBmf4MLX2Nn1BpJupjrTtWNRqKkdK8S0XckmKaqfYyH2JMpks9MJ/KZ0i
         d0gLc/J3xt0JZBTUFMmSkhmrKg/pH0E9wAsTwRMaBSN22CdrFJoZxl+GG1+O+dDV8Flr
         te98u35D6qG8H/vGpXeo31hn78dxRK0eHmgeW8qQRVoLXJ6kOBbkuK/3tFe7bgMMMYDr
         LapQ==
X-Gm-Message-State: AOAM532e4TgFGlN8VUyjMfJ8hvFmP1xBj4Lo+1Xjr/ZbX4QPOkjy4Rwg
        iNVCmIJcc1WDmCGTuKMVvBfJUWWU1e/pl7z2IDonJg==
X-Google-Smtp-Source: ABdhPJys34Tj/H6BMuD4li7gNKtPjNXFTtG/dt6qc79bH1fBaaihFbrJhQPAbU6UvAQfixj/pjHIpIsLEhzSQ88UfoQ=
X-Received: by 2002:ac2:4c05:: with SMTP id t5mr3290753lfq.89.1598782048574;
 Sun, 30 Aug 2020 03:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200829175704.GA10998@Kaladin>
In-Reply-To: <20200829175704.GA10998@Kaladin>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Aug 2020 12:07:17 +0200
Message-ID: <CACRpkdZ+_eDPntPhfhF3bAP-afsVUaCfWowZL-otr8TcKdRP+w@mail.gmail.com>
Subject: Re: [PATCH] clk: versatile: Add of_node_put() before return statement
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 7:57 PM Sumera Priyadarsini
<sylphrenadin@gmail.com> wrote:

> Every iteration of for_each_available_child_of_node() decrements
> the reference count of the previous node, however when control is
> transferred from the middle of the loop, as in the case of a return
> or break or goto, there is no decrement thus ultimately resulting in
> a memory leak.
>
> Fix a potential memory leak in clk-impd1.c by inserting
> of_node_put() before a return statement.
>
> Issue found with Coccinelle.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
