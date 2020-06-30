Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8ECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E9C20774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dimS1Y+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgF3UV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:21:57 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10782 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgF3UV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:21:56 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb9ee00000>; Wed, 01 Jul 2020 04:21:52 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 13:21:52 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 30 Jun 2020 13:21:52 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 20:21:47 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 20:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiFHOpsh7vZK57P/Zpxxxb2Ku6dz4uBgQkop/WEa90petb8S7a5JnJDBCoYAjOOwy6ERUWy3Ne6tMhAazwxuDDDuaQ9zPPX0Tr/OLlGZhIdOE97ts+GzUlxvN4JIW1HiI28U+jDyRyi9EsjNxsmTa/me4XGNSQjikJDJE0c/Yy4Y+9/Bv1NGS5lkWN5AGP9EYcXYNdmZfe22dHkzydD2wm5HYFeGlL0IgFsX/CNwySp0NrjvArew/x6jW0OABaiz91qUkLRtERhEsrOzgUV7ZhXyoO+dHI40oka1SG6r+d/HzGm2fD/X8TdloPrQWlMmBQoYE8LPrUUjQJLh8IxfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9TmtNU1To6IxI+EH+P3BHjtxVj6UUA2yhTMaYLkcJI=;
 b=OFTPqql2e5EqDooH80QUxD5XTlczrsIeCzhUZv9RX82icNm0Ncm0k2L0ABBp3Z5c8MQr3Je3jLobpfaiKWZvMcq+ZsPqrMxECJgDU7f7xbpDeBSaj8r2N5LdiTaisO3G9e9L+n5wvx16LlFM+N7uCUrKSipUWgv5Aw8Ci72XFI+RwsdpX+HFGHZrWvgUnaEC+t69p5Uu8g8rd+e3UrRFShyx0P+isFbvVF2MKbJyCbpW1qfYKVTCoVkTF3r2cmsKVMSeCb6rQBZoD8N31c7MdAmvDAXeaIVMEwa0s+MBo0Fe4Hzd+pcpWnK/nvAimacNKAV1ZBz5xkCVX9odq6KaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 20:21:44 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 20:21:44 +0000
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
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw8nYAgABivFCAAAYNgIAAA0WAgAAGCACAACC4AIAAFN+A
Date:   Tue, 30 Jun 2020 20:21:44 +0000
Message-ID: <BYAPR12MB282290F6E270DB90040379A0B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
 <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <4037efc7-fbed-e8cf-dac7-212c65014e4e@nvidia.com>
 <eb0ffc7e-f41b-d17c-6a90-049335098cd2@nvidia.com>
 <BYAPR12MB2822B43B0218F6E55C97451BB36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <64ffa84f-a8cf-ae81-6306-b5d8b1ff0618@nvidia.com>
