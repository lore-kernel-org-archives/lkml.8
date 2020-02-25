Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8081EC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DF62176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="POWk9i9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgBYNSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:18:34 -0500
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:32781
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728981AbgBYNSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:18:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEunnffjM+MzhFvNIsYjXXMa9t7ftyNui/QGA4wfJ+CdMod8qYqOd4/mgCGa25svk+9qkuHtEQ+drKGtnysRsz/MbcWGyaEhCEfz4EQjwjpnK+T40R/HfTIyayxSYMxseM0iyYbZCNkK0o5kdpqAywkb5yEj1jW6R9zZgE5OfP1euDBUkKq0anTk9bGri2IhTaBhmy2+yHre07Kjzjx1wVQwvAtSOCdNZrejlJ3Ss9c4kfGyfmXDC2s3QcSpsPnEFRP5KM7hguG005+zYIJyebMZNNNfu6M9N8nBYlJXVKvqijmbwv12smwbJbfdgk3XgWRSXmYwwuCtsamxEx3ZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIIIs4GqHpVivBNY6K/ds+zxz3M1YhN7rGtj8fz8rJA=;
 b=J75MaKpv+FHhD0cq7cnSNkZ8H3zCQ9Z68UyGJxix6MES99gw28td8RjbGRxmy6Fpr90VhU6E4uZjVeuQ+SeqjekLtaiGfszda/1QdCAoXF5zb1Z7K/IpOWlUmQ2SnZyjpwFQmrKG6z57Sa7IJc5YnIFfIZ9LaDBaFkZ5WfNw/VX3heF5RswW/wpTa5oDTjLnqXwZW1IlrIeb0C8z3kCpQ2fzt/CCRRtkWG3GAmoLuwYAFfDItQknnKL0Dw+QKRks0R77428JKs4p2WQsazWeplIvsr9UMr4IH4ShRp/Z43GWrEwAJleR47UNHadsrHlf61+pi6G+NYK9dA1pa3oEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIIIs4GqHpVivBNY6K/ds+zxz3M1YhN7rGtj8fz8rJA=;
 b=POWk9i9C8nuyiwNBVak1mw4mTuqRd6KGSL7+Cp5wrdO4IIfxcwlXIEccwNQmwfUx30g1dFXXHbvm/9XdFfLF6xoNyn3dKgs4OPMDCS3R5n+qQQCveO05yuawUWqNjZwYPVT6R5bgXnwfIkPMOyyHEP7g5a0jrnJTspNrJgQk7V8=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5616.eurprd04.prod.outlook.com (20.178.126.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 13:18:30 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:18:30 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Michal Simek <monstr@monstr.eu>,
        LKML <linux-kernel@vger.kernel.org>, git <git@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@ti.com>, Peter Chen <peter.chen@freescale.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc-xilinx: Fix xudc_stop() kernel-doc
 format
Thread-Topic: [PATCH] usb: gadget: udc-xilinx: Fix xudc_stop() kernel-doc
 format
Thread-Index: AQHV4ZORQFzPlcxWKkmSJAY3DwHopKgr3PcAgAAb4hA=
Date:   Tue, 25 Feb 2020 13:18:30 +0000
Message-ID: <VI1PR04MB5327D2970A145441FC7A34B08BED0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <c753b529bdcdfdd40a3cf69121527ec8c63775cb.1581505183.git.michal.simek@xilinx.com>
 <CAHTX3dJN5No9wUSDnmcMQXsGRKXKcLrDx_OhP-MF2yL+dXFu7w@mail.gmail.com>
In-Reply-To: <CAHTX3dJN5No9wUSDnmcMQXsGRKXKcLrDx_OhP-MF2yL+dXFu7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63fa49d9-790b-4df1-b3e1-08d7b9f534f1
x-ms-traffictypediagnostic: VI1PR04MB5616:|VI1PR04MB5616:
x-microsoft-antispam-prvs: <VI1PR04MB561658965AFD1FC607AC53FF8BED0@VI1PR04MB5616.eurprd04.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(8936002)(33656002)(7696005)(8676002)(81156014)(6506007)(81166006)(478600001)(2906002)(9686003)(55016002)(4326008)(66446008)(76116006)(66946007)(66476007)(66556008)(64756008)(4744005)(5660300002)(44832011)(71200400001)(26005)(316002)(186003)(52536014)(66574012)(86362001)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5616;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAiOJvXEmJQHGLWERTa7Z0UkSCDaNT3SyNmsgaWv2Nk4BfaTKWE4pnf2E+IlDzpb5Xj+LTs9DtOWsXiD256vK6Pfrer9fg9PQ3CSeW+7yaEQm91UzeG30XaOr1Fs3vb9m2mkCJqrk3WHG+zKKuglBECEY9kS7UFjD/g6nILMAWy0xEKTzck0PVNHujkQE5EIQQ/2Eu+U1Aw0K40BXN3EM0ljYyUVirbbe/SBytWZPc47Sl8Y5GZpSWj2RsQ6OUE7KZXtysvjAqDBHe+BAPczUi2lTmTStGETlOKO9wcYDzQYjnLKOPO/YoF8wFKkzSjisBZL+1wVu7AQ/wCUoq63vXKF3+qknDX3R7A7QIYxiBa8EOLP7Ql/AdXZP9KwZGtslsrCyP8xWRfhwPWlP83VuEWQznDRHuBPOfK4JGmFlDrjwq6LHiqygWLJFAoL2UYV
x-ms-exchange-antispam-messagedata: w7P4HrbyAdPrBm7Zj/4/yUwdWf4qAFvgWuc+awdkQl1sD8Vw1ydDcTXwPO6zXUCWsTcQr1aMIcAgQ95S8ibGUh+R/mDSzmO+aKA1M0kA0K9Afam2ipUABvW7qDiJK4p1MJTy5d6Wk6vdl78a3vhFPA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fa49d9-790b-4df1-b3e1-08d7b9f534f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 13:18:30.1526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Puym10WGAFuaOR9af+3JawVsbPiFvdxU5gt0fru5OwhbetyMMy11fsmUYB3SBmxmCV4jAciGDiy5w3nsZvT3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiANCj4gc3QgMTIuIDIuIDIwMjAgdiAxMTo1OSBvZGVzw61sYXRlbCBNaWNoYWwgU2ltZWsg
PG1pY2hhbC5zaW1la0B4aWxpbnguY29tPiBuYXBzYWw6DQo+ID4NCj4gPiBUaGUgcGF0Y2ggcmVt
b3ZlcyAiZHJpdmVyIiBwYXJhbWV0ZXIgd2hpY2ggaGFzIGJlZW4gcmVtb3ZlZCB3aXRob3V0DQo+
ID4gdXBkYXRpbmcga2VybmVsLWRvYyBmb3JtYXQuDQo+ID4NCj4gPiBGaXhlczogMjI4MzViODA3
ZTdjICgidXNiOiBnYWRnZXQ6IHJlbW92ZSB1bm5lY2Vzc2FyeSAnZHJpdmVyJw0KPiA+IGFyZ3Vt
ZW50IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxp
bnguY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvdWRjLXhp
bGlueC5jIHwgMSAtDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy91ZGMteGlsaW54LmMNCj4gPiBi
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvdWRjLXhpbGlueC5jDQo+ID4gaW5kZXggMjlkOGU1Zjhi
YjU4Li5iMWNmYzgyNzljM2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy91ZGMteGlsaW54LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3VkYy14aWxp
bnguYw0KPiA+IEBAIC0xMzk5LDcgKzEzOTksNiBAQCBzdGF0aWMgaW50IHh1ZGNfc3RhcnQoc3Ry
dWN0IHVzYl9nYWRnZXQgKmdhZGdldCwNCj4gPiAgLyoqDQo+ID4gICAqIHh1ZGNfc3RvcCAtIHN0
b3BzIHRoZSBkZXZpY2UuDQo+ID4gICAqIEBnYWRnZXQ6IHBvaW50ZXIgdG8gdGhlIHVzYiBnYWRn
ZXQgc3RydWN0dXJlDQo+ID4gLSAqIEBkcml2ZXI6IHBvaW50ZXIgdG8gdXNiIGdhZGdldCBkcml2
ZXIgc3RydWN0dXJlDQo+ID4gICAqDQo+ID4gICAqIFJldHVybjogemVybyBhbHdheXMNCj4gPiAg
ICovDQo+ID4gLS0NCj4gPiAyLjI1LjANCj4gPg0KPiANCj4gQ2FuIHNvbWVvbmUgdGFrZSBhIGxv
b2sgYXQgdGhpcyBwYXRjaD8NCj4gDQogDQpSZXZpZXdlZC1ieTogUGV0ZXIgQ2hlbiA8cGV0cmUu
Y2hlbkBueHAuY29tPg0KDQpQZXRlcg0K
