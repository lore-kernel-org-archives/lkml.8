Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B6DC35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D56206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DsIPVQKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgBWAFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 19:05:44 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:53669
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbgBWAFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 19:05:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KucBHNrr+pN8mxi32bp4v76ofn8KfU6ZBCC5tjgTGKWNPyWszNRQLtcv0aMBjV5zlh30PJD3hXVfym742KXlOiGtxKL7MR5fef20Mp4bwzfVspLypTHgeALHGlOzdseDT7UEIwKoZpSTzcHqOQmCrBtdTu+J8N0G5TYG3iEiV3LhzIc+qFjnhYkZAWmmgDZaC9LnfKQQhwdaYHK6kayUu2L6WAlyRi7OscRxqhKuuACWjbHQ+lCi3lBR3Wv0M1D7gV/fZGhEX0LSvhRP0J9MowMhFyObWJ7xYWn5cTNlGih+lZdYq05vmoKpxSXhq06zLgoAFQLMadhOzKlMzXOfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qfNWAfX9rRSeyK5xvU/DHDOyQ8vQFjPJs4gHZRgprw=;
 b=KXzwMi5EqAv39PYWtuand5UBwKfjMmd2BHaNf0fGuD5aoAFjENr2v8BKVRKGiLlzaOldUk3xjO/CqLdT0fjHd9hfwsCy8J4ENHKYL8riVjj35atpOIo6LFwqYuYpv78OQipKJG87SAP7vhIniDOr+EI3AVIalfCChRPX60IhK+ry7jiGG9wJIpbBtYF9FcGX33swz/guEikyohrMaqGmSVQYnQhfwF8/HQ+dt+JwfNv6EfYgIRSn175mSkjm4hLZcPdBBRrA9zC8dVX1cPS0A5N6/QJYgAwegDWjOhsR3L98Tq3qD53uxI2/gAxHJB3M4MWDRBh5DUvfI4uaJYHuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qfNWAfX9rRSeyK5xvU/DHDOyQ8vQFjPJs4gHZRgprw=;
 b=DsIPVQKF3s6dEjQ2TNQTuk5fCbSK6B45HZksJE+DKAJ0+y6+U1WVrf080ZJuE/SAS4ode5XxRUJ/XY8VtO6T7oV9l7JFf8bwE3CGIR7hZHTKHs5oPEq5XPh/fpJE5NxMnAo+gWL6Jh1GG5e+Bhu+tKHVx3C6os95UdkQyT9xb1s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4785.eurprd04.prod.outlook.com (20.176.215.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Sun, 23 Feb 2020 00:05:37 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Sun, 23 Feb 2020
 00:05:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/9] remoteproc: imx_rproc: surport early booted remote
 processor
Thread-Topic: [PATCH 4/9] remoteproc: imx_rproc: surport early booted remote
 processor
Thread-Index: AQHV5vbwehIi1bDyDkSmdk0pEr9IMqgmKoMAgAHAdvA=
Date:   Sun, 23 Feb 2020 00:05:37 +0000
Message-ID: <AM0PR04MB4481F6CFED06D319E312622588EF0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-5-git-send-email-peng.fan@nxp.com>
 <20200221211646.GB10368@xps15>
