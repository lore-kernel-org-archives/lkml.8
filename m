Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA96C2D0E1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726032073E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M13KYvn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgIKHXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:23:55 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:60160
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgIKHXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMqYXotdOXUkCiPZ3UefnVko9SseUgVjGB162YIPpbp2XEllNWKF8rRBIejCO9BOpw+ABa+DnG+WuNA2BvciWbxDxa/5ajiskjaDhuhVFv+UjVMcPZ+rS6SRWMTGcm9bxtry9N00KKPL0Fcq6ZaXzcFS4/h3wr5JqLmQwYAVN/NDl3nndgUyk7NFEjmir0TlZ9I7xwVwD0l2FU8rSZrzI7JIxeW2h/DcAUjvxuq0bbAmZr1z990JvAARHR3wL02LaS1kzmgub+KSD8/4MvikaRHeJjN6Ga012h3bouXDErAwe5VA47Cdsk+ODYV6BV2zkbBhlcUifwOlPrV+AhrjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0nanApWIYBUbS/2eFIbgflL9HFnXRQvJg8WwRHWWuo=;
 b=FKS9t9IdPff6VPs9svwI5/qLPX+LRMSeH933mWSRrjEwYx4NQlcXnyIZSB2PiMx3FhiNTM0lHw55Tev5IWfLWlRvKL+dKeakiEE91XXh0ImayaQhdUwnSqGlT9qHwcpy8GyEaSWp/cAybA6dnWrcecuvER5WHU52XQc5vZ7gynIN4wBIXO+6VLOu7qmvucC2nFk3nHCTB7Nyw+/WqZwFbwaH0V9ZF+r2fDzJf7Prhc5ZcHVQIRMaqWzF7/FKKe7gMeNWAK1wwwWvI168fDcOJGNdxXIsT7zmpxsA8vPwyM31SH6awaPCaxDHJ5m9oB+HUsXNdYMlZVT3ROKmx6byRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0nanApWIYBUbS/2eFIbgflL9HFnXRQvJg8WwRHWWuo=;
 b=M13KYvn0Un+IeVI5vXL2z9Wyz5a7G4HpN5PJvfXnjSWNG/9hC8rRwcC5H0yr5IOdCsScjmY0SxCKsJ1m3ojJ1f8WnAJWHvw2IPgCCcYnYr4Cwyz8KDWybY/u6lzYKC558lsJQh2cC8mRz2fl1PjAJsgmljv6V0JjDGDq+ykDQy8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4037.eurprd04.prod.outlook.com (2603:10a6:209:49::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 11 Sep
 2020 07:23:49 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 07:23:49 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v3 06/14] dt-bindings: clock: imx8mp: Add hdmi blk_ctl
 clock IDs
Thread-Topic: [PATCH v3 06/14] dt-bindings: clock: imx8mp: Add hdmi blk_ctl
 clock IDs
Thread-Index: AQHWhcp5uhbtqb60PUKVoRuoMbyL46ljDUog
Date:   Fri, 11 Sep 2020 07:23:48 +0000
Message-ID: <AM6PR04MB4966F6E7B86FFF37527EC7B480240@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
 <1599560691-3763-7-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1599560691-3763-7-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e947eea5-accf-4577-af90-08d85623a0cb
