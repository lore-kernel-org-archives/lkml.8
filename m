Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31DA2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590584210;
	bh=erY/IwqgkO3Saa04fysngd9fsuKr+NX9GqJdjsQjRF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=mK14ho8r5gLgLQ9L0BGYqqIRO2+wF8U45XWnvZ6dzIBS12kzQpOW/xP53OmubDhbE
	 EuVelQfSs3B8G6IeHd3jlBPpIwEcAuAK5K2AZzrMcXdW+AcNh5XtZEC1tFk96+iKnG
	 ALsI9hQ0Mywi5f2n1kjBTuvVBE3+WZduEtxgTa64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgE0M4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgE0M4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:56:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C1C08C5C1;
        Wed, 27 May 2020 05:56:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z13so19098334ljn.7;
        Wed, 27 May 2020 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3vGPAEN7EbkXErW9fSFtRny4Z1vag3pW/OLkpcJ4DRI=;
        b=Mr2coyS14UPM1YA2MC9vEyzwVu5iP4fzdum+cFAUe/8X9S0pgLoTIoGj6bdxCvljvs
         OR2TzhIdbIrASS6tdBBIceaqzyzw2fzC/IQgZ9bBg/22zKJ0fXytoUy+lIdZ7lQFCQgq
         jLUuH0WYDLxxtDhTb/66gKClmWBKt4St5ex1KCjCYssVO+FkIvr4kLQIzLCFDsiECyla
         0DTRbVC7xAuR83vo+nY0frHtSmpdHphoKUF9hXg+UlungONT8B/69caFWp5fcTINSnDa
         AapHA/dKF9IkNTslv627nuwU+HAJPfVk8qScTZSVgfCSBkiA/ZjAHsu020EkWdCHPBQL
         M93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=3vGPAEN7EbkXErW9fSFtRny4Z1vag3pW/OLkpcJ4DRI=;
        b=LE6s4EAGwUJ1I2z/GzlfCUsBWdGQJQGWxjo903Deq8/yrMbZseLEzwIJEFFBBDS48j
         1CAoiiFro3IUa1+ORoE9bdokJeO0LuKmGe1tND3+RRxYqhHYAq6aBd/BVAE0K6ZRbj4o
         fybAYVIIXEyrziRmeSfknY5WF/hOeQ6nHs1M5U42ZWISAP5M1FZ6C5hVeMu8IZZTTP3b
         ogi9QgU9HzQe8dJKecjnrqK9Z2IQIWeh7RQWpheycWANHyy4LO1nWwXGBHd9BukK8Sek
         9zikPgsXruhxdp0t5Bm9JlW4AmmSR4Ict7I20EoE3RaFiJhrWxXp3yim1xDUmzH+WLHn
         Bfow==
X-Gm-Message-State: AOAM530cyhWAaOBC6QN2hdwOIbJq8GDFRnT/vAfeLkrIBtyG0dIX5zKq
        RwIHITCMx9m7za876N9wqSRV3BWvqwA=
X-Google-Smtp-Source: ABdhPJxtvzmXmbURkG5ELpUsVYJeCfAoLEjID1fDrWld7TIOVChr9rYSaLDVBxcHfTbBmJq6HA8+DQ==
X-Received: by 2002:a2e:596:: with SMTP id 144mr3191505ljf.364.1590584206551;
        Wed, 27 May 2020 05:56:46 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id 23sm800224lfb.1.2020.05.27.05.56.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 05:56:45 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        hanjie.lin@amlogic.com, yue.wang@amlogic.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH for-5.8 2/2] usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs
