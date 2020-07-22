Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28962077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Df13hatx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbgGVAex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:34:53 -0400
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:8398
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgGVAex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L40mm7LgMravz/SEPySfFDLnqws9Bxchpv2efSgqvKGQy4c5Y4ZjEWAQjWY5qZPfsXCx0QmicrQTvLSO0pPQScsNprys3a+I1jZO339KyE60Uc6apAP/Z/XitPNiJT5DDtc/sj6Zohyx3TICR/ubolIpXTFJKVhdRp22y9a3kYhbcoqz2lRJ6Vlnqxc6VxV3yw3lFis66ai5ojhXjAG3HNxduh4b3KbIelxeFAMZaCWKSd7te763vfHQprPLnSek/bp0w/36LdLtj9hLmtkTkKXtB32klFuidBdU9aaRiAZ3U+WQj6SHFu4/Uz8EzPVrce+vuNIHNwOOH8115GtGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q08i8TgpAfZssDPAyFyCKPwwguvIPnxVmVLZie23WVE=;
 b=c8hQR3H9Rsl/JrJ4l9oyiazci1QYjmNLfmV3ZSNzBCJBj/SZ0C94/daxbp8dZHzwdpfuxcsd/mmnPmpFczblfgOdmK05VcWN+fwRQpbc2mBaH9vooOotc+FKyI9bTeWra4bnWi4RwW1Dvmp40NtDj8yZFQOxN+FTuxb2DxMsV/839vcqi349Ia0CcT/u+jBAkM4lXG4N/N/JI6Ic4/tz1T/gCw+U99wSPbjM4fQVNV7LFzCS+V6qvUfC4igGOzpykdsV3WwbpeNR2dpeV7wJZaljDZ7rwE1AobaZxZdbdT0Q2B1tG3oJFGc1ROhpHv0V8ZOERecVJ2oieyguvdFh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q08i8TgpAfZssDPAyFyCKPwwguvIPnxVmVLZie23WVE=;
 b=Df13hatxIrizUkdieHLbt44Wp+guHh3DYqkxCe5yj3VhgYLP8W47rrYFdP1DPINzNBxBNtuNbm0ePYuX/jyBcWm6E0YymHXy98yyDAkfeoAEBEZXx5h8Hi6vscIr6hbBMgjl3jOWrlHk1SqntQlsThEX/48uLfDEoMIwXKiDkqE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6440.eurprd04.prod.outlook.com (2603:10a6:20b:f4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 22 Jul
 2020 00:34:50 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.027; Wed, 22 Jul 2020
 00:34:50 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH v2 3/9] usb: cnds3: drd: deleted !=
Thread-Topic: [PATCH v2 3/9] usb: cnds3: drd: deleted !=
Thread-Index: AQHWWP1Gr9U+jhl6R0eCVw9AqHDt2qkSzcoA
Date:   Wed, 22 Jul 2020 00:34:49 +0000
Message-ID: <20200722003440.GB5807@b29397-desktop>
References: <20200713100554.28530-1-pawell@cadence.com>
 <20200713100554.28530-4-pawell@cadence.com>
In-Reply-To: <20200713100554.28530-4-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f0689a4-2efa-4b18-fb7d-08d82dd70b2a
x-ms-traffictypediagnostic: AM6PR04MB6440:
x-microsoft-antispam-prvs: <AM6PR04MB644037179B36EF438CFC1B498B790@AM6PR04MB6440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DijX2eaKlCV6SsHD4jbVktALcSurABPp/xJci3WL7WdEoBHDD5H8Ev0IVYDhcuMIzm2oya6dIcbp7kFPSbfPFg00G5jF00kP/5ndJ+q7ytXE8hJe3SMC2oH+imHUiEjeO2lSaLv4G9DLFwbBD5gvEbFmFD64Xcc68fwLAVsN4FfDuiP59+Onct6mT98JuuhUNysvZ7yePvoe+J0I2vhcbJZqL4LUGQqmRHjTYmVYYJF0fcTYUQiZuyIm0LcYzosIfZD8sbwOelLUf6964mewUPpc44UINlKFujJVHw70TNG44aZ4/HTvs5UCp6Qvrrl0Pe8rhQgS6X7pY/E/Igfx6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(6486002)(33656002)(6916009)(478600001)(6506007)(4326008)(7416002)(186003)(53546011)(26005)(91956017)(76116006)(64756008)(86362001)(316002)(44832011)(8936002)(71200400001)(33716001)(66556008)(54906003)(8676002)(2906002)(4744005)(9686003)(6512007)(66946007)(66476007)(66446008)(83380400001)(1076003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6L7Eeh2eN0ob7kuDJxZ6aOYqb4d5LAnJrO1us37jC9Pv2BrnS5zD0fMchlTmNT0GCfmQ2o1d4krgLmNYPSmR0B+qUVtP/jJXsmjOr8F4IvmyfJvZbptKzBYJ8shgl4w3fLdA4k0+jWfTu756SFxCJeCsXlwffgUlgCpbhqhSIxNFn/+FLOWp576m8B7pZPD6QZxQPL3Z5k56mVjXodsdJiqSGzGmQjgDUxYLvClvQ45CDvCWlNdqtHUyrT+6FrCKTU5OakZBSFB8FiVFy1ACpVfgSr0PUzl2LHA4UJv/376sHh+8eUT02pBt6Uqr0TOiyqW9ohcgg4fORE2Ax8bDb5ti0CSU0Wi76XGzfZyIsBomLcxpfbOcY9AB0EVxqlMPk21CFjCdjmRrbAK6BtD6HqnxJaq4KZkvsPN3ZFnIbs0E6S/sNcmT65YSNRKp1GP87TOEWDNtqW9F4NvZQMLTjfQKPbLoBvpLbmamqIXwia3IwD0jsjqJ8GRngbPpl1K1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA45C8C7978FD541A3DD3FA3B103ED71@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0689a4-2efa-4b18-fb7d-08d82dd70b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 00:34:49.9986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5ACnIhF4fTBKcelPK3QsqoOdEDi+WZApuTaJAhZ+W1IVl3vYgwdfMm0IgXyBYeE+nle2zE/jZIGuvl9l6NvyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-13 12:05:48, Pawel Laszczak wrote:
> Patch deletes unnecessary !=3D from condition statement in cdns3_drd_init
> function.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

> ---
>  drivers/usb/cdns3/drd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 4939a568d8a2..6d2da504ad49 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -365,7 +365,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
>  	}
> =20
>  	state =3D readl(&cdns->otg_regs->sts);
> -	if (OTGSTS_OTG_NRDY(state) !=3D 0) {
> +	if (OTGSTS_OTG_NRDY(state)) {
>  		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>  		return -ENODEV;
>  	}
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
