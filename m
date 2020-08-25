Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560DD207F7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b+B9hcGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHYT7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHYT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:59:10 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:59:10 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id 68so8361ual.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyZxIenRzLRb0uRNdBtgusm7ii5Z3WvQsO/+O8B9aLw=;
        b=b+B9hcGB4rLX+gwJzENPKtNLlKGAgqbg52OJSJg1f0lT1z9E4c9rD3zsD6Zs3A/4y6
         cHhV2Z10WGiLIf3VBY6UQvvTeU+eAn8mpZw+QeyjOGm8nzZ6glkmyD4YKNzyo0KH4ngq
         9bN1QNwPEZriPLnpyzBN33I9fBMC/Nnhx1jD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyZxIenRzLRb0uRNdBtgusm7ii5Z3WvQsO/+O8B9aLw=;
        b=tNFaQhvjYfzM2AwrCLbRZJWcTSZGtL7iYScPjdbjY9SzUmbqhLGV3agrg4Qi+qNPRy
         DiDJOvVQUhkn3Glw30K0r9I0TcG418mpW7Md5HMIcq58NmjqTGdT88xz/+tprVj2vl4j
         GLnE4rFeP+ogU6aVL5cniorhmSqcr0OuTMD3x/XGfqtBm8s4KzX4SPyHRMV+BBzxNswl
         jv0YZhKNEyHhggDrrMoUe0HiRGfSi+vD7K+oYeLm7lCGbYWDaWUgOpaXkeJaa0NQJjI3
         DUncE+peGQNwR1kQ95jLmkiTz2QwPHf/xe8rhEp6RftaK8b+ks4pnCtRCjOXb7hTXtfu
         LLIQ==
X-Gm-Message-State: AOAM531klI1hxBnUuQ40LPlQK71HFhR/qBhw9ZE62sFaV7MgMV5ZeoF7
        kllBr0D4rS8BlqhbRMJbJn8TpONRbvqr2A==
X-Google-Smtp-Source: ABdhPJwvh8xovK57NSuAjd99HeXId1OQh4hUBKHxZOHNJ9Sd3UHs3OLfihB12qXkCeU0t4vX9vbXhw==
X-Received: by 2002:ab0:22c9:: with SMTP id z9mr6667948uam.17.1598385549266;
        Tue, 25 Aug 2020 12:59:09 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id h8sm1980595uab.13.2020.08.25.12.59.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 12:59:08 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id s29so11827uae.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:59:07 -0700 (PDT)
X-Received: by 2002:a9f:2966:: with SMTP id t93mr6981969uat.90.1598385547221;
 Tue, 25 Aug 2020 12:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org> <1598113021-4149-5-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1598113021-4149-5-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Aug 2020 12:58:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMSx4ORdztkb1L-zh+pYEsQOLLALRNjazaZFsEk0Rvkw@mail.gmail.com>
Message-ID: <CAD=FV=WMSx4ORdztkb1L-zh+pYEsQOLLALRNjazaZFsEk0Rvkw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] pinctrl: qcom: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND
 flag
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 22, 2020 at 9:17 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag to enable/unmask the
> wakeirqs during suspend entry.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
