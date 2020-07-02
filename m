Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB6AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8CB206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FbVAf+Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGBJHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:07:19 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:43310
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbgGBJHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjEEW3eFVj31Tz16zPDwPoALZSbWjo/AvsIqUu5dnvCv/d1oaeo3FSPQA8ZbwbRs/qnPT9CUXxqR3z31ZUlO5q91b/4SXywzc/eo8M9ytuh7r3yjkYZ9flfzMizvS/e2Vby5uQRilkscOIo6h6OifaT1dSlOTZUMZBPYL2CEoe55TnQZSYU6+4UFLX051ozBal+xKSGmIqg79O1QgNV/7hFXk1dU4EenrnlKLaoFgmAUlU59BUVjVN4+p4iPaunDnOx86CL0ILA4tMBu/REufSvifLMGStGNKiqZRCUSeGE6G+aupkwRxJFCLsiInBJYTZI1g5yL5Ul5XnL0icXnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2HNI14cXwL6ZBbqMtFXQIkoDCt5Xfdxe66j+SKCJEo=;
 b=TItvTd5Le9Rq2jdd7FhT1NEDfAAAl0jDFMRQnJGHQG4YPzC1zlDWaBo57xLEzzDOK1huuHqC9ix/Lv+Zk9yt1b5TtiV/96H8Ms8K+YiKor0N5nlripEPRz+YrYRTXx0wyec9WwIAn8f0kh2oNLX4R4Wt9wukTdNq+qnG5r2jJ6ByUL9hZr1ooz+pPOr/vXvaAA2gnVc26S9brN/wBrFYSS8/pgGufry7AGcM7VghWXoBWUPOZSfYgihyqmsmU7NPWD2uNSKyP5OpOYeASiv1asWxHqbNn1AppjW0y4BYanLmt57XJH2nsOJxw4YxSR5Mu+GfdQ0S7+PkZaKZIvH3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2HNI14cXwL6ZBbqMtFXQIkoDCt5Xfdxe66j+SKCJEo=;
 b=FbVAf+FbqJ6+T+L08yC/hKARhJKMOP5TOUW8DY49JOUduIbbbpO6UyfD1UC7QVrxgnCJpe3tf4gyGp0OEFGdhQFfTF9whifP9h0y6NddQ3hZ6IVZCpMRsXNP/iFc19Aq++at1erGCd8Tqr8L+oofvfLaQIu7kWpS1b3jR8M2Lf8=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6439.eurprd04.prod.outlook.com (2603:10a6:20b:d8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 09:07:14 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:07:14 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] USB: phy: fsl-usb: remove sysfs abuse
Thread-Topic: [PATCH 1/2] USB: phy: fsl-usb: remove sysfs abuse
Thread-Index: AQHWUEKAPS7Jf/ATmEORsHiFvZN8Cajz/5XA
Date:   Thu, 2 Jul 2020 09:07:14 +0000
Message-ID: <AM7PR04MB7157F5D247041AA604C3D1368B6D0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
In-Reply-To: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
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
x-ms-office365-filtering-correlation-id: aad270a0-bf45-4516-b5ac-08d81e675032
x-ms-traffictypediagnostic: AM6PR04MB6439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6439A5B8C5FA4392135DF3C08B6D0@AM6PR04MB6439.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6zuMtlTW7USJFyOkvjhom1aG7m7kfbzXw2XGMFfHGqSnUKMSdBIBoYgCkcRK6hn3Umo+wDjYy2QKWT1mSXycHDeSIGZvSeANsrKWtRYcoimsL+rbUvmvKiFJLSXNDk10Xptwb2vIbm3/phIG+EYrPulhEgPxsTZveqJaANRJX8suiWh/gE2jO5/Z/oZWnkLIK6r5Y/gEzXzVTkS/aSk1ZUZWrhkDRFbChqBYWRI5P22F4BKgRwQhY7TWLRjCs/Peh+wCPTqdDklEBq+xLrERNwrzAR382F4BjEEgCa78zii93okRubfqWQpJ3eQJi7LqzVBtRRWIW0FQMW/pTE3vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(4326008)(2906002)(8936002)(8676002)(26005)(44832011)(52536014)(186003)(33656002)(5660300002)(66446008)(64756008)(66556008)(66476007)(86362001)(66946007)(71200400001)(76116006)(6636002)(54906003)(7696005)(316002)(110136005)(6506007)(55016002)(9686003)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: r7zH8dkPdQR4STRC2RLESesxNzbNAXQB8VUbP1FdOUEszdwAPp8rEhWULQ9/XShMP21CbzXhFqzhzBeUQsa3eZTLgGYUz0maew3Oqo2Yz4FQ/DoUHD1ZE/3AXdaKDWrC4n4WSK22u9qmkokuvnCqr4c+wETxRJKW5eSkL4LvicvUbPmazTbATVhjjiiNWXbJqJx/VhBXBcfVZPBO5DfCxNb//PJQV3T6uJ5iSHzc//CwsNs7ACt/lC1kTvSVfkXOCUDkts043q4nqB6RQMaxLOONM6L4r6ncQiBatcOBcViI79LuV4rnoHNSDlzvFchsILINTcHQ/gSJU1doGvln93wQ3POJd0qP/ciyGUMb73k27QYpvC3k+0T3oZnADXFzlfvg5RRbTeXMENy9oiUtATT3g7PAT06Sc6ZUAbt7r8c42JWLITsTmoLp25zJSBjnxDhLKHA26oe2t5AT3JxxRgCe2tHGghpxyn9ZBxstjFP/bcTcmsWYailIfglZHan7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad270a0-bf45-4516-b5ac-08d81e675032
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 09:07:14.8034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLNUWXVMfzw0eQhon//kr6ne5JGwqQRWNcpoaCmi5qyy4YCbtk/H7WC8I6KtpsR6xQ+tMTs+Ynzxkwg9xpXr5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> This file has a HUGE debugging sysfs file that spews out a lot of informa=
tion all at
> once, which violates the one-value-per-file rule for sysfs.  If this is r=
eally needed, it
> should go into debugfs, but given the age of this driver, I strongly doub=
t anyone is
> using it anymore.
>=20
> So just remove the file entirely, it was never documented, so obviously, =
no one
> actually needed it :)
>=20


