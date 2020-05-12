Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E66C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746AA20675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exCeW+nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgELMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729408AbgELMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:30:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F61C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:30:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id o14so12342228ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkbzZyFNKR5xF9Zj0XXSLiW6F+Uc35unyhuy5/Nx/Q0=;
        b=exCeW+nP77zJ0TV1K0EGNA+H5dOM/e46KBa/p2zQGq61zsrFTTx7KZa5cldAt97Ijl
         uwywF17fXwO0Y2J8N458zCY761VkF06TyT0wXmXeCEhP522u18UyGR4fACmDugGvm7g+
         iKwhuQc5slkVhiBkG+a0xKgBo9iJpN4k+oOr+Avdnnhsa1Qb0NQn+t7ztSODllLqm/Oo
         ea0/5ry8lpH3UTmbt0dCeMpjgutQAtCibc8scwfVMNVVolq4HhKolP10/HvVk4H6fkf0
         N5h2cevIpBluCumqyoMVJ26Z24EyM2rmAUzbkxtbZtIGQRGc1VHm7JEsplkKN7zh0nWF
         6EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkbzZyFNKR5xF9Zj0XXSLiW6F+Uc35unyhuy5/Nx/Q0=;
        b=S5mSsfLptUFg5HF7nMCzc322XPcC94vGPrYmPWW8Vu0dW8rIiZ5y730k9vsQy+I0fO
         JTMfM3A9p4CyOIl1y/g3gATaFq6fmyloJGzLeaza2YgwmCJQ6UB3SxKZfXw8/sBO6MlK
         DJdpMS9tNXFEQc5GemrC6jiyaVmmCuWywGrEe+PwnFySClHfm9Annr+eJVeqZXjlvUfs
         iHzuklOCgMX97atyM89AakLoTpk0zK6IXsuRrBMvICwt08C1/nY7l448uKMPSzBOFSit
         dhJcs2d17+wuRU46Xn+G+IeWlYlS0/B3z9d5XD9BqOZ0D7EOnIAkyAqZApdrXtnjVh6D
         xuBQ==
X-Gm-Message-State: AOAM531da8o4C4TgEVYE3n3YARwE0rA5ekuC0NKX+1QPkQv2cJ7v7x3Y
        T7UJfnWIiZXiOojUCDFO6kWjQerH8i0vZalUikeOhA==
X-Google-Smtp-Source: ABdhPJyQ1XkAcDYdXIDP8J2lY9e4GdpmrmWTg4XAQwyJXe2xgn9EQQgalxHJmKDmPx5R0kd7PzBNkmSwwYjMe3jXEHA=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr14097206ljh.223.1589286646283;
 Tue, 12 May 2020 05:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:30:35 +0200
Message-ID: <CACRpkdau3+OytK93=6SA-mzdcded6Jsx=WoxgXXd4KMUc_WwPg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Add affinity callbacks to msmgpio IRQ chip
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 8:31 AM Maulik Shah <mkshah@codeaurora.org> wrote:

> From: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>
> Wakeup capable GPIO IRQs routed via PDC are not being migrated when a CPU
> is hotplugged. Add affinity callbacks to msmgpio IRQ chip to update the
> affinity of wakeup capable IRQs.
>
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> [mkshah: updated commit text and minor code fixes]
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Patch applied for fixes, will go upstream soon (unless
Bjorn stops me).

Yours,
Linus Walleij
