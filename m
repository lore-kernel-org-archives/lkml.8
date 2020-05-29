Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DF6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FC5207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qrh4vtzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgE2IKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:10:45 -0400
Received: from mail-eopbgr150089.outbound.protection.outlook.com ([40.107.15.89]:33299
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE2IKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:10:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mch9I+bTQUAJmUX7PILbiP5ki/j1wogqx8fFRfbYUkP54eNcdNnYX/0yG8dn0C0PAmtie0OP3BFxijCDFr68jv4gWNx9UClZGkZsxqk20S6+4TwI6rGFcCY/SfK+z8rEQJ2MpypJ7ABr1Htcwxtsh9/XgU8k+apQbI68qC4YxD4c+UCfvjX1Hi/2bBb5ev7JLpeGj6N93l3VroPE8wYnKyAjhFEF5b65jMcOpeowQHkG9QC3U81dnFy7FFiLXd+dBMqoVkkMs0YkXx1bxSMpTp41C3Osf7O84lRnpsljSU8Ct0Ric+86Li/9a5LfaFKCLBTljA7H2NtvxhMtWVVp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INJTwu/NoL99K72Pbudw9zikPywqiqhv0ifvdoUYjys=;
 b=XVScsj0oG7qURpNQ52gNMgCs2FD+a+RrmDU00yCbAEAbM4y7gS4pMqjeNBXU1Pj/fmACmMFXoJFvGSf+HLNJ4tr3IfbcdY2UDjbtEsNdKeeYIETEXFa3yso/GTGSBHX74ak2KPfrb9LsKKgXg4Kl242gU77KaQH2VXlrU9Ylb+AlB/ZaQ47F9gq9tEfqgO/lZEisq47+mbQZwTnud3RmEvjUSjCkLezjFeGpClbnJeHszXxDfrZv3/lhHCP0+0kfXDea0DDRo6AEH9e5yiQ5pdT30uRn6lSC3G4oGoBrKsYwK+oFptHS4WThUMjeIr9orSBI9THMUKATZNkIiUIuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INJTwu/NoL99K72Pbudw9zikPywqiqhv0ifvdoUYjys=;
 b=Qrh4vtzX9bz6+6q6BDNot65QGco4sBE377K886Jywd6x9A7y3XpuDKtSuxy3COhLjVOGWk1EuMqHdKuDCI9vk8plQNXcmzGqbDpZ11KCrfmfDL/ferdMGAjEFiTIYeYsCe9a5N0IrfegjxL5O3iidJ0nB4qpjo6213/ALMbZdgo=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 08:10:40 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 08:10:40 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_acm: don't disable disabled EP
Thread-Topic: [PATCH] usb: gadget: f_acm: don't disable disabled EP
Thread-Index: AQHWNXESSGSOBa+W40WQH/z+ZHSm4ai+toSA
Date:   Fri, 29 May 2020 08:10:40 +0000
Message-ID: <20200529081104.GD32755@b29397-desktop>
References: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rere.qmqm.pl; dkim=none (message not signed)
 header.d=none;rere.qmqm.pl; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5c9daaa-6e85-4166-3373-08d803a7c725
x-ms-traffictypediagnostic: AM7PR04MB6919:
x-microsoft-antispam-prvs: <AM7PR04MB6919D740A0D8D6044BBD90528B8F0@AM7PR04MB6919.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: drvH21Cs8abN8B8PwxoRW/HMAtZ00OSLYw9bC4DXQO/7M04D4kfrg9HD4PIZPOnIG6J7lUvIwTr5aa+clLFVD9Z3mk9WXzt1TUGsSSV1VBLERwwspzs6zYTz2VN0UdPSQxieRikdT+QNpt22u+OcFpPxc3zIR0aLx1/dDcGUrpicnpUPniwNtBcmADe/Z6EqRO6T8wQPr8n0JWr0lbCjgQbYdCS9J/gKUTWMjNEC1rKhLZZwj/UvaaMwNI4cbWD05pZrogslx1S+aeQV8KvyKboSYWsrmh967NVXchDiqaY2BPkBMVIbLkO+jeJLHUK/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(2906002)(83380400001)(66574014)(316002)(33716001)(186003)(44832011)(1076003)(26005)(53546011)(6506007)(86362001)(54906003)(478600001)(8936002)(8676002)(4326008)(66946007)(5660300002)(6916009)(91956017)(66556008)(9686003)(66446008)(66476007)(76116006)(33656002)(6512007)(64756008)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rYF9YAMfRZhSAi4dlWXHHqcByzyBpzdw1QAEck+hLQXs8hnYPvB1n896+ORI3ojiHdQaBQ5cTri5Q6FY8xz5A6KOyHy5kmHN2bSv90mFievblT+7p8UrV2N5ONaFYjDwYdJe71DdjHOebfEeanMtjWWeiL5XHuzdweNlAoVq2/xOFcfDI5YHjiOWJa8LBy5HBDuVCw25PF7CFK1yv6BB2JtybUsm3lb4DqfjGzEDth2DD2XriRPyfJEmViN/ZB1v6D5iCRPqm8Zvy9qbyjxbrkX+XA+y1dnUV0O9sTA6FK5Fz6HmSnkJwAXHg0jSq2OJmwOg5+KEWsZN/eKjZ4qamcM8z/6GabLFX3uNnFn2uzAM8VX2nJ1pNIS1wo02OPWJ2uUtQ4BhgD9zrmXewfjNSdrZQ/ZwoFpt/K0sEraTfy5ymBCgUSN/plmxIx2CatyuhYpRCKz2hqju3b/Lxyykhi6CIM3ZnXlFo6JsmZSuHi8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CD7FF03DACB70458D69354DA88D5E47@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c9daaa-6e85-4166-3373-08d803a7c725
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 08:10:40.7126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKCfBtfoAU63Rz2SBgv4FO0CbNngVAINMVk24eExa+UT01fpLrqOtYf+PdHmIFxiEROs9gvH94L+wyXlWL+LDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAtMDUtMjggMjA6MzA6MjgsIE1pY2hhxYIgTWlyb3PFgmF3IHdyb3RlOg0KPiBNYWtlIGRl
YnVnZ2luZyByZWFsIHByb2JsZW1zIGVhc2llciBieSBub3QgdHJ5aW5nIHRvIGRpc2FibGUgYW4g
RVAgdGhhdA0KPiB3YXMgbm90IHlldCBlbmFibGVkLg0KPiANCj4gRml4ZXM6IDRhYWI3NTdjYTQ0
YSAoInVzYjogZ2FkZ2V0OiBmX2FjbTogZWxpbWluYXRlIGFidXNlIG9mIGVwLT5kcml2ZXIgZGF0
YSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUu
cW1xbS5wbD4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9hY20uYyB8
IDggKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
YWNtLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9hY20uYw0KPiBpbmRleCAyMDA1
OTZlYTk1NTcuLjQ2NjQ3YmZhYzJlZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfYWNtLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
YWNtLmMNCj4gQEAgLTQyNSw5ICs0MjUsMTEgQEAgc3RhdGljIGludCBhY21fc2V0X2FsdChzdHJ1
Y3QgdXNiX2Z1bmN0aW9uICpmLCB1bnNpZ25lZCBpbnRmLCB1bnNpZ25lZCBhbHQpDQo+ICAJLyog
d2Uga25vdyBhbHQgPT0gMCwgc28gdGhpcyBpcyBhbiBhY3RpdmF0aW9uIG9yIGEgcmVzZXQgKi8N
Cj4gIA0KPiAgCWlmIChpbnRmID09IGFjbS0+Y3RybF9pZCkgew0KPiAtCQlkZXZfdmRiZygmY2Rl
di0+Z2FkZ2V0LT5kZXYsDQo+IC0JCQkJInJlc2V0IGFjbSBjb250cm9sIGludGVyZmFjZSAlZFxu
IiwgaW50Zik7DQo+IC0JCXVzYl9lcF9kaXNhYmxlKGFjbS0+bm90aWZ5KTsNCj4gKwkJaWYgKGFj
bS0+bm90aWZ5LT5lbmFibGVkKSB7DQo+ICsJCQlkZXZfdmRiZygmY2Rldi0+Z2FkZ2V0LT5kZXYs
DQo+ICsJCQkJCSJyZXNldCBhY20gY29udHJvbCBpbnRlcmZhY2UgJWRcbiIsIGludGYpOw0KPiAr
CQkJdXNiX2VwX2Rpc2FibGUoYWNtLT5ub3RpZnkpOw0KPiArCQl9DQoNCkJ1dCBpdCBkb2VzIG5v
dCBmaXggYW55IGlzc3VlcywgdGhlIHVzYl9lcF9kaXNhYmxlIGNoZWNrcyAnZW5hYmxlZCcgZmxh
Zy4NCg0KLS0gDQoNClRoYW5rcywNClBldGVyIENoZW4=
