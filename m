Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372FDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8A520768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q+4aMz5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbgF3REW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:04:22 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:12446 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389947AbgF3REV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:04:21 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb70920001>; Wed, 01 Jul 2020 01:04:18 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 10:04:18 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 30 Jun 2020 10:04:18 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 17:04:16 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 17:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz8ogrX3yphWMmj28G0zrl7DPe4pQhteLVAFJ3I7kQ/KJhO2Wozbv7gXfv0VOT0uNlCGFrkGAzvQSrJnu7uPIt6dD9qkAgv/ULGMdoXkZlobPv4m9H07jXhb8bgVVOPdufivUVKCJubKB8KwQtWWejli8KS7PdAdaPsgssrIsxNM1zvT+vlbgRNmIg4Z7am6TGfGdPSNptIG7JpyccEYwOtcvH9dyzLYU8RvV/yvoQKoEx2pV6njMdSvBguj5DwTiMCE9g2B0H6xsQxLhlUZo4dPOBK25H3d4IxZmUQF1iZbVFmY8w68WJmkptXZa52Zy8TetqORzTfULfo3SWb3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjNOaagwuwlxcGNhARe11W8Vg/6fDbq00jf8kXsGFpM=;
 b=Hju9NBO0NoH2/YFmcfONRsocQFUHlElkjYrLSMDnKKm4220o/Ds2hBurjMQLjk+dqGyh92EqG5b+aE4yCmfZHNgN4x3QpRaSeMq+c6GxI2pa7OFnhmkXadc86P9VQYMGjM9eRSv7QbRnsNU/jzjCV2VewQ6VqP23K7HtIA/dfRhVt3RZjGKPthQUE/xy6e3A1+SwkHiKi5a2lxoUHX4WvpwUo5twCm5Uz8wrAtXGN0eO9i57X3qpEtB3N1Xr17DvSg8aHQqmKgPcyDgZN98Vu+qfOigXtGmUe2ytdcsHxbQb9+mhAD5F1vsxmTUO/xA3ORw6dGDBS7+EkXojsAoYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3415.namprd12.prod.outlook.com (2603:10b6:a03:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 17:04:14 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 17:04:14 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        "Yu-Huan Hsu" <YHsu@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Subject: RE: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
Thread-Topic: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw0WKAgACIGaA=
Date:   Tue, 30 Jun 2020 17:04:14 +0000
Message-ID: <BYAPR12MB2822A100F2BE2D8141F0B585B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
In-Reply-To: <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T17:04:11.9890059Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=1317b412-78b4-4c24-ad7a-bf78d36dcba8;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bf44a11-efd4-4268-871c-08d81d179def
x-ms-traffictypediagnostic: BYAPR12MB3415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34154605E88379628E115FC5B36F0@BYAPR12MB3415.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7c10Hx2l3Ev3xlDCp68s7kxv9uT+ln8wmM49Rs5d9HWAm6bLtccoHC45IZklzUuMavhS7IJGKObnf7+KsO5QzSYCmWCtMz9y88zkdsBOF7rxJvEKY/XvI6dJ57uDN6uXxI7/ifnNlAk+Mfub+vKupYQLoUoJkMHbCSG+yJg7W88Tyfon0TiEWuCViIPfNja89d2gK5NsjjtG5Q2r6JIYEliYb357lmmwpz7YrYO/l3M2WmmKrIlz5RjR3g4DyzM/zWTOzT8qVswqID3BzsBugzoxcESvqjls7IaD8Op2N43VFSfFOhdHCqSninTRraR2EKiJa5EBNe7/a5xslmA/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(33656002)(478600001)(52536014)(316002)(5660300002)(54906003)(4326008)(71200400001)(6862004)(86362001)(66946007)(83380400001)(66556008)(76116006)(186003)(8676002)(6506007)(6636002)(55016002)(8936002)(9686003)(66476007)(64756008)(26005)(2906002)(66446008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2vnzISzZQpZYaqDlxu9/jD4BcEO30jDyrtwkZb3Z1X85yCR3spEOplLKKFUZzVDK1olYyuOhkK+ntaymhnG+x1r+TJMajYrNqw+XCiP84OKIsKsGiMgrUtcthSVwaHdCBWx4bgb1HA2fnDiHX9ERKRpprS0pD6GXhhhBrvSByYU6m+jvOgE8DcD5tLq+Bac9uvSvCVvcJRT64RcHWDsDiVRqvuezfeQ7YC3ejvsa1/JkD2ulHOCJJ939MdhyAjfESm9+20ZnlsC1xBzBQ2MuVHJlV6W6vRCSVhpmHsPw2fs8gKcTjkeFQtfZfA54wt62ka1Df1bniCa2TIro2tVrFJoLfqFoBrYNsDChdkB8aO5/en+MUJef8QvvyPnM25nrmzxoY1VhdGnUjAYFirMcSNB1877VQMwvS+iXH/cYQ0UI4P+AddFY6Bey+0IeDt7Zuzcoe0sxKxyiGU8bActWRJ3eptSyF+CyduHKpkLwX7Uu9BL8hZ0M4BcTLO/QV+5T
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf44a11-efd4-4268-871c-08d81d179def
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:04:14.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4T/k9HB8ANt54+6wzcq2P4uBbQZC6nZcPS/uI8zN5sA2GnKRFygrgOPfUlACApHLTo0nnPcNoH4JGxz1p0ya3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593536658; bh=PjNOaagwuwlxcGNhARe11W8Vg/6fDbq00jf8kXsGFpM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=q+4aMz5Qz5bkS1AddwShxE8G6xtJksYT9+3ID/I7SVXJJw6t7JZR7wtvj08qrMSUr
         l0vvKl7YlyGXkb0BPUzxAGN2JFbXoXSf4qY8dbQIQ+G2tGwPA7bj88NVefwft007Ce
         ltfPru16byiZkAIEspWN6szfEO2B2T7cMNSHMKgSxXSviaw31LJS0bTyMjAhAuki/k
         ahuYDch9nEyKRkveshf7CHiMiNzjbDpgunEuxE/DiK0Oi95s5V+JbP2AlXmxaeHB9i
         RGpf4sbVcTZovXfHhn2XAO9cq6dxujYpm2HDCD8iZiWCl7L345KVilgvDCc5my8ZXA
         iTCUS87vbwTfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gTlZJRElBJ3MgVGVncmExOTQgU29DIHVzZXMgdHdvIEFSTSBNTVUtNTAwcyB0b2dldGhlciB0
byBpbnRlcmxlYXZlIA0KPj4gSU9WQSBhY2Nlc3NlcyBhY3Jvc3MgdGhlbS4NCj4+IEFkZCBOVklE
SUEgaW1wbGVtZW50YXRpb24gZm9yIGR1YWwgQVJNIE1NVS01MDBzIGFuZCBhZGQgbmV3IGNvbXBh
dGlibGUgDQo+PiBzdHJpbmcgZm9yIFRlZ3JhMTk0IFNvQyBTTU1VIHRvcG9sb2d5Lg0KDQo+VGhl
cmUgaXMgbm8gZGVzY3JpcHRpb24gaGVyZSBvZiB0aGUgM3JkIFNNTVUgdGhhdCB5b3UgbWVudGlv
biBiZWxvdy4NCj5JIHRoaW5rIHRoYXQgd2Ugc2hvdWxkIGRlc2NyaWJlIHRoZSBmdWxsIHBpY3R1
cmUgaGVyZS4NCg0KVGhpcyBkcml2ZXIgaXMgcHJpbWFyaWx5IGZvciBkdWFsIFNNTVUgY29uZmln
LiAgU28sIEl0IGlzIGF2b2lkZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KSG93ZXZlciwgSW1w
bGVtZW50YXRpb24gc3VwcG9ydHMgb3B0aW9uIHRvIGNvbmZpZ3VyZSAzIGluc3RhbmNlcyBpZGVu
dGljYWxseSB3aXRoIG9uZSBTTU1VIERUIG5vZGUNCmFuZCBpcyBkb2N1bWVudGVkIGluIHRoZSBp
bXBsZW1lbnRhdGlvbi4NCg0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2lvbWVtICpu
dmlkaWFfc21tdV9wYWdlKHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUsDQo+PiArCQkJICAg
ICAgIHVuc2lnbmVkIGludCBpbnN0LCBpbnQgcGFnZSkNCg0KPklmIHlvdSBydW4gY2hlY2twYXRj
aCAtLXN0cmljdCBvbiB0aGVzZSB5b3Ugd2lsbCBnZXQgYSBsb3Qgb2YgLi4uDQoNCj5DSEVDSzog
QWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVudGhlc2lzDQo+IzExNjogRklMRTogZHJp
dmVycy9pb21tdS9hcm0tc21tdS1udmlkaWEuYzo0NjoNCj4rc3RhdGljIGlubGluZSB2b2lkIF9f
aW9tZW0gKm52aWRpYV9zbW11X3BhZ2Uoc3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSwNCj4r
CQkJICAgICAgIHVuc2lnbmVkIGludCBpbnN0LCBpbnQgcGFnZSkNCg0KPldlIHNob3VsZCBmaXgg
dGhlc2UuDQoNCkkgd2lsbCBmaXggdGhlc2UgaWYgSSBuZWVkIHRvIHB1c2ggYSBuZXcgcGF0Y2gg
c2V0Lg0KDQo+PiArc3RhdGljIHZvaWQgbnZpZGlhX3NtbXVfd3JpdGVfcmVnKHN0cnVjdCBhcm1f
c21tdV9kZXZpY2UgKnNtbXUsDQo+PiArCQkJICAgIGludCBwYWdlLCBpbnQgb2Zmc2V0LCB1MzIg
dmFsKSB7DQo+PiArCXVuc2lnbmVkIGludCBpOw0KPj4gKwlzdHJ1Y3QgbnZpZGlhX3NtbXUgKm52
aWRpYV9zbW11ID0gdG9fbnZpZGlhX3NtbXUoc21tdSk7DQo+PiArDQo+PiArCWZvciAoaSA9IDA7
IGkgPCBudmlkaWFfc21tdS0+bnVtX2luc3Q7IGkrKykgew0KPj4gKwkJdm9pZCBfX2lvbWVtICpy
ZWcgPSBudmlkaWFfc21tdV9wYWdlKHNtbXUsIGksIHBhZ2UpICsgb2Zmc2V0Ow0KDQo+UGVyc29u
YWxseSwgSSB3b3VsZCBkZWNsYXJlICdyZWcnIG91dHNpZGUgb2YgdGhlIGxvb3AgYXMgSSBmZWVs
IGl0IHdpbGwgbWFrZSB0aGUgY29kZSBjbGVhbmVyIGFuZCBlYXNpZXIgdG8gcmVhZC4NCg0KSXQg
d2FzIGxpa2UgdGhhdCBiZWZvcmUgYW5kIGlzIHVwZGF0ZWQgdG8gaXRzIGN1cnJlbnQgZm9ybSB0
byBsaW1pdCB0aGUgc2NvcGUgb2YgdmFyaWFibGVzIGFzIHBlciBUaGllcnJ5J3MgY29tbWVudHMg
aW4gdjYuIA0KV2UgY2FuIGp1c3QgbGVhdmUgaXQgYXMgaXQgaXMgYXMgdGhlcmUgaXMgbm8gdGVj
aG5pY2FsIGlzc3VlIGhlcmUuDQoNCi1LUg0KDQotLQ0KbnZwdWJsaWMNCg==
