Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F10C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5F3206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pi5qtbZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBMQSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:18:12 -0500
Received: from mail-am6eur05on2055.outbound.protection.outlook.com ([40.107.22.55]:6210
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727926AbgBMQSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:18:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAjDji++Gyw9GQKXalTpGWoLTaJlhd8Ah6w7TNy2ENOFmD+432EfK91fadCYxzsCfzku0ltNZmYrExOfuId/nRFYT/Ty7kHYLudCB9uib8206bbb/ycthFQ3Nyyf902sUXD3cwuXNsOUdePtPw019FYA0ADCtFWPlzcINpyKhdrF8n+lZXfup8zyhyWUiROYjSNzal3e9F8mpQSkqHqg4HjrcFWiHDGkq/8lBe5c23hd0psLrJfkN3LGlisREZMAo5MIkLs+XgEZ0WJX22u8FEf8JVpIFPfskJ2Gz6IrhaVvHgbd1gJMpehSXlswkgpEeisfkYHkYDrAugSM8oB/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT31BqboP7OM/wcp+rLnV7morBDIg9MORXgrJSDdqRg=;
 b=cTl6NXTzNukOjhbOLzUBagq/PE1gErFaB1Q6rZ6L7MFhrA7QXKloazdl7xrJIlzH3g0dMJzg9YfckqEuGjy7nxS6WA8gnj+sZ9ZLB8l6bFP4n27FxZi17aXVXIfR3BufN4ZH9ZP1BPwIF2YMtO2BLueHF5vG3y5jtirmkCTB6ypzK6slOoqZcc3toYigUQIOj5Ap8pyjb6veoz7okIJI/5QjmlZ0bYE1CkEQeW7fCTMKxKbs2VZ0bF6NIaNJuGDqfV8+fdVnFmCzeebTJ8CzbVYg9cSZRrtnPKrvvmjg7mWRN23Js9XZlJVndd6wwyeF5abiTYvFbuRxA9CI1GojdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT31BqboP7OM/wcp+rLnV7morBDIg9MORXgrJSDdqRg=;
 b=Pi5qtbZPpIiuKirGO7oiPyVe8j2TaNHuYSxClGs4+U4FCRwJmpc660PzwDHfgGwqmK6M1gCGNk1KRFzKUM98lhUT5S4MbkeeMPQwFU1aFqjnKJiCDLc6xf/BDmxhnakfcaeSQWYblTveac/qkA2aoaewbFDeo+4EcuHkNIPgi/0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5011.eurprd04.prod.outlook.com (20.177.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 13 Feb 2020 16:18:09 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5024:13e2:7000:3c2]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5024:13e2:7000:3c2%6]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 16:18:09 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Oliver Graute <oliver.graute@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: clk: imx: clock driver for imx8qm?
