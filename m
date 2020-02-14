Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE6C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F2F206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ee18s8iP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="cbJ6ioJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBNDkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:40:14 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48004 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728052AbgBNDkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:40:14 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 46FC842AB3;
        Fri, 14 Feb 2020 03:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1581651613; bh=tSQM4RQs0fe4u4e2y2vHZEc7ytgEZgOJiV5MCy2nfzo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ee18s8iPYeQqE+x9mqfb2LQ87dzOqO2JUgJeKWWFQly0zD5Hv6pUhMGXDP4SJ+2u3
         pmyyP3bGI0C4ObX7Z/4xyoK78HoFXdWFEzdsEovZbG+hV+ZHKafG0qwyOmC1JvHOyx
         SWKVY0VD6UyIf1AAgHp1Bcu1tYZlOipXezP86pK6SeZZQ+wFx9HadOVPUtMsvptFSW
         6fUzY/EAgDEYIXNbpFRfwq0Si0Id9SqvW8QTJfHw3DRX4giZg+PXaBHmIM50dSMRBe
         aPsJd5yubUzqznTnUtgovOMEj4BYucRYgBZ6sXCM9a7XsRPFVDhBpBqqnPn9dQsA+I
         q2LaGUvTUInnw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 28ADAA007F;
        Fri, 14 Feb 2020 03:40:11 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Feb 2020 19:40:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 13 Feb 2020 19:40:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1pKRysIP86W8RgyCFoH15Ah4YhIRsClR2eZ3s3Fh+JrYpUKp+gy4Wd5gPdpSid731nr9xE5QOHAFXdnW4VMiKqVktZeZcBsUo6rAgP7w6zK9AwdjqLZ9BBs3JFJK5vEd0cSBkHJYqBATjNIJRxq3YpiR7t6CPvXEDX0TLLpI867qfl8y4liukPZ/NYripPAGCE7rAvTeu5q5AkL1zcecLOYb+/uV1UTk5zLicN9V5m+E6mhDT1mPFIkjavH2u++TvhO22nPQ6KpFqHSbZKoRIoVeDYaFLnYtGsmkdCkLMJhS2uURJBGDj+hUVlZ1nfliPejm6DKEdKkmRENeivuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSQM4RQs0fe4u4e2y2vHZEc7ytgEZgOJiV5MCy2nfzo=;
 b=KDbaAUVJFHS9UA8XZWa6nbCyQuR+7YCDhMW4cNibC/wxbLu5S1TNFOaq8wJPUil5gt2I11szZC2d7gi7IOXGlKQEz8pIkZzRChGSJJeYe/+M3JatvWOJHFwJJhCSDivhhZts4dDm2OeLSO+9VVePQNWjw+C5UTd0FutD2KJm3eTY4eVHwNOB2Z8Sm58Ca+PI/tQPo7M+jk3AIJ6zKyWj00DMgn3B6CZ1WXzvQfrxIwMduLe3BfBKI4w7V/GRXx8uz2LhO6b4YOUVjpZbRQMhmD/rvCy1VXDkwlU9JQ794IqtZ1qofU5DUELW0mJxBggMtJM+9w/ilGXBllwp4ndPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSQM4RQs0fe4u4e2y2vHZEc7ytgEZgOJiV5MCy2nfzo=;
 b=cbJ6ioJngqdCB589aSoGBW8XSSK43VC5VdpqG3x61y113CSnB/hXAaO+mLmad9/O6yZL1VusdNopLDAkyHo2Q+ECBFLc5rl6vlYq5bZfnJ7AchccAdI0aud+Ppb8jZ7R1kMty7JA6rOvWYcyPRPq7W1d0uuSM8JxCn8lpwc6658=
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3142.namprd12.prod.outlook.com (20.178.55.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 14 Feb 2020 03:40:08 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::6cae:8d93:540f:1593]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::6cae:8d93:540f:1593%3]) with mapi id 15.20.2707.030; Fri, 14 Feb 2020
 03:40:08 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jayshri Pawar <jpawar@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed
 function.
Thread-Topic: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed
 function.
