Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72491C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E7B206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xoz6eOIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFBJSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:18:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48892 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:18:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0529IKFD068269;
        Tue, 2 Jun 2020 04:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591089500;
        bh=HRp5NJcgpD5M8lfp1dgBCoU2NWUCFTruXvAY9gBzvvk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xoz6eOIKkhtxgQJsERCAN6s8rjW8N8YLGgcl2MBUUz5p2Eg03KD9IMxMAXsfnQBjh
         Qdn3DOiIf9P8UdT4a2RJ1CLUB/UNAOlMlBb0bcN6j+Xic98hxZBNq2rB+kegFpFNeO
         SXKjKsec1cIcDMAGrlIeSuHj9e5q1kricH+7kB0w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0529IKYx121479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Jun 2020 04:18:20 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Jun
 2020 04:18:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Jun 2020 04:18:19 -0500
Received: from feketebors.localnet (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0529IH14004338;
        Tue, 2 Jun 2020 04:18:18 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
CC:     <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>, Bin Liu <b-liu@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: davinci: fix build failure without I2C
Date:   Tue, 2 Jun 2020 12:19:00 +0300
Message-ID: <2499396.lGaqSPkdTl@feketebors>
In-Reply-To: <20200527133746.643895-1-arnd@arndb.de>
References: <20200527133746.643895-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wednesday, 27 May 2020 16.37.34 EEST Arnd Bergmann wrote:
> The two supplies are referenced outside of #ifdef CONFIG_I2C but
> defined inside, which breaks the build if that is not built-in:
>=20
> mach-davinci/board-dm644x-evm.c:861:21: error: use of undeclared identifi=
er 'fixed_supplies_1_8v'
>                                      ARRAY_SIZE(fixed_supplies_1_8v), 180=
0000);
>                                                 ^
> mach-davinci/board-dm644x-evm.c:861:21: error: use of undeclared identifi=
er 'fixed_supplies_1_8v'
> mach-davinci/board-dm644x-evm.c:861:21: error: use of undeclared identifi=
er 'fixed_supplies_1_8v'
> mach-davinci/board-dm644x-evm.c:860:49: error: use of undeclared identifi=
er 'fixed_supplies_1_8v'
>         regulator_register_always_on(0, "fixed-dummy", fixed_supplies_1_8=
v,
>=20
> I don't know if the regulators are used anywhere without I2C, but
> always registering them seems to be the safe choice here.

Thanks for fixing this,
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
=20
> On a related note, it might be best to also deal with CONFIG_I2C=3Dm
> across the file, unless this is going to be moved to DT and removed
> really soon anyway.
>=20
> Fixes: 5e06d19694a4 ("ARM: davinci: dm644x-evm: Add Fixed regulators need=
ed for tlv320aic33")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-davinci/board-dm644x-evm.c | 26 ++++++++++++------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-dav=
inci/board-dm644x-evm.c
> index 3461d12bbfc0..a5d3708fedf6 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -655,19 +655,6 @@ static struct i2c_board_info __initdata i2c_info[] =
=3D  {
>  	},
>  };
> =20
> -/* Fixed regulator support */
> -static struct regulator_consumer_supply fixed_supplies_3_3v[] =3D {
> -	/* Baseboard 3.3V: 5V -> TPS54310PWP -> 3.3V */
> -	REGULATOR_SUPPLY("AVDD", "1-001b"),
> -	REGULATOR_SUPPLY("DRVDD", "1-001b"),
> -};
> -
> -static struct regulator_consumer_supply fixed_supplies_1_8v[] =3D {
> -	/* Baseboard 1.8V: 5V -> TPS54310PWP -> 1.8V */
> -	REGULATOR_SUPPLY("IOVDD", "1-001b"),
> -	REGULATOR_SUPPLY("DVDD", "1-001b"),
> -};
> -
>  #define DM644X_I2C_SDA_PIN	GPIO_TO_PIN(2, 12)
>  #define DM644X_I2C_SCL_PIN	GPIO_TO_PIN(2, 11)
> =20
> @@ -700,6 +687,19 @@ static void __init evm_init_i2c(void)
>  }
>  #endif
> =20
> +/* Fixed regulator support */
> +static struct regulator_consumer_supply fixed_supplies_3_3v[] =3D {
> +	/* Baseboard 3.3V: 5V -> TPS54310PWP -> 3.3V */
> +	REGULATOR_SUPPLY("AVDD", "1-001b"),
> +	REGULATOR_SUPPLY("DRVDD", "1-001b"),
> +};
> +
> +static struct regulator_consumer_supply fixed_supplies_1_8v[] =3D {
> +	/* Baseboard 1.8V: 5V -> TPS54310PWP -> 1.8V */
> +	REGULATOR_SUPPLY("IOVDD", "1-001b"),
> +	REGULATOR_SUPPLY("DVDD", "1-001b"),
> +};
> +
>  #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
> =20
>  /* venc standard timings */
>=20

=2D P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki


