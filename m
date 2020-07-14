Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0809EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D088F2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="tJLkF0WS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGNIsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:48:16 -0400
Received: from mail-eopbgr1320084.outbound.protection.outlook.com ([40.107.132.84]:39744
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbgGNIsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:48:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSCptF2BKRG3O6pJ2lWwW3QxkbYauE3kPi0O20WaruHHX0xL6MZ+8kf7HRuQzM5U06ZOhQJgc4xC7OISo7OEOWplHIBT1s5r57Sf3kxBooBnWgSYM5FAZGk3eY/23ezbE8fpNOSvNlbpHzMfns3IxqzJKDP+GOWDFObT20hLFbBkGFk1xzYvHIZkv+1bAjwoVuZ1Xg8MasILPeS8eRp0wlfzq6eNh2tS0jCL0FYcezbxKRUd7T+AP5ow3591C29s033wdPURBwze4AgrHwuc9mjXGfxJ4gr5IPx+SY49RQB1b3odrUK2QiF6L42sCjqABlok/LCX8JbkjSLBxt4lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9womYDkAceixYuJBocJoOyNFw9IijhIu7n8PyY1VRW0=;
 b=nWr1BfKMYsMyznzFpT9yJ4BbfZHDe3tHSpCdWsLJXFUYLqMCmF9mGVFQeVpfvo46VcA/hwPCraBSKzhi77th7o7tMZxoCByRyHACMy3b+yWEKklhXvyU0Et/mXptaCffn45Ft39VEC85jHrnfTHWqeY5awif3Zq86i4FX0Z3md1j4Pv/hvr3rmo5cRK9Vk0RCbUG4ljMysoUP15HYvUAos7fwgd9H5cy/bs5A0qDZB25X/Xn8rRE0xMAAWddWb2gwED4rzN8E1Fja+mKO+jlf9ss3osx1zgfcdVHXIc4DU5mDhjZWf3qZDHJL1sfXEK74FDyfbVA89TU7iZrvBvopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9womYDkAceixYuJBocJoOyNFw9IijhIu7n8PyY1VRW0=;
 b=tJLkF0WSCw8BDz8d8QAzDNzif0+U281CQuMeLE1vDjvZ5aHlUjc9rP7tFrAEUwcw+i3PbV6AEA80jCMl1WjK1iedEyrMv6s1sYiXj45Ufec0uOkdowDFeeRYyuznSNOTm39nhsDcubo+40gBC2fmGKM1e8CrtYJBlJbcmeGSRV0=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HKAPR02MB4385.apcprd02.prod.outlook.com (2603:1096:203:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 08:48:11 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2%8]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:48:11 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     Will Deacon <will@kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Topic: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Index: AdZZu3XFug5WrkWdRjKyv3mGtucKKQ==
Date:   Tue, 14 Jul 2020 08:48:11 +0000
Message-ID: <HKAPR02MB4291648701A6803290A17299E0610@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.255.79.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfd2ca1e-9421-47c4-e5f5-08d827d2a380
x-ms-traffictypediagnostic: HKAPR02MB4385:
x-microsoft-antispam-prvs: <HKAPR02MB43859A0BBEECCA9C8D85D5C8E0610@HKAPR02MB4385.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +D3cGMCRi8foQQt+XVlammhwrtRcOT+Y1nxWSjWhNLsdm0FmKyaN7el2uqKeHko2Hv07Itqewt/DHfaB68GBg+W514Rx5DllXHJjlinYFKR3wrIVWQ5rfTxBmI5TyqyGTHGoDqYGG4Aqpslb7cN0odr/V0V96F49m/Al6lYeQ4Ugm3evHlfl6xnqKG7QGufKnuk7IZyJxXVMJSeel8EGiTR8Ejbl1SRt8dI4Da9ZXmnyzjS52ust4l/B9JvZWGl+pR0uj02Kb+z6QVX16+87R8kno3cID6Dj6fz2rGAWJmyhy3xt/ew8pM7ptmU7m3H84HbYhk+q0ze2OVUuYYr16rsztoJ2oHZNlLhGOjtmCTmJfw7OAOi777ppiYjtcS4A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(366004)(346002)(376002)(186003)(55016002)(2906002)(33656002)(5660300002)(52536014)(7696005)(66446008)(76116006)(8676002)(66946007)(54906003)(64756008)(26005)(9686003)(66556008)(71200400001)(86362001)(66476007)(6506007)(6916009)(8936002)(478600001)(85182001)(4326008)(83380400001)(316002)(11606004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: d0owv5cDsraZwYhl512+kPmHas70l3QGpxtcgriIRjcyV5kCNf/72iL+rkIkJF5B6mvc2+rJVyzbAOEWE2/Kx8MAQxe07KnO6g7o7GAHrRRqc+8bWpzeAJOupJ//eLjkdTNkKr1RcKsR1AvlIK5fHx1CbiG53Scpic+k7vhNl32LTYLj8dQQc9Tkr0BjtMjtFfMf0DsVaNvkS1Vs6y9prZ2vWWi8eFhgf5mDVb4lODkMUKidmIo/M4RrqFDdkD3WdzDQkqObFlVS1kcWmD/uSh57FpTLOiQ8ddtmD1eOxqGYj8mMIYDEfvUDa39lGaspiW9om49IwAQMk6mSRHkuhfY7RpGTw2+cvncw4SLS07t0IhOJgAe0fCUKCi+LYpwZHxot+0ynco8Pgjpyy4zbhpfCtO+SBecTfhkJtVxUBP+ydchVt233HBuVwI/rTpI9QdTl40cyzxpQ/YIhaCshr4FX/3z22tA3851SzUomu6M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd2ca1e-9421-47c4-e5f5-08d827d2a380
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 08:48:11.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+OzG31vTym3Dso/xRzwjhnOOmu3J/E5T7H7s5FT7PYWKdQw/G/ka8CsWxTjCFTgo2ss+AE9vO2Zc19FdpCrVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdWwgMDksIDIwMjAgYXQgMDc6MTg6MDFBTSArMDAwMCxQZW5nIEhhbyhSaWNoYXJk
KSB3cm90ZToNCj4gT24gVGh1LCA5IEp1bCAyMDIwIGF0IDA5OjUwLCBQZW5nIEhhbyhSaWNoYXJk
KSA8cmljaGFyZC5wZW5nQG9wcG8uY29tPiB3cm90ZToNCj4gPj4gPkFwcGFyZW50bHksIHlvdSBh
cmUgaGl0dGluZyBhIFJfQUFSQ0g2NF9KVU1QMjYgb3IgUl9BQVJDSDY0X0NBTEwyNg0KPiA+PiA+
cmVsb2NhdGlvbiB0aGF0IG9wZXJhdGVzIG9uIGEgYiBvciBibCBpbnN0cnVjdGlvbiB0aGF0IGlz
IG1vcmUgdGhhbg0KPiA+PiA+MTI4IG1lZ2FieXRlcyBhd2F5IGZyb20gaXRzIHRhcmdldC4NCj4g
Pj4gPg0KPiA+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYSBtb2R1bGUgdGhhdCBjYWxscyBm
dW5jdGlvbnMgdGhhdCBhcmUgbm90IHBhcnQgb2YgdGhlIG1vZHVsZSB3aWxsIHVzZSBQTFQuDQo+
ID4+IFBsdF9tYXhfZW50cmllcyA9MCBNYXkgb2NjdXIgaWYgYSBtb2R1bGUgZG9lcyBub3QgZGVw
ZW5kIG9uIG90aGVyIG1vZHVsZSBmdW5jdGlvbnMuDQo+ID4+DQo+ID4NCj4gPkEgUExUIHNsb3Qg
aXMgYWxsb2NhdGVkIGZvciBlYWNoIGIgb3IgYmwgaW5zdHJ1Y3Rpb24gdGhhdCByZWZlcnMgdG8g
YQ0KPiA+c3ltYm9sIHRoYXQgbGl2ZXMgaW4gYSBkaWZmZXJlbnQgc2VjdGlvbiwgZWl0aGVyIG9m
IHRoZSBzYW1lIG1vZHVsZQ0KPiA+IChlLmcuLCBibCBpbiAuaW5pdCBjYWxsaW5nIGludG8gLnRl
eHQpLCBvZiBhbm90aGVyIG1vZHVsZSwgb3Igb2YgdGhlDQo+ID5jb3JlIGtlcm5lbC4NCj4gPg0K
PiA+SSBkb24ndCBzZWUgaG93IHlvdSBlbmQgdXAgd2l0aCBwbHRfbWF4X2VudHJpZXMgaW4gdGhp
cyBjYXNlLCB0aG91Z2guDQo+IGlmIGEgbW9kdWxlIGRvZXMgbm90IGRlcGVuZCBvbiBvdGhlciBt
b2R1bGUgZnVuY3Rpb25zLCBQTFQgZW50cmllcyBpbiB0aGUgbW9kdWxlIGlzIGVxdWFsIHRvIDAu
DQoNCj5UaGlzIGJyaW5ncyBtZSBiYWNrIHRvIG15IGVhcmxpZXIgcXVlc3Rpb246IGlmIHRoZXJl
IGFyZSBubyBQTFQgZW50cmllcyBpbg0KPnRoZSBtb2R1bGUsIHRoZW4gY291bnRfcGx0cygpIHdp
bGwgbm90IGZpbmQgYW55IFJfQUFSQ0g2NF9KVU1QMjYgb3INCj5SX0FBUkNINjRfQ0FMTDI2IHJl
bG9jYXRpb25zIHRoYXQgcmVxdWlyZSBQTFRzIGFuZCB3aWxsIHRoZXJlZm9yZSByZXR1cm4gMC4N
Cj5UaGUgYWJzZW5jZSBvZiB0aGVzZSByZWxvY2F0aW9ucyBtZWFucyB0aGF0IG1vZHVsZV9lbWl0
X3BsdF9lbnRyeSgpIHdpbGwgbm90DQo+YmUgY2FsbGVkIGJ5IGFwcGx5X3JlbG9jYXRlX2FkZCgp
LCBhbmQgc28geW91ciBwYXRjaCBzaG91bGQgaGF2ZSBubyBlZmZlY3QuDQoxLlRoZSBtb2R1bGUg
aW4gcXVlc3Rpb24gaXMgdGhlIGNhbGxpbmcgZnVuY3Rpb24gZnJvbSBjb3JlIGtlcm5lbC4oIEli
X2NvcmUua28gdHJpZ2dlcmVkIHRoZSB3YXJuaW5nIG11bHRpcGxlIHRpbWVzKS4NCjIuIFRoZXJl
IGFyZSBtdWx0aXBsZSB0aHJlYWRzIGxvYWRpbmcgSUJfY29yZS5rbw0KWyAgIDczLjM4ODkzMV0g
ICMjI2NwdT0zMywgbmFtZT1pYl9jb3JlLCBjb3JlX3BsdHM9MCwgaW5pdF9wbHRzPTAgIA0KWyAg
IDczLjQwMjEwMl0gICMjIyMgY3B1PTMzLHBpZD0yMjk3LG5hbWU9aWJfY29yZSwgbW9kdWxlX2Vt
aXRfcGx0X2VudHJ5OnBsdF9udW1fZW50cmllcz0xLCBwbHRfbWF4X2VudHJpZXM9MCAod2Fybmlu
ZykNClsgICA3My40MzkzOTFdICAjIyNjcHU9MjQsIG5hbWU9aWJfY29yZSwgY29yZV9wbHRzPTAs
IGluaXRfcGx0cz0wICANClsgICA3My40NDg2MTddICAjIyNjcHU9NCwgbmFtZT1pYl9jb3JlLCBj
b3JlX3BsdHM9MCwgaW5pdF9wbHRzPTAgIA0KWyAgIDczLjU0NzUzNV0gICMjI2NwdT0yMjEsIG5h
bWU9aWJfY29yZSwgY29yZV9wbHRzPTAsIGluaXRfcGx0cz0wICANClsgICA3NS4xOTgwNzVdICAj
IyMjIGNwdT0yNCxwaWQ9MjMzNixuYW1lPWliX2NvcmUsIG1vZHVsZV9lbWl0X3BsdF9lbnRyeTpw
bHRfbnVtX2VudHJpZXM9MSwgcGx0X21heF9lbnRyaWVzPTAgKHdhcm5pbmcpDQpbICAgNzUuNDg5
NDk2XSAgIyMjIyBjcHU9NCxwaWQ9MjM0NCxuYW1lPWliX2NvcmUsIG1vZHVsZV9lbWl0X3BsdF9l
bnRyeTpwbHRfbnVtX2VudHJpZXM9MSwgcGx0X21heF9lbnRyaWVzPTAod2FybmluZykNCg0KSSBk
b24ndCB1bmRlcnN0YW5kIHdoeSBjb3VudF9wbHRzIHJldHVybnMgMCB3aGVuIENPTkZJR19SQU5E
T01JWkVfQkFTRT1uIGZvciBSX0FBUkNINjRfSlVNUDI2IGFuZCBSX0FBUkNINjRfQ0FMTDI2Lg0K
DQozLiBTZXQgQ09ORklHX0FSTTY0X01PRFVMRV9QTFRTPXkgYW5kIHJlc3RhcnQgdGhlIHNlcnZl
ciBzZXZlcmFsIHRpbWVzIHdpdGhvdXQgdHJpZ2dlcmluZyB0aGlzIHdhcm5pbmcuDQoNCg0K
