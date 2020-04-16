Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5851C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39DD21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBO7Wy48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504063AbgDPJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504032AbgDPJmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:42:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E7C061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:42:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so5482312ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+O7/evWJtIotBVQwpT2KqWk5rAQTrvcTqRSVKK6/9k=;
        b=GBO7Wy481+gwjzwWz6sPoxZqqVNth7p+TZXxXv9ZXZIuibsA7jpbfZ1R3Cltai4VE/
         T+Q6VWM8Q2rrpO4h9z7LSUUwDtPWLvpo/tgRtXFb00mvUDeFrnFf3yC1N4qAdzPUpqFm
         TdzpB+TgGyDntlMspEHwiEwmi7RkyzWoWHzpYbd4IXYRJiHIeQBBKmZLQ1gv3hnKR3O3
         ++3rNzyQ1L2/scInVP4zfxYgBan9tmTDcBBBpC/4+rNQU9yfyEWL/aRb4X2ZbPezw6N2
         vuVncMTVvXO7PsbL+fsmN08ROgpRe4jFNxIaEcMzDulqNGg4CKbv36dRq7yPUXGY+LDk
         i9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+O7/evWJtIotBVQwpT2KqWk5rAQTrvcTqRSVKK6/9k=;
        b=HcJpZYWP+ozrjc974vk5IH6bW0pq/DKtxj6IlYXI0I4pwYQjGmz7l1X3sc2hWHq84b
         JFkaZMXFC9Skv7/MqfbkX61dbce3tVQTfr2XvA0D8aoVcLksF+rSY9+y1M0Bun51FFEO
         AxAI9A63nlSj82OhGnAs/3sMW4j8K6FR6PNtFywX/jgPKxUzG88jNVVr4+jZgpIuPqPc
         ZWDWDd2JWfio8ywCrneWdYPge29eTm9bosaQSY27Q0nIZJpZPEBrR3W4Uv9BR0qA1iev
         w9QkE4HTDn1NndFd9pBO55hsq7ohv4tu0eXTOox8GUVyLD7/1xbAs3ZKUulL9ZZ0H1iC
         9qJg==
X-Gm-Message-State: AGi0Pub2VpqF8bluMQB/vhQSQ6IJwSrH11mJv+pROkOBy9+32lUjkQEx
        unQlITJEbM5iXNlAbyrZmXd5LfFeGu0YScmWDqJONQ==
X-Google-Smtp-Source: APiQypLpGxFP3d0tO0AVQPx+QFHPQbTiqjrHkFQRQ+jm2jkrid0OXVlkJQdGNnguZKq4zibPaNOzMTt/O2P/KsUiIa0=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr5725065ljh.258.1587030129422;
 Thu, 16 Apr 2020 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <1585306559-13973-1-git-send-email-Anson.Huang@nxp.com> <1585306559-13973-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1585306559-13973-3-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 11:41:58 +0200
Message-ID: <CACRpkda4Bng5HqUdFCL4a+GMzyK-SqcfuDLjOaebS4ghtL4FsQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: defconfig: Enable CONFIG_PINCTRL_IMX8DXL by default
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peng Fan <peng.fan@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:03 PM Anson Huang <Anson.Huang@nxp.com> wrote:

> Enable CONFIG_PINCTRL_IMX8DXL by default to support i.MX8DXL
> pinctrl driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the SoC tree.

Yours,
Linus Walleij
