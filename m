Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD11AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A9F22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yr2/FSik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBVyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:54:06 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7240 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBVyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:54:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5d806e0000>; Mon, 02 Mar 2020 13:53:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Mar 2020 13:54:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Mar 2020 13:54:03 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Mar
 2020 21:54:03 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Mar 2020 21:54:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3PLLTzI8nB4qScdrre5TAgKDth++cFolZqQvN77KM+fDNu5j4vxGRJJj0s/NrBqFrMwxr3e4bb6FcJaHpKe67mEKunW+jLLZO/+TfntMtUVJ9J45o6KTuerriOfMA3/zMnSOisnjACilyu6OCC1K4A5jpSCv1zY98nBchpCxXKasmBh9BLsAEZCa/rD3zMI8jAr9ZPX9O247/zXCncLrUZ8ZucZGI4P0HnOS+ZCmny6B8+NSh0HtdoUXpHjHa0P11oJjmIptYpfi/1pYn2abXL9ARSxHnFudZvEj94Iquv0ePNqbXxbKI3N058osthfBBOex63XqiLa7H9akAUlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4aBK4jUPglH7Tz3jgnEsevXmaTh3dUBbj3BJwAYLk4=;
 b=KiSOa2LXVTsgxDaR97WAxAMNG0KNWATBq3SQ5OdcTTs27WGtZO79x4ubU6/sYkZc1oceQ7VctPq99o+O9d7yXIZsbvSV6hz5k+FQfkxIK6WW3wr2VgKaulnkRmjwgXmx8MEz1ZtzIu3BfBKbfC8c54pEC1j7S5NqoHQ4ewI2BkbeA9fHR/wbjCdNNzuQMStgo1LS9eHI0pKOuS3I57PdTIZgGn7y9/lE7xZLZt7o6XaiAcUQk2hJ0x6zK2GYt0JaReIU0afQaNYP3TY8kcliW4pAHJHKO8/de6taARKNKDsCShRFU8Gr3pz9o6IvwM9aprMtw0NgLR3uzZ3FhOBBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3015.namprd12.prod.outlook.com (2603:10b6:a03:df::14)
 by BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 21:54:02 +0000
Received: from BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::50d4:922c:83f:534f]) by BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::50d4:922c:83f:534f%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 21:54:02 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: RE: [PATCH v2] mm: Proactive compaction
Thread-Topic: [PATCH v2] mm: Proactive compaction
Thread-Index: AQHV8NpA8KpdFgytgkKKwNxcIvg7mag111CA
Date:   Mon, 2 Mar 2020 21:54:02 +0000
Message-ID: <BYAPR12MB3015F73999D9C5D4A034DAE2D8E70@BYAPR12MB3015.namprd12.prod.outlook.com>
References: <20200302213343.2712-1-nigupta@nvidia.com>
In-Reply-To: <20200302213343.2712-1-nigupta@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=nigupta@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-03-02T21:54:09.6545215Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=4e830f61-868b-48b4-a542-511ce959ae7a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nigupta@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3458908-695f-4651-948d-08d7bef43853
x-ms-traffictypediagnostic: BYAPR12MB3207:
x-microsoft-antispam-prvs: <BYAPR12MB32074D4F59D51C0BFF962F89D8E70@BYAPR12MB3207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(54906003)(86362001)(4326008)(110136005)(33656002)(316002)(71200400001)(53546011)(8676002)(7696005)(6506007)(8936002)(81166006)(81156014)(5660300002)(52536014)(66556008)(64756008)(66446008)(66476007)(9686003)(55016002)(66946007)(2906002)(76116006)(4744005)(478600001)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3207;H:BYAPR12MB3015.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YyYND73kiNNb7mI2buCEhMn466OJYKHuao0sqadcxrfMNJrMzEac0dlsbBSRcVoWTflfR5nUycJeBKJy5oxarehhvoXb2tSo+w3dft8COUU1VoNkhsZrmdwXeL7l41KUm8/zcJnQpr9o5jxJQSwlv5nFA0Vy1obtjJJW6XUymKWZZua/FvxWTM3oacUoCfQpMY/yI94Hd4b9SLzn7mi/b3X+4v2huXJLv73nJVo+JCzg8oCOBS13pwqVDfms776PpZQ9o1/gL3uFccIL1wehjflKEf0/huiz+2IAGXuvRdU3PWWIblZOFckOhY1R8dzG4OfCd+DNS83YECGOfOeiSs2jqUNxpCQUbZeqgt98TW1klDiVJjBDmOPrM4GgSVjpZKbnqE7vCT/d4+LQ0fL7ZTqP1onpyJiCujhZwEI1UB3m90zQn/c8UQomXXeKPc2
x-ms-exchange-antispam-messagedata: VUzP4oaRZX2OQVRUklGoq9Gtf5jC2vtEupf2XaB5pqVJnXAc4BiKOOr52jFbveWpm14nKsI78SeF4Q64s+Slv9M8QUPp+dFl+LGSHXSpg3n3HGMCx4c04z7N5UQxBVwQVkd4IMuGDpqkfZI9uRJuQQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3458908-695f-4651-948d-08d7bef43853
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 21:54:02.0644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Y8wC1N1zHDyeu7y+9LJydUhAdGpyfMFVKONiunsmxt0D2bM7OpYZahy2LWxHrOvTfsbGsI8PzMnhxKpNQrdrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3207
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583186030; bh=V4aBK4jUPglH7Tz3jgnEsevXmaTh3dUBbj3BJwAYLk4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:
         x-ms-exchange-antispam-messagedata:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Yr2/FSiknJkowgari1FfdIwmD6DC9EBeMDpAsL3yKyz4+gm2Vhz0bW/RefTl6sdid
         NZhKEXXQ69vqTP/GWoBQ3bsT0kDxjz+KhS+5sR2aUwX5ApeoFXlSrqr0qS3mlKhOWD
         7Wc+MIIFrnhJ3uzbCg5CrBAudbR67wkYn8944XcHPx0Nu1qsXL7Yg9YESUEpyhgLBn
         wDvs3hWLMfSJ2IPPYD5NAA18x+e/A+CaJvXcmlkcwBM4C3qrfUYNlu48a9f4n/Qv2b
         lMYEBS4lmlZtbgG8YPyF8ZT4YywQPXJWpvCT8JODi84opFV3r8Ys9uU9nN9pJ4Sgvq
         3Nt2rFdCQZuFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTml0aW4gR3VwdGEgPG5p
Z3VwdGFAbnZpZGlhLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAyLCAyMDIwIDE6MzQgUE0N
Cj4gVG86IE1lbCBHb3JtYW4gPG1nb3JtYW5AdGVjaHNpbmd1bGFyaXR5Lm5ldD47IE1pY2hhbCBI
b2Nrbw0KPiA8bWhvY2tvQHN1c2UuY29tPjsgVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5j
ej4NCj4gQ2M6IE5pdGluIEd1cHRhIDxuaWd1cHRhQG52aWRpYS5jb20+OyBNYXR0aGV3IFdpbGNv
eA0KPiA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+Ow0KPiBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFjbGUuY29tPjsg
bGludXgta2VybmVsIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LW1t
IDxsaW51eC1tbUBrdmFjay5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gbW06IFByb2FjdGl2
ZSBjb21wYWN0aW9uDQo+IA0KDQoNCj4gLSBXaXRoIDUuNi4wLXJjMyArIHRoaXMgcGF0Y2gsIHdp
dGggcHJvYWN0aXZlbmVzcz0yMA0KPiANCj4gZWNobyAyMCB8IHN1ZG8gdGVlIC9zeXMva2VybmVs
L21tL2NvbXBhY3Rpb24vbm9kZS0qL3Byb2FjdGl2ZW5lc3MNCj4gDQo+ICAgcGVyY2VudGlsZSBs
YXRlbmN5DQo+ICAg4oCT4oCT4oCT4oCT4oCT4oCT4oCT4oCT4oCT4oCTIOKAk+KAk+KAk+KAk+KA
k+KAk+KAkw0KPiAJICAgNSAgICAgICAyDQo+IAkgIDEwICAgICAgIDINCj4gCSAgMjUgICAgICAg
Mw0KPiAJICAzMCAgICAgICAzDQo+IAkgIDQwICAgICAgIDMNCj4gCSAgNTAgICAgICAgNA0KPiAJ
ICA2MCAgICAgICA0DQo+IAkgIDc1ICAgICAgIDQNCj4gCSAgODAgICAgICAgNA0KPiAJICA5MCAg
ICAgICA1DQo+IAkgIDk1ICAgICA0MjkNCj4gDQoNClRoZSBwZXJjZW50aWxlIGxhdGVuY3kgZGF0
YSBhYm92ZSBpcyBjb3JyZWN0IGJ1dCB0aGUgc3VtbWFyeSBsaW5lIGlzDQpJbmNvcnJlY3Q6DQoN
Cj4gVG90YWwgMk0gaHVnZXBhZ2VzIGFsbG9jYXRlZCA9IDExMTIwICgyMS43RyB3b3J0aCBvZiBo
dWdlcGFnZXMgb3V0IG9mIDI1Rw0KPiB0b3RhbCBmcmVlID0+IDk4JSBvZiBmcmVlIG1lbW9yeSBj
b3VsZCBiZSBhbGxvY2F0ZWQgYXMgaHVnZXBhZ2VzKQ0KPg0KDQpDb3JyZWN0ZWQ6DQpUb3RhbCAy
TSBodWdlcGFnZXMgYWxsb2NhdGVkID0gMzg0MTA1ICg3NTBHIHdvcnRoIG9mIGh1Z2VwYWdlcyBv
dXQgb2YNCjc2MkcgdG90YWwgZnJlZSA9PiA5OCUgb2YgZnJlZSBtZW1vcnkgY291bGQgYmUgYWxs
b2NhdGVkIGFzIGh1Z2VwYWdlcykNCg0KVGhhbmtzLA0KTml0aW4NCg0K
