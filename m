Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2036AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE7020723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PsL9QixB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390125AbgF3RQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:16:20 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41648 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgF3RQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:16:19 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb735f0000>; Wed, 01 Jul 2020 01:16:16 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 10:16:16 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 30 Jun 2020 10:16:16 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 17:16:12 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 17:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+fUZABkWpK08pLQEbOIHGY8XLy0B+RHNHSnGUoS+NGKOXf8VGFqopWTYz9cuAFyqRpncySLiTlKNNacmi68EoZ/7v6jyTbIaQl2VyjSORWaLU4FBqpOzYTmdm3q/xUWf+YRWsvQ+sugeJhjw/JA/QE7g/0lwIryzlQowdOkE6a2MiN+4g3DmYGQisEGaAezbXp6ziNBB2vt8aJiqqKMA/CCJX3MbdJ9iIPIqpMwXiDCHkLtYVbGfCXzkKVz51atfwySjQNt5ocDPFTdsKkGlN4ME8zqcAdajW0HS9zxlPbEEjTu7e3h0ieRGX5LYMwPY3r1LEwIvGUkZiA/NEJLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rpWkPa4G2BpSb5xcr1KVEdWuniqSALHDaJZNgqVOac=;
 b=WtKai+0yi7qx7YDoCK/TguEaYfMHhtKCT4C1FXjRsHesEXdBtSeNvmOb0fg5MJHB3EgILGJ38ZCDakkQlsEzEoFitHRc0BbVg50dOy5UBbr/hxnY3GErCGcW2lsnoJnhdLaGug2la5+PyX6HZVHyEcLUKnSPf8Y0jUgvC83xFuc9WiqednKQL7XgU8VZYoMibMmgmKUCWin3910im1RQjO6WOxS+GR9t2H89UPdjcYiekO3XxtQ14rOY1dRj71lNN1IKT4HPFddTbOQdvrNHeojrhaze/JW1XC2/HccgnFxR2QrdPkogNiJ68FZJaloZ8SfH7mEdoAVkBTqjtMYI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 17:16:10 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 17:16:09 +0000
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
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw8nYAgABivFCAAAYNgIAAA0WAgAAGCAA=
Date:   Tue, 30 Jun 2020 17:16:09 +0000
Message-ID: <BYAPR12MB2822B43B0218F6E55C97451BB36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
 <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <4037efc7-fbed-e8cf-dac7-212c65014e4e@nvidia.com>
 <eb0ffc7e-f41b-d17c-6a90-049335098cd2@nvidia.com>
