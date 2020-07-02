Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AF8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B8206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZYXY8hOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGBJHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:07:49 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:7342
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbgGBJHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:07:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9OgGPWtJ05ElyrBjAnxGDRjAxG7IYnCvQBG0XEEa58LKO1RgWNbyPNbD8UxcrdVwmWmCDVmXd/AbjhMHt7HpquyE2ZtqxC8IGE27N+5YkIgWyy4jY4I2bcPJr17tExO3Ydjb7S7fGeDc1EtZXRshNGq0+AZ7OOTrmaUYhQpr4VJhD6FV0NyLXxhY7oL4exaDaNHnxVFVbIkSI2jlyt/ZW5VzjZkENXAxRU9IRDD3yTeoGNV5vYwr67qn+QB1HhE9kKVlNVqlOeEj3qX63mHV3RYDqRCXE4loPphjgwIMQAVZRGR9+7nJSyvbNYNfGMcjo2RLwKxG2XKkUASRlUvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/keRyV9OT5cfvOusoOSTAnE1iH/T9HxOKRdYzddNtBI=;
 b=OZ551FZ4z7oGmwsgHymRFzWTfA0U99diIQQH4wfgNPV1xH0hwQCOvUn2nk3q2HXuuHkxjtH7cOOT/Cuh3pkei8xVxgqB9nF/VWvUlejdDHdUX9ovqNPRFgdMOqdrNrggRjdJNIp24cngUdK9keMaLn+khlhJ28s48KvnUoMqgwhIon/UM22O2yw7cEHxLxCkkwuwqFT6uzlHhtguvrB4SJWLW3uZuR1PGuInpcGeiI1Cl0ZjOhLNXE16GM8kVVlAzW3MZm4Hds9SrFM5UO4/l+pF1c+I1BInsLILSnQ/yxWp1WK01/PB41caeSgVtc12O6uJq4KNI8cgG1eWvBf8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/keRyV9OT5cfvOusoOSTAnE1iH/T9HxOKRdYzddNtBI=;
 b=ZYXY8hOYoB2Ew/bBbpVBObQIVwDqnKAx/3jI6+zi1DaiXohvjB/YP4+g73K+KNLwKo3gJjoZFdgETLVMNQFPYgp8lK524OxnaEJv8mqOzhKZ2mIj50wdhQ1KkXMTRrjKMksFLZW4p9TVVEt/5psvrJc2rh7b/YGgwPz/WtugRyE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6439.eurprd04.prod.outlook.com (2603:10a6:20b:d8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:07:43 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:07:43 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] USB: phy: fsl-usb: remove character device usage
Thread-Topic: [PATCH 2/2] USB: phy: fsl-usb: remove character device usage
Thread-Index: AQHWUEKFtA9+f8E8UUSJ1E0v2g7u/qjz/9rg
Date:   Thu, 2 Jul 2020 09:07:43 +0000
Message-ID: <AM7PR04MB71575977E680A7F6405D8B3F8B6D0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
 <20200702072914.1072878-2-gregkh@linuxfoundation.org>
