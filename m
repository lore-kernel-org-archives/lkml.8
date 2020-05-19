Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4547FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2092A2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nYb2JpgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgESCt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:49:57 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:47287
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbgESCt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTF4p+6hibFv6oHrFULdsvuNgxf5Z12PVUytnOoiIReayqzvXmOW93dRSBl6tKHKkg5IE8WbDA6ureSVv+60bmEDkfPONEsyqtpJy8/cDrZetT42TWEnlcS/vsTEriJ9ol6e3Xzfzq1IJvL52EJ1QoQConi4XZAMraRr++/P7l/XuJhirmZeO0PzUX1bP9PWsfGMEJpQHgfvhcgOiXSzrVS/6eqjeY0JfZeDxO8zq4hm1YfHTzeOFhCJL9lLSfa/PnoZKrEvppYR5Tl/50mC3M6vAOGnf3kF9DXUYi+IkIeDOlRokvDyvzvJJ+qQaf0elD6pGeV20oqqPGRGU4zNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGPcUiRJ0CW6YzTZqDrxG55/AfOzeV8hebde2afFCJE=;
 b=bswwKqQPm0cjWUsQnctO4V6fu64S25NeZsVUJ9T+PL/mZH24oWInonFy8TaliAkr/Ah6Jx4vFJqX+Ces6WHj3BGxwndIrE1Vdwnw+szIVPCjlKaKnGkQsFKOGEqEQJ5cMTgkTf1AdmDxOTLAvQOrf0sV71NKjL5rPzwbv8s2q0VyFXEdr3NLnwkGyVieduLrftsWQvJCqYRaGKunEtQx1qyZI/5ftz+AUBZVGfRX1xbkn6UZnCdR6kumIERB6Q5YFIb0dsW9/neitf+OeornS1V3q6cQ6ctx+bxdPto5rEzCe944WyUm8Wda7288WeBhrrE1wkqWEDomDLtrg6Z9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGPcUiRJ0CW6YzTZqDrxG55/AfOzeV8hebde2afFCJE=;
 b=nYb2JpgPG0nFsj9yqi+Jfi8err0UaPcEETbzHEe73UMWatudAlzfoIXisgzNVLWFI0j/DnosM/gkd4AefQ0eroNSl2vO68J+yM14jgXkHD/kviN6LApHl/PNSt12vCh4CU6XcJSj2+VHTa4FChkuYnc0BkZeUa8Ikk8wXDfN3aA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4150.eurprd04.prod.outlook.com (2603:10a6:209:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 02:49:51 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:49:51 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] dt-bindings: timer: Convert i.MX TPM to json-schema
Thread-Topic: [PATCH 2/3] dt-bindings: timer: Convert i.MX TPM to json-schema
Thread-Index: AQHWLSSm2/1WAPgK0U6sOtqNceGFLKiutSNw
Date:   Tue, 19 May 2020 02:49:51 +0000
Message-ID: <AM6PR04MB49661ACB965C762C30E39AF680B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
 <1589813260-20036-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589813260-20036-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b88891f4-4c89-4cf9-dfe5-08d7fb9f4d7a
