Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F500C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BED4206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505958AbgDPLGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:06:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506004AbgDPLDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:03:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83812AC52;
        Thu, 16 Apr 2020 11:03:00 +0000 (UTC)
Message-ID: <69b79028764dcdfc9f550a5f95752afb491005f0.camel@suse.de>
Subject: Re: [PATCH 0/4] of: property: fw_devlink misc fixes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Apr 2020 13:02:59 +0200
In-Reply-To: <CAGETcx-=E-6sg=B2Rr+V51eCxiBjNWPnOvvq6K=o9Sr-qLDvOg@mail.gmail.com>
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
         <CAGETcx-=E-6sg=B2Rr+V51eCxiBjNWPnOvvq6K=o9Sr-qLDvOg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-U0A1alyAP1S30q95YmNu"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U0A1alyAP1S30q95YmNu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 11:17 -0700, Saravana Kannan wrote:
> On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > As I'm interested in using this feature to fine-tune Raspberry Pi 4's
>=20
> You've made my day! Finally another user outside of Android. :) If
> this does improve the boot time, I'd be super interested to see the
> numbers.

Actually making the boot time faster isn't my main objective just a nice
possible side-effect. I'll give you some numbers nonetheless :).

I have two things in mind:
 - Exploring if fw_devlink=3Don can help us solve a rather convoluted devic=
e
   initialization depency we're seeing in RPi4. It could potentially preven=
t us
   from adding nasty platform specific driver code.
 - See if we can use all this information to fine-tune initrd generation on
   smaller arm devices with limited i/o speeds.

Do you have any plans in moving the default behavior to fw_devlink=3Don? If=
 so
what is blocking us?

Also do you think it'd be reasonable to add a DT binding to set the desired
fw_devlink level? Something like a 'linux,fw_devlink' property under the
/chosen node.

> > device probe dependencies, I tried to get the board to boot with
> > fw_devlink=3Don. As of today's linux-next the board won't boot with tha=
t
> > option. I tried to address the underlying issues.
>=20
> I'll review the patches. Apologies in advance if my explanations
> aren't thorough. A bit swamped right now.

They were pretty clear!

Thanks,
Nicolas


--=-U0A1alyAP1S30q95YmNu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6YO2MACgkQlfZmHno8
x/666wf/VylFMUp6RLlJhIXSGCFQ/cPOJJTYI73tBsxzqgAsq9hWHbuH6fYDBxCU
5AnrhT8W1qkUUEMk4bBN4jUSK0mQJYI1T9pRpHUe6o83pxSeWPEK/kkQMRfLr0UI
LxDzhO290djKF7rw9ndeTfV6iEXjNfMuqBzHJkE+22VIkEWQuNiMduE7p5Drfv5a
a5CXIkMmUoNJsVRS104xH+lxdg+IFFDrHN9tEhLAua6OMwfClptUKWryeiGqFi6S
TV8BvdStbPRPjfQpLnESs/SYp/l5LQVSl/L60q9Rsq7mxXLvmR6UDMRmzbabH4mV
ZtR6LwbQkqD8dzPnvpY4i/pmr8xgHg==
=SdVL
-----END PGP SIGNATURE-----

--=-U0A1alyAP1S30q95YmNu--

