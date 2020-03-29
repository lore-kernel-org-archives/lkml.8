Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B39CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C471620675
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585477814;
	bh=Xe9aEno1CmtbJbg+uRLSngEJXIYyAbKc823L4BjEg/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=hb3gcvbduanAW13o/kYpTjkA6hlsz9UZr5tYFDGc4zRkJu1PU1dFIbEEVVWvElNxB
	 R1n9V3iTuTiO+ri1lX25uy567ZVdh8pfmjhEaTcuPyPdz10xRp5vvU/WsDnUpKKA4Z
	 S7dsbLBJN7RTvUdOQmFqMXZmSGSmGhqdrblFpedI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgC2KaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:30:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39812 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2KaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:30:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so14728362ljn.6;
        Sun, 29 Mar 2020 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=N3NqZnJ/CxQz+vgNsvaAHWGkQWp4JEs+xGk3PJVLusw=;
        b=W+6jrG6CBhLnlYGkAOJDbZ7SHq4ouY7T1YUPiP9PcofJuFJgtKpaaFWbkA6mhqr3w5
         wXhxJcdc+ZOSitnxl3+MEfB5kQHpDvIZuX8O3OfvkCmtxAUBgR6LnCh+0fpxuhcDIs5P
         QI1r+lSrE9ONAI2VwG86GljK+V0i+afoN+uI4Yg8rjIjdskpBqE2HcAwyLDhRWeYKWNP
         waa4sRGz04xikLcM5l5fgiptWD1YkkL80G8q2RI8iHvkN563BB+d3uVhst6G3CPAZSvn
         WLQvNalAXxnUfrGm5flsL94DudT1AjPE0XUPY678Ck0S9IguY0hdAc6KkBoy7oe6kkA/
         Z5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=N3NqZnJ/CxQz+vgNsvaAHWGkQWp4JEs+xGk3PJVLusw=;
        b=O2TSEu8yxDzRTQ1/TJOK1CMVYhqwXvr3Yt3PulAJIlzvWutPEKre/rO9hyfhqXvkty
         G08gGdws/zGwSD/051Hul39Sl9UbpCA1cg9pNzEA4w60hUFpmFYcWcHkvZVi+jcnwnd2
         LaNAJQVt1WCaXxN36o0ETg+uXv71IW7x4NJgSCqpZN2TYeFnaH09ybZE2mBcrCBJjYWc
         QT0JDG/Hs/YNAdGuW9lOKnQczEIUfSDaQ33xOYiUqADXgrTtsj+pIGTFB/pUBXEIJB+v
         w4zUQLllgdqY5Kkpzk5Tl94ZQuS4HLDuMfwLgVEmodwJpwS5mGc/yWaHS92et8zfsP7F
         15lQ==
X-Gm-Message-State: AGi0PuYzH93iFrpbPx4UHC4G64BC+gz57Sbwj8Hr8LaLxu5PH/E60px8
        lAY223OduLbay269hApfD3AO8XTbHqSrxw==
X-Google-Smtp-Source: APiQypL26pRPoTg8hmK0zo9sxRXo65MAqpvyF6aUMysm+aHZ4u2UZCTAa1IwphYZOi+xJmhaZznDkw==
X-Received: by 2002:a2e:9146:: with SMTP id q6mr4211254ljg.240.1585477810916;
        Sun, 29 Mar 2020 03:30:10 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id r10sm5229827ljk.13.2020.03.29.03.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 03:30:10 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] usb: dwc3: meson: add OTG support for GXL/GXM
In-Reply-To: <20200324102030.31000-1-narmstrong@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
Date:   Sun, 29 Mar 2020 13:30:06 +0300
Message-ID: <87369rfo7l.fsf@kernel.org>
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

Neil Armstrong <narmstrong@baylibre.com> writes:

> The USB support was initialy done with a set of PHYs and dwc3-of-simple
> because the architecture of the USB complex was not understood correctly
> at the time (and proper documentation was missing...).
>
> But with the G12A family, the USB complex was correctly understood and
> implemented correctly.
> But seems the G12A architecture was derived for the GXL USB architecture,
> with minor differences and looks we can share most of the USB DWC3 glue
> driver.
>
> This patchset refactors and adds callbacks to handle the architecture
> difference while keeping the main code shared.
>
> The main difference is that on GXL/GXM the USB2 PHY control registers
> are mixed with the PHY registers (we already handle correctly), and
> the GLUE registers are allmost (99%) the same as G12A.
>
> But, the GXL/GXM HW is buggy, here are the quirks :
> - for the DWC2 controller to reset correctly, the GLUE mux must be switch=
ed
>   to peripheral when the DWC2 controlle probes. For now it's handled by s=
imply
>   switching to device when probing the subnodes, but it may be not enough
> - when manually switching from Host to Device when the USB port is not
>   populated (should not happen with proper Micro-USB/USB-C OTG switch), it
>   makes the DWC3 to crash. The only way to avoid that is to use the Host
>   Disconnect bit to disconnect the DWC3 controller from the port, but we =
can't
>   recover the Host functionnality unless resetting the DWC3 controller.
>   This bit is set when only manual switch is done, and a warning is print=
ed
>   on manual switching.
>
> The patches 1-8 should be applied first, then either waiting the next rel=
ease
> or if the usb maintainer can provide us a stable tag, we can use it to me=
rge
> the DT and bindings.

it's unclear to me if this series is ready to be merged. Can someone
confirm? If it is, can you resend with all reviewed by tags in place?

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6AeK4ACgkQzL64meEa
mQaBrg/9HlcRQjYQsutKmZuRscMQWwFrkkYrNIRYUYOM13FibjrTl8YEv/ocy2Gk
huJi0X7JUcERQoCZsvkP6aORdnZ7LNdc/qLJ8uuaBGWCYcIy1uHZnMbqLsESrIXr
VaSBjW9v4Qon/YAKnQbb3JTo2sa9yBOdaJx4B/t0g0ke4QD2zaF9g+8UsAgU8HQX
DyE89wAn92AC399gPwF4U6xIPEXSHesRH4dSFcFajiaIEfG/rTleN+gZZYy/1Jag
owp+mE38Gr3nvNeYRUNsW5vJVibvVKv8pTv6CO4CZj3ZuACLqAm/zHmHZS1ML/pV
QoU02X9uK8O6hLl/coAvDQwwou9fvJ9c68dbgdkRMGC9M4Y0QqDkjYEWdyAHgdZN
TE0wmGkOZvVTrEorWSyrUDQGDSwp/mFJinYnAVMuZZPfLEHala6uUpojD1dvuCvj
A7Ljwj5ya84mbY+D5RbAoWfFayeDMoJcla7HHtz0wb9g+WzV6JwhZVJP4vaLbDDw
EeeSt6vBXOuh24lFVcGeKwrACbT38z9c+ZrbBKujrkYERR3zC5jQsoudxI2nSgb9
U/dew4yKRT1VUbK8y+mbneesrFSDcPDZO+uTkoKzSdW6NnbWM0Lnc2klmt1iYrYa
aplBe2DwyMcCIBFfqQo4NYj0HMzFzGqeG7qxX2E+0vI661nDE+k=
=LsIt
-----END PGP SIGNATURE-----
--=-=-=--