Thread-Topic: clk: imx: clock driver for imx8qm?
Thread-Index: AQHV4oK4jf4Yk7gIB0yfade2LGWp9agZS8Hg
Date:   Thu, 13 Feb 2020 16:18:08 +0000
Message-ID: <AM0PR04MB4211AC5AB9F6A055F36040A2801A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20200213153151.GB6975@optiplex>
In-Reply-To: <20200213153151.GB6975@optiplex>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7b092a9-ea20-4ea8-a0bd-08d7b0a0509e
x-ms-traffictypediagnostic: AM0PR04MB5011:|AM0PR04MB5011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB50112248CB805FF73C8763B0801A0@AM0PR04MB5011.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(316002)(33656002)(66556008)(66446008)(7696005)(76116006)(66946007)(110136005)(54906003)(71200400001)(64756008)(66476007)(8936002)(2906002)(52536014)(4326008)(55016002)(44832011)(9686003)(86362001)(6506007)(81156014)(5660300002)(81166006)(8676002)(4744005)(478600001)(966005)(186003)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5011;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bu7vFDcdK7f182O04/6dAeKKzvPt6a2II1GZviPlZM3u1eOEM7z8eoffncM7qb5NYoVgGE6cc0bLBgNIXKkkQrb+BRYvFrkE4wqtIFwjKSEZB9LZYrfOf5KSg6LegUO2L01unZgwSZeHFtMYjgiU2UiuC7lJVgS/McGmTC0R6uu/fosnukGeta13IKA0JseI9Qjz79X/bQDnvDjxuJauMSu48tfJQ5IK3V8xKP/rxEE2JGPeBvabh7qS8JGdmZmopBatOIRgd7F4f4jU4n0EsWON3nanErx+Vrl0+ROa7dgwV3plT74nOQWssU3UU55YPuMAVTfxr9ySWg5CNS3tvsWyXJdqL0tXk+TM8WN+3KscWohyM76vlbCYdzVqFlyNGzDUqsTSS2mzU4VMBYXzTPLcYaEfT2JuCO+HxGNFQ9CtIzzv2KU3ME/lvKAjF07vxk67BY5X1XAqN5ZczCSi6TxeuRz6ziJHwFLKViWnJh6KEi8Tf1TqZXnphBjnIz4dmMccF7AlHmEJD6EFBA7RuymiKAgiUmy2aX9xofUsaOKHUcDdGkSqqM5xxDRH+lLz
x-ms-exchange-antispam-messagedata: MnZGfFkEn1BSzdz4lFog/TibaUHgc+VgBIH2akxOepXFkNMBsgvHDBgNxiWhuHRSLxvUcCmHFQX31HolG2KeRmh8XtqsJIRd8Oh1Lv/H03Vb/+MOHK9BEs6I742Rjrv+OI+hNqFbM2jFhlIkT1LjZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b092a9-ea20-4ea8-a0bd-08d7b0a0509e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 16:18:08.9044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qJigXwItpkDjuMOLdEHL0WlwWYjNkVNXozFA9cGt49LvE0MzYGRrNdb3aWM6BjmnpHoAZbRCXzNvG9vzfOkKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xpdmVyLA0KDQo+IEZyb206IE9saXZlciBHcmF1dGUgPG9saXZlci5ncmF1dGVAZ21haWwu
Y29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTMsIDIwMjAgMTE6MzIgUE0NCj4NCj4g
SGVsbG8gRmF2aW8sDQo+IEhlbGxvIEFuc29uLA0KPiANCj4gaXMgc29tZW9uZSB3b3JraW5nIG9u
IGNsb2NrIGRyaXZlciBmb3IgaW14OHFtPyBJIG1pc3MgYXQgbGVhc3QgYSBjbGstaW14OHFtLmMN
Cj4gaW4gdGhlIGRyaXZlcnMvaW14L2Nsay8gZGlyZWN0b3J5LiBJIHNhdyB0aGF0IHlvdSBhcmUg
d29ya2luZyBpbiB0aGlzIGFyZWEgYW5kDQo+IHBlcmhhcHMgeW91IGNhbiBnaXZlIG1lIHNvbWUg
aW5zaWdodHMgd2hhdCBpcyBuZWVkZWQgaGVyZS4NCj4gDQoNCk1YOFFNL1FYUCBhcmUgdXNpbmcg
dGhlIHNhbWUgY2xvY2sgZHJpdmVyIGNsay1pbXg4cXhwLmMNCg0KW1BBVENIIFJFU0VORCBWNSAw
MC8xMV0gY2xrOiBpbXg4OiBhZGQgbmV3IGNsb2NrIGJpbmRpbmcgZm9yIGJldHRlciBwbSBzdXBw
b3J0DQpodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9hcm0ta2VybmVsL21zZzc4MTY4Ny5o
dG1sDQpUaGUgcmV2aWV3IG9mIHRoYXQgcGF0Y2ggc2VyaWVzIGlzIHBlbmRpbmcgZm9yIGEgY291
cGxlIG9mIG1vbnRocy4NCg0KU3RlcGhlbiwNCldvdWxkIHlvdSBoZWxwIGl0Pw0KDQpSZWdhcmRz
DQpBaXNoZW5nDQoNCj4gQmVzdCByZWdhcmRzLA0KPiANCj4gT2xpdmVyDQo=
