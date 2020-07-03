Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA679C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CD120A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IsXVsKr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGCBtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:49:25 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:48193
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbgGCBtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imPbOLRfcNAYVqPR7e9mMnl2zUehmko7ry+b15KPGCGBj5ozL87v0aLcLuDmFUMc4zOnAa9jHxgQEBou2NMiCnjxhL+9ZdTZ9fBCCyvej7al5M8XumHPOcA15FWWhNIFQXocj7lbApd73K0Z0e2uB7EBt3JCl/yhklA+NMCEIr/kYeKQMfB0eOKKviuiyfjMva65YKKln5KgvKoYSSQMdH5754qvzBB+2KfTg/v9v59nX89gpnkrYwyQ17U9TXKIHKKTabwskbxG0bO+Zne0NYwhqPHOuoBbtlILLLa0WK8W48OdiNk5azP9H/ueo4+sU/ZoAucIaCbzY+jxkAvOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY0+NLI3L9Tv43F+tfjzE+xJqyIwvsfWVGFsSHfsjiY=;
 b=UEYACJkOHGMlQJ2YoDfEKEya/oHC88MADJjRENJALk3qpe6mZtXazakMuFPg3Mg9EAQeU0cFGP6B9Q8iGimJyuY96XLW8vHn/IbXRa5s1Z7lP8i/axeF9DYZUrhsBTgRpyktcsE3bbaWfuH6WxOWSjNBmW5WZ9RCQwaQ4KnDoV5/KGuYqOM3Xu2jLtPi53Karso8lkXcs7xtU2ZtU49kZfSVF6I1Na1QEfx+KT4isoK6XezjMXEK6pDRrAcYe7F5vynyWZmtDgJXPoNAYnDuIHxtLwsjb9AfyIYMAgQo454GrL8zF2g5GtUoegMI7eVJrA5bd8N7vmL08cFDQSa0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY0+NLI3L9Tv43F+tfjzE+xJqyIwvsfWVGFsSHfsjiY=;
 b=IsXVsKr20uVH3aaAjn+nyrXf6Djyrmn7+V208UJKWANY+mmmg3sFrRj2fcD/4IWIPAi4izbzQ6/fmKxwULN6DbYqB5j/Dw63LuGgkO8GqRO0aFV/PkNqK7A4qAsJHHy4DTVvZ6xIjlXTa5ORpi29OlBe0UkIk54Z1z7i2IV+TV4=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM5PR04MB3153.eurprd04.prod.outlook.com (2603:10a6:206:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Fri, 3 Jul
 2020 01:49:20 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::18e:f4c7:5a46:90e3]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::18e:f4c7:5a46:90e3%5]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 01:49:19 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Peter Chen <peter.chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] USB: phy: fsl-usb: remove sysfs abuse
Thread-Topic: [PATCH 1/2] USB: phy: fsl-usb: remove sysfs abuse
Thread-Index: AQHWUEKAQaIemoHQu0ecXIYPoFfzAKjz/9UAgAEXB7A=
Date:   Fri, 3 Jul 2020 01:49:19 +0000
Message-ID: <AM6PR04MB541321C805C5EE3DADE28D81F16A0@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
 <AM7PR04MB7157F5D247041AA604C3D1368B6D0@AM7PR04MB7157.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB7157F5D247041AA604C3D1368B6D0@AM7PR04MB7157.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d2a7835-ac93-4ad0-9613-08d81ef34d88