In-Reply-To: <20200527085315.GA168054@kroah.com>
References: <20200526202943.715220-1-martin.blumenstingl@googlemail.com> <20200526202943.715220-3-martin.blumenstingl@googlemail.com> <40a874eb-1a2b-533e-ee3e-bd90510abaf9@baylibre.com> <20200527085315.GA168054@kroah.com>
Date:   Wed, 27 May 2020 15:56:40 +0300
Message-ID: <87y2pd1qpj.fsf@kernel.org>
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

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, May 27, 2020 at 10:17:31AM +0200, Neil Armstrong wrote:
>> Hi Martin,
>>=20
>> On 26/05/2020 22:29, Martin Blumenstingl wrote:
>> > dwc3_meson_g12a_usb2_init_phy() crashes with NULL pointer on an SM1
>> > board (which uses the same USB setup as G12A) dereference as reported
>> > by the Kernel CI bot. This is because of the following call flow:
>> >   dwc3_meson_g12a_probe
>> >     priv->drvdata->setup_regmaps
>> >       dwc3_meson_g12a_setup_regmaps
>> >         priv->usb2_ports is still 0 so priv->u2p_regmap[i] will be NULL
>> >     dwc3_meson_g12a_get_phys
>> >       initializes priv->usb2_ports
>> >     priv->drvdata->usb_init
>> >       dwc3_meson_g12a_usb_init
>> >         dwc3_meson_g12a_usb_init_glue
>> >           dwc3_meson_g12a_usb2_init
>> >             priv->drvdata->usb2_init_phy
>> >               dwc3_meson_g12a_usb2_init_phy
>> >                 dereferences priv->u2p_regmap[i]
>> >=20
>> > Call priv->drvdata->setup_regmaps only after dwc3_meson_g12a_get_phys =
so
>> > priv->usb2_ports is initialized and the regmaps will be set up
>> > correctly. This fixes the NULL dereference later on.
>> >=20
>> > Fixes: 013af227f58a97 ("usb: dwc3: meson-g12a: handle the phy and glue=
 registers separately")
>> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> > ---
>> >  drivers/usb/dwc3/dwc3-meson-g12a.c | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >=20
>> > diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc=
3-meson-g12a.c
>> > index ce5388338389..1f7f4d88ed9d 100644
>> > --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
>> > +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>=20
>> [...]
>>=20
>> Fixes regression reported at [1] on SEI510 board based on Amlogic G12A.
>>=20
>> Felipe, Greg, can this be queued on uxb-next for 5.8 ?
>>=20
>> Acked-by: Neil Armstrong <narmstron@baylibre.com>
>
> I can take this and patch 1/2 here if Felipe acks them.

Sure thing, Greg. Thanks.

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7OY4gACgkQzL64meEa
mQbULw//QEHuzbRomKSbPaOe0cM+/i1yGMyZAnXKQ0Q8bG+JLpSVDe8cXhRr2edg
Ilfx6m8Kt/CYIZn6zZ73MdjPtVADkkJfsNVpGD+iAZ3uww8lAIm1rn4XozjNJt/5
Jpno6KBqmXY3NXuE0HZ7LraJw7XMc01c3tSOh8T54pqeJ62aLHuxfkv+4fSYQS2R
0gSF0tCJKC5eATjzg1retNX8nUkf0h8Zi3HyZTD2iUVSYiOe5FJeGYGNfmozwe3c
shI0qMyIzCU/yFrvblfh4LANI8D938SCCgUfs8rXUNmbtdYlHcdcNEPWOh9q0ecF
/bwHfaMkNAhtjrLa/4U4kNuoTPQhZIlPfl48Smq30xw+qUvMfkij1woAneYPBvxE
Qz8VuaLQEcIBq/qkG2hQAjkJn6XoAXVPXO/dktZJjTWv2iJq2arNaGcUzB9t5RNg
h1zCj3uphIP3t5uTmLGaeGm/4NQVcTSH843/kWMEcc/eZ27/t2DZL8Zl9llMVsr7
cMIS7LWBTamc+GA2g5c2d27EH6xGnUYW9ribrXNZsZlpqFCGc0nvQHNj++lAFUc0
iOoKhst9DZYTegMOgpbHyxIJnsInJlHhXf6C7vVdL75S9O+mLm9S5hJid9baWJTO
mW78XccwWqGp5ctssvPr0e1qbflw39fQGeXAZC4acQr6W76wvwI=
=bVFY
-----END PGP SIGNATURE-----
--=-=-=--
