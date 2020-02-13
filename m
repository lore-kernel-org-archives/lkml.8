Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DAEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0CF20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="i1mH3UpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgBMJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:01:25 -0500
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:11713
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgBMJBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:01:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5GrJ/SgXo7jzwDK2BR0v/kYi9CckO7b8Os7nYrOKCoFD/L3yiYLaiQlrkvZCjX8CneD4NJWH/1twM06gJ2W22zGAGX59DgCnKQH09vu4n54UxA7I8cfyKK2xSr/ROqho7Gj6ZQl8ZETUUcILwunARNZZh+9Qd8VZpl8zfeJw5Ybs1sMnBQmJNjGz3CwD99NwffHRPujso76GvXSIxCJ8NQyeKZLcOv1Frbk2L1w93sKSvwBA0Y1vts1UL6/qnyAzwkaPCP9D7FF0USfejvUq0t3Q+96MdfTRJFJK4sn865EDk901q6RDsQKcmNV0BiJtOtborQYsDMZ7D9y207SJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juxscd5JyVe9fD5hlLx3KOpfRN8ZWNzwsgSnSpHml2I=;
 b=TGSUPoJ2SUFsQXf5A026VVQMdKXc6eNk4Nf5uMRn11exkGQ3km8eu3rc0SRyR7aqGO/5F3NaTWVH+9gidF+n5M9N9gtgozChZW1Z+OvQTfPDRGGhilHoMHRPk5JHnQgEEdq9ocpdAhlF+ozTO2BIBrT8BdS9VwZGLvRiAvGCA6VfhNqjhc8rzrEVeQare2CCO+Aj//g8wDBS6vJja+5igZJcEk6zHojIhjSmuMpRXsmEI0AQoFlKSf1NlqkYNU6TKTdzDDcxhOc70Qg79uZt/e2wHjCEnu9wERbi07eei6IU4xljXJS0iIP6U5wyQinhIGvR6sGJYW6XGZ/m3ndRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juxscd5JyVe9fD5hlLx3KOpfRN8ZWNzwsgSnSpHml2I=;
 b=i1mH3UpYwIUIcd5lJSw/TueJ456y1nqJW0nrmxATK+WqwIPtG77H9OC2Qb4AaJLjAMd+oywLIhrrORpGdwbQ0nwpF9MOzvUj44G3x7sxTf0k/jGnbmjLnVRgw6ycUUyIDlgHK3soNY/UpmXaoQh/9q9J1DyW0v8vM/cHIbdA134=
