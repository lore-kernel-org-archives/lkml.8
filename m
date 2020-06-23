Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F763C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC64C206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nkYPLtAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgFWCWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:22:23 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:36576
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730882AbgFWCWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkuTa1XnY+6TZq8kHVTVxwu6ej1FTyat3L/pTIkx8utrdba3W3lDLGvCsC8ikEK+GEe/uo7pYLqj3FJ8QUCH0+WSwxtVxT0xKGBTqM4FCjkyjM7JD28CCAJic1lY5jNUXdYOj8QKtHALWyKNvilS5GoSMYFghe9MTB8ff28ZZcJ8OAKkrWM47wgqfZiJLstCft9NY4fJ82RhOaNTdJ9f5YQrLyzTEZH7UKdI2ppkAMx7Gg2ehMWfnJiva1VmeIjNhWid2plBmgdwP4m+xE+qUOO9ZWQ3wNq5u2S+Ioe653na9H1QesxFHP1xhBSIWicSjxkBGM9VVrVuw9/Q74sNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/5q2jSTv20iJsx3jzTZe+84r6ui5PGJOw38UBJulo4=;
 b=ZF5xbQgw8tDKNCPfMxO2a8uPdDXgGyuzutC5WmsMQa5snbAIBBVGiIUecyN19XCic5KgNo6rNrKD7VP7BLE06ehMYNTF2j9CVWA8qCMQqPZuPG5bxbrha64dxy/XATiRkxsitPQW5dI2le4vSVu5GJNbBVZzcZDEnOPQnwjsCj0hE6hQWUziPRVBgjJ9TbnlaWEZe9416NEVbZ1aftfqwZGT3Wq5ZCsjs3hs4VLTjqMymk2yfmf1FN9CdAsQXWqCD5xo12etVMLdhjyu9GpPK6K+Lj9ilTEdDiJ98zm39Ro0kspACleWdn/gYxMerwGlWXrCxXgbEKeKT0QEHZtzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/5q2jSTv20iJsx3jzTZe+84r6ui5PGJOw38UBJulo4=;
 b=nkYPLtAHOywY2z8zR0azOrSr9YG2JHHR0Tv+bUSzP5nFIptjn4q6AKcxG7gHCbchzZRojcxHGzKKrIr/mmpkbNvQX5VAVr/zJI8Hv22ltqSYQQCRKSJc0OnZHoocmYBVS/GjoM+gR5WS9iz/rFsp+wGS8eEi+0zoLF5ziRz05Ms=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB4886.eurprd04.prod.outlook.com (2603:10a6:20b:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 02:22:19 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::18e:f4c7:5a46:90e3]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::18e:f4c7:5a46:90e3%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 02:22:18 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: RE: [kbuild] drivers/usb/gadget/udc/fsl_udc_core.c:1055
 fsl_ep_fifo_status() error: we previously assumed '_ep->desc' could be null
 (see line 1055)
Thread-Topic: [kbuild] drivers/usb/gadget/udc/fsl_udc_core.c:1055
 fsl_ep_fifo_status() error: we previously assumed '_ep->desc' could be null
 (see line 1055)
