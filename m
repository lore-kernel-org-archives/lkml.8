Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C3C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCAE2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fWxI/9ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGQWgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:36:38 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:42781 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgGQWgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:36:38 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1227f20000>; Sat, 18 Jul 2020 06:36:34 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Jul 2020 15:36:34 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 17 Jul 2020 15:36:34 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Jul
 2020 22:36:29 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 17 Jul 2020 22:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX9zrvKHyh4lW/0GZ31SPDNDvtzFan1i3T5OdskeUeKBj1yzVegK5KYOzjlJX+MPbb8QnMdFAkPvmsmnkTwE4gVTLvznezOofeHyA5r+55OYUBm7tQOeMkLic3AVdkcNcCBk8oPU5AWmM9lhR+umCKDcPetucG2j8+n7GDRhRKSyt0LIhXSfQsXRt3aZAIRqlbNJGnJO8WvmtYEMllLzas3+hpFSbHfVQ5o8fblTc1stpohrPCrJwg+R1zP2Xa5cjX+ypoM7fJVmf9QZ6bqY0DqCbEjlczZGHRcaZG7+xHn+dp/YFWf4DTpCJL6UW44sxCoYD6y4x6IxxSI0sCGSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkrYAjYfVKTm/Fz1tRs8wCjeVh9SOkeqD8yWVv7kcp8=;
 b=fErKPcCzp2tTBUbj/LmwxO6yQnENgE87toag3iZ9/nMGHDIc9PI5zi6TQaHJ5JMjA9U3m0YOIaAKtkB1HzvTSld0DgYVdI4//5uwASmJb02rCvQVcieYIIaqhWgxpJQkz425HYxEojDQCtsVo5EnQL+dU9b1NSLp4ixSZlnCYrzyXNqDbnvXJwtXfScY9PEz+C7FM1UH88hblnlOVXYn5hMoBqJ94vTYyR/L9wO7SbrVIjdrJX+FLkrYJ09p2y/oZ8c2nBwGbcrUBkBKdVpensfZVtkdeH4x/VXKG4rpM3/v4a1pHYvUUBlU89nm2fFAVMe7qrEx79bzCU/+aiLqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB2821.namprd12.prod.outlook.com (2603:10b6:a03:9b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 22:36:27 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3174.029; Fri, 17 Jul 2020
 22:36:27 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Thierry Reding" <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Subject: RE: [PATCH v10 0/5] NVIDIA ARM SMMU Implementation
Thread-Topic: [PATCH v10 0/5] NVIDIA ARM SMMU Implementation
Thread-Index: AQHWVOS0Ssba+jgpK0ibL49hlWjwHakFj04AgAYJ/QCAAM/dMA==
Date:   Fri, 17 Jul 2020 22:36:26 +0000
Message-ID: <BYAPR12MB282220FED958EED2AA6AA860B37C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200713135020.GD2739@willie-the-truck>
 <20200717100337.GA8673@willie-the-truck>
