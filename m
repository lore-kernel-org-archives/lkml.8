Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C579C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398A221D80
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rzBpADcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIIJOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:14:15 -0400
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com ([40.107.243.45]:61537
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbgIIJOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:14:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqvC2s8jgXv4b7KfSbrmG9Ov5geAQj+atr0objk0BESrWKNxDtsD0OM4NSlPm4TpQ3esy+uNpCDRSr+tux3TizEMyGmXVPY7TUrq/Ryi9QkTFZF41TUucmYO8k3sZ6+Tubzt5tETFxGib2RkKcAfxVxVNLLFn91q8ticR5PzSuqHJbAKPNkkoXOu1aapY77V77MBLt39oQHYH+0CDMs3bVVx49eOjadJEbGieX2rI6zI1QKb9Ac4HN01DSC+7fF/NlJ4lQOs5FFIvBSxgQZbV/smhXIe9NfA+S5Qok6wiUySXVuh4+tPnEmx0aDAXiXLG1n5ubvZZk+6yWWwOty/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZYJJ1ZuQtyAmROiyc2fKI0GtEfo/aVs6uGvsTqUvHg=;
 b=Wvl0+AUQDn4FBXFclsevkpc9PhX/RbrngBFEyxDf/GM0Uw4lnUS/jXaHmvrKbp2y+eehquhDahfKoZ6T2PFRbErgEO197Y/mZ7eMeHXCS/++hS6CFPSsxXJ0qqXjxj1SF2r6J/8BjD4axqqZnvHud6RTij2ihpy5ZWcPJe1FPuNfLAonJRK20Iju/ASofYTneVjArZppI01fKnEqkE+JnPIg3BaujC3lKILYBAkjHAmDHZzK2sVdbm2qcUK7iQTz2QEv2jPDOXFZuf2IyrQnRt5kJrMPXDF/bB2F4u75P99JXXmgxiBU0rijIri0JkYE9Z4/+XxuQs4Dx3rI/ljptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZYJJ1ZuQtyAmROiyc2fKI0GtEfo/aVs6uGvsTqUvHg=;
 b=rzBpADcBia7AHq3VuxESNjA9yKHow3qnGVroWOBvk+C7jiovaHRiDdIA1daayXWQhJ9bT0cIHE5qHEryVsabfMN2nQU62zh47Rm2TuDPSeCi7O+tKntlrxUVh+RexyYNFzTSxvUvxqEKHY5QDlzfwB6BXlYu6Zxr1NdYjz3YuSE=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB5975.namprd02.prod.outlook.com (2603:10b6:a03:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 09:14:05 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 09:14:05 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Topic: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Index: AQHWe9kSXk9fyd29ekqKVsSVp3b0nKlLf7MAgAHFp1CABnYHgIAMTv+w
Date:   Wed, 9 Sep 2020 09:14:05 +0000
Message-ID: <BYAPR02MB58960AA4C87C76223C04D71BC1260@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
 <87y2m0ioql.fsf@kernel.org>
 <BYAPR02MB5896669D47783D06F779608BC1520@BYAPR02MB5896.namprd02.prod.outlook.com>
 <877dtd7kxc.fsf@kernel.org>
In-Reply-To: <877dtd7kxc.fsf@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d0c1704-cf41-4de8-f1e2-08d854a0b349
x-ms-traffictypediagnostic: BYAPR02MB5975:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5975A6BA9DEBC3EE8533A193C1260@BYAPR02MB5975.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhN0KPM21mp3JwdLYVscTb1/3BA4QLvz+BGDZCkGw7qjAe62w27s0s4ceGx626h/WWKy3rdLJD3HLW/D0BxEa+fTjm6s8vU7EbZc0lEBw5bWF9zTDOH4x7qzX1O7Ihj9gDrfAy9GQKg7co8ses+pbsrv1NjbG1bN9erpOnloz1AHhFXiD1t067MJ6baZENj5f2tZlWWteN75bkYu3fs108BhvqqULvpwr/B6Mj4t5l6DlyuRYytKLCAuewt7NO6zhvuDWhLsSARK0zPZrbkG7EPuQf33xNaKsk73JeO+9mRIq6v6c6VoIDz0XRzJSEdsgVRPiRoMWW6EgeJUvqVOXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(186003)(52536014)(107886003)(7416002)(316002)(86362001)(478600001)(33656002)(5660300002)(66946007)(76116006)(26005)(7696005)(83380400001)(6506007)(71200400001)(4326008)(9686003)(66476007)(66556008)(66446008)(64756008)(55016002)(2906002)(54906003)(8936002)(8676002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9LTeryk/WLcFmVJxOkWoW7pjNsjM93K+EJGk+SBoYG0fCeO93j7a/MToD4qRuwCkGvNXCX/y37UU2UgBHbzx8Ina+QJw/1st/6SYQEiqhdXdtr/uq4hA9zVdloVuLaUzoq+AkWXO8TaGgPmgmo83pbP7fyySTVCYvqy7MLCfO16tZIKHdK1QjNBHYlwuI4Qry/9t1y/XlpwZT/qsAf1RW0PLfrFrGBGV2OPeGdmqE8ywc7CVNhLcAVbQXCXhp9fJ2Y34R1VocVdAG9H90H9K8bd7+R7Z5sySaE4JFHgXZXD7b3b17peXgtjq05YsqxvskeO6osxlrR2YWKT/tvNzC+L4QePejiE/ceCv9F3sm9qV6WWWyrZoJeD1Dxz2FwXC4ZeQKHsAsYM580ZhI3SD6IUfKQ6ef0ZHp+XR7Oay8qQljBqLmAS7D/JjXlWCQmb/nNpcOrA1heb7HDulzWVHQWCMgSLbuznU+H1Jc/oHONX96tQTnARDOAAL5TzMSmkz9renPtDMtMyAWp/9caWiQoYgnPc0diwaDyiqNSXFjQbnKgXsskE+/ZG1t7Dq7tVxr6OEKd/m+Lijpg1ccgWkyP7wxokpK/e9Ll9mM3K64ZBctCT0tL2zVwJebBh4jMErEVxqocmQVaGrEUPHTKeG5Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c1704-cf41-4de8-f1e2-08d854a0b349
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 09:14:05.1084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AX987tusCbLt1sDpjt5/DE3PbQwK+L6JTeMPKoTrZGJzq13kZHZwwi4wouCTbETaw1IH7yjDUR0LAnEmNbNdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Thanks for the response.

> -----Original Message-----
> From: Felipe Balbi <balbi@kernel.org>
> Sent: Tuesday, September 1, 2020 5:45 PM
>=20
> >> > +		goto err;
> >> > +	}
> >> > +
> >> > +	ret =3D dwc3_xlnx_rst_assert(priv_data->apbrst);
> >> > +	if (ret < 0) {
> >> > +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> >> > +			__func__, __LINE__);
> >>
> >> 		dev_err(dev, "Failed to assert APB reset\n");
> >>
> >> > +		goto err;
> >> > +	}
> >> > +
> >> > +	ret =3D phy_init(priv_data->usb3_phy);
> >>
> >> dwc3 core should be handling this already
> >
> > The USB controller used in Xilinx ZynqMP platform uses xilinx GT phy
> > which has 4 GT lanes and can used by 4 peripherals at a time.
>=20
> At the same time or are they mutually exclusive?

The lanes are mutually exclusive.

 [...]
> >> > +	if (ret < 0) {
> >> > +		dev_err(dev, "%s: %d: Failed to release reset\n",
> >> > +			__func__, __LINE__);
> >> > +		goto err;
> >> > +	}
> >> > +
> >> > +	/* Set PIPE power present signal */
> >> > +	writel(PIPE_POWER_ON, priv_data->regs + PIPE_POWER_OFFSET);
> >> > +
> >> > +	/* Clear PIPE CLK signal */
> >> > +	writel(PIPE_CLK_OFF, priv_data->regs + PIPE_CLK_OFFSET);
> >>
> >> shouldn't this be hidden under clk_enable()?
> >
> > Though its naming suggests something related to clock framework, it is
> > a register in the Xilinx USB controller space which configures the
> > PIPE clock coming from Serdes.
>=20
> PIPE clock is a clock. It just so happens that the source is the PHY
> itself.

This bit is used to choose between PIPE clock coming from SerDes
and the Suspend Clock. When the controller is out of reset, this bit
needs to be reset in order to make the USB controller work. This
register is added in Xilinx USB controller register space. I will
add more description about the same in v2.

Thanks,
Manish

