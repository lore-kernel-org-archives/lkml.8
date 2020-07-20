Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C3822BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXsM1TqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGTNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGTNqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:46:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02947C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:46:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so20295599lji.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qtN5L8/xZpkQuUDdQgpDbwS59vLxj0mGpt2DoBoy94=;
        b=eXsM1TqXMP0+Ycllxnt287iVoc4UP/VmkbTLyen6E3H8sTZIqd9z05gN/mMJfdmKmk
         BoJo8MyzlEYp7ARXgkpltQj640PDZyIDVmJw8pr5I0qCjR5l4sA3Zs+PRacBBLXeWwSI
         P/+0oQIeqpm3sV+uW1mN67zbkry7xF0VlZgjis++Euub9b1vv95MLRcvI5OCWJ4QlQCb
         SuRNmhUdtMlzKM0Nmoz9Hv5kpvsp2YDTORZGw+lWD9umaFAaMgicUR+ONXSdsGOfBxzz
         1rNvJhmUA1bS+pr1aejUW00ivh6s7iEjEE6htmYQ7BUmzXFlo5mlJrh17Ymq50aOh1Ap
         0zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qtN5L8/xZpkQuUDdQgpDbwS59vLxj0mGpt2DoBoy94=;
        b=HSHwcBgrkyKkZdW3MvfvMtspzdz9U5KAH1zAmhSoIHpDoSi1JVqbz51tRuQA7RXdtb
         hpLjNknJ/Q6WFP6AcbrIdKkKc1jgS6VfFJcJVUhBBN7lhn9A0N6XzkP42xr/Erdl8wLf
         pwHw+jwyUGi7MmZ4wUWj+f/vfyEypuPRZ1yoneOnic0pd5eBoTjskgWDAl/WSc8qFFIv
         q0ygVYkcNNaYtSShHUCNRl9bX5XFt1cXIH05/TTd0RDsK7+h4WbLdjSOeR1SgexKT35Z
         uXGuJ88i6ULlVbxDdRtC3sd9VR1HQx4bOBGfQENJ+10rgPJ0W/R9OWgK0ThGAAGKY08e
         mrmg==
X-Gm-Message-State: AOAM533tLlt8D2isbgxw6vNl38KDiIKRK7M8boSuHakuqOTzX/tVCR4j
        rdeGJ4Qit41WEPkQdsl+0GEZkd95qlZd5havDjcd2GbQ1Ss=
X-Google-Smtp-Source: ABdhPJzRSIGPw4xCiw8wIgSx2BFb3C3mWivZPGkHLMXSE3njtM+f1mImRq6NBxxseL7B9Y8eFbRc4USvjpMyv+bDbIo=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr9943001ljc.104.1595252805400;
 Mon, 20 Jul 2020 06:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200717014908.13914-1-jay.xu@rock-chips.com> <20200717014908.13914-2-jay.xu@rock-chips.com>
In-Reply-To: <20200717014908.13914-2-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 15:46:34 +0200
Message-ID: <CACRpkdYyZ3GHYo0vB-1UpW+EtiTXgeRuOhOuB0XxUNXN11N9-w@mail.gmail.com>
Subject: Re: [PATCH 01/13] pinctrl: rockchip: add nr_pins to rockchip_pin_ctrl
To:     Jianqun Xu <jay.xu@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 3:49 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> Add nr_pins to rockchip_pin_ctrl by hand, instead of calculating during
> driver probe. This patch is prepare work for making rockchip_pin_ctrl to
> be const type.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

I'm letting Heiko review this series, to me it looks all right.

Yours,
Linus Walleij
