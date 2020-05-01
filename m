Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D6C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAFA216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i5JF31ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgEAPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgEAPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:10:50 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3EEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 08:10:50 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u12so3473786vsq.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knTG2gmvtoT22+XOsX7dmFpVAGO3ao9zwsfFiTXURTg=;
        b=i5JF31iiDLo6z171lTJxhjapmVJS9gqP3xgHzEmURWBZ9ZrO+wXla6ynAK3ki/7XPX
         sRwv80rlH6ndWj4Gju7PPJfTN9R8SjAgNB8Ev4Z37QlaoWQGa2up1QK2IwuGgWTxfCp1
         86gjvyWw9Ih0xsuuDS86kOVoOpHcVaXBZSNjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knTG2gmvtoT22+XOsX7dmFpVAGO3ao9zwsfFiTXURTg=;
        b=dhCQykJ816+8DF+XiVtlA+28LjjS0G8U6kZAVNAGtSv3otmLCZTqaY9dQ4GiC00Tur
         Q10m7xy3BijR/+0/nF/Xbqqv7M75ZyrBKV9ErP3dz7qEVMtg85LNalINAQFBn/PK62qr
         WO9aqtoqW96zokhAofYMDV1WB+k1235yEsKEgbr86h4D3Fbu5TCCSwRhP94M83N6nJXB
         zK+V9EG/KLq9KXN2wtCHPUTQQ/yK2n0yulNkkXybgw6ezrLoZOmFXKbP4/bx97GmBSQB
         rmBrg+uQJ12r/34jWKGaEdZONlzvTxuhdHujhijgYWaf83tmPWp7K4bjawBLCBZn8c35
         NHIQ==
X-Gm-Message-State: AGi0PuaBUF35voowkhSXa2Y3GBhjRknyIwV7Ajm28MyWNd70cFvLnWgs
        IgIUdI+3QWFQ/8SCa9gLuEirnKoguA0=
X-Google-Smtp-Source: APiQypJQa73SrUYdqvanDKEOFYozR65Thd99RGmIL+07KSJ56t756XnZZf0tdu0oCUmEOhPdFbG4pw==
X-Received: by 2002:a05:6102:30a7:: with SMTP id y7mr3438610vsd.118.1588345849280;
        Fri, 01 May 2020 08:10:49 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 189sm776541vsu.3.2020.05.01.08.10.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 08:10:48 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id x136so6441623vsx.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 08:10:48 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr3622452vsq.109.1588345847717;
 Fri, 01 May 2020 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 May 2020 08:10:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8phQsc5SSUdqw-HRPYzW5QoEc8NoVJ+ZXQz72FgEPug@mail.gmail.com>
Message-ID: <CAD=FV=V8phQsc5SSUdqw-HRPYzW5QoEc8NoVJ+ZXQz72FgEPug@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Add affinity callbacks to msmgpio IRQ chip
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LinusW <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 11:31 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
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
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Tested-by: Douglas Anderson <dianders@chromium.org>
