Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF0C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FC120724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="1dSVjZD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgCQQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:48:07 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:63266 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbgCQQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:48:06 -0400
Received: from [100.113.7.184] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 4E/07-23255-34FF07E5; Tue, 17 Mar 2020 16:48:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRWlGSWpSXmKPExsWSoS+4Ttf5f0G
  cwadt4hZTHz5hs/h2pYPJ4vKuOWwW72/0MjuweGy5Yu+xc9Zddo9NqzrZPD5vkgtgiWLNzEvK
  r0hgzTjW85ytoMG6YnfHatYGxnbDLkZODkaBpcwS8+9kQNjHWCTa7zt2MXIB2ZsZJX73/mQDc
  VgETjBLLFr2lQnEERKYwCTR+u8bC4Rzl1Fi3+43TCD9bAIWEpNPPGADsUUE0iRW34IoYhboYJ
  TY0PmCBSQhLGAs8XIyhC0iYCJxcsMaJgjbSGLOrOlgNouAqsTXLTvBBvEKxErcbZrCDmILCfh
  IrD33B6yXU8BXYs3ZT0wQh8tKfGlczQxiMwuIS9x6Mh8sLiEgILFkz3lmCFtU4uXjf6wQ9akS
  J5tuMELEdSTOXn8CZStKPDz0E8qWlbg0vxvK9pXon9kONIcDyNaSWPvDBiJsIbGku5UFIqwi8
  e9QJYSZI7FynjNEhZrE+4lbWSFsGYltTT1Q9loWiburzCcwGsxCcjOErSOxYPcnNghbW2LZwt
  fMs8DhIChxcuYTlgWMLKsYLZKKMtMzSnITM3N0DQ0MdA0NjXVNdI2M9BKrdJP0Ukt1k1PzSoo
  SgZJ6ieXFesWVuck5KXp5qSWbGIEJKaWQRWwH46y17/UOMUpyMCmJ8gbPKYgT4kvKT6nMSCzO
  iC8qzUktPsQow8GhJMH74i9QTrAoNT21Ii0zB5gcYdISHDxKIry8/4DSvMUFibnFmekQqVOMu
  hwTXs5dxCzEkpeflyolznsWpEgApCijNA9uBCxRX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwa
  gkzOv/B2gKT2ZeCdymV0BHMAEdUbEhH+SIkkSElFQD0+KaX5YX0yJa6quVzi+RT1xzd2Jx19z
  CoiU3Nz6P91i2+8b6Dkb+uRceXzgZadymqKp15ufzrU37HjrLGOVEZB1ecqDHvW0yu9QhhWef
  PWbM1Es0/n7Ud3OASoHkkbr1q2XNcy4e99zj+Viy6d6TIBdVi0sKe3Y/9rycdGLLrjMSqgeiT
  UsMlEXa36VvOMk4y87J4qXu/k4by3b510+mbf+vqXOExzAuVoCRQXlf/NVdHnutYwIyVoULFq
  w6b3vj8pNp3Lu2lV3MOq5UFul/RPzmtgM/lUPYBO91nD3V9H+br3PYC56jqrY2AR48K2ZoyvV
  2bmjrV4lu3fLp1q7Fs2TanS8f/uDyta7qkl70JyWW4oxEQy3mouJEAFSSgLRPBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-249.messagelabs.com!1584463682!1110934!1
