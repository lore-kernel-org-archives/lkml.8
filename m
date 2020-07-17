Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EECC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C35220829
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AM9BWjcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGQLb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQLb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:31:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE799C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:31:25 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b11so3415821lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNEkiDjRHZLjrSjApuNKMS+b0w9T6h8fgeM/XXNJlU4=;
        b=AM9BWjcv98+KZlbVQQnp9h2/TAR/8qQnvV5Me7RxUOcqk3A6uzv3LmPAvD2USaVUEy
         cLe8NTPN4dDUf5T/T7QQbIIKd3VmiF+zuwcRNUqeSpMP7glwqZs2XAbDC/2H1/plDAt2
         kZlbPXdyP1jj8jGZE2v5BJjqMjHdzEUeo08bssuqwZp3mNmoY5H3x99leh4FQq2YdBzs
         bQRwf3CQ221rQVp3ybLEhegCxTPqARQuqbSYTAUeuX31k2N8tqarwJR63VV6Yx19mCMV
         6rrgwxrpZEMuH7hEi0mxufCBAhrRK30uDIDmuo/Xm43pg0WseBBK4ij2B7caA3RLT+/Q
         RGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNEkiDjRHZLjrSjApuNKMS+b0w9T6h8fgeM/XXNJlU4=;
        b=XLPDzy5M8ucWn95spBZJfjnKzFkJIzSrjXoLDzQXizSGRB8VNt6GB4jZZfcW6SKJNh
         5TM5WTgx9kFBDlUWsp7Azr4gHJwwCUv6pigD5TQFBAPzc5d+19dYV/uVKzQGi/7nAHYZ
         5uvYVdTYCb7vsh4Xp1OAMzd+MWWVAn94dRA64PlE8ppY4IpjohE8DmkCx2C9N9s84ZZ2
         9zc26iYtfWcErOoaptLEIvbTkputropl3uk9RkUfu0AdKFMcsYsGdoajHByqeHKve9OW
         hjrmvpV4rW8CYGa9PRrO6DTkWSVwfVjUs7O9gVE6rhjaIdm6kOPcvTMYnH3N6Wn5wUQD
         MvSA==
X-Gm-Message-State: AOAM531JXcZ/8+5iVyP13tJ333/UdcaPJ5agu2z88YrV2V5w98CIseAA
        RDkVeKn4nu3N6GgXXDECuWiDPa4LSyYMJD3J//8TPg==
X-Google-Smtp-Source: ABdhPJzQrwfmXRI5GvyLJ45Awt0ZiIoBsN/rni73r/Q+iR0qjV3m6kqN0KtjAHoD+7g/dvWBZXgGFcPS8++J/NWTlSI=
X-Received: by 2002:a19:203:: with SMTP id 3mr4477596lfc.77.1594985484191;
 Fri, 17 Jul 2020 04:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200713183541.36963-1-grandmaster@al2klimov.de>
In-Reply-To: <20200713183541.36963-1-grandmaster@al2klimov.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jul 2020 13:31:13 +0200
Message-ID: <CACRpkdY3woSgK5bAHxY6aEXe1Hx5Tpxa+0hyA4T_DiFOd5HjXw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rockchip: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 8:35 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Patch applied.

Yours,
Linus Walleij
