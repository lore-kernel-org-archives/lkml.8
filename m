Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9168CC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEA1206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QpuIKuee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgDUPn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:43:59 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:32970 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgDUPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587483836; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHceis2+vNOIlN7295BKgbc3RLPfHPJQ+eTv/OC+9IQ=;
        b=QpuIKueesZI4P4sWW1sIWSdpXUbxiN3H02M0g6ZzKABJLrnx0kWpTKAwNIkdQRdnG//d7A
        Jzx8FJwDqKws+VKsKJeAhymgOM8RgffnwGXBBVI4tafXQzq7xiPA/ZaOd37L/EBpfK1Xur
        XEr8WhaY6Wo7Qqsy1thhxE0t4eYRI7E=
Date:   Tue, 21 Apr 2020 17:43:44 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 4/5] remoteproc: ingenic: Added remoteproc driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Message-Id: <WCA59Q.IXGX82YOG4GI2@crapouillou.net>
In-Reply-To: <20200420063714.GA1868936@builder.lan>
References: <20200417170040.174319-1-paul@crapouillou.net>
        <20200417170040.174319-4-paul@crapouillou.net>
        <20200420063714.GA1868936@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Le dim. 19 avril 2020 =E0 23:37, Bjorn Andersson=20
<bjorn.andersson@linaro.org> a =E9crit :
> On Fri 17 Apr 10:00 PDT 2020, Paul Cercueil wrote:
>=20
>>  This driver is used to boot, communicate with and load firmwares to=20
>> the
>>  MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
>>  Ingenic.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Signed-off-by: kbuild test robot <lkp@intel.com>
>>  Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
>=20
> Please read Documentation/process/submitting-patches.rst about
> "Developer's Certificate of Origin".
>=20
> I suspect that you incorporated review feedback on previous revisions
> from kbuild and Julia, this is generally omitted from the actual=20
> commit
> message.

Julia / kbuild sent a patch to fix an error in the driver, so my patch=20
now has code from Julia / kbuild. That document clearly says that I=20
should add their signed-off-by. Or what do you mean?

>>  Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>  ---
>>=20
>>  Notes:
>>      v2: Remove exception for always-mapped memories
>>      v3: - Use clk_bulk API
>>      	- Move device-managed code to its own patch [3/4]
>>      	- Move devicetree table right above ingenic_rproc_driver
>>      	- Removed #ifdef CONFIG_OF around devicetree table
>>      	- Removed .owner =3D THIS_MODULE in ingenic_rproc_driver
>>      	- Removed useless platform_set_drvdata()
>>      v4: - Add fix reported by Julia
>>      	- Change Kconfig symbol to INGENIC_VPU_RPROC
>>      	- Add documentation to struct vpu
>>      	- disable_irq_nosync() -> disable_irq()
>>      v5: No change
>>      v6: Instead of prepare/unprepare callbacks, use PM runtime=20
>> callbacks
>>=20
>>   drivers/remoteproc/Kconfig         |   8 +
>>   drivers/remoteproc/Makefile        |   1 +
>>   drivers/remoteproc/ingenic_rproc.c | 282=20
>> +++++++++++++++++++++++++++++
>>   3 files changed, 291 insertions(+)
>>   create mode 100644 drivers/remoteproc/ingenic_rproc.c
>>=20
>>  diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>  index fbaed079b299..31da3e6c6281 100644
>>  --- a/drivers/remoteproc/Kconfig
>>  +++ b/drivers/remoteproc/Kconfig
>>  @@ -240,6 +240,14 @@ config STM32_RPROC
>>=20
>>   	  This can be either built-in or a loadable module.
>>=20
>>  +config INGENIC_VPU_RPROC
>=20
> Please try to keep things alphabetically ordered.
>=20
>>  +	tristate "Ingenic JZ47xx VPU remoteproc support"
>>  +	depends on MIPS || COMPILE_TEST
>>  +	help
>>  +	  Say y or m here to support the VPU in the JZ47xx SoCs from=20
>> Ingenic.
>>  +	  This can be either built-in or a loadable module.
>>  +	  If unsure say N.
>>  +
>>   endif # REMOTEPROC
>>=20
>>   endmenu
> [..]
>>  diff --git a/drivers/remoteproc/ingenic_rproc.c=20
>> b/drivers/remoteproc/ingenic_rproc.c
> [..]
>>  +/**
>>  + * struct vpu - Ingenic VPU remoteproc private structure
>>  + * @irq: interrupt number
>>  + * @clks: pointers to the VPU and AUX clocks
>=20
> aux_base is missing
>=20
>>  + * @mem_info: array of struct vpu_mem_info, which contain the=20
>> mapping info of
>>  + *            each of the external memories
>>  + * @dev: private pointer to the device
>>  + */
>>  +struct vpu {
>>  +	int irq;
>>  +	struct clk_bulk_data clks[2];
>>  +	void __iomem *aux_base;
>>  +	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
>>  +	struct device *dev;
>>  +};
> [..]
>>  +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da,=20
>> size_t len)
>>  +{
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +	void __iomem *va =3D NULL;
>>  +	unsigned int i;
>>  +
>>  +	if (len <=3D 0)
>=20
> len can't be negative (also, does it add value to check for and fail=20
> len
> =3D=3D 0?)
>=20
>>  +		return NULL;
>>  +
>>  +	for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>>  +		const struct vpu_mem_info *info =3D &vpu->mem_info[i];
>>  +		const struct vpu_mem_map *map =3D info->map;
>>  +
>>  +		if (da >=3D map->da && (da + len) < (map->da + info->len)) {
>>  +			va =3D info->base + (da - map->da);
>>  +			break;
>>  +		}
>>  +	}
>>  +
>>  +	return (__force void *)va;
>>  +}
> [..]
>>  +static struct platform_driver ingenic_rproc_driver =3D {
>>  +	.probe =3D ingenic_rproc_probe,
>>  +	.driver =3D {
>>  +		.name =3D "ingenic-vpu",
>>  +#ifdef CONFIG_PM
>=20
> Please omit the #ifdef here.

If I do, then the PM callbacks will be compiled in even if CONFIG_PM is=20
disabled. That means dead code and I see no reason why you would want=20
that.

If you don't mind, I'd like to keep the #ifdef CONFIG_PM for now, until=20
this patchset is merged: https://lkml.org/lkml/2020/4/13/582

Then it would become a one-liner:
.pm =3D pm_ptr(&ingenic_rproc_pm),

Cheers,
-Paul

>>  +		.pm =3D &ingenic_rproc_pm,
>>  +#endif
>>  +		.of_match_table =3D of_match_ptr(ingenic_rproc_of_matches),
>=20
> Please omit the of_match_ptr()
>=20
> Regards,
> Bjorn
>=20
>>  +	},
>>  +};
>>  +module_platform_driver(ingenic_rproc_driver);
>>  +
>>  +MODULE_LICENSE("GPL");
>>  +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>  +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control=20
>> driver");
>>  --
>>  2.25.1
>>=20


