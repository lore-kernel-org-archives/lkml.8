Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B18C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163E0208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="LGy0aG0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGLkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:40:06 -0400
Received: from mail-eopbgr70110.outbound.protection.outlook.com ([40.107.7.110]:4676
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgEGLkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:40:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY/rlHBI/GA6Ox+evhgewN1JrE96GThJ7RqaWlvvZXh/TLijrF50ffR+YNyzw3RaxqCaK67k+1CEoVjXT1iQR73R7y6HCVBeInVZWMChMnvk4a5aD8UXvj1Bo6+TYFvmv5iAdpg2CbWaEuguw5AFtVRM/leM8q7Vsx2/Fbo/CcY8TJtYbnVFhPD0J/5HfkLLpZTAu+HGQT15zI65+fuHX5Fb7UcDlH6cef9UEvSpbCN5S9X/aW2Qt9Ll8D3DiN3m7Gv7iW1fo8JaCtsG5mc8RcGKOPCKtBvvtomDzgh07CBEcRYPi896bAoVRM5vImw9vTfXZlNmvNyP1Cx2HOEZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REG8EPehNarY/yGsa0fRI7+j40UTo7cDPWZwMPV7x5s=;
 b=fW+wTme0WB4TZxjoqlewCwHtGi28tfCX/vgE9/jVvv9Mj1s8HnIgaKoF7EW+RFA4XWsxwi2MxFrGVU4UAXWm7rj4X9Vc3FKfKHHSLKB2MLbsOeb9jT5DvgOf5pDKxIliZrlayXouM815epxesLZEZBft/ORt5MA3TIyQ0tJtDrXnZeJGne4unGRgAa1zfqIJxHg6I3aEhjFjYs8i/No0Xfh57QjhIu7HGeHsyPuRtCfSqIEBgA6c6atGr2aMJKch2vqhpTuSi/DaaN+Vf1YgOqggglsorlUQbCyIJxjQ21rnq18mwxGWio8t0DTaVx2AYi2+vsLQKLoC8Cdq2IUPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REG8EPehNarY/yGsa0fRI7+j40UTo7cDPWZwMPV7x5s=;
 b=LGy0aG0fgW23CtMjN1U0FspwVKn6WneXgdZbEcWN8YsKBE/l9Dy60j9HGAN6A+mi5EbQUJGkspx2alshu9uuMDGwIBfytSr2CNJPNqF1FfccEQwgY0LSklcSQZuQw5hEYdD7EDlNNjGVm7bxCwCOUn6ymeI3bg3rRamUpE/+Fmc=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4422.eurprd05.prod.outlook.com (2603:10a6:209:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 11:40:01 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::d8d3:ead7:9f42:4289]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::d8d3:ead7:9f42:4289%6]) with mapi id 15.20.2979.030; Thu, 7 May 2020
 11:40:01 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco
 board
Thread-Topic: [PATCH V2 3/4] ARM: dts: stm32: enable stmpe811 on
 stm32429-disco board
