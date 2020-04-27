Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C26FC7C8A2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F296E2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C6T7t6dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgD0JMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:12:03 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:26479
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbgD0JMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwuV8kHN9pgIc3m+1q+VO2VhwrXUbbQkxnvWpOUGCkRrUn6O24ZVCPgbwtz7Afc6v1niukn9Em1/+RiHRvcBEx1y6Q0REff/zeolUuN1dpN2XXBL+Gp7ZSaHPWegxKIG2PF8lek0eYwuX7UElO/D1foNl2dtci50e6GtQbp5RgqhNOQ9UG8rDHBls7Tg43WhzGTNdtwqCyabt5NpLZDxmJkPQbbkvGXmdJh6GvApInRx4t8ON8JDW6WUescyMs3OvaIqdgyOhKXlkWi2QcTv24F5b0//Rszw9qlnahvG2x/JlcvGvxhlLsCgbvyBWpPC9p9/p3jAIrSC9OdR96+1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bDnst4dXlusnhUOAxaYT/hQk/ttcqqykctvFm+W6qA=;
 b=WLEw4g88UQoewIKdDNHELAVVOb/IsADrD8RM3sb1BxZDgRKA/B9bTFwsO9vnxKF+z+7zCB+9ZVN0ncjG5GsDSzrEXV1iToTVP8tl1PUXEtlWgFvwXrUVup4eyOdKzVWKh+twefIl4N+5aW5WXYfELKUmHhBxHV4Rde+yjHdivVya78A5UzgoAm8TMR1P0O4pwBAn56Ca7/K5S5MeoiaIXr/7WCe4URpFv6wxzwOGX3GAKVdZgqJxST3mkr4N5xaWg3Qg5qyQi5NHfdf1HvaQbv4vLqE3XB2Rss53irZVwCfTTnuaw83v79atojOqyVXnNzu+GzObIE6SCTMOq/mPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bDnst4dXlusnhUOAxaYT/hQk/ttcqqykctvFm+W6qA=;
 b=C6T7t6dtCgjBP6jjtR2U/+Ui7KFOAjL2slDERBMU2xZgq8oTcFZ2cLyRzAFss0dG2qsJaEhUAijySfIdgH62RF5XhdskCXCJb4Hbv10j7uv4r2lPWbVmeifYwO1Hjeernsw8oBOJPqFD6NoX3hm1ntv+v/WIvMQjC7R7ddIqxvE=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2695.eurprd04.prod.outlook.com (2603:10a6:4:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 09:11:56 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 09:11:56 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Subject: RE: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Topic: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Index: AQHV+FjOyMJp4JjxAkWF8jtS4KMMQqiLILmAgAHSuqA=
Date:   Mon, 27 Apr 2020 09:11:56 +0000
Message-ID: <DB6PR0402MB276047141A63BE756B9C06D988AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966D0EF272CAB282BF72EB580AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966D0EF272CAB282BF72EB580AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f12ddcb-ffed-4b2d-b0ae-08d7ea8b08ec
x-ms-traffictypediagnostic: DB6PR0402MB2695:|DB6PR0402MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB269586674C80866C2F87FFF988AF0@DB6PR0402MB2695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(64756008)(66476007)(66446008)(76116006)(186003)(52536014)(54906003)(478600001)(316002)(110136005)(2906002)(4326008)(9686003)(6506007)(86362001)(33656002)(7696005)(26005)(6636002)(71200400001)(66556008)(81156014)(8676002)(8936002)(66946007)(5660300002)(7416002)(55016002)(44832011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvxASt3EtIz//ewjYFigJtg+8fh6EVUb6r3HAtDHd8PhMDeq5Lk8YJUs9PVCdSU2p1xFvTsExzZMdjgSsdkz8xRB9TMsqIgpqg/94TwMN9DqXR5Rh/SuMvsQk2n6zXLeKLOkxFjciT6AmtKhQn0VlEExOfjc93E5GJh41A8qJuoIBevYTGaYLBNLNAswpY2kfHwmJDUY4lt0ceGIdsmtpuKnydYHW1cgpXoo0V48FyhYCp9rnCbQL9wsxHa3dpsmud9v3LwS4/T0L1etxKVkUFVZYCovChP2KR2umHuwhr6OJ2CqGiBQYGdX41m98USA9avnqSk4uwLx0QrmBG51X9eT005kIfkw3tzRhgZAxH/IMlIqNml5DzS4Zo1R7cYtB+abty+97oLwZfAE8wU43yqNgB38sSCXa8/Q5mqpvm0a8Lg15BDdm4j0GBHyti3J
x-ms-exchange-antispam-messagedata: CxpJiQUijhiSScjazk4W5zOwrrdAq6LztRXuudPZNUASB8so8Mnv9TqPA3jK0UNcag7k+oPqroSVf5qymKHKpKeiaqKE5b5buhdUl1JCrbEdAPrdIWH455j2K1VcJ4DsnhW+f3jdWL3wKJ5RoIHDcp8jpAGtpfQXrorOU1pIO4enY2M3FJObHUiWEPZWrFcdA9yBH0VtJvVrjXZf3R6TZkkFwEYyHMKVlkpcRk8/MhM2BMq5BJn5A7fAcEB/PMtJDZc+bugf4z/PvnXeLPpndrf3KotOqmHbj+I0gl5eyktZWRUFc5wiLnVmOwws2kQEr91KZfPux5awt5kFHzR+u9ejZRovvsTNWDwEwoZazIvkyeHuL0GnsawQasNIbiGfqNEis9qBIBgyMNIfVOZZ3rlIZvsQ3dz+gQfDV2DokoHLEakxDSj3XFUxrJI65Ro87fb8SYU928xwznLZYQtC5fYJHCa4h3xeZZIxHEOyN+U36wbi2fQgetO7Gu4p47w4cV1T8qbr3tpObZ2AMOsZdQh22KFusLzPRSEidCQSUYYEVosKyELec2o53SiBxcLzXWl/CnjBDgh5an/N5dg+bqo7W7VZg1I/voHxgU/It6Ko4V6jVD5rQDMP1f/6FDN9+zsVW1iZWr2nvmS1KGFYJ7UI5+tFEIwb8W4nrmzhW9wJMMASlAoNc2JkqO/luP+lsF1H5noGp2QChoDQBoZs6Ioarmbr5S6prE0ROmzLbxVKbz1qwnl6XdnyfOWicgpbKMQ7IX25avo8LIG9XKoC5YTnkdpmey6Hp28PGpp5tIg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f12ddcb-ffed-4b2d-b0ae-08d7ea8b08ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 09:11:56.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRMo8rFEULDNhyKIt3XnDNdFeVVbMmSa/kXWBX9vcVvTeYSL4eDv2i7s8l166VyhZPSU+vxT+yJKRqZUVz2Tlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDA3LzEwXSBjbGs6IGlteDogYWRkIG11eCBvcHMgZm9y
IGkuTVg4TSBjb21wb3NpdGUNCj4gY2xrDQo+IA0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMiwgMjAyMCA2OjIwIFBNDQo+
ID4NCj4gPiBUaGUgQ09SRS9CVVMgcm9vdCBzbGljZSBoYXMgZm9sbG93aW5nIGRlc2lnbiwgc2lt
cGxpZWQgZ3JhcGg6DQo+ID4gVGhlIGRpZmZlcmVuY2UgaXMgY29yZSBub3QgaGF2ZSBwcmVfZGl2
IGJsb2NrLg0KPiA+IEEgY29tcG9zaXRlIGNvcmUvYnVzIGNsayBoYXMgOCBpbnB1dHMgZm9yIG11
eCB0byBzZWxlY3QsIHNheWluZyBjbGtbMC03XS4NCj4gPg0KPiA+ICAgICAgICAgICAgIFNFTF9B
ICBHQQ0KPiA+ICAgICAgICAgICAgICstLSsgICstKw0KPiA+ICAgICAgICAgICAgIHwgICstPisg
Ky0tLS0tLSsNCj4gPiBDTEtbMC03XS0tLT4rICB8ICArLSsgICAgICB8DQo+ID4gICAgICAgIHwg
ICAgfCAgfCAgICAgICstLS0tdi0tLSsgICAgKy0tLS0rDQo+ID4gICAgICAgIHwgICAgKy0tKyAg
ICAgIHxwcmVfZGl2YSstLS0tPiAgICB8ICArLS0tLS0tLS0tKw0KPiA+ICAgICAgICB8ICAgICAg
ICAgICAgICArLS0tLS0tLS0rICAgIHxtdXggKy0tK3Bvc3RfZGl2IHwNCj4gPiAgICAgICAgfCAg
ICArLS0rICAgICAgfHByZV9kaXZiKy0tLT4rICAgIHwgICstLS0tLS0tLS0rDQo+ID4gICAgICAg
IHwgICAgfCAgfCAgICAgICstLS0tXi0tLSsgICAgKy0tLS0rDQo+ID4gICAgICAgICstLS0+KyAg
fCAgKy0rICAgICAgfA0KPiA+ICAgICAgICAgICAgIHwgICstPisgKy0tLS0tLSsNCj4gPiAgICAg
ICAgICAgICArLS0rICArLSsNCj4gPiAgICAgICAgICAgICBTRUxfQiAgR0INCj4gPg0KPiA+IFRo
ZXJlIHdpbGwgYmUgc3lzdGVtIGhhbmcsIHdoZW4gZG9pbmcgdGhlIGZvbGxvd2luZyBzdGVwczoN
Cj4gPiAxLiBzd2l0Y2ggbXV4IGZyb20gY2xrMCB0byBjbGsxDQo+ID4gMi4gZ2F0ZSBvZmYgY2xr
MA0KPiA+IDMuIHN3dGljaCBmcm9tIGNsazEgdG8gY2xrMiwgb3IgZ2F0ZSBvZmYgY2xrMQ0KPiA+
DQo+ID4gU3RlcCAzIHRyaWdnZXJzIHN5c3RlbSBoYW5nLg0KPiANCj4gV2h5IFN0ZXAgMyB0cmln
Z2VycyBzeXN0ZW0gaGFuZz8gSXMgdGhpcyBhIEhXIGxpbWl0YXRpb24/DQoNCkl0IGlzIHdoYXQg
aGFyZHdhcmUgZGVzaWduZWQuDQoNClRoZXJlIGlzIGEgY291bnRlciBpbnNpZGUgdGhlIGNsayBy
b290IG1vZHVsZSB0byBjaG9vc2UNClNFTF9BIG9yIFNFTF9CLiBJZiBjaG9vc2UgU0VMX0IsIHRo
ZSBwYXJlbnQgb2YgU0VMX0IgbXVzdA0KYmUgYWN0aXZlLCBvdGhlcndpc2UgdGhlIGNoYW5nZSBm
cm9tIFNFTF9BIHRvIFNFTF9CDQp3aWxsIGNhdXNlIGhhbmcuDQoNClNFTF9BIGFuZCBTRUxfQiBp
cyBpbnNpZGUgdGhlIGNsb2NrIHJvb3QgbW9kdWxlLA0KSXQgaXMgbm90IGNsaydzIHNvZnR3YXJl
IHBhcmVudEEvQi4gbWlzdW5kZXJzdGFuZA0KdGhpcyB3aWxsIG1pc3VuZGVyc3RhbmQgdGhlIHdo
b2xlIGZpeC4NCg0KPiANCj4gPg0KPiA+IElmIHdlIHNraXAgc3RlcDIsIGtlZXAgY2xrMCBvbiwg
c3RlcCAzIHdpbGwgbm90IHRyaWdnZXIgc3lzdGVtIGhhbmcuDQo+ID4gSG93ZXZlciB3ZSBoYXZl
IENMS19PUFNfUEFSRU5UX0VOQUJMRSBmbGFnLCB3aGljaCB3aWxsIHVucHJlcGFyZQ0KPiA+IGRp
c2FibGUgdGhlIGNsazAgd2hpY2ggd2lsbCBub3QgYmUgdXNlZC4NCj4gPg0KPiA+IFRvIGFkZHJl
c3MgdGhpcyBpc3N1ZSwgd2UgY291bGQgdXNlIGZvbGxvd2luZyBzaW1wbGllZCBzb2Z0d2FyZSBm
bG93Og0KPiA+IEFmdGVyIHRoZSBmaXJzdCB0YXJnZXQgcmVnaXN0ZXIgc2V0DQo+ID4gd2FpdCB0
aGUgdGFyZ2V0IHJlZ2lzdGVyIHNldCBmaW5pc2hlZA0KPiA+IHNldCB0aGUgdGFyZ2V0IHJlZ2lz
dGVyIHNldCBhZ2Fpbg0KPiA+IHdhaXQgdGhlIHRhcmdldCByZWdpc3RlciBzZXQgZmluaXNoZWQN
Cj4gPg0KPiA+IFRoZSB1cHBlciBmbG93IHdpbGwgbWFrZSBzdXJlIFNFTF9BIGFuZCBTRUxfQiBi
b3RoIHNldCB0aGUgbmV3IG11eCwNCj4gPiBidXQgd2l0aCBvbmx5IG9uZSBwYXRoIGdhdGUgb24u
DQo+ID4NCj4gPiBBbmQgdGhlcmUgd2lsbCBiZSBubyBzeXN0ZW0gaGFuZyBhbnltb3JlIHdpdGgg
c3RlcDMuDQo+IA0KPiBJcyB0aGlzIElDIHByb3Bvc2VkIHNvbHV0aW9uPw0KDQpUaGlzIGlzIHdo
YXQgSSBwcm9wb3NlZCBhbmQgSUMgdGVhbSBjb25maXJtZWQuDQoNCj4gDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+
IFYyOg0KPiA+ICBEcm9wIHdhaXQgYWZ0ZXIgd3JpdGUsIGFkZCBvbmUgbGluZSBjb21tZW50IGZv
ciB3cml0ZSB0d2ljZS4NCj4gPg0KPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS04
bS5jIHwgNjINCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMNCj4gPiBi
L2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMNCj4gPiBpbmRleCA5OTc3MzUxOWI1
YTUuLmVhZTAyYzE1MWNlZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWNv
bXBvc2l0ZS04bS5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUtOG0u
Yw0KPiA+IEBAIC0yNCw2ICsyNCwxMiBAQA0KPiA+DQo+ID4gICNkZWZpbmUgUENHX0NHQ19TSElG
VAkJMjgNCj4gPg0KPiA+ICsjZGVmaW5lIFBSRV9SRUdfT0ZGCQkweDMwDQo+ID4gKyNkZWZpbmUg
UFJFX01VWEFfU0hJRlQJCTI0DQo+ID4gKyNkZWZpbmUgUFJFX01VWEFfTUFTSwkJMHg3DQo+ID4g
KyNkZWZpbmUgUFJFX01VWEJfU0hJRlQJCTgNCj4gPiArI2RlZmluZSBQUkVfTVVYQl9NQVNLCQkw
eDcNCj4gDQo+IEFyZSB0aG9zZSBtYWNyb3MgdXNlZCBzb21ld2hlcmU/DQoNClJlbW92ZSBpbiB2
My4NCg0KPiANCj4gPiArDQo+ID4gIHN0YXRpYyB1bnNpZ25lZCBsb25nIGlteDhtX2Nsa19jb21w
b3NpdGVfZGl2aWRlcl9yZWNhbGNfcmF0ZShzdHJ1Y3QNCj4gPiBjbGtfaHcgKmh3LA0KPiA+ICAJ
CQkJCQl1bnNpZ25lZCBsb25nIHBhcmVudF9yYXRlKQ0KPiA+ICB7DQo+ID4gQEAgLTEyNCw2ICsx
MzAsNTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzDQo+ID4gaW14OG1fY2xrX2NvbXBv
c2l0ZV9kaXZpZGVyX29wcyA9IHsNCj4gPiAgCS5zZXRfcmF0ZSA9IGlteDhtX2Nsa19jb21wb3Np
dGVfZGl2aWRlcl9zZXRfcmF0ZSwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgdTggaW14OG1f
Y2xrX2NvbXBvc2l0ZV9tdXhfZ2V0X3BhcmVudChzdHJ1Y3QgY2xrX2h3ICpodykgew0KPiA+ICsJ
c3RydWN0IGNsa19tdXggKm11eCA9IHRvX2Nsa19tdXgoaHcpOw0KPiA+ICsJdTMyIHZhbDsNCj4g
PiArDQo+ID4gKwl2YWwgPSByZWFkbChtdXgtPnJlZykgPj4gbXV4LT5zaGlmdDsNCj4gPiArCXZh
bCAmPSBtdXgtPm1hc2s7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNsa19tdXhfdmFsX3RvX2luZGV4
KGh3LCBtdXgtPnRhYmxlLCBtdXgtPmZsYWdzLCB2YWwpOyB9DQo+IA0KPiBZb3UgZG9uJ3QgaGF2
ZSB0byByZWRlZmluaXRpb24gdGhlbSBpZiB0aGV5J3JlIHRoZSBzYW1lIGFzIGNsa19tdXhfb3Bz
Lg0KPiBZb3UgaGF2ZSB0aGUgYWNjZXNzIHRvIGNsa19tdXhfb3BzLg0KDQpUaGlzIHdpbGwgcmVx
dWlyZSBleHBvcnRfc3ltYm9sIG9mIGNsa19tdXhfb3BzIGNhbGxiYWNrcy4NCg0KPiANCj4gPiAr
DQo+ID4gK3N0YXRpYyBpbnQgaW14OG1fY2xrX2NvbXBvc2l0ZV9tdXhfc2V0X3BhcmVudChzdHJ1
Y3QgY2xrX2h3ICpodywgdTgNCj4gPiAraW5kZXgpIHsNCj4gPiArCXN0cnVjdCBjbGtfbXV4ICpt
dXggPSB0b19jbGtfbXV4KGh3KTsNCj4gPiArCXUzMiB2YWwgPSBjbGtfbXV4X2luZGV4X3RvX3Zh
bChtdXgtPnRhYmxlLCBtdXgtPmZsYWdzLCBpbmRleCk7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGZs
YWdzID0gMDsNCj4gPiArCXUzMiByZWc7DQo+ID4gKw0KPiA+ICsJaWYgKG11eC0+bG9jaykNCj4g
PiArCQlzcGluX2xvY2tfaXJxc2F2ZShtdXgtPmxvY2ssIGZsYWdzKTsNCj4gPiArDQo+ID4gKwly
ZWcgPSByZWFkbChtdXgtPnJlZyk7DQo+ID4gKwlyZWcgJj0gfihtdXgtPm1hc2sgPDwgbXV4LT5z
aGlmdCk7DQo+ID4gKwl2YWwgPSB2YWwgPDwgbXV4LT5zaGlmdDsNCj4gPiArCXJlZyB8PSB2YWw7
DQo+ID4gKwkvKiB3cml0ZSB0d2ljZSB0byBtYWtlIHN1cmUgU0VMX0EvQiBwb2ludCB0aGUgc2Ft
ZSBtdXggKi8NCj4gPiArCXdyaXRlbChyZWcsIG11eC0+cmVnKTsNCj4gPiArCXdyaXRlbChyZWcs
IG11eC0+cmVnKTsNCj4gDQo+IFdoeSB0aGlzIGFmZmVjdHMgYm90aCBTRUxfQS9CPw0KDQpUaGUg
aW50ZXJuYWwgY291bnRlciB3aWxsIG1ha2Ugc3VyZSBib3RoIFNFTF9BL0IgcG9pbnQNCnRvIHRo
ZSBzYW1lIG11eC4NCg0KPiBWZXJ5IHRyaWNreSBhbmQgbWF5IHdvcnRoIG1vcmUgY29tbWVudHMu
DQoNCkFoLCBJIHRoaW5rIFJNIHNob3VsZCBiZSBjbGVhciBhYm91dCB0aGUgdGFyZ2V0IGludGVy
ZmFjZQ0KYW5kIG5vbi10YXJnZXQgaW50ZXJmYWNlLg0KDQpXaGVuIHlvdSB3cml0ZSBvbmNlLCBz
YXlpbmcgdXNlIFNFTF9BLCB3aGVuDQp5b3Ugd3JpdGUgdGhlIDJuZCwgdGhlIGhhcmR3YXJlIHdp
bGwgdXNlIFNFTF9CLA0Kd2hlbiB5b3Ugd3JpdGUgM3JkLCB0aGUgaGFyZHdhcmUgd2lsbCB1c2Ug
U0VMX0EuDQphbmQgLi4uDQoNCj4gDQo+IEJlc2lkZXMgdGhhdCwgSSdkIGxpa2UgdG8gc2VlIEFi
ZWwncyBjb21tZW50cyBvbiB0aGlzIHBhdGNoLg0KDQoNCkFiZWwsDQoNCiBBbnkgY29tbWVudHM/
DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMNCj4gQWlzaGVuZw0KPiANCj4gPiAr
DQo+ID4gKwlpZiAobXV4LT5sb2NrKQ0KPiA+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUobXV4
LT5sb2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbnQNCj4gPiAraW14OG1fY2xrX2NvbXBvc2l0ZV9tdXhfZGV0ZXJtaW5lX3Jh
dGUoc3RydWN0IGNsa19odyAqaHcsDQo+ID4gKwkJCQkgICAgICAgc3RydWN0IGNsa19yYXRlX3Jl
cXVlc3QgKnJlcSkgew0KPiA+ICsJc3RydWN0IGNsa19tdXggKm11eCA9IHRvX2Nsa19tdXgoaHcp
Ow0KPiA+ICsNCj4gPiArCXJldHVybiBjbGtfbXV4X2RldGVybWluZV9yYXRlX2ZsYWdzKGh3LCBy
ZXEsIG11eC0+ZmxhZ3MpOyB9DQo+IA0KPiBTYW1lIGFzIGJvdmUuDQo+IA0KPiA+ICsNCj4gPiAr
DQo+ID4gK2NvbnN0IHN0cnVjdCBjbGtfb3BzIGlteDhtX2Nsa19jb21wb3NpdGVfbXV4X29wcyA9
IHsNCj4gPiArCS5nZXRfcGFyZW50ID0gaW14OG1fY2xrX2NvbXBvc2l0ZV9tdXhfZ2V0X3BhcmVu
dCwNCj4gPiArCS5zZXRfcGFyZW50ID0gaW14OG1fY2xrX2NvbXBvc2l0ZV9tdXhfc2V0X3BhcmVu
dCwNCj4gPiArCS5kZXRlcm1pbmVfcmF0ZSA9IGlteDhtX2Nsa19jb21wb3NpdGVfbXV4X2RldGVy
bWluZV9yYXRlLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RydWN0IGNsa19odyAqaW14OG1fY2xr
X2h3X2NvbXBvc2l0ZV9mbGFncyhjb25zdCBjaGFyICpuYW1lLA0KPiA+ICAJCQkJCWNvbnN0IGNo
YXIgKiBjb25zdCAqcGFyZW50X25hbWVzLA0KPiA+ICAJCQkJCWludCBudW1fcGFyZW50cywgdm9p
ZCBfX2lvbWVtICpyZWcsIEBAIC0xMzYsNg0KPiA+ICsxOTMsNyBAQCBzdHJ1Y3QgY2xrX2h3ICpp
bXg4bV9jbGtfaHdfY29tcG9zaXRlX2ZsYWdzKGNvbnN0IGNoYXINCj4gPiArKm5hbWUsDQo+ID4g
IAlzdHJ1Y3QgY2xrX2dhdGUgKmdhdGUgPSBOVUxMOw0KPiA+ICAJc3RydWN0IGNsa19tdXggKm11
eCA9IE5VTEw7DQo+ID4gIAljb25zdCBzdHJ1Y3QgY2xrX29wcyAqZGl2aWRlcl9vcHM7DQo+ID4g
Kwljb25zdCBzdHJ1Y3QgY2xrX29wcyAqbXV4X29wczsNCj4gPg0KPiA+ICAJbXV4ID0ga3phbGxv
YyhzaXplb2YoKm11eCksIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFtdXgpDQo+ID4gQEAgLTE1
NywxMCArMjE1LDEyIEBAIHN0cnVjdCBjbGtfaHcNCj4gPiAqaW14OG1fY2xrX2h3X2NvbXBvc2l0
ZV9mbGFncyhjb25zdCBjaGFyICpuYW1lLA0KPiA+ICAJCWRpdi0+c2hpZnQgPSBQQ0dfRElWX1NI
SUZUOw0KPiA+ICAJCWRpdi0+d2lkdGggPSBQQ0dfQ09SRV9ESVZfV0lEVEg7DQo+ID4gIAkJZGl2
aWRlcl9vcHMgPSAmY2xrX2RpdmlkZXJfb3BzOw0KPiA+ICsJCW11eF9vcHMgPSAmaW14OG1fY2xr
X2NvbXBvc2l0ZV9tdXhfb3BzOw0KPiA+ICAJfSBlbHNlIHsNCj4gPiAgCQlkaXYtPnNoaWZ0ID0g
UENHX1BSRURJVl9TSElGVDsNCj4gPiAgCQlkaXYtPndpZHRoID0gUENHX1BSRURJVl9XSURUSDsN
Cj4gPiAgCQlkaXZpZGVyX29wcyA9ICZpbXg4bV9jbGtfY29tcG9zaXRlX2RpdmlkZXJfb3BzOw0K
PiA+ICsJCW11eF9vcHMgPSAmY2xrX211eF9vcHM7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCWRpdi0+
bG9jayA9ICZpbXhfY2NtX2xvY2s7DQo+ID4gQEAgLTE3Niw3ICsyMzYsNyBAQCBzdHJ1Y3QgY2xr
X2h3DQo+ICppbXg4bV9jbGtfaHdfY29tcG9zaXRlX2ZsYWdzKGNvbnN0DQo+ID4gY2hhciAqbmFt
ZSwNCj4gPiAgCWdhdGUtPmxvY2sgPSAmaW14X2NjbV9sb2NrOw0KPiA+DQo+ID4gIAlodyA9IGNs
a19od19yZWdpc3Rlcl9jb21wb3NpdGUoTlVMTCwgbmFtZSwgcGFyZW50X25hbWVzLA0KPiA+IG51
bV9wYXJlbnRzLA0KPiA+IC0JCQltdXhfaHcsICZjbGtfbXV4X29wcywgZGl2X2h3LA0KPiA+ICsJ
CQltdXhfaHcsIG11eF9vcHMsIGRpdl9odywNCj4gPiAgCQkJZGl2aWRlcl9vcHMsIGdhdGVfaHcs
ICZjbGtfZ2F0ZV9vcHMsIGZsYWdzKTsNCj4gPiAgCWlmIChJU19FUlIoaHcpKQ0KPiA+ICAJCWdv
dG8gZmFpbDsNCj4gPiAtLQ0KPiA+IDIuMTYuNA0KDQo=
