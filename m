Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B06820714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsSMMtpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCYXXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:23:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46592 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCYXXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:23:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so4403434ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzH05cCCMpVmHYF3oKcpm8etu/QybMtAIGeitvxhj1Q=;
        b=WsSMMtpKb0V9yha9xppOQV22HjAGLYImHQyE8yg9neTuzz/nvoNw5ji+hwqqFg6hr3
         eB9INx4p4jfTld8Qe4C3ld7jai8lFsCq83RgddMC5yJrwE7wfIr0lRqucaUWViadoI33
         WeTPrKbBBJvypG6oTC976eAJ/thZPFgWF3kyc1psAcc9B2BmC+xrz2nl6YmZRDh93dbv
         1XYDlZbOgU1OttNHAL+wQWA07ngBhdFag18MwBQxk/oY/Lv1oehlKCkjLaAErvNTAQaY
         FEgiaNA/t/3AXYRG3PyOV+a048N0obhrQg6f6Dqpxa74yd3yC0LactbyPwxxruNChYqM
         VVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzH05cCCMpVmHYF3oKcpm8etu/QybMtAIGeitvxhj1Q=;
        b=GhEKCxqjfKKc2pQA0Fpu2ekE4SURPjEwgsWPozb47qTyjezbsm8EZ9liFH3Luv3VqE
         bSVMlbVIUBVHTMJwcN56kDynEN8bYGHAsVRNien/3UcilbOi5cLmJgFGNsRyaUCHy3MN
         ceK0vH6Nrv/pa6TlzymT0HAqUm3iqgwlexNdPGHNrAgb3Y5gLM3ZDI9iNa/ER3mEsWVd
         9B5XeG0gEb3jSQlXTy7QeGuuMRKB/cWKt1NuQ3iFg5T8qVaSqm7fe99xH1ewLe73yeJS
         7J57PMLLxPilNJMwwu1GI0x3QpLcSvtcWZL2Iz1byRW9+8bjW12ttksq97ZAgGN/T3/I
         RTsQ==
X-Gm-Message-State: ANhLgQ126L4qt2/WOaoM5CiVS03M09buNF0AGSWIf27EdomsbiCYQv99
        2qY8fi7YwomGAGjD2p6heMSb4YrsHbOOg7M5tZ59rw==
X-Google-Smtp-Source: APiQypITGq57Kb/lzahVkrlExUhwLPINcscG+bHPEiaOYa6DIp+J67M4OUdwol6kgmk28bTrywFON1xEgyHN3jB+qx8=
X-Received: by 2002:a2e:9a90:: with SMTP id p16mr3485374lji.277.1585178616927;
 Wed, 25 Mar 2020 16:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <1584070036-26447-1-git-send-email-peng.fan@nxp.com> <1584070036-26447-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584070036-26447-2-git-send-email-peng.fan@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Mar 2020 00:23:25 +0100
Message-ID: <CACRpkdakXz2QCsbAqN0AxXJ2o8ZWzJ9_h0b4w8SCvtME4Uk_3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: freescale: drop the dependency on ARM64 for i.MX8M
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:34 AM <peng.fan@nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Moving to support aarch32 mode on aarch64 hardware, need to drop
> the dependency on ARM64 to make the driver could be selected for
> ARM32.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Patch applied with Arnd's ACK.

Yours,
Linus Walleij
