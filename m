Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42634C54FD0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 04:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE782078E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 04:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UtWRcrbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDZE3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 00:29:10 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:52960
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgDZE3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 00:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fw4wDm/93kdCzKnlVNdw4e8pKJitKAaoye0bY6uejfv32H09a1XTXpaJHNov3uH8A88OrDvtt9Ckd+yxmErtdcw6GF6Xdgi/A4cz6gNkWpTsF8eEgvGgt+S2Oi5MEtI9X4RjmXvELBR+AeafQqAIDD5qVw6Oy3wfYA3fg04Jeq5K63ktftd6nkbUU5LntKl3PLYoH+iKKELEvalZDIFuZ9k+MbdU7nLtDT01MPBfQA4JmXaHSBsfnkrrQm42I+N9anL2nRrwnm2AwoCqvGlmpp0+7BxUTvqP1COo1tuELeotVehiVO1jfdeqsNnFSW0qqs89IIi148pF6/VEoLbMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhRx8a7vkivhsbgc3VhCwX7FaaSYSKJFtKDurRDue98=;
 b=aTg1V9AicwLJZj+jzacUVkLaaZlXh4hAaDgnXpbUHluWoGVt8ZNo6tLi0259A5s3oEfQKGpcjaX/UbKgdLT8TW9RbcaQ64cnfRTD5eGWqZ4NVT1ddcHd0ynaW8vzzRzRikpm+A9ZnfAfB+ux5Op352gLe8fvopWHwXSqFUiVC1kD5wCCn4UuSM7+BVi5Y1xe7cfWkkrzEq705AjPUsBetuBHb9NSqfjZGlrEazDWDNyq4Oclvitwa+W4ANGWq+ndQ3BfNPS+l9hyVl5EleNT4koekmYkdxSFiCynUQOyq1CRF+rV1YGyr7srDK+Op0uEFMZ1ij40k/kJxHxHi7GdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhRx8a7vkivhsbgc3VhCwX7FaaSYSKJFtKDurRDue98=;
 b=UtWRcrbe6riDbI+nkzid9lAgMxUO6SJdDpDCYlPoPFRJyYy1zeYcLv697hF7G1PtcWHsLMCUJvSaTf3+OV0m7+Y+NP7xYUhIVQau/6GqSOVtgq9LyCjgtG+GCQskavPASltTy1MoJWd/dRYJPbyszk/KeliPdZOvTmpEwP7UfMA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5397.eurprd04.prod.outlook.com (2603:10a6:20b:9c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 04:29:03 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 04:29:03 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 04/10] clk: imx8mp: Define gates for pll1/2 fixed
 dividers
Thread-Topic: [PATCH V2 04/10] clk: imx8mp: Define gates for pll1/2 fixed
 dividers
