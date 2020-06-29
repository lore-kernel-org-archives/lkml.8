Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB2BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC02D206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qIC1eMlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgF2Dly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:41:54 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:6220
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbgF2Dlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx1x+9hHPdMkqacmbHayQO3NyJHU6ScWox8LRncJWocXpmfRDs8urmJ/Cqq9rTFsRwjCF7A4xJr11I1GR/cBLRZ3nj1BLdmucn7+Ey+Jvw7NnV4fjM53DMxtP8WtoVZtKsPTmPszksspxFKl+vFULbvEC2btJ+LUYseJO5OLzm5kpvlvU8AQAmYvDpiq8w4TEqqVmCEwM1Eyab6+7OTXFXf+bKVeVbKT7ZC7RsyJBIrK2zc9/mf0xxz/s7oyUVhkV+Y5K0Ig9Zz/EVQNmKEixfaOSlUCrElMVfaWx33HHXhQyLOI/NDaHeHLccfHbPAjI88A1rbG52SIUkZLzDaruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzOLoSQ/r051mT/wlf5drizZdJwTQqChn6RkarZ/dLY=;
 b=oFcZgyPWuOLKNpLS5SbEBOB6xzvZsXDlG2nSafqy0bkJt/iJlmUqFp+fMza0XsexvY5p/+1IrnKyNHR91tx9BcKu/YuzdieI4tr/L1Dym68KR14v2Kb3nJtYhgQ9RcK8ISR7aSGhRQTTodOkRi0DS8a2WC2WQXuv39PiOGxzYpxQSPAMr0DWOA7xArDbwGuF4M4aSaiXMC/8gjOv2+DTBDdU4lVhTa2TABxGvtNrGQzXMuO1Xjzm2jXdy8bQbxlvM++uPTj0l0LgS7XeC3vMlT4ujdE6ew8Zj6jRciv3a9bcz8qQV12yWz6wNkJGW2wKmjoDLuGAs0geFMXXBr6cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzOLoSQ/r051mT/wlf5drizZdJwTQqChn6RkarZ/dLY=;
 b=qIC1eMlhjpKMBCyCZfWwCbiz2BHidB/f0vAnlvPa5NAPwZ5fxnzfIn+teu36StmtN+gGZ5x97iWdz5btUWpX9F4ROPLBBXsFkfYwMYdHjBRZNVxk87l11k8KP6aD9dupNBeqO5P9kKSItmgMKA73hW9RGBahcsEvDR5TXLNjxhs=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR0402MB3654.eurprd04.prod.outlook.com (2603:10a6:209:21::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Mon, 29 Jun
 2020 03:41:49 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 03:41:49 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: Re: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWS3Ylp2LS5pecmkenOlfLMCntJajqdbIAgAAHxACABHoqgA==
Date:   Mon, 29 Jun 2020 03:41:49 +0000
Message-ID: <20200629034213.GB30684@b29397-desktop>
References: <20200626045450.10205-1-pawell@cadence.com>
 <878sga5nfr.fsf@kernel.org>
 <BL0PR07MB5522A8796EE7BFB5062A8E76DD930@BL0PR07MB5522.namprd07.prod.outlook.com>
In-Reply-To: <BL0PR07MB5522A8796EE7BFB5062A8E76DD930@BL0PR07MB5522.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93d31729-04b4-4734-7e39-08d81bde5afd
x-ms-traffictypediagnostic: AM6PR0402MB3654:
x-microsoft-antispam-prvs: <AM6PR0402MB3654881622666D51B70C31AB8B6E0@AM6PR0402MB3654.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4NDtJKdWb1GISMgSA0tbKsQ6YJQJQauc7YrC+cT8thrABhHfv7xS9ofnDUX85acOIXfoOvNfKuoTVH8nTN9nOchGtIgilVR+MdEocwAdQX57Hiu/joTX5+g5buKu+Dp3AQ0C1vboAD4u8W1rLJDsJIyqDWl8uZJdjuNWI7uvu26oHWXlB2vJ52QcOcV5qbWyBB0pwzriQbwGVnT1wpEx60zXU7AEbwHVJVDoKBEa9uSbL5kSCj2Wvs3wT5eE+aJRItJaAKAfxZ3kzuHFsY6tkopOOWRxUpeav6RC6sYzbKZIZkevhdKUveu1SyZWdGFky1pfHnUHm+tScwLB/Y9rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(86362001)(9686003)(6916009)(2906002)(6512007)(4326008)(316002)(478600001)(54906003)(6506007)(53546011)(186003)(26005)(7416002)(33656002)(33716001)(8676002)(64756008)(66556008)(83380400001)(66446008)(71200400001)(8936002)(6486002)(76116006)(66476007)(1076003)(91956017)(66946007)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RgZxGg4FEQRNHOZhoTf32HYbku4lK3jaGWGAbg0GYN3L++DasSk0Cp3XsR+befYSeAU3eopm4KT93+YA9jaV+st+HX45Z86V2OonEbxzwFgCyK2+QspqaQI6GEiv+7M1CNxL5nJoVThHHIpE8GPRd+8Kqx2ah5QHKf9hyI6NIF1u0fnO90gjjhLeKZebGGuUoMEEKGidh2U39amqQW5OPXCHx6DkhGPhcJ+eslNY5qLSgnxbLJPeO2vPCOzL2cXjDbqcNwBdLGbci0bWCbQXi0XeFDB/fqr4fPhZ4F/G1nk4ACdKcIysmsVIRU8TjvLwnJe6frbRihawXJMYo8HSCn6BttBk2+swPX5ISaqANX8nUteXSOF+Kw3M0qwvmAZtsuG5614J4aqBf8vo0japN8SYSVIH8H/egqCISTUT+BRA3j7v9Nk95E31/IrmJo3AW2bOTWqT7B/HthUPplczeOLWeIm9iKLrjFScoiFgZeo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4877C9C125D3ED46B215D65647EB3933@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d31729-04b4-4734-7e39-08d81bde5afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 03:41:49.5749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4F8qIQNHddqeJzAvebjeEizAi8Ig7AcburL8jMQVzRtJYveEJrqLFbOthXHpaOjiichxcnQp0mz4heWYiZwow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-26 07:19:56, Pawel Laszczak wrote:
> Hi Felipe,
>=20
> >
> >Hi,
> >
> >Pawel Laszczak <pawell@cadence.com> writes:
> >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> >>
> >> The Cadence USBSS DRD Controller is a highly configurable IP Core whic=
h
> >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> >> Host Only (XHCI)configurations.
> >>
> >> The current driver has been validated with FPGA burned. We have suppor=
t
> >> for PCIe bus, which is used on FPGA prototyping.
> >>
> >> The host side of USBSS-DRD controller is compliance with XHCI
> >> specification, so it works with standard XHCI Linux driver.
> >>
> >> The host side of USBSS DRD controller is compliant with XHCI.
> >> The architecture for device side is almost the same as for host side,
> >> and most of the XHCI specification can be used to understand how
> >> this controller operates.
> >>
> >> This controller and driver support Full Speed, Hight Speed, Supper Spe=
ed
> >> and Supper Speed Plus USB protocol.
> >>
> >> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
> >> The last letter of this acronym means PLUS. The formal name of control=
ler
> >> is USBSSP but it's to generic so I've decided to use CDNSP.
> >>
> >> The patch 1: adds DT binding.
> >> The patch 2: adds PCI to platform wrapper used on Cadnece testing
> >>              platform. It is FPGA based on platform.
> >> The patches 3-5: add the main part of driver and has been intentionall=
y
> >>              split into 3 part. In my opinion such division should not
> >>              affect understanding and reviewing the driver, and cause =
that
> >>              main patch (4/5) is little smaller. Patch 3 introduces ma=
in
> >>              header file for driver, 4 is the main part that implement=
s all
> >>              functionality of driver and 5 introduces tracepoints.
> >
> >I'm more interested in how is this different from CDNS3. Aren't they SW =
compatible?
>=20
> In general, the controller can be split into 2 part- DRD part and the res=
t UDC.=20
>=20
> The second part UDC which consist gadget.c, ring.c and mem.c file is comp=
letely different.=20
>=20
> The DRD part contains drd.c and core.c.=20
> cdnsp drd.c is similar to cdns3 drd.c but it's little different. CDNSP ha=
s similar, but has different register space.
> Some register was moved, some was removed and some was added. =20
>=20
> core.c is very similar and eventually could be common for both drivers.  =
I thought about this but
> I wanted to avoid interfering with cdns3 driver at this point CDNSP is st=
ill under testing and=20
> CDNS3 is used by some products on the market.=20

Pawel, I suggest adding CDNSP at driver/staging first since it is still
under testing. When you are thinking the driver (as well as hardware) are
mature, you could try to add gadget part (eg, gadget-v2) and make
necessary changes for core.c.

--=20

Thanks,
Peter Chen=
