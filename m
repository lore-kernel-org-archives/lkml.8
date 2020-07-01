Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD26C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D12082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LzgCldV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGATj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:39:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19843 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGATj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:39:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efce6290000>; Wed, 01 Jul 2020 12:38:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 12:39:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 12:39:57 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 19:39:52 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 19:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAaYXohNvaRkKVndYFg+8BDD3WztYiTxA4Cbo0HOSw/bmAg5hlnxqGFtLkveusvripKMeQyVP18h00CZYYyHHewTxi8cdw1tEUdMuo04YUDEzEJefo/AdT3hsRqIKeEU+egCjI+78/1Aq2iqk+S5UK8FGUZgoDmNhHXWRlJfk1UVTVuLKvImm7Ajx8Ypy/jMBeMb2MZ23C65n+rHgU/VodWyNqYRMTJCvL0EKwS18EQLdHz9twlmdfPSOz8RR5W1Lt1QZQN+mortIPC/piG4kxmKkKjM6P9OWdC6J52UD6Nr5pgyaLt7bcZN5J3+wmMvWw37lzQFjwVDQ7ubOSWcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0VyKIKMkZ+TYVRHj9ciDY1OJts+8wIb9MgTV3QWNwE=;
 b=IP1+DFNJmd/EDgYbXISM59Bx276RXz4IbVwqKpeczGo+Ena+4kV0e4e+bq05jfCauSWwHOScEoqc9H9r10E8B13FYz+SBgyBE7rrOqAAnfCpb8RuvhLE6tOzsFFJ1Ytn8sljmJdFD2BX08y77N23Br4k2MghFXVXYMR+PfOZ2wF9gkEE07fOkGcrNrXwEmL0cDm/1c3DcKbC+1XwWeUyzIpBpXdUOXzXCkdL691+IhOlepxDRyLumMD0sDpHjQytoI+DOV8RnaB/d/Ny2YZRUlDwl6v3iPO01cmLZ3sAg9AQo8pnQt2U8O5qahk6QC7LYqasW0DCzWXjHUkZdG5i+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 19:39:51 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 19:39:51 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
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
Subject: RE: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Topic: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Index: AQHWTnLtO+c1bLqxQk+6SvUQTirpX6jxFsYAgAH0qfCAAAfXAIAAAiQAgAAKGICAAACGQA==
Date:   Wed, 1 Jul 2020 19:39:51 +0000
Message-ID: <BYAPR12MB2822EE99210BFA984ECB954AB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
 <BYAPR12MB282245DD6BB50ECA700AC69EB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <b10673f6-2a01-b9e5-0948-9684ffbe1813@nvidia.com>