Thread-Index: AQHWSMHg173I/CwxlUSjT6yCmaAgyajldNlA
Date:   Tue, 23 Jun 2020 02:22:18 +0000
Message-ID: <AM6PR04MB54138B87957CFB06EC9DF351F1940@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20200622182023.GX4282@kadam>
In-Reply-To: <20200622182023.GX4282@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [148.153.126.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5298aca8-683a-4620-04d2-08d8171c40f8
x-ms-traffictypediagnostic: AM6PR04MB4886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4886499EE9EA2E09DDD7F859F1940@AM6PR04MB4886.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMoY/Kz0LNGIEVvDzVzKtLV+W4lmKxGiaXA7ldeXKPlObuW1hkHmNZyUmOAOUy0d4uKCdTkolLTiltA4idei+66grgK5WY3nfHD9vSSjQrvMhvvIBbYzwOAdweBoQY8xDj24FJsQUTCQidlwtPS3UpP8Zi6PEMC99/RQM4g8ZzxJtYag7I3SrOPxctLJzUn0xkyzwupgsBO5C+lPjYSJDzV8613V5YQMGAilnV3w11QRQJsVUfS0zogMU+eCZJtYOVXsy2RVFzNRXbReIUMoEJlrqtYabkSwHp7K1r+7+eTy/Cv99MCo9DfMr5OcTI+FmwrvV8TZysNAU1/CdcLpZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(26005)(55016002)(71200400001)(9686003)(52536014)(66946007)(2906002)(76116006)(64756008)(66556008)(66446008)(66476007)(4001150100001)(5660300002)(6506007)(53546011)(8936002)(83380400001)(478600001)(7696005)(186003)(4326008)(33656002)(8676002)(316002)(54906003)(110136005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EelZf+s+ZpZgToF8n6J71oraXanKbYNECPCc5aoQrzGDalAYf9YVIQMlq+DXv1h/sMuidbhib7ZyhG77BmpC7xsmdZtcrGG9f3nrS2j4hx50Tv6wGpFdSsnfvCLh4z3wPKcFxdqLlTT1r/Zhbz76xNWdM9wvu9V5ZlMZb14sq/u1jNilmspRAr530pdF7PaEaFcy2CpKcYtBCLm1rQ3X3uK/zCRxJKSD860QB1iB0LPdH7/tXYHfug/QtLLOo7fQKF4XefP04kRb2IXgEeG9IKUC73CTtTvUOmy6/NpuhjYsRkpa8xjhpIc4gUSlHcqU/V5tta7pOepWCtE/ysvNFjHe4oPmfv/b4Z/rgg3MGZt6DMbvKXWLDdT6Hnm3g8OPrHGQjq0UAx7MZiEdGBF032za31bp4+TDtt62+Rs6xlb4hWiNUxyk+Gd1t+yY3qnJnZIarEQoR4eInfJAs5zfchRHVQOx4Ixg/1DnkYNsM02ZB0Hf8j91chHu9lXiKpg3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5298aca8-683a-4620-04d2-08d8171c40f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 02:22:18.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wh1/IyLkAiSrzPaCPq8xQVwuN6xI/alAKUC2CKKgHI81SsVaibWetW6DGsssMKNcdEwva/FwdpbBgbMqG/vWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan

On Tuesday, June 23, 2020 2:20 AM, Dan Carpenter wrote:

<snip>

>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> New smatch warnings:
> drivers/usb/gadget/udc/fsl_udc_core.c:1055 fsl_ep_fifo_status() error: we
> previously assumed '_ep->desc' could be null (see line 1055)
>=20

<snip>

>=20
> 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> 2011-04-18  1047  static int fsl_ep_fifo_status(struct usb_ep *_ep)
> 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> 2011-04-18  1048  {
> 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> 2011-04-18  1049  	struct fsl_ep *ep;
> 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> 2011-04-18  1050  	struct fsl_udc *udc;
> 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> 2011-04-18  1051  	int size =3D 0;
> 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> 2011-04-18  1052  	u32 bitmask;
> 6414e94c203d92 drivers/usb/gadget/fsl_udc_core.c     Li Yang
> 2011-11-23  1053  	struct ep_queue_head *qh;
> 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> 2011-04-18  1054
> 75eaa498c99eeb drivers/usb/gadget/udc/fsl_udc_core.c Nikhil Badola
> 2019-10-21 @1055  	if (!_ep || _ep->desc || !(_ep->desc->bEndpointAddress=
&0xF))
>                                          ^^^^^^^^^ Reversed NULL test.  T=
his will always return -ENODEV.  (Or possibly crash.  But I suspect it alwa=
ys returns -ENODEV instead of crashing).

So the kernel test reports warning in case of '_ep->desc is null', right?=20

My understanding is that this judgement would return -ENODEV when
executing '... || _ep-desc ||..' and never execute '_ep->desc->bEndpointAdd=
ress' part,
so crash would not happen, am I right?

> The container_of() macro doesn't dereference anything, btw.  It just does
> pointer math.  I think it would be cleaner to use ep_index() like the ori=
ginal
> code did.  In other words, perhaps it would look best written like this:

Yes, I agree using ep_index() would be easier for reading, just feel a litt=
le bit
uncomfortable to mix checking on _ep and it's container (ep) in the same li=
ne.

> 	ep =3D container_of(_ep, struct fsl_ep, ep);
> 	if (!_ep || !_ep->desc || ep_index(ep) =3D=3D 0)
>=20
>=20

BTW, Nikhil Badola has left NXP (Freesale), so his email address is invalid=
 now.

Thanks & Regards,
Ran
