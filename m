Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1F4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53C4206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="bGSS7Lo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbgDBOrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:47:40 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:39463
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388499AbgDBOrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:47:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIoKKlaV8iirTX9Y7kza6pJwXNh98jrJsLJJsese61bitYyh1kE7GPG/16T5Uj9pex6uNGeuX9XO/A1FLg4vuH4MK8lOktTsoj8y5DKnSajuNmMwFzVAX31S02I6+AKwbqGV0X+M6HL7eZumPkPHp/GVQCHCPeQxwNmT/Rk9pGgUNyGR8zy8vQKg14rNf+ThG3NJDRo1CZvblITrmNcGqzrnS3BmMj+gSRf2/L4StNGV8VG8irHV6XjMxyM47KKS9klu5LSTf/44Hvc4d3gUSRdz/Q4n2SqlPGMi/vfBx2yEOmkCYyE9ELWABedBSKeujmfTNXOMVUsNKKh7v//SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y77EZkI118P9FYESEecbrjdkw3QR8UfhPyyXKjdlTu0=;
 b=Mi85+5G50dePEfq/eOdlY6vZBdXw59/gJWv/s8Zh/fHmyRXiajNV8IRnDi/t7o9hgDn60gXqyRQQauSEgkugz7ceszTGivno+vya8FpkhIWOpaUJ/puUO3mpH/fJOz4qWtYsxNInApvSZ2NmCLu0hw63yD268KlwvWzWGjMK5ZXDg323UnTn42SsI0zzh3l+v9kWj4XDU69RuCyFOXNS/RahGREnujRkZRiFBbTiDJYqv+otK+9BLj57ZidXxabCaxF0RLu83+QBKlKC5tIJ1d5/xDhlkw9OvLoGByKMuxJ/P0LL+/DV8urQlEFusYqHwyJs89iTjw+L6s98LsmNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y77EZkI118P9FYESEecbrjdkw3QR8UfhPyyXKjdlTu0=;
 b=bGSS7Lo1mVbdEKZLGRSgi0MPV0eh80fI3UZUr0zte0p40MBgLT1CBO4xXBOxMkx6pRt8Sz8yOdARPD0JUu1jS2tYq7uUBoyFDrnyhgWeI7yFFv6UBYV68rJenqyKjgjiBmtsDV9gzPFWBQ8uETj0Agmft3iRA6YguDoA1dJSY6U=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4406.namprd05.prod.outlook.com (2603:10b6:a02:ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.13; Thu, 2 Apr
 2020 14:47:33 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2878.014; Thu, 2 Apr 2020
 14:47:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC:     "Kenneth R. Crudup" <kenny@panix.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 0/2] x86: Prevent Split-Lock-Detection wreckage on VMX
 hypervisors
Thread-Topic: [patch 0/2] x86: Prevent Split-Lock-Detection wreckage on VMX
 hypervisors
Thread-Index: AQHWCO7Sb6i2/I/iLUiyebf9d8/Vyahl13iAgAAPCQCAAALoAA==
Date:   Thu, 2 Apr 2020 14:47:33 +0000
Message-ID: <D07135B9-576F-4232-8A1B-BEC5D26F35B8@vmware.com>
References: <20200402123258.895628824@linutronix.de>
 <alpine.DEB.2.21.2004020641470.7052@xps-7390>
 <875zeinecr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zeinecr.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4700:9b2:1153:aafd:5246:5949]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c2ec0b-7518-4222-f851-08d7d714c6ee