Thread-Index: AQHV4Y5FV9MeiX15OUylR8jx9wgmF6gaDcsA
Date:   Fri, 14 Feb 2020 03:40:08 +0000
Message-ID: <c722e1c3-7aee-11a6-295f-fb183c611300@synopsys.com>
References: <1581502748-22464-1-git-send-email-jpawar@cadence.com>
In-Reply-To: <1581502748-22464-1-git-send-email-jpawar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 098032d5-f0ec-4649-cd4e-08d7b0ff96b9
x-ms-traffictypediagnostic: BYAPR12MB3142:
x-microsoft-antispam-prvs: <BYAPR12MB314293620D347CC590847559AA150@BYAPR12MB3142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(8676002)(81166006)(81156014)(66476007)(8936002)(4326008)(7416002)(6512007)(64756008)(66946007)(6486002)(76116006)(66556008)(66446008)(2906002)(6506007)(71200400001)(478600001)(5660300002)(31696002)(54906003)(86362001)(36756003)(316002)(31686004)(26005)(186003)(110136005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3142;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: soNTKmnS2i9QsAHpASWNbk7OdbksVrCS+3P9MrXC5vMBi+8X9O+eTij3o7eejOf/+ZnYeo9hlt6n80QUpK8yhNlcHuHDy2WXnTH45M0hh9pHqDowUJyozr/PD1Ec2Evpo7355m/zMEnDukgSYOMh+AIGUu45rIqfB0YOWUoWJQxdkqj5V8nA4cHMamLn03CoMyGKMNUVY8cg1mVt66XFmO8d7Y95pe/jrm2NlKSUzBQNFSOk9RCe++i/va8LMIz1aqdHnRQ9P3WQ9bnLdywNeyWr94NpbMp0XQ0Al0O7stxVHxJhfR1IX3fIpUeHzqg7uVyFWtTNL4i3IORbqtmCuXzewW/vRXq1QknmNFyBlUPAmFlvJyj0p6JP0y5YNzqBOzTy0qphQ4eSv3DTt8JHkytuEVFYua7PAGnqXU2nY/BCuEGO5shM+VerHtVIxbwh
x-ms-exchange-antispam-messagedata: 4yGTcO6DHceOaE1AM6VqBogog6ranYLWbxxxQdMOmjmYUF1BtkUypolUxoEAQQmbgDROBHCHYlI88WNscS9QLH7V/uad+0mUtCzvcNVKpUNF627hHippfUlf7oPvF/twotmC/81SLEoX/a4csCExuw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C137ED382E82814F9DA30EFA6F781746@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 098032d5-f0ec-4649-cd4e-08d7b0ff96b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 03:40:08.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBbsVbNswVK2ih24Urnl0wbZ5MbbpLhJXXghsQlcqIbwiaUxZjR0vYzopryXDViJF+j0wtyyOCil0momWm/KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3142
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkpheXNocmkgUGF3YXIgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyBhZGRpdGlvbmFs
IHBhcmFtZXRlciBhbHQgdG8gY29uZmlnX2VwX2J5X3NwZWVkIGZ1bmN0aW9uLg0KPiBUaGlzIGFk
ZGl0aW9uYWwgcGFyYW1ldGVyIGFsbG93cyB0byBpbXByb3ZlIHRoaXMgZnVuY3Rpb24gYW5kDQo+
IGZpbmQgcHJvcGVyIHVzYl9zc19lcF9jb21wX2Rlc2NyaXB0b3IuDQo+DQo+IFByb2JsZW0gaGFz
IGFwcGVhcmVkIGR1cmluZyB0ZXN0aW5nIGZfdGNtIChCT1QvVUFTKSBkcml2ZXIgZnVuY3Rpb24u
DQo+DQo+IGZfdGNtIGZ1bmN0aW9uIGZvciBTUyB1c2UgYXJyYXkgb2YgaGVhZGVycyBmb3IgYm90
aCAgQk9UL1VBUyBhbHRlcm5hdGUNCj4gc2V0dGluZzoNCj4NCj4gc3RhdGljIHN0cnVjdCB1c2Jf
ZGVzY3JpcHRvcl9oZWFkZXIgKnVhc3Bfc3NfZnVuY3Rpb25fZGVzY1tdID0gew0KPiAgICAgICAg
ICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmYm90X2ludGZfZGVzYywNCj4gICAg
ICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJmJvdF91YXNwX3NzX2JpX2Rl
c2MsDQo+ICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZib3RfYmlf
ZXBfY29tcF9kZXNjLA0KPiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAq
KSAmYm90X3Vhc3Bfc3NfYm9fZGVzYywNCj4gICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRv
cl9oZWFkZXIgKikgJmJvdF9ib19lcF9jb21wX2Rlc2MsDQo+DQo+ICAgICAgICAgIChzdHJ1Y3Qg
dXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX2ludGZfZGVzYywNCj4gICAgICAgICAgKHN0
cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJmJvdF91YXNwX3NzX2JpX2Rlc2MsDQo+ICAg
ICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX2JpX2VwX2NvbXBf
ZGVzYywNCj4gICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3Bf
YmlfcGlwZV9kZXNjLA0KPiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAq
KSAmYm90X3Vhc3Bfc3NfYm9fZGVzYywNCj4gICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRv
cl9oZWFkZXIgKikgJnVhc3BfYm9fZXBfY29tcF9kZXNjLA0KPiAgICAgICAgICAoc3RydWN0IHVz
Yl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFzcF9ib19waXBlX2Rlc2MsDQo+ICAgICAgICAgIChz
dHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX3NzX3N0YXR1c19kZXNjLA0KPiAg
ICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFzcF9zdGF0dXNfaW5f
ZXBfY29tcF9kZXNjLA0KPiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAq
KSAmdWFzcF9zdGF0dXNfcGlwZV9kZXNjLA0KPiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlw
dG9yX2hlYWRlciAqKSAmdWFzcF9zc19jbWRfZGVzYywNCj4gICAgICAgICAgKHN0cnVjdCB1c2Jf
ZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3BfY21kX2NvbXBfZGVzYywNCj4gICAgICAgICAgKHN0
cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3BfY21kX3BpcGVfZGVzYywNCj4gICAg
ICAgICAgTlVMTCwNCj4gfTsNCj4NCj4gVGhlIGZpcnN0IDUgZGVzY3JpcHRvcnMgYXJlIGFzc29j
aWF0ZWQgd2l0aCBCT1QgYWx0ZXJuYXRlIHNldHRpbmcsDQo+IGFuZCBvdGhlcnMgYXJlIGFzc29j
aWF0ZWQgIHdpdGggVUFTLg0KPg0KPiBEdXJpbmcgaGFuZGxpbmcgVUFTIGFsdGVybmF0ZSBzZXR0
aW5nIGZfdGNtIGRyaXZyIGludm9rZXMNCj4gY29uZmlnX2VwX2J5X3NwZWVkIGFuZCB0aGlzIGZ1
bmN0aW9uIHNldHMgaW5jb3JyZWN0IGNvbXBhbmlvbiBlbmRwb2ludA0KPiBkZXNjcmlwdG9yIGlu
IHVzYl9lcCBvYmplY3QuDQo+DQo+IEluc3RlYWQgc2V0dGluZyBlcC0+Y29tcF9kZXNjIHRvIHVh
c3BfYmlfZXBfY29tcF9kZXNjIGZ1bmN0aW9uIGluIHRoaXMNCj4gY2FzZSBzZXQgZXAtPmNvbXBf
ZGVzYyB0byBib3RfdWFzcF9zc19iaV9kZXNjLg0KPg0KPiBUaGlzIGlzIGR1ZSB0byB0aGUgZmFj
dCB0aGF0IGl0IHNlYXJjaCBlbmRwb2ludCBiYXNlZCBvbiBlbmRwb2ludA0KPiBhZGRyZXNzOg0K
Pg0KPiAgICAgICAgICBmb3JfZWFjaF9lcF9kZXNjKHNwZWVkX2Rlc2MsIGRfc3BkKSB7DQo+ICAg
ICAgICAgICAgICAgICAgY2hvc2VuX2Rlc2MgPSAoc3RydWN0IHVzYl9lbmRwb2ludF9kZXNjcmlw
dG9yICopKmRfc3BkOw0KPiAgICAgICAgICAgICAgICAgIGlmIChjaG9zZW5fZGVzYy0+YkVuZHBv
aXRBZGRyZXNzID09IF9lcC0+YWRkcmVzcykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gZXBfZm91bmQ7DQo+ICAgICAgICAgIH0NCj4NCj4gQW5kIGluIHJlc3VsdCBpdCB1c2VzIHRo
ZSBkZXNjcmlwdG9yIGZyb20gQk9UIGFsdGVybmF0ZSBzZXR0aW5nDQo+IGluc3RlYWQgVUFTLg0K
Pg0KPiBGaW5hbGx5LCBpdCBjYXVzZXMgdGhhdCBjb250cm9sbGVyIGRyaXZlciBkdXJpbmcgZW5h
YmxpbmcgZW5kcG9pbnRzDQo+IGRldGVjdCB0aGF0IGp1c3QgZW5hYmxlZCBlbmRwb2ludCBmb3Ig
Ym90Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXlzaHJpIFBhd2FyIDxqcGF3YXJAY2FkZW5jZS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyAgICAgICAgICAgICAg
IHwgNDYgKysrKysrKysrKysrKystLS0tLS0NCj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vZl9hY20uYyAgICAgICAgICB8ICA3ICstLQ0KPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5j
dGlvbi9mX2VjbS5jICAgICAgICAgIHwgIDcgKy0tDQo+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfZWVtLmMgICAgICAgICAgfCAgNCArLQ0KPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX2ZzLmMgICAgICAgICAgIHwgIDMgKy0NCj4gICBkcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vZl9oaWQuYyAgICAgICAgICB8ICA0ICstDQo+ICAgZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfbG9vcGJhY2suYyAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi9mX21hc3Nfc3RvcmFnZS5jIHwgIDUgKystDQo+ICAgZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL2ZfbWlkaS5jICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX25jbS5jICAgICAgICAgIHwgIDcgKy0tDQo+ICAgZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2Zfb2JleC5jICAgICAgICAgfCAgNCArLQ0KPiAgIGRyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi9mX3Bob25ldC5jICAgICAgIHwgIDQgKy0NCj4gICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vZl9ybmRpcy5jICAgICAgICB8ICA3ICstLQ0KPiAgIGRyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi9mX3NlcmlhbC5jICAgICAgIHwgIDQgKy0NCj4gICBkcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9zb3VyY2VzaW5rLmMgICB8IDExICsrKy0tDQo+ICAgZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zfc3Vic2V0LmMgICAgICAgfCAgNCArLQ0KPiAgIGRy
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5jICAgICAgICAgIHwgMzYgKysrKysrKy0t
LS0tLS0tDQo+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdWFjMV9sZWdhY3kuYyAg
fCAgMiArLQ0KPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jICAgICAgICAg
IHwgIDUgKystDQo+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfYXVkaW8uYyAgICAg
ICAgfCAgNCArLQ0KPiAgIGluY2x1ZGUvbGludXgvdXNiL2NvbXBvc2l0ZS5oICAgICAgICAgICAg
ICAgIHwgIDIgKy0NCj4gICAyMSBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCspLCA3MSBk
ZWxldGlvbnMoLSkNCj4NCg0KSSB0aGluayB3ZSBzaG91bGQgY3JlYXRlIGEgbmV3IGZ1bmN0aW9u
IGFuZCBrZWVwIHRoZSBvbGQgDQpjb25maWdfZXBfYnlfc3BlZWQoKSBmb3IgZGVmYXVsdCBhbHQt
c2V0dGluZyAoZS5pLiBoYXZlIA0KY29uZmlnX2VwX2J5X3NwZWVkIGNhbGxzIHRoZSBuZXcgZnVu
Y3Rpb24gd2l0aCBkZWZhdWx0IGFsdC1zZXR0aW5nIDApLiANClRoaXMgd2F5LCB3ZSBjYW4ga2Vl
cCBjb21wYXRpYmlsaXR5IHdpdGggb2xkIGZ1bmN0aW9uIGRyaXZlcnMgYW5kIA0KbWluaW1pemUg
Y2hhbmdlcy4gQXQgbGVhc3QgdGhhdCdzIHdoYXQgd2UgZGlkLg0KDQpCUiwNClRoaW5oDQo=
