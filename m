Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52368C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0E620747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VSlTYD6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgGATA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:00:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17458 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGATA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:00:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efcdce50001>; Wed, 01 Jul 2020 11:58:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 12:00:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 12:00:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 19:00:25 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 19:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csGnbFggm+cGQaki/bTCi+M93zyie7VIHL1/wSX45VyC90vZJPpkao8AmHBN+4MiFpgTcRcJa6aqCpOpXUnxyBo5O0o6QgU6CxWePZy8ehe7C6BVUDOWPjCFuoppWB05xQhWN1H8zsO6Clgl4fWMIZ/M1JiXdLGd/PBgMjClDt4WO4oV5fTcp1n0+zKsQneQJF7uUOsCyrs26vnGaRLQj9nYAq65vzzop6ENoZHQqZov/CBoeHIW/tF2Isbfy8kovFItuPIvVMD3OmcGrRgsUZJXRFUM51GaIwAB1urjzRdwNYNhYy2afDltDte+FPNmDdOaMYm1UTDGCjJgkblmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqWGsFp49I3q2K3JAL9PPUBgrphHBlcmniWTcaEYd18=;
 b=kZjEtpik+r97uf8SksbA59694z8+nnd4fl/QwofhGVghXEDeDW/utjANI5rW7HfUANedeYyDKc4PQHQHTpPOHHG9bMKzxjzsrRPTRKNHpFQBG4wEjTePLuU4gXHJIXfZGEj2KWC0SW0KNf2+Dg79sCQZprqSTXzFLJU7iRSFHK6M1S1S0DiwLa64hK1NyiedKttC1DeW9y3BnMgL0Wc4Cyq046VEtbJ4sRqPAtsmf+lumnnki//NvOoXi8UIO6dR6K7w1FZhMXWWx+CeaVZHP1WAOmgd3BP3JrwsB5WkL/X+8H9ios8ulFAUpoqLwgj+8qtY+/C59n/AYVfYeSRNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BY5PR12MB3795.namprd12.prod.outlook.com (2603:10b6:a03:1a9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 19:00:22 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 19:00:22 +0000
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
Thread-Index: AQHWTnLtO+c1bLqxQk+6SvUQTirpX6jxFsYAgAH0qfCAAAfXAIAAAiQA
Date:   Wed, 1 Jul 2020 19:00:21 +0000
Message-ID: <BYAPR12MB282245DD6BB50ECA700AC69EB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
In-Reply-To: <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T19:00:16.0734995Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=fdb2a29b-e17e-4027-8621-051533513461;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aa1dc65-bc72-429d-9f13-08d81df1015c
x-ms-traffictypediagnostic: BY5PR12MB3795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB379509C96A7B7BF3BF3A6DC5B36C0@BY5PR12MB3795.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6y95LW5S9DBVdiBQWzWv09ELj5pbM/FrRZeyk9aNDygDuzJyz6GFjdTwYZH2z2LLq7K7btEBKyh9lWzBTp96oiOyNsBQy4Yito3KrVYRcxwNrehnxHShHJ6AeFXMi1zxWZqO4wBT0x13FlSBp6jPDgvxF5/+rDLrs92x6gnIaUdvW9Hx2bmsg2FoWpn3oRw447K+4ujd/8DGYlwPWYAGvGESmcZDxysqeIYG8aOafBS2chOo8QG6t9flSULFKbtLsCrMrrUmC90YlvMZi4pcnDwRZX3XlLa4C45IzTt5fUHNn+pO5/8EojqniDa+YMAf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(55016002)(83380400001)(66476007)(66556008)(7696005)(66446008)(64756008)(4326008)(2906002)(33656002)(478600001)(6506007)(54906003)(316002)(9686003)(110136005)(186003)(71200400001)(26005)(86362001)(66946007)(8936002)(76116006)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8fz7jYVIayBCiWs/J8eimJ1PJL3oHtGlIZdfnIRlrPYgluqPMRdYqCr/y7ZeBGAIQLF7r+Ncqr8c7q/zhIad9GRlMaizH2/BMbDLy0LbduouOnRe4XrjsWDVMa+0bVLex0qL79q65Lud3hwyRy/8ltdTq2WTyXonJ/TH5wlrysFOeSO04xC7I5aHmgGWFDi/5ypFqgTsOXHEGDWmXH8AjhZVvRlnK7VrRyPC1Ww/8eFCurtIjAcPqrTH+2JvcgGHR6dBpv72XvfB9hG93vzppz8EpYNwZg8mEHYhg21RpgJZbMCsnr7U7yPRWMBQGpSxsk+2hTVZnz5qfLPan4Ga7eiKqMjNqEyNwN5Lh7bbJp/EFGApJsKw8kdD3RkLW4NEXn6/4Ure/54YB939I+3tzZt8Nj4SJLy342IB/O1sFzjczy7ZK2dDCW8GCLWC7/BKP71L/oWyOlEEb4ZVBn1wDFsVP4doEpidkCUKwgw8sjgWV65GpmtpEDqv7mjonSMH
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1dc65-bc72-429d-9f13-08d81df1015c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 19:00:21.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mj29hfH/ToKkeA7CsJ49hoc0b3lM59FAZYfktJ42QS7U5uTyrBFLYF4qJvcti54kxqnKc5LTwCHmnaamgU5o1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3795
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593629925; bh=DqWGsFp49I3q2K3JAL9PPUBgrphHBlcmniWTcaEYd18=;
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
        b=VSlTYD6FW92jvzFhwuddm4sffVUongyYF9hz2MliI/GJPjH/BjY1CE7q8LCzTd3XC
         Byg+yIug43S6H7wry9QIsoh+Fg40iKHn2Ogn47bHokRKWbu6da759QeSigUOGkD2CJ
         8TSC92MKvHKDqJ4iDm7qnVatqEqGlvi/o5TSu3uoQnmq6U8iWH45CjHipmDB0Jg4Pv
         no/T7dExRwH2qppIHRuAW73o7XIZvZ35trsmPSNHTulTiXNrfhnvLbLeqQEVOE8q9v
         i61JJNXp682G4trB3LbwE4RSHbm/EYZG8x5MTrCbXxgxTlClBqgQEKo5XzyQcWMAxJ
         tNRQ7Vgro0J3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+PiArICAgICAgICBpdGVtczoNCj4+Pj4gKyAgICAgICAgICAtIGVudW06DQo+Pj4+ICsgICAg
