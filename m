Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C0B20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BpIXhj0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHMJZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:25:25 -0400
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:15602
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgHMJZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRX5u38IUv4oADks2rEn5TVaz778o4t9yH0r0uG/zRQbhF97YHC//1pSFt/bgdvmYQcY8g2L8cZ6X/CVWWFbprTzrSHyunbfkeKwmfOoyXmVkyQFRSDk0HPgiThAa+ZdSmBp24TL3OTJhpNDR9FKryDPLo0si21jOEi0RncNYf2AnEL8iwZR/RT1JSsaZjBSowM7XxkW8Y+twuW4Z93u9W+40OmwUZE2Rhe40/6UwnHx48nHobml03mY5ja4fJ86rCSXkL/ARLujvEffRNxtoQ6GEqNI6fAHz1mVoR2fVXrNNhV2AcMoct50mTPeUdRiPDUg6ATFdQQHqlpPkbrbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/nor7Ae7qwD7yTZm6g3LFn2ToCW1DvVnc/UzgwVSQo=;
 b=ExIUFyzA3+bCqm3Qc4oJ2Nn2zRlFQ332xi0dJgbjq8cC8fT3gGI+K+kKil3Z3FQaij8+zsf50a+KqVaXZewrGnuzBODAPJ3GWICDxArQDjIKmM40Rq2Lwqk0gkS+nP7kBIJqpY5ovLGM7VEpzxDsQaVbxdKlC79+sN+Ev8GbcXictlbKKRbuh6asdFtQhzbWQZCq5+fFrajO17rs6TpfNayzi7kshurnhT5LbFtb5DSVjqlWpPff2/y/6HYd5w0Hmr0tyxa+EyqWsnDQjLZYHOG7MxQ3cuRh0jpAc6u6d97SD0/SfOOYvTLn8SvHs2DGPL4yp+wpCkBMp91OOvxsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/nor7Ae7qwD7yTZm6g3LFn2ToCW1DvVnc/UzgwVSQo=;
 b=BpIXhj0wJx+V/FBYSDGWe+KvMZAMxIjAGszC7tRDwStvsrZK7+XAYCn/8YcIUCpNnNCq4d8duIPahrZFlrYbxLBATqtgERh2r1z7O6Vf6ybYchjW5v1iyt2ee9OH5X8g0i5Hx6avszoC9t4v1jt5AQrM3F4BwRq1AJ52LDrzDKY=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4166.eurprd04.prod.outlook.com (2603:10a6:209:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 09:25:21 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::ed7f:8755:5994:7fcf]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::ed7f:8755:5994:7fcf%5]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 09:25:21 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH] usb: cdns3: Removes duplicated call to the
 cdns3_exit_roles function
Thread-Topic: [PATCH] usb: cdns3: Removes duplicated call to the
 cdns3_exit_roles function
