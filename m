Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C55C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B782067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jfc+zM4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgF3GCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:02:09 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:61206 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgF3GCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:02:08 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efad55c0000>; Tue, 30 Jun 2020 14:02:04 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 23:02:04 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 29 Jun 2020 23:02:04 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 06:02:00 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 06:02:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMsy/sqedPmqK9l33QckMR5bDUmKmIJW5WdMJxuSypIwoI5DOZi//M5B6oTZCexrF590dBypdAEi/iQKjFC2BGjirf5HZgrvLaZoEvY57dKXKQ0dCZm/yBVucZ157xb7wq+p0Jos4LxnijhEoSTu+tJtDQG+fA0Jm+HAXkHJfoktnda9PrQfxZqYZFaLwSHZsn/hnU9GgzokNUplm9CE+E03gq4DO4B2z6hNb2G2UBuyNXv9j4RFpyFQ07vpeNCXMS7oIb0+W+CSGgGvxrlTYMnawMwOSxmH4E/d4LS8CQr9XhTspEG+CL1eC05+fWuVCKZRSxnO7O7C+InAljOIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVZSUaYWibtWpczBQ7tn2VIEEN4xN6koSkrkaROfdFA=;
 b=l25pXueQHeBp9BUcDL/3+WxCopnnBGwAN4IWGARu2uA0axoCEqlvhlBu/BJZiTrVBi2FEAuPejM5vgQBeR9g7FekUpuLunRBFU1pePBNX1mucx6mZau1g75xSKENIH+DQhRtGrWSGTneQNfLj1v9UtIm235s+yN+tl0aU1yTLWqaj1zWb948uR2pFFEypCMdOuP0W9Ulfj9H5imyxwnHvo1TUDEPDCMI44xHv87/NndvTkkUQM2154snpFOFIAFfuxak2wMCwP/HkG7QufNxKETMr497x8sOGAPwVefiLtYmGKbE0juCFBEwl3atG5AGnWQgjV/8h5NVHw8l8FFtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from CY4PR12MB1688.namprd12.prod.outlook.com (2603:10b6:910:8::15)
 by CY4PR1201MB0024.namprd12.prod.outlook.com (2603:10b6:910:1b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 06:01:58 +0000
Received: from CY4PR12MB1688.namprd12.prod.outlook.com
 ([fe80::a976:61a8:970b:d874]) by CY4PR12MB1688.namprd12.prod.outlook.com
 ([fe80::a976:61a8:970b:d874%11]) with mapi id 15.20.3131.028; Tue, 30 Jun
 2020 06:01:58 +0000
From:   Pritesh Raithatha <praithatha@nvidia.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
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
Thread-Index: AQHWTnLtWwYDUzAjrEeBmIPTY7U1fKjwqqOw
Date:   Tue, 30 Jun 2020 06:01:58 +0000
Message-ID: <CY4PR12MB16880A45C948A0512EADAB72A26F0@CY4PR12MB1688.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
In-Reply-To: <20200630001051.12350-3-vdumpa@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=PRAITHATHA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T06:01:55.5565190Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=c3eb4c61-a18a-4ec0-9529-f9e844ede887;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [202.164.25.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b79122b4-4965-4946-25de-08d81cbb1967
x-ms-traffictypediagnostic: CY4PR1201MB0024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0024BF9683DAE7ECD03B9653A26F0@CY4PR1201MB0024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfhcwJ3+51b4EY+tB669Uxk3dfGzxTsVhP0jMo4o5CgKkDHXC8Yf1plTPT+wF4bE8JhYelYFSSEccYogBv/CHD3Zkz7NxE7TokY24Gbm+t2wO0ytosbcB1qFBfgDUkx2Uhh1gDcHUZ+DdK6M/5UtnZrYjWRpMOmyLiuCgU2Us8MfqQPAH+9gHkdxl39X4xYo0pKbjq5ugyaWMZJYdOSq/77JXK7/NJYJaaDXcCaf+TZNwFq4+VE5k4KzJYV9ajKES4Ku4OyKf3q2jofQNQauELpHR9pDqJSFFZ403lqXy/3GUxbXuc0CZprjGMgU/WJb5WbVlBco3w3NzCB1OO+jBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(5660300002)(55016002)(86362001)(7696005)(9686003)(33656002)(6636002)(2906002)(6506007)(316002)(26005)(66946007)(76116006)(478600001)(66556008)(558084003)(66476007)(71200400001)(4326008)(8936002)(66446008)(8676002)(54906003)(186003)(64756008)(6862004)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jy29o5yxd8LT6mYVPV9OwJ+y9vLNOHJjlUydxLMmz6RTRgziE5ao88IsIN4kHjErQseOsBvf3izboG+9YQu5SBA99D5Kvlvw/ka1YCW+pTdr3bGvEFvytxySWHVEW+rWKWIwDUTAouqAWpt2PXgzFKrQOpCG1BaKBdUTzfVyrzm2Kqoz2PL3dPO/UE9AZnD7KsW7tWOAxvBvryPhc64PzWiZ9+e5mg/t61n6FFmbGydYR8TKH1rczv25UeRBdxX70Q5BseeFKTJ5jX0S/Lia6wzO12h8F7HWpCZKVle7LGBRr6oweZn1MaLVGIyJTgyxJTxcvyBjirpwcEsKpowctRWLfDs8iktAMYK8+YS2KLyacRm1LSf+UcmrXZC7tvLZZUbJ+CI9EXckuQptcB+LG2QleS5knCpQ9Al4VhKvVbxGMO22R8dhE8jdJ8kyq5XE09M1lRMiOdE2vHqSEWIPjrxnS2+wk9Ygdt4jG61YIsg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79122b4-4965-4946-25de-08d81cbb1967
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 06:01:58.2088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKOugohPM7Np/6XiwSR8aWbD29qezabIPqaezFRtWHSVMsu+ac14i8MYtSWQa06kY1Mn1uTqDvGUfL+IpLIX/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0024
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593496924; bh=lVZSUaYWibtWpczBQ7tn2VIEEN4xN6koSkrkaROfdFA=;
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
        b=jfc+zM4DWUfSJCAbDvmcrJ7bvSopmRkGI/GBRY+Rl6OC5xGsu0LKGsScJgXJ7JgPb
         FN77DLM+TvGhLMROT0yzDgdo6aTEJiJ5ISUY5UABgcs0weIvuTzJRME0Ta1T9lJtJO
         d6OOYCpqwJkTHYVddqonxyXhoV51GdJYLLTQ+qF0/C39KtMbF+2EPM1IE7v5TJ0LVh
         3cM5c1eRwwb9gkExcMnBuusDcG9QNnots5g28y9XpgXPGyDwkb5FSsf1nnldLo5PLt
         SYNSzkj/SC0ZpBpcXuby7idjE/Tzw4v5FIsZAKpCjS8AZReHNFAxLtfE+gkj4AqORs
         NlrEXVSxoC9pg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add binding for NVIDIA's Tegra194 SoC SMMU topology that is based on ARM
> MMU-500.
>=20
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Pritesh Raithatha <praithatha@nvidia.com>
