Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A95C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23812206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eCcMk8wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEKLK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:10:58 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:65203
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgEKLK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:10:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exMnq0W7c7esuf/L8IP+NwuBKHFo09cGrFmqes6o+y8N5modiRVJ+mCRLJkbmQTvPUO+lKgvWMrfDpxSFuqoJgPD3QwXJVy/58EjBmxeJzJBWRzrSv82vdtEluJ9Ky4JBouftlzpdr0sLm34qP5r54Cb7Ow7B6kCQ0SEs4oIG2cUJILwjkirF/9ympB7WaBqMAWGmjTVBCFHmwFALAb8tLoPP1IUkfMnaPhnWd3aWDXNvpub/+QrHajsPcKLx6L5gWzdliNvxGFMUzNLtUDYnugaRoGOMoOb/arXyjf0tzBxZwRcIBKEirNsckB7KE+q3Uy07McpL7Z+duPhJmYWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBHRX+NCfW9OUJSreUNfE88O/DzDXLDG+uHMsez8Y1w=;
 b=gDBiUpukjhtZtgzItQK6a0WIuaWbzZeymQSIiJubyRHGfVzvhwhhVGDRcAxZpdR4ZzxYCR5uOcGW9IQ1MOuCmbfaCdsLoRCd9eb3wtoMz/io0tpWZBf+4VE/X5ilpkN/9cd0bfrg7RTTQE+aE/zIFemjSpMi46RarkcUhi2v+tacpvAfAtvr5u07OCP4+I8tTC81LHZD+VuFiUo4/hG8rZpLN6Gr3en2Y4zf099qNNoC46TWRefaJytmJdlgvBGKbpPAho6wdCAkEKvAMVEDnAB7LYbBgYSvovOwAZlYzaM0vJ5T6oVx/cR73yNPIvkTTd9yAOa49eCLVXTH1H/osA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBHRX+NCfW9OUJSreUNfE88O/DzDXLDG+uHMsez8Y1w=;
 b=eCcMk8whZkd68Y4xlSG+4c9gYO4Mj0V0tK1EewHLvxNUNVtHwPQGeQ9Xu1X2d/aYQb87ffHDfekrmIY6ePOQQl34OmSsONC/AVmpv3IsX4OrZscWkifXR+Xt6iynzyLz75QZVKnsuy1rJsCYp73u9AkR0gX93TWkjz2f8nCP/+4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 11:10:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 11:10:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] arm64: dts: imx8mp: Add src node interrupts
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mp: Add src node interrupts
Thread-Index: AQHWJdumWve+yy8KZke1xaVTXiUFTKiivd6A
Date:   Mon, 11 May 2020 11:10:54 +0000
Message-ID: <AM6PR04MB49662146049364DFA24E205D80A10@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589012271-12740-1-git-send-email-Anson.Huang@nxp.com>
 <1589012271-12740-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589012271-12740-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f4060d6-1801-4b0d-14f0-08d7f59bf922
x-ms-traffictypediagnostic: AM6PR04MB5925:|AM6PR04MB5925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB59250CC24E2C0DAC4828BE2280A10@AM6PR04MB5925.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+RAf/dfezkcqiTyUqekV6eRwn78UMg+uqpr3alG3NVV5VWwEmT/rW0NVg0xZaCCAQM4MPjjtmh5BNBt41bz1UJrpbxlZ/p1IX17LW/oQ2fiEIOWSMmXw4rxqLBf2oOPnWTIRTzZlX//TVOvCmd5uvBKUErMRKmGGGKVO1qavo0XpRBRgx+9FWZr+jQ0D+V+6x0M5J5Ja9RRC/aUizFDyN62tOWW068BxKUvVkvA5DEJwgzHEavH788mlWA/ikpeT5fzyWpeUdFzFCZw9Jrwmj8hQ9hNDqtQJey8epk/UIabBUuqpyPVXd4sJ4tRPhTfdv9HBYGCOtfvThgSxs5wC/WOCfplJd3Yu940S7PL9/ZTsV/WLy53jOQ3kMMwUEcGFWwtXa0qGO/qzIWBjBabRTPb0tPbbu5bridSU/TUtABKqRXC0xUWYUixObmrxv2Gg7C3T/Qqe7XMNdKD4Hn+d4Qa7PIBq6bCRcJkgsD0I7FIAqD3KTDqiPwOJnaT1YNytKggrt0Tty9J4CuJ8qGGQJXN79ftI1wQft7Q1FzQnSEFI/dp3zOFI43adwQzJJs0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(33430700001)(316002)(7696005)(9686003)(5660300002)(7416002)(55016002)(44832011)(558084003)(86362001)(76116006)(8936002)(8676002)(33440700001)(2906002)(4326008)(66556008)(66476007)(64756008)(186003)(52536014)(6506007)(66446008)(26005)(478600001)(66946007)(33656002)(71200400001)(110136005)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4lzzLYKf1G7l1mnTvow9LjX5mLAO66I8VXBlFz8AGFVt+2eDBSsHwFt6xKaSOuuCAPQk5o3NE4bvNp439YR1kKyIr5uubJ59qos6f88Nc8xXGJhA8NFIDPYJ1ho0UW8Yj3uedfyMogfJHw1/CP0v9F0DicVC+cvizoaxrFZkWnw5yRQg7QINQZD5m3aNjJysdfRFcDj89Is/RoOduQNwumtX3AkekVHXA/9FqBZJzPbJv68NiBpWFgq1uSjp8s7e6tKA5AUlQnN8yNWWaPl52853DYRVb57/zND9/CvoYe4ABVwGgCrK0lYx/clA+9EE43hX2IzEP29a4t6pJvkc43nx7u7+5y6iw4xzLcqZC+7iJak1ndwvR+3MVOnIhByZPWaNqzwY3OWFrueXu1lGgJNJwviZIZvb+yE7N1tDq7ENmAkELEujJriwvtmAzBTy/lsi9PGdSRMtQnp90qp+GJFPLUoAlv1/RpRarFHLXLg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4060d6-1801-4b0d-14f0-08d7f59bf922
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 11:10:54.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzNeiWY22dGlmsm6l9Ydjk9D9I9uupHgV4lwwyQGabfYkmP8JCifoufLiDm0A4JwxQLTtBBid/Ys5FuM4gjz5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogU2F0dXJk
YXksIE1heSA5LCAyMDIwIDQ6MTggUE0NCj4gDQo+IEludGVycnVwdHMgaXMgYSByZXF1aXJlZCBw
cm9wZXJ0eSBhY2NvcmRpbmcgdG8gU1JDIGJpbmRpbmcsIGFkZCBpdCBmb3IgU1JDIG5vZGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0K
DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVn
YXJkcw0KQWlzaGVuZw0K