In-Reply-To: <64ffa84f-a8cf-ae81-6306-b5d8b1ff0618@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T20:21:42.5016349Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=e86ac2ad-94a5-4360-b4fe-863d47606bad;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [71.202.129.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b2cd1e-c839-4a24-cf86-08d81d33350a
x-ms-traffictypediagnostic: BYAPR12MB3191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31911783FCEEF540DC5476E7B36F0@BYAPR12MB3191.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9D0EPOHLLsgQl6+NSl7GbzxP6IgfyvIH4wxNzWyxuYt96se0Gl85/kycsYbsOsfSnZ8dmgzrtsCeueL3kOn/ltQ0zaPn+8E6lAMr4iy58gLG07g19ERjY53kvkN+FeimbUhVgiTDTa4BEeM0GNvLZQxgBpOTf/VUyWbXK4OGII5hxx1QJZJwovtDICQSRWMhRNNflv9KG1HoJWpMDkj2p7bXGLYig17JrXRyg58Wa9A4FXbTCl6lh+SYEIJvhBTtiyTiJlXsUNNYU1086Eo35Xs1IS/BYfCdEAFHvqFake+up593NUE3uvEOkCje7N+4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(7696005)(6636002)(6506007)(86362001)(52536014)(83380400001)(9686003)(6862004)(316002)(71200400001)(54906003)(478600001)(4326008)(33656002)(55016002)(186003)(26005)(8676002)(64756008)(8936002)(2906002)(66556008)(66476007)(66446008)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7XsW8+8X7Z15I+wTuT6GOEjHQUcvy8XdL6/5rqupM7RikkG4yNpjWVxR/iJAF8KUkESek7/1xZNln/6boM0/zXMEiyRZnjE2uEDkTkpQ/eoeoaxToPjT1s2vX9yFgxSi8+XDh92fBjHHjO7jXQqRH2N9g/pogNkDX+e93PNWWJLCuRNr5oYuIB87GPXi4cbpN+GZYdTl55EmIf979njpXTexKuQ7QYA1L8lbEHgVx0NHuPDGk4lnz0GcD/WCmPhXkKtwDpg9GODsEkoTJCCSQEZK1Y3eI2DphzARK7oLYzX6PHzV14JNQqJwVnD1ncyJCzpLeEaHIQlkeK3W9XiQgyDeGifAJPMFWaN/JDNXgWXR7hNIFt4H9iu0RDJiD3o2m2GbXD9FJrwL33u9AseQC6laurKAY7np2qJQ9IRZULYCunm/MNKqhQ/R+SxNgoF6rseRe6dkbGMSd5NJPx2VovJAtrgmSzSevgWjZgj2oG4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b2cd1e-c839-4a24-cf86-08d81d33350a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 20:21:44.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meKE/dIyBW3rLkFmkswNJh4YdbB/mC4rtz6W4v+VFF1SNJkk6qnB003Cy10yOHDABRBDznaaqOmqZkMWHtiUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593548512; bh=V9TmtNU1To6IxI+EH+P3BHjtxVj6UUA2yhTMaYLkcJI=;
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
        b=dimS1Y+T9Itbi7CoQXzOmbB575VMGNHXMRu7ycjyJaS5vO4sKz4zxyZNqgFDtbz2T
         eH8VTkGalhEFoxaKMFtbtJwA1rCeMC404y27WK/5SO1dtweefzvuroiJhqFY0WI4kQ
         zFSBMNJmu3eg3oX5SQxrkcOTZnvbhhr7DZ7yvokpky7v6CG0SDiEUiVfJkh2fxKzGD
         8O/54d15VOWzNsQ+52IjZLUkXWcJI91eb8GfVs4d1cU1aI2JMUZ5s3Eds5dkIpqAZt
         9NTRk1IyclyVOeC9Tp6vNzwesom4yvwhVgGtg2cGjvY3gzO/ZKoQIzmhJdsJRmX4eu
         lGikUzqk+0HzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gVGhlIGRyaXZlciBpbnRlbmQgdG8gc3VwcG9ydCB1cCB0byAzIGluc3RhbmNlcy4gSXQgZG9l
c24ndCByZWFsbHkgbWFuZGF0ZSB0aGF0IGFsbCB0aHJlZSBpbnN0YW5jZXMgYmUgcHJlc2VudCBp
biBzYW1lIERUIG5vZGUuDQo+PiBFYWNoIG1taW8gYXBlcnR1cmUgaW4gInJlZyIgcHJvcGVydHkg
aXMgYW4gaW5zdGFuY2UgaGVyZS4gcmVnID0gDQo+PiA8aW5zdDBfYmFzZSwgc2l6ZT4sIDxpbnN0
MV9iYXNlLCBzaXplPiwgPGluc3QyX2Jhc2UsIHNpemU+OyBUaGUgcmVnIGNhbiBoYXZlIGFsbCB0
aHJlZSBvciBsZXNzIGFuZCBkcml2ZXIganVzdCBjb25maWd1cmVzIGJhc2VkIG9uIHJlZyBhbmQg
aXQgd29ya3MgZmluZS4NCg0KPlNvIGl0IHNvdW5kcyBsaWtlIHdlIG5lZWQgYXQgbGVhc3QgMiBT
TU1VcyAoZm9yIG5vbi1pc28gYW5kIGlzbykgYnV0IHdlIGhhdmUgdXAgdG8gMyAoZm9yIFRlZ3Jh
MTk0KS4gU28gdGhlIHF1ZXN0aW9uIGlzIGRvIHdlIGhhdmUgYSB1c2UtY2FzZSB3aGVyZSB3ZSBv
bmx5IHVzZSAyIGFuZCBub3QgMz8gSWYgbm90LCB0aGVuIGl0IHN0aWxsIHNlZW1zIHRoYXQgd2Ug
c2hvdWxkIHJlcXVpcmUgdGhhdCBhbGwgMyBhcmUgcHJlc2VudC4NCg0KSXQgY2FuIGJlIGVpdGhl
ciAyIFNNTVVzIChmb3Igbm9uLWlzbykgb3IgMyBTTU1VcyAoZm9yIG5vbi1pc28gYW5kIGlzbyku
ICBMZXQgbWUgZmFpbCB0aGUgb25lIGluc3RhbmNlIGNhc2UgYXMgaXQgY2FuIHVzZSByZWd1bGFy
IGFybSBzbW11IGltcGxlbWVudGF0aW9uIGFuZCBkb24ndCAgbmVlZCBudmlkaWEgaW1wbGVtZW50
YXRpb24gZXhwbGljaXRseS4NCiANCj5UaGUgb3RoZXIgcHJvYmxlbSBJIHNlZSBoZXJlIGlzIHRo
YXQgY3VycmVudGx5IHRoZSBhcm0tc21tdSBiaW5kaW5nIGRlZmluZXMgdGhlICdyZWcnIHdpdGgg
YSAnbWF4SXRlbXMnIG9mIDEsIHdoZXJlYXMgd2UgaGF2ZSAzLiBJIGJlbGlldmUgdGhhdCB0aGlz
IHdpbGwgZ2V0IGNhdWdodCBieSB0aGUgJ2R0X2JpbmRpbmdfY2hlY2snIHdoZW4gd2UgdHJ5IHRv
IHBvcHVsYXRlIHRoZSBiaW5kaW5nLg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIGl0IG91dCEgV2ls
bCB1cGRhdGUgdGhlIGJpbmRpbmcgZG9jLg0KDQotS1INCg0KLS0NCm52cHVibGljDQo=