In-Reply-To: <b10673f6-2a01-b9e5-0948-9684ffbe1813@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T19:39:41.3476805Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=1e5a298f-6414-4cb8-bb73-d5ee44b12e28;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9241ffa7-9222-4404-e82d-08d81df685d6
x-ms-traffictypediagnostic: BY5PR12MB4292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42924217DD3DC4C4BFD37E7FB36C0@BY5PR12MB4292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uHzpEdXw/efaxLf49tRoDJLwwsC00mCILb1qx2TvJfwPEwSnbuu3GdXhqhhgz0J6aagrk47CRhgtw7OWETYNFaFnLXsrFVHQkIp6yNGXAVvCH+EpT1xAPcKBnMDKUNw9ZHRz9K/6S4FwPIGzMMjQ5jhP8xX/jkn1oFD2+AxsIeD6gafYViqOdeTV0ahxaWk+O0NEyc+OzTsd9asjndQE6qI4bpGjFNEU/FXG9eZN46TsitUKo7YOmvPKv3ynZ+8JLVAHHmtrNtdmu3/aDKinJwzV48NMSeqp4pjlPXHn040ObtBbJlo5gSCNqTwquo2k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(5660300002)(8676002)(53546011)(26005)(86362001)(2906002)(71200400001)(33656002)(186003)(83380400001)(8936002)(52536014)(64756008)(66556008)(66476007)(4326008)(55016002)(9686003)(110136005)(316002)(478600001)(54906003)(6506007)(66446008)(66946007)(76116006)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NYdyN8JhSWjrbOwgP2ds2hMOfp4Ll7Z1Fvwkk2aP/aGjI8rIeGu8uprVWCjgrSQTqUmJUemezHefTrpo7/16xsoueJWbjAGhLkbQmHP4FZqGd5sevewdF+VvKtE1TeDyLXlO95GMGCMc9osCrlZNEe5sxBBXUqzYVjBlta2r9zyzO+5B1K9pVoIO65q/3sdeyidyCK9FNUtZteCVPKyMYjtFnwnNyg4H5bOKqegthkUiFk/CTbgVWhu7lHAtnUV8TESRJhegs6+qoA3QLtONKWkzjpJyAf1p9qTEez0fT+OQgk0sLu1FueT+Ay27GYd3QReSVuGYaqHBwArXAzDftbTS/6tj9xnf+CYw+YdrYIuOLKD97jdH73a/8jB7OUP85LaOQ1vj1nN/yTcPF5yPs+oY/H5iL3BuO/dZSjRNVYKnYXTf8k2JS+VrXelqRlvy4cXMCKjE4iY/NneMZr7TzUsEsOVoUIe2KOXLlWiMKTWqoxxjQkWxxsxPJ2Dav71f
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9241ffa7-9222-4404-e82d-08d81df685d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 19:39:51.5460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxphPJO3M3dGtCfJUgjhvdXnksn9fvw3VFO2FucLU8bCXuPkRMG5UPC4LIJZg76/FlDe6LdNXoPoft9BQyOyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593632297; bh=r0VyKIKMkZ+TYVRHj9ciDY1OJts+8wIb9MgTV3QWNwE=;
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
        b=LzgCldV1XFk449rQei2608bSZKcTjXYqyFgLNfVNU0BzPLHN6oDC/5I6jpAaaUwLv
         Q0DBojr0SyQ57ao7XyQQ4lyNLXJgm6sigF27DhQDxht2UbCB0kr9rqQKzL9E6zVQOr
         V9mGrmD1vtQDPTMj4z6dSq9xeBatF2A+Ma3VwAknp3ZDBvJeAW1b1RIOU7nZvceVSX
         9NhI97FW6jwWr13+u0pnp/u2uBD0DAZs7DpClymfUjgcYNIbroAkVdWP4y5MP2jtpv
         o7Mj72BJb7AD2OSZYNJFVK+joLvlRgZ+SEU4pb6w21UJFw9IM5TlJNfPlgD/A5f8+X
         rp4HSkFd8jXig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDcvMjAyMCAyMDowMCwgS3Jpc2huYSBSZWRkeSB3cm90ZToNCj4+Pj4+PiArICAgICAg
