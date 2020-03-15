Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFD8205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5tlozNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgCOOSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:18:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46906 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgCOOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:18:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so15083435oth.13;
        Sun, 15 Mar 2020 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIvjMCX4EF2e2/1EU9o3Lj1tLQtD2asohfX3nS6dN58=;
        b=H5tlozNoL6ddzLiyDNNBheEf9TmDbw3WnAROlN+OXNbD7RPlO13XtIPgbQ262gQ1hO
         9wGZUdGq0O8VVmGh9bN3Pu1v/O0vMyiYbhZSXB30nTHEGdbE43iSde1t3FtxVjrdQffb
         ahODA5lOPfDiGN7rdvtJFgXd7PlHZxd2lgodcrQ1t+LDAQMRLEMJgqa/gbvCex+vlhBL
         UfOGr1T7T7klHpGdFnmuuvGnjC+/+jpVTwbBiUMkI5TTaALgiHpLFwFVpYpysZXuFQ/Q
         iOicwDyzEEWfevaKNMUMZ350UbWcVJ0Ik4uw7RcDgMyXtJKBBXCAZa9v7nRc72os6tZQ
         xhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIvjMCX4EF2e2/1EU9o3Lj1tLQtD2asohfX3nS6dN58=;
        b=cJmy7X0ojsDc0TiAx3Z95EZ9nMqO+Pihkub4b159Zs9g8nr4khDHazz+QjIzhdmwaa
         ZdwNYqnNdsa5kDCfr5aMC7DmD5oKXb1kxjUClOwum5PIf4B+Lp37fVCNgOEHUTO7Nz/A
         JNZtVQCQpokMuo3Gz6DicoLT0++bEX0MV5KU6si5WIvYuCyy5yBcNm/TyFEfaczUVS3b
         9YSbtDyFJlrRcF0i5EcKiURQ3kKGoJgtEX1TVWC2p+rpGkngCbvBHklJmOifeim93aXU
         aIiHQ7+0bfBDXz2DH759kMfD5TObCoXwvCnyn4jClpJc9z02BVejyMZ1FOVMEx4Xk4ql
         ZMZw==
X-Gm-Message-State: ANhLgQ2fqELkB/niDYkim06VnlKzSS9Hs92cdhpsP7LrjkxthUyhKcsw
        VD5Scja0m/u+V61WX4JlacswyMCo62RdN9VpR3U=
X-Google-Smtp-Source: ADFU+vtJyIW+7jIrbYSqcVwYrDRZW+PqsJKAdZgliGxBlK9407U+KaNa7HYtQCepI+/dIe5ND6qw1BT0Wh/ylXmoDk0=
X-Received: by 2002:a9d:4c8f:: with SMTP id m15mr15310641otf.273.1584281885504;
 Sun, 15 Mar 2020 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200315121338.251362-1-gch981213@gmail.com>
In-Reply-To: <20200315121338.251362-1-gch981213@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 15 Mar 2020 15:17:54 +0100
Message-ID: <CAMhs-H-Teedp8ptaDvEFfye+zRsgE-n190doda3-2WkrUY=zyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio: mmio: introduce BGPIOF_NO_SET_ON_INPUT
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 15, 2020 at 1:14 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> Currently gpio-hog doesn't work on gpio-mt7621 driver. On further
> debugging, I noticed that set/clear register on this controller
> only works on output pins. We need to setup pin direction before
> writing values in bgpio_dir_out for a correct gpio-hog behavior.
> This patchset introduces a new flag BGPIOF_NO_SET_ON_INPUT for
> these kind of controller and set this flag for gpio-mt7621.
>
> Chuanhong Guo (2):
>   gpio: mmio: introduce BGPIOF_NO_SET_ON_INPUT
>   gpio: mt7621: add BGPIOF_NO_SET_ON_INPUT flag
>
>  drivers/gpio/gpio-mmio.c    | 23 +++++++++++++++++++----
>  drivers/gpio/gpio-mt7621.c  |  4 ++--
>  include/linux/gpio/driver.h |  1 +
>  3 files changed, 22 insertions(+), 6 deletions(-)
>

This series looks good to me.

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos

> --
> 2.24.1
>