In-Reply-To: <20200717100337.GA8673@willie-the-truck>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-17T22:36:02.8245596Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=a8b4efad-5909-4d32-8ba8-5e4fbc13f4f7;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [71.202.129.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f43ccf2-27ac-475f-82cd-08d82aa1d7c8
x-ms-traffictypediagnostic: BYAPR12MB2821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2821AA084A4E1372D78CE5FDB37C0@BYAPR12MB2821.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLJkIttkMXZGf96T4bUOiYtNSr+kP/Qs5zMNe04Kltc/5ertyWFunuEAjk89x6U67PoBPwLvuUCuqH0QXd8DqMT9fjiSlj925qtnjiXVnAU9d9WOPNag+BXIVmX4/p4QGmiMo3ajttG4bLljDvma7i1ZrUg6nteyRD6kAd8k+z47voE3MMTZSbmppRFc6FDBuY8KIR9KOC2xOmjrM1CvoNCxh/C3C21AKG2m9UgW7SQn5eQCxH8ovsQ05+3t6AuDHaEx0iasWcGvwqQsyRCeVM17C06+uuPA94+XV9o4i6c3V1JNQdZ/IXMm/H/4F0PI6C2lC3jWOVZU8lkciU8yzGPCiQJ5zeoj3iUjS+55fU6ceXM89VGqi87mxBfT1UifDfyNQaq7f8ajAM+JBVZ9CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(76116006)(33656002)(66946007)(66446008)(64756008)(71200400001)(66556008)(66476007)(5660300002)(86362001)(6506007)(7696005)(4326008)(2906002)(52536014)(8936002)(8676002)(4744005)(83380400001)(54906003)(186003)(26005)(316002)(478600001)(7416002)(55016002)(6916009)(9686003)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jJ5uhKVSRmLjUag+gCG/mb0KPdIlinSiFT46whYv2yVsEInnT4cJjWlbDBFT/p9IZAp10S09KzBcrjAsP/NKTkO3zHPO4xuMNPid1crk3PAA0gHDUKPnVgRTls/fyd3MJpkDQ+OmyX+BLmM6az2qDMO0UDX944tN+d2b9s9ltiYXD5Jo5717xJSkbzG4aEhHn4G73HdJrZMqZ/V8MCu8Lc7VuGxtNbANv4jbbMO82Mkijx01uaMLLFHDS4rIqmHlsnNlhmios9a6xCrcO+QOaruzkyVUpXQMobRfN7GhjIV6zG7G0R6fc66yYPJ0lpFcW7HaeZkRFkQdqpVuLVNmqswhnuliOo8XAoNR2v+Y5vD60f0AsIil1c0k6A/q7KendjohP+c1/vhcl0ibMM9NA92Heu+iro0pcB8TCJPrlwFfkjkO9j0FC8oLiy/KLFVapjaqSGBR8kiFhF57Do5ozwEon2MbbJ21p2OfjLgbFSQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f43ccf2-27ac-475f-82cd-08d82aa1d7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 22:36:27.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTEiFUDXxYcavpU0OcvZE33pvO1K9tTMZdzIGWhlAQSMw0sXbD+cqb6mTnBV/YGfiiMieC3zhKSXTe3m58vGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595025394; bh=UkrYAjYfVKTm/Fz1tRs8wCjeVh9SOkeqD8yWVv7kcp8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         MIME-Version:X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=fWxI/9ONLx4mZ4H1aNPRira/xOuvxRETYb6iW34eOdkfkfehvHAzx6N3eWveNHOOL
         WdPk3t4teVq9PYER6+b10nQRVJEap9p2vm4LAMhKMO5TlxwaKakdX+20mLRxWNltIG
         MYDjFNOjfmxwtu5R/FEEWw6K2+hnJD9/dnhM2xfZjvms3WMz1sjDhKPTuNyftBd0SB
         My3wwjB2njiaaQsYcaXRfbngaU09f0SDjRFuTIz7EXUsumJJgpQtX9B0raIBZX5FIS
         CIbYUTBDY253vEg2eQtE61FKHZRBEGuomPXpJ9D9HYE78AaWGpyc0v+Gh/vVmPKCAc
         xp9cAzbXr4jpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Jul 13, 2020 at 02:50:20PM +0100, Will Deacon wrote:
>> On Tue, Jul 07, 2020 at 10:00:12PM -0700, Krishna Reddy wrote:
> >> Changes in v10:
>> > Perform SMMU base ioremap before calling implementation init.
>> > Check for Global faults across both ARM MMU-500s during global interru=
pt.
>> > Check for context faults across all contexts of both ARM MMU-500s duri=
ng context fault interrupt.
> >> Add new DT binding nvidia,smmu-500 for NVIDIA implementation.
>>
>> Please repost based on my SMMU queue, as this doesn't currently apply.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=3D
>> for-joerg/arm-smmu/updates

>Any update on this, please? It would be a shame to miss 5.9 now that the p=
atches look alright.

Thanks for pinging.
I have been out of the office this week. Just started working on reposting =
patches.

Will
