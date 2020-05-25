Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8400120723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+pESXNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgEYLfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388733AbgEYLe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:34:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC8C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:34:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id o14so20446285ljp.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wi+gk3CC8jugnfSNVoMn5WXhzhJYTbdK21k8+STJk6k=;
        b=Y+pESXNupJYz2M2etZnKieO/VeNhDEch9p7SVInZEB86XRO8h8M0GoDFaLeaBHge/W
         Xp9kIUqUEkWWSw7pjtUsHwOtULbYumcsJXagBz9Ug1w/NyvSgP0CQ3BbjxCv+HgrB1fH
         v0FMESlvZPYhwTC1m2O/dm7zggf8bAm563//moUatJJH3uVnOVQ1G5LKgQlw+V4pmaQE
         nFAU4UIJmnE5qEc7JF6agjan+4tXxbuDF5lKRg0yWE12MncRS99VJLMnqTN2QXnDp6Ne
         9pZ90O0+wuTvskb5fFW0cpQxlH0kvGuiwxPPgcUyNGvUm478ynq1TcZi70/WmqqsQyp4
         NTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wi+gk3CC8jugnfSNVoMn5WXhzhJYTbdK21k8+STJk6k=;
        b=DRu0qxTKqAnzVynF0l9KltSzdBxxWPjqn2+bSxW49BJocCRqsCw7J8UDpzt7BQmKiD
         HMvHsb8uThNZcmrhM840xkE4vCXEYL5i51wmnV7If8f5wUfZz6XAOAfUBIDNI+86GcKx
         h6w2LgmfOkmOfSFDRClMu4pVuEAZlLXCTO4o9KMB/DM0s9yvdxeooujFgXiVKj2AEeg6
         I495Ko05avu7DwfUg3RExCbTq5kmB3qzuhQ9zyM943nwsZ9YD1V4jdDlwkAScr02kOQR
         469DHnHQA60rk7EP1t0uWsnzVPxh3q9dLB4yLXjxdHIdNeJrW5g4sU7KKxYYz768d+lP
         QkZg==
X-Gm-Message-State: AOAM533IoopegsSHcks0k5wBad0O/xPPzFgjDeq60lmWQLwySkieBrqA
        MYipgjPcxEkqxYRp3gBti8ip1m0MZoDamYMD4GatS/CJ
X-Google-Smtp-Source: ABdhPJxFW58LmjFQ2sV+aQMAz5AdRkRbkgO4NOt9cugPGtvFDYY4xWr6++WnNjKk6nO+SbTF8QVEWA7J+F6+Lk6vtb4=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr14339462lji.286.1590406496492;
 Mon, 25 May 2020 04:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <1590153569-21706-1-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1590153569-21706-1-git-send-email-mkshah@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:34:45 +0200
Message-ID: <CACRpkdbpbOPfMfgjF17C=ET1SCiY49Wu55fgO6-kjBwR0mmQrg@mail.gmail.com>
Subject: Re: [PATCH 0/4] irqchip: qcom: pdc: Introduce irq_set_wake call
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 3:20 PM Maulik Shah <mkshah@codeaurora.org> wrote:

>   pinctrl: qcom: Remove irq_disable callback from msmgpio irqchip
>   pinctrl: qcom: Add msmgpio irqchip flags

For these two:
Acked-by: Linus Walleij <linus.walleij@linaro.org>
so the irqchip maintainers can merge them.

But you ideally also need Bj=C3=B6rn's ACKs.

Yours,
Linus Walleij
