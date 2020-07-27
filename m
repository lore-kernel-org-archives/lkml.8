Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2384CC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2AA2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgG0FUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgG0FUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:20:42 -0400
Received: from metis.ext.pengutronix.de (unknown [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D50C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 22:20:41 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jzvYd-0005Ov-P9; Mon, 27 Jul 2020 07:20:15 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jzvYc-0001Zu-AD; Mon, 27 Jul 2020 07:20:14 +0200
Date:   Mon, 27 Jul 2020 07:20:14 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 06/10] remoteproc: imx_rproc: add load hook
Message-ID: <20200727052014.tadfgxyexkoxffy7@pengutronix.de>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-7-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbgyevojci4fu3gk"
Content-Disposition: inline
In-Reply-To: <20200724080813.24884-7-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:01:51 up 254 days, 20:20, 238 users,  load average: 0.18, 0.13,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fbgyevojci4fu3gk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 04:08:09PM +0800, Peng Fan wrote:
> To i.MX8, we not able to see the correct data written into TCM when
> using ioremap_wc, so use ioremap.
>=20
> However common elf loader using memset.
>=20
> To arm64, "dc      zva, dst" is used in memset.
> Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,
>=20
> "If the memory region being zeroed is any type of Device memory,
> this instruction can give an alignment fault which is prioritized
> in the same way as other alignment faults that are determined
> by the memory type."
>=20
> On i.MX platforms, when elf is loaded to onchip TCM area, the region
> is ioremapped, so "dc zva, dst" will trigger abort.
>
> So add i.MX specific loader to address the TCM write issue.

First I wonted to ask, if it is AMR64 related issues, why do we handle
it in iMX specific driver?

But after searching and finding this thread:
https://lkml.org/lkml/2020/4/18/93
it looks to me like most of related maintainer questions, was not
answered.

> The change not impact i.MX6/7 function.

Hm... it is impossible assumption,e except you was able to test all
firmware variants it the wild.
You changed behavior of ELF parser in the first place. It means,
not iMX6/7 is affected, but firmware used on this platforms.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 76 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 76 insertions(+)
>=20
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index aee790efbf7b..c23726091228 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -4,6 +4,7 @@
>   */
> =20
>  #include <linux/clk.h>
> +#include <linux/elf.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -15,6 +16,9 @@
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> =20
> +#include "remoteproc_internal.h"
> +#include "remoteproc_elf_helpers.h"
> +
>  #define IMX7D_SRC_SCR			0x0C
>  #define IMX7D_ENABLE_M4			BIT(3)
>  #define IMX7D_SW_M4P_RST		BIT(2)
> @@ -247,10 +251,82 @@ static void *imx_rproc_da_to_va(struct rproc *rproc=
, u64 da, size_t len)
>  	return va;
>  }
> =20
> +static int imx_rproc_elf_load_segments(struct rproc *rproc, const struct=
 firmware *fw)
> +{
> +	struct device *dev =3D &rproc->dev;
> +	const void *ehdr, *phdr;
> +	int i, ret =3D 0;
> +	u16 phnum;
> +	const u8 *elf_data =3D fw->data;
> +	u8 class =3D fw_elf_get_class(fw);
> +	u32 elf_phdr_get_size =3D elf_size_of_phdr(class);
> +
> +	ehdr =3D elf_data;
> +	phnum =3D elf_hdr_get_e_phnum(class, ehdr);
> +	phdr =3D elf_data + elf_hdr_get_e_phoff(class, ehdr);
> +
> +	/* go through the available ELF segments */
> +	for (i =3D 0; i < phnum; i++, phdr +=3D elf_phdr_get_size) {
> +		u64 da =3D elf_phdr_get_p_paddr(class, phdr);
> +		u64 memsz =3D elf_phdr_get_p_memsz(class, phdr);
> +		u64 filesz =3D elf_phdr_get_p_filesz(class, phdr);
> +		u64 offset =3D elf_phdr_get_p_offset(class, phdr);
> +		u32 type =3D elf_phdr_get_p_type(class, phdr);
> +		void *ptr;
> +
> +		if (type !=3D PT_LOAD)
> +			continue;
> +
> +		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
> +			type, da, memsz, filesz);
> +
> +		if (filesz > memsz) {
> +			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
> +				filesz, memsz);
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		if (offset + filesz > fw->size) {
> +			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
> +				offset + filesz, fw->size);
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		if (!rproc_u64_fit_in_size_t(memsz)) {
> +			dev_err(dev, "size (%llx) does not fit in size_t type\n",
> +				memsz);
> +			ret =3D -EOVERFLOW;
> +			break;
> +		}
> +
> +		/* grab the kernel address for this device address */
> +		ptr =3D rproc_da_to_va(rproc, da, memsz);
> +		if (!ptr) {
> +			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> +				memsz);
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		/* put the segment where the remote processor expects it */
> +		if (filesz)
> +			memcpy_toio(ptr, elf_data + offset, filesz);
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct rproc_ops imx_rproc_ops =3D {
>  	.start		=3D imx_rproc_start,
>  	.stop		=3D imx_rproc_stop,
>  	.da_to_va       =3D imx_rproc_da_to_va,
> +	.load		=3D imx_rproc_elf_load_segments,
> +	.parse_fw	=3D rproc_elf_load_rsc_table,
> +	.find_loaded_rsc_table =3D rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	=3D rproc_elf_sanity_check,
> +	.get_boot_addr	=3D rproc_elf_get_boot_addr,
>  };
> =20
>  static int imx_rproc_addr_init(struct imx_rproc *priv,
> --=20
> 2.16.4
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--fbgyevojci4fu3gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8eZAkACgkQ4omh9DUa
UbMr4xAAzb9KHRlNH/QhnvS0wxRRBZAU6U8LEO6qZrFn6a00IcQqY2y35hdAr5kf
c8uo3kBuHbrw3aYeur6iNQA8cp57Uc70fK0a4jS7KOvDmjuttRyDN/GD2Gb6kY/a
RoG33lQc0JA1gtLNoMA1VeX3Oaoghlvpv0VBrstPGHp+b61uDI2lFwF4KkhrEe0G
+HjTWxdkFiZ1g4kC5Ik8ZlaKwNfzTcJgnlaoQsQQkxECIILcZvmntru0YOdePM9t
0/VOGJH+qA+Np7A5j/sb+D07RYMmcb1ek7GLTIgsndtMlHp66XkzKyObbLLfRnqU
DQ8w4waaY9i8X2W3X9aaCi45dG2XJ9m7wvGohLp7Rr4b9bioo1lbNHNM2Jo0fEXE
0X7XRACIKihQy3QmN2lX7zXK0kpQcq+gSV2kRvairRDuqYXm/lKoMsPMT3UAMbsu
fCj7D66swuCfdoe05hwsqu93fbJP7Jdog3gCyHVoFxNcXT43ur4AwRkJkdU+yl2C
TmK9U2hLq+DhnlBg0M+6yaf7t2P4kuu6BRy7kLzf+KrB4daU0nxqDF+404apbP0N
Z6WgWETHEfn0i53mHIaVwAWdGLwJhNAsSAB3c82+D3TLozJyQgOrtWZK1VtcUnWq
q20cBB7zMuOX82D5G+YVz6K1rwYb0MsLSVQT9J0VMDl24rHJBDw=
=9PWb
-----END PGP SIGNATURE-----

--fbgyevojci4fu3gk--
