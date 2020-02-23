Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A1C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F120208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jnTHWOW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBWABo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 19:01:44 -0500
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:22401
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726881AbgBWABn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 19:01:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1Ocl/eyCAo0o4avnpq5ecN9yDL5TH6E/hiMP/5DbZF+YGW7BstieX6zdsk/8U1EbXRko4CZ+tLJX5jRSTXRWIrWGfHrG/zyXiWuVJOwrCCUEGY+twpykwcqPzKo2PqgaUfqLYiiVaGwy42ViWuKIRHwrMn4GbphD6wA4ZdwH7eYx8QEmj8Hp60mVzugAcfW9gWTA4LKzKYwI61QcFb2TZPj/LnvY5VhkAIGxEJKQpvzhD2PF2EK2L5BRxR88jL2FL+GSr/F7J4DyTJs9k44g7qIfVSPiy+m0Wnci6fLRFf2YWoY4KiLTptB9lyD1H+xcP0WXsCP4ozoDS58GaIGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwE/mmrHGrzg8quN3M2ttt3p23R1oFXKNG8rqxD47jc=;
 b=IpJzCqIBUppgbM25LZVVgxrpblhCjrPV2oHwEIaT21dhyDvZEZmFwAFgENdWlfVL4h0XyWaSpM8YrO14und9UwIVCre4oKFfVcownIoS36/SfGoi4k+Pto4t/JnziQwH5d2t2VAbsvF/QHZilzkYcPvyh2xM7xiu0q0epnEW+JTdMCCLcnfEJlnL5TP6mwNilQpzcZobi+d2H794PE0tkmJV4bThHqNECgpUGD2PRkVEPLzCwA9Rq5/BwPJFAGcOXxmtaCNiCpJLlF3AAFIj3dbP3ifMiZONi859hhq4KmTbp6hZZoRnkZ4ksyVu+yfLghYk+jKfxP6vubNXbWQKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwE/mmrHGrzg8quN3M2ttt3p23R1oFXKNG8rqxD47jc=;
 b=jnTHWOW50KqeAYMTaqgRSDXaVXQB2Ha7VGyde68zB7xvyByZP/FCb40GIDpF8hGqX5A0Vx78AsIRPF1SAWpmnMpXZG7+VyJGEFghposRuv0W504oh6QSCVY4XevLRpIPzP1+IPWXF8OEe0ZPc5Pg8noyRm6h8qIxnF2IyqRe8P8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4785.eurprd04.prod.outlook.com (20.176.215.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Sun, 23 Feb 2020 00:01:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Sun, 23 Feb 2020
 00:01:38 +0000
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
Subject: RE: [PATCH 3/9] remoteproc: add support to skip firmware load when
 recovery
Thread-Topic: [PATCH 3/9] remoteproc: add support to skip firmware load when
 recovery
Thread-Index: AQHV5vbtBcsi7uUDB0+hcFvNM8RaVqgl/3AAgAHq/5A=
Date:   Sun, 23 Feb 2020 00:01:38 +0000
Message-ID: <AM0PR04MB44810B020E8C4F099D8F47A588EF0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-4-git-send-email-peng.fan@nxp.com>
 <20200221184236.GA10368@xps15>
In-Reply-To: <20200221184236.GA10368@xps15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [117.82.241.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 458ee98e-6f4e-45c7-31d9-08d7b7f38e25
x-ms-traffictypediagnostic: AM0PR04MB4785:|AM0PR04MB4785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB478503D2AC58297EB7CA7D2188EF0@AM0PR04MB4785.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0322B4EDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(86362001)(52536014)(81166006)(8676002)(81156014)(8936002)(6916009)(7696005)(4326008)(54906003)(76116006)(66476007)(66946007)(66556008)(7416002)(5660300002)(71200400001)(316002)(64756008)(66446008)(6506007)(44832011)(26005)(186003)(2906002)(33656002)(55016002)(9686003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4785;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L2LsAKB3OMKFCfMX60UD+S3ROmC8lelaat7eu1NAJaE1hWPznZMAajG5yag9iKpZT5j5MDoqQr/lC6WfyfIbQ3PkBDF4hyohUgiEPxsW9yvhGXSEtgHhWhMEuN+JVZltwVCdlyrHFwLqg5k41wWPL6hU+I/2RaZNRtLVU9o7cLzcvtsSpxEHqhq055o/BGyb0H3AmleZtoJ7Uhof9LZhL7bFPfszkk+vaCQz1o0GfVspsVnXPFYgRDp5tqPvN0ZIKx2xZUhmvjNc4bGlWkkfliGaztBL8xGL2pYwMMVNRSl6UTTpVHxjwFyYFDb4rR2Y7CX9O2x0BEGAxsqvhnNkixaXTLM1dkV8e/w0LpsErs3/Utt/Y/LgG4/q6BC4NPOPjjb2S8K7n8k3N1xi7DCunfA3oMAufuAsFX/cf1awoWZZw00MACjUY01boDm+ZmBX
x-ms-exchange-antispam-messagedata: MF6f8pFJx4pAbTJ8sRbTCfGVGfkmTA6zqNG1sgfFzQbxT0wMoU/51bppjga26axigMQiMwfROJDzrQl985Vb7mt/f6SKxA5lZov6uvqOQCRaw2MJtY0Dlx2YGNHJxsyP+me2YqxiWKgJkJ7JwYKeHA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458ee98e-6f4e-45c7-31d9-08d7b7f38e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2020 00:01:38.5073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJovSucEXBk3laAdehfJbRjMtt0TrC5vFmIHN9HbTfPnHJTtrD9RDpkDGWg1YpoH94i3CGPPozgqLdHDRvx/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> Subject: Re: [PATCH 3/9] remoteproc: add support to skip firmware load wh=
en
> recovery
>=20
> Hi Peng,
>=20
> On Wed, Feb 19, 2020 at 03:27:39PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Remote processor such as M4 inside i.MX8QXP is not handled by Linux
> > when it is configured to run inside its own hardware partition by
> > system control unit(SCU). So even remote processor crash reset, it is
> > handled by SCU, not linux. To such case, firmware load should be
> > ignored, So introduce skip_fw_load_recovery and platform driver should
> > set it if needed.
>=20
> For now I will not comment on the code - I just need clarifications on th=
e
> scenario.
>=20
> In the specific case you are trying to address here, I understand that wh=
en the
> M4 crashes, the SCU will recognize that and reload the MCU firmware. Does
> the SCU also start the MCU or is that left to the remoteproc subsystem?

SCU starts M4. Linux has no permission to start/stop M4 from hardware
perspective with hardware partition feature enabled.

Regards,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 19 +++++++++++--------
> >  include/linux/remoteproc.h           |  1 +
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index 876b5420a32b..ca310e3582bf 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1678,20 +1678,23 @@ int rproc_trigger_recovery(struct rproc *rproc)
> >  	if (ret)
> >  		goto unlock_mutex;
> >
> > -	/* generate coredump */
> > -	rproc_coredump(rproc);
> > +	if (!rproc->skip_fw_load_recovery) {
> > +		/* generate coredump */
> > +		rproc_coredump(rproc);
> >
> > -	/* load firmware */
> > -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto unlock_mutex;
> > +		/* load firmware */
> > +		ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > +		if (ret < 0) {
> > +			dev_err(dev, "request_firmware failed: %d\n", ret);
> > +			goto unlock_mutex;
> > +		}
> >  	}
> >
> >  	/* boot the remote processor up again */
> >  	ret =3D rproc_start(rproc, firmware_p);
> >
> > -	release_firmware(firmware_p);
> > +	if (!rproc->skip_fw_load_recovery)
> > +		release_firmware(firmware_p);
> >
> >  unlock_mutex:
> >  	mutex_unlock(&rproc->lock);
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 4fd5bedab4fa..fe6ee253b385 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -514,6 +514,7 @@ struct rproc {
> >  	bool has_iommu;
> >  	bool auto_boot;
> >  	bool skip_fw_load;
> > +	bool skip_fw_load_recovery;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> >  };
> > --
> > 2.16.4
> >
