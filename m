Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B05DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5A62070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bpoz9Svh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgETDB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:01:27 -0400
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:35212
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgETDB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVPPuJZCZTB7h+R77HFt3RjVCzsgbRJcJHmF+9zY72UO4klUxfKJKT0XatKKHXU8Ptreb6SwqXtx594jXGO7nF7lHd1Q0A26hRmyINh501mMBCG8VK15d3Wt0vTkCFmPO26jjUxEOQzouVAFlYESg5F2AaLKP1cxpHGYGCMnwtuPxqmyR7pchxMovlY+d1noNhhAjNygpMz7wePpDJ6hGtYFUw+adeWrIoBsg0HnQP8iN0gw2xM+Vzz2IGLXMtEkwy5L9RNNaFZEHElw2KRQLIqMtR1CzKj3oRCXuwfO32Xz/hhK1OpodbqJdVcqdHwTqi44IEXnSGcnYWko9tmAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqYx3Ua7kL60hAsLDKtyrWzaWQwaY6lSxmbTkwtYS6Q=;
 b=lraI2zMe5FCOWPHiapU35YMjjK01xybZLaWk1p3sC8D7Hh1fAYAMywv3Dhy3hFJ7iN9hxpv7T6dgNNPToLNYO90Rfi6XsW75VKwDcbDaGbBYWQ/gDEdfdNUYYTev6Prg0SAKTTVcqx4upHjo6z0F0KV581ip3ob104Ndou43KztZN72rOI/owdtySso5TlGy8d3y/37fDniRLaJjwYBtq9ErSMyzpjYYKemyPV414vjVvUryjP3pvEyFCWs3YbZls/bEbqIODKihbSeZMEinR2RhtZMj2pIbNsn9c+vcFQZKLRo+ZV/e9UtBbXcHumae2GEg+fsw3GqqtpBaVSYnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqYx3Ua7kL60hAsLDKtyrWzaWQwaY6lSxmbTkwtYS6Q=;
 b=bpoz9Svh3rqja2uWy+turxh3HZ3WV8TNEoTbQNEQ88s63eoLcWuus7BQZCFG/mPLAdrUEtIAjX3o1BK6YxaHg8Ugk6s0trM1pN4cmBSoRgO/XBeZ8XrqmyoEvnEf+qyyCJ6OtK3JL67ecG5aSVgu0DN3l4FqHkgHTCY9AqpbW1k=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2870.eurprd04.prod.outlook.com (2603:10a6:4:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Wed, 20 May
 2020 03:01:23 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 03:01:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mp: add mu node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mp: add mu node
Thread-Index: AQHWLkxzkzQ2vaqxukCIUytKVqWONKiwSJ8A////3aA=
Date:   Wed, 20 May 2020 03:01:23 +0000
Message-ID: <DB6PR0402MB27602682E90E4CED55244BCC88B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
 <1589940278-3680-4-git-send-email-peng.fan@nxp.com>
 <CAOMZO5BPPRy_XGHHyZfE3eOrmCwW_VytueY-An8qqke6HU06TQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BPPRy_XGHHyZfE3eOrmCwW_VytueY-An8qqke6HU06TQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [221.225.35.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbf9c2b1-5829-421f-0a2b-08d7fc6a1452
x-ms-traffictypediagnostic: DB6PR0402MB2870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB287057010F5D3F677029785D88B60@DB6PR0402MB2870.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLrs44IBw3cjkIBR7hY28CJkK0qJaBMdssG+pATxcdckMm0YfM50bouUMh708emDxyBxF349i606e7+/wC4e3MFjhDUEvUoJqFNlKGW5zM0xM+IXVvAOkrDjifuv0Cagz8gUw05UhOrFIV3yPNoNsszbq2RiNt01jUp6rbbqm5XY26mF+4oxbyvnbVPE6QCzFNVJTWreidJLnj58bDs6rzDnXUqDnDJoRmDSJpsp8JcSwOrckBEVwv0rXmRA0yUq4IHits1KyXMUQF7fpSSAlMsgwqBoQiBbogW5CfEjjIOXpGfLJaQ73xqGJXm5oWZbnlbxvyXNZE5C5XAtS0wfBD3Y8uzA9nE18RzA4mcJ2x7sL25OP1fvjxtVVsGV+w5jhyg5UhiGl6bnvpANWnKamceCdFNINTIkHIXVrU+3oJns5WELeJF7uk2WqQzQLZX6AbCCWe9I+HN/x5tZKcpmXGaI8gwrklcA+Q2iRIXuH6rKzqs6A0pIx5aYNMWHVeIG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(54906003)(5660300002)(66446008)(64756008)(4326008)(66556008)(66476007)(66946007)(8936002)(44832011)(8676002)(76116006)(4744005)(33656002)(53546011)(86362001)(316002)(7696005)(7416002)(6916009)(478600001)(26005)(9686003)(55016002)(6506007)(71200400001)(52536014)(2906002)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: i2B83DEH4q6QyvA0r+yWv5Nz1Xxd8LSIcSN+GMdZt7lKmMTu0Juk6UXmqcMMRi1OOZfbpkPWPcHHlOBGeXlqrm304EpsTeU4ltAyO6dbFL/25PUs2wh2uctUCeNwiAP4rGplXzS4T9GhlV9IEijB5R+bBMlGBzO58zknxcilz7cgI/D9mX9IkIaPxXxkxoRB7IR07qWXAUKaM7Oe6LAvr3kSXEA8GG36WH490fZksaT6IkLAgl0vM5uROhfSxB5i9ncGqoAS4+WKNn99u/HHn2+yewd6KZ8XJKYKaBnA9/qVGyy/X2GJzAYlAmiFlui6aOqXF/ROVhCNuC9k1LdFxD9dkciowGYFua/K6UO7ivL6huCdKQhqXV9btrDZSaLrZaGMDC1BpGuztre86/CObs1pV0cW94ZuP0YpCGSIm3vH1io+jQVurNT4rqdmpiNXOQrgUCZvVdW84l5sHA/Qp3MHqqWWMjQMdSo3PVw0kow8+7p1rmys90LYfq9WEMTS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf9c2b1-5829-421f-0a2b-08d7fc6a1452
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 03:01:23.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5HQDgh+hQdURzQwxCaWZlMRW33VXRtOZs6K7nTO+ayRHu4gnfgp/l8IjRd8xp9SO6aZNv1+94zcKlpj/nKnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gYXJtNjQ6IGR0czogaW14OG1wOiBhZGQgbXUgbm9k
ZQ0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIFR1ZSwgTWF5IDE5LCAyMDIwIGF0IDExOjE1IFBN
IDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbXU6IG1haWxib3hAMzBhYTAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14NnN4LW11IjsNCj4gDQo+IFRoaXMgc2hvdWxkIGJl
IGJldHRlciBkZXNjcmliZWQgYXM6DQo+IA0KPiBjb21wYXRpYmxlID0gImZzbCxpbXg4bXAtbXUi
LCAiZnNsLGlteDZzeC1tdSI7DQo+IA0KPiBGcm9tIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tYWlsYm94L2ZzbCxtdS50eHQ6DQo+IA0KPiAiVGhlICJmc2wsaW14NnN4LW11IiBj
b21wYXRpYmxlIGlzIHNlZW4gYXMgZ2VuZXJpYyBhbmQgc2hvdWxkIGJlIGluY2x1ZGVkDQo+IHRv
Z2V0aGVyIHdpdGggU29DIHNwZWNpZmljIGNvbXBhdGlibGUuIg0KDQpOb3RoaW5nIHNwZWNpZmlj
IGluIGkuTVg4TVAgZm9yIHRoZSBtdSBwYXJ0LCBzbyBkbyB3ZSByZWFsbHkgbmVlZA0KYWRkICJm
c2wsaW14OG1wLW11Ij8NCg0KVGhhbmtzLA0KUGVuZy4NCg==
