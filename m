Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B18C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CC420675
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585478199;
	bh=Io8+jAiHEbJYEt/DyVZFmpPHOSq9d/2sdPcr0EXpShw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ly03MARaemV8nXlCwTm8juDHg36e4QQB6DPUZ93s1FxLrlqgwGbt85no17kt8esF7
	 vGyy0iZprcwHPcyBFd3XxxVDca/GeaP7siu/tc2J0dLYmBrkRCqd9Bo++zYl7kmVSa
	 GYR2zpPolklXiFSpfl/dTk+BXUmsmo2KZIWHodOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgC2Kgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:36:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44421 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgC2Kgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:36:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so14699488lji.11;
        Sun, 29 Mar 2020 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cEsIe8nn/S1lT0wrpqG10UN56pPApRKTKN29r4c4Uu8=;
        b=ZKWeswJz2TjBGfAJe3HbiPdCAr3SAOh2sPYa0TzzpncnDPFVrILal0hxoCJog0t8uW
         Ksu4ct+oISI8eYATUgwqFuctJVD+KM7iKyZxVXe6YYDS4CZdzrQz1vO69vhpLgDNTOnC
         hDj0hOnVAqkxHlO8Xmejq8lhPxTij/tFHZdUk9SoBRTyC6c4LRMIGBl5EBpvcy8zXG/u
         fRTlspMAYfdgBtudbe90nhcleTSmtaNEOLtkQwXErND9RjiUQAyk3IZv0FB6ev9pfkWG
         uRLIRt55E0sMNw78VnDLg9bTubhpd4oEruWQPDd1RTBqejrRw8hMrd52fbX/Y9hPVl3I
         intA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=cEsIe8nn/S1lT0wrpqG10UN56pPApRKTKN29r4c4Uu8=;
        b=D++lF5XdlOBUV86ZeIj38uxVCy55oImZP/pRiiH7EbQcy+OXJMq1nh0LE8Hn6WZoF/
         piNObpNn7vIUv4Vge2Iq3qtawhtD95fbMTAvnVK7J281mSxRzoFrhEKM+oL0+cEIZYYv
         Bkd3PfRU5MSRF+bWteAQ5BYH+ZCOEHKZTtMDMjFBJI8MZcaBOWh3PYV5MjWmr7ITEOEX
         XaMx6VJ1uvebxx/4BpqjbqJsGHpmrZczrbtnVyVWPY4a32lIpSwxax9kS2YcFZ+6qM2p
         d3/ZwF5E0wFwdoAQuijxpz69TreiJh1xQHFdoPrWK/qjSuLSXeFvthWiVjaJNhU7lNB+
         qvJQ==
X-Gm-Message-State: AGi0PuaQuxYGEbLZv2vDIgsr9hUxFWCV5FYUwxOZYoT+mTxt/NZBGie4
        yuz8RJCenTaQb6EhlfsTPO27a3nLpnN8QQ==
X-Google-Smtp-Source: APiQypJThIFhVwSBsidNoBC3qKZrQY2GoxPRqD+WnxsypL80S0UNgy5WV/AaIIZEVzJM6IJFC8PXkw==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr4134503ljk.176.1585478194949;
        Sun, 29 Mar 2020 03:36:34 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id k3sm5332976lji.43.2020.03.29.03.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 03:36:34 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] usb: dwc3: meson: add OTG support for GXL/GXM
In-Reply-To: <20200326134507.4808-1-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
Date:   Sun, 29 Mar 2020 13:36:28 +0300
Message-ID: <87v9mne9cj.fsf@kernel.org>
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
>   to peripheral when the DWC2 controller probes. For now it's handled by =
simply
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
> The patches 1-9 should be applied first, then either waiting the next rel=
ease
> or if the usb maintainer can provide us a stable tag, we can use it to me=
rge
> the DT and bindings.
>
> Changes since v1 at [1]:
> - Fixed DT bindings to take in account usb2-phy2 on GXM
> - Added comment in patch2
> - Fixed patch 5 and moved fix out
> - Collected tags
> - Lower DT patch changes, switch p20x-q20x port B as OTG by default

patches 1-6 are applied to my testing/next

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6Aei4ACgkQzL64meEa
mQaamxAAwuHxU4drRBYL0UhnH4ujHmfw9zVuZeEVjxAf0eTeCXjxw0u76bgZlbm1
z407kK9bU2znxIUFAEtYZ8SNuPQcnGkEkJBRIAKr9sBlcoqnVl0I6UCCgpAhZh0P
/Mkpea+QjUrtIgojPkyM9xnxi42+JwBT6S+rGqgq9KulVVC5TzNWTY5b3IvlJinW
7OruoTHahtfiVqSi5DOzzNRsWvX6R6JolMq8wsa1KOQiVnlB0GTLJFqf8TKrZgWn
/PQpbbhk5MUnDgUTIaOWYbfcJrUZd4yt0kkgH8tO3jIH8getvK3JKgZcrsQQ2em6
gmXrQ+o64TaJ+5RFNMJknhcMfnB5jKCAWj8FVHB2P/wOFt1eHu6XOIxBozraEkYW
OEa+3RNEFilashPRbm7plsHlqQX98HpliM2+p7mtcgTjWKJeDRMiBc2RXqd8SKcp
U7kwWYGv6BZ/EVncImIHgVJ2uTvriB+yeUuMVrZU8u/Rr3eRaOHikb/KJANh00k/
UlpxS89UD2zAd+HT3BqVYuzvtoKJOYO8z0d6DlvV/bzaxSOpWoIFNEL8tGjGDRtu
R9HlOcqhoi3amtqVFMR+huIB6ZQIcilLcNA+1mzxwq0qXyVNA+oyY2dskRhgoV+t
kFZs/a6g4e5bN8HxaWdDeEdWgts/Cmz+A4PfCTsD26XKggaw8f4=
=uyGs
-----END PGP SIGNATURE-----
--=-=-=--