Thread-Index: AQHWcUEJ2HYKtjM4M0WllTS952Uv86k1xJSA
Date:   Thu, 13 Aug 2020 09:25:20 +0000
Message-ID: <20200813092429.GA22195@b29397-desktop>
References: <20200813071054.25837-1-pawell@cadence.com>
In-Reply-To: <20200813071054.25837-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e0dc348-d883-4042-d89c-08d83f6acd02
x-ms-traffictypediagnostic: AM6PR04MB4166:
x-microsoft-antispam-prvs: <AM6PR04MB4166FEE4F0A15D448621E4A38B430@AM6PR04MB4166.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhQ/cwmRskIfKf5qJ1FgjvbnWzIoERErsJOe0sXuWs6+q/IrCXsMceDsQ74q4GZr4TS27BBHGlwBY/sEPCnHxifMzo7TSK7U/IvtYmZWDDbHsaqlWHFhtYI7LQRPFr+UCTRFJrfswl2W0QL5gM/6OJ+koVFDfMFSyrEiju8pxPuz+/poRPG3yGZ1cjOyiNFX1BCi+R0HJQZCkk/QEgCBvHQVWNRggRaDhVaL+p92chKRuFcXh103zpkxRTBZyqjrIGKPJ7YqbAplCRwwcxNr8sWIt24cWUsvdsdSwSJ9VRlLoj6/GSR5rsaUxNaVQvkSpJivmtoUeWLEqBs4bVRAJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(8936002)(8676002)(44832011)(6506007)(6512007)(71200400001)(7416002)(54906003)(33656002)(9686003)(316002)(53546011)(26005)(6916009)(186003)(66946007)(33716001)(66446008)(478600001)(91956017)(76116006)(83380400001)(6486002)(86362001)(66476007)(2906002)(66556008)(64756008)(5660300002)(4326008)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Vl6RF+7bOXsJTwiAnKY5YsTqScZn1UiBnsu8PFPWqpAJzmgtNUQBOyvpz6zOr4EwNxqiX8VYpfNGwYSMNe4WpmGb48JV7IdrtOOHTSMvy4YxHVGf1OmkiIhJDBgL2TOI+hnaJminlwN7gYiQbmYpkXe+0UFaUGrV28zpgl13xNfmEcTGvPOChqvn++AZVPwB7nDiXObTy7r+DYmrzuH0Gf/40TyTNVzA1WHBlkMjEo8GNoMMwBFwrrgyInPrO6b/ruM2X0s0YpvHd7NT+S26at2QOOECZsvr7Zt/Q19LYeJa15kYmZkb0dmenbBdmzhCUe9mvzozre2emy3Q6HYIh60V7SzZsFwWjjKGmvsZGz0FLjL3YQ8kJCvSAhpnxus/u1/Zh64lXAqLVzqZ9zl9xPWyyodWOl3oVuascUagl8uKUDAKpFq8Rj1mwYpp9xwF8bbpY+Uk/iYAWm8/ruWaHL0Rc8tzi/hfEtomrIegX8rKg3+j16JFeMQLCVx8WIcsrJD3m4UZCctJiLjxlHExJ5BAMr4pxdC8LQMgMw9cz8UzswIb+EU0bWT73T15owymoYQbSn+xpapD4J4nIDNzfzpvEJ0nilqjaP2DjckBa3EyMUgzjIQ5qX8ZeGb/zPx6ZAozNsS/NdBqh0KSnUC4yA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <949C84F919CAF14486D9A3FA45AC3F01@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0dc348-d883-4042-d89c-08d83f6acd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 09:25:20.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndbY2lE+kdWY/k+esyRkxarNwBkuMyi5Z4dbldMhd4hj166K58eDPP31Xr9WJnN1KtSsrPiguljE9uXGTs2hgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-13 09:10:54, Pawel Laszczak wrote:
> To avoid double calling of function cdns3_exit_roles when initialization
> failed
need ","

> patch removes invoking this function from cdns3_core_init_role.
> This function is invoked again from cdns3_probe when
> cdns3_core_init_role returns error code.

If you delete the cdns3_exit_roles here, where it will be called again?
I only see cdns3_exit_roles is called at .remove callback.

Peter
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 5c1586ec7824..c22c7224642a 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -132,7 +132,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  		if (ret) {
>  			dev_err(dev, "Host initialization failed with %d\n",
>  				ret);
> -			goto err;
> +			return ret;
>  		}
>  	}
> =20
> @@ -141,7 +141,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  		if (ret) {
>  			dev_err(dev, "Device initialization failed with %d\n",
>  				ret);
> -			goto err;
> +			return ret;
>  		}
>  	}
> =20
> @@ -149,38 +149,34 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
> =20
>  	ret =3D cdns3_drd_update_mode(cdns);
>  	if (ret)
> -		goto err;
> +		return ret;
> =20
>  	/* Initialize idle role to start with */
>  	ret =3D cdns3_role_start(cdns, USB_ROLE_NONE);
>  	if (ret)
> -		goto err;
> +		return ret;
> =20
>  	switch (cdns->dr_mode) {
>  	case USB_DR_MODE_OTG:
>  		ret =3D cdns3_hw_role_switch(cdns);
>  		if (ret)
> -			goto err;
> +			return ret;
>  		break;
>  	case USB_DR_MODE_PERIPHERAL:
>  		ret =3D cdns3_role_start(cdns, USB_ROLE_DEVICE);
>  		if (ret)
> -			goto err;
> +			return ret;
>  		break;
>  	case USB_DR_MODE_HOST:
>  		ret =3D cdns3_role_start(cdns, USB_ROLE_HOST);
>  		if (ret)
> -			goto err;
> +			return ret;
>  		break;
>  	default:
> -		ret =3D -EINVAL;
> -		goto err;
> +		return -EINVAL;
>  	}
> =20
>  	return 0;
> -err:
> -	cdns3_exit_roles(cdns);
> -	return ret;
>  }
> =20
>  /**
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