x-ms-traffictypediagnostic: AM6PR04MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4150294BE7DED975CDDE358580B90@AM6PR04MB4150.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89f/1xmP6O9Jh7KIR+4XMYPSMo0jN6YnPIElHXRAM46anK1yMgNZUpI6ZpQXjbrY2Ja3SvR/7y1lWq4JEoDw5CBaBVOkgYfF7nOyxtLmMCyWsZYAmw3RQ1L53ssCgEUeMd53W9xBFIhfmrrQDdBrKHzkH71gHY+HdtsPGAOu0jw5Aa5J4ERdHRHXZBlSsKB+HiDzGRDJJjdm1LFvErD7uGxIg+g+Udl9ozzbPpEuY28mrStenhewH8MWwfgGZx6CHisrMYYIP24EMAb+1WoQG9Iddxme9qLP+RmNeIkUhKnTHBzVN1jgtdv/Y+5QJIXjrMkj2pNnp6m7A/Zz7gHvwGUt+SknZ3D0iQgcwBUP2G9I8Pg8d5PsmyDvFyWuL+Rhq/T2bjsee+W/CdTAX8Di5zpC7IXgNWb72XvLzkVb/N4QynKiqn7iMdiDDzGthEZJ9iAnPsYwUsD+vrh4HRu7kly1beFQ05yvCrikNvE59zw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(5660300002)(26005)(71200400001)(186003)(7696005)(8936002)(44832011)(55016002)(33656002)(76116006)(66556008)(66476007)(66946007)(2906002)(52536014)(7416002)(86362001)(316002)(66446008)(110136005)(4326008)(6506007)(478600001)(8676002)(64756008)(9686003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NoVWvZHtUvRY7Y29COiIdGOTAQJPwKO0WlY0407/wFITZdf5LJdr5kTx33cpxhWw1h0e/ZAfhrV4eK1Z0t+cYB5LqJC1a2//0lHcL/pZ1xEOHXDPSPrDASC6Fhl5rf5ANWE+gzVmmk6IA9iEBYyyz7itV+nqFZxUO0I8HYWBJykvfGH6DhJZJBiSzTHR+KrPpnJPGYJ02yNEcdLaqX3naa5h/ToUyJorNpSLZSszpfLp+xG8WXnnkA5xhQtdTm4E5O+27FCCUBI4LA2OJsdFud7nMKY1FRbJU5WAIl7r0Fx4YTIuP+uop+UbI2ntGFKqzpGi2VgsqifsZt96jkO/8I6KYQ9G53UvkfZRBLXQoNe9MKvAHmUZwquOr6P+K7PAdE3gdOwrQUgIjqzBMAxh/A9irGqWZ2CNCy9OuIO62INT/g5+didUCF5OYH8nxv9V3Jui8ag9fDUvjyv5hsn8YrfRJih8Qv5dxhHebfCujwYOnHFGjpR0T9IKBXGpU0wW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88891f4-4c89-4cf9-dfe5-08d7fb9f4d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:49:51.2935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukTilocx3wR/E2PTV/3M9gRjsyuIZz6BwHnWLqsqF4uqdhGuyTloe3oqomxMNbR3IYVeQMrpkz9P+GZsMEntEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgMTA6NDggUE0NCj4gDQo+IENvbnZlcnQgdGhlIGkuTVggVFBNIGJpbmRp
bmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL254cCx0cG0tdGltZXIudHh0ICAgIHwgMjggLS0tLS0t
LS0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnhwLHRwbS10aW1lci55YW1s
ICAgfCA2Mw0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYz
IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUgMTAwNjQ0DQo+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9ueHAsdHBtLXRpbWVyLnR4dA0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy90aW1lci9ueHAsdHBtLXRpbWVyLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnhwLHRwbS10aW1lci50eHQNCj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnhwLHRwbS10aW1lci50eHQNCj4g
ZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IGY4MjA4N2IuLjAwMDAwMDANCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL254cCx0cG0tdGltZXIu
dHh0DQo+ICsrKyAvZGV2L251bGwNCj4gQEAgLTEsMjggKzAsMCBAQA0KPiAtTlhQIExvdyBQb3dl
ciBUaW1lci9QdWxzZSBXaWR0aCBNb2R1bGF0aW9uIE1vZHVsZSAoVFBNKQ0KPiAtDQo+IC1UaGUg
VGltZXIvUFdNIE1vZHVsZSAoVFBNKSBzdXBwb3J0cyBpbnB1dCBjYXB0dXJlLCBvdXRwdXQgY29t
cGFyZSwgLWFuZA0KPiB0aGUgZ2VuZXJhdGlvbiBvZiBQV00gc2lnbmFscyB0byBjb250cm9sIGVs
ZWN0cmljIG1vdG9yIGFuZCBwb3dlcg0KPiAtbWFuYWdlbWVudCBhcHBsaWNhdGlvbnMuIFRoZSBj
b3VudGVyLCBjb21wYXJlIGFuZCBjYXB0dXJlIHJlZ2lzdGVycyAtYXJlDQo+IGNsb2NrZWQgYnkg
YW4gYXN5bmNocm9ub3VzIGNsb2NrIHRoYXQgY2FuIHJlbWFpbiBlbmFibGVkIGluIGxvdyAtcG93
ZXIgbW9kZXMuDQo+IFRQTSBjYW4gc3VwcG9ydCBnbG9iYWwgY291bnRlciBidXMgd2hlcmUgb25l
IFRQTSBkcml2ZXMgLXRoZSBjb3VudGVyIGJ1cyBmb3INCj4gdGhlIG90aGVycywgcHJvdmlkZWQg
Yml0IHdpZHRoIGlzIHRoZSBzYW1lLg0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAt
DQo+IC0tIGNvbXBhdGlibGUgOglzaG91bGQgYmUgImZzbCxpbXg3dWxwLXRwbSINCj4gLS0gcmVn
IDoJCVNwZWNpZmllcyBiYXNlIHBoeXNpY2FsIGFkZHJlc3MgYW5kIHNpemUgb2YgdGhlIHJlZ2lz
dGVyIHNldHMNCj4gLQkJZm9yIHRoZSBjbG9jayBldmVudCBkZXZpY2UgYW5kIGNsb2NrIHNvdXJj
ZSBkZXZpY2UuDQo+IC0tIGludGVycnVwdHMgOglTaG91bGQgYmUgdGhlIGNsb2NrIGV2ZW50IGRl
dmljZSBpbnRlcnJ1cHQuDQo+IC0tIGNsb2NrcyA6CVRoZSBjbG9ja3MgcHJvdmlkZWQgYnkgdGhl
IFNvQyB0byBkcml2ZSB0aGUgdGltZXIsIG11c3QgY29udGFpbg0KPiAtCQlhbiBlbnRyeSBmb3Ig
ZWFjaCBlbnRyeSBpbiBjbG9jay1uYW1lcy4NCj4gLS0gY2xvY2stbmFtZXMgOiBNdXN0IGluY2x1
ZGUgdGhlIGZvbGxvd2luZyBlbnRyaWVzOiAiaXBnIiBhbmQgInBlciIuDQo+IC0NCj4gLUV4YW1w
bGU6DQo+IC10cG01OiB0cG1ANDAyNjAwMDAgew0KPiAtCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1
bHAtdHBtIjsNCj4gLQlyZWcgPSA8MHg0MDI2MDAwMCAweDEwMDA+Ow0KPiAtCWludGVycnVwdHMg
PSA8R0lDX1NQSSAyMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gLQljbG9ja3MgPSA8JmNsa3Mg
SU1YN1VMUF9DTEtfTklDMV9CVVNfRElWPiwNCj4gLQkJIDwmY2xrcyBJTVg3VUxQX0NMS19MUFRQ
TTU+Ow0KPiAtCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KPiAtfTsNCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9ueHAsdHBtLXRpbWVy
LnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnhwLHRw
bS10aW1lci55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAuLjBk
MzQ2MTANCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdGltZXIvbnhwLHRwbS10aW1lci55YW1sDQo+IEBAIC0wLDAgKzEsNjMgQEANCj4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNl
KSAlWUFNTCAxLjINCg0KWy4uLl0NCg0KPiArDQo+ICt0aXRsZTogTlhQIExvdyBQb3dlciBUaW1l
ci9QdWxzZSBXaWR0aCBNb2R1bGF0aW9uIE1vZHVsZSAoVFBNKQ0KPiArDQo+ICttYWludGFpbmVy
czoNCj4gKyAgLSBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiArDQo+ICtk
ZXNjcmlwdGlvbjogfA0KPiArICBUaGUgVGltZXIvUFdNIE1vZHVsZSAoVFBNKSBzdXBwb3J0cyBp
bnB1dCBjYXB0dXJlLCBvdXRwdXQgY29tcGFyZSwNCj4gKyAgYW5kIHRoZSBnZW5lcmF0aW9uIG9m
IFBXTSBzaWduYWxzIHRvIGNvbnRyb2wgZWxlY3RyaWMgbW90b3IgYW5kIHBvd2VyDQo+ICsgIG1h
bmFnZW1lbnQgYXBwbGljYXRpb25zLiBUaGUgY291bnRlciwgY29tcGFyZSBhbmQgY2FwdHVyZSBy
ZWdpc3RlcnMNCj4gKyAgYXJlIGNsb2NrZWQgYnkgYW4gYXN5bmNocm9ub3VzIGNsb2NrIHRoYXQg
Y2FuIHJlbWFpbiBlbmFibGVkIGluIGxvdw0KPiArICBwb3dlciBtb2Rlcy4gVFBNIGNhbiBzdXBw
b3J0IGdsb2JhbCBjb3VudGVyIGJ1cyB3aGVyZSBvbmUgVFBNIGRyaXZlcw0KPiArICB0aGUgY291
bnRlciBidXMgZm9yIHRoZSBvdGhlcnMsIHByb3ZpZGVkIGJpdCB3aWR0aCBpcyB0aGUgc2FtZS4N
Cj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBjb25zdDogZnNs
LGlteDd1bHAtdHBtDQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4g
KyAgaW50ZXJydXB0czoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGNsb2NrczoNCj4g
KyAgICBpdGVtczoNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IFNvQyBUUE0gaXBnIGNsb2NrDQo+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBTb0MgVFBNIHBlciBjbG9jaw0KDQo+ICsgICAgbWF4SXRl
bXM6IDINCg0KVW5uZWVkZWQgbGluZQ0KDQo+ICsNCj4gKyAgY2xvY2stbmFtZXM6DQo+ICsgICAg
aXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBpcGcNCj4gKyAgICAgIC0gY29uc3Q6IHBlcg0KDQo+
ICsgICAgbWF4SXRlbXM6IDINCg0KRGl0dG8NCg0KT3RoZXJ3aXNlOg0KDQpSZXZpZXdlZC1ieTog
RG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
DQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcNCj4gKyAg
LSBpbnRlcnJ1cHRzDQo+ICsgIC0gY2xvY2tzDQo+ICsgIC0gY2xvY2stbmFtZXMNCj4gKw0KPiAr
YWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwN
Cj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14N3VscC1jbG9jay5oPg0KPiAr
ICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+
DQo+ICsNCj4gKyAgICB0aW1lckA0MDI2MDAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
ZnNsLGlteDd1bHAtdHBtIjsNCj4gKyAgICAgICAgcmVnID0gPDB4NDAyNjAwMDAgMHgxMDAwPjsN
Cj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyIElSUV9UWVBFX0xFVkVMX0hJR0g+
Ow0KPiArICAgICAgICBjbG9ja3MgPSA8JnNjZzEgSU1YN1VMUF9DTEtfTklDMV9CVVNfRElWPiwN
Cj4gKyAgICAgICAgICAgICAgICAgPCZwY2MyIElNWDdVTFBfQ0xLX0xQVFBNNT47DQo+ICsgICAg
ICAgIGNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KPiArICAgIH07DQo+IC0tDQo+IDIuNy40
DQoNCg==
