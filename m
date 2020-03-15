Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FB5C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C142206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584264495;
	bh=k0MY7Bqf584jeU9PbEpBAMYhk0hnAtxUjrOw1PNGQHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=O6K/iZ5+95f3dgvMNuJn6mxF3Xy2x2Aw08mc3gqlo0538D879GaQzhZng8skE1N2y
	 ymojVPLjhud+DaZdO+tX/f5SPTMp6N/ZGUBM1HQfDtwLTddtF8bfiw2Je1TTk3hWjO
	 uU7TJFHpBNx14p7N9F0cMOrqI/fstnwa1X8HOz4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCOJ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:28:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39287 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgCOJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:28:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id f10so15240062ljn.6;
        Sun, 15 Mar 2020 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=k0MY7Bqf584jeU9PbEpBAMYhk0hnAtxUjrOw1PNGQHQ=;
        b=Sx43VyZaq2psJT9xqIVidcHL3h96etCE7IVZacPBNdfwm1ykQfiCokV3MGbXASTucf
         d9kaMtFyylnFJ3xX2f/J5w5/35NG6F+ZeaHxZt0Sadpwbvume2jt3NPzVZ9g1cZY/HBB
         rtH5q3SMNBhds3/yLS4ny21+ruxPDH1i4tqAPqBqVirMMOW3+4LThDiAs5+MjWMBad8o
         isY3i/ywS97tlSH3hzgOD+3FKgzGiewOx+CByrS6E4BnVmKrNfa+ajysQa3xBErDNr5s
         SL0FywuSsdV1EfufhjaE/34EnTd1G0IhAj99w3QVYlYPsSzIEcmT+NIGFV2Xqbujl+gh
         0qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=k0MY7Bqf584jeU9PbEpBAMYhk0hnAtxUjrOw1PNGQHQ=;
        b=SElnOu5HNOA+9Ll4XI3x56EDoIFrynVoxC0B87OxlUPYiCGxMXdDNORlpP8XxlalHT
         EDQ3yFqtBpW32Rg3qMisGGKZQIbc+ZUCzfAmG2dD38z2fWoNPmul9zCaWjJEkV8luBej
         S4g/ZF0ZRPFukxGxYwPWwQE8+0hbZ9jwS2/6nX8p77BubfolF2dZXlhyZRlOENWh3NId
         oUr1LOox/zm20zI4vfYnCZnSrfyp9n/k/Kznt7oRVZDX+9V/CvdkxLoSaF/2Uw3S8x4D
         iJAxRw9QV11mdJb7A0aA+7XxMmGFYEf6e91lysJURKsXSF0dlCpSqmFi/Qk25NXyrG8p
         UV1Q==
X-Gm-Message-State: ANhLgQ2ymQQZm4teb/j4SHTGWYSL9fR3sYYZPGszDdtwYxyuDiWhrBfi
        k8sZTQRAEIXZqaxebDBJLFdTM7jt2E8cyA==
X-Google-Smtp-Source: ADFU+vvXjsjBwXRjg6blDRN9dWbFmFP0x6cQKEKKsY3Lzbg80fvZNanN8fszf7hNtH4/g9dBOm89Jw==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr12762955lji.182.1584264490463;
        Sun, 15 Mar 2020 02:28:10 -0700 (PDT)
Received: from saruman (88-113-215-213.elisa-laajakaista.fi. [88.113.215.213])
        by smtp.gmail.com with ESMTPSA id f23sm1708531lja.42.2020.03.15.02.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 02:28:09 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/3] devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3 clocks support
In-Reply-To: <20200301212019.2248-2-linux.amoon@gmail.com>
References: <20200301212019.2248-1-linux.amoon@gmail.com> <20200301212019.2248-2-linux.amoon@gmail.com>
Date:   Sun, 15 Mar 2020 11:28:05 +0200
Message-ID: <871rpuezmi.fsf@kernel.org>
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

Anand Moon <linux.amoon@gmail.com> writes:

> This patch adds the new compatible string for Exynos5422 DWC3
> to support enable/disable of core and suspend clk by DWC3 driver.
> Also updated the clock names for compatible samsung,exynos5420-dwusb3.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

doesn't apply:

checking file Documentation/devicetree/bindings/usb/exynos-usb.txt
Hunk #2 FAILED at 84.
1 out of 2 hunks FAILED

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5t9SUACgkQzL64meEa
mQYm8xAA3I2/YauH6uYkFBQvDNCN3vk3Y9Nd7A0OQ7+zhusbeqhl93In7+YgQ+3r
gvXux2DHyL121EUbI7Fj398cescSm4FBgnhlVx8qhKQFn85vPBWtCjI8vvS+PIxn
S6+emDEeVhj0FF8mfuVV844SqIrz7UcIg9hS9PMsrZLvh31cFbgJhAKhR84ak4lr
jku+TUy2tf9ZJr8DU8DUH8dRWccCRZJ+RXFyNAfaMZ3aNJuI6CS5bGTp1LBL4alh
i4G3NgBIk4JStBxezp3AZuJ5yYz3yHcgk2paMSKiuZoLJ+12KiLwxIlY70Mo984P
8XI9oP6xVTreGY1KGR3I819s4qAjCley7q1/2eFiO2i7B4JMbn4724lExPUpEaPy
qBtoiOmN4cYBPaF75RGCJEZmgM/+yt/CQHWEowEQRHSaoQ6iqUBmyOjZhAh03fA3
8Bg6Mfs2cJXntvjNSLneHTzbOXbh1F57UCh+cWJNk7QOag/O95kd5N4IZJ55CWD6
BnAc4yMsl9aOGNLYqwX173WqeOUHm7r6MQ+vXxp24ZlBT0Z9x9OfPmN6BGXPXJyA
OFgkjJacY7L6pTWhVMPDReQ0SkXpTvqBZVGxYaxAROVPg/+Do71j8tiUwESQg19A
1k/AH25xxfy/4OvcBqCwpphqRwzxuOvc6/+NEwXFiBY+oJdTnQ4=
=uud3
-----END PGP SIGNATURE-----
--=-=-=--