x-ms-traffictypediagnostic: AM6PR04MB4037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB403796434695D2B32EDB3C1780240@AM6PR04MB4037.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZCtXAqzqQfM3f1At9DOOmrMpNUMImf1eBCSyyCLw39+AgfW969UOjV3xjlxn8XltiMuGA2zdjCvvE7UDvPIhIdZWV9D763GAdDPoW3r0ifGAbtyezZyx7aA5WN5ttA42NJyjUTrvPek/++TEkxYP+lYaWFs0Qmyd6SVzK96aBeq1FP/881br+xraLx1gCJUTPoZwShfo/ZA3kT2BPy0RenqzeYubWlvvZwHPL3qTAIL1pHiThdrQz/OXZWv0cjxgMVc8TF1kO337ZlEJHND4LVl4znPuMLKLchUo/J6QMXF+3IFYJ4sWiJkF+ITdkWT3j15XXAOiHAHbgVcTIQ99KogHrWEVubEHtx25JaK3Wx016gOBjp7ZAzRKwWmRC71yGz7xp3zSOqAIxdBwBe6n/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(44832011)(8936002)(83380400001)(478600001)(33656002)(86362001)(52536014)(7416002)(66446008)(5660300002)(66476007)(64756008)(54906003)(9686003)(66556008)(71200400001)(76116006)(55016002)(66946007)(4326008)(7696005)(26005)(316002)(186003)(110136005)(6506007)(8676002)(2906002)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KQQkqS2EoEzMrMygmq7sXKm1ZsDtWbvT3iuBATrJ5VC4YthcN9mIl39jKqq4XdtzM6H/65zkW0+ccmPYbzuOHTw9UCZ1HlKphAw/XeQyi1N5m2+SHtHTmFNPkB2ojBVtseK1D1x5pfLRDyHVTvUwvex68gIDIh3PDG4QXW5YjK7uPz+91JliDpUdq7bHoOwFYrtdUeSgu4yGgreIT1C5pHc3tYeJDfGdyySl3OTvukPm3w2LMOtADeJcraECHK9NBa785zbGv3rl62PFlTyDS3hQAN2bUrny8NDEoANyFARlQtz0zLUlf8fGJKxCaVgDRI0UHIp8rKnINyajQKqoaBDenlFo8mjN9722LMczb8XaX0Bq66WyZ96G0GpnH9rkHqvJIdOQast2SBO8Vxw8WtjwoomnvHwbL2ETp6+GrRBGFNTqAy+zk3Y3B260WmkpTB2d5RE8BKZp9YP9MEdFzXTds/EFGNtRuOW3r/PAKVpju8hNYltsokOFO1LGtsi8tj0L2NslG3+IcS8lyvnEh5WfPnq0wUpJLTVFHcw/vAHNQc257xA591DSOaRJhw9JRfK7oVlA11SkIh8I6sJw2NlzTLWfjl9GYqqYN8qwjxJrmHbclVvnydMx+rEwKzdbI1Mg6YQuKZuqbHaaZ9K2kg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e947eea5-accf-4577-af90-08d85623a0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 07:23:48.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PI3szlezl0okDLTTqGYI/K5KzW05po0jxLWNFR7cdCugoMDERyP4SEfMWec7ofj6x311AXt08xUvshXCHk35eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgOCwgMjAyMCA2OjI1IFBNDQo+IA0KPiBUaGVzZSB3aWxsIGJlIHVzZWQgYnkgdGhl
IGlteDhtcCBmb3IgYmxrX2N0bCBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBYmVsIFZl
c2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhw
LmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IC0tLQ0KPiAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9pbXg4bXAtY2xvY2suaCB8IDQwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1wLWNsb2NrLmgNCj4gYi9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oDQo+IGluZGV4IDEyNjMyZmEuLmRl
N2Q1MjIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1wLWNs
b2NrLmgNCj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4bXAtY2xvY2suaA0K
PiBAQCAtNDI0LDQgKzQyNCw0NCBAQA0KPiANCj4gICNkZWZpbmUgSU1YOE1QX0NMS19NRURJQV9C
TEtfQ1RMX0VORAkJCTI1DQo+IA0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlfQkxLX0NUTF9H
TE9CQUxfQVBCX0NMSwkJMA0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlfQkxLX0NUTF9HTE9C
QUxfQl9DTEsJCTENCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfR0xPQkFMX1JF
RjI2Nk1fQ0xLCTINCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfR0xPQkFMX1hU
QUwyNE1fQ0xLCTMNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfR0xPQkFMX1hU
QUwzMktfQ0xLCTQNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfR0xPQkFMX1RY
X1BJWF9DTEsJNQ0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlfQkxLX0NUTF9JUlFTX1NURUVS
X0NMSwkJNg0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlfQkxLX0NUTF9OT0NfSERNSV9DTEsJ
CTcNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfTk9DX0hEQ1BfQ0xLCQk4DQo+
ICsjZGVmaW5lIElNWDhNUF9DTEtfSERNSV9CTEtfQ1RMX0xDRElGX0FQQl9DTEsJCTkNCj4gKyNk
ZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfTENESUZfQl9DTEsJCTEwDQo+ICsjZGVmaW5l
IElNWDhNUF9DTEtfSERNSV9CTEtfQ1RMX0xDRElGX1BESV9DTEsJCTExDQo+ICsjZGVmaW5lIElN
WDhNUF9DTEtfSERNSV9CTEtfQ1RMX0xDRElGX1BJWF9DTEsJCTEyDQo+ICsjZGVmaW5lIElNWDhN
UF9DTEtfSERNSV9CTEtfQ1RMX0xDRElGX1NQVV9DTEsJCTEzDQo+ICsjZGVmaW5lIElNWDhNUF9D
TEtfSERNSV9CTEtfQ1RMX0ZEQ0NfUkVGX0NMSwkJMTQNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19I
RE1JX0JMS19DVExfSFJWX01XUl9BUEJfQ0xLCQkxNQ0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hE
TUlfQkxLX0NUTF9IUlZfTVdSX0JfQ0xLCQkxNg0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlf
QkxLX0NUTF9IUlZfTVdSX0NFQV9DTEsJCTE3DQo+ICsjZGVmaW5lIElNWDhNUF9DTEtfSERNSV9C
TEtfQ1RMX1ZTRkRfQ0VBX0NMSwkJMTgNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19D
VExfVFhfSFBJX0NMSwkJMTkNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfVFhf
QVBCX0NMSwkJMjANCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfVFhfQ0VDX0NM
SwkJMjENCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfVFhfRVNNX0NMSwkJMjIN
Cj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfVFhfR1BBX0NMSwkJMjMNCj4gKyNk
ZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19DVExfVFhfUElYRUxfQ0xLCQkyNA0KPiArI2RlZmlu
ZSBJTVg4TVBfQ0xLX0hETUlfQkxLX0NUTF9UWF9TRlJfQ0xLCQkyNQ0KPiArI2RlZmluZSBJTVg4
TVBfQ0xLX0hETUlfQkxLX0NUTF9UWF9TS1BfQ0xLCQkyNg0KPiArI2RlZmluZSBJTVg4TVBfQ0xL
X0hETUlfQkxLX0NUTF9UWF9QUkVQX0NMSwkJMjcNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1J
X0JMS19DVExfVFhfUEhZX0FQQl9DTEsJCTI4DQo+ICsjZGVmaW5lIElNWDhNUF9DTEtfSERNSV9C
TEtfQ1RMX1RYX1BIWV9JTlRfQ0xLCQkyOQ0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlfQkxL
X0NUTF9UWF9TRUNfTUVNX0NMSwkJMzANCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19D
VExfVFhfVFJOR19TS1BfQ0xLCQkzMQ0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlfQkxLX0NU
TF9UWF9WSURfTElOS19QSVhfQ0xLCTMyDQo+ICsjZGVmaW5lIElNWDhNUF9DTEtfSERNSV9CTEtf
Q1RMX1RYX1RSTkdfQVBCX0NMSwkJMzMNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19IRE1JX0JMS19D
VExfSFRYUEhZX0NMS19TRUwJCTM0DQo+ICsjZGVmaW5lIElNWDhNUF9DTEtfSERNSV9CTEtfQ1RM
X0xDRElGX0NMS19TRUwJCTM1DQo+ICsjZGVmaW5lIElNWDhNUF9DTEtfSERNSV9CTEtfQ1RMX1RY
X1BJUEVfQ0xLX1NFTAkJMzYNCj4gKw0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX0hETUlfQkxLX0NU
TF9FTkQJCQkzNw0KPiArDQo+ICAjZW5kaWYNCj4gLS0NCj4gMi43LjQNCg0K
