Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CCAC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5650B24695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=camlinlimited.onmicrosoft.com header.i=@camlinlimited.onmicrosoft.com header.b="csozP72R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgB0Mjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:39:39 -0500
Received: from mail-eopbgr100048.outbound.protection.outlook.com ([40.107.10.48]:45834
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728977AbgB0Mji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:39:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx/p9JhwWO+Jj9bOi0IhQGTv2WPawGOojRkNxTRZjy1S/d3SWSfT8fA//mb5RpK48ezfxDblLzqCNJqJ8gMfVea9Ow9r1cbRbFZYnuWQ6vgBDKJzuovQwuYSYqJ8T5tum5kcAorAQQoaoFBrJ7FvSCIB2gq3ECHpyyhnz0xQXFiXmwQwJWfuSqkoakXm9o/P3IWqS1W4Hydibu8IQm/yjXKgpGMu/7v5oqC0fDQALZQTXVm1Qn98Xm1Us/xj9KBOs/eCqHEEPSNU96xAjY4RbB0E0xyKZlaDjDPxVK/XYUPpDjd7h75Ok4yjUJbddquHst0rmlLNYVGtuD0/BIsjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz7pu0P30E1VYlon+AJ7SwRga23t4g0R2tuHLcd+ep4=;
 b=O17/V6SJkODmpNDe7iqECP00L6SvoO9OyA9vtpE2OLabVYXgSlT9znRjc70ri8OfzFtarh6FtyU83pVLk9Jd72Nc/OqSoUez/pCejs6gh6fsiYV+DpBxCBb7hBceZ9c8E91AWz+Fyknu6hOztpCrF59ETg+k3JWN1CTAf2gKfDdrx4JNBvzIIxf5CIQt2yYt5W59plaZgD7cSrp+H/CXNFgFqy5818GuUmnCgXzs8AHcx+JHvukPtl367g2dsH+ep8bl7mguajLEYG53EgkIEfz9T733vL/hMLOn6B4KyKRtL9YeQhKiuoeexyluRwVJvozSOIbn+rXCj3GSUcsvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=camlintechnologies.com; dmarc=pass action=none
 header.from=camlintechnologies.com; dkim=pass
 header.d=camlintechnologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=camlinlimited.onmicrosoft.com; s=selector2-camlinlimited-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz7pu0P30E1VYlon+AJ7SwRga23t4g0R2tuHLcd+ep4=;
 b=csozP72RetIqa00+yKOaABiaqCaSGCwc3meYI01mGVTU5jL2/UBlw2jG/ri/79LUcU9WDgro6IqL1oFDW6zGqmtkhgCvjH7POXBkZeh9fMcWvw4Bu2HC/5iSlO85pXt/ZRCeJvzXYRnYvzxw5+b3Yg0dQ3VRqw7E1AZY15UYIzI=
Received: from CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM (20.176.61.151) by
 CWLP123MB1985.GBRP123.PROD.OUTLOOK.COM (20.176.61.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Thu, 27 Feb 2020 12:39:34 +0000
Received: from CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 ([fe80::fc9c:3a7e:f857:3c78]) by CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 ([fe80::fc9c:3a7e:f857:3c78%3]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 12:39:34 +0000
Received: from [192.168.10.194] (95.143.242.242) by AM3PR05CA0145.eurprd05.prod.outlook.com (2603:10a6:207:3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 12:39:33 +0000
From:   Lech Perczak <l.perczak@camlintechnologies.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?S3J6eXN6dG9mIERyb2JpxYRza2k=?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Thread-Topic: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Thread-Index: AQHV7V5t8S4uzrFtj0WCWsMdVjN9Yqgu+liAgAAA1gA=
Date:   Thu, 27 Feb 2020 12:39:34 +0000
Message-ID: <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
 <20200227123633.GB962932@kroah.com>
In-Reply-To: <20200227123633.GB962932@kroah.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:207:3::23) To CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:6d::23)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=l.perczak@camlintechnologies.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [95.143.242.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 171e1b91-5d05-49be-62f2-08d7bb821927
x-ms-traffictypediagnostic: CWLP123MB1985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP123MB1985572B120051450366E4A187EB0@CWLP123MB1985.GBRP123.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39850400004)(396003)(366004)(189003)(199004)(86362001)(66946007)(956004)(66446008)(186003)(8676002)(16526019)(2616005)(4326008)(107886003)(5660300002)(31696002)(54906003)(66556008)(31686004)(81156014)(81166006)(71200400001)(64756008)(8936002)(66476007)(26005)(2906002)(478600001)(6486002)(6916009)(36756003)(52116002)(16576012)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CWLP123MB1985;H:CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: camlintechnologies.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eRA8p8Ummp1OQH8ImfZoWRyleCIKYdRTilL/cE+Yn4klNLby05cbq8cNDwfUGeQ0nIzu5zXtEnAOBcBz+z6jl8WiN1ZYUpqTTjKqUcEST+b3AQbIljLpdzIZL+3ZoycMTsvGQ/5cZegPAkyyB7P9xXAMLG2h6mGb09jGUl4ZE3sXYM1in2p0hcqULxB5TcHEOxherf9USrBGmom0piKTpbW0zmUZWEg9lJ3efasRUxZarFcwwELOZ/aBbEgoSDCMrjO7BpCfP45w5nlNYa0Gp/9t1OXC72HKnZVncJTclfc9VdTajT+rRSnJIkLFjIs/l0b1x1Z2mLidV1H1+d125Ry9eloD3aZD151CHuC0ygfjPWCS3YAR/KGq+DEvvupFzjBTCrFAzV5sqAIbJwpTCCV1Ao9+XHq8faTD+K8X5MwDUISBsrde59cQABksZ9I
x-ms-exchange-antispam-messagedata: s+I55ZIVi2RngOzKwxx+7AJ1UdZo4zdJBIDtV9jWfwWSUT8InxZET5OeL7Z6n+DHHQzn+82gmB1gOQKDo/L2OA3OxXurGHN5KzNz5VwYrxqb2j7zsLubUQQEJuUZjUu9MZcroMbtI8tIZH0nZbna+g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E88F003A07A93D48B93588EFE564021E@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: camlintechnologies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171e1b91-5d05-49be-62f2-08d7bb821927
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 12:39:34.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7oYJLIu/Y1qAmkIe8uywZqBxBJ5DkySlyZfgNRuLOUDS6bNcEvqHqb1h0lztGbv8j3m8X+hV5eTo5mMI60/quu2dlCLYWlLVHzXaFzOskzr7TIy2mD1jG/wDrhBUxnzt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB1985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VyBkbml1IDI3LjAyLjIwMjAgb8KgMTM6MzYsIEdyZWcgS3JvYWgtSGFydG1hbiBwaXN6ZToNCj4g
T24gVGh1LCBGZWIgMjcsIDIwMjAgYXQgMTE6MDk6NDlBTSArMDAwMCwgTGVjaCBQZXJjemFrIHdy
b3RlOg0KPj4gSGVsbG8sDQo+Pg0KPj4gQWZ0ZXIgdXBncmFkaW5nIGtlcm5lbCBvbiBvdXIgYm9h
cmRzIGZyb20gdjQuMTkuMTA1IHRvIHY0LjE5LjEwNiB3ZSBmb3VuZCBvdXQgdGhhdCBzeXNsb2cg
ZmFpbHMgdG8gcmVhZCB0aGUgbWVzc2FnZXMgYWZ0ZXIgb25lcyByZWFkIGluaXRpYWxseSBhZnRl
ciBvcGVuaW5nIC9wcm9jL2ttc2cganVzdCBhZnRlciBib290aW5nLg0KPj4gSSBhbHNvIGZvdW5k
IG91dCwgdGhhdCBvdXRwdXQgb2YgJ2RtZXNnIC0tZm9sbG93JyBhbHNvIGRvZXNuJ3QgcmVhY3Qg
b24gbmV3IHByaW50a3MgYXBwZWFyaW5nIGZvciB3aGF0ZXZlciByZWFzb24gLSB0byByZWFkIG5l
dyBtZXNzYWdlcywgcmVvcGVuaW5nIC9wcm9jL2ttc2cgb3IgL2Rldi9rbXNnIHdhcyBuZWVkZWQu
DQo+PiBJIGJpc2VjdGVkIHRoaXMgZG93biB0byBjb21taXQgMTUzNDFiMWRkNDA5NzQ5ZmE1NjI1
ZTRiNjMyMDEzYjZiYTgxNjA5YiAoImNoYXIvcmFuZG9tOiBzaWxlbmNlIGEgbG9ja2RlcCBzcGxh
dCB3aXRoIHByaW50aygpIiksIGFuZCByZXZlcnRpbmcgaXQgb24gdG9wIG9mIHY0LjE5LjEwNiBy
ZXN0b3JlZCBjb3JyZWN0IGJlaGF2aW91ci4NCj4gVGhhdCBpcyByZWFsbHkgcmVhbGx5IG9kZC4N
ClZlcnkgb2RkIGl0IGlzIGluZGVlZC4NCj4NCj4+IE15IHRlc3Qgc2NlbmFyaW8gZm9yIGJpc2Vj
dGluZyB3YXM6DQo+PiAxLiBydW4gJ2RtZXNnIC0tZm9sbG93JyBhcyByb290DQo+PiAyLiBydW4g
J2VjaG8gdCA+IC9wcm9jL3N5c3JxLXRyaWdnZXInDQo+PiAzLiBJZiB0cmFjZSBhcHBlYXJzIGlu
IGRtZXNnIG91dHB1dCAtPiBnb29kLCBvdGhlcndpc2UsIGJhZC4gSWYgdHJhY2UgZG9lc24ndCBh
cHBlYXIgaW4gb3V0cHV0IG9mICdkbWVzZyAtLWZvbGxvdycsIHJlLXJ1bm5pbmcgaXQgd2lsbCBz
aG93IHRoZSB0cmFjZS4NCj4+DQo+PiBJIHJhbiBteSB0ZXN0cyBvbiBEZWJpYW4gMTAuMyB3aXRo
IGNvbmZpZ3VyYXRpb24gYmFzZWQgZGlyZWN0bHkgb24gb25lIGZyb20gNC4xOS4wLTgtYW1kNjQg
KDQuMTkuOTgtMSkgaW4gUWVtdS4NCj4+IEkgY291bGQgcmVwcm9kdWNlIHRoZSBzYW1lIGlzc3Vl
IG9uIHNldmVyYWwgYm9hcmRzIHdpdGggeDg2IGFuZCBBUk12NyBDUFVzIGFsaWtlLCB3aXRoIDEw
MCUgcmVwcm9kdWNpYmlsaXR5Lg0KPj4NCj4+IEkgaGF2ZW4ndCB5ZXQgZGlnZ2VkIGludG8gd2h5
IGV4YWN0bHkgdGhpcyBjb21taXQgYnJlYWtzIG5vdGlmaWNhdGlvbnMgZm9yIHJlYWRlcnMgb2Yg
L3Byb2Mva21zZyBhbmQgL2Rldi9rbXNnLCBidXQgYXMgcmV2ZXJ0aW5nIGl0IGZpeGVkIHRoZSBp
c3N1ZSwgSSdtIHByZXR0eSBzdXJlIHRoaXMgaXMgdGhlIG9uZS4gSXQgaXMgcG9zc2libGUgdGhh
dCB0aGUgc2FtZSBoYXBwZW5lZCBpbiA1LjQgbGluZSwgYnUgSSBoYWRuJ3QgaGFkIGEgY2hhbmNl
IHRvIHRlc3QgdGhpcyBhcyB3ZWxsIHlldC4NCj4gSSBjYW4gcmV2ZXJ0IHRoaXMsIGJ1dCBpdCBm
ZWVscyBsaWtlIHRoZXJlIGlzIHNvbWV0aGluZyBlbHNlIGdvaW5nIHdyb25nDQo+IGhlcmUuICBD
YW4geW91IHRyeSB0aGUgNS40IHRyZWUgdG8gc2VlIGlmIHRoYXQgdG9vIGhhcyB5b3VyIHNhbWUN
Cj4gcHJvYmxlbT8NClllcywgSSdsbCBjaGVjayBpdCBpbiBhIHNob3J0IHdoaWxlLg0KPg0KPiB0
aGFua3MsDQo+DQo+IGdyZWcgay1oDQoNCi0tIA0KUG96ZHJhd2lhbS9XaXRoIGtpbmQgcmVnYXJk
cywNCkxlY2ggUGVyY3phaw0KDQpTci4gU29mdHdhcmUgRW5naW5lZXINCkNhbWxpbiBUZWNobm9s
b2dpZXMgUG9sYW5kIExpbWl0ZWQgU3AuIHogby5vLg0KDQo=
