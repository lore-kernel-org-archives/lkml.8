Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:22855
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKG2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:28:31 -0400
From: "Madalin Bucur (OSS)" <madalin.bucur@oss.nxp.com>
To: Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com"
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] dpaa_eth: Remove unnecessary boolean expression in
 dpaa_get_headroom
Date: Wed, 11 Mar 2020 06:28:26 +0000
Message-ID:
 <DB8PR04MB6985A192818CEB0F0D274677ECFC0@DB8PR04MB6985.eurprd04.prod.outlook.com>
References: <20200310220654.1987-1-natechancellor@gmail.com>
In-Reply-To: <20200310220654.1987-1-natechancellor@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311062826.vsq-7KXVm0lKPaCRP2OTMQmnvga7mWlzSv2KQ7ZnOI4@z>

> -----Original Message-----
> From: Nathan Chancellor <natechancellor@gmail.com>
> Sent: Wednesday, March 11, 2020 12:07 AM
> To: David S. Miller <davem@davemloft.net>; Madalin Bucur
> <madalin.bucur@nxp.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; clang-built-
> linux@googlegroups.com; Nathan Chancellor <natechancellor@gmail.com>
> Subject: [PATCH] dpaa_eth: Remove unnecessary boolean expression in
> dpaa_get_headroom
>=20
> Clang warns:
>=20
> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2860:9: warning:
> converting the result of '?:' with integer constants to a boolean always
> evaluates to 'true' [-Wtautological-constant-compare]
>         return DPAA_FD_DATA_ALIGNMENT ? ALIGN(headroom,
>                ^
> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:131:34: note: expanded
> from macro 'DPAA_FD_DATA_ALIGNMENT'
> \#define DPAA_FD_DATA_ALIGNMENT  (fman_has_errata_a050385() ? 64 : 16)
>                                  ^
> 1 warning generated.
>=20
> This was exposed by commit 3c68b8fffb48 ("dpaa_eth: FMan erratum A050385
> workaround") even though it appears to have been an issue since the
> introductory commit 9ad1a3749333 ("dpaa_eth: add support for DPAA
> Ethernet") since DPAA_FD_DATA_ALIGNMENT has never been able to be zero.
>=20
> Just replace the whole boolean expression with the true branch, as it is
> always been true.
>=20
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.c
> om%2FClangBuiltLinux%2Flinux%2Fissues%2F928&amp;data=3D02%7C01%7Cmadalin.=
buc
> ur%40nxp.com%7C53f37e7dbf584248844608d7c53f5f70%7C686ea1d3bc2b4c6fa92cd99=
c
> 5c301635%7C0%7C0%7C637194748277007260&amp;sdata=3DGshtiHYyjvTcp87StdMoQDP=
5L6
> %2BhYN6nnUi6vbyuqic%3D&amp;reserved=3D0
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index 190e4478128a..46039d80bb43 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2857,9 +2857,7 @@ static inline u16 dpaa_get_headroom(struct
> dpaa_buffer_layout *bl)
>  	headroom =3D (u16)(bl->priv_data_size + DPAA_PARSE_RESULTS_SIZE +
>  		DPAA_TIME_STAMP_SIZE + DPAA_HASH_RESULTS_SIZE);
>=20
> -	return DPAA_FD_DATA_ALIGNMENT ? ALIGN(headroom,
> -					      DPAA_FD_DATA_ALIGNMENT) :
> -					headroom;
> +	return ALIGN(headroom, DPAA_FD_DATA_ALIGNMENT);
>  }
>=20
>  static int dpaa_eth_probe(struct platform_device *pdev)
> --=09
> 2.26.0.rc1

Reviewed-by: Madalin Bucur <madalin.bucur@oss.nxp.com>