Thread-Index: AQHWJGDUkh+1vWERX0ChStn6nGXI06icf7qA
Date:   Thu, 7 May 2020 11:40:01 +0000
Message-ID: <7f7ad11559ec728c72d3d4df19ca16fe6a57058e.camel@toradex.com>
References: <1588850125-24344-1-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1588850125-24344-1-git-send-email-dillon.minfei@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [51.154.7.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29fbc4f7-5b24-419c-9140-08d7f27b60de
x-ms-traffictypediagnostic: AM6PR05MB4422:
x-microsoft-antispam-prvs: <AM6PR05MB44221BADEA5EDEC59ABEC04BF4A50@AM6PR05MB4422.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AxzFTOa8ZwZzlUHwLviCmW15pVlyFHD61ml8tbRAheNapEz6R2qqMQJZs5K0egBhJtCe8/KYwvRFwYymrgkeCxkrcdFEqv5OqUK5kdrF6nYkMQYSLQOqSxoBEQ/DSonEOPfEqy6VIaPBFa1sSfV6m6NaACmdJjRNAlZHPFH3620pL6MOzFJ+jgKU59CFEi+ldEcuHgKSg9tdF1SlDSDxDx9kUX3Pezpngve6c/GN46zqZb5/FJzCjCgzsSl9l2TELuTD5g6mjmk2kqpdfjPFNk0XxUDd6hEHLaydBtaBz9pEk+HIC1FZO91qyugRdJ4CMA03KSJQUPwIAN/F/+tbVCQyegzamce+r0rG+l9DClFuMoP2GtCq65KxQMJnyVGEez3FTEr+aVMsJ7fkfwUXraGDBrmWjQPS9xVC8GzQXjnVw+WiKIVeCl3wn75X4+3yq7SDoDYjyfIIB9Z0mHesVcJr2E3joAoN3iUxQMYb1H2ePavuTK/xHvQKXJVFKpl7SBI1ZjHPRweGAFe8hZ1rag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(33430700001)(8936002)(33440700001)(6512007)(86362001)(6506007)(66946007)(44832011)(6486002)(2906002)(66556008)(186003)(66476007)(66446008)(64756008)(8676002)(36756003)(2616005)(110136005)(54906003)(5660300002)(83320400001)(83280400001)(83310400001)(316002)(478600001)(83290400001)(26005)(71200400001)(83300400001)(76116006)(4326008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g237bnMKZYHSTxKGC0S2aRZgC+wlf9bYDfQvima5NeqHgOF+b/1YDLbo7xgWAJg7euX79jT1euKDhKz6u8bNpyJyUpG5AmHELThrHAOcvTXfjPNg/8nmCziSylUjJ8ZUBROIb7FxH3186lfraE/efIvtqFw1FDfO5e6wTRaixR4YHgYWOVllg1nSdj+3+UwuZX21F2Sg57dBJDD1TSfH8KYwksoQje6qMNI1tYDNi6xgN4hwSOUbepIgdWc7BHcmVZbKA6+0qwAyHb8B6Y4L04ClAgxAVL659vSAQboI2HPfbWGM0nqEGm4iYm1Y41jmf5jbi7OQdEyEvHt1Drfxogq1LQ5m5JpmrsW5P6qbKZHO7Wlea+mUhqA06f+qzOolGkNujjuzDJ+Mjw+YzQ7kVQlNdKtjTyp72wyPEzPFxy16pMpVA8Vg+tiLz/s6AONzr5xLaCwFU68Y7+HLHrL4yO/mqkGY7x1hbOrV/RuH2ckC4RiWIAgQkudgdKK19lJ+HNxExKUl+Ue27kVP2CM4RZ2BHsyoHu/mODsgUlXZTRiaao+uTyl7LWn4BTOa/wh02Ku8zucMy3kQlBfIUaJ2jZEtuVHwv1X+WW8E1t+CEod9z0UNThQDm1eze3wIGt6WxzB3B7IfzmwRA9ve91e6fqU/JbAtwubAPheVu0QOpldonwtclc1wV6GbHdy+m7h5URzEp99yoI//u45121TgOlBD0YfqRFmvEdUq3ueXrRXwoB0RC41z6xnp9kCJHB5ASkfoawRz1mj6vjF7p3IRTwoAv6D9JP0+I8JiHzQ6Pi4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <014E3F861DA3C24E97B6948622A59A2E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fbc4f7-5b24-419c-9140-08d7f27b60de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 11:40:01.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkoWnmgKnXKPCVfB9l406okk2fIZ3OPQdaotk2TPJHn5dHgC03+PYc8NOglY1k0F3uA/i/cEhY5jD+4uzzHwCusuDIL9QXdFROhKUetwFOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTA3IGF0IDE5OjE1ICswODAwLCBkaWxsb24ubWluZmVpQGdtYWlsLmNv
bSB3cm90ZToNCj4gRnJvbTogZGlsbG9uIG1pbiA8ZGlsbG9uLm1pbmZlaUBnbWFpbC5jb20+DQo+
IA0KPiBFbmFibGUgdGhlIHN0bXBlODExIHRvdWNoIHNjcmVlbiBvbiBzdG0zMjQyOS1kaXNjbyBi
b2FyZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGRpbGxvbiBtaW4gPGRpbGxvbi5taW5mZWlAZ21h
aWwuY29tPg0KPiANCj4gW1BBVENIIDMvNF06IEFSTTogZHRzOiBzdG0zMjogZW5hYmxlIHN0bXBl
ODExIG9uIHN0bTMyNDI5LWRpc2NvDQo+IA0KPiBWMjoNCj4gcGF0Y2ggMzogcmVtb3ZlIHVudXNl
ZCBpZCwgYmxvY2tzLCBpcnEtdHJpZ2dlcg0KPiANCj4gVjE6DQo+IHBhdGNoIDQ6IGZpeCByZWFk
IHRvdWNoIHNjcmVlbiB4eXogdGltZW91dCBidWcNCj4gcGF0Y2ggMzogZW5hYmxlIHN0bXBlX3Rv
dWNoc2NyZWVuIG9uIHN0bTMyZjQyOS1kaXNjbyBib2FyZA0KPiBwYXRjaCAyOiBhZGQgaTJjMyBw
aW4gbXV4IGZvciBzdG0zMmY0DQo+IHBhdGNoIDE6IGFkZCBpMmMzIGNvbnRyb2xsZXIgaW50ZXJm
YWNlIGZvciBzdG0zMmY0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBkaWxsb24gbWluIDxkaWxsb24u
bWluZmVpQGdtYWlsLmNvbT4NCg0KRm9yIHRoZSBTVE1QRSBwYXJ0Og0KDQpSZXZpZXdlZC1ieTog
UGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQo+IC0t
LQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJmNDI5LWRpc2NvLmR0cyB8IDQ3DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyZjQy
OS1kaXNjby5kdHMNCj4gYi9hcmNoL2FybS9ib290L2R0cy9zdG0zMmY0MjktZGlzY28uZHRzDQo+
IGluZGV4IDMwYzBmNjcuLmZhZDFlYzEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3N0bTMyZjQyOS1kaXNjby5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJmNDI5
LWRpc2NvLmR0cw0KPiBAQCAtNDksNiArNDksOCBAQA0KPiAgI2luY2x1ZGUgInN0bTMyZjQyOS5k
dHNpIg0KPiAgI2luY2x1ZGUgInN0bTMyZjQyOS1waW5jdHJsLmR0c2kiDQo+ICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW5wdXQvaW5wdXQuaD4NCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dw
aW8uaD4NCj4gIA0KPiAgLyB7DQo+ICAJbW9kZWwgPSAiU1RNaWNyb2VsZWN0cm9uaWNzIFNUTTMy
RjQyOWktRElTQ08gYm9hcmQiOw0KPiBAQCAtMTI3LDMgKzEyOSw0OCBAQA0KPiAgCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gKw0KPiAr
JmkyYzMgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0g
PCZpMmMzX3BpbnM+Ow0KPiArCWNsb2NrLWZyZXF1ZW5jeSA9IDwxMDAwMDA+Ow0KPiArCXN0YXR1
cyA9ICJva2F5IjsNCj4gKw0KPiArCXN0bXBlODExQDQxIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJz
dCxzdG1wZTgxMSI7DQo+ICsJCXJlZyA9IDwweDQxPjsNCj4gKwkJaW50ZXJydXB0cyA9IDwxNSBJ
UlFfVFlQRV9FREdFX0ZBTExJTkc+Ow0KPiArCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvYT47
DQo+ICsJCS8qIDMuMjUgTUh6IEFEQyBjbG9jayBzcGVlZCAqLw0KPiArCQlzdCxhZGMtZnJlcSA9
IDwxPjsNCj4gKwkJLyogMTItYml0IEFEQyAqLw0KPiArCQlzdCxtb2QtMTJiID0gPDE+Ow0KPiAr
CQkvKiBpbnRlcm5hbCBBREMgcmVmZXJlbmNlICovDQo+ICsJCXN0LHJlZi1zZWwgPSA8MD47DQo+
ICsJCS8qIEFEQyBjb252ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gKwkJc3Qsc2FtcGxl
LXRpbWUgPSA8ND47DQo+ICsNCj4gKwkJc3RtcGVfdG91Y2hzY3JlZW4gew0KPiArCQkJY29tcGF0
aWJsZSA9ICJzdCxzdG1wZS10cyI7DQo+ICsJCQkvKiA4IHNhbXBsZSBhdmVyYWdlIGNvbnRyb2wg
Ki8NCj4gKwkJCXN0LGF2ZS1jdHJsID0gPDM+Ow0KPiArCQkJLyogNyBsZW5ndGggZnJhY3Rpb25h
bCBwYXJ0IGluIHogKi8NCj4gKwkJCXN0LGZyYWN0aW9uLXogPSA8Nz47DQo+ICsJCQkvKg0KPiAr
CQkJICogNTAgbUEgdHlwaWNhbCA4MCBtQSBtYXggdG91Y2hzY3JlZW4gZHJpdmVycw0KPiArCQkJ
ICogY3VycmVudCBsaW1pdCB2YWx1ZQ0KPiArCQkJICovDQo+ICsJCQlzdCxpLWRyaXZlID0gPDE+
Ow0KPiArCQkJLyogMSBtcyBwYW5lbCBkcml2ZXIgc2V0dGxpbmcgdGltZSAqLw0KPiArCQkJc3Qs
c2V0dGxpbmcgPSA8Mz47DQo+ICsJCQkvKiA1IG1zIHRvdWNoIGRldGVjdCBpbnRlcnJ1cHQgZGVs
YXkgKi8NCj4gKwkJCXN0LHRvdWNoLWRldC1kZWxheSA9IDw1PjsNCj4gKwkJfTsNCj4gKw0KPiAr
CQlzdG1wZV9hZGMgew0KPiArCQkJY29tcGF0aWJsZSA9ICJzdCxzdG1wZS1hZGMiOw0KPiArCQkJ
LyogZm9yYmlkIHRvIHVzZSBBREMgY2hhbm5lbHMgMy0wICh0b3VjaCkgKi8NCj4gKwkJCXN0LG5v
cmVxdWVzdC1tYXNrID0gPDB4MEY+Ow0KPiArCQl9Ow0KPiArCX07DQo+ICt9Ow0K