x-ms-traffictypediagnostic: AM5PR04MB3153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB315372D6BB3997BAA86A0071F16A0@AM5PR04MB3153.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DI0UCWCZ1fV1n2PIOIJw823ikIV2B0snX7OuYUcxDpN+6l+8WnI7eJw9K6wT2YZMqiXcthjmbSe5e23v7i0wwljMvZdzcIv2861J3HvZCZjbmc4KCfZ8xp5NdzfeO586Ja59EtUqvMxpEzwD5aIH5V0+N2L5+fp0j2i39t84zWcIYGFYuscvQgJ52UdVyovkhSN3bRKFfWJ7SMevYYCBSNVzXybJ8Z5raNsn4q3zkD/wcLQgFgAa16p21VEMK46M3NrusxEC+HXZHxm66/BBuPauSmcFWDKMiPKGO1LEmuladnCJ6KogztaGL/4dyDjMtlAxsaUCa2VLubg1IvP7NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(2906002)(66946007)(9686003)(64756008)(66446008)(66556008)(26005)(66476007)(186003)(71200400001)(86362001)(52536014)(110136005)(53546011)(6506007)(8936002)(76116006)(54906003)(55016002)(316002)(6636002)(5660300002)(7696005)(4326008)(8676002)(33656002)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JhZpvQSNWA8NJtti5JjPOeS4GDfMtd44xJbAOK3s/ADoLpCDKUyC79J05k/OShOpHhrAv6XwFF0QzLNYoJfJ7tnO5XmHuyt6x8Or4+0QKC9oQqmkkrvjTxowdXIMgABEubGQf0nxtR+sg3ckym6VYSFRnk7PDj1/3p72GmVaR+il8QEpBwNVykq8yM2p1AONPdRDcq5oT/fPzh99bc4e//3T8zmzUmYy1Necm+j1iA/5eTsGx4IUadPC0jtYu/9hC+xASdIYGvSFK4AoLjlcCCyap8Ry/rizmkq5XTIwDc59UF09+WFYNjCCxiYYErfJoh8sgxJ8/9nUdQXWiQ9h/rdl9kpRBqOLPk5q2dahpYPmzR4tJnGLDFdspk/bYIoJJdpGkLtvM9qQApz5zDPcy57tDYDMLZNnw/l5rZkx3YnZppXBQaa2/lyvKYbIRx36pvYsNNYCH+vUkSfDbDiC4F9AEKih4hykxoJo/OPYRsc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a7835-ac93-4ad0-9613-08d81ef34d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 01:49:19.8498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3VGPVwp6njkGvEmZAoWSGC5ZlSNaqRC91eOVARZqHuyGopT8JHT3aMtrLDeERqz9H/qjENsTdthjXD4Ap09ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, July 2, 2020 5:07 PM, wrote:
> >
> > This file has a HUGE debugging sysfs file that spews out a lot of
> > information all at once, which violates the one-value-per-file rule
> > for sysfs.  If this is really needed, it should go into debugfs, but
> > given the age of this driver, I strongly doubt anyone is using it anymo=
re.
> >
> > So just remove the file entirely, it was never documented, so
> > obviously, no one actually needed it :)
> >
>=20
>=20
> Add related people from NXP.

Thanks for having me. Agree to clean this up for above reasons.

Regards,
Ran

