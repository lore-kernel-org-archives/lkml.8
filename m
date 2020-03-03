Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2BFC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBD22073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwKCTO1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgCCMkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:40:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36403 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgCCMkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:40:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id 195so3369299ljf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 04:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zN8pyMGel5CV8Q9nKyqGu12Vu+yCXPWrrYbbRn/lVPU=;
        b=HwKCTO1rlByKTsfERL1oZ8pKPr5JopkC3uXIMLMJIlq5BKoyM0rhAXFSdGParUncGI
         gV7KLS2Ud8c3rgLcmIKl/JwbANUHsWH7ieo6Hf8lgu6sYMT4Gtij+ZyzjmfVPH9msRvu
         1zn/Nma3BCSgTDOXXliErlBP4mJgVTqAknqNjZoddALJjuSsgq804W9iLhlz0YdeWtii
         y7FT0h7C76rVSI7Dy4lvwije9Pbu2idIGncUJmoiAtlVd07EvvtevxoMQZjmz9W36fce
         5GUVEc3hD5Ne8dCmXdKLJ8T4cdJjcLyedUo91UsS6oNA3xb3pDYu1DG3MhVV8CW4PlPq
         1Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN8pyMGel5CV8Q9nKyqGu12Vu+yCXPWrrYbbRn/lVPU=;
        b=cfimKplnkSw77tKSpBNSNCSGB6dskQLCEf5pMN1rmcXEleeyMGhUGSbjcwsY9HQBrG
         l3vmkq37bO8sZ5VIc9QjGjGxStCH1DVEP8SzzotS4bGQR50ABdsymqfHQ0FVgPohEzvw
         8ry8a72GiBnMegwOS76qysk2ZCCTHD5hrEO5w6PJkofloD3U+Slv96SC9kkQ/O1O21Sv
         g9J3RVrYz2EKnh+uG38GNAjVn0SL3epcGqK6dt0AzeOn9V0I+3cQgYq4Yn1nZg/jQMak
         GOcJ2k5yOtjtgYJinADfidhmbSEtu7EA5dTcPoPFeV/1S4gAJxmFK/a2PWgi4QGUhIiH
         auyw==
X-Gm-Message-State: ANhLgQ1wee77guHPJ+OKNLrQy+fRDKiNPziv5cEMLWwrjdkhev8DjTxM
        ApbeObdsqceux3zqdbtlmNLAlG8UyYYhK90U4VWZrw==
X-Google-Smtp-Source: ADFU+vvSSKGCj604RxzVxw0FhFpXHGXXjroDOMjzjjm8qVvTi5OQFjHlZtkT1au8AJ7UHhJzsPJpENZWs84jZE3Hfxk=
X-Received: by 2002:a05:651c:39b:: with SMTP id e27mr2176389ljp.99.1583239222137;
 Tue, 03 Mar 2020 04:40:22 -0800 (PST)
MIME-Version: 1.0
References: <1583124056-94785-1-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1583124056-94785-1-git-send-email-christianshewitt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Mar 2020 13:40:11 +0100
Message-ID: <CACRpkdZ4+-26Q01nx9iFJLUSCfM0Cuh6U8=gdtP=63xMd+2jqA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: add tsin pinctrl for meson gxbb/gxl/gxm
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Vavro <afl2001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 5:41 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:

> From: Igor Vavro <afl2001@gmail.com>
>
> Add the tsin pinctrl definitions needed for integrated DVB hardware
> support on Meson GXBB/GXL/GXM boards.
>
> Signed-off-by: Igor Vavro <afl2001@gmail.com>
> [updated commit message]
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Can I get Martin and/or Neil to review this?

Yours,
Linus Walleij
