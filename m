Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01373C55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD62E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nWziVz/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgDWKmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:42:36 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:50309
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgDWKmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:42:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXo4YLKPeGfFJr5+1FgFPYH86Gju6Hu6kCqJSsO6Ce1QmWNcWvmW/Mt2AERwcWSuileEEMbtdQOaZ2m4kyN2TlqCoAqHVk6C3pf8jyjzucN2IGzJwdv3qC4irAWy3YYB6MnV/c/2S3HG4ObeVUh6xTASuF8nTAGuo7FxqNvwuFz43SvZM8L1gbUezT3c2RKZP4lKKUQow3pPLV8eP66JBXRLIPeNd1bC7/zPoMuWoS1DpQdZwEBUjecGkcbYhgUHpmSCgIHDenJw412UkYMoxHTD8s4BjnK8jTVbktXMGHgq6azdEfGC/fDkSnGsz83am1RC3OkkwHjSV2g0+t0mZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5S21MaP3Lpc/fmPv0Nb2sehkH8vi3AVTcoOXttnE8s=;
 b=F4gFso+3FD9Ad2saHIrgp9t3tHYgNRRS1F3IbM2bsNegTNZk6m4YF+cyNDWM5r7RnQbfITPXR//dgqVxe79cG2096xlA5R3AlzotQYipPXMFTfI+vIM8g0ig7MFP+qepoWzqjN7iUAIlRZgTeK7siVTbeKGCcLVP2AkBupSMQTJgAKgO3P6hLPYB2y/K30TYN/w9ZcNBIr5BXyjzgRoNYsy+nalmR4bNJIZiIq5RD6O82yt/T6nVp2cXZBf/5QC54slfkGwgtArUTQ9PDFAm13xKt6hn5F3A+OAHOvuBsbPUkkfJk2oHIrYYaq+Q2rlyv+oG36Yyj+2anFFy1Nbu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5S21MaP3Lpc/fmPv0Nb2sehkH8vi3AVTcoOXttnE8s=;
 b=nWziVz/B3pF5QkP+Rn/bx6HDt5dLhzVEK4nQHbVEbEXZT5GPpkdICMPIZpskya/fqNLjjwryl8MmGOeFzm8DiQ+4vv1hvpQpgYgSQ5teZhOhtMgySAM38WYKGRy8swfCtIl4XSdf7KTGmEEt3mJZk5VKavk6QuCekuic4kdN+ZM=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4440.eurprd04.prod.outlook.com (2603:10a6:20b:21::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 10:42:31 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 10:42:31 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Thread-Index: AQHWGTz23ipTFSUpC02goIyCROLLPKiGhOhw
Date:   Thu, 23 Apr 2020 10:42:31 +0000
Message-ID: <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8132c7a-64cd-497a-68d4-08d7e77306d2
x-ms-traffictypediagnostic: AM6PR04MB4440:|AM6PR04MB4440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB444049FDCE874A3E294391D480D30@AM6PR04MB4440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(186003)(9686003)(71200400001)(5660300002)(66446008)(66556008)(7696005)(52536014)(6506007)(2906002)(76116006)(26005)(110136005)(478600001)(66476007)(54906003)(316002)(66946007)(64756008)(8936002)(8676002)(55016002)(44832011)(33656002)(81156014)(4326008)(86362001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ss1yDeaT2mRe95kWnZYTwPARm5tEQYdnCS9Vq6cl4KAq+OhTI2JwjI4eIfU1jcPQMMM/bp5Sn50XEYyaV3iVBri0u0/JvBm3LubU4d5XS5ugaTdSUH9EInX/7AU/QUTF05JQmYuVAo0DFAtXPAgC0Rql7GQq6/2RhzX6FTK1Yz/tUIYlMB4fk5neQcnpwa1IwldynrsFRaGarF8ieMQkRuFJH7Xv2zPr5T95lPXDBdoQN3KYYlPG4o8x1K9NZIEK8ogR5TX0Rig3MFgx2zQRe1ouA05LWh+zWi6V9HjuOc/8ZQClbugu+HQCvzF/YVlUaqdEQsiEGg0J3VpMmnKPVmq5Mo1y0ZF+W+gde2EJeDsmjROeROzPNl+WDFCBxDQMlDcoZoujnDDcHMPrb6BqFS7suKWdSxM8az68IJjpdidn535eiGZcjoEA5DM/qXYa
x-ms-exchange-antispam-messagedata: F4f4CUmC0mKc2rWzRtsJKu+aDw9k6xLtFSIcrtLai2Y+IZpBt1h8fGUVD60NhA0geI9zHNCpQyfVs7+zxXTDEMpR5ykVuKI4rq8YXl8xOVXg3/PdNCxzC5KXSLym76tIOYkz5zqWDe6SaxrV3n+n0w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8132c7a-64cd-497a-68d4-08d7e77306d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:42:31.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6K76xQp/BjP37cgqF7TKuiS5KcHPFkeTJsUqtF4Cgi3qNl0z2BGH199f3aQZYPyVhzYmMsP+nitEoD/EUZkSOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDI6NTIgUE0NCj4gDQo+IFRvIGkuTVg4TSBTb0MsIHRoZXJlIGlzIGFuIGNh
c2UgaXMgd2hlbiBydW5uaW5nIGR1YWwgT1NlcyB3aXRoIGh5cGVydmlzb3IsIHRoZQ0KPiBjbGsg
b2YgdGhlIGhhcmR3YXJlIHRoYXQgcGFzc3Rocm91Z2ggdG8gdGhlIDJuZCBPUyBuZWVkcyB0byBi
ZSBzZXR1cCBieSAxc3QNCj4gTGludXggT1MuDQo+IFNvIGRldGVjdCBjbG9jay1jcml0aWNhbCBm
cm9tIGNjbSBub2RlIGFuZCBlbmFibGUgdGhlIGNsb2NrcyB0byBsZXQgdGhlIDJuZCBPUw0KPiBj
b3VsZCB1c2UgdGhlIGhhcmR3YXJlIHdpdGhvdXQgdG91Y2ggQ0NNIG1vZHVsZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvY2xrL2lteC9jbGsuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysgIGRyaXZlcnMvY2xrL2lt
eC9jbGsuaCB8ICAxDQo+ICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGsuYyBiL2RyaXZlcnMvY2xrL2lt
eC9jbGsuYyBpbmRleA0KPiA4N2FiOGRiM2QyODIuLmVjN2Q0MjI1NDBjMSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9jbGsvaW14L2Nsay5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuYw0K
PiBAQCAtMTc3LDMgKzE3NywyMiBAQCBzdGF0aWMgaW50IF9faW5pdCBpbXhfY2xrX2Rpc2FibGVf
dWFydCh2b2lkKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgbGF0ZV9pbml0Y2FsbF9zeW5jKGlt
eF9jbGtfZGlzYWJsZV91YXJ0KTsNCj4gKw0KPiAraW50IGlteF9jbGtfaHdfY3JpdGljYWwoc3Ry
dWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0IGNsa19odyAqIGNvbnN0DQo+ICtod3NbXSkgew0K
PiArCXN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsNCj4gKwljb25zdCBfX2JlMzIgKmN1cjsNCj4gKwl1
MzIgaWR4Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlpZiAoIW5wIHx8ICFod3MpDQo+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiArDQo+ICsJb2ZfcHJvcGVydHlfZm9yX2VhY2hfdTMyKG5wLCAiY2xv
Y2stY3JpdGljYWwiLCBwcm9wLCBjdXIsIGlkeCkgew0KDQpJcyB0aGVyZSBhIGJpbmRpbmcgZm9y
IGl0IGFscmVhZHk/DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiArCQlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoaHdzW2lkeF0tPmNsayk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0
Ow0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbGsvaW14L2Nsay5oIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oIGluZGV4DQo+IGQ0ZWExNjA5
YmNiNy4uNzAxZDc0NDBmOThjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmgN
Cj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+IEBAIC05LDYgKzksNyBAQCBleHRlcm4g
c3BpbmxvY2tfdCBpbXhfY2NtX2xvY2s7DQo+IA0KPiAgdm9pZCBpbXhfY2hlY2tfY2xvY2tzKHN0
cnVjdCBjbGsgKmNsa3NbXSwgdW5zaWduZWQgaW50IGNvdW50KTsgIHZvaWQNCj4gaW14X2NoZWNr
X2Nsa19od3Moc3RydWN0IGNsa19odyAqY2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQpOw0KPiAr
aW50IGlteF9jbGtfaHdfY3JpdGljYWwoc3RydWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0IGNs
a19odyAqIGNvbnN0DQo+ICtod3NbXSk7DQo+ICB2b2lkIGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2Nr
cyhzdHJ1Y3QgY2xrICoqIGNvbnN0IGNsa3NbXSk7ICB2b2lkDQo+IGlteF9tbWRjX21hc2tfaGFu
ZHNoYWtlKHZvaWQgX19pb21lbSAqY2NtX2Jhc2UsIHVuc2lnbmVkIGludCBjaG4pOw0KPiB2b2lk
IGlteF91bnJlZ2lzdGVyX2Nsb2NrcyhzdHJ1Y3QgY2xrICpjbGtzW10sIHVuc2lnbmVkIGludCBj
b3VudCk7DQo+IC0tDQo+IDIuMTYuNA0KDQo=
