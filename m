Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D3BC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F45820725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgBQVTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:19:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:42838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgBQVTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:19:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA941AD6C;
        Mon, 17 Feb 2020 21:19:22 +0000 (UTC)
Message-ID: <7bd53a3ee156037132e85415589168345461ad7c.camel@suse.de>
Subject: Re: [PATCH] usb: xhci-pci: Raspberry Pi FW loader for VIA VL805
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     oneukum@suse.com, phil@raspberrypi.com, tim.gover@raspberrypi.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 17 Feb 2020 22:19:20 +0100
In-Reply-To: <185f8cae-9898-ee72-00f1-ec79d98c43f4@gmail.com>
References: <20200217100701.19949-1-nsaenzjulienne@suse.de>
         <185f8cae-9898-ee72-00f1-ec79d98c43f4@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6v5SE9lBM19zZDAYXHDY"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6v5SE9lBM19zZDAYXHDY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-17 at 12:52 -0800, Florian Fainelli wrote:
>=20
> On 2/17/2020 2:07 AM, Nicolas Saenz Julienne wrote:
> > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either b=
e
> > loaded directly from an EEPROM or, if not present, by the SoC's
> > VideCore.  Inform VideCore that VL805 was just reset, or defer xhci's
> > probe if not yet joinable trough the mailbox interface.
> >=20
> > Based on Tim Gover's downstream implementation.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Would it work if you registered the firmware loading as pci fixup such
> that you would not even have to mangle xhci-pci.c at all and all the
> logic could be contained within drivers/firmware/raspberrypi.c?

Not that simple, PCI fix-ups don't allow for probe deferring. We depend on =
the
firmware and mailbox drivers to be up prior running this, so it's essential=
. We
could cheat and do the deferring first thing during pcie-brcmstb's probe.

Actually this might be a workable solution (as in upstreamable):
 - Wait for firmware to be up in pcie-brcmstb.c
 - Add firmware code in firmware/raspberrypi.c
 - Perform call in usb's quirk_usb_early_handoff() (usb/host/pci-quirks.c)

Regards,
Nicolas


--=-6v5SE9lBM19zZDAYXHDY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5LA1gACgkQlfZmHno8
x/7pOQf/Rc4PUoWjbSaEnRadMhclCH4wKP/YYX30qB8pP4LdbbBhlVyFrL1pYqsA
7SM/sYXSi77ZudG91Qdw0KZQO+8d8R/sC0AliG5qNe0qkc314TwqjAcu90kXkbEF
lvLFkocleihvGcVPjY9LEwk2bPqSY4ScYt/WhrfGIaqvqyJ/ISqliY6HFlbjJfjq
323xSs7Jp0SXjl8h2yOhL0kgV6HS/NTUbwUrW0lRXvZWjDyi0CM1uyxCgUy4EiRC
wsSutseZ95JKX8Sw78dLrE1H0qQel1cAIbZSNb6/lVOvFinq8lKhh+EJVHmAiwOl
7o2HJ9OsjY6Lb4mqgcvoPqFPVl5/tQ==
=bl1/
-----END PGP SIGNATURE-----

--=-6v5SE9lBM19zZDAYXHDY--

