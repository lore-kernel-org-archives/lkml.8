Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9C8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B44D20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DWOs26TX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgGBHMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:12:43 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:6032
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgGBHMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:12:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3I2cunhuc0aZb2Q4YYMeWnSMtKj8GvaeKEygc99vt/OSbQ3ELld+83CrmdFFL2LM5ksyqprSchZfuxkAXGu+jGiv3DeIHrqwWqgElb38/cl9/zrzs2wzlsCjmkWkxDumsOVNSJOv4phrF1Dqq4O0dEqNYZjVzkad/YE6lyIbxA/zXOYXIZquchT8zqwNWR+J83M63k/mZaSR9pbvjK4fqugQyVj6yosjOvQcfdZEw9ZIiVROa8e/wmt1nPB+d9Y2mXWvR5DSGldPrjBZQaz26dDxZTS/8KjfBqyzNYIa0PCD94ho0LbqufVVkVvC/woULDj73sRyeHySzRFWizy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEKe9+JD0q0mqqfzP3C/d7uoa7bEc1dqym+hnurTkuE=;
 b=TypQ6Z3WOwl9XNbAOxNmlk3szjOu2+vNdsYJUyghBKzue5kl/M+bHSrXGBb9TT3SbhXMiIADeD683hDCXonNeYIdIRd4eEmwuvY8kMPtOoZyw0ZamSmFVdjQ9C8MfPkTtldW+qS3Xpev2MGBq/BlzWTQwEOJVqMeYwyRqR3Py18YiF1TzmxS8PvBdo+G54HJlxlvPx94AH/p+dqcwfflwGDkY+YNODjnzWizdNPvFsp3FOl04iDSEPsaVM3v1HXFRrGj1KmcJ6GheYY0GVIdlkUHZlL9QFQGEDifBr2J7hSlilGNCb2L8bvf17WMJnsfZ1tSlLf4m/tbJitlnBhYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEKe9+JD0q0mqqfzP3C/d7uoa7bEc1dqym+hnurTkuE=;
 b=DWOs26TXFGRZP66wga8gVsq3eCH+6HHWu3qG3Xmxt5ktPJYwSHd0WtuGP1m7GUe8gQPXZtcwpa9qoL6IrvpFVdh8x3/S1UMAKMsSHi2tifw1sDeAtSp4pFyDKcgFOsutQsCpBB/EjU88ilArCk9GTVIGyJZ4rl8LEfaPrQhOiQk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB5082.eurprd04.prod.outlook.com (2603:10a6:10:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 2 Jul
 2020 07:12:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 07:12:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>, Dong Aisheng <dongas86@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
Thread-Topic: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
Thread-Index: AQHWUBb/eaArIN5lW0eg3m9Qeje+NajzluoAgAAJBACAACXUAIAABbYggAAHpQCAAAp/AIAAAXTw
Date:   Thu, 2 Jul 2020 07:12:36 +0000
Message-ID: <DB3PR0402MB391638434ED48B67EEAF8C02F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com>
 <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
 <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com>
 <AM6PR0402MB3911049CC1B136327345F11CF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <CAA+hA=S9ENXtD7q362=y84qKAtR090pZOd6MF6uN8W223UK-+Q@mail.gmail.com>
 <CAK8P3a31bZ1XDjjv1LRvpgifxqYUuBRFbPEc+eFD8Dby+mRE8Q@mail.gmail.com>
In-Reply-To: <CAK8P3a31bZ1XDjjv1LRvpgifxqYUuBRFbPEc+eFD8Dby+mRE8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66bec2df-8526-4b8f-a219-08d81e574c61
x-ms-traffictypediagnostic: DB7PR04MB5082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5082B8D0E535279DE0188CAAF56D0@DB7PR04MB5082.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsTSTEtTvL71GQyLDw+DOxFShGegO6pz1JOUq/AKzgPlbD//erHMxBVbexldbOqbvwhlEhu/kAJHfMH2WclZTt6ccHYZtHuB7Ratx40uZEvuIzvuPvq9oczaaBrsKP9VVK5J1aWG67Tncr33ubmJ3y/mPMAiW3MSen2L9LLn0tzZTHd5RkEWUQYm33/NaRB3wEb4vlUxYey1h2ZF8/Cg4uX+YpYvDyrGCmfUeCCvpQptYJMXXiI1lAj8oCEp8cv/ASG2KXdVchn1Ovb/rfNj26CRO1YcoLt8+Yh26NySUzb9oyeHTdRLkFEmnHFJTqyy5BQrY2l8QtsGzHYPbCUCxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(86362001)(44832011)(6506007)(53546011)(26005)(76116006)(54906003)(110136005)(33656002)(186003)(7696005)(478600001)(4326008)(316002)(55016002)(52536014)(5660300002)(66476007)(66446008)(9686003)(83380400001)(66946007)(66556008)(64756008)(8936002)(7416002)(8676002)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jSusJ+XYJFhlVNQDKv1ZKpOraiKyrc/DcTnm1Tn3vNGMS87qNbzOkXNXpoK96FLt6FzbDEH/WZMXcFRGDRQbHgO+HzlpvEy2YOCNUjOurMehkWwWJes3lR5UZJ3P0N698lL9KvkH3h1cwazhWnPE8ByinZEmzs69NpPQ6AufXfHnl77lNkWn+f6Krf9w0Kvtj4rQfi5xqwcL6iQEekhwg1a2I9xjS+AKqfvSgVIiJAz6wXTkV/lTW9oTKI0zGIXzswmoa9taF/d0ZD1lVSYb5Lk4zTDksqKfKZQsy6vf47R6B4nisdXbzBYIovfH5D2dwIgWw3P7D8p4mD6KGfMIV2PQLoPHmIPhACVZIW1UxbySaR8rH9D1pxpZ4KWhxRlxdXzv9GM6Cb9hvNsFIklw/2425VFwCIJh7xvfpcuCdDMt5oQ5KIV4bjFjoaK58MQ2xmgjBIWJyUdV9HUjp87Epi+X2qpctHrzg0vNe2bFiKGwomHXO6vyMVSMu92hz3Jk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bec2df-8526-4b8f-a219-08d81e574c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 07:12:36.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmU9qOQxcwvtpEmk0AC8LgFuUmkfE3IFKelOhpYd6j8x3df5OakYssOwyLfAA3qb208Vp8F+GnKPcq4L7loilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMy81XSBjbGs6IGlteDogU3Vw
cG9ydCBidWlsZGluZyBpLk1YIGNvbW1vbiBjbG9jaw0KPiBkcml2ZXIgYXMgbW9kdWxlDQo+IA0K
PiBPbiBUaHUsIEp1bCAyLCAyMDIwIGF0IDg6NDAgQU0gRG9uZyBBaXNoZW5nIDxkb25nYXM4NkBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+IE9uIFRodSwgSnVsIDIsIDIwMjAgYXQgMjoxMSBQTSBBbnNv
biBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggVjQgMy81XSBjbGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBpLk1YIGNvbW1v
bg0KPiA+ID4gPiBjbG9jaw0KPiA+ID4NCj4gPiA+IEkgYW0gZmluZSBvZiBhZGRpbmcgdGhlICcj
aWZuZGVmIE1PRFVMRScgdG8gaW14X2Nsa19kaXNhYmxlX3VhcnQoKQ0KPiA+ID4gYW5kIGlteF9r
ZWVwX3VhcnRfY2xvY2tzX3BhcmFtKCkgYXMgd2VsbCBpbiBuZXh0IHBhdGNoIHNlcmllcy4NCj4g
PiA+IE90aGVycyBsaWtlICcgaW14X2tlZXBfdWFydF9jbG9ja3MgJyBhbmQgaW14X3JlZ2lzdGVy
X3VhcnRfY2xvY2tzKCkgbmVlZCB0bw0KPiBiZSBrZXB0IGFsd2F5cyBidWlsdCwgc2luY2UgdGhl
eSBhcmUgdXNlZCBieSBlYWNoIGNsb2NrIGRyaXZlciBubyBtYXR0ZXINCj4gYnVpbHQtaW4gb3Ig
bW9kdWxlIGJ1aWxkLg0KPiA+ID4NCj4gPiA+IFNvIHRoYXQgbWVhbnMgSSBoYXZlIHRvIGFkZCBh
bm90aGVyICdpZm5kZWYgTU9EVUxFJyBvciBJIG5lZWQgdG8NCj4gPiA+IGFkanVzdCBzb21lIGNv
ZGUgc2VxdWVuY2UgdG8gbWFrZSB0aG9zZSBjb2RlIGNhbiBiZSBidWlsdC1vdXQgaW4NCj4gPiA+
IHNhbWUgYmxvY2sgYW5kIGp1c3QgdXNlIHNpbmdsZSAnaWZuZGVmIE1PRFVMRScsIEkgdGhpbmsg
YWRqdXN0IHRoZSBjb2RlDQo+IHNlcXVlbmNlIHNob3VsZCBiZSBiZXR0ZXIsIHdpbGwgZ28gd2l0
aCB0aGlzIHdheS4NCj4gPg0KPiA+IFdoYXQgaWYgd2UgIGNvbmRpb25hbGx5IGNvbXBpbGUgaXQg
aW4gY2xrLmg/IFdpbGwgdGhhdCBiZSBlYXNpc2VyPw0KPiANCj4gWWVzLCB0aGF0J3Mgd2hhdCBJ
IGV4cGVjdGVkIHRvIHNlZSBpbiB2NCBhZnRlciB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbi4gSWYN
Cj4gaW14X3JlZ2lzdGVyX3VhcnRfY2xvY2tzKCkgaXMgYW4gZW1wdHkgaW5saW5lIGZ1bmN0aW9u
LCB0aGVuIHRoZSBhcnJheXMgcGFzc2VkDQo+IHRvIGl0IGFyZSB1bnVzZWQgYW5kIGFsc28gZ2V0
IGRyb3BwZWQgYnkgdGhlIGNvbXBpbGVyLg0KPiANCj4gVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIg
dGhlICNpZmRlZiBjaGVjayBpbiB0aGUgaGVhZGVyIHRvIHRlc3QgZm9yIE1PRFVMRQ0KPiAob25s
eSBjYWxsaW5nIGl0IGlmIHRoaXMgcGFydGljdWxhciBzb2MgaGFzIGEgYnVpbHQtaW4gY2xrIGRy
aXZlciwgd2hpY2ggaXMgc3VmZmljaWVudCkNCj4gb3IgZm9yIElTX01PRFVMRShDT05GSUdfTVhD
X0NMSykgKGNhbGwgaXQgaWYgX2FueV8gY2xrIGRyaXZlciBpcyBidWlsdC1pbiBhbmQNCj4gdGhl
IGZ1bmN0aW9uIGV4aXN0cywgd2hpY2ggbGVhdmVzIGV4dHJhIGNvZGUgaW4gdGhlIGRyaXZlciBi
dXQgaXMgYSBtb3JlDQo+IGNvbnZlbnRpb25hbCBjaGVjaykuDQo+IA0KDQpTbyB5b3UgcHJlZmVy
IHRvIGFkZCBhbiBlbXB0eSBpbmxpbmUgZnVuY3Rpb24gZm9yIGlteF9yZWdpc3Rlcl91YXJ0X2Ns
b2NrcygpIHdpdGggY2hlY2sNCm9mIE1PRFVMRSBidWlsZD8gRXZlbiB3aXRoIHRoaXMsIHdlIHN0
aWxsIG5lZWQgdG8gYWRkIE1PRFVMRSBidWlsZCBjaGVjayB0byB3aG9sZSBibG9jaw0Kb2YgdGhp
cyBlYXJseWNvbiB1YXJ0IGNsb2NrIGhhbmRsZXIgaW4gaW14L2Nsay5jLg0KDQpUaGFua3MsDQpB
bnNvbg0K