Add related people from NXP.

Peter

> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/phy/phy-fsl-usb.c | 93 -----------------------------------
>  1 file changed, 93 deletions(-)
>=20
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.=
c index
> b451f4695f3f..93d2257aeec8 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -957,98 +957,6 @@ int usb_otg_start(struct platform_device *pdev)
>  	return 0;
>  }
>=20
> -/*
> - * state file in sysfs
> - */
> -static ssize_t show_fsl_usb2_otg_state(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct otg_fsm *fsm =3D &fsl_otg_dev->fsm;
> -	char *next =3D buf;
> -	unsigned size =3D PAGE_SIZE;
> -	int t;
> -
> -	mutex_lock(&fsm->lock);
> -
> -	/* basic driver infomation */
> -	t =3D scnprintf(next, size,
> -			DRIVER_DESC "\n" "fsl_usb2_otg version: %s\n\n",
> -			DRIVER_VERSION);
> -	size -=3D t;
> -	next +=3D t;
> -
> -	/* Registers */
> -	t =3D scnprintf(next, size,
> -			"OTGSC:   0x%08x\n"
> -			"PORTSC:  0x%08x\n"
> -			"USBMODE: 0x%08x\n"
> -			"USBCMD:  0x%08x\n"
> -			"USBSTS:  0x%08x\n"
> -			"USBINTR: 0x%08x\n",
> -			fsl_readl(&usb_dr_regs->otgsc),
> -			fsl_readl(&usb_dr_regs->portsc),
> -			fsl_readl(&usb_dr_regs->usbmode),
> -			fsl_readl(&usb_dr_regs->usbcmd),
> -			fsl_readl(&usb_dr_regs->usbsts),
> -			fsl_readl(&usb_dr_regs->usbintr));
> -	size -=3D t;
> -	next +=3D t;
> -
> -	/* State */
> -	t =3D scnprintf(next, size,
> -		      "OTG state: %s\n\n",
> -		      usb_otg_state_string(fsl_otg_dev->phy.otg->state));
> -	size -=3D t;
> -	next +=3D t;
> -
> -	/* State Machine Variables */
> -	t =3D scnprintf(next, size,
> -			"a_bus_req: %d\n"
> -			"b_bus_req: %d\n"
> -			"a_bus_resume: %d\n"
> -			"a_bus_suspend: %d\n"
> -			"a_conn: %d\n"
> -			"a_sess_vld: %d\n"
> -			"a_srp_det: %d\n"
> -			"a_vbus_vld: %d\n"
> -			"b_bus_resume: %d\n"
> -			"b_bus_suspend: %d\n"
> -			"b_conn: %d\n"
> -			"b_se0_srp: %d\n"
> -			"b_ssend_srp: %d\n"
> -			"b_sess_vld: %d\n"
> -			"id: %d\n",
> -			fsm->a_bus_req,
> -			fsm->b_bus_req,
> -			fsm->a_bus_resume,
> -			fsm->a_bus_suspend,
> -			fsm->a_conn,
> -			fsm->a_sess_vld,
> -			fsm->a_srp_det,
> -			fsm->a_vbus_vld,
> -			fsm->b_bus_resume,
> -			fsm->b_bus_suspend,
> -			fsm->b_conn,
> -			fsm->b_se0_srp,
> -			fsm->b_ssend_srp,
> -			fsm->b_sess_vld,
> -			fsm->id);
> -	size -=3D t;
> -	next +=3D t;
> -
> -	mutex_unlock(&fsm->lock);
> -
> -	return PAGE_SIZE - size;
> -}
> -
> -static DEVICE_ATTR(fsl_usb2_otg_state, S_IRUGO, show_fsl_usb2_otg_state,
> NULL);
> -
> -static struct attribute *fsl_otg_attrs[] =3D {
> -	&dev_attr_fsl_usb2_otg_state.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(fsl_otg);
> -
>  /* Char driver interface to control some OTG input */
>=20
>  /*
> @@ -1167,7 +1075,6 @@ struct platform_driver fsl_otg_driver =3D {
>  	.driver =3D {
>  		.name =3D driver_name,
>  		.owner =3D THIS_MODULE,
> -		.dev_groups =3D fsl_otg_groups,
>  	},
>  };
>=20
> --
> 2.27.0

