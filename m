Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE23C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413E42073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipsLkFmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgBUP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:28:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39071 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBUP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:28:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id o15so2602443ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UN+CWiVcnl1t3iZVzq1TQm7oj61jG5zfG5blHJVYlAI=;
        b=ipsLkFmM7mX3UmnaWZVKbi5pG0qQJn3b0UAAel0eQqHf0WXtgcQwKNwvfRoIsD37O1
         3zMEFbpBJiuC5/Og5GSvuWtysk8901K+gI8JMIy1Tw8rcVmYv4CKFhoSyJlVGk4WRR2d
         zB2Kuo8EQP39F1O7bolUPpLaYWQM7x8ifZq1Q65owiKRk2GrnNvBlwgg+CstAhKLA+lG
         dCjpfhI6GJh+8bYAspFB24GBKGVogPDsclfK8UdTplP18IMIjuO93ydyKj/xMIcVINxl
         f9a/ri6ZvEpVz5XIpJn41uPWE91lWaMjyQD+A93dNBtzTKx+ho+LlJ7OlvfSbxRvRq4/
         BZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UN+CWiVcnl1t3iZVzq1TQm7oj61jG5zfG5blHJVYlAI=;
        b=t0QdltDQ8b5TAG55AE0EtaEtmJw7PJd0f1cuwzhduXPZsX/ssEv3GktIpkQrjabT4w
         DbXvfOnz9Z935EUpyihKLqO5rt3U0g/4PDadKUur2oAEcT2/L8Yk9AnLDWFTySirheDk
         qi9C/ELs7iMGvRKLDuhxu2s8CbFIaF8ZrjXpP/UK9Dbl82M4og7NyVn7I+gCuyhRp7xo
         f/rjmRkGR0HYIQQE8V1A2/WdXO0p9pirdkkRP1U6N/LAbzrhzQr2uDaM0cN1DNzgXPjr
         gHHuZU8V+aThvS5Q3l2Rq9pN7FtCGmuqVqTzHsLbG3hp2q+D8nJFZd0ZHUNdfnGY19Z2
         3D8A==
X-Gm-Message-State: APjAAAWxsw9kmlhUNbQ0dsQlDFdKbwpeo/zS2g40gBwQaCtHAUReKEYg
        ao93cWSmkVttOE/xVYH78zhQbOqgb78IBsgLApnfzQ==
X-Google-Smtp-Source: APXvYqzmRFe5+aD/XXxN155ljO/M/dRWkcx3FCLqbfPxZB8aGlo1hrJcZ2FMwgK4758C1WxaFEeTRiAAgqNT/nNrtts=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr23121445ljg.223.1582298895959;
 Fri, 21 Feb 2020 07:28:15 -0800 (PST)
MIME-Version: 1.0
References: <1582204512-7582-1-git-send-email-nbelin@baylibre.com>
In-Reply-To: <1582204512-7582-1-git-send-email-nbelin@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 16:28:05 +0100
Message-ID: <CACRpkdajEO3HvqG+4SNj1UoUpAZJoq9RHT+bqvHDbvP6UUjA+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] pinctrl: meson-gxl: fix GPIOX sdio pins
To:     Nicolas Belin <nbelin@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 2:15 PM Nicolas Belin <nbelin@baylibre.com> wrote:

> In the gxl driver, the sdio cmd and clk pins are inverted. It has not caused
> any issue so far because devices using these pins always take both pins
> so the resulting configuration is OK.
>
> Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>

Patch applied!

Yours,
Linus Walleij
