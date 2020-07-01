Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CAAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AF920720
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Lnv8OCuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGATNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:13:09 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:36618 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgGATNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:13:07 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efce0400000>; Thu, 02 Jul 2020 03:13:04 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 12:13:04 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 01 Jul 2020 12:13:04 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 19:13:01 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 19:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgwNwq9rbBiALnUXz+JaORz6a8rLYydQbVLRg3e1qMfV41NgYXRLKXftomJsMZYR4nxnmhJgqs6WA/LL/242biS1Qf2Hr6hXSNvpkBvpq9W64MbqnbLKYeByr/tVG05YkJcaO7qcJggq24z87/NYIY0rHhY2Khdi45qyvvxa5I/FakFqwIQog6iPkiduJ+Y4vVtprlkNvYAbbsIlbb180KG/yHMJxXiis1d02AAlcdmiFcFDS+lCexzqk0EUA9mTWimdaTkqWlEdkQGepAWTzAQjOYIi21e0g31FvYdkPI490PkTe3WOmRVILswKJeB4K5+qfEUAqB16/JIvPEMtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+DCbWdM2AccvdrArNCVCFMbq6nuJsqGXo1K/awn6Ac=;
 b=doDnGq/c+TOAZSWpio4QTixpJRbqslfPd0T9N4ZFoWO80Qg6e04qkZgwnIqXlKKJCrnGe/QvqYZVTz7z5rAMVrNzJTcXHNrUhQdqzANzCIKPORI3RznxSflZxmEH2GVl/vTijqAsWnBwqXy+v6s/tYOec60mCFWLWO32dUyQZbS0qeqgecqKa9y733Gr8dHs4lQ/k4PRvDCfPK0byiYe3hCnFxqKPc2B4YI4HH56TKHRbbL13zId0+QlNYrsIvZwUA3epQqlLtwNAgXeDa1Q6v3mh+ewYT1KbT0bE6Ue381L2XOTs+xpLqjUISUPG/bMDBUghAK2bKlrZYeltxczAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 19:12:59 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 19:12:59 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Sachin Nikam <Snikam@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "Bryan Huntsman" <bhuntsman@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pritesh Raithatha" <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Bitan Biswas <bbiswas@nvidia.com>
Subject: RE: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
Thread-Topic: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw0WKAgABuEYCAAcm6kIAADIaAgAABofA=
Date:   Wed, 1 Jul 2020 19:12:58 +0000
Message-ID: <BYAPR12MB282210175D43BF649E2C5F87B36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
 <d59b7220-168c-419f-db16-194307e11065@arm.com>
 <BYAPR12MB2822FC263456303302EF30BEB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <9ae6b6e6-bd64-9c89-49ca-1f5785ef3f0c@arm.com>