ICBpdGVtczoNCj4+Pj4+PiArICAgICAgICAgIC0gZW51bToNCj4+Pj4+PiArICAgICAgICAgICAg
ICAtIG52ZGlhLHRlZ3JhMTk0LXNtbXUNCj4+Pj4+PiArICAgICAgICAgIC0gY29uc3Q6IGFybSxt
bXUtNTAwDQo+Pj4+DQo+Pj4+PiBJcyB0aGUgZmFsbGJhY2sgY29tcGF0aWJsZSBhcHByb3ByaWF0
ZSBoZXJlPyBJZiBzb2Z0d2FyZSB0cmVhdHMgdGhpcyBhcyBhIHN0YW5kYXJkIE1NVS01MDAgaXQg
d2lsbCBvbmx5IHByb2dyYW0gdGhlIGZpcnN0IGluc3RhbmNlIChiZWNhdXNlIHRoZSBzZWNvbmQg
aXNuJ3QgcHJlc2VudGVkIGFzIGEgc2VwYXJhdGUgTU1VLTUwMCkgLSBpcyB0aGVyZSBhbnkgd2F5
IHRoYXQgaXNuJ3QgZ29pbmcgdG8gYmxvdyB1cD8NCj4+Pj4NCj4+Pj4gV2hlbiBjb21wYXRpYmxl
IGlzIHNldCB0byBib3RoIG52aWRpYSx0ZWdyYTE5NC1zbW11IGFuZCBhcm0sbW11LTUwMCwgaW1w
bGVtZW50YXRpb24gb3ZlcnJpZGUgZW5zdXJlIHRoYXQgYm90aCBpbnN0YW5jZXMgYXJlIHByb2dy
YW1tZWQuIElzbid0IGl0PyBJIGFtIG5vdCBzdXJlIEkgZm9sbG93IHlvdXIgY29tbWVudCBmdWxs
eS4NCj4+IA0KPj4+IFRoZSBwcm9ibGVtIGlzLCBpZiBmb3Igc29tZSByZWFzb24gc29tZW9uZSBo
YWQgYSBUZWdyYTE5NCwgYnV0IG9ubHkgc2V0IHRoZSBjb21wYXRpYmxlIHN0cmluZyB0byAnYXJt
LG1tdS01MDAnIGl0IHdvdWxkIGFzc3VtZSB0aGF0IGl0IHdhcyBhIG5vcm1hbCBhcm0sbW11LTUw
MCBhbmQgb25seSBvbmUgaW5zdGFuY2Ugd291bGQgYmUgcHJvZ3JhbW1lZC4gV2UgYWx3YXlzIHdh
bnQgYXQgbGVhc3QgMiBvZiB0aGUgMyBpbnN0YW5jZXMgPj5wcm9ncmFtbWVkIGFuZCBzbyB3ZSBz
aG91bGQgb25seSBtYXRjaCAnbnZpZGlhLHRlZ3JhMTk0LXNtbXUnLiBJbiBmYWN0LCBJIHRoaW5r
IHRoYXQgd2UgYWxzbyBuZWVkIHRvIHVwZGF0ZSB0aGUgYXJtX3NtbXVfb2ZfbWF0Y2ggdGFibGUg
dG8gYWRkICdudmlkaWEsdGVncmExOTQtc21tdScgd2l0aCB0aGUgZGF0YSBzZXQgdG8gJmFybV9t
bXU1MDAuDQo+PiANCj4+IEluIHRoYXQgY2FzZSwgbmV3IGJpbmRpbmcgIm52aWRpYSxzbW11LXYy
IiBjYW4gYmUgYWRkZWQgd2l0aCBkYXRhIHNldCB0byAmYXJtX21tdTUwMCBhbmQgZW51bWVyYXRp
b24gd291bGQgaGF2ZSBudmlkaWEsdGVncmExOTQtc21tdSBhbmQgYW5vdGhlciB2YXJpYW50IGZv
ciBuZXh0IGdlbmVyYXRpb24gU29DIGluIGZ1dHVyZS4gDQoNCj5JIHRoaW5rIHlvdSB3b3VsZCBi
ZSBiZXR0ZXIgb2ZmIHdpdGggbnZpZGlhLHNtbXUtNTAwIGFzIHNtbXUtdjIgYXBwZWFycyB0byBi
ZSBzb21ldGhpbmcgZGlmZmVyZW50LiBJIHNlZSBvdGhlcnMgaGF2ZSBhIHNtbXUtdjIgYnV0IEkg
YW0gbm90IHN1cmUgaWYgdGhhdCBpcyBsZWdhY3kuIFdlIGhhdmUgYW4gc21tdS01MDAgYW5kIHNv
IHRoYXQgd291bGQgc2VlbSBtb3JlIGFwcHJvcHJpYXRlLg0KDQpJIHRyaWVkIHRvIHVzZSB0aGUg
YmluZGluZyBzeW5vbnltb3VzIHRvIG90aGVyIHZlbmRvcnMuIA0KVjIgaXMgdGhlIGFyY2hpdGVj
dHVyZSB2ZXJzaW9uLiAgTU1VLTUwMCBpcyB0aGUgYWN0dWFsIGltcGxlbWVudGF0aW9uIGZyb20g
QVJNIGJhc2VkIG9uIFYyIGFyY2guICBBcyB3ZSBqdXN0IHVzZSB0aGUgTU1VLTUwMCBJUCBhcyBp
dCBpcywgSXQgY2FuIGJlIG5hbWVkIGFzIG52aWRpYSxzbW11LTUwMCBvciBzaW1pbGFyIGFzIHdl
bGwuDQpPdGhlcnMgcHJvYmFibHkgaGF2aW5nIHRoZWlyIG93biBpbXBsZW1lbnRhdGlvbiBiYXNl
ZCBvbiBWMiBhcmNoLg0KDQpLUg0KLS0NCm52cHVibGljDQo=
