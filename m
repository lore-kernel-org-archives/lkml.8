Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E8BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E872E206E6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585467533;
	bh=nmrrAYfVEzsqFqU7BQ15GFfiG+yun3zA2CK8iQdAQFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=K4PKyx2982RCg4NHn4wnK8DIQn9tyiTZJVYlNjSnntcLa1IzIfqcBlGP/kjUgoJFO
	 QdaRY6mCUvNcOYDtdtE/U2TJOh+cwgunGWIgXeA5TQ1UBQRfOPSdvL/1UYCGFjCNAf
	 a+oD13XF7FRp+P9VzWIV+QBI3KZRNebDiNUDd1Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC2Hiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 03:38:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37575 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgC2Hiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 03:38:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so14531558ljd.4;
        Sun, 29 Mar 2020 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nmrrAYfVEzsqFqU7BQ15GFfiG+yun3zA2CK8iQdAQFo=;
        b=vUkO5Br3+j9smAk3sxUis0Cz1x9A4Ia+XO3h/kqEP/KMQU1oXk+xI1HW15E7V4cvSL
         DszCgHhVgiEU69nvCkkPvT+WRo5p5ux7ggTvEPH0QFEFSfC/OLhGIERjGxmzpiZPMRJP
         NQeyYd+eOcjsIf2AXBIevikgix+lOtuJntFTaOoFtYm03vsdD4AIp3/OclKye9Ai4/Qx
         VrdwBGEdK2CtMxD9BgoKFDe1i0QwFiOD7tjRriI3gRBTwo4vjHjmUyxCWj+jRlQj6zi0
         NL3MrTNn9klJiLtzXEwt6B8O5nB6tc0KO0y43aY60ZWpVBMfY2gCQzF1LfuWKbz2u2dx
         QbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=nmrrAYfVEzsqFqU7BQ15GFfiG+yun3zA2CK8iQdAQFo=;
        b=RgU/1ZSDrPSMvooABOXTk9XpkjH6RWjSYULc8jJey72Z3Q9O7xViBY+Pqs42WN8DbC
         nXwVawGR8UfkIFLqZ6BwhdcO+k6Xi99exrPw8FieKgersz49dOkGadSiKJrq625v5X+W
         mvmnBM2Bf16CMKgplEpJ3Cm3LpldgPetHrhiMTtKhRo5KWR20YMzp0c+OnEHfDy2cA/B
         G+x55pCFsTTyEk8dEHyUqv4/+7rISQx2sQGGkQjkfUreqKeuBptPRQwe8iaWVGZvwLwV
         pV1OM3Gnb+TfUkt0uE4x0AZ8Z1YJyT6dqKeUFVCpky3aY3YIvSGhL97Li6zx/DuVFqTv
         nkjg==
X-Gm-Message-State: AGi0PuZLU0i9JfdIXf1cGs4KdGXTjvpkUf0K56QNDtrOWy7HyTk14ZFt
        UhPhbj/Sissrx2neQeMKgPumMAk4IBuw9w==
X-Google-Smtp-Source: APiQypLLu3qcqBRxOgcjs2usRagdq/INw77TTMj+efa7knJdkpkhCGW2WS2p7Er+MAPsKlIncu1Z9A==
X-Received: by 2002:a2e:b04d:: with SMTP id d13mr4088141ljl.278.1585467528898;
        Sun, 29 Mar 2020 00:38:48 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id a10sm5689013lfg.33.2020.03.29.00.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 00:38:48 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: Use the correct style for SPDX License Identifier
In-Reply-To: <20200328111112.GA7219@nishad>
References: <20200328111112.GA7219@nishad>
Date:   Sun, 29 Mar 2020 10:38:43 +0300
Message-ID: <877dz34nlo.fsf@kernel.org>
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
> header files related to USB peripheral controller drivers.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
>
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Thanks, it's now in my queue for v5.8

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6AUIMACgkQzL64meEa
mQawYA/9Hbd80EhX+J5aV/4oQyE5Jibk/WK9fgAIsH6zfZ8ghPYFexbb7TFBrtGG
zS5OghuXHaVvNYvC9bS8Y2Hd2cSU/BwbYoiAqHBwgIY0/NZhu6F+c7syBxGwLcPE
y4wG8FDXLIsJd3J4lw5qij1BnGHsIjTuksWP67gRFnw4bZydFBnwU0oMVSoZz4eD
X//28JxDpRM4PAyWq/ndRMY1eL63p/kr2l1K9QFkdqA1xDCUll6X1FnWtdIj8ifD
cK1BC2h/FaQvl+dWTE2O2CwG46uDqDMtNRdOVhncL9wAQyGfP/9X10ZRn67XOdAZ
5vov/cQHjyt+XOyMxC8YacTG5nuKL6gJNvEKOcYEkmOqfOAHrfI3Yo6jriCZal/w
1UFPohw+3fjeVL0MSUglbwss7yocbAeVRjHsK4yy+5NnJhZvmv1m9Ee0Ojc3bQbB
svEM9vPzU7GJ5ENMCYd356ypTE1aFzRqvneleDbaNJwbnapa7rnL8JXpshzG5k57
HTGEGn9qgKD6tBncCMuQlzNhwFaRfEOQk/ZbhJPs9W4o2j5Xx8C5C2sLH73ikIWl
K8D32b78ZPfiab5Ltmn0baQ29BH50wp25dqyD+bBhlRgQmkLJkSXbdg0d1VCl8ua
QxaAgUuE4oq0zXjLyPmykG4LiokadeHBL4M12Vh2AfuKXs5aQoM=
=yrIC
-----END PGP SIGNATURE-----
--=-=-=--
