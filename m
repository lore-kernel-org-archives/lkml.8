Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE680C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B2720716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDl6Tah1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCLKou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:44:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44604 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:44:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id u24so3334147vso.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hsaG6j90s66b5sAhcEsQTY0J6YR55tJXb5H+vXmq9o=;
        b=BDl6Tah1NgNqpJiG8G3CoDYR87HmHLI8xvK8q2kHUqM97kM38Kbl8lKdPiqJyXtojq
         icwj3qLGQWigurDYhIh0KN4bz9wwIQRkyvCBsdJAFirg41OT+I97DTnbYyFxSTeCeCSO
         MpA11ZmGDCF7Zw2hwDOi90PKeLezH5+npfVwNOnfFOrcsmpBJKj60+JoB7FuNekCCkDk
         oi5UMYTExgop+4c7iTeLXM+MpjwiPw2ZWSaP7SZHg2AHyrKxkfuj9B24Ruyu5B9TLsyo
         Tjajj24+NKBaODEvMCnsL6cU67ag2CIGJluubOaHBItFWdvbcrktOnfOB4lzKx/Utg8k
         YqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hsaG6j90s66b5sAhcEsQTY0J6YR55tJXb5H+vXmq9o=;
        b=PUGbg09SzFpdTG43V0FV/slqq8nRN7GrsaZTAKgmrRU1uvWYYpKa5nkiNASxILexWa
         Jt17QSimgnKl7Fp3U0sylz3OHfznDex80H7LYR0N1LBnimakrAgxCqOL0TabOTV1JVsn
         JgsQsHpZ3h7e1ikUpBUaJ0isCKHUXK2sD7d6z2+esEyWWWDx7dqGq3+0nKZt7VwzbfmA
         QIfco12eIr6hd7g65htHVw+awX3M7ppOExqY6385/Z/KqBtkIjZp3VAtNB4UdgyuL8xy
         zi/dgEdM0NhedAdJFeBcBmmTyC9CBrI9gFznTgvcEsR0OBUP0NdXsZkI8ehB9TdHMQHv
         xjcw==
X-Gm-Message-State: ANhLgQ1GaqFacj4F616BSY2n5V7DPxnatAO6xrhnYW4uioGts5KUZKrS
        Gn6zdbLPLV8Q7orADOmpwaTbET/KxularARGDh643w==
X-Google-Smtp-Source: ADFU+vuszdscU3XdZ57aAT25416d0k5sPcfl0mAi5hLjgkEZHNfu0Lp82aNKZ+W0OfmUblZbN51k2qpZO8MHLGW1V6A=
X-Received: by 2002:a67:cb84:: with SMTP id h4mr4854919vsl.85.1584009889300;
 Thu, 12 Mar 2020 03:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <1583377666-13378-1-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1583377666-13378-1-git-send-email-christianshewitt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 11:44:37 +0100
Message-ID: <CACRpkdZgeA-qgWckwAH2_6nqqwkbxfTa0so55mbKJoC1q1O38A@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: meson: add tsin pinctrl for meson gxbb/gxl/gxm
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Vavro <afl2001@gmail.com>, Otto Meier <gf435@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 4:08 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:

> From: Igor Vavro <afl2001@gmail.com>
>
> Add the tsin pinctrl definitions needed for integrated DVB hardware
> support on Meson GXBB/GXL/GXM boards.
>
> changes in v2
> - fix ordering and numbering of uart_c ping flagged by Otto in [1]
>
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2020-March/015906.html
>
> Signed-off-by: Igor Vavro <afl2001@gmail.com>
> [updated commit message]
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Patch applied with Neil's review tag.

Yours,
Linus Walleij