ICAgICAgICAgIC0gbnZkaWEsdGVncmExOTQtc21tdQ0KPj4+PiArICAgICAgICAgIC0gY29uc3Q6
IGFybSxtbXUtNTAwDQo+ID4NCj4+PiBJcyB0aGUgZmFsbGJhY2sgY29tcGF0aWJsZSBhcHByb3By
aWF0ZSBoZXJlPyBJZiBzb2Z0d2FyZSB0cmVhdHMgdGhpcyBhcyBhIHN0YW5kYXJkIE1NVS01MDAg
aXQgd2lsbCBvbmx5IHByb2dyYW0gdGhlIGZpcnN0IGluc3RhbmNlIChiZWNhdXNlIHRoZSBzZWNv
bmQgaXNuJ3QgcHJlc2VudGVkIGFzIGEgc2VwYXJhdGUgTU1VLTUwMCkgLSBpcyB0aGVyZSBhbnkg
d2F5IHRoYXQgaXNuJ3QgZ29pbmcgdG8gYmxvdyB1cD8NCj4gPg0KPj4gV2hlbiBjb21wYXRpYmxl
IGlzIHNldCB0byBib3RoIG52aWRpYSx0ZWdyYTE5NC1zbW11IGFuZCBhcm0sbW11LTUwMCwgaW1w
bGVtZW50YXRpb24gb3ZlcnJpZGUgZW5zdXJlIHRoYXQgYm90aCBpbnN0YW5jZXMgYXJlIHByb2dy
YW1tZWQuIElzbid0IGl0PyBJIGFtIG5vdCBzdXJlIEkgZm9sbG93IHlvdXIgY29tbWVudCBmdWxs
eS4NCg0KPlRoZSBwcm9ibGVtIGlzLCBpZiBmb3Igc29tZSByZWFzb24gc29tZW9uZSBoYWQgYSBU
ZWdyYTE5NCwgYnV0IG9ubHkgc2V0IHRoZSBjb21wYXRpYmxlIHN0cmluZyB0byAnYXJtLG1tdS01
MDAnIGl0IHdvdWxkIGFzc3VtZSB0aGF0IGl0IHdhcyBhIG5vcm1hbCBhcm0sbW11LTUwMCBhbmQg
b25seSBvbmUgaW5zdGFuY2Ugd291bGQgYmUgcHJvZ3JhbW1lZC4gV2UgYWx3YXlzIHdhbnQgYXQg
bGVhc3QgMiBvZiB0aGUgMyBpbnN0YW5jZXMgPnByb2dyYW1tZWQgYW5kIHNvIHdlIHNob3VsZCBv
bmx5IG1hdGNoICdudmlkaWEsdGVncmExOTQtc21tdScuIEluIGZhY3QsIEkgdGhpbmsgdGhhdCB3
ZSBhbHNvIG5lZWQgdG8gdXBkYXRlIHRoZSBhcm1fc21tdV9vZl9tYXRjaCB0YWJsZSB0byBhZGQg
J252aWRpYSx0ZWdyYTE5NC1zbW11JyB3aXRoIHRoZSBkYXRhIHNldCB0byAmYXJtX21tdTUwMC4N
Cg0KSW4gdGhhdCBjYXNlLCBuZXcgYmluZGluZyAibnZpZGlhLHNtbXUtdjIiIGNhbiBiZSBhZGRl
ZCB3aXRoIGRhdGEgc2V0IHRvICZhcm1fbW11NTAwIGFuZCBlbnVtZXJhdGlvbiB3b3VsZCBoYXZl
IG52aWRpYSx0ZWdyYTE5NC1zbW11IGFuZCBhbm90aGVyIHZhcmlhbnQgZm9yIG5leHQgZ2VuZXJh
dGlvbiBTb0MgaW4gZnV0dXJlLiANCg0KLUtSDQotLQ0KbnZwdWJsaWMNCg==
