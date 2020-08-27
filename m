Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DAB2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p0ZVjG6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgH0AZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:25:01 -0400
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com ([40.107.21.46]:24225
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbgH0AY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjeGvLen3+aX6YqlkU0zg0y1gpeGhD2U3IRlRUuLJpYo9u6TXvOjPg8QqqALDn1Dxdec++Z/QFbVWgVtDlNrweMFsgD1XVFWRdUaKL73vL4HYZzsDvyNDDQS0nHl61JlUd6tEpCYUNK3RwlX7LkJZ/6tkYYtk5N+o6pyy6isnvNDx75zKXadlAfc5uchgffEuNO9LVWVcdbKMUQreDjUhzXSKYJ2GgUS2OptZZZ/YAHlcZYuNoTjWc+Ifvo8TWRPOlcPXNVl9qwmhIbxq9GK/3GnzONJecq8aQOGwVP06n5hKMm3NJ8YdcgSDVW7ikPn+bNsZhJCR2wyrC2tdqapWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKcKvjSGmGifOI4ACRW6IHKOpzQudZ9H8w5ynwCmNe0=;
 b=hDyLMWNPHpEaFwzy1ZEx6psI8E31hMqVTwiefZtPaUduG+UdOR7pVK7UlBP1cpl6uE7rYeIJKaSkL4SGiUozW20RijpJGSMh14IXpwPBl2qP7fa31pRvWsirlxTImI8lxCZu/U+vgfq8AaIsUaZyDIQGMgIgTD7/byhxBmMVE555cfcjRQTRZGTuyfIA2jSfH/ieQykszFn34qRZGpVCgx/gFxVniZa1FcPfnVrL1bN3mFRAqWupLQUpD68QYdIi5eiVcRui91Xv/vyomMRzpKBMBkrgWnLji+cyQzKDIFWAM0WX4hrPUZ8x0E9xcui+K60tcRpImk2zYTxGtJkCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKcKvjSGmGifOI4ACRW6IHKOpzQudZ9H8w5ynwCmNe0=;
 b=p0ZVjG6EL2QiJYCWG1livM2ZDUhMTedWZ8PH8QqGHBtB27LITLQL5M0XWLRZTtiQcupCRXOYy3Zm9N/1PKXZbWVmsP4e0AsurjaABzrRjkZVPs7Gwobbr6H9YcQA7xLBcZDXPd3qTk+Uk0PugNQY+M+E7i5nnvB8/EKXMNT7EcE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 00:24:55 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 00:24:55 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Topic: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Index: AQHWete/XCUsbMkzVE2tONyDrFDh16lJudEAgAAMW4CAADVhAIAACEuAgAACF/CAAFMvgIAAwdIA
Date:   Thu, 27 Aug 2020 00:24:55 +0000
Message-ID: <20200827002339.GA17559@b29397-desktop>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com> <20200826031948.GA7646@b29397-desktop>
 <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20200826071504.GA19661@b29397-desktop>
 <DM6PR07MB5529EB2FB7E3380321191B44DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM7PR04MB71576DF6C03387C7628DBE3A8B540@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <ab38721a-ef48-c6a7-aa33-3085ca7b8852@ti.com>
In-Reply-To: <ab38721a-ef48-c6a7-aa33-3085ca7b8852@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1360a51-3280-4529-ce2b-08d84a1f9f9f
x-ms-traffictypediagnostic: AM7PR04MB7077:
x-microsoft-antispam-prvs: <AM7PR04MB7077F0B096EC3D02873827BE8B550@AM7PR04MB7077.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: srRsLX2ziMcRoP/YnaYKUCIHce/+JcnpFD9OhJ5leOmG346HGz2fi3RTquYwFcmZEUz+km5QSPd40w7fnQ540tuZ5chMawczTIo8j+x/wBVh5swWRezV1gMLDf5DlZnwMQYPnD/M2q/YpjMGVOZHaEOhnbui+enHnSWvk9/guuTv8X7cQFHJ+lbbYcBvHquD9OM9VmhXeEhSxMx/3oB3wZWt3hYkukWbNdnBqWPQfw+GlntmAIqnw7cVOqm+ym6a/iQ9LPdq00PwskahtLmVaHHGdxcrZEfsEFmqO1/uXTT7wPe4q1UiHjahOQJTjAjf+nkjV/SS/SUsz8/x/4KYJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(6916009)(44832011)(9686003)(7416002)(186003)(2906002)(4326008)(33716001)(76116006)(5660300002)(91956017)(8936002)(53546011)(478600001)(64756008)(6506007)(6512007)(1076003)(66446008)(66556008)(66946007)(33656002)(54906003)(6486002)(66476007)(316002)(86362001)(71200400001)(26005)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AsSjq7Wsjz2WzE8krla8gA30xB93uiuXXmvJNGkUM6J0Ss5aNb30K6O+JE/zYJqraJysWlnyntX6I1aPYx5I0CrJuvK4xazpPZbq+J0iT1/LXgMEunrsIsaKIdFoQfz0L8OZDJ3d9uSc5pkrWoNSU/JSpg4Nlg4gntxqFk4Hf0Lc5YM256CDMMZbPFXW9lcd1/HcczxmucQVPhBYgSKXeij6dXvaPbkvcLBfiTlX+CW07Xy/+Eg/69DpdtVBXZSJs2MszQc4HT2ouFAvzf0MMoisLu/h8LYBIDTYtSMISarqQFURI/PzkzWuu5aXk9nFxUOiB3mNzC2sDRTXTJvgB9WNVzauBy58/dm6WEok8HcU6eqBd7i+HCKxUugTOux4rRffe/AQQRCWE3JsTlOe+TUfMnx2gdFPIPnblB7kmlb01s3r83T28AQuOTzmaniczkansYhlMVFbC2Qx7r4hITN1h2yVvDG1vNNTXPabaoFPFL/KYfcv9ejDlUi84Ui3fr7SL/qYAoARV3VvMOaRKTi57eC3XXF7xNdlEBMLtILKnfZfVfWuQYYjbyWjgsoKQ+65XA9yxToXHmkiqmWe2KjbShGpgk5jq2ZOTr1Tzu/RC3amOgcD9ZgTPo92QtZCRNA4Roz7Ewjs+eK4TLqsqQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C19BF47BDD710F45AB0258E5658DA04F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1360a51-3280-4529-ce2b-08d84a1f9f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 00:24:55.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkZvKLcQWvuv73vn2KiiuzvQhmwh4bftG7od8ysJOuGPwRPWL2SIMXPuQbgz3zSmIpR1rVNKhJ2lkPyFxd83pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-26 15:49:57, Roger Quadros wrote:
> Peter,
>=20
> On 26/08/2020 11:07, Peter Chen wrote:
> > >=20
> > >=20
> > > >=20
> > > > On 20-08-26 04:04:01, Pawel Laszczak wrote:
> > > > > > On 20-08-25 15:00:59, Roger Quadros wrote:
> > > > > > > From: Pawel Laszczak <pawell@cadence.com>
> > > > > > >=20
> > > > > > > USB2.0 PHY hangs in Rx Compliance test when the incoming pack=
et
> > > > > > > amplitude is varied below and above the Squelch Level of Rece=
iver
> > > > > > > during the active packet multiple times.
> > > > > > >=20
> > > > > > > Version 1 of the controller allows PHY to be reset when RX fa=
il
> > > > > > > condition is detected to work around the above issue. This fe=
ature
> > > > > > > is disabled by default and needs to be enabled using a bit fr=
om
> > > > > > > the newly added PHYRST_CFG register. This patch enables the w=
orkaround.
> > > > > > >=20
> > > > > > > As there is no way to distinguish between the controller vers=
ion
> > > > > > > before the device controller is started we need to rely on a =
DT
> > > > > > > property to decide when to apply the workaround.
> > > > > >=20
> > > > > > Pawel, it could know the controller version at cdns3_gadget_sta=
rt,
> > > > > > but the controller starts when it tries to bind gadget driver, =
at
> > > > > > that time, it has already known the controller version.
> > > > > >=20
> > > > > > For me, the device controller starts is using USB_CONF.DEVEN (D=
evice
> > > > > > Enable) through usb_gadget_connect, I am not sure if it is the =
same
> > > > > > with yours.
> > > > > >=20
> > > > >=20
> > > > > Yes in device mode driver knows controller version but this
> > > > > workaround Must be enabled also in host mode. In host mode the
> > > > > controller doesn't have access to device registers. The controlle=
r
> > > > > version is placed in device register.
> > > > >=20
> > > >=20
> > > > You may suggest your design team adding CHIP_VER register at global
> > > > register region, it will easy the software engineer life.
> > > >=20
> > > >From what I read, this register is only enabling USB2 PHY reset
> > > > software control, it needs for all chips with rev 0x0002450D, and t=
he
> > > > place you current change is only for 0x0002450D, right?
> > >=20
> > > Even I could say that this workaround should be enabled only for Spec=
ific USB2
> > > PHY  (only 0x0002450D)
> > >=20
> > > This bit should not have any impact for Cadence PHY but it can has Im=
pact for third
> > > party PHYs.
> > >=20
> >=20
> > So, it is related to specific PHY, but enable this specific PHY reset b=
it is at controller region, why don't
> > put this enable bit at PHY region?
>=20
> I think this is related to Controller + PHY combination.
> The fix for the issue is via a bit in the controller, so it needs to be m=
anaged by the
> controller driver.
>=20
> >=20
> > So, you use controller's device property to know this specific PHY, can=
 controller know this specific
> > PHY dynamically?
>=20
> Still the PHY will have to tell the controller the enable that bit. How t=
o do that?
>=20
> Adding a dt-property that vendors can used was the simplest option.
>=20

Ok, does all controllers with ver 0x0002450D need this fix? I just think
if we introduce a flag stands for ver 0x0002450D in case this ver has
other issues in future or just using phy reset enable property?

Pawel & Roger, what's your opinion?

--=20

Thanks,
Peter Chen=
