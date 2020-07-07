Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F714C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416E0206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bgh1b8ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGGMDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGGMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:03:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569DC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:03:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so24676668ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YH/VxHJ3AGs6CZr/wDufvaXGnXEL37As4napaZvmJwI=;
        b=Bgh1b8lny6xvbW6+ct6t0vaU1Jiuk1+UbOS0d8piluPPBGIXBoT6fW7BVBSL7RHC63
         fEwHuYtJRRgTOHhbS2rN6Tjv4NtcokJr8Fuoa7BvDxlhthTf17pY3yOCrhuNLV3gkrYG
         Q4R3d+gPzj9akoo0jD0im55k7lI7uXK4QpdEzdJsmEJxDe4Nb2ojQJhKD+UQ+YtvdV8H
         ZTjUu6RzuTMzq6LAahoT55UVyxUCAbEEUhKJ/VvC7TrN4hv/IrpXz4dTMVhhSmFMYZNM
         xcw1PbLOYtWC79erbC2q965s5SZDvI1mznoOTC7Wo6tcIWKecnXnph1xJwDHHTVaozHM
         aPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YH/VxHJ3AGs6CZr/wDufvaXGnXEL37As4napaZvmJwI=;
        b=HVavFB75SeoDkB9yFQmJ+if6A6b+JYVN3yMf6CMR0PyeZGVCMrHoyicjSLA3B4qnGC
         tSzHuOKwlRc/31ozhRwo+dz4GZ7eBYATWmFfq0JmYC+5IdvF1KslFGYqQnVwbGGQ/x0Z
         9+T/3EkLWWOjEObgfQj4m9Nr3EweEhvq6e8U5JPXdL+h0APaHY4xZTCovPE8WElgFu4T
         uEVfcP9ecPlOutBd+BK5jWfJfXqVZifCiy/S3COF6iIUtAWK9i7CyrJFRHALwipan+Aq
         VK3ya3cushC/w1klOjCA3zw+yiD9GXIED4LCqksxrrdKmBv1GUsUcSCc5TaLOVWCUEoi
         PAag==
X-Gm-Message-State: AOAM530i6hSu+trNnA52nSxALnkNlBZqAIu7kQYgg9uFO9EwxZPLShZS
        k3Zl8W+6000PXeGv1hIah8acxn/pI5wBHes1jIenOA==
X-Google-Smtp-Source: ABdhPJyR5v0EwI80g1kmy1SXVGsVqQpkid61MlRrKwlnDjYgLnU+qYwazQ3V+EyiCn9ABxFKleq7Kr5Bjuu2lykaDYY=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr14035216lji.338.1594123384691;
 Tue, 07 Jul 2020 05:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200622192558.152828-1-konradybcio@gmail.com> <20200622192558.152828-3-konradybcio@gmail.com>
In-Reply-To: <20200622192558.152828-3-konradybcio@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:02:54 +0200
Message-ID: <CACRpkda7b5a95ZpLmZ07awzSHenfxyzxFR46s0cUa_5JzYQ3tw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] Documentation: Document pm660(l) SPMI GPIOs compatible
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:26 PM Konrad Dybcio <konradybcio@gmail.com> wrote:

> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Patch applied.

Yours,
Linus Walleij
