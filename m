Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6C2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DC52073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gHme3gHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgGVClG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 22:41:06 -0400
Received: from mail-db8eur05on2052.outbound.protection.outlook.com ([40.107.20.52]:13318
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731614AbgGVClF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 22:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alWA/zxBStmvg9KYlczUUnAC1b4qsZByPco7ZPQ0Wio0u0BJcQ6HZOhOaw7osrx7WnsZA8Jzb5wOsdWulG0oi1jpLME+/QBYsRjMzd0f90sfT+QTfzPNEPrY+vSRB2W8ne0lUP52qcNrn4j5WmqKmFHJIII6uJ7LCRWdrbBku+xEcylHp+/D5btF6P7XHH3byJ8oim+4SFwWYBFndo/k3xUcG2uniCoHOl4BGrQwuuoCaT9ayTFV8pgMF9GEIAIZyhIzDX3cG0qCtJNEDgWSLQPa3yV9sq73MYzUEYu45xzWCP5kP0xEcsTMHgk6qIZme6IRUWgTcQetCvnHLS/S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hz3E/Qtj2ImsW96GJbNeUoAHWQmM7eFtPy3EfAgf+8=;
 b=kRXU6fToHZ2Ziqs5afOPLRAWMBOvKs2eBLNQbjX424R2WIooKTJ2/iXsI2+xiRFQnWksasyXhM4Wyu83UvckN6VEIZFV6rLe1UG3nrK+J+rNDw5Z5lGfUqIgTzVPwUAVoZ13TV5jikvZWyM/dz/Jx+msu22VNOMhWYHcElOy8WTLVdxCNqw+T+YKpxoElCCzXJkLqUQFIOB/pVDgQJ1q9f86v2A5iyIpGCToU8AUDoPYTbN5k20iL4/72JXc5XeGfQF/8hJv/B/xdAPDDrKaB23+NUXluy6yxRofHMaMXmqAIzRojG0b7UVNcOL+bGiPENlWRkC469vz+enWHFLTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hz3E/Qtj2ImsW96GJbNeUoAHWQmM7eFtPy3EfAgf+8=;
 b=gHme3gHy3JB3fVqJPve0X90gJPlJfe8GYscyK5rZ6/z9LJikjDIR39pyv33i6B49rJ3ES6GtHudxfO/SAV31YOJbeAx4t9nIN38f5hwMRGjZy/rliMyaj5mIDD6PUvCruHpLUhL7YlOZUhXkNcADF1x5SFF4ooHWOtnL5I5yXVY=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5318.eurprd04.prod.outlook.com (2603:10a6:20b:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 02:41:01 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.027; Wed, 22 Jul 2020
 02:41:01 +0000
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
Subject: Re: [PATCH v2 7/9] usb: cdns3: core: removed 'goto not_otg'
Thread-Topic: [PATCH v2 7/9] usb: cdns3: core: removed 'goto not_otg'
Thread-Index: AQHWWP1HOtuwuNPaqEyD/5ami1y3VqkS8QyA
Date:   Wed, 22 Jul 2020 02:41:01 +0000
Message-ID: <20200722024051.GF5807@b29397-desktop>
References: <20200713100554.28530-1-pawell@cadence.com>
 <20200713100554.28530-8-pawell@cadence.com>
In-Reply-To: <20200713100554.28530-8-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2d439d4-d47e-402d-3640-08d82de8ac3a
x-ms-traffictypediagnostic: AM6PR04MB5318:
x-microsoft-antispam-prvs: <AM6PR04MB5318750FC355BCF4D68B92878B790@AM6PR04MB5318.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqkVVztIZtT4DiM0BEcY2CZ1YWt3V9vRdCIcg/PZB5iqeRiszcsoDkSvRRwfDeAVmYWKZp3BKRc9voz75k/Y1uRrewSvi5sVCCm5wDmNzhvsjOnuCemdlyFOxnTdYgUPXOTIbxDKSg5rJy8X6RJ5tlDsCWKH9fKP6vWqHDfyBuGkc8AhlUJ4+POsjDCV1Gr49SO/uUiNeETNOe8u9dAuEsltI8b+jVdWM2oAorLQFzElzizs7FX74bQNWhLhWQAsOmDY5aB/6eiKJORPRx4YVEEKRcUJASuMbCLW3cP2FwArT8bIG5XH6maJ/aJQneLk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(366004)(39860400002)(346002)(396003)(376002)(136003)(4326008)(478600001)(6916009)(8936002)(86362001)(8676002)(186003)(1076003)(26005)(71200400001)(33656002)(5660300002)(66476007)(83380400001)(6486002)(33716001)(91956017)(76116006)(2906002)(44832011)(66946007)(66556008)(64756008)(66446008)(54906003)(6512007)(7416002)(53546011)(6506007)(316002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3vLS91/nY3gzTWZz8sFwaEZ1hQOp8wBokq1DbKavBEcOzC9sMzELM4OBrZ7oJhDzGRuinu8KSgmhIHWxKrnnb2swfdvg0xhQuHxjfznFeFd1nK86whUIPhySKJvgOafmHC4aICNeI1kWEJOAdIwhJOy9fBM+eLLvm59DznzjrOhvYw3mWJMnii+N8adLAPTg1AhyAfLztB72Eo6uAvJWg7jJiuCZvcQPTBwbm6QWYQHhxzS8G55YJehPf4uGl9SvMqHiqjHkWoLlwPnEf7ouBquyf1reg8GE8+OwnfU5TJdK/3shqXvIsbc7+uMMfzW+yrWmP6mdzCE+pZf6cjmqVGuOCvKsISxfVRJjw07kNJV6IVaxuAT23dYgyG9OB9u5Mykf9JPHBoKy2D1DSVfKM4d9MQQYuhpTcefZ+7fmL+RjPxpGG6upt5Jsww6P7gIdb3eH20ateRocif+ou6Pu6aQ0n7meCte1TlkRJBgDXqwB7jL1Ft77ztue9su6X0Fe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E11D0E8FAE001341B638A777DDF2A713@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d439d4-d47e-402d-3640-08d82de8ac3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 02:41:01.7038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8M44x0BE4TT05yHeoD3yQ6GAL3BbAvb4Piw73eN/GQVuSdNJMSPFWoMLPdAiTuoWCsKuEMYvODKNseejMPt0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-13 12:05:52, Pawel Laszczak wrote:
> Patch removes 'goto not_otg' instruction from
> cdns3_hw_role_state_machine function.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index c498b585eb13..8e3996f211a8 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -191,11 +191,17 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>   */
>  static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
>  {
> -	enum usb_role role;
> +	enum usb_role role =3D USB_ROLE_NONE;
>  	int id, vbus;
> =20
> -	if (cdns->dr_mode !=3D USB_DR_MODE_OTG)
> -		goto not_otg;
> +	if (cdns->dr_mode !=3D USB_DR_MODE_OTG) {
> +		if (cdns3_is_host(cdns))
> +			role =3D USB_ROLE_HOST;
> +		if (cdns3_is_device(cdns))
> +			role =3D USB_ROLE_DEVICE;
> +
> +		return role;
> +	}

Would you please improve it a bit like below:

	if (cdns->dr_mode !=3D USB_DR_MODE_OTG) {
		if (cdns3_is_host(cdns))
			role =3D USB_ROLE_HOST;
		else if (cdns3_is_device(cdns))
			role =3D USB_ROLE_DEVICE;
		else
			role =3D USB_ROLE_NONE;

		return role;
	}

Peter
> =20
>  	id =3D cdns3_get_id(cdns);
>  	vbus =3D cdns3_get_vbus(cdns);
> @@ -232,14 +238,6 @@ static enum usb_role cdns3_hw_role_state_machine(str=
uct cdns3 *cdns)
>  	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> =20
>  	return role;
> -
> -not_otg:
> -	if (cdns3_is_host(cdns))
> -		role =3D USB_ROLE_HOST;
> -	if (cdns3_is_device(cdns))
> -		role =3D USB_ROLE_DEVICE;
> -
> -	return role;
>  }
> =20
>  static int cdns3_idle_role_start(struct cdns3 *cdns)
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