In-Reply-To: <20200221211646.GB10368@xps15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [117.82.241.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f2a1a0b-3fb0-439f-e199-08d7b7f41c7c
x-ms-traffictypediagnostic: AM0PR04MB4785:|AM0PR04MB4785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB47857D0736C327337291B8AA88EF0@AM0PR04MB4785.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0322B4EDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(86362001)(52536014)(81166006)(8676002)(81156014)(30864003)(8936002)(6916009)(7696005)(4326008)(54906003)(76116006)(66476007)(66946007)(66556008)(7416002)(5660300002)(71200400001)(316002)(64756008)(66446008)(6506007)(44832011)(26005)(186003)(2906002)(33656002)(55016002)(9686003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4785;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcm2aMB9i6hpgblum2NvF50ppPDpGJNz8YVPGdNnTfPJjC/LTw1K3ro5jpkrA1UhaSqJ1SJd6vzViSpJB3iWOiRtHaJGnmiSTf73MVlYYkr7uJFitF1/Ys4Yw20ZsP1fbl9Tj7n2opm9Fjii1bxl3hGXMZeThjkg14sp7w86GMZYQdNApC5GL7GYLjX/poUAhQ5gTDDZT73YEbrLqqnLx96+03vAGHjlh/nmvPT3HKK0ssqT3yanlgrK7cBK9JkJsE4EpOTxQ2H4v3ZrffkN0DlRFT7BcRLJDV7/3NOQ2PcDbrdEgBbGDQNR6qWR+6UO8FXvWoc7gW3royt3KuW1g5hdf4h4Q+vFBBG2lu5iw+Pq3BTc29uYtFQaOwai+tO0KAeQDBJ9Aj4s3MeCYCDVtViWLM7US4jtaVZFWCoV0xnlVHfApvUjB8fn7KSj8qYU
x-ms-exchange-antispam-messagedata: AdyTGTV7nWDZY5YzYy9DzPOPFws/YqYUrYrBTmXDdR6D1LY03O2wazdz/61H4R947xTUq8m21Bk4Q7y8VoldJqMezZBUYWF5HlrbCzYpDSiUBLMqIOLsV2U26sGJTL6/I00ljK+ShqQ1TEn0UVe1Ww==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2a1a0b-3fb0-439f-e199-08d7b7f41c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2020 00:05:37.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOEdkdy/+chqSTRNUfA1tlB57GG0zI0TVnCvNUt7kJSx9z/Wbxtepl2ZFjIApdq+JIepdOLBCgEa+l7fc7Qb6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 4/9] remoteproc: imx_rproc: surport early booted remo=
te
> processor
>=20
> On Wed, Feb 19, 2020 at 03:27:40PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When remote processor is booted by bootloader, Linux need to ignore
> > firmware loading, and ignore remote processor start/stop related
> > hardware operations. what should do is to need to handle
> > memory-regions and resource table.
> >
> > Add a src_started entry to check whether Cortex-M4 is started for
> > i.MX7D and i.MX6SX.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 240
> > +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 220 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 3e72b6f38d4b..b9fabe269fd2
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -74,6 +74,7 @@ struct imx_rproc_dcfg {
> >  	u32				src_mask;
> >  	u32				src_start;
> >  	u32				src_stop;
> > +	u32				src_started;
> >  	const struct imx_rproc_att	*att;
> >  	size_t				att_size;
> >  };
> > @@ -85,6 +86,7 @@ struct imx_rproc {
> >  	const struct imx_rproc_dcfg	*dcfg;
> >  	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
> >  	struct clk			*clk;
> > +	bool				early_boot;
> >  };
> >
> >  static const struct imx_rproc_att imx_rproc_att_imx7d[] =3D { @@ -142,=
6
> > +144,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx7d =3D {
> >  	.src_mask	=3D IMX7D_M4_RST_MASK,
> >  	.src_start	=3D IMX7D_M4_START,
> >  	.src_stop	=3D IMX7D_M4_STOP,
> > +	.src_started	=3D IMX7D_ENABLE_M4,
> >  	.att		=3D imx_rproc_att_imx7d,
> >  	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx7d),
> >  };
> > @@ -151,6 +154,7 @@ static const struct imx_rproc_dcfg
> imx_rproc_cfg_imx6sx =3D {
> >  	.src_mask	=3D IMX6SX_M4_RST_MASK,
> >  	.src_start	=3D IMX6SX_M4_START,
> >  	.src_stop	=3D IMX6SX_M4_STOP,
> > +	.src_started	=3D IMX6SX_ENABLE_M4,
> >  	.att		=3D imx_rproc_att_imx6sx,
> >  	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx6sx),
> >  };
> > @@ -162,6 +166,9 @@ static int imx_rproc_start(struct rproc *rproc)
> >  	struct device *dev =3D priv->dev;
> >  	int ret;
> >
> > +	if (priv->early_boot)
> > +		return 0;
> > +
> >  	ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> >  				 dcfg->src_mask, dcfg->src_start);
> >  	if (ret)
> > @@ -177,6 +184,9 @@ static int imx_rproc_stop(struct rproc *rproc)
> >  	struct device *dev =3D priv->dev;
> >  	int ret;
> >
> > +	if (priv->early_boot)
> > +		return 0;
> > +
> >  	ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> >  				 dcfg->src_mask, dcfg->src_stop);
> >  	if (ret)
> > @@ -240,10 +250,167 @@ static void *imx_rproc_da_to_va(struct rproc
> *rproc, u64 da, int len)
> >  	return va;
> >  }
> >
> > +static int imx_rproc_elf_load_segments(struct rproc *rproc,
> > +				       const struct firmware *fw) {
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +
> > +	if (!priv->early_boot)
> > +		return rproc_elf_load_segments(rproc, fw);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_rproc_mem_alloc(struct rproc *rproc,
> > +			       struct rproc_mem_entry *mem) {
> > +	struct device *dev =3D rproc->dev.parent;
> > +	void *va;
> > +
> > +	dev_dbg(dev, "map memory: %p+%x\n", &mem->dma, mem->len);
> > +	va =3D ioremap_wc(mem->dma, mem->len);
> > +	if (IS_ERR_OR_NULL(va)) {
> > +		dev_err(dev, "Unable to map memory region: %p+%x\n",
> > +			&mem->dma, mem->len);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Update memory entry va */
> > +	mem->va =3D va;
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_rproc_mem_release(struct rproc *rproc,
> > +				 struct rproc_mem_entry *mem)
> > +{
> > +	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
> > +	iounmap(mem->va);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_rproc_parse_fw(struct rproc *rproc, const struct
> > +firmware *fw) {
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +	struct resource_table *resource_table;
> > +	struct device_node *np =3D priv->dev->of_node;
> > +	struct of_phandle_iterator it;
> > +	struct rproc_mem_entry *mem;
> > +	struct reserved_mem *rmem;
> > +	int index =3D 0;
> > +	int elems;
> > +	int ret;
> > +	u64 da;
> > +
> > +	if (!priv->early_boot)
> > +		return rproc_elf_load_rsc_table(rproc, fw);
>=20
> Once again I will concentrate on the scenario rather than making comments
> on the code.
>=20
> If I understand correctly if the AP is responsible for loading the firmwa=
re and
> starting the MCU, the ELF image contains a resource table that describes =
all
> the memory areas and vdev needed.

This is just make sure the original code to support i.MX6SX/i.MX7D work
which added by Pengutronix.

>=20
> Otherwise the MCU firmware that is preloaded by the boot loader or the SC=
U

NXP released firmware will be preloaded and booted by bootloader or SCU
in different SoCs depends on hardware design.

> does _not_ have a resource table and as such specifics need to be coming
> from the DT.
>=20
> Is my assesment correct?

Yes. Correct.

Regards,
Peng.

>=20
> > +
> > +	/* Register associated reserved memory regions */
> > +	of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
> > +	while (of_phandle_iterator_next(&it) =3D=3D 0) {
> > +		rmem =3D of_reserved_mem_lookup(it.node);
> > +		if (!rmem) {
> > +			dev_err(priv->dev, "unable to acquire memory-region\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* No need to translate pa to da */
> > +		da =3D rmem->base;
> > +
> > +		if (strcmp(it.node->name, "vdev0buffer")) {
> > +			/* Register memory region */
> > +			mem =3D rproc_mem_entry_init(priv->dev, NULL,
> > +						   (dma_addr_t)rmem->base,
> > +						   rmem->size, da,
> > +						   imx_rproc_mem_alloc,
> > +						   imx_rproc_mem_release,
> > +						   it.node->name);
> > +
> > +			if (mem)
> > +				rproc_coredump_add_segment(rproc, da,
> > +							   rmem->size);
> > +		} else {
> > +			/* Register reserved memory for vdev buffer alloc */
> > +			mem =3D rproc_of_resm_mem_entry_init(priv->dev, index,
> > +							   rmem->size,
> > +							   rmem->base,
> > +							   it.node->name);
> > +		}
> > +
> > +		if (!mem)
> > +			return -ENOMEM;
> > +
> > +		rproc_add_carveout(rproc, mem);
> > +		index++;
> > +	}
> > +
> > +	/*Parse device tree to get resource table */
> > +	elems =3D of_property_count_u32_elems(np, "rsrc-table");
> > +	if (elems < 0) {
> > +		dev_err(&rproc->dev, "no rsrc-table\n");
> > +		return elems;
> > +	}
> > +
> > +	resource_table =3D kzalloc(elems * sizeof(u32), GFP_KERNEL);
> > +	if (!resource_table)
> > +		return PTR_ERR(resource_table);
> > +
> > +	ret =3D of_property_read_u32_array(np, "rsrc-table",
> > +					 (u32 *)resource_table, elems);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rproc->cached_table =3D resource_table;
> > +	rproc->table_ptr =3D resource_table;
> > +	rproc->table_sz =3D elems * sizeof(u32);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct resource_table *
> > +imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
> > +				    const struct firmware *fw)
> > +{
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +
> > +	if (!priv->early_boot)
> > +		return rproc_elf_find_loaded_rsc_table(rproc, fw);
> > +
> > +	return NULL;
> > +}
> > +
> > +static int imx_rproc_elf_sanity_check(struct rproc *rproc,
> > +				      const struct firmware *fw)
> > +{
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +
> > +	if (!priv->early_boot)
> > +		return rproc_elf_sanity_check(rproc, fw);
> > +
> > +	return 0;
> > +}
> > +
> > +static u32 imx_rproc_elf_get_boot_addr(struct rproc *rproc,
> > +				       const struct firmware *fw) {
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +
> > +	if (!priv->early_boot)
> > +		return rproc_elf_get_boot_addr(rproc, fw);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct rproc_ops imx_rproc_ops =3D {
> >  	.start		=3D imx_rproc_start,
> >  	.stop		=3D imx_rproc_stop,
> >  	.da_to_va       =3D imx_rproc_da_to_va,
> > +	.load		=3D imx_rproc_elf_load_segments,
> > +	.parse_fw	=3D imx_rproc_parse_fw,
> > +	.find_loaded_rsc_table =3D imx_rproc_elf_find_loaded_rsc_table,
> > +	.sanity_check	=3D imx_rproc_elf_sanity_check,
> > +	.get_boot_addr	=3D imx_rproc_elf_get_boot_addr,
> >  };
> >
> >  static int imx_rproc_addr_init(struct imx_rproc *priv, @@ -309,6
> > +476,31 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
> >  	return 0;
> >  }
> >
> > +static int imx_rproc_configure_mode(struct imx_rproc *priv) {
> > +	const struct imx_rproc_dcfg *dcfg =3D priv->dcfg;
> > +	struct device *dev =3D priv->dev;
> > +	int ret;
> > +	u32 val;
> > +
> > +	if (of_get_property(dev->of_node, "early-booted", NULL)) {
> > +		priv->early_boot =3D true;
> > +	} else {
> > +		ret =3D regmap_read(priv->regmap, dcfg->src_reg, &val);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to read src\n");
> > +			return ret;
> > +		}
> > +
> > +		priv->early_boot =3D !!(val & dcfg->src_started);
> > +	}
> > +
> > +	if (priv->early_boot)
> > +		priv->rproc->skip_fw_load =3D true;
> > +
> > +	return 0;
> > +}
> > +
> >  static int imx_rproc_probe(struct platform_device *pdev)  {
> >  	struct device *dev =3D &pdev->dev;
> > @@ -347,27 +539,33 @@ static int imx_rproc_probe(struct
> > platform_device *pdev)
> >
> >  	dev_set_drvdata(dev, rproc);
> >
> > -	ret =3D imx_rproc_addr_init(priv, pdev);
> > -	if (ret) {
> > -		dev_err(dev, "failed on imx_rproc_addr_init\n");
> > +	ret =3D imx_rproc_configure_mode(priv);
> > +	if (ret)
> >  		goto err_put_rproc;
> > -	}
> >
> > -	priv->clk =3D devm_clk_get(dev, NULL);
> > -	if (IS_ERR(priv->clk)) {
> > -		dev_err(dev, "Failed to get clock\n");
> > -		ret =3D PTR_ERR(priv->clk);
> > -		goto err_put_rproc;
> > -	}
> > +	if (!priv->early_boot) {
> > +		ret =3D imx_rproc_addr_init(priv, pdev);
> > +		if (ret) {
> > +			dev_err(dev, "failed on imx_rproc_addr_init\n");
> > +			goto err_put_rproc;
> > +		}
> >
> > -	/*
> > -	 * clk for M4 block including memory. Should be
> > -	 * enabled before .start for FW transfer.
> > -	 */
> > -	ret =3D clk_prepare_enable(priv->clk);
> > -	if (ret) {
> > -		dev_err(&rproc->dev, "Failed to enable clock\n");
> > -		goto err_put_rproc;
> > +		priv->clk =3D devm_clk_get(dev, NULL);
> > +		if (IS_ERR(priv->clk)) {
> > +			dev_err(dev, "Failed to get clock\n");
> > +			ret =3D PTR_ERR(priv->clk);
> > +			goto err_put_rproc;
> > +		}
> > +
> > +		/*
> > +		 * clk for M4 block including memory. Should be
> > +		 * enabled before .start for FW transfer.
> > +		 */
> > +		ret =3D clk_prepare_enable(priv->clk);
> > +		if (ret) {
> > +			dev_err(&rproc->dev, "Failed to enable clock\n");
> > +			goto err_put_rproc;
> > +		}
> >  	}
> >
> >  	ret =3D rproc_add(rproc);
> > @@ -379,7 +577,8 @@ static int imx_rproc_probe(struct platform_device
> *pdev)
> >  	return 0;
> >
> >  err_put_clk:
> > -	clk_disable_unprepare(priv->clk);
> > +	if (!priv->early_boot)
> > +		clk_disable_unprepare(priv->clk);
> >  err_put_rproc:
> >  	rproc_free(rproc);
> >
> > @@ -391,7 +590,8 @@ static int imx_rproc_remove(struct platform_device
> *pdev)
> >  	struct rproc *rproc =3D platform_get_drvdata(pdev);
> >  	struct imx_rproc *priv =3D rproc->priv;
> >
> > -	clk_disable_unprepare(priv->clk);
> > +	if (!priv->early_boot)
> > +		clk_disable_unprepare(priv->clk);
> >  	rproc_del(rproc);
> >  	rproc_free(rproc);
> >
> > --
> > 2.16.4
> >