X-Originating-IP: [104.47.17.174]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16251 invoked from network); 17 Mar 2020 16:48:03 -0000
Received: from mail-vi1eur05lp2174.outbound.protection.outlook.com (HELO EUR05-VI1-obe.outbound.protection.outlook.com) (104.47.17.174)
  by server-9.tower-249.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Mar 2020 16:48:03 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR80mF5F/qdYJe/9JM31kobyrP3lX+/S4QXusEzcwAkXkWhxfzyz7XynrhcyBX/csuXgYKz6Xeg4D26myI+ZmsdLY8v35yNh94beII0fRHCcoxEJskV941V/WgvdviFPfNBMpMyGbXDJ1iRnQR4ccdV+WC84vsKmpfVhKC1fNJlhbF2DvyWixoLuz+rdSPOPQedx+uwD7YVx2PMMAm2NGkkQorLn1T9bKBfDC8olYA6wFTMwcGojLVGts6Fcfn5MRba9zMCy+drEp+Z4oioJoyXQVmjLs66ZfBHXqP8bqiFYKiBAzOwIZSxXQ8kaO4l0GBVEUn1dE4wqdQorXZFPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CFfhMemm35rSsA3DcNm5KeVWDj/NF0t2OeOw30uJmo=;
 b=MKv2ASJTqxALZXOe5DcZJ7Dq7LuI4aci6lxr2Tf6o8G5ezSc+8XZoJFQI4q4haOLxcX59SOBKWoST+rULuSuGWFQ39dlKHmmU57qbOVoEIqYgvn17ctcTFWFYL3RZe8EObKkX2YtpBdz3WQ6MCICpTWn4dd/27lipq2T1A5XQ44AruEfWh2VzKyzXpvA2hHhwHHKB/JvuiYN3tYiyWCWDJg2/F0dXgpolYa10xA75s2HWHeS83cESlSJ4boPf/9cB1hj46mVFuq9Ul9GY1oo7pYXGJyayYoyj9GxVsXP65wdNERR0OQUKZ6o9PeN+r59Dx2lMApOx87kDi3Z/GjHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CFfhMemm35rSsA3DcNm5KeVWDj/NF0t2OeOw30uJmo=;
 b=1dSVjZD+bQHqE/gxSW9TmLO/P5Ec4dA+bqXxWom52Sv2Ebwu9u+Ut8pLijwGLL1/fiSrg029IZ1UI7FLt2+JRDHVTQWgHgDC/NxE7dCNSRup5YeNvWkxX4JQPboSX+EuUouv9rp3REZl7qpTNq7FtDrhYEhKC0k38IcbXTg4EMk=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2742.EURPRD10.PROD.OUTLOOK.COM (20.179.2.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 16:48:01 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 16:48:01 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Support Opensource <Support.Opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9063: fix suspend
Thread-Topic: [PATCH] regulator: da9063: fix suspend
Thread-Index: AQHV/Hc/w1dnVCMOJ06Dcff89taxrqhM/Mng
Date:   Tue, 17 Mar 2020 16:48:00 +0000
Message-ID: <AM6PR10MB2263CCDAED3D22683B96D91580F60@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <1584461691-14344-1-git-send-email-martin.fuzzey@flowbird.group>
In-Reply-To: <1584461691-14344-1-git-send-email-martin.fuzzey@flowbird.group>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [146.200.71.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06bb5b8e-b76d-48e6-e65c-08d7ca92f4d1
x-ms-traffictypediagnostic: AM6PR10MB2742:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2742124A2240865D2DB2DC4DA7F60@AM6PR10MB2742.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(7696005)(53546011)(6636002)(4326008)(54906003)(6506007)(52536014)(8676002)(110136005)(81156014)(5660300002)(26005)(55236004)(8936002)(81166006)(478600001)(2906002)(9686003)(86362001)(33656002)(316002)(76116006)(55016002)(64756008)(66446008)(186003)(71200400001)(66946007)(66556008)(66476007)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2742;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jev9+E/sqD8KdtuIkmjCIOq12lf6tB/BWgaOHiKGbfZSOil07XWkV2QKYu6Qy2tXaIvaOl9kmQucH+bEHqO0dsU2Bgqla8zZker96hV4ycqD+IHpQC+SON87c0hif1uS8mnDezT8/nnOHACB/H7ZMnTZLZ0Dbms5WYFEsw6vvdlFlgdCTP1I0fafTjrKu4dcAyTqOz3lst396kZk8+rfENCOEdhh7n+jXGDYdPzhXREiDypaSBzI0E90HPu8b5RCHZvb/cEAl9aH3QPaOvKx7bu9e5yWqvuFHcn6ypdB6sOVXdwtsG16E/ig+gFxdZXiFlJtUSaX94U7tYPiDL/DfrX1pIqvQX2HfrLCU501Rue7eaWI/ugj/F+LQjLVPjEbmvj2QIlGd/Cee5TooybvYyVo7d/ntcfiriXhQSKwwW6UweeolbJcGKz4yuht0XgX
x-ms-exchange-antispam-messagedata: cE+g7NAeEWuE5GjQWwDrx1XjFe4v3+/N83Ax6iZy/8U1/eWXx35OMi9+LDzwZYHouLMuGierxA9Q0ml/IMEjv+XxMVeeOqimSS+HLz2kgqmiLVzb0+Kxxm9KmuYMW/anmZrsSxlYaR7C4st7IvOJJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bb5b8e-b76d-48e6-e65c-08d7ca92f4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 16:48:01.4179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpNcXJdw5oGoqJh81kiYDvC9W2jQCuFwTepP+rX5AwiomfGRtllwBprPlhJIsfO3plw3/nVMG4PFSpIZQStRDpgFkSfj3eMtkHhX23/Q3hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 March 2020 16:14, Martin Fuzzey wrote:

> The .set_suspend_enable() and .set_suspend_disable() methods are not
> supposed to immediately change the regulator state but just indicated
> if the regulator should be enabled or disabled when standby mode is
> entered (by a hardware signal).
>=20
> However currently they set control the SEL bits in the DVC registers,
> which causes the voltage to change to immediately between the "A"
> (normal) and "B" (standby) values as programmed and does nothing for
> the enable state...
>=20
> This means that "regulator-on-in-suspend" does not work (the regulator
> is switched off when the PMIC enters standby mode on the hardware
> signal) and, potentially, depending on the A and B voltage
> configurations the voltage could be incorrectly changed *before*
> actually entering suspend.
>=20
> The right bit to use for the functionality is the "CONF" bit in the
> "CONT" register.
> The detailed register description says "Sequencer target state"
> for this bit which is not very clear but the functional description
> is clearer.
>=20
> From 5.1.5 System Enable:
>=20
> 	De-asserting SYS_EN (changing from active to passive state)
> 	clears control SYSTEM_EN  which triggers a power down sequence
> 	into hibernate/standby mode
> 	...
> 	With the exception of supplies that have the xxxx_CONF control
> 	bit asserted, all regulators in power domains POWER1, POWER, and
> 	SYSTEM are sequentially disabled in reverse order.
> 	Regulators with the <x>_CONF bit set remain on but change the
> 	active voltage controlregisters from V<x>_A to V<x>_B
> 	(if V<x>_B is notalready selected).
>=20

Thanks for this. Actually it's very much the same as the changes made for
DA9061/2 regulator driver, as per:

	regulator: da9062: fix suspend_enable/disable preparation
	(commit: a72865f057820ea9f57597915da4b651d65eb92f)

Think we should also update the get_mode() functions for da9063 in a simila=
r
manner, given the updates being made here.=20

> Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
> ---
>  drivers/regulator/da9063-regulator.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-
> regulator.c
> index 2aceb3b..46b7301 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -100,6 +100,7 @@ struct da9063_regulator_info {
>  	.desc.vsel_mask =3D DA9063_V##regl_name##_MASK, \
>  	.desc.linear_min_sel =3D DA9063_V##regl_name##_BIAS, \
>  	.sleep =3D BFIELD(DA9063_REG_V##regl_name##_A, DA9063_LDO_SL), \
> +	.suspend =3D BFIELD(DA9063_REG_##regl_name##_CONT,
> DA9063_LDO_CONF), \
>  	.suspend_sleep =3D BFIELD(DA9063_REG_V##regl_name##_B,
> DA9063_LDO_SL), \
>  	.suspend_vsel_reg =3D DA9063_REG_V##regl_name##_B
>=20
> @@ -124,6 +125,7 @@ struct da9063_regulator_info {
>  	.desc.vsel_mask =3D DA9063_VBUCK_MASK, \
>  	.desc.linear_min_sel =3D DA9063_VBUCK_BIAS, \
>  	.sleep =3D BFIELD(DA9063_REG_V##regl_name##_A, DA9063_BUCK_SL), \
> +	.suspend =3D BFIELD(DA9063_REG_##regl_name##_CONT,
> DA9063_BUCK_CONF), \
>  	.suspend_sleep =3D BFIELD(DA9063_REG_V##regl_name##_B,
> DA9063_BUCK_SL), \
>  	.suspend_vsel_reg =3D DA9063_REG_V##regl_name##_B, \
>  	.mode =3D BFIELD(DA9063_REG_##regl_name##_CFG,
> DA9063_BUCK_MODE_MASK)
> @@ -465,42 +467,36 @@ static int da9063_ldo_set_suspend_mode(struct
> regulator_dev *rdev, unsigned mode
>  			    da9063_buck_a_limits,
>  			    DA9063_REG_BUCK_ILIM_C,
> DA9063_BCORE1_ILIM_MASK),
>  		DA9063_BUCK_COMMON_FIELDS(BCORE1),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
>  	},
>  	{
>  		DA9063_BUCK(DA9063, BCORE2, 300, 10, 1570,
>  			    da9063_buck_a_limits,
>  			    DA9063_REG_BUCK_ILIM_C,
> DA9063_BCORE2_ILIM_MASK),
>  		DA9063_BUCK_COMMON_FIELDS(BCORE2),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE2_SEL),
>  	},
>  	{
>  		DA9063_BUCK(DA9063, BPRO, 530, 10, 1800,
>  			    da9063_buck_a_limits,
>  			    DA9063_REG_BUCK_ILIM_B,
> DA9063_BPRO_ILIM_MASK),
>  		DA9063_BUCK_COMMON_FIELDS(BPRO),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VBPRO_SEL),
>  	},
>  	{
>  		DA9063_BUCK(DA9063, BMEM, 800, 20, 3340,
>  			    da9063_buck_b_limits,
>  			    DA9063_REG_BUCK_ILIM_A,
> DA9063_BMEM_ILIM_MASK),
>  		DA9063_BUCK_COMMON_FIELDS(BMEM),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
>  	},
>  	{
>  		DA9063_BUCK(DA9063, BIO, 800, 20, 3340,
>  			    da9063_buck_b_limits,
>  			    DA9063_REG_BUCK_ILIM_A,
> DA9063_BIO_ILIM_MASK),
>  		DA9063_BUCK_COMMON_FIELDS(BIO),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_2, DA9063_VBIO_SEL),
>  	},
>  	{
>  		DA9063_BUCK(DA9063, BPERI, 800, 20, 3340,
>  			    da9063_buck_b_limits,
>  			    DA9063_REG_BUCK_ILIM_B,
> DA9063_BPERI_ILIM_MASK),
>  		DA9063_BUCK_COMMON_FIELDS(BPERI),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VBPERI_SEL),
>  	},
>  	{
>  		DA9063_BUCK(DA9063, BCORES_MERGED, 300, 10, 1570,
> @@ -508,7 +504,6 @@ static int da9063_ldo_set_suspend_mode(struct
> regulator_dev *rdev, unsigned mode
>  			    DA9063_REG_BUCK_ILIM_C,
> DA9063_BCORE1_ILIM_MASK),
>  		/* BCORES_MERGED uses the same register fields as BCORE1 */
>  		DA9063_BUCK_COMMON_FIELDS(BCORE1),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
>  	},
>  	{
>  		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
> @@ -516,21 +511,17 @@ static int da9063_ldo_set_suspend_mode(struct
> regulator_dev *rdev, unsigned mode
>  			    DA9063_REG_BUCK_ILIM_A,
> DA9063_BMEM_ILIM_MASK),
>  		/* BMEM_BIO_MERGED uses the same register fields as BMEM
> */
>  		DA9063_BUCK_COMMON_FIELDS(BMEM),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VLDO3_SEL),
>  		.oc_event =3D BFIELD(DA9063_REG_STATUS_D,
> DA9063_LDO3_LIM),
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
> -		.suspend =3D BFIELD(DA9063_REG_LDO7_CONT,
> DA9063_VLDO7_SEL),
>  		.oc_event =3D BFIELD(DA9063_REG_STATUS_D,
> DA9063_LDO7_LIM),
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
> -		.suspend =3D BFIELD(DA9063_REG_LDO8_CONT,
> DA9063_VLDO8_SEL),
>  		.oc_event =3D BFIELD(DA9063_REG_STATUS_D,
> DA9063_LDO8_LIM),
>  	},
>  	{
> @@ -539,36 +530,29 @@ static int da9063_ldo_set_suspend_mode(struct
> regulator_dev *rdev, unsigned mode
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
> -		.suspend =3D BFIELD(DA9063_REG_LDO11_CONT,
> DA9063_VLDO11_SEL),
>  		.oc_event =3D BFIELD(DA9063_REG_STATUS_D,
> DA9063_LDO11_LIM),
>  	},
>=20
>  	/* The following LDOs are present only on DA9063, not on DA9063L */
>  	{
>  		DA9063_LDO(DA9063, LDO1, 600, 20, 1860),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VLDO1_SEL),
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO2, 600, 20, 1860),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_1, DA9063_VLDO2_SEL),
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO4, 900, 20, 3440),
> -		.suspend =3D BFIELD(DA9063_REG_DVC_2, DA9063_VLDO4_SEL),
>  		.oc_event =3D BFIELD(DA9063_REG_STATUS_D,
> DA9063_LDO4_LIM),
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO5, 900, 50, 3600),
> -		.suspend =3D BFIELD(DA9063_REG_LDO5_CONT,
> DA9063_VLDO5_SEL),
>  	},
>  	{
>  		DA9063_LDO(DA9063, LDO6, 900, 50, 3600),
> -		.suspend =3D BFIELD(DA9063_REG_LDO6_CONT,
> DA9063_VLDO6_SEL),
>  	},
>=20
>  	{
>  		DA9063_LDO(DA9063, LDO10, 900, 50, 3600),
> -		.suspend =3D BFIELD(DA9063_REG_LDO10_CONT,
> DA9063_VLDO10_SEL),
>  	},
>  };
>=20
> --
> 1.9.1

