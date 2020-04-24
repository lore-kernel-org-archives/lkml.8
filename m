Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDDC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD7220715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P74hXmJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDXCDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:03:04 -0400
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:48939
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgDXCDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijtievauOvxcnuQwXBFy9wbLd/JphvjYCAZr0F3LE62igbKy0DzsXLrZOwgnmTe1nx8j9uonB9KGWTit+gp16m13PfHkcgAwX0b+5zlc7/bZClc0qnMuVTWIxhkWBJNYlCRrI+5aZi1X4FS1+N35/aXHx7hWxj987jYKQ0k5/qs+SgFFBdbWj6hHD+5EBgg2Sh1G0Vet7J4xAr+pgRt/8qOCkZ+lVF8H36LooxGRP+Ax02jJG9+XkCByqQ5pX9/9OtccXA6NWQ1KHOvikTZGwFFsAB8aR/NNXIJNAyQJpytBuURdkTL3ydehZ477rF+x3JdekWfHBjyvEDPWR7BZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU0F6DxwJwUelxvKSOGGK0X2m6M1kIMQVmuznKFUQrI=;
 b=KaTIM/Yq/njlRV2hXJIv7kH4yFybktCUayJoDzOm3ontrw9gv/rE+nFkicMxTlAxVD6meSXPqI3j4Dtm6MRXMp4DGaBb4eWBfFqh8/xLY/gwHLo9Ud1gbm/iSfsDVAchh8764bEdhHCFZt2RaNQ3YSqIaMqoMEsgLIOX5XAVV2OvwATT4K0mMZqDx/jIfnUcqEwfUWUz53SuEkzVFWIfZg96nefJho4z4oKZ9MHMqE4FdhyS06V9hge1r+YjReg0V1+0VDXkF2S212EkRMojl0ju6bh7pTBhsIvt72RBNHqwgemqF2iV0prU8y/tCA96urPJR7LyyzyaKEHrhY7D/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU0F6DxwJwUelxvKSOGGK0X2m6M1kIMQVmuznKFUQrI=;
 b=P74hXmJioolUkuPHSGAdkb8hvMjvUqQaFaexC6jRwdNsBM9EZoUpE/qGLLG2HEUgxFxJVujjveLQ1BPeD6bvOr0kLi198MR9ryvfuQY+XeQddVDq30dj+iP4eZapAAillEOu4AwtZjrRbFdb5jY2Inlj4mw1yh+VAGiaiXdSw64=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2824.eurprd04.prod.outlook.com (2603:10a6:4:98::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 02:02:57 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 02:02:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Topic: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Index: AQHWGTz1S3ryZr4eI06QzGNLele1k6iGhU2AgAACxjCAADVJgIAAt/hggAAQDACAAACyUA==
Date:   Fri, 24 Apr 2020 02:02:57 +0000
Message-ID: <DB6PR0402MB27606091A98872EB60A5BA5788D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760793865AA2E67E1C33F4488D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <AM6PR04MB4966460FE849E557FDA754F980D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276068E21E36BFCCA91728D088D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <AM6PR04MB49665A599A06623160EB592980D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49665A599A06623160EB592980D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e47ca25-6ad7-447f-378a-08d7e7f39bf7
x-ms-traffictypediagnostic: DB6PR0402MB2824:|DB6PR0402MB2824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2824C27AEB9C832BE80FFDBD88D00@DB6PR0402MB2824.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(66446008)(186003)(86362001)(9686003)(8676002)(478600001)(5660300002)(81156014)(316002)(54906003)(8936002)(2906002)(966005)(110136005)(66556008)(66476007)(55016002)(64756008)(71200400001)(52536014)(33656002)(76116006)(7696005)(6506007)(4326008)(44832011)(66946007)(26005)(53546011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2yjsTzy9j6HE0Ncu985wcD/FNnc7HY6vrLGg42r82nE58VxlkNIuRceMaZsZSnHK6QFUpTgF4nb0Dd6zEdGtCU1HzD3MQespLrvG8kYtXRhXwaox4LZWeLl08wEav10v+R1l1tMCG5WQRwj9mvzRzxA1J/09r7fSvqoJJqTyU11AgCmGaRxo87e9KwIlqivFQuhl48oxUJQ3Wvy0U0NwRd5GSk059NkjXGrYkZhUmbGvzvhdDTvVPIBUMpLoUtm546sYqUZ2+M99ieeBdxDjT8GWJJyTosqt5HcPE+fZjdVvJebnef83FM90BIPsX6F7xJj6Q6oQxGFJZsjGE2LA5bw+HwYfRJJGcz8CKcAxhXz+gvPNqQhjw/F9C5qjlV1QSWSLV5BvAUzwDq/exrOY+ejM3UhLkMW7EoyEVp3IjDm8wK0laQWeboYySYVIqAzP7F1CK24nCSQPYB6NLcT33YDarvRKm9nEi1GbLWxkUhXsiOYrKQdOXbsDkMaNcUH2djI0mpshduxX7WcCw5Ojw==
x-ms-exchange-antispam-messagedata: 9jizYNVdLrGWvZlxJ4d00CHS9MUel44COBSxTOXIhQ+3EdEMzbYZe31UsvMorHUEinEidv12BWY5wAv3d0Mcnqm3CU3srHx8MTfsQteHKd+hRP1cuBMhlBzpE+3ry2u4D8Bp5q9GCrAppfR1JKu0/Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e47ca25-6ad7-447f-378a-08d7e7f39bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:02:57.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGMuqZh9o2ODSGLtXPEoG10KLrdp0WXNgt91kUp47f8QYszdSmA73i9nXK8HWAKOl/TE/D5vkyXwvI+xJIP/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBjbGs6IGlteDogaW50cm9kdWNlIGlteF9jbGtfaHdfY3Jp
dGljYWwNCj4gDQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gU2Vu
dDogRnJpZGF5LCBBcHJpbCAyNCwgMjAyMCA5OjA4IEFNDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJF
OiBbUEFUQ0hdIGNsazogaW14OiBpbnRyb2R1Y2UgaW14X2Nsa19od19jcml0aWNhbA0KPiA+ID4N
Cj4gPiA+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiA+IFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAyMywgMjAyMCA2OjU0IFBNDQo+ID4gPiA+DQo+ID4gPiA+ID4gU3Vi
amVjdDogUkU6IFtQQVRDSF0gY2xrOiBpbXg6IGludHJvZHVjZSBpbXhfY2xrX2h3X2NyaXRpY2Fs
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
Pg0KPiA+ID4gPiA+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDI6NTIgUE0NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUbyBpLk1YOE0gU29DLCB0aGVyZSBpcyBhbiBjYXNlIGlz
IHdoZW4gcnVubmluZyBkdWFsIE9TZXMgd2l0aA0KPiA+ID4gPiA+ID4gaHlwZXJ2aXNvciwgdGhl
IGNsayBvZiB0aGUgaGFyZHdhcmUgdGhhdCBwYXNzdGhyb3VnaCB0byB0aGUNCj4gPiA+ID4gPiA+
IDJuZCBPUyBuZWVkcyB0byBiZSBzZXR1cCBieSAxc3QgTGludXggT1MuDQo+ID4gPiA+ID4gPiBT
byBkZXRlY3QgY2xvY2stY3JpdGljYWwgZnJvbSBjY20gbm9kZSBhbmQgZW5hYmxlIHRoZSBjbG9j
a3MNCj4gPiA+ID4gPiA+IHRvIGxldCB0aGUgMm5kIE9TIGNvdWxkIHVzZSB0aGUgaGFyZHdhcmUg
d2l0aG91dCB0b3VjaCBDQ00NCj4gbW9kdWxlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay5jIHwgMTkgKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiA+ID4gZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+ID4gPiA+ID4gPiB8ICAx
DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2lteC9jbGsuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuYw0KPiA+ID4gPiA+ID4gaW5kZXgNCj4g
PiA+ID4gPiA+IDg3YWI4ZGIzZDI4Mi4uZWM3ZDQyMjU0MGMxIDEwMDY0NA0KPiA+ID4gPiA+ID4g
LS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2Ns
ay9pbXgvY2xrLmMNCj4gPiA+ID4gPiA+IEBAIC0xNzcsMyArMTc3LDIyIEBAIHN0YXRpYyBpbnQg
X19pbml0IGlteF9jbGtfZGlzYWJsZV91YXJ0KHZvaWQpDQo+ID4gPiA+ID4gPiAgCXJldHVybiAw
Ow0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ICBsYXRlX2luaXRjYWxsX3N5bmMoaW14X2Ns
a19kaXNhYmxlX3VhcnQpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK2ludCBpbXhfY2xr
X2h3X2NyaXRpY2FsKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHN0cnVjdCBjbGtfaHcNCj4gPiA+
ID4gPiA+ICsqIGNvbnN0DQo+ID4gPiA+ID4gPiAraHdzW10pIHsNCj4gPiA+ID4gPiA+ICsJc3Ry
dWN0IHByb3BlcnR5ICpwcm9wOw0KPiA+ID4gPiA+ID4gKwljb25zdCBfX2JlMzIgKmN1cjsNCj4g
PiA+ID4gPiA+ICsJdTMyIGlkeDsNCj4gPiA+ID4gPiA+ICsJaW50IHJldDsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJaWYgKCFucCB8fCAhaHdzKQ0KPiA+ID4gPiA+ID4gKwkJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCW9mX3Byb3BlcnR5X2Zvcl9l
YWNoX3UzMihucCwgImNsb2NrLWNyaXRpY2FsIiwgcHJvcCwgY3VyLA0KPiA+ID4gPiA+ID4gK2lk
eCkgew0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXMgdGhlcmUgYSBiaW5kaW5nIGZvciBpdCBhbHJl
YWR5Pw0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIGNsb2NrLWNyaXRpY2FsIGlzIGEgY29tbW9u
IGJpbmRpbmdzPyBTZWUgb2ZfY2xrX2RldGVjdF9jcml0aWNhbC4NCj4gPiA+ID4gUGxlYXNlIHJl
dmlldyB3aGV0aGVyIHRoaXMgYXBwcm9hY2ggaXMgYWNjZXB0YWJsZSwgaWYgZG8gbmVlZA0KPiA+
ID4gPiBiaW5kaW5ncywgSSBjb3VsZCBhZGQgdGhhdCBpbiB2Mi4NCj4gPiA+ID4NCj4gPiA+DQo+
ID4gPiBJJ20gb2sgaWYgaXQncyBhIGNvbW1vbiBiaW5kaW5nIGFscmVhZHkgc3VwcG9ydGVkIGJ5
IGN1cnJlbnQgY2xrDQo+IGZyYW1ld29yay4NCj4gPiA+IEJ1dCBpdCBzZWVtcyB0byBiZSBtb3Jl
IGxpa2UgYSBjb21tb24gY2xrIGZlYXR1cmUgcmF0aGVyIHRoYW4NCj4gPiA+IHBsYXRmb3JtIGZl
YXR1cmUuDQo+ID4NCj4gPiBIZXJlIGlzIHRvIHVzZSBpdCBmb3IgZHVhbCBMaW51eCBjYXNlIHJ1
bm5pbmcgb24gaS5NWCBwbGFmb3Jtcy4NCj4gPiBJdCBpcyB0byByZXBsYWNlIHRoZSBpbml0LW9u
LWFycmF5IHByb3BlcnR5IGluIGRvd25zdHJlYW0ga2VybmVsLg0KPiA+DQo+ID4gVGhlIHJlY29t
bWVuZGVkIGNyaXRpY2FsIGNsb2NrIGlzIHVzaW5nIENMS19JU19DUklUSUNBTCBmbGFnIGluIGNs
aw0KPiA+IGRyaXZlciwgbm90IHVzZSBjbG9jay1jcml0aWNhbCBwcm9wZXJ0eS4NCj4gPg0KPiAN
Cj4gQ2xvY2stY3JpdGljYWwgcHJvcGVydHkgc2VlbXMgRFQgdXNhZ2Ugb2YgQ0xLX0lTX0NSSVRJ
Q0FMIGZsYWcgYW5kIHB1cmUNCj4gcGxhdGZvcm0gaW5kZXBlbmRlbnQuDQo+IFNvIEkgd29uZGVy
IGlmIHRoaXMgZmVhdHVyZSBjb3VsZCBiZSBhZGRlZCBpbnRvIG9mX2Nsa19hZGRfaHdfcHJvdmlk
ZXIuDQo+IA0KPiA+IEJ1dCBoZXJlLCB3ZSBjb3VsZCBub3QgdXNlIENMS19JU19DUklUSUNBTCwg
YmVjYXVzZSB3aGVuIHN1cHBvcnQgZHVhbA0KPiA+IE9TZXMsIGl0IGlzIG5vdCBmbGV4aWJsZSwg
YW5kIGl0IHdpbGwgYWZmZWN0IG5vbiBoeXBlcnZpc29yIGNhc2UuDQo+ID4NCj4gDQo+IEEgYml0
IGNvbmZ1aW5nIGJlY2F1c2UgeW91IHNhaWQgdGhlIGNyaXRpY2FsLWNsb2NrIHByb3BlcnR5IHdp
bGwgb25seSBiZSB1c2VkIGJ5DQo+IEh5cGVydmlzb3IgZHRzLCB0aGVuIGhvdyB0byBhZmZlY3Qg
bm9uIGh5cGVydmlzb3IgY2FzZXM/DQoNCklmIHB1dCB0aGUgYXJyYXkgaW50byBoeXBlcnZpc29y
IGR0cywgaXQgd2lsbCBub3QgYWZmZWN0IG5vbiBoeXBlcnZpc29yIGNhc2UuDQoNCkkgbWVhbiBp
ZiB1c2luZyBDTEtfSVNfQ1JJVElDQUwgaW4gZHJpdmVyIGNvZGUsIGl0IHdpbGwgYWZmZWN0IG5v
biBoeXBlcnZpc29yIGNhc2UuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+ID4gPiBBbHNvIGEg
Yml0IHN0cmFuZ2UgdGhhdCB3aHkgSSBkaWQgbm90IGZpbmQgdGhlIGJpbmRpbmcgZG9jIGluIGxh
dGVzdCBrZXJuZWwuDQo+ID4gPiBNYXliZSBTdGVwaGVuIGNvdWxkIGNvbW1lbnQgbW9yZS4NCj4g
Pg0KPiA+IEl0IGlzIHVzZWQgaGVyZS4NCj4gPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92NS43LXJjMi9zb3VyY2UvZHJpdmVycy9jbGsvY2xrLmMjTDQ4DQo+ID4gOTENCj4gDQo+
IFllcywgSSBhbHNvIHNhdyBpdCwgYnV0IGRpZG4ndCBmaW5kIGJpbmRpbmcgZG9jLg0KPiANCj4g
UmVnYXJkcw0KPiBBaXNoZW5nDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gQlRXLCBpZiB1c2luZyB0
aGlzIGZvciBkdWFsIE9TZXMgY2FzZSwgd2lsbCB0aG9zZSBjcml0aWNhbCBjbG9ja3MNCj4gPiA+
IGFmZmVjdCB0aGUgbm9ybWFsIHVzZXJzIHRoYXQgbm90IGJvb3RpbmcgdGhlIHNlY29uZCBPUz8N
Cj4gPg0KPiA+IE5vLiBkdWFsIG9zIHVzaW5nIHgtcm9vdC5kdHMsIG5vdCB4LmR0cy4gY3JpdGlj
YWwtY2xvY2sgd2lsbCBiZSBwdXNoIGluDQo+IHgtcm9vdC5kdHMuDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4gUGVuZy4NCj4gPg0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMNCj4gPiA+IEFpc2hlbmcNCj4g
PiA+DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gUGVuZy4NCj4gPiA+ID4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IFJlZ2FyZHMNCj4gPiA+ID4gPiBBaXNoZW5nDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ICsJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShod3NbaWR4XS0+Y2xrKTsNCj4gPiA+ID4g
PiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ID4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiA+ID4gPiA+
ICsJfQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ID4gPiA+
ICt9DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay5oIGIvZHJp
dmVycy9jbGsvaW14L2Nsay5oDQo+ID4gPiA+ID4gPiBpbmRleCBkNGVhMTYwOWJjYjcuLjcwMWQ3
NDQwZjk4YyAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0K
PiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+ID4gPiA+ID4gPiBAQCAt
OSw2ICs5LDcgQEAgZXh0ZXJuIHNwaW5sb2NrX3QgaW14X2NjbV9sb2NrOw0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ICB2b2lkIGlteF9jaGVja19jbG9ja3Moc3RydWN0IGNsayAqY2xrc1tdLCB1
bnNpZ25lZCBpbnQNCj4gPiA+ID4gPiA+IGNvdW50KTsgdm9pZCBpbXhfY2hlY2tfY2xrX2h3cyhz
dHJ1Y3QgY2xrX2h3ICpjbGtzW10sIHVuc2lnbmVkDQo+ID4gPiA+ID4gPiBpbnQgY291bnQpOw0K
PiA+ID4gPiA+ID4gK2ludCBpbXhfY2xrX2h3X2NyaXRpY2FsKHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bnAsIHN0cnVjdCBjbGtfaHcNCj4gPiA+ID4gPiA+ICsqIGNvbnN0IGh3c1tdKTsNCj4gPiA+ID4g
PiA+ICB2b2lkIGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2NrcyhzdHJ1Y3QgY2xrICoqIGNvbnN0IGNs
a3NbXSk7DQo+ID4gPiA+ID4gPiB2b2lkIGlteF9tbWRjX21hc2tfaGFuZHNoYWtlKHZvaWQgX19p
b21lbSAqY2NtX2Jhc2UsDQo+IHVuc2lnbmVkDQo+ID4gPiA+ID4gPiBpbnQNCj4gPiA+IGNobik7
DQo+ID4gPiA+ID4gPiB2b2lkIGlteF91bnJlZ2lzdGVyX2Nsb2NrcyhzdHJ1Y3QgY2xrICpjbGtz
W10sIHVuc2lnbmVkIGludA0KPiA+ID4gPiA+ID4gY291bnQpOw0KPiA+ID4gPiA+ID4gLS0NCj4g
PiA+ID4gPiA+IDIuMTYuNA0KDQo=
