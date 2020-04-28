Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD0C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDFB206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6oemS2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgD1J4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbgD1J4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:56:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CCCC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:56:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so20785112lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dUYMvHNm1S+cpRAgh6CuSzaN8QMyIl6tpzVnoQoDNsE=;
        b=O6oemS2LnyyWHZ8OwOVA5KOWkg8pK08yWXcrww9azpSPIXoqcyZUqaeM+3xVi2ke0u
         +N6PeCK3fdOn6+nxTApK1Ve3c6+2SjX3uanr9QyJK0/7sHiR7ZSG3zOTztgcd/ym8fXa
         o1c6DSg/BSnqC0YDotD1dhY/RN0m/4GXyeUDpgX2b8XUHT9ZLKC5d0wy37aIV2JR2ANF
         edfFxnlJhe5pdtlMc2ZMCQZL0m2MykJTd5yLS1+DHzNuoUFcICYI/41mUidjkTSbpuoD
         9jH0Q7n7ugThfQG3sHPJfC7kpdAmjVEmtmUnEtLuu3ViKE03MeHAGm3FuPRkK6ZQeNTn
         QPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dUYMvHNm1S+cpRAgh6CuSzaN8QMyIl6tpzVnoQoDNsE=;
        b=AobdaS4K5Qj3KSYPG9PAKYs6SZHc0nip78sFFg2Z3z6lyL//QR8zaWBOJ8MH9954qA
         RatlHz7TFu0S02PDHogr4lVE7V8rNdzluC7vTZrVVCE+8OPWFKHId3u026LkIBLh8kXo
         Btwz0RjiT2LN+WUzi494XW7UApvKWMgUacqVlqe/X5gOMWND+sEJaFbTaQs3hH753/q0
         Fl4wtjnE3PCRy+Fucqq6bv+zCHddCDPQWxpPN+m/SoMLIG4GJ4CciRJtxuOcWi8WPmDL
         gc8C/7draFmdGljO/wOIeZtq1426G9xmZEwfkXvB2SHNavhO6KBrYEmwuntec5iQUQHf
         qDCQ==
X-Gm-Message-State: AGi0Pua1RhMBTWaj3QHFkwSyiabUGBAJ2Fa2o/Enmn6+7sXXZX5DommI
        SRZQIj8PUExtCC+P70xkk5ECi3UQnIjEeUxUSSel6Q==
X-Google-Smtp-Source: APiQypJlwiuxB4ab5wQqVxYuJTJqT6PIowMT3AHLQ+WNf0e2mYCYXwqrwm6FFZORaGA6n3AkLGy307SzZEMgXnQ6Ro8=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr16549672ljo.168.1588067796808;
 Tue, 28 Apr 2020 02:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200417073512.42350-1-yanaijie@huawei.com>
In-Reply-To: <20200417073512.42350-1-yanaijie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 11:56:25 +0200
Message-ID: <CACRpkdaH1bet-iBxB7pM9-_swpXkuUiMeg6jwTyx2j8WiB2G_g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: db8500: remove some unused symbols
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 9:08 AM Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following gcc warning:
>
> drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c:899:20: warning:
> =E2=80=98sbag_groups=E2=80=99 defined but not used [-Wunused-const-variab=
le=3D]
>  DB8500_FUNC_GROUPS(sbag, "sbag_oc2_1", "sbag_oc4_1");
>                     ^
> drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c:570:23: warning:
> =E2=80=98ipgpio6_c_2_pins=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  static const unsigned ipgpio6_c_2_pins[] =3D { DB8500_PIN_G3 };
>                        ^~~~~~~~~~~~~~~~
> drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c:472:23: warning:
> =E2=80=98mc1dir_a_1_pins=E2=80=99 defined but not used [-Wunused-const-va=
riable=3D]
>  static const unsigned mc1dir_a_1_pins[] =3D { DB8500_PIN_AH13,
> DB8500_PIN_AG12,
>                        ^~~~~~~~~~~~~~~
> drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c:453:23: warning:
> =E2=80=98modem_a_1_pins=E2=80=99 defined but not used [-Wunused-const-var=
iable=3D]
>  static const unsigned modem_a_1_pins[] =3D { DB8500_PIN_D22,
> DB8500_PIN_C23,
>                        ^~~~~~~~~~~~~~
> drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c:430:23: warning:
> =E2=80=98kpskaskb_a_1_pins=E2=80=99 defined but not used [-Wunused-const-=
variable=3D]
>  static const unsigned kpskaskb_a_1_pins[] =3D { DB8500_PIN_D17,
> DB8500_PIN_D16 };
>                        ^~~~~~~~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

These should not be deleted but used properly. I've sent another
patch fixing the problem and adding you as Reported-by.

Yours,
Linus Walleij
