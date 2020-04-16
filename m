Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B42C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C92F21841
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUm/dCpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633168AbgDPL0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632893AbgDPLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:24:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E55C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:24:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j14so5289370lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91IoQt8MKAEQHzNhIomKMTipSgMe5lSxVgD3BjRS3II=;
        b=pUm/dCpD1e2p3xp5gP2FxIaTOJYH0dKsBte/U1WzRr/sqJJwTvU48GZ1Hka/i50iXd
         qtjfcbVtvHLKx1XrN94vL42DhN/4djLHGAUiQ5poHDIcSowJ443iu7reqIKF+ON22+gS
         Y2NWQ06wB3tcXZq7wXxv8j6UfTyqFg3Ar5jehrqa1s0ETPFwDt4DA6rXO3d3p5W2yh5s
         gSl/BFbmFQAJSUmGZd4GHYpEh869jkZu7qzgqocMT1j15y9uHq9Hfr2K1ZO69FmFxPFp
         oxAyzQs5QM5P4B4ak5prGL/jnsvIWWmJE4hd7EEfjVMUtMwd1GH6SW70YOJSrqloA4gF
         M0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91IoQt8MKAEQHzNhIomKMTipSgMe5lSxVgD3BjRS3II=;
        b=K6RIDRaX8jsCPk5frmOfuOiafpk8OX+b5zyeSf6NoJXXODBhvhAUfC2ri3PTK4kyD+
         bwp5svBEJF7cUITeeyapzv93B1/Qodrw35tPClwAQhrn2OGEAMlsE41CVQYH2CGZra9H
         RqE4Qkz+eZTWtsJZr5JPNYGpHqiW9HJdw+zJUG0Th+GCjY/g3glwrDWhjx0OVgcpd94j
         SmoHyZk29WR386/5/uQ9VUFBtLFFqvOSrilZNwS4X5Nqj8gs3pf1mMYsxrx4RxtT3wIz
         qP2iiaNcmM4OdpoMCXfIl9i+yKMbJplhNTNZrLptLgvUCBrs7sBCQZnyaQtfzIlOBGhq
         xEyw==
X-Gm-Message-State: AGi0PuY3vtA2YsJ+Hscijns7fV+9eEEhcz4skGiWSIs7qk4xcsZWbb+d
        nDrx+nKyGm8L/bBzetYGbpvezZRlfaXEBOSJbfjjQQ==
X-Google-Smtp-Source: APiQypKER/2EB8Z5ELqVAMozkqwK3O4AQM7q+civrEIeHemg21DnYBd8b8x4Owji7jfW3OIAelN4bep/jvanKBdDm+A=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr5679216lfa.194.1587036284149;
 Thu, 16 Apr 2020 04:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <1586882894-19905-1-git-send-email-gupt21@gmail.com>
In-Reply-To: <1586882894-19905-1-git-send-email-gupt21@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 13:24:33 +0200
Message-ID: <CACRpkdYZ1_EzPPFaiEUihnxuMB=9EquVPnRxf3pVeJfxn8AbcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: mcp2221: add GPIO functionality support
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 6:48 PM Rishi Gupta <gupt21@gmail.com> wrote:

> MCP2221 has 4 pins that can be used as GPIO or configured
> for alternate functionality such as clock generation and
> IRQ detection. This patch adds support for GPIO functionality.
>
> To set direction of a pin or to toggle its state after it
> has been configured as GPIO, driver sends command to mcp2221
> and parses response received from mcp2221. Based on this
> response either 0 or appropriate error code is returned to
> GPIO framework.
>
> To get the direction or current state of a pin, driver
> sends command and read response from the device. Based on
> the response received from device direction or value
> is sent to the GPIO framework.
>
> Command from driver to mcp2221 device are output report.
> Response received from mcp2221 is input report.
>
> Datasheet (page 45-48) contains details about how to decode
> the response received from device:
> http://ww1.microchip.com/downloads/en/DeviceDoc/20005565B.pdf
>
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>

This looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
