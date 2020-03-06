Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43831C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF6D2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Nk0Bdh9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:55:11 -0500
Received: from mail-eopbgr20106.outbound.protection.outlook.com ([40.107.2.106]:6806
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbgCFJzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:55:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYdzMG1iFOhkAloxfPNJDiH2ns6BtuvjuppQHsYsqTWGc3/JBzr19DLHLVjEyhfO0usS3iYPnePi1QffwX4EsUOp/e8V7xIGq427zCfy8FuRvS4IptW4b17ghFC9M/+u/xUSX/AC8XTekx4fSg135VkwrPFVGuoi8zU6iU32CGYrJtB9zJgVYQO2sRh1RPdjiHbuL64bE9sP5+hy8/uf+kCAPdqGs5XaJ116iTdSjD0nNp/IjbTCHsZwe9/6KvWXeq/TOjp0fCIIa+Tvd2lzdDN5KGbygHzB+NyAHvA1CcutFL9tNocKeEX2pvneRLWrs+9V/Qwmr9Tk5W1Jkdk7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jLgIFH5HWbHzi6vSoNmqSsFnmdBLqxeD5Zx8BL/MbM=;
 b=cnEmGwlIymK8RqdbmorpKxl1C56wd521Rdg4mXck5atwxSzg7kLcDdAlXUpNqxifstaig+nn0Kv0wCz72d8KhK7eD0th4E3VEQ+O425m8m32LXzHV0j3JKrwiEEfPuuuR1lWIp/N8yLTA9vCZ0N8ELTeEyznM2mHXfEsxB92JzKez7er1NkyLJ88vHkoS0CWbqiiCenigDTsIWG0wliRZ1u+zPhb6KaUmrQNfyUvhlmSNHf8yN7LbKXwK7U8OsnJuDY1Ubmdo44gglRvV1iMQAAVZ+bmja9LdPd2wdu/VaDRzuPdUyKFct+Mh8TSuL0yLQTC7Z1PS64Ol/d0VNujQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jLgIFH5HWbHzi6vSoNmqSsFnmdBLqxeD5Zx8BL/MbM=;
 b=Nk0Bdh9FpeG9mX7Bbec9JediwI8PCQ6EHc0zxFJfeEsruIN9XSbamLb+CST0qPUiXDZ67CqyZdTmCL3rVQJbuPBgBYH0q8RR1eMnLnXdPsM33Ea4Z6/eJ/uFtFjBvYAE6ZkkjqwSOBjfOWqgePUZcViWXjIdRWGJko+UkMcJFs4=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (20.179.1.217) by
 AM6PR05MB6102.eurprd05.prod.outlook.com (20.179.3.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Fri, 6 Mar 2020 09:55:06 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e%4]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 09:55:06 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Topic: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Index: AQHV8vTsfP1BktnxKEy+q0EhrXMNZqg6EXKAgAFDQ4A=
Date:   Fri, 6 Mar 2020 09:55:06 +0000
Message-ID: <240b86a0aa76ac1f1d3948fc3089e3d13266f4b1.camel@toradex.com>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
         <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
In-Reply-To: <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08422c7a-18b2-498c-c7f2-08d7c1b472fb
x-ms-traffictypediagnostic: AM6PR05MB6102:
x-microsoft-antispam-prvs: <AM6PR05MB6102EF0B1A1E072799BE5FC0F4E30@AM6PR05MB6102.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(189003)(199004)(76116006)(44832011)(6512007)(4326008)(2616005)(54906003)(71200400001)(66446008)(36756003)(91956017)(64756008)(66556008)(86362001)(316002)(66946007)(66476007)(81156014)(81166006)(8676002)(5660300002)(26005)(7416002)(186003)(6486002)(478600001)(2906002)(6916009)(8936002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB6102;H:AM6PR05MB6120.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZWldYLqaQduhL8o6NoXTWDcI2Tzcw3r9GTQDWaLaL2cKmiHS9fhGTWNKylp720ijho77957ltTmybwP5eSvO5l0u1nrcQ2PPFaG9LmKRbOlhojT+GWzLd85fFEBkTl+sI3Oabej3pXB0l7QgAuMnnBYCcaQZ04sKlzn70R0CwrxxkZ1+7178RgPuX4msKOSkRfmZDXs9TwRZ4edlwnn9aL+jOeR3evFilj0OOMz8Q7LyzxDm98fDCcfIb+A0wFuVjvQZUnJDjH+20U5Ul0mi5B+8+QzfkB58h91zEDVHNhU34wzPrpIaiRbtdWry+jYzgl1dHqWvDm8xk0a0/mQNWDxqjrVrPgv1VhCAgWqlZqfxFr5DiiLnoewzoLawfPHYGOrooS0EZx2JmrdsCxh6mGTQvHThmR2ptGvAfXNyUVrRd6aTzQPy3r3hOEYhsJ4
x-ms-exchange-antispam-messagedata: BTYrzSINbnj5jPX7tFJQKWAdnQ048bCKNmxPfRRO0ihZTXKSj2qcSKAAiRPgTNRDxNrIaxG73sg24Ptw0KSP38113S3kPaJfkKf5APrpUjKVH7Um7LmtBvqLtqPxbc+OoElaHgF41WHyiL9x+MnEJg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFCE055C63299E45AD1CD8A9714B53D6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08422c7a-18b2-498c-c7f2-08d7c1b472fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 09:55:06.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tn4w7mw9I/berCOzBh/zQK0LeyatqEKiLttxJ7650nCNS5oeHPapcXhQfpgyBGYGddbUNf/ajq61ymddfppShfDn2KGBHOxzRBfFbS6nvmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDE1OjM4ICswMTAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gSGkgUGhpbGlwcGUsDQo+IA0KPiBPbiBUaHUsIE1hciAwNSwgMjAyMCBhdCAwMjo0OToyOFBN
ICswMTAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90ZToNCj4gPiBUaGUgTUFDIG9mIHRoZSBpLk1Y
NiBTb0MgaXMgY29tcGxpYW50IHdpdGggUkdNSUkgdjEuMy4gVGhlIEtTWjkxMzENCj4gPiBQSFkN
Cj4gPiBpcyBsaWtlIEtTWjkwMzEgYWRoZXJpbmcgdG8gUkdNSUkgdjIuMCBzcGVjaWZpY2F0aW9u
LiBUaGlzIG1lYW5zIHRoZQ0KPiA+IE1BQyBzaG91bGQgcHJvdmlkZSBhIGRlbGF5IHRvIHRoZSBU
WEMgbGluZS4gQmVjYXVzZSB0aGUgaS5NWDYgTUFDDQo+ID4gZG9lcw0KPiA+IG5vdCBwcm92aWRl
IHRoaXMgZGVsYXkgdGhpcyBoYXMgdG8gYmUgZG9uZSBpbiB0aGUgUEhZLg0KPiA+IA0KPiA+IFRo
aXMgcGF0Y2ggYWRkcyBieSBkZWZhdWx0IH4xLjZucyBkZWxheSB0byB0aGUgVFhDIGxpbmUuIFRo
aXMgc2hvdWxkDQo+ID4gYmUgZ29vZCBmb3IgYWxsIGJvYXJkcyB0aGF0IGhhdmUgdGhlIFJHTUlJ
IHNpZ25hbHMgcm91dGVkIHdpdGggdGhlDQo+ID4gc2FtZSBsZW5ndGguDQo+ID4gDQo+ID4gVGhl
IEtTWjkxMzEgaGFzIHJlbGF0aXZlbHkgaGlnaCB0b2xlcmFuY2VzIG9uIHNrZXcgcmVnaXN0ZXJz
IGZyb20NCj4gPiBNTUQgMi40IHRvIE1NRCAyLjguIFRoZXJlZm9yZSB0aGUgbmV3IERMTC1iYXNl
ZCBkZWxheSBvZiAybnMgaXMgdXNlZA0KPiA+IGFuZCB0aGVuIGFzIGxpdHRsZSBhcyBwb3NzaWJs
eSBzdWJ0cmFjdGVkIGZyb20gdGhhdCBzbyB3ZSBnZXQgbW9yZQ0KPiA+IGFjY3VyYXRlIGRlbGF5
LiBUaGlzIGlzIGFjdHVhbGx5IG5lZWRlZCBiZWNhdXNlIHRoZSBpLk1YNiBTb0MgaGFzDQo+ID4g
YW4gYXN5bmNocm9uIHNrZXcgb24gVFhDIGZyb20gLTEwMHBzIHRvIDkwMHBzLCB0byBnZXQgYWxs
IFJHTUlJDQo+ID4gdmFsdWVzIHdpdGhpbiBzcGVjLg0KDQpIaSBPbGVrc2lqISBUaGFua3MgZm9y
IHlvdXIgY29tbWVudHMgYW5kIHJldmlldy4NCj4gDQo+IFRoaXMgY29uZmlndXJhdGlvbiBoYXMg
bm90aGluZyB0byBkbyBpbiBtYWNoLWlteC8qIEl0IGJlbG9uZ3MgdG8gdGhlDQo+IGJvYXJkIGRl
dmljZXRyZWUuIFBsZWFzZSBzZWUgRFQgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBuZWVkZWQN
Cj4gcHJvcGVydGllczoNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9t
aWNyZWwta3N6OTB4MS50eHQNCg0KSSBrbm93IHRoYXQgbm93YWRheXMgdGhpcyBzdHVmZiBvbmx5
IGJlbG9uZ3MgaW4gdGhlIGRldmljZXRyZWUuIEkgZnVsbHkNCmFncmVlIHdpdGggeW91LiBJIGFt
IGFsc28gYXdhcmUgb2YgdGhlIGRldmljZXRyZWUgYmluZGluZ3MuDQo+IA0KPiBBbGwgb2YgdGhp
cyBtYWNoLWlteCBmaXh1cHMgYXJlIGV2aWwgYW5kIHNob3VsZCBiZSByZW1vdmVkIG9yIGRpc2Fi
bGVkDQo+IGJ5IEtjb25maWcNCj4gb3B0aW9uLiBTaW5jZSB0aGV5IHdpbGwgcnVuIG9uIGFsbCBp
Lk1YIGJhc2VkIGJvYXJkcyBldmVuIGlmIHRoaXMgUEhZDQo+IGFyZQ0KPiBjb25uZWN0ZWQgdG8g
c29tZSBzd2l0Y2ggYW5kIG5vdCBjb25uZWN0ZWQgdG8gdGhlIEZFQyBkaXJlY3RseS4NCj4gQW5k
Li4gSWYgZHJpdmVyIGRpZG4ndCBtYWRlIHRoaXMgY29uZmlndXJhdGlvbiBhbGwgdGhpcyBjaGFu
Z2VzIHdpbGwNCj4gYmUgbG9zdCBvbg0KPiBzdXNwZW5kL3Jlc3VtZSBjeWNsZSBvciBvbiBQSFkg
cmVzZXQuDQoNCkkgYW0gYWxzbyBhd2FyZSBvZiB0aGlzIGJlaGF2aW91ci4gQnV0IHRoZSBpLk1Y
NiBpcyBhIFNvQyB1c2VkIGluDQplbWJlZGRlZCBhcHBsaWNhdGlvbnMgYW5kIEkgZ3Vlc3Mgbm8g
b25lIGNvbWVzIGFuZCBwbHVncyBpbiBhIFBDSWUgTUFDDQpjYXJkIGluIGFuIGVtYmVkZGVkIGRl
dmljZS4gQnV0IHllcyB5b3UncmUgcmlnaHQgeW91IG5ldmVyIGtub3cuDQoNCkJlY2F1c2UgdGhl
IGkuTVg2IGlzIGFuIGVtYmVkZGVkIHByb2Nlc3NvciBJIHN0aWxsIHRoaW5rIHdlIHNob3VsZCBw
bGFjZQ0KdGhhdCBmaXh1cCBpbiBtYWNoLWlteC4gVGhlcmUgaXMgYWxyZWFkeSBhIGZpeHVwIGZv
ciB0aGUgcHJlZGVjZXNzb3INCktTWjkwMzEgaW4gdGhhdCBjb2RlLiBUaGUgS1NaOTEzMSBpcyBw
aW4tY29tcGF0aWJsZSB3aXRoIEtTWjkwMzEgYW5kDQphbHNvIHNvZnR3YXJlIGNvbXBhdGlibGUs
IGp1c3Qgbm90IHdpdGggdGhlIHNrZXcgc2V0dGluZ3MuDQoNCkkgcmVhbGx5IGRpc2xpa2UgcmVp
bnZlbnRpbmcgdGhlIHdlZWwgaGVyZSBmb3IgYW4gb2xkIFNvQy4NCg0KUGhpbGlwcGUNCj4gDQo+
IFJlZ2FyZHMsDQo+IE9sZWtzaWoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2No
ZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiA+
IA0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDZxLmMgfCAzNw0KPiA+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2Vy
dGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1p
bXg2cS5jIGIvYXJjaC9hcm0vbWFjaC0NCj4gPiBpbXgvbWFjaC1pbXg2cS5jDQo+ID4gaW5kZXgg
ZWRkMjZlMGZmZWVjLi44YWU1ZjJmYTMzZTIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vbWFj
aC1pbXgvbWFjaC1pbXg2cS5jDQo+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2
cS5jDQo+ID4gQEAgLTYxLDYgKzYxLDE0IEBAIHN0YXRpYyB2b2lkIG1tZF93cml0ZV9yZWcoc3Ry
dWN0IHBoeV9kZXZpY2UgKmRldiwNCj4gPiBpbnQgZGV2aWNlLCBpbnQgcmVnLCBpbnQgdmFsKQ0K
PiA+ICAJcGh5X3dyaXRlKGRldiwgMHgwZSwgdmFsKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3Rh
dGljIGludCBtbWRfcmVhZF9yZWcoc3RydWN0IHBoeV9kZXZpY2UgKmRldiwgaW50IGRldmljZSwg
aW50DQo+ID4gcmVnKQ0KPiA+ICt7DQo+ID4gKwlwaHlfd3JpdGUoZGV2LCAweDBkLCBkZXZpY2Up
Ow0KPiA+ICsJcGh5X3dyaXRlKGRldiwgMHgwZSwgcmVnKTsNCj4gPiArCXBoeV93cml0ZShkZXYs
IDB4MGQsICgxIDw8IDE0KSB8IGRldmljZSk7DQo+ID4gKwlyZXR1cm4gcGh5X3JlYWQoZGV2LCAw
eDBlKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBrc3o5MDMxcm5fcGh5X2ZpeHVw
KHN0cnVjdCBwaHlfZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiAgCS8qDQo+ID4gQEAgLTc0LDYg
KzgyLDMzIEBAIHN0YXRpYyBpbnQga3N6OTAzMXJuX3BoeV9maXh1cChzdHJ1Y3QgcGh5X2Rldmlj
ZQ0KPiA+ICpkZXYpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArI2RlZmlu
ZSBLU1o5MTMxX1JYVFhETExfQllQQVNTCTEyDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGtzejkx
MzFybl9waHlfZml4dXAoc3RydWN0IHBoeV9kZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJaW50
IHRtcDsNCj4gPiArDQo+ID4gKwl0bXAgPSBtbWRfcmVhZF9yZWcoZGV2LCAyLCAweDRjKTsNCj4g
PiArCS8qIGRpc2FibGUgcnhkbGwgYnlwYXNzIChlbmFibGUgMm5zIHNrZXcgZGVsYXkgb24gUlhD
KSAqLw0KPiA+ICsJdG1wICY9IH4oMSA8PCBLU1o5MTMxX1JYVFhETExfQllQQVNTKTsNCj4gPiAr
CW1tZF93cml0ZV9yZWcoZGV2LCAyLCAweDRjLCB0bXApOw0KPiA+ICsNCj4gPiArCXRtcCA9IG1t
ZF9yZWFkX3JlZyhkZXYsIDIsIDB4NGQpOw0KPiA+ICsJLyogZGlzYWJsZSB0eGRsbCBieXBhc3Mg
KGVuYWJsZSAybnMgc2tldyBkZWxheSBvbiBUWEMpICovDQo+ID4gKwl0bXAgJj0gfigxIDw8IEtT
WjkxMzFfUlhUWERMTF9CWVBBU1MpOw0KPiA+ICsJbW1kX3dyaXRlX3JlZyhkZXYsIDIsIDB4NGQs
IHRtcCk7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIFN1YnRyYWN0IH4wLjZucyBmcm9tIHR4
ZGxsID0gfjEuNG5zIGRlbGF5Lg0KPiA+ICsJICogbGVhdmUgUlhDIHBhdGggdW50b3VjaGVkDQo+
ID4gKwkgKi8NCj4gPiArCW1tZF93cml0ZV9yZWcoZGV2LCAyLCA0LCAweDAwN2QpOw0KPiA+ICsJ
bW1kX3dyaXRlX3JlZyhkZXYsIDIsIDYsIDB4ZGRkZCk7DQo+ID4gKwltbWRfd3JpdGVfcmVnKGRl
diwgMiwgOCwgMHgwMDA3KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAgLyoNCj4gPiAgICogZml4dXAgZm9yIFBMWCBQRVg4OTA5IGJyaWRnZSB0byBjb25maWd1
cmUgR1BJTzEtNyBhcyBvdXRwdXQgSGlnaA0KPiA+ICAgKiBhcyB0aGV5IGFyZSB1c2VkIGZvciBz
bG90czEtNyBQRVJTVCMNCj4gPiBAQCAtMTY3LDYgKzIwMiw4IEBAIHN0YXRpYyB2b2lkIF9faW5p
dCBpbXg2cV9lbmV0X3BoeV9pbml0KHZvaWQpDQo+ID4gIAkJCQlrc3o5MDIxcm5fcGh5X2ZpeHVw
KTsNCj4gPiAgCQlwaHlfcmVnaXN0ZXJfZml4dXBfZm9yX3VpZChQSFlfSURfS1NaOTAzMSwNCj4g
PiBNSUNSRUxfUEhZX0lEX01BU0ssDQo+ID4gIAkJCQlrc3o5MDMxcm5fcGh5X2ZpeHVwKTsNCj4g
PiArCQlwaHlfcmVnaXN0ZXJfZml4dXBfZm9yX3VpZChQSFlfSURfS1NaOTEzMSwNCj4gPiBNSUNS
RUxfUEhZX0lEX01BU0ssDQo+ID4gKwkJCQlrc3o5MTMxcm5fcGh5X2ZpeHVwKTsNCj4gPiAgCQlw
aHlfcmVnaXN0ZXJfZml4dXBfZm9yX3VpZChQSFlfSURfQVI4MDMxLCAweGZmZmZmZmVmLA0KPiA+
ICAJCQkJYXI4MDMxX3BoeV9maXh1cCk7DQo+ID4gIAkJcGh5X3JlZ2lzdGVyX2ZpeHVwX2Zvcl91
aWQoUEhZX0lEX0FSODAzNSwgMHhmZmZmZmZlZiwNCj4gPiAtLSANCj4gPiAyLjI1LjENCj4gPiAN
Cj4gPiANCj4gPiANCg==