In-Reply-To: <9ae6b6e6-bd64-9c89-49ca-1f5785ef3f0c@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T19:12:50.6469575Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=d8b63a6a-9004-4cd8-b330-3096cc1e2070;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca27dbad-2144-4516-08e6-08d81df2c49a
x-ms-traffictypediagnostic: BYAPR12MB3189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB318960760732DA1DB046AAEBB36C0@BYAPR12MB3189.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pi9eumPEd74dd8hf06SIonupWQdq4OO5g1MUdTvc0GXplKaKw5u9yA7NlYGq5Mj30fs9/CG+V3IC4n+t2Vt4Uo14y/Ak/w1DEuyhwcNKTTdgx7vz+Rb1wA1MJU7LtdwwHVdYQKpMlXfpF1x8+UX0Zs82pKmma21fzBE3bdYDgHp9h09LrGd2nE3DI0KM2J54bZJitmSqJ+DzlCWvznkEowYXCgrgu7qkpkuNQ1COr8A9ls4gLIl4ahe78VpnUwHAKTSHlEmQJb4Os/6O4VmxeeuHBf7X24s72eau+0IcetYCs4JST/x2HLHY3xuagxjs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(71200400001)(83380400001)(110136005)(54906003)(478600001)(107886003)(8676002)(52536014)(55016002)(4326008)(9686003)(186003)(316002)(7696005)(66946007)(4744005)(66556008)(66446008)(64756008)(76116006)(2906002)(26005)(8936002)(6506007)(86362001)(33656002)(6636002)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Dky7EQMwdlkV7/XVXvp9261PFQt27wtFhuZSB0chk3xyK/DFOe3AsG8QRS5fTgwhOTXJx3facq+9hGc7RQgciDCa5TsEe1OTH3RfZz0L9xVrNWQhx8aaqTvT9gVPmYcKtNUw1JvOnRrmppCueJmZFytOOMjvjoCwNt7sbGccaRDutbl4PtNJs0lN1Vbjb5ijydj/PiBGoT5d4sKTHDtIbfgRfUYpBxKizYvtTPJDyE0uco5G5626WNcIOuOA+wAu4jJ6NM7U5n+qQWg8C+8fc2OSIeBj9if1pfVSphmmRdQ28ClQZzGKrhb296OtnrxCOokGT/xzmEZ7j7VjQNjIlNOwi9oEejtqQPs8mYu1w7REz2vkBawn1yUVHaPSvBK2MnwacPmMIUO4tpoVmrLxGvkEQ+gjwg9hWHQYFjRX0KIRch6D/ePsPAx1ZiA+JF2iOd7rHKWUP1oX+rFsVfDncq9ox/ZLkHCyS/+qkWT8ywyQLrD/5frPET+3bar+D9UF
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca27dbad-2144-4516-08e6-08d81df2c49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 19:12:58.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Py+3Upf71qcd8I0n6Uul7sSEaVoq7maVYnaBYV4qWb9H1RJMMzUzM+d2ST8zLJ2GbML98pDH+30Uvm3iDj84TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593630784; bh=z+DCbWdM2AccvdrArNCVCFMbq6nuJsqGXo1K/awn6Ac=;
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
        b=Lnv8OCuzEV5shEkuvExPt27jFn9jhZRi3j/NOEMZLHllT0lYjLzuHtr7foMryX2UW
         zAdHihbEIHiuYiSl298lvgoCUGjsPowsctsE0jFHnG4JQ5Ap+04cWY5z1i5Yn9PspX
         YEZ6kqOJexIlmEhXfF4142scp7pqwIF1ZmzvUtE7KnyVF593cssOiMRLjbHlRjeA5h
         Ox8pwCwvDJCizZ1xFu193rOHCJdJSG/3kC1saYZZMWJUjEoOgFouUndnCfEq8s09wU
         tcxtxzhYfzHCS8neau9GlbDUhY9pjohnl2A4mj44EV2YVpXzyf2n4g87A28VlEcQdQ
         11foluoI3FLeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PlllYWgsIEkgcmVhbGlzZWQgbGF0ZXIgbGFzdCBuaWdodCB0aGF0IHRoaXMgcHJvYmFibHkgb3Jp
Z2luYXRlZCBmcm9tIGZvcmtpbmcgdGhlIHdob2xlIGRyaXZlciBkb3duc3RyZWFtLiBCdXQgZXZl
biB0aGVuIHlvdSBjb3VsZCBoYXZlIHRyZWF0ZWQgdGhlIG90aGVyIG9uZSBhcyBhIHNlcGFyYXRl
IG5zbW11IHdpdGggYSBzaW5nbGUgaW5zdGFuY2UgOykNCg0KVHJ1ZSwgQnV0IHRoZSBpbml0aWFs
IG52aWRpYSBpbXBsZW1lbnRhdGlvbiBoYWQgbGltaXRhdGlvbiB0aGF0IGl0IGNhbiBvbmx5IGhh
bmRsZSBvbmUgaW5zdGFuY2Ugb2YgdXNhZ2UuIFdpdGggeW91ciBpbXBsZW1lbnRhdGlvbiBob29r
cyBkZXNpZ24sIGl0IHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSBtdWx0aXBsZSBpbnN0YW5jZXMg
b2YgdXNhZ2Ugbm93Lg0KDQo+U2luY2UgaXQgZG9lcyBhZGQgYSBiaXQgb2YgY29uZnVzaW9uIHRv
IHRoZSBjb2RlIGFuZCBjb21tZW50cywgbGV0J3MganVzdCBrZWVwIHRoaW5ncyBzaW1wbGUuIEkg
ZG8gbGlrZSBKb24ncyBzdWdnZXN0aW9uIG9mIGFjdHVhbGx5IGVuZm9yY2luZyB0aGF0IHRoZSBu
dW1iZXIgb2YgInJlZyIgcmVnaW9ucyBleGFjdGx5IG1hdGNoZXMgdGhlIG51bWJlciBleHBlY3Rl
ZCBmb3IgdGhlIGdpdmVuIGNvbXBhdGlibGUgLSBJIGd1ZXNzIGZvciBub3cgdGhhdCBtZWFucyBq
dXN0IGhhcmQtY29kaW5nIDIgYW5kIGhvcGluZyB0aGUgaGFyZHdhcmUgZm9sa3MgZG9uJ3QgY29v
ayB1cCBhbnkgbW9yZSBvZiB0aGVzZS4uLg0KDQpGb3IgVDE5NCwgcmVnIGNhbiBqdXN0IGJlIGZv
cmNlZCB0byAyLiBObyBmdXR1cmUgcGxhbiB0byB1c2UgbW9yZSB0aGFuIHR3byBNTVUtNTAwcyB0
b2dldGhlciBhcyBvZiBub3cuIA0KDQotS1IgDQo=