In-Reply-To: <eb0ffc7e-f41b-d17c-6a90-049335098cd2@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T17:16:08.1378150Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=9312166d-7c3d-4376-93ca-0c1bb1b6d0ee;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49c3dc5a-94f8-4b05-3ef7-08d81d194875
x-ms-traffictypediagnostic: BYAPR12MB3126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31267AEF461B142437C9446DB36F0@BYAPR12MB3126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoZSV0Jgzs5uYk/Hdd0uSh8EsZvevrHBZ+AUcR3+z7sjftWvQObYM9JxyRmNdLGWYSiW7EnupfO/U0tYdSO9n0G2g1UDRD0QuUmGBp/ea5SnNU4HXaGz5O1bdkys8B9niCwHhe6hPYr9xea+kIdUQ7J6KUatjHqMJI9F7LFlwPaS3SLmNuINnyWOisiWAPmhETTiV0hceDSRQFPTblDs8BYeR0SW90vCtf5gIQr5FMeow7WXD1ahTg2W/awAatixTTK1B/GWGg44DcrxRFVKvE2i/0EF+WbCukSLDMsJht4ydTnrmb/IKWbWQXsJrUi8EZvO4EQM3kiuCvv167NALg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(9686003)(7696005)(6636002)(6506007)(86362001)(4744005)(8936002)(71200400001)(33656002)(5660300002)(478600001)(2906002)(8676002)(54906003)(4326008)(66446008)(26005)(6862004)(316002)(55016002)(76116006)(66946007)(66556008)(66476007)(64756008)(52536014)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ffo5rliOMSfvJ2bDNl0uodDl+d6TocgWCq8GIFaxaXVu9Gl5RHzthZgQoeuAwJVYsDVAKH9ri88H+NOhY4/Y/5BfdDovSyUmFCcDwFHpNWhPvFPI5H+Brc//ZNCjP5UbGsFcCnMARJWVHBQZcn41qdSO/yGrJeJFVilS3PQ6jZN/zq8ZsbXoWFSNkulMssWyvrcDIZDVl2cyRdtmpStkrme8ddxs+FiqBHglM2SKorAag47ixZ6rPJ6+MaG/em+vdB84gYLyvRPnqZtexbRLgswZiWjTv0iXVVuq/NUx78xoTHPXqZy31yJ2PjTJGkrHzRBGoMyv7rcZzYS97gYGNun0lUolksua1j6dwdh98zZzNSnafM0HD5ZkZfTQew3l7Qp7wi7fdDD7w42xeMKWADlc7z7X+t+HGrSaRh4u/0ZuMqxQYFedW/BB3oMfKfhTM5wjtmkELObyiyCX9/Hj3Vg335SK0TJZ4gFYUPlkZlyB7r8dJOs2dyQNneaLRiwT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c3dc5a-94f8-4b05-3ef7-08d81d194875
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:16:09.7947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wr4H5bsA5FtAIF0kmWiL6iiIYHO28paKasv6WgqZQZvE1MQ+KWF9SXd6rK494r8nQdJJHJyWay+NSY5WlY14+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593537376; bh=/rpWkPa4G2BpSb5xcr1KVEdWuniqSALHDaJZNgqVOac=;
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
        b=PsL9QixBsP51o7ATracMVmH1L2RSjzITpziJo81J/oGMjvJ7XhQohBdYXs7bC1/I2
         rlvSHLB04gRQPm8a5F/3hIIGhN5+NHlvWVg4W7xu3farHJfrbgr6G3kJyvr9TRwdKn
         jYCWnrcQPZiZuWz7DMdyM/F2vOYRH0eUoyILgdND3GCpbS6J0rpjg1qhmB/YE0LBVp
         dQXrNeo3LNdrd21xON4c2qMTJ0VpCbHKXMkdjfWkUnTkSTKKZEgG4ukeUo+vfVZOi/
         zBFlcJpW72wHRo0GVtD2VXOE1mSfuMZdOX5+arcOmmH8PzbjKkYmAhdrGf0Qf/95wX
         AZpvLlmiAhudg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9LLCB3ZWxsIEkgc2VlIHdoYXQgeW91IGFyZSBzYXlpbmcsIGJ1dCBpZiB3ZSBpbnRlbmRlZCB0
byBzdXBwb3J0IGFsbCAzIGZvciBUZWdyYTE5NCwgdGhlbiB3ZSBzaG91bGQgZW5zdXJlIGFsbCAz
IGFyZSBpbml0aWFsaXNlZCBjb3JyZWN0bHkuDQoNClRoZSBkcml2ZXIgaW50ZW5kIHRvIHN1cHBv
cnQgdXAgdG8gMyBpbnN0YW5jZXMuIEl0IGRvZXNuJ3QgcmVhbGx5IG1hbmRhdGUgdGhhdCBhbGwg
dGhyZWUgaW5zdGFuY2VzIGJlIHByZXNlbnQgaW4gc2FtZSBEVCBub2RlLg0KRWFjaCBtbWlvIGFw
ZXJ0dXJlIGluICJyZWciIHByb3BlcnR5IGlzIGFuIGluc3RhbmNlIGhlcmUuIHJlZyA9IDxpbnN0
MF9iYXNlLCBzaXplPiwgPGluc3QxX2Jhc2UsIHNpemU+LCA8aW5zdDJfYmFzZSwgc2l6ZT47DQpU
aGUgcmVnIGNhbiBoYXZlIGFsbCB0aHJlZSBvciBsZXNzIGFuZCBkcml2ZXIganVzdCBjb25maWd1
cmVzIGJhc2VkIG9uIHJlZyBhbmQgaXQgd29ya3MgZmluZS4NCg0KPkl0IHdvdWxkIGJlIGJldHRl
ciB0byBxdWVyeSB0aGUgbnVtYmVyIG9mIFNNTVVzIHBvcHVsYXRlZCBpbiBkZXZpY2UtdHJlZSBh
bmQgdGhlbiBlbnN1cmUgdGhhdCBhbGwgYXJlIGluaXRpYWxpc2VkIGNvcnJlY3RseS4NCg0KR2V0
dGluZyB0aGUgSU9SRVNPVVJDRV9NRU0gaXMgdGhlIHdheSB0byBjb3VudCB0aGUgaW5zdGFuY2Vz
IGRyaXZlciBuZWVkIHRvIHN1cHBvcnQuICANCkluIGEgd2F5LCBJdCBpcyBhbHJlYWR5IHF1ZXJ5
aW5nIHRocm91Z2ggSU9SRVNPVVJDRV9NRU0gaGVyZS4gDQoNCg0KLUtSDQoNCg==
