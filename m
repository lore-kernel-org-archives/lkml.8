Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142CFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E82217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMX1B8aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAUUte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:49:34 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33876 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgAUUtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:49:33 -0500
Received: by mail-vk1-f193.google.com with SMTP id w67so1337220vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 12:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBEGZV2vj1MH0BvdgXGZZpVTB7oeQn2dvK8l+QN95lQ=;
        b=TMX1B8aJ0mdwyfWvhX3zw7IXUIZkSTpKbZyScUvStUxTx7Q9NKUZgT4sgEcmjjrk9P
         2nWvtVgAI4y13hFYT0QIelOR0ot1cS9WHWuxz0H09Ufx1/J8l3vCTMoXRTejA2iZxByt
         eTrt6dXm8H8h/06oBVvjTXLs7kgKY1Sdpq/Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBEGZV2vj1MH0BvdgXGZZpVTB7oeQn2dvK8l+QN95lQ=;
        b=kgjTjPQFzDfAGqELlCuvYANF0gMaU+ODFMovb8h6Vak29EokEZuKZY7+AzSvofKYYC
         VUzW8O8bcg1CZYFjvNX5BoK6VmnkJtDkFbxtO99RMZs1tYV9j4E9kZe7EJ/nHKL7JHiv
         kLpsIVHBVqaLFg1ogGJ37DZiQQd5/DBKDHAZYoJu91myLe8luqJsj2or/xQ0MFlfzsl7
         gcg1hSKIatN7/+cLO2blvgKzpqntamu7CjEqSNPhcdrP9v1bqRedJ+41v/+wByGDWQeG
         WXsw8BAKiKQtCxsEDrjMnX6m7Z1mp/V5PmYUYuy4qk4zgx1hT5okiPXxf9avl9mXnsNj
         axJg==
X-Gm-Message-State: APjAAAWnif8V79WLbeGIBSfsNu57TcAoPKcN7qR4LiYRLXnxt7028qnL
        CPl+X0Rno8BvBS2bVEw9Nypgi8g6u5c=
X-Google-Smtp-Source: APXvYqx06ZCc6lUXUo0fp8GdjbvDbe0CDyzta6OD1u6NbErYN8X4ifnPxFq39ped6OsB+Rjyjh9GMg==
X-Received: by 2002:a1f:c158:: with SMTP id r85mr4170353vkf.33.1579639772635;
        Tue, 21 Jan 2020 12:49:32 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id x5sm9171261vso.12.2020.01.21.12.49.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 12:49:31 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id x123so2821318vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 12:49:31 -0800 (PST)
X-Received: by 2002:a67:e342:: with SMTP id s2mr473558vsm.198.1579639771288;
 Tue, 21 Jan 2020 12:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20200121171806.9933-1-swboyd@chromium.org>
In-Reply-To: <20200121171806.9933-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jan 2020 12:49:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UAvQYemJonDhs3d700XYP7o5shgTwyMo1exzRCaapkXA@mail.gmail.com>
Message-ID: <CAD=FV=UAvQYemJonDhs3d700XYP7o5shgTwyMo1exzRCaapkXA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Disable pwrkey on Cheza
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 21, 2020 at 9:18 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't use the power key from the PMIC on Cheza. Disable this node so
> that we don't probe the driver for this device.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi       | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
