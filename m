Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14834C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4724206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R+MLFr9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgA0Mdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:33:53 -0500
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:15428
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbgA0Mdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:33:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RghuW1yvDqEqnGan/KjDXLzUw5uc2Hnf9+aayH5S0R5Jok4Ys42MBRLDQovzkzKNgrSxjMwXPyuWIoXNi4tOQZ4WE8osVQ5dWy3iKjHAxRvCRmoR8+3yDwhDoSPBposgDN9tardrLbdn1CL6rlF2xfv0dIswQBbDunQJD/k9i0duxEo9mqChT3/eCXNoUH8LDGZDEkR+/cElb1yc8mXKHc1bDePbFpFHPNH7iWdDJMYGuvEKQa/zVu+jF0d2HL4If7CiqpZ8nH8bPPtE4I89i/op5B0TYOCJGIwZRJK75PR3GSJVMkxhYmq2EBAbm0U7suz+eBU6i5J7zNv5SdBd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWf2tbweuAz8xqbIEizhowXSbEV7vSIVmZiS0wt9NTA=;
 b=YxYXltCKd4GrUdlYPCdQJDzz8i+H89Uy917RCaJRNXZH5xuDCyR3fW4bvoTJC1w246iSoR2T7QhAW3+n2BJwc9+Fie6d+wxFrEdRdN04/Ag17nXsAhz++GrtzirdpwnH95JFX2dsNZaZmsSSUOEL8FnuyIEcRwrMVdecuxWiQq3jC5QkTjDEbPEUdiy6GIwcfaUPX1flvDL1zt7n1NRFkAq/z6cIZFFjQ5gczvFuxQDFFXZ6NWI5tkqDQ93QUlpxpBvIRcX6lb/Sgbd0ldD/UKkDIF4t27ERQ3rx/BGVXTp0ct21ZgW7CGs68EMRMQEaPWAN+AoLkXp1hZkm0x99vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWf2tbweuAz8xqbIEizhowXSbEV7vSIVmZiS0wt9NTA=;
 b=R+MLFr9x1swKngIXk4/weAHZVaWanouad2risrlF4rT+RHJkfnN73LLSQHIT/TFvCGy/k6ZcQ6uyLz7bu7MkObpYBpaVjju0NAhBWIJepcwKTQUP6DmQWTiOX9xM3w7o0igJCaPZk2h7KLsebtm237o2jkzwo2utg3RNO5waUbY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4883.eurprd04.prod.outlook.com (20.176.215.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 12:33:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 12:33:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Topic: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Index: AQHV1PZk+mGdzzCjckexq+nG+OcySqf+VfQAgAAbviA=
Date:   Mon, 27 Jan 2020 12:33:49 +0000
Message-ID: <AM0PR04MB4481E1AACAC4285D49E721AD880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
 <CAK8P3a2YLo4rNBXu9NhvKv6QOFUcZhCVXNR4XJe_0Kc_RJ=ubA@mail.gmail.com>
In-Reply-To: <CAK8P3a2YLo4rNBXu9NhvKv6QOFUcZhCVXNR4XJe_0Kc_RJ=ubA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7464c71-8d82-4e65-6a5f-08d7a3252965
x-ms-traffictypediagnostic: AM0PR04MB4883:|AM0PR04MB4883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB488373235429091B8BD349CD880B0@AM0PR04MB4883.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(8936002)(81156014)(53546011)(4744005)(8676002)(6506007)(7416002)(71200400001)(81166006)(316002)(76116006)(66556008)(26005)(66476007)(6916009)(64756008)(186003)(66446008)(66946007)(52536014)(2906002)(44832011)(54906003)(86362001)(33656002)(9686003)(55016002)(478600001)(7696005)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4883;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2ksliVQgSP1uZaySxdpg9U6hDayH8FDOSyRah+PLhvbgxdRMOSmbWCCibcLOofuv0W5dV+Iy2auhNjYItbo9uFkJbJDemtW83xHQvR3f3qIxH658cdWxX+FTuKvj/39lv8/TlYgYHUR14mfVy/HHK8KxboRZ1Bk9FGi7PO3guGelLGlWVlSNpHPmyzlRYrNkwR6UarCOE9IKZciCkzTWtc8sFybhXYHE3P5bs0ZBup2ivEjTcdt60h8d4iYF/uPI18Z2e5C0k2WnQFVOMrH+Ag23vMuUm6RgSscJicgauRnsL5S2XXhJWXcDIl2vAKOIfdAgafbcWUxs/AtqBueGx1+YjxBj7XGNSZJVgDw9DSmL9qJRB4wu2qxoiLV+BknqytxFMOzuYV1b4xdKIqvijuIoFmrbLlqO5iI8JgCPpQsObekwc2WSJZLnJwgStAA
x-ms-exchange-antispam-messagedata: VEMKmetQzF8ucn/8ElYiF/9QvwB8AYZT60rZXyDNj4H9/be6J7JmurQSdIyM8hi91dYR9/FfcCq7ypFatUatPR/rFGdGwj68p1qSzXPMKAbb/qv3eu4AgcXXt57OLGt7XyYh6w29YfAuMbNJld1VXg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7464c71-8d82-4e65-6a5f-08d7a3252965
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 12:33:49.9220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjQ8vSbXGG9xOOvJrkMqU4qZvKny6jmBNifFqHULj1xwgjSqxR/vMW9LsUYetf0GVXIY1l5j4XSsO8FtalXBsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDAvNV0gc29jOiBpbXg6IGluY3Jl
YXNlIGJ1aWxkIGNvdmVyYWdlIGZvciBpbXg4IHNvYw0KPiBkcml2ZXINCj4gDQo+IE9uIE1vbiwg
SmFuIDI3LCAyMDIwIGF0IDEwOjQ0IEFNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4N
Cj4gPiBWMjoNCj4gPiAgSW5jbHVkZSBMZW9uYXJkJ3MgcGF0Y2ggdG8gZml4IGJ1aWxkIGJyZWFr
IGFmdGVyIGVuYWJsZSBjb21waWxlIHRlc3QNCj4gPiBBZGQgTGVvbmFyZCdzIFItYiB0YWcNCj4g
Pg0KPiA+IFJlbmFtZSBzb2MtaW14OC5jIHRvIHNvYy1pbXg4bS5jIHdoaWNoIGlzIGZvciBpLk1Y
OE0gZmFtaWx5IEFkZA0KPiA+IFNPQ19JTVg4TSBmb3IgYnVpbGQgZ2F0ZSBzb2MtaW14OG0uYyBJ
bmNyZWFzZSBidWlsZCBjb3ZlcmFnZSBmb3IgaS5NWA0KPiA+IFNvQyBkcml2ZXINCj4gDQo+IFRo
ZSBjaGFuZ2VzIGFsbCBsb29rIGdvb2QgdG8gbWUsIGJ1dCBJJ2QganVzdCBkbyBpdCBhbGwgaW4g
b25lIGNvbWJpbmVkIHBhdGNoLCBhcw0KPiB0aGUgY2hhbmdlcyBhcmUgYWxsIGxvZ2ljYWxseSBw
YXJ0IG9mIHRoZSBzYW1lIHRoaW5nLiBZb3UgY2FuIGxlYXZlIExlb25hcmQncyBmaXgNCj4gYXMg
YSBbUEFUQ0ggMS8yXSAgaWYgeW91IHdhbnQsIGJ1dCB0aGUgcmVzdCBzaG91bGQgY2xlYXJseSBi
ZSBhIHNpbmdsZSBjaGFuZ2UuDQoNClRoZXJlIGlzIGEgYXJtNjQgZGVmY29uZmlnIGNoYW5nZSwg
c2hvdWxkIGl0IGJlIGFsc28gaW5jbHVkZWQgaW4gdGhlIHNpbmdsZSBjaGFuZ2U/DQoNClRoYW5r
cywNClBlbmcuDQoNCj4gDQo+ICAgICAgIEFybmQNCg==
