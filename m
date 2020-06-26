Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621C8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCBD20775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593154338;
	bh=JH0EwifEFWJK0ZGDKqPuMsUuzx3DE/iNpg21kqYUz64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=CZVmsfhKFRYvgommwcbruluC31sQWcycbjo+5uLVYeo+XHAJmHMhV6vxyEBZvW4sv
	 q/FJ4/BnvdngFd1kJgIcS0CMLz9YNkuulbxNgt/erV3GX4SKxRy0GIovMNmDqrFDYd
	 3rRYi6tnddvI2bvep0Stq1NAANUZk7iYGkbh2134=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgFZGwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZGwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:52:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAAAC08C5C1;
        Thu, 25 Jun 2020 23:52:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so2006880lji.9;
        Thu, 25 Jun 2020 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nFM3kop9ktvhCUlgVduYIaa6zuTPi9zx4zThaiWVhw4=;
        b=IHfRxkbi+UPUJ5N40VXH4vaoWL9sjWCW9SvCSr79xo4P5MZjTEDcIJ9sSKXrzp/N2+
         emFRcVbz+jVBa+awDJlc9nWSXvnKmBaZUWjXIRhx7+S+IDFO6rp4LNqKQFnwFv2oqwdl
         vOR6dWa6+Gbb8ySKmMpqAHI7llo/PUd25iwNxsyIDqSkMMUF3xf3lzyKjBdBUZh0u8m5
         xmOoO4hjc0KB1d9K34yehIbMZv8/iaQsjlGhCIwGHEOcfqY0+TATlSyYRCqBhLbLteBV
         agITCK1Ef0jsGz0K7fEm4+e+EWcLqLnzNP7hQTq30pWfjcMiy5FXuYEsHPH7gvYFQEIA
         pkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=nFM3kop9ktvhCUlgVduYIaa6zuTPi9zx4zThaiWVhw4=;
        b=mDxQ64yqe9QkZ8rMGU83ZPgj0ORAvVh70KCwtiZWeIdNPeGwfWIlnc1ORDYmdYs4GC
         scaRbR7yTGwuKo3dg28v5xOO3tedZnDgbwupQCmpnDIAQ3NpCIYJBofP8Zr48y4Xg0gr
         0fOTCCUKU/RrVC5y+y2tg2Ud9kS3edGLHThNQU7R942XEDKvvFNSLHntRoQ7cwtDiB2k
         MR5vyE9NXGMai3pp/kjUaUrwiytlPAJklkwcGieUAoCe/f4CGpxYXYo/BUnmXIwU0J00
         BI7hJ7RLCnKd/ti5ndsQH2hdX8RNZSZ72nlEDS1s2QI4fYS6P41rvbtgdEsdUTPceTrH
         JkSw==
X-Gm-Message-State: AOAM5303lZTY7m6EWrXaGOmA8cGDwf8sQAAei4j15+aX7TBKGl+nCUTL
        Tn3+Jsck8q4Ye+oXudw3C+U=
X-Google-Smtp-Source: ABdhPJwtp1ZLwujD1qZAwEUI67yGIAEejThjkqWU9ZqERY6mYmJv4ZrW1uPxE64uAOUIjduvvUjWnQ==
X-Received: by 2002:a2e:9141:: with SMTP id q1mr682251ljg.196.1593154333942;
        Thu, 25 Jun 2020 23:52:13 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id r11sm6559950lfc.29.2020.06.25.23.52.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jun 2020 23:52:13 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     dan.carpenter@oracle.com, ben.dooks@codethink.co.uk,
        colin.king@canonical.com, rogerq@ti.com, peter.chen@nxp.com,
        weiyongjun1@huawei.com, jpawar@cadence.com, kurahul@cadene.com,
        sparmar@cadence.com, Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
In-Reply-To: <20200626045450.10205-1-pawell@cadence.com>
References: <20200626045450.10205-1-pawell@cadence.com>
Date:   Fri, 26 Jun 2020 09:52:08 +0300
Message-ID: <878sga5nfr.fsf@kernel.org>
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

Pawel Laszczak <pawell@cadence.com> writes:
> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
>
> The current driver has been validated with FPGA burned. We have support
> for PCIe bus, which is used on FPGA prototyping.
>
> The host side of USBSS-DRD controller is compliance with XHCI
> specification, so it works with standard XHCI Linux driver.
>
> The host side of USBSS DRD controller is compliant with XHCI.
> The architecture for device side is almost the same as for host side,
> and most of the XHCI specification can be used to understand how
> this controller operates.
>
> This controller and driver support Full Speed, Hight Speed, Supper Speed
> and Supper Speed Plus USB protocol.
>
> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
> The last letter of this acronym means PLUS. The formal name of controller
> is USBSSP but it's to generic so I've decided to use CDNSP.
>
> The patch 1: adds DT binding.
> The patch 2: adds PCI to platform wrapper used on Cadnece testing
>              platform. It is FPGA based on platform.
> The patches 3-5: add the main part of driver and has been intentionally
>              split into 3 part. In my opinion such division should not
>              affect understanding and reviewing the driver, and cause that
>              main patch (4/5) is little smaller. Patch 3 introduces main
>              header file for driver, 4 is the main part that implements a=
ll
>              functionality of driver and 5 introduces tracepoints.

I'm more interested in how is this different from CDNS3. Aren't they SW com=
patible?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl71mxgACgkQzL64meEa
mQaiPQ//a7Zb3mi4EERXBszW7rCLKyFOdQYjy83WFHOxrAV/iXqGsx6KARPngoDg
1u8cCOef0xdHjXt8aP9BhD9n2yvSb0oIMZFcyw/BOPADEUN9OBqCVxWSLDTZ1YuX
O6n61nGDVkC/WWqwoiE/+yXV1MvEPV1nH/RQlh8aJa5WXe2CglkmKEJJC/Wo83BO
Q+tsXgN1BCUAGl8TILSlrWjaP9jSQINFuzyU+fqJs6nzI/vnxMSvCk00UEwOQVMa
HXLftoVdg9q9i4fphnW0hAj80bSG4i6U9r7cH2Ne+0QZzkSv4FFaKs3AutA9il1Z
tL88XIvUx5fXy7vfBJL+P4HY5IfbP42jVKvMrjA+A2wdI0IRhGAvZKFnuZV2B2Ad
FswDnFwUXvY8PmWS9/JFKC/Xqharmo6+9ozS9KZpzFMgDJtWA31fRwrSrxFx56Lo
JhJfzy5awku/qNSQgh48tfyaat28Ubj3PjHe6UDe6PCq4zcrwOfobdCb0CNroWoQ
gG94c2i4cGbHRKSWhBYGkz11U5TN5KfArKR/oPiCc3O8BPoOj9nru+j559cHr34J
Gt2ToK0H/ICL+OLyqkuEMu0CERM9JpDzYhytaC+VxJbvYBDV9GzO//nqNnJyLFNm
gQzfbcNSALJJGNIB7grpjCMeqOYT588o0rF79MitN94HpHYFWuk=
=ZsUv
-----END PGP SIGNATURE-----
--=-=-=--
