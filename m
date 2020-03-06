Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC7BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EB02072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="hyVH1LjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFJ5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:57:20 -0500
Received: from mail-eopbgr140120.outbound.protection.outlook.com ([40.107.14.120]:32768
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgCFJ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:57:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbQkqNOdvz4K+3FEboL2aV3HqldoduzQpXjsJ6e9eEvLiqBBdFhJS4pTRzs0y6cO2h3sN+mwx8Q1+it0wdWrWKHyiE+e74K2LXDuxb2ZSk+Urza6bXtvFS0Zrm1byeSWij6ZSRetQSTGuzETPuzJQwPkza/v4gTxBnTQUsXDv0cgNZ90wmKwt8fTqkpNAejzSSYrV1TR3hdxBNLsT69Ao20M4WhhkNDaoJwVQHKiEXu+X2RtOh2h4N++WHUxoDHjfgjK7SU2pAd1gDWA5cE9DIrJ/bohSjGcrqfGYQ7sR+AbDWY+h52Yw9jKGv+A3Ya02T7mPELK5aW8J6H+GhrRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e52YPFKisGKwNXZh2mdc4gwk2qFdgy5+uqMkDqH6s9c=;
 b=f6O2Xc3YdgcYC/u4gB00BzlgzzBXXGeq9a0Z5yqaQl3sMhPq/+TvupadPwsCSJy9pGJzhMM6pm4L1flTVF28s/UbKKexA59svgOB1xT5v97dZx73nlfm/YbpSM07CYb7wJjblegg4TNc9KSIhmB8LhkGhQPQ3H7wY6tbH15NMOuEnU2k9AmxhYa/Y1It6+HbnjK85B4IFCtrS5OfHdAnJ149dxb1iMLNVfA4K+amYrW9HvceCu+WXOPlk8DP8GpjvGCnARkqNuzv3QCVudjtjL/tN8tMI0Hb13sSQoMbuC09UpaBM/yg3azLxbtuTlVfyqnvKK6OwFypsFiT1qIswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e52YPFKisGKwNXZh2mdc4gwk2qFdgy5+uqMkDqH6s9c=;
 b=hyVH1LjR56tXcdiWXIPlR9FPLrxO/vVVRjOecfi7f380CynqU9wa+HNp75Q+hiMDQ5x0bxrcj9bU+kTL1eyBb15j5oCnqMNFAo8le3eW65IqyPXILrkup9w6Cl5JsUPVuJgV/HCOJ9X9bLr9ZINumZLWMQviR1NJOPX5N5NQIes=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (20.179.1.217) by
 AM6PR05MB6405.eurprd05.prod.outlook.com (20.179.7.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 6 Mar 2020 09:57:15 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e%4]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 09:57:15 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Topic: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Index: AQHV8vTsfP1BktnxKEy+q0EhrXMNZqg6BRAAgAFQPwA=
Date:   Fri, 6 Mar 2020 09:57:15 +0000
Message-ID: <98f5901a121b83d4f7d75f9a9056bd3719e2ee89.camel@toradex.com>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
         <20200305135346.GD25745@shell.armlinux.org.uk>
In-Reply-To: <20200305135346.GD25745@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eb6224b-8deb-4f74-fff4-08d7c1b4bfd9
x-ms-traffictypediagnostic: AM6PR05MB6405:
x-microsoft-antispam-prvs: <AM6PR05MB6405AE487710F9781B20B361F4E30@AM6PR05MB6405.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(2906002)(54906003)(6506007)(86362001)(7416002)(66476007)(4326008)(44832011)(66446008)(66556008)(64756008)(5660300002)(71200400001)(26005)(36756003)(6512007)(76116006)(91956017)(66946007)(8676002)(6486002)(186003)(8936002)(81156014)(2616005)(6916009)(498600001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB6405;H:AM6PR05MB6120.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lldETpQqHk1BOyb+DyuN17zzh+Z1KzlDE4q7gt14jFzhj5ofFpbpo6q9hquGTHWb6SQo3gpStGMIiiev8uPwxXTkZ/dL34WVJjPA5rDRx8Bo4GmkAkNX53/V5lw8Eisu0E6EQNddUC/DMjKnqdiNqQglVCRN83eUwbIFSCojsI2hf429ax4fGHFw7CJv/PZRntBXQof0ofoVZsSixYiad+yJJ2Irloeir3NWlHFzH3B/9+yqwLsOXIfuGWEtxuLrK2gPEV74i8FFCcfbGVF7BwIAJu6u9UcORcevfoF7QNWY9vm2ZKO62l7LeiJs7SaCmASrqav/qAewfrj/ua05Np27sJdJb+5RczVbRGjBXMAzJCUiGgeIT3FRp2YQM2+KzaHd3+Q2MTTTdP6bzTOfEwp0rl77ZgUd1N9rnXszdFecbNVBuhKaMoH/7ThG+ZkU
x-ms-exchange-antispam-messagedata: KGN8AxpStEmIErqwdT9aAZTpA1J+/wbyoJ/kErUCvhrRyNH+5Dy8SCfqlh6YTp5+Dq+fXy3c/mEam2z97AfNE96PNp4BA+8DCxs+MJXg0BrqeaeMGtLODH8ljaM1RAqmotqpXweRiDxUOU9buYOZxA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <504FBA37D3137D47B885050B57AB5C07@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb6224b-8deb-4f74-fff4-08d7c1b4bfd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 09:57:15.1764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux1WKhFfYWV51Mh8CbeEzR7XcJqrGJ/UF/3/ZZlekGxKLnGH2ugEZjDbndgPXSemku3xwQvhFkrIfiq47mwnzI8AxYusPhKOPMCoQ6+Yl3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDEzOjUzICswMDAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gd3JvdGU6DQo+IE9uIFRodSwgTWFyIDA1LCAyMDIwIGF0IDAyOjQ5OjI4UE0gKzAx
MDAsIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+IFRoZSBNQUMgb2YgdGhlIGkuTVg2IFNv
QyBpcyBjb21wbGlhbnQgd2l0aCBSR01JSSB2MS4zLiBUaGUgS1NaOTEzMQ0KPiA+IFBIWQ0KPiA+
IGlzIGxpa2UgS1NaOTAzMSBhZGhlcmluZyB0byBSR01JSSB2Mi4wIHNwZWNpZmljYXRpb24uIFRo
aXMgbWVhbnMgdGhlDQo+ID4gTUFDIHNob3VsZCBwcm92aWRlIGEgZGVsYXkgdG8gdGhlIFRYQyBs
aW5lLiBCZWNhdXNlIHRoZSBpLk1YNiBNQUMNCj4gPiBkb2VzDQo+ID4gbm90IHByb3ZpZGUgdGhp
cyBkZWxheSB0aGlzIGhhcyB0byBiZSBkb25lIGluIHRoZSBQSFkuDQo+ID4gDQo+ID4gVGhpcyBw
YXRjaCBhZGRzIGJ5IGRlZmF1bHQgfjEuNm5zIGRlbGF5IHRvIHRoZSBUWEMgbGluZS4gVGhpcyBz
aG91bGQNCj4gPiBiZSBnb29kIGZvciBhbGwgYm9hcmRzIHRoYXQgaGF2ZSB0aGUgUkdNSUkgc2ln
bmFscyByb3V0ZWQgd2l0aCB0aGUNCj4gPiBzYW1lIGxlbmd0aC4NCj4gPiANCj4gPiBUaGUgS1Na
OTEzMSBoYXMgcmVsYXRpdmVseSBoaWdoIHRvbGVyYW5jZXMgb24gc2tldyByZWdpc3RlcnMgZnJv
bQ0KPiA+IE1NRCAyLjQgdG8gTU1EIDIuOC4gVGhlcmVmb3JlIHRoZSBuZXcgRExMLWJhc2VkIGRl
bGF5IG9mIDJucyBpcyB1c2VkDQo+ID4gYW5kIHRoZW4gYXMgbGl0dGxlIGFzIHBvc3NpYmx5IHN1
YnRyYWN0ZWQgZnJvbSB0aGF0IHNvIHdlIGdldCBtb3JlDQo+ID4gYWNjdXJhdGUgZGVsYXkuIFRo
aXMgaXMgYWN0dWFsbHkgbmVlZGVkIGJlY2F1c2UgdGhlIGkuTVg2IFNvQyBoYXMNCj4gPiBhbiBh
c3luY2hyb24gc2tldyBvbiBUWEMgZnJvbSAtMTAwcHMgdG8gOTAwcHMsIHRvIGdldCBhbGwgUkdN
SUkNCj4gPiB2YWx1ZXMgd2l0aGluIHNwZWMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+
IC0tLQ0KPiA+IA0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDZxLmMgfCAzNw0KPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDM3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1p
bXgvbWFjaC1pbXg2cS5jIGIvYXJjaC9hcm0vbWFjaC0NCj4gPiBpbXgvbWFjaC1pbXg2cS5jDQo+
ID4gaW5kZXggZWRkMjZlMGZmZWVjLi44YWU1ZjJmYTMzZTIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2cS5jDQo+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgv
bWFjaC1pbXg2cS5jDQo+ID4gQEAgLTYxLDYgKzYxLDE0IEBAIHN0YXRpYyB2b2lkIG1tZF93cml0
ZV9yZWcoc3RydWN0IHBoeV9kZXZpY2UgKmRldiwNCj4gPiBpbnQgZGV2aWNlLCBpbnQgcmVnLCBp
bnQgdmFsKQ0KPiA+ICAJcGh5X3dyaXRlKGRldiwgMHgwZSwgdmFsKTsNCj4gPiAgfQ0KPiA+ICAN
Cj4gPiArc3RhdGljIGludCBtbWRfcmVhZF9yZWcoc3RydWN0IHBoeV9kZXZpY2UgKmRldiwgaW50
IGRldmljZSwgaW50DQo+ID4gcmVnKQ0KPiA+ICt7DQo+ID4gKwlwaHlfd3JpdGUoZGV2LCAweDBk
LCBkZXZpY2UpOw0KPiA+ICsJcGh5X3dyaXRlKGRldiwgMHgwZSwgcmVnKTsNCj4gPiArCXBoeV93
cml0ZShkZXYsIDB4MGQsICgxIDw8IDE0KSB8IGRldmljZSk7DQo+ID4gKwlyZXR1cm4gcGh5X3Jl
YWQoZGV2LCAweDBlKTsNCj4gPiArfQ0KPiANCj4gVGhlc2UgbG9vayBsaWtlIHRoZSBzdGFuZGFy
ZCBNSUkgTU1EIHJlZ2lzdGVycywgYW5kIGl0IGFsc28gbG9va3MgbGlrZQ0KPiB5b3UncmUgcmVp
bnZlbnRpbmcgcGh5X3JlYWRfbW1kKCkgLSBidXQgYmFkbHkgZHVlIHRvIGxhY2sgb2YgbG9ja2lu
Zy4NCj4gDQo+IEkgZ3Vlc3MgeW91IG5lZWQgdGhpcyBiZWNhdXNlIHBoeV9yZWFkX21tZCgpIG1h
eSBiZSBtb2R1bGFyIC0gbWF5YmUNCj4gd2Ugc2hvdWxkIGFycmFuZ2UgZm9yIHRoZSBhY2Nlc3Nv
cnMgdG8gYmUgc2VwYXJhdGVseSBidWlsZGFibGUgaW50bw0KPiB0aGUga2VybmVsLCBzbyB0aGF0
IHN1Y2ggZml4dXBzIGNhbiBzdG9wIGJhZGx5IHJlaW52ZW50aW5nIHRoZSB3aGVlbD8NCg0KWWVz
LCBJIGRpZCB0aGF0IGJlY2F1c2Ugb2YgdHdvIHJlYXNvbnM6DQoxLiBJIHRyaWVkIHBoeV9yZWFk
X21tZCgpIGFuZCBwaHlfd3JpdGVfbW1kKCkgYnV0IHRoaXMgcGFuaWMnZA0KMi4gVGhlcmUgaXMg
YWxyZWFkeSBtbWRfd3JpdGVfcmVnIGluIHRoYXQgY29kZSBzbyBJIHRob3VnaHQgaXQgd291bGQg
YmUNCm5vIGJpZyBkZWFsIHRvIGFsc28gaGF2ZSBhIHJlYWQgaW4gdGhlcmUuDQoNCkJ1dCB5ZWFo
LCB5b3UncmUgcmlnaHQgdGhhdCBtbWRfd3JpdGVfcmVnIGlzIGZyb20gMjAxMy4uLg0KDQpIb3cg
ZG8geW91IHN1Z2dlc3QgdG8gaW1wbGVtZW50IHRoYXQ/DQoNClBoaWxpcHBlDQo+IA0KPiA+ICsN
Cj4gPiAgc3RhdGljIGludCBrc3o5MDMxcm5fcGh5X2ZpeHVwKHN0cnVjdCBwaHlfZGV2aWNlICpk
ZXYpDQo+ID4gIHsNCj4gPiAgCS8qDQo+ID4gQEAgLTc0LDYgKzgyLDMzIEBAIHN0YXRpYyBpbnQg
a3N6OTAzMXJuX3BoeV9maXh1cChzdHJ1Y3QgcGh5X2RldmljZQ0KPiA+ICpkZXYpDQo+ID4gIAly
ZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArI2RlZmluZSBLU1o5MTMxX1JYVFhETExfQllQ
QVNTCTEyDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGtzejkxMzFybl9waHlfZml4dXAoc3RydWN0
IHBoeV9kZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJaW50IHRtcDsNCj4gPiArDQo+ID4gKwl0
bXAgPSBtbWRfcmVhZF9yZWcoZGV2LCAyLCAweDRjKTsNCj4gPiArCS8qIGRpc2FibGUgcnhkbGwg
YnlwYXNzIChlbmFibGUgMm5zIHNrZXcgZGVsYXkgb24gUlhDKSAqLw0KPiA+ICsJdG1wICY9IH4o
MSA8PCBLU1o5MTMxX1JYVFhETExfQllQQVNTKTsNCj4gPiArCW1tZF93cml0ZV9yZWcoZGV2LCAy
LCAweDRjLCB0bXApOw0KPiA+ICsNCj4gPiArCXRtcCA9IG1tZF9yZWFkX3JlZyhkZXYsIDIsIDB4
NGQpOw0KPiA+ICsJLyogZGlzYWJsZSB0eGRsbCBieXBhc3MgKGVuYWJsZSAybnMgc2tldyBkZWxh
eSBvbiBUWEMpICovDQo+ID4gKwl0bXAgJj0gfigxIDw8IEtTWjkxMzFfUlhUWERMTF9CWVBBU1Mp
Ow0KPiA+ICsJbW1kX3dyaXRlX3JlZyhkZXYsIDIsIDB4NGQsIHRtcCk7DQo+ID4gKw0KPiA+ICsJ
LyoNCj4gPiArCSAqIFN1YnRyYWN0IH4wLjZucyBmcm9tIHR4ZGxsID0gfjEuNG5zIGRlbGF5Lg0K
PiA+ICsJICogbGVhdmUgUlhDIHBhdGggdW50b3VjaGVkDQo+ID4gKwkgKi8NCj4gPiArCW1tZF93
cml0ZV9yZWcoZGV2LCAyLCA0LCAweDAwN2QpOw0KPiA+ICsJbW1kX3dyaXRlX3JlZyhkZXYsIDIs
IDYsIDB4ZGRkZCk7DQo+ID4gKwltbWRfd3JpdGVfcmVnKGRldiwgMiwgOCwgMHgwMDA3KTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoNCj4gPiAgICogZml4
dXAgZm9yIFBMWCBQRVg4OTA5IGJyaWRnZSB0byBjb25maWd1cmUgR1BJTzEtNyBhcyBvdXRwdXQg
SGlnaA0KPiA+ICAgKiBhcyB0aGV5IGFyZSB1c2VkIGZvciBzbG90czEtNyBQRVJTVCMNCj4gPiBA
QCAtMTY3LDYgKzIwMiw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbXg2cV9lbmV0X3BoeV9pbml0
KHZvaWQpDQo+ID4gIAkJCQlrc3o5MDIxcm5fcGh5X2ZpeHVwKTsNCj4gPiAgCQlwaHlfcmVnaXN0
ZXJfZml4dXBfZm9yX3VpZChQSFlfSURfS1NaOTAzMSwNCj4gPiBNSUNSRUxfUEhZX0lEX01BU0ss
DQo+ID4gIAkJCQlrc3o5MDMxcm5fcGh5X2ZpeHVwKTsNCj4gPiArCQlwaHlfcmVnaXN0ZXJfZml4
dXBfZm9yX3VpZChQSFlfSURfS1NaOTEzMSwNCj4gPiBNSUNSRUxfUEhZX0lEX01BU0ssDQo+ID4g
KwkJCQlrc3o5MTMxcm5fcGh5X2ZpeHVwKTsNCj4gPiAgCQlwaHlfcmVnaXN0ZXJfZml4dXBfZm9y
X3VpZChQSFlfSURfQVI4MDMxLCAweGZmZmZmZmVmLA0KPiA+ICAJCQkJYXI4MDMxX3BoeV9maXh1
cCk7DQo+ID4gIAkJcGh5X3JlZ2lzdGVyX2ZpeHVwX2Zvcl91aWQoUEhZX0lEX0FSODAzNSwgMHhm
ZmZmZmZlZiwNCj4gPiAtLSANCj4gPiAyLjI1LjENCj4gPiANCj4gPiANCg==