x-ms-traffictypediagnostic: BYAPR05MB4406:|BYAPR05MB4406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB44062B41DEFE367352608C65D0C60@BYAPR05MB4406.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(6506007)(66946007)(8676002)(110136005)(76116006)(66556008)(66476007)(5660300002)(4326008)(54906003)(186003)(66446008)(71200400001)(86362001)(64756008)(2906002)(6512007)(498600001)(2616005)(53546011)(7416002)(36756003)(4744005)(6486002)(81166006)(81156014)(8936002)(33656002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HmQxS6Rj4xD3fZzV36uK4FU5pQpWQO9ZAc0w7SEx9mbUxzTrjazorjfQhTie4nicfxYiMhYxXCXcqUfwp93oHFxcMC24IfB0iQtahylpf2tSKGFDaPkIqkS/tloNpjg03kqUBNVlHjA4qDdu3B2MarvpAY36KOlmgazJWWFaol2nVzaZPjXcxhJIVfz0v6RTINuXLTnHl+bEd5A0OsI5rpqJ8r5HeeCMMrUPvXJWdaa8A1+6BUf5qLIy8qSO2fmbQ6+rP3fcz2NPTk3nVtMs1JTza6Wjk4ll2pz1IlGrkeDu90isnC8D0DO2pV5RKP4IdnjStJPO/3O3ouxBTSW9/b4yz69p1V2T4oPUEmka7YxQLcAMlVgax2NlXYUPPi9D/ra9AKYCSOC4C5xV0/FmDrU6PErbN4laQmSdkCQmHvIYgugfqpx5cTPTlQ+mq0Pj
x-ms-exchange-antispam-messagedata: Fi7iUDF08aLM/wCN7jhwHaPKsLPeJRQBND+0J7NrrNGSakoVv/ualX447w7+VDrqE07E3c6g3O83G6AKd0sl842bSAlPIAnpRXG4yVgk5J7oFA3k8URxi8N09g66/GT2iVF0RF0/60HtPMBEC0/EzUHafXQe0j2Qilasf55rJvXXZiFe/LavpxhP5NeUtLIyXO1xF4gfHOAq6WiLEKToDQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAA01C6A3008CF4D86360B5DEF1BF40F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2ec0b-7518-4222-f851-08d7d714c6ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 14:47:33.2082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5+FL9lrobh0aVNKi8WHZmHf+ZH5A7OdvVf2mBrp/WiXC0eEpBeeX4z4z/CNhBcoPkq2y3OIH2imd3RJpbCBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMiwgMjAyMCwgYXQgNzozNyBBTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gIktlbm5ldGggUi4gQ3J1ZHVwIiA8a2VubnlAcGFuaXgu
Y29tPiB3cml0ZXM6DQo+IA0KPj4gT24gVGh1LCAyIEFwciAyMDIwLCBUaG9tYXMgR2xlaXhuZXIg
d3JvdGU6DQo+PiANCj4+PiBBcyBQZXRlciBhbmQgbXlzZWxmIGRvbid0IGhhdmUgYWNjZXNzIHRv
IGEgU0xEIGVuYWJsZWQgbWFjaGluZSwgdGhlDQo+Pj4gS1ZNL1ZNWCBwYXJ0IGlzIHVudGVzdGVk
LiBUaGUgbW9kdWxlIHNjYW4gcGFydCB3b3Jrcy4NCj4+IA0KPj4gSSBqdXN0IGFwcGxpZWQgYm90
aCBvZiB0aGVzZSBwYXRjaGVzIHRvIG15IChMaW51cycgdGlwKSB0cmVlLCBhbmQgdW5mb3J0dW5h
dGVseQ0KPj4gVk1XYXJlIHN0aWxsIGhhbmdzIGlmIHNwbGl0X2xvY2tfZGV0ZWN0PSBpcyBzZXQg
dG8gYW55dGhpbmcgYnV0ICJvZmYiLg0KPj4gDQo+PiBXYXMgdGhlcmUgYW55dGhpbmcgZWxzZSBJ
J2QgbmVlZGVkIHRvIGRvPw0KPiANCj4gSG1tLiBOb3QgcmVhbGx5LiBEb2VzIGRtZXNnIHNob3cg
dGhlIHdhcm5pbmcgd2hlbiB0aGUgVk1XYXJlIG1vZHVsZSBsb2Fkcz8NCj4gU29tZXRoaW5nIGxp
a2U6DQo+IA0KPiAgeDg2L3NwbGl0IGxvY2sgZGV0ZWN0aW9uOiBkaXNhYmxlZCBkdWUgdG8gVk1M
QVVOQ0ggaW4gbW9kdWxlOiDigKYuDQoNCkkgcmFuIGFuIG9iamR1bXAgb24gVk13YXJlIHdvcmtz
dGF0aW9uIGFuZCBpbmRlZWQgSSBkbyBub3Qgc2VlIGENClZNTEFVTkNIL1ZNUkVTVU1FLiBJIGRv
IHNlZSBob3dldmVyIFZNWE9OIHdoaWNoIHNob3VsZCBhbHNvIGJlIGdvb2QgZm9yDQpkZXRlY3Rp
bmcgaHlwZXJ2aXNvcnMuIEkgd2lsbCB0cnkgdG8gdW5kZXJzdGFuZCB3aHkgVk1MQVVOQ0ggaXMg
bm90IHRoZXJlLg0KDQo=
