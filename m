Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F61C2D0E7
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F59B206E6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585467577;
	bh=evADfDgP0TU2SsCO4NfDBcKupa7OZGcH7SA5IsT+jPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=u/AG4XaiG0GwOPMKm7Un+gVHgNHk4YUOe7Dpnc53jg0baJPstfzQoD9e4QdwOeWid
	 ABmSiy6LMB+tuUcybug/5MKnxqsadk1vxs6Y0gYr0U0yGzarO20s/+R04mJHGQvqgd
	 HQeHi0mJvH3UcQ313hG9rOsx+jl575wpvRGX1h/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgC2Hjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 03:39:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45466 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Hjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 03:39:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so14509404ljc.12;
        Sun, 29 Mar 2020 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=evADfDgP0TU2SsCO4NfDBcKupa7OZGcH7SA5IsT+jPk=;
        b=Dwg8kfaizeYALQK6XUX8jfCUfSsreKteh15wihImIZAg7TgRWpzB3nvk/897YX/hSF
         Z6cs7x9Qzch89VlG0LJAdZ0wlD8zuRofPFAvRGa2RpJR3vkhOxwwtLNejQQ7ygBe2MDl
         3kYuWoyHSpTdMJEgo38jBKCQHA0cLDYpcHtAkraEZDnqBa1dXdxogQgBX5y4lQLYbtCT
         fIMs/9BDxA41z8aZSoj4f0/9zOSJowZ2X/jYSpFskoOYr203c+Dze7AwrfYAcbHfCepA
         ytvNg0dcOLG1kEKn+js1+PGUA5glpvVGkySkBxTgG+DL374V+p4XtYlUKZsj1QTA/xaW
         N9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=evADfDgP0TU2SsCO4NfDBcKupa7OZGcH7SA5IsT+jPk=;
        b=RY7fjQsOePoxcn983vhzedO1NoefBhMQuugVxbKR1j91aJY5HhYm2LarniTZHmWfQK
         abMLyUsrAJj7c2tXdTk088JiIxgssjG0aysu1Jj26ZAlGQu5wlLQDP4jtehb8IxVdODG
         zIACOlAT1gAzDBJGwk3wHvIrH61LY/OK0tylWJ/Il+qG7SAxKyaAvNQW3XnZpklfIn8q
         xJ35MkUL3SbPp08GEboQNMtGv7T8U9xZyQaOIHFw+R4QgG/JBYMC8IEvdiUvyy/ib/Jc
         rLneUasGoWqdM7WAMYthVCX6T+iq2OgCUB2ftiFnSsiKbFf4f1TbZkJbfsST/E8yKaZl
         NUhw==
X-Gm-Message-State: AGi0Pua/4ZorNLw0cT0111F+Kkxx3DxYwTnmLndCJbZmuV6nIjaNxbcn
        Lxzyt4kELwf0p/jc7kAiartozl6CH8ZI/w==
X-Google-Smtp-Source: APiQypLWBf5kBp9KIsV8NDvIPHjISYc97CIpHXKRzGdsR8z1xoET8+maZ7DUboDB9H2+9Kn9QLSNvw==
X-Received: by 2002:a05:651c:1139:: with SMTP id e25mr3958472ljo.261.1585467573033;
        Sun, 29 Mar 2020 00:39:33 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id i18sm5809466lfe.15.2020.03.29.00.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 00:39:32 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: dwc3: Use the correct style for SPDX License Identifier
In-Reply-To: <20200328100442.GA5517@nishad>
References: <20200328100442.GA5517@nishad>
Date:   Sun, 29 Mar 2020 10:39:28 +0300
Message-ID: <874ku74nkf.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nishad Kamdar <nishadkamdar@gmail.com> writes:

> This patch corrects the SPDX License Identifier style in
> header files related to DesignWare USB3 DRD Core Support.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
>
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

queued for v5.8

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6AULAACgkQzL64meEa
mQZ6HA//akc/EQ5bD7S0sXVTaK4wByAv9t4gIB61JY2Fcp4ynO+VgwC8O0/pp0nL
Z8eEo0vLmCvIROYeqPSfwT7otJXqOzBFfGiyUgy9HO8uL5wlwHdb5/X1q7v2fjeO
6vRHTXZG+xVG6Ezl8HKZJvvSwCjyGWLf0RLcx0NGvYY6w0RkUXIWNRNIVf1tscYb
o77QKoC2CBLwt1NRsvLLMcAuh/kw1+IjmH7ynrUhP4QPkFnNR4AhhUw7wTYCIXjM
G2HyfQUolKfKT0linNY5dqvIbBGqBbEILbsI2frDw09/aYU9r2tpt4ilPw4m47wF
LyKSQS13YM3STITMZXzk48pDZqI2Z4zpZDgbWCRTqXdZaEt39ccF3RDSXHL4F4oK
hYdUQX18r9D2l3DrKzSt8dZbMe++F5/o5p+xX/ddIr0063y8PIY1XQ4/yFuELAU1
dSRtD2bzQrTyjCeCtjGqL5hWZoxXEaNOQJLtK+711eKPLBD2k3m2H51k6kEtFTo4
dR+7k3TKcAMnqiI5l4prHp5NpViMQ49d+76gwfEqbPZiRujWJLYLY8pmozXne3Gr
r1Gi8Psr6+QOrXopghuCnf4tERIHTyPcEfkKrR6VTu63ogCQqzCSqej8e4X6D3Jh
rnmNNLPDUu2WbHRD+HXVIfXpakkUcZ1VdjqiB7KbiY/8P9BIan4=
=gL+Y
-----END PGP SIGNATURE-----
--=-=-=--
