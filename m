Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD66C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18882065D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIklItY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGWNUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:20:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD744C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:20:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y18so3232663lfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5cjN/ArrOT+SU2XjBSHJvP6yQc3qN6Wi8CCivRg2Z4=;
        b=ZIklItY1VHV8uzX/5DeSAuq8RFRtlThGT+GIFQMHPGcdBHMGU6NvLpEax2cWs8P6ls
         PNjbmKvBUO4f9DSVDXIYuz9fUPijmW/l8daaiqy0sqqzeXranjQZS0Uepn0aioaYYtl5
         ztC35RoYiW6tbudfX1LY9HL2dSZgRMRZ6617IfY2EgkblqbX/aB/ehNeGjVllikGz55T
         30A/IaOdVbjHe3Ym0XlJ8rwfkKq7TLfUFtYeTVYPSUpUbQE41gXKAGGvQKWGAY4CNyCv
         x9GlpcO18u18CCeJZXFuhcEBhLMxokbai8UMlHOBfBHKWA+SBi3lJq6f7yllZVU3ZLV2
         qtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5cjN/ArrOT+SU2XjBSHJvP6yQc3qN6Wi8CCivRg2Z4=;
        b=PwEf2zSkIbmtExxqgoXX+FyOglNI6gO5xpR85nI7/R+BRFuunvClL2SNT11CRaXyD/
         c5B6v9qVnYQmxmTvhAXivCEIrL4WiegQ8ljVG40DHVHTKEVpkmxJWDZEljjTCKwctit6
         mWjVJztd+NCWQZ+RXcG8VKi7B0Fui3L9qZdVwEqR0EHfg30kGDqKUCSS4W8dy8xCENt4
         ieoCJj1o+XviS4JthFv8J1i5SGfN4h6sicfmVSYgvCdkwelnsAOxpcVoLfPb/E7IjqCh
         2T/IG2dFWCWF+oUmBUfGNju1w/rWAFfWiIew/TmCOtjqMlXRoNndLXNEIeuQKxy0PUNL
         rzkQ==
X-Gm-Message-State: AOAM530n2Tjv5QRz4Tff/+Ber4PLb9c+5eQRyIAVWOYUEIrlzlLofwzb
        a9juNrVjA8PWyM2tIlgxR5IP+P1AlMJcX/yVrAVk6Q==
X-Google-Smtp-Source: ABdhPJyysHHdEAzrPwZMCPgLooL3Yy70BEt6ZdCnNnKy/t8d+QmtYn+XgGpvNWNaIM+UCe+nOjubYDkX69B0/wcC65c=
X-Received: by 2002:ac2:4d16:: with SMTP id r22mr2241086lfi.21.1595510418410;
 Thu, 23 Jul 2020 06:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200615124456.27328-1-alexandre.torgue@st.com>
In-Reply-To: <20200615124456.27328-1-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jul 2020 15:20:07 +0200
Message-ID: <CACRpkdbWUop6hyKM80zxaz85oQ8BfDLCtxBTzjOypnDpUm-a4Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: use the hwspin_lock_timeout_in_atomic() API
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:44 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> From: Fabien Dessenne <fabien.dessenne@st.com>
>
> Use the hwspin_lock_timeout_in_atomic() API which is the most appropriated
> here. Indeed:
> - hwspin_lock_() is called after spin_lock_irqsave()
> - the hwspin_lock_timeout() API relies on jiffies count which won't work
>   if IRQs are disabled which is the case here.
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Patch applied, sorry for missing this one.

Yours,
Linus Walleij
