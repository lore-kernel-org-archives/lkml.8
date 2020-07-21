Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A24C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B6E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595324032;
	bh=tf6ZMhs/JC7o39Wk5Sgc0mvXEIqXB+JBcQ4m5d951NA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=tLZ1lj6YOHHtf8oLNJN1hAM1QT+TuW+I2IuzHb6TawFOE1a2z5QmsLFHBoUt1yIuy
	 6DYK3uIxopeXFn/jakW2p93XUVUtCcfxB/Qm0YBGCroGHquYeccK54djncqWVRaI47
	 eqIOBclrh8XXSAWx07nLRRr/tO5JGfqLILCj2em8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGUJdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGUJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:33:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA3C061794;
        Tue, 21 Jul 2020 02:33:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so23315758ljc.5;
        Tue, 21 Jul 2020 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=H9OhidrR5GwaDx7LdnN3XVSRHXGq+Bmjj5l/pD+T9jk=;
        b=SDQlOZ7bFq09vzSvuDSYV9oNaEPZIPUFqveaPvO0TRSOX+5d0R2A98aKiQlnNHSpJr
         ru7KWvSzwpA7AWMpbgT7htw7RAeanCgFn5bVMuvifU1hSDuOm4CMFwIgmvgmOI1tz6yj
         5gg+UdnUCQLYGkII0/8KcGvBEXmsni1VA8msdS6cNBYIaoDs86AcZ0fpRe9jEsvx+OwR
         jqnboADHN0e+m1w7eSpt35hHWdf4OI0eAJ/sane8+LdJGdNSFKAG6COEcwi9c2xB20VD
         qs+WS8Bs/aW5h3oX8OvXnlPr7NTJqpGVeE96DRGSRzijjpDhUqEai/b2syF2qwqMM/iv
         ZPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=H9OhidrR5GwaDx7LdnN3XVSRHXGq+Bmjj5l/pD+T9jk=;
        b=YFldZTHOuO8Gl50UChT2C/HGWt5ub/fWuHm68RK7qjANn27mK+ssxUISLU9dkxwv+L
         bOkkyvoTuXbec36avcbIvTHW2jOZCHnIhdWIxCyx3oQjk9Q0a6ZSK+aqKCBSApvodVI2
         WCKnK7QV86GLGstmWfBUJzyo3ObtXukGlHVz2SH5J3P6OUnjYDWrU7Zs/yUUgc9yEeFA
         dhBzffXX0Y2dqb0JeMh/FoBnerZQkh2rdNbH83+fetNQkL5XBXPNlwjWzepYOadKtC+L
         y11PeaJrdTB2CLm4SSYnFtr/5XsFdM88cxsgFRrAXM30ZLy+lM0x6Riyc1c6+2N9qnxH
         muww==
X-Gm-Message-State: AOAM530gqfJhSCRtWOzkjVPQCU996L2mt8Tno4DiDTYmva27t53aueRy
        I/h5+/LifwF1pHEzSY7cVznyxPmwJEjEmg==
X-Google-Smtp-Source: ABdhPJwcw0HnE8axTsimOyA7XwYSPXVkGvMqpHntMdEsAtB+Fs0AFylRhtLZhnw3ra+Kcy6QbmCoWw==
X-Received: by 2002:a2e:9855:: with SMTP id e21mr13129280ljj.424.1595324028411;
        Tue, 21 Jul 2020 02:33:48 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id m1sm4960969lfa.22.2020.07.21.02.33.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 02:33:47 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: Re: [PATCH 0/7] usb: bdc: Updates and fixes to the USB BDC driver
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Date:   Tue, 21 Jul 2020 12:33:42 +0300
Message-ID: <87h7u1p5zd.fsf@kernel.org>
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


Hi,

Al Cooper <alcooperx@gmail.com> writes:
> Updates and fixes to the Broadcom USB BDC driver.
>
> Al Cooper (4):
>   dt-bindings: usb: bdc: Update compatible strings
>   usb: bdc: Add compatible string for new style USB DT nodes
>   usb: bdc: Adb shows offline after resuming from S2
>   usb: bdc: driver runs out of buffer descriptors on large ADB transfers
>
> Danesh Petigara (1):
>   usb: bdc: Halt controller on suspend
>
> Florian Fainelli (1):
>   usb: bdc: Use devm_clk_get_optional()
>
> Sasi Kumar (1):
>   bdc: Fix bug causing crash after multiple disconnects

What should we do here? There are few comments which seem
unresolved. Are we getting a new version?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8WtnYACgkQzL64meEa
mQbgmRAApjEv4sPoy9DHfKAs4nJ1OcfivuXfGsdfBWCG4IJweHKB+MPPZLVwam1/
w61d4KPH9EZZl+68JQV8Z7CoDQMEa6hKhf/12t+xhxdagBLhJbANQ4TpGuL2/QRx
jHR47DvcQ3P2GbDiqwEuTP01XZuz1g97Bp9TON7KlKq7hqr5pCR8m/DUCLI5ZIEe
W9dQKwDhRR9zmpptkh1JSNRdQ6F0CAucCtplxPrfg7FdoxBnr4m9nwZkWgcoe6o3
IAoZ0UbEuaEHEnsBIiiJ3kWL1w7d/JClEC01P3H2kX+HUYvrslYGm1tvlyx/eXUB
p4PiXz601s1XheCOFrgL2wkT5TjX+iGBnDdAZV9jAWR0vfH2zfbdq4+xqchAxsqv
t0zHiTF6U2lI+J1VJXNlpoXz7LesgMawv9OK8euvHW0fvYQOM7QW7BO9Q3cb1PSm
oQZj/IqLM8InIylbxwA8ucs7sMj2skkLwgVHpolAjRWEyqSh8d2WQq/QWGC2gsni
4fg4w5Uq/bzQ+lDw/zNu4zcCyigSGZdJSD0MjvjH357ahWGpopxECKdU7LrK1XU4
GF6Vndt+TG/TRo/1jVdjhQAw6i2bKE3NFV0du2OW534I5yLneYD42L4QTMiNaoc6
8SkaibwYayTfO0x6ckWdaW+VU7CIg/z6IfxgaMd+T/Rdjs6zzeY=
=FSV/
-----END PGP SIGNATURE-----
--=-=-=--