In-Reply-To: <20200702072914.1072878-2-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [222.67.222.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 674cff6c-771f-4b42-5ed7-08d81e676173
x-ms-traffictypediagnostic: AM6PR04MB6439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB643906363957E150C4C1100A8B6D0@AM6PR04MB6439.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2yXjizMpXTNC85ZoPOiKrbNR4mCnUfjjHh0nsSfr8oFzwZlasJVjQz1Z5O6iHKfLnEdaoP6ByIGwWNzZBF3lG8b6qn35v/vU4tX7Njw18auNa3eF+kIOpnx9DOiKS5vH+8IMG1ce4rWd8VxLbI6rCn0UaNvnQNnXVZfTwXVBFttP+aa3ftOEfyjBaAsfGCJnt8PJd5AAjabWnV+3/UIXEkRTb/xgx1xiBY7kqIrsp6MqqcmGvId6ojaGLpi4tDpyE06QfXwYknBPK2Cf9wt9rTh680On+4UENt6urQGQSvgtG7pL8esyOdzJWnn0sDqilw/Ze/ibr25DUStjcHpHJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(4326008)(2906002)(8936002)(8676002)(26005)(44832011)(52536014)(186003)(33656002)(5660300002)(66446008)(64756008)(66556008)(66476007)(86362001)(66946007)(71200400001)(76116006)(6636002)(54906003)(7696005)(316002)(110136005)(6506007)(55016002)(9686003)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +qYV5xujyEVnmV25Sb5gcJ/k7K6ADD3olcn7OBs6P8FuEtE5gNviFM/Tjck93l0HYaZyGj1cqcJL598PcQnX9VvDZe2z9TTykxfgNnPB6XoAN0EkCXR9tEYZlgE+CuXNh5jaEbL1486oRgMJLIKpIcmZvMeZtBu7SsgX28xvXXU1gqp+9SH4rPziGIrOiNwIJ6ndotMtOyVU09F+7/jrezRbtJ8ZuWH/aLewxKAXLG5mKPKYkOMGQs/pGJsiJNFpXZsZDKJMdtKHMv2Tu+xUVHhg1L6ydGB/bNi0o4AptHB+Lwg1Ij3EkeeMNsob02tplvDO06xEAqPpeRH/vQwJCpRwuwhlhBs1vM1SOFQyNzJNorKQSYbwbj1FipnjPiQKikZP8A4ojrW3r6NhUdA18DJS5OPG97/umyr5niDV4hARJ9Ff/m7emXkDHKdhxy31L/ZnOYkz2UyW0BdbHJ2H/YkjU8CkGpPFmJlmJK9wABSdSgBRylE0VAOTM62n7F6U
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674cff6c-771f-4b42-5ed7-08d81e676173
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 09:07:43.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1E9BfjzyZvcWWZck64jSO4AbBE8f9QqQUV3dz6JT1rlVPPUMzdzfipnvhWSp+GlOepN1p9NMe20YtVw6K+LAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> No idea why this driver is using a char device node, statically allocated=
, with no
> dynamic allocation or hook up with devtmpfs, along with a reserverd major=
 number,
> for "special" operations, not all of which ever were implemented.
>=20
> So just rip it out, as no one must be using it because no modern system w=
ill ever
> actually create the /dev/ node it needs.
>=20

Add related people from NXP.

Peter

> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/phy/phy-fsl-usb.c | 69 -----------------------------------
>  drivers/usb/phy/phy-fsl-usb.h | 14 -------
>  2 files changed, 83 deletions(-)
>=20
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.=
c index
> 93d2257aeec8..0c6d9f9f2994 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -957,67 +957,6 @@ int usb_otg_start(struct platform_device *pdev)
>  	return 0;
>  }
>=20
> -/* Char driver interface to control some OTG input */
> -
> -/*
> - * Handle some ioctl command, such as get otg
> - * status and set host suspend
> - */
> -static long fsl_otg_ioctl(struct file *file, unsigned int cmd,
> -			  unsigned long arg)
> -{
> -	u32 retval =3D 0;
> -
> -	switch (cmd) {
> -	case GET_OTG_STATUS:
> -		retval =3D fsl_otg_dev->host_working;
> -		break;
> -
> -	case SET_A_SUSPEND_REQ:
> -		fsl_otg_dev->fsm.a_suspend_req_inf =3D arg;
> -		break;
> -
> -	case SET_A_BUS_DROP:
> -		fsl_otg_dev->fsm.a_bus_drop =3D arg;
> -		break;
> -
> -	case SET_A_BUS_REQ:
> -		fsl_otg_dev->fsm.a_bus_req =3D arg;
> -		break;
> -
> -	case SET_B_BUS_REQ:
> -		fsl_otg_dev->fsm.b_bus_req =3D arg;
> -		break;
> -
> -	default:
> -		break;
> -	}
> -
> -	otg_statemachine(&fsl_otg_dev->fsm);
> -
> -	return retval;
> -}
> -
> -static int fsl_otg_open(struct inode *inode, struct file *file) -{
> -	return 0;
> -}
> -
> -static int fsl_otg_release(struct inode *inode, struct file *file) -{
> -	return 0;
> -}
> -
> -static const struct file_operations otg_fops =3D {
> -	.owner =3D THIS_MODULE,
> -	.llseek =3D NULL,
> -	.read =3D NULL,
> -	.write =3D NULL,
> -	.unlocked_ioctl =3D fsl_otg_ioctl,
> -	.open =3D fsl_otg_open,
> -	.release =3D fsl_otg_release,
> -};
> -
>  static int fsl_otg_probe(struct platform_device *pdev)  {
>  	int ret;
> @@ -1039,12 +978,6 @@ static int fsl_otg_probe(struct platform_device *pd=
ev)
>  		return ret;
>  	}
>=20
> -	ret =3D register_chrdev(FSL_OTG_MAJOR, FSL_OTG_NAME, &otg_fops);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to register FSL OTG device\n");
> -		return ret;
> -	}
> -
>  	return ret;
>  }
>=20
> @@ -1061,8 +994,6 @@ static int fsl_otg_remove(struct platform_device *pd=
ev)
>  	kfree(fsl_otg_dev->phy.otg);
>  	kfree(fsl_otg_dev);
>=20
> -	unregister_chrdev(FSL_OTG_MAJOR, FSL_OTG_NAME);
> -
>  	if (pdata->exit)
>  		pdata->exit(pdev);
>=20
> diff --git a/drivers/usb/phy/phy-fsl-usb.h b/drivers/usb/phy/phy-fsl-usb.=
h index
> fbcc28ad9964..d70341ae5a92 100644
> --- a/drivers/usb/phy/phy-fsl-usb.h
> +++ b/drivers/usb/phy/phy-fsl-usb.h
> @@ -371,21 +371,7 @@ struct fsl_otg_config {
>  	u8 otg_port;
>  };
>=20
> -/* For SRP and HNP handle */
> -#define FSL_OTG_MAJOR		240
>  #define FSL_OTG_NAME		"fsl-usb2-otg"
> -/* Command to OTG driver ioctl */
> -#define OTG_IOCTL_MAGIC		FSL_OTG_MAJOR
> -/* if otg work as host, it should return 1, otherwise return 0 */
> -#define GET_OTG_STATUS		_IOR(OTG_IOCTL_MAGIC, 1, int)
> -#define SET_A_SUSPEND_REQ	_IOW(OTG_IOCTL_MAGIC, 2, int)
> -#define SET_A_BUS_DROP		_IOW(OTG_IOCTL_MAGIC, 3, int)
> -#define SET_A_BUS_REQ		_IOW(OTG_IOCTL_MAGIC, 4, int)
> -#define SET_B_BUS_REQ		_IOW(OTG_IOCTL_MAGIC, 5, int)
> -#define GET_A_SUSPEND_REQ	_IOR(OTG_IOCTL_MAGIC, 6, int)
> -#define GET_A_BUS_DROP		_IOR(OTG_IOCTL_MAGIC, 7, int)
> -#define GET_A_BUS_REQ		_IOR(OTG_IOCTL_MAGIC, 8, int)
> -#define GET_B_BUS_REQ		_IOR(OTG_IOCTL_MAGIC, 9, int)
>=20
>  void fsl_otg_add_timer(struct otg_fsm *fsm, void *timer);  void
> fsl_otg_del_timer(struct otg_fsm *fsm, void *timer);
> --
> 2.27.0