Thread-Index: AQHV+FjDliBavkXAxE+a4boWx+ac7KiLFZLA
Date:   Sun, 26 Apr 2020 04:29:03 +0000
Message-ID: <AM6PR04MB4966B828D06FCF3C42C5AB8D80AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-5-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-5-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fbcb1b1-6f3c-4dd5-a9a4-08d7e99a59c0
x-ms-traffictypediagnostic: AM6PR04MB5397:|AM6PR04MB5397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5397AD4FA4A574081C604DBD80AE0@AM6PR04MB5397.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(5660300002)(6506007)(7696005)(7416002)(186003)(478600001)(66476007)(4326008)(33656002)(66446008)(66946007)(64756008)(66556008)(76116006)(71200400001)(44832011)(86362001)(54906003)(110136005)(9686003)(4744005)(81156014)(6636002)(316002)(8936002)(2906002)(26005)(55016002)(52536014)(8676002)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+5p/hn62v51ETpOUn5hB5a0Imar4O/iJEfQ1luCHgqmJj81uuCrb2+ocVVscBfZ4+Mrr23TWrgZHzV7WUm/L5EEs2tWMM+Au2rUwEmHk+rGPdQk/b++gz89wiJw0FN577lhqmYHK07jr4nJEWwEgViF6Fm4t51n8Ph+yhq9W6bq6iIBhCqRrRj3AoAijv0bT+od7hMzn2kpFHxXUxhnQUbOIVvrV+R2MuMjEfYSFAbItpWbAHDx2C+v28W8woN5jV997Iz8dtGXvjv/auQSi2ZUjrcxRaOimld0/hRcGYvnWXSQnsVe1qRU2IxUFzdcGgnnlUX06tx0N7qTdm7Zw86YYdrnLwA0C/vE0krSIBNC1zi/6+bf62LxHk2NqrOrGF9HmIW23o7mB39Zlpo4Or17X5EeU+qn21WQ4rP3IxJ6N0MNAhC01d0HnLl73ylCkAkGGxQzQOeVzItx2kV4WT1xI65fbiF4Awf7SVs4LA7sRSinOfaHZwXXGHJNaFFW
x-ms-exchange-antispam-messagedata: b7iFLyrw1vz9rJxOieovX8bW/BqvHfi5nqSvZOuxkcilLdUy7mBFIOlEsrgCimLhZnUoaqxEzQmmYK3lDLX3Bh1cjv7rurpygyn1/h8nTdbWEDOd7HLxe1ndWunLfQ+geaTqIdQhEaY5DRNtRhXQJiinLIMvRu8hbyJ3N53ZvUgLxEWNmniqreq35fz2PNiqHodTY7NUdcOevAkf3gICPKwb93OG7DpFpdxiOzl1/NkXoHTFd1GtkBBWOpre760vMVBjjzNrEJW5AoKp7qWuI9RLSH8ZBv6zsha4KysXpCrJDzfyjijSu4Rbsfi7P543nS5v3+1POvZbRdO91ptdxeGMmLMxygn5VMJ/11ju/v/bm6WWskOGJyYxRXTQB0rusInJ+TKgBvr/16ozOBsLExfINOa9K/CacSTZGqJvMLTBsvdRFN6Wk4VFFgA/1W5gS4Bz5yx+9mZs3hlyClUUUWJ3PFDgCuabKMCwMUsEF/RAEvekpqlnYb48WllwUOhbEe1DmHAT/qW4dZxab4RniG0zMu1PEpG+7rIrxRmHYScOuj/jzrHU+p7qJgmEUEeYspxEF1UKhGaXODtUUzbBp++/DoVSzcJOaorzsAIM/Aai/zjIYDWyEvi1rNtffTWVXvUNomv7S9mkgMG8Grs36q9Uyg7gVv4IOogkvNha9JSkwH0V1etHn+zQ4lLRnGl6lVZKer7CzQvYhgChE4WXeoYt7OAobjLA68i9DXuDnrhGmbrVtx98gR7wK9P8OEXdteMQ2c/5MmjoTNglwXfY9Tvtfigh0qQNgL9lsIZsmj0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbcb1b1-6f3c-4dd5-a9a4-08d7e99a59c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 04:29:03.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dou9BbAdQ3YJYVB+oQoa3pzkqzkiqSGIOeKArhWok4kYHptHZTTt0KgmW50r4ekt4FbuNNZf35cmvv9sJg9bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDEyLCAyMDIwIDY6MjAgUE0NCj4gDQo+IEluc3ByaWVkIGZyb20NCj4gY29tbWl0IGU4Njg4
ZmU4ZGY3ZCAoImNsazogaW14OG1uOiBEZWZpbmUgZ2F0ZXMgZm9yIHBsbDEvMiBmaXhlZCBkaXZp
ZGVycyIpDQo+IA0KPiBPbiBpbXg4bXAgdGhlcmUgYXJlIDkgZml4ZWQtZmFjdG9yIGRpdmlkZXJz
IGZvciBTWVNfUExMMSBhbmQgU1lTX1BMTDIgZWFjaA0KPiB3aXRoIHRoZWlyIG93biBnYXRlLiBP
bmx5IG9uZSBvZiB0aGVzZSBnYXRlcyAodGhlIG9uZSAiZGl2aWRpbmciIGJ5DQo+IG9uZSkgaXMg
Y3VycmVudGx5IGRlZmluZWQgYW5kIGl0J3MgaW5jb3JyZWN0bHkgc2V0IGFzIHRoZSBwYXJlbnQg
b2YgYWxsIHRoZQ0KPiBmaXhlZC1mYWN0b3IgZGl2aWRlcnMuDQo+IA0KPiBBZGQgdGhlIG90aGVy
IDggZ2F0ZXMgdG8gdGhlIGNsb2NrIHRyZWUgYmV0d2VlbiBzeXNfcGxsMS8yX2J5cGFzcyBhbmQg
dGhlIGZpeGVkDQo+IGRpdmlkZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