Received: from BYAPR02MB4997.namprd02.prod.outlook.com (20.176.253.206) by
 BYAPR02MB4983.namprd02.prod.outlook.com (20.177.124.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 09:01:21 +0000
Received: from BYAPR02MB4997.namprd02.prod.outlook.com
 ([fe80::90f6:4723:69e8:56e4]) by BYAPR02MB4997.namprd02.prod.outlook.com
 ([fe80::90f6:4723:69e8:56e4%7]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 09:01:21 +0000
From:   Stefan Asserhall <stefana@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>, git <git@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH 3/7] microblaze: Define SMP safe bit operations
Thread-Topic: [PATCH 3/7] microblaze: Define SMP safe bit operations
Thread-Index: AQHV4bsPPZw9y+9DiE+r7k7+xry4lagXtZWAgAEaGYCAAAMQYA==
Date:   Thu, 13 Feb 2020 09:01:21 +0000
Message-ID: <BYAPR02MB499729CFF3B9FD7DDDCFBCD8DD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <6a052c943197ed33db09ad42877e8a2b7dad6b96.1581522136.git.michal.simek@xilinx.com>
 <20200212155309.GA14973@hirez.programming.kicks-ass.net>
 <cd4c6117-bc61-620c-8477-44df6e51d7b8@xilinx.com>
In-Reply-To: <cd4c6117-bc61-620c-8477-44df6e51d7b8@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefana@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52bddd83-259c-43a8-cd0e-08d7b0634ba1
x-ms-traffictypediagnostic: BYAPR02MB4983:|BYAPR02MB4983:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4983AC9B8BB21123DB5E93F7DD1A0@BYAPR02MB4983.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(81166006)(7696005)(316002)(71200400001)(478600001)(6636002)(33656002)(110136005)(54906003)(52536014)(8676002)(81156014)(86362001)(55016002)(76116006)(8936002)(6506007)(9686003)(2906002)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(186003)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4983;H:BYAPR02MB4997.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESCsZ5yPCqK2heKeSYcgw1nSnjQqD1t6s624myq73Rq898KKY1YDRbxKfp8pYspdSJrX5USy2RtOr8oRtkA7GLT6CB5WlWYzhNqYWIXD+Zl9g1j+rIx+eXS3Ps79VD+pc73t069hw3TaatrwT6lagphBmgbPzyy89QLqSDBg9d0SacORTx0AUkCCMRqMbd9GFY+Kw/NBSxRfTyOCTjQY526NOkl9fk73/VvB35zfPkDq+EUYWCCa8RkP0pgEWLQ7FZQ6w3jsHXhF1JC+B4uYE0Z32M52VgET2kWzULWfj7W9hDYQbWV4opx0t5OfZP/Hgdukxjwt1CWx2NHj4ghdgGNv+VFNmV+DSYQsdZ7pUv2pzTP8OscDWenYDqqxaJDrfsUsy4KhkPTY8G1NbjLKuQJtwsAlaQTiucWwqeiyec22EL8LW8SrZckEzHfxUWIx
x-ms-exchange-antispam-messagedata: mnRtkOXKcs0ovgZPFmpvIZziqec9cTtcBZspNiVhrhrjwHAbMi3dtj/2RS0MA+5+A9AhuMLG3ysNCbtAdnrj7vMIqCtfWS8ZYUlA39nUha5jT5iK6fppF8wkffsoOmXTeVRFc7FrYMOnqb8qdJzMGw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bddd83-259c-43a8-cd0e-08d7b0634ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:01:21.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83kr1K6YMCXB1D/aNCd4p6XSV2txUqazWwReP7fV5HXdbKwHPzLAga965du0IaG4LekElKnkNHi37EL/v0LQtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMi4gMDIuIDIwIDE2OjUzLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiBPbiBXZWQs
IEZlYiAxMiwgMjAyMCBhdCAwNDo0MjoyNVBNICswMTAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+
ID4+IEZyb206IFN0ZWZhbiBBc3NlcmhhbGwgPHN0ZWZhbi5hc3NlcmhhbGxAeGlsaW54LmNvbT4N
Cj4gPj4NCj4gPj4gRm9yIFNNUCBiYXNlZCBzeXN0ZW0gdGhlcmUgaXMgYSBuZWVkIHRvIGhhdmUg
cHJvcGVyIGJpdCBvcGVyYXRpb25zLg0KPiA+PiBNaWNyb2JsYXplIGlzIHVzaW5nIGV4Y2x1c2l2
ZSBsb2FkIGFuZCBzdG9yZSBpbnN0cnVjdGlvbnMuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBBc3NlcmhhbGwgPHN0ZWZhbi5hc3NlcmhhbGxAeGlsaW54LmNvbT4NCj4gPj4gU2ln
bmVkLW9mZi1ieTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gPg0K
PiA+PiArLyoNCj4gPj4gKyAqIGNsZWFyX2JpdCBkb2Vzbid0IGltcGx5IGEgbWVtb3J5IGJhcnJp
ZXIgICovDQo+ID4+ICsjZGVmaW5lIHNtcF9tYl9fYmVmb3JlX2NsZWFyX2JpdCgpCXNtcF9tYigp
DQo+ID4+ICsjZGVmaW5lIHNtcF9tYl9fYWZ0ZXJfY2xlYXJfYml0KCkJc21wX21iKCkNCj4gPg0K
PiA+IFRoZXNlIG1hY3JvcyBubyBsb25nZXIgZXhpc3QuDQo+IA0KPiBvay4gRWFzeSB0byByZW1v
dmUuDQo+IA0KPiA+DQo+ID4gQWxzbywgbWlnaHQgSSBkcmF3IHlvdXIgYXR0ZW50aW9uIHRvOg0K
PiA+DQo+ID4gICBpbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9hdG9taWMuaA0KPiA+DQo+ID4g
VGhpcyBiZWluZyBhIGxsL3NjIGFyY2gsIEknbSB0aGlua2luZyB0aGF0IGlmIHlvdSBkbyB5b3Vy
IGF0b21pY190DQo+ID4gaW1wbGVtZW50YXRpb24gcmlnaHQsIHRoZSBnZW5lcmljIGF0b21pYyBi
aXRvcCBjb2RlIHNob3VsZCBiZSBuZWFyDQo+ID4gb3B0aW1hbC4NCj4gPg0KPiANCj4gQmFzZWQg
b24gbXkgbG9vayBpdCBsb29rcyBsaWtlIHRoYXQgSSBjYW4gcmVwbGFjZSBpbXBsZW1lbnRhdGlv
bnMgaW4gdGhpcyBmaWxlIGJ5DQo+IHNvdXJjaW5nIHdoaWNoIHdpbGwgYmUgdXNpbmcgYXRvbWlj
IG9wZXJhdGlvbnMuDQo+IA0KPiAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYml0b3BzL2F0b21pYy5o
Pg0KPiAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYml0b3BzL2xvY2suaD4NCj4gDQo+IENvcnJlY3Q/
DQo+IA0KPiBXb3VsZCBiZSBnb29kIHRvIHJ1biBhbnkgdGVzdHN1aXRlIHRvIHByb3ZlIHRoYXQg
YWxsIG9wZXJhdGlvbnMgd29ya3MgYXMNCj4gZXhwZWN0ZWQuIElzIHRoZXJlIGFueSB0ZXN0c3Vp
dGUgSSBjYW4gdXNlIHRvIGNvbmZpcm0gaXQ/DQo+IA0KPiBUaGFua3MsDQo+IE1pY2hhbA0KDQpU
aGUgY29tbWVudCBpbiB0aGUgZ2VuZXJpYyBiaXRvcHMuaCBzYXlzICJZb3Ugc2hvdWxkIHJlY29k
ZSB0aGVzZSBpbiB0aGUNCm5hdGl2ZSBhc3NlbWJseSBsYW5ndWFnZSwgaWYgYXQgYWxsIHBvc3Np
YmxlIi4gSSBkb24ndCB0aGluayB1c2luZyB0aGUgZ2VuZXJpYw0KaW1wbGVtZW50YXRpb24gd2ls
bCBiZSBhcyBlZmZpY2llbnQgYXMgdGhlIGN1cnJlbnQgYXJjaCBzcGVjaWZpYyBvbmUuDQoNCk15
IHJlY29tbWVuZGF0aW9uIGlzIHRvIHN0aWNrIHdpdGggdGhlIGFyY2ggc3BlY2lmaWMgaW1wbGVt
ZW50YXRpb24uDQoNClRoYW5rcywNClN0ZWZhbg0K
