Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A249206E6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585467843;
	bh=NKSbrd6NmaTsJRQmOcq29J1U+1WRQTw1Tjw0bO//oL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=vQzM2iczQ67qjp1BgBFyjN5gb+8Dcb8dEQ6jbMVk3VKFEoxvUzveAzY0q0/dtRR9J
	 BLquQG/lfPWk58i3FXZpn8f5fJxxwdDkRy6pzQixrBQRYaOQpRvHHenQWHkbY++RYu
	 5YvP5wKO5oCkDYoqB9P1ioSRt65uuVP+Efi3orKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgC2HoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 03:44:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43355 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgC2HoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 03:44:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so14450016ljn.10;
        Sun, 29 Mar 2020 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=QLo6fVdvEqGq4fqBM86otIAvPA/b4/SI1Ijm5GUnxlY=;
        b=TZpTIz6r5C6PFXffKCzHlr51GQjmE/ir+44H90ZVLXKEqaDP4YTSygDbrrjsRub5Es
         Djg9fnFQDxgseUy3La5ivRYSeXn/wPC85zS4alwBxxIY2xwxDA7Ry5fhVCNwvKJ9KZOy
         +7Z9EakYUzGtguB1H5l4Rxa2c7wgk/pBYzv8XYQ7zHOe0siOu2aNf2TXLrn8nEgAj0e8
         XL2KKJ3938HaiPfWojn0bfXrAI/mcCV4NNPb6z08xaDHVQG+TKL1IJcGj+LJY58yPFQj
         AHSQYKX2t9Cx2IaprCbzu6iFTTQ5koxtfVSvBOhFAOqBX06zQHvDtTp/pYuEYNKj8x+l
         pCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=QLo6fVdvEqGq4fqBM86otIAvPA/b4/SI1Ijm5GUnxlY=;
        b=UbsFZSrjgYRqGnNt4lwigElsshiXWuEsudJ811TuEaJix7Jce9QJFVEvKAZ6g4OHbF
         lSwq8gok3ePLlvhmfdhdkp/Ejk4DvB/dAycL+Nakc6ECS5oZ1BURRxFJvx7N9ajtLcIl
         GhQlho+en3aglUDO9JeYc4+k0Opiua09Qi1z15Vw4OiElmCzxDd+cRxrMvc6KaY/vGNx
         kp0ixhjJK52wr1WHpLm+HPjVttPQWKqT3RCdogMRNIg6+uyJlC+TrxcJxqDnJXhgxtBB
         5EtqxcJb32WkOdw2Pt1nRtnp5EP7yZaz8kFFs+kL/9UITs1S3BdXwV0X3typGwxrC8cT
         r+GQ==
X-Gm-Message-State: AGi0PuYEurnKPXWd+UZmRIOY4vu4FJ9xcuHPpTZZgZHpuGTaCrU1EDoz
        mByGAdzMuu6zGyMBkP5Qzro=
X-Google-Smtp-Source: APiQypJ7Wzs5sM7AKqnv8tOf8rAveL3EdbT+huVavBPWHJJu6l5sgHJ7E3y4I393GNC2vTHWSSF0Hw==
X-Received: by 2002:a2e:84c4:: with SMTP id q4mr1246033ljh.206.1585467839412;
        Sun, 29 Mar 2020 00:43:59 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id i190sm5737708lfi.7.2020.03.29.00.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 00:43:58 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ashwini Pahuja <ashwini.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH RESEND] usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete
In-Reply-To: <20200329011246.27599-1-natechancellor@gmail.com>
References: <87zhc0j2qi.fsf@kernel.org> <20200329011246.27599-1-natechancellor@gmail.com>
Date:   Sun, 29 Mar 2020 10:43:54 +0300
Message-ID: <871rpb4nd1.fsf@kernel.org>
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


Hi Nathan,

Nathan Chancellor <natechancellor@gmail.com> writes:

> When building with Clang + -Wtautological-pointer-compare:
>
> drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
> address of 'req->queue' equal to a null pointer is always false
> [-Wtautological-pointer-compare]
>         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->usb_req =
=3D=3D NULL)
>                              ~~~~~^~~~~    ~~~~
> drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
> address of 'req->usb_req' equal to a null pointer is always false
> [-Wtautological-pointer-compare]
>         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->usb_req =
=3D=3D NULL)
>                                                     ~~~~~^~~~~~~    ~~~~
> 2 warnings generated.
>
> As it notes, these statements will always evaluate to false so remove
> them.
>
> Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 dev=
ice controller IP BDC")
> Link: https://github.com/ClangBuiltLinux/linux/issues/749
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

It's now in my queue for v5.8. It doesn't really look like a bug fix, so
it's not going in during v5.7-rc

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6AUboACgkQzL64meEa
mQb+NBAAgxNIBz5VX6oLaK6CuxSluSXwopfuTbujEog2EhExzl/SGSN6CIayVjjg
Pt9GnJrum+oUZ86rAaK9nzVNOILvQ06+DfjzoXLAdwFM8ceG+gdp3cHjmMYI4HN1
HS2IhTP/DEOfTIe6iyIQVI2JHnOnYnxWvfcnmwgcu96ReLX9Wskm9b52SlwEdlwi
2fS/O8m2CFh8ES31/+LCUdqVMOhhW+qaXUZzQtkVevxlLyRrkklCKqrys/SBvmTu
yxpPxhytSTfSkXF5dSMT4M8G+ySVIBrA3MlCMajj2BgAG6JIdtaBmN4t/hNuOOqt
ncDuOOS5A8V9F9UJe+H5fSP+3kpmxmoyrJV8/rNILl/W8LYuE1IIg1mEziI3J8qz
mfE6s/8JGXmpdFgIOJijx5jsKmGC/YH1K43DzA5Ji9XaveUc3qzSF1PPM85f9TQC
6Kl7D9FMqqgeUbf6o5rr3+6RvCni9fsmP/Te5LR5aQ9K7Qbg4oEefuV4W14wKEZZ
LqbdVM+V8ITaffJso/xvs6r6xgEZBjisx0/H9sppm/5P5K4w6beVx2Abjidq7IMc
HPP+W/O4TZd/SI19VRjdoow4nkK6dyBFg5j//6Akmp4bIXcqn1qBq2PWgwWVHQc7
lXZOXWSNVSyUvURVGdGSHdi2XX2WprjsbLnKtCwpVkCQqHGK6ag=
=Tnnz
-----END PGP SIGNATURE-----
--=-=-=--
