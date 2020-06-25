Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8D3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C57207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbgFYIYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:24:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:37286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390460AbgFYIYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:24:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 921C7ACF1;
        Thu, 25 Jun 2020 08:24:03 +0000 (UTC)
Message-ID: <600f9f780eae75f47cf6c975dcfe172c6b151ac5.camel@suse.de>
Subject: Re: [PATCH 50/50] staging: vchiq: Move vchiq.h into include
 directory
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Date:   Thu, 25 Jun 2020 10:24:01 +0200
In-Reply-To: <20200623164235.29566-51-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
         <20200623164235.29566-51-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wf8ryFCmpQGjVNK0SP/1"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wf8ryFCmpQGjVNK0SP/1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile
> b/drivers/staging/vc04_services/vchiq-mmal/Makefile
> index f8164c33aec3..b2a830f48acc 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/Makefile
> +++ b/drivers/staging/vc04_services/vchiq-mmal/Makefile
> @@ -5,4 +5,5 @@ obj-$(CONFIG_BCM2835_VCHIQ_MMAL) +=3D bcm2835-mmal-vchiq.=
o
> =20
>  ccflags-y +=3D \
>  	-I$(srctree)/$(src)/.. \
> +	-I$(srctree)/$(src)/../include \
>  	-D__VCCOREVER__=3D0x04000000
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 72afa4319bd3..b99b7555a8fb 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -23,14 +23,14 @@
>  #include <linux/slab.h>
>  #include <linux/completion.h>
>  #include <linux/vmalloc.h>
> +#include <linux/raspberrypi/vchiq.h>
>  #include <media/videobuf2-vmalloc.h>
> +#include <linux/raspberrypi/vchiq.h>

Just realised that there an include too many here...

Regards,
Nicolas


--=-wf8ryFCmpQGjVNK0SP/1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl70XyEACgkQlfZmHno8
x/4qEwf+II/T904mwftPXhFlzsBMzhsH4e95IcgFjKlDJDOMXRCNPRwx23g2zSMp
m4bTDmCFDRbgjRfFp3os5IWQ1pfa/Xi4MpHCjQI1ii2qUok9frDzYXnZLpli+VAu
JOayUpsvvk5jLD9VgtqYnrBxsVN36tqn+xpc8apdUlbwjNJ1/476fH+dkk78m4cW
/wWi5DGDpfy1/BaNqxLymd03qYSEUDmRZuCi5lxkHPQM2KKZFOXZ8Ei4sWzsCm8E
0efl/v13HKW8kZyvHqCTBzQ/ntWhprtiMgHXgvcLsR4M8OHqmdEeVu+bAokcISRV
GV9iAQjaRnSw8voaJu8tYrfN7nar1w==
=h21r
-----END PGP SIGNATURE-----

--=-wf8ryFCmpQGjVNK0SP/1--