> Peter
>=20
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/phy/phy-fsl-usb.c | 93
> > -----------------------------------
> >  1 file changed, 93 deletions(-)
> >
> > diff --git a/drivers/usb/phy/phy-fsl-usb.c
> > b/drivers/usb/phy/phy-fsl-usb.c index
> > b451f4695f3f..93d2257aeec8 100644
> > --- a/drivers/usb/phy/phy-fsl-usb.c
> > +++ b/drivers/usb/phy/phy-fsl-usb.c
> > @@ -957,98 +957,6 @@ int usb_otg_start(struct platform_device *pdev)
> >  	return 0;
> >  }
> >
> > -/*
> > - * state file in sysfs
> > - */
> > -static ssize_t show_fsl_usb2_otg_state(struct device *dev,
> > -				   struct device_attribute *attr, char *buf)
> > -{
> > -	struct otg_fsm *fsm =3D &fsl_otg_dev->fsm;
> > -	char *next =3D buf;
> > -	unsigned size =3D PAGE_SIZE;
> > -	int t;
> > -
> > -	mutex_lock(&fsm->lock);
> > -
> > -	/* basic driver infomation */
> > -	t =3D scnprintf(next, size,
> > -			DRIVER_DESC "\n" "fsl_usb2_otg version: %s\n\n",
> > -			DRIVER_VERSION);
> > -	size -=3D t;
> > -	next +=3D t;
> > -
> > -	/* Registers */
> > -	t =3D scnprintf(next, size,
> > -			"OTGSC:   0x%08x\n"
> > -			"PORTSC:  0x%08x\n"
> > -			"USBMODE: 0x%08x\n"
> > -			"USBCMD:  0x%08x\n"
> > -			"USBSTS:  0x%08x\n"
> > -			"USBINTR: 0x%08x\n",
> > -			fsl_readl(&usb_dr_regs->otgsc),
> > -			fsl_readl(&usb_dr_regs->portsc),
> > -			fsl_readl(&usb_dr_regs->usbmode),
> > -			fsl_readl(&usb_dr_regs->usbcmd),
> > -			fsl_readl(&usb_dr_regs->usbsts),
> > -			fsl_readl(&usb_dr_regs->usbintr));
> > -	size -=3D t;
> > -	next +=3D t;
> > -
> > -	/* State */
> > -	t =3D scnprintf(next, size,
> > -		      "OTG state: %s\n\n",
> > -		      usb_otg_state_string(fsl_otg_dev->phy.otg->state));
> > -	size -=3D t;
> > -	next +=3D t;
> > -
> > -	/* State Machine Variables */
> > -	t =3D scnprintf(next, size,
> > -			"a_bus_req: %d\n"
> > -			"b_bus_req: %d\n"
> > -			"a_bus_resume: %d\n"
> > -			"a_bus_suspend: %d\n"
> > -			"a_conn: %d\n"
> > -			"a_sess_vld: %d\n"
> > -			"a_srp_det: %d\n"
> > -			"a_vbus_vld: %d\n"
> > -			"b_bus_resume: %d\n"
> > -			"b_bus_suspend: %d\n"
> > -			"b_conn: %d\n"
> > -			"b_se0_srp: %d\n"
> > -			"b_ssend_srp: %d\n"
> > -			"b_sess_vld: %d\n"
> > -			"id: %d\n",
> > -			fsm->a_bus_req,
> > -			fsm->b_bus_req,
> > -			fsm->a_bus_resume,
> > -			fsm->a_bus_suspend,
> > -			fsm->a_conn,
> > -			fsm->a_sess_vld,
> > -			fsm->a_srp_det,
> > -			fsm->a_vbus_vld,
> > -			fsm->b_bus_resume,
> > -			fsm->b_bus_suspend,
> > -			fsm->b_conn,
> > -			fsm->b_se0_srp,
> > -			fsm->b_ssend_srp,
> > -			fsm->b_sess_vld,
> > -			fsm->id);
> > -	size -=3D t;
> > -	next +=3D t;
> > -
> > -	mutex_unlock(&fsm->lock);
> > -
> > -	return PAGE_SIZE - size;
> > -}
> > -
> > -static DEVICE_ATTR(fsl_usb2_otg_state, S_IRUGO,
> > show_fsl_usb2_otg_state, NULL);
> > -
> > -static struct attribute *fsl_otg_attrs[] =3D {
> > -	&dev_attr_fsl_usb2_otg_state.attr,
> > -	NULL,
> > -};
> > -ATTRIBUTE_GROUPS(fsl_otg);
> > -
> >  /* Char driver interface to control some OTG input */
> >
> >  /*
> > @@ -1167,7 +1075,6 @@ struct platform_driver fsl_otg_driver =3D {
> >  	.driver =3D {
> >  		.name =3D driver_name,
> >  		.owner =3D THIS_MODULE,
> > -		.dev_groups =3D fsl_otg_groups,
> >  	},
> >  };
> >
> > --
> > 2.27.0

