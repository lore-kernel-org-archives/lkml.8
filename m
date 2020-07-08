Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F3AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7304920775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="Ub5w/lnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGHKDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:03:32 -0400
Received: from mail-eopbgr1310043.outbound.protection.outlook.com ([40.107.131.43]:36509
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbgGHKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYwXTlZ2eJtH0FqTNo3NSCT/vHvPA9XZsjUUfBQk5OI853Awck6ilOWA7UXBteN3x/FTXlx1pKtPObp01PfAZTORmb59QRRmJ3MBj6BS44/092sQqjHMJTF4izspgLaXRjojsunl9sULcT8RP7ztdbddZvjBJ1eZv1FQVvJ3zaYboTCi6U3tBcXTecBAYjoe6LNjeLm7J1q15X0TzhPC17t4hiYkMGMqNTJvWKCwwxOYkbMa9vbYGoYxpWh3y6RqBmmqX/aDjMdpW6x0Wvzyhn2XrxyvGULywx6UBvJyPkMPZ9jIFxpjNyVIrwp4xgZOXb4cZJ39nrKXLFZqUTlx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK4DFEGMRz2UGxaLw9hL5pkxsR6bM3pSF8IetCs1Hcc=;
 b=UG1eBMnKBZ+ZA8rAPaPIMzCrgZ2OXQzTlmdrpxojL9c7Vlg+0v1Lbrptb1788boIvONIqxXaOgLN5IRG93jRuZR+xKjMicf95hbgFLxpxfxZouag6X1V1mkxzCBT7gaWWbE65lh627ATkYbZPdBimouzlzj1WvNisulgdE+sq5xounxSHRz352VSodIVkzzkpFws4EbX9EM31UNNNPfG0iyGEgrxzWI0KNP+MAqDXXpTKs8fa5S+zA+lNQBbnmybD2x2PQk2sr48qkuP+Uxj0kmj705Kihty60mRW9YUKnsX7VXRUzoP/AW7DQzZLi9P0xuKGOi7oMBSCk2IibZtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK4DFEGMRz2UGxaLw9hL5pkxsR6bM3pSF8IetCs1Hcc=;
 b=Ub5w/lnSzq0/CTvt2m42HqqslhC2xCygu6ZeFbt0UarbBVyfkDq9PZ0QwZkShP2WEvS6c5vd64fVqOANGmR2HRBNym4K/8ezVCAKyhIEC1V/potgursWJpOu5tT2zLiCfvq/H0mhPhd1azN2Rh2Dp0a3N2DR2tHY0a2mIhiYQ3Q=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HK0PR02MB3042.apcprd02.prod.outlook.com (2603:1096:203:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 10:03:28 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2%8]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 10:03:28 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     Will Deacon <will@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Topic: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Index: AdZVDnc5+YpMVDDhTCCDDkk4WgR86A==
Date:   Wed, 8 Jul 2020 10:03:28 +0000
Message-ID: <HKAPR02MB4291B970192A023778445B1BE0670@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.255.79.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3271dda-4de1-4ac8-ed8f-08d823262996
x-ms-traffictypediagnostic: HK0PR02MB3042:
x-microsoft-antispam-prvs: <HK0PR02MB304257527B7ADD4277B74BD2E0670@HK0PR02MB3042.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUMQc3I4jAbO/EiVmOqbbPwpTqf2Q0SH51If7Vy/gNiOMhKPQ5OENwEvpi1wqOGOWZI1JG0fAyYDZjeZ/qcPDlb94CMTChYCWOn7rWMMrrxRgQYCURwaRmChl5CCn4nz0sks7yybEqlufowvsg08eZIYScCOOEtwFD95VROvAUcimib6krvupsivemLepm0TYkTh4+5GfU5DX0f4arbLXxsZbsNZ2FROfoCjj2tcmKEDP9GagsUmeVX783HFHcyMVlFoqwOPFoQU9mMVZRETSAqfcfWXWSCekTBlf+0fJZa+fjNNWDTNqQVz2bsEnPhGtACuXTQje1dQuqC2+AAkrBQaY0L7eFrEiHE7Alzz7A+XxXAcFc8anazQ5vhMo/ZK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(396003)(366004)(26005)(55016002)(7696005)(66946007)(86362001)(186003)(76116006)(8676002)(85182001)(6506007)(2906002)(8936002)(52536014)(478600001)(83380400001)(316002)(5660300002)(71200400001)(66446008)(4326008)(64756008)(66556008)(66476007)(6916009)(9686003)(54906003)(33656002)(11606004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oyZn+OuiWj1wcfUmiG9ZI/B7LqKentyT6y4IPrJ86yWA+T8mr/w9R1MQLzvqeO4eBWAlPaenf8Nvrq3LmzM/TnFUpTs+35uiMoftUTUpuMDZAih2S8ctSFp7Gjj3em8F/SqCgDTa25RZf66BzGpG4a2A1CiAN8ibl+1alaGBk+Szv1EJSUGfQVBcSsQgP+RMIZQWvK9DltToOyc9teEX2gqWkLcWd9lJWIFzG/jlvD8SksYuuVUHdfAFsODi+7IBLYTiPJgV/u1NTcWGWt3Xy6prRJrP1UwSIk0a7s3m8uxyiddbvsnGwRcPI5AjhAYoy7g9R4k7xFeVDyVym7LRihxPOsJiHKHW+OhILS1De57kO0rP1imV/WF9LbcfMb3u0H9nleZa3fg2qUyZVfuvjTxvRFSGLQw3ivjmYlPDa+DXqKuN80gqm/Qn35XBtV8V29YeTs334kKz/cQ9rgAGy3cB+EvzM75bE2nwBTXZ37s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3271dda-4de1-4ac8-ed8f-08d823262996
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 10:03:28.4121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQgb9kWOfkWirfSwwxKXWz8ORFwk8xLykt+B+sMc3MmqeO7zVr9GVE6YNxlpFj1mXdbQ6hi0HS+p4r/bncgwpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIEp1bCAwNywgMjAyMCBhdCAwNzo0NjowOEFNIC0wNDAwLCBQZW5nIEhhbyB3cm90
ZToNCj4+IElmIHBsdF9tYXhfZW50cmllcyBpcyAwLCBhIHdhcm5pbmcgaXMgdHJpZ2dlcmVkLg0K
Pj4gV0FSTklORzogQ1BVOiAyMDAgUElEOiAzMDAwIGF0IGFyY2gvYXJtNjQva2VybmVsL21vZHVs
ZS1wbHRzLmM6OTcgbW9kdWxlX2VtaXRfcGx0X2VudHJ5KzB4YTQvMHgxNTANCj4NCj4gV2hpY2gg
a2VybmVsIGFyZSB5b3Ugc2VlaW5nIHRoaXMgd2l0aD8gVGhlcmUgaXMgYSBQTFQtcmVsYXRlZCBj
aGFuZ2UgaW4NCj4gZm9yLW5leHQvY29yZSwgYW5kIEknZCBsaWtlIHRvIHJ1bGUgaWYgb3V0IGlm
IHBvc3NpYmxlLg0KPg0KNS42LjAtcmMzKw0KPj4gU2lnbmVkLW9mZi1ieTogUGVuZyBIYW8gPHJp
Y2hhcmQucGVuZ0BvcHBvLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtNjQva2VybmVsL21vZHVs
ZS1wbHRzLmMgfCAzICsrLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL21vZHVs
ZS1wbHRzLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9tb2R1bGUtcGx0cy5jDQo+PiBpbmRleCA2NWIw
OGE3NGFlYzYuLjE4NjhjOWFjMTNmMiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVs
L21vZHVsZS1wbHRzLmMNCj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL21vZHVsZS1wbHRzLmMN
Cj4+IEBAIC03OSw3ICs3OSw4IEBAIHU2NCBtb2R1bGVfZW1pdF9wbHRfZW50cnkoc3RydWN0IG1v
ZHVsZSAqbW9kLCBFbGY2NF9TaGRyICpzZWNoZHJzLA0KPj4gIAlpbnQgaSA9IHBsdHNlYy0+cGx0
X251bV9lbnRyaWVzOw0KPj4gIAlpbnQgaiA9IGkgLSAxOw0KPj4gIAl1NjQgdmFsID0gc3ltLT5z
dF92YWx1ZSArIHJlbGEtPnJfYWRkZW5kOw0KPj4gLQ0KPj4gKwlpZiAocGx0c2VjLT5wbHRfbWF4
X2VudHJpZXMgPT0gMCkNCj4+ICsJCXJldHVybiAwOw0KPg0KPkhtbSwgYnV0IGlmIHRoZXJlIGFy
ZW4ndCBhbnkgUExUcyB0aGVuIGhvdyBkbyB3ZSBlbmQgdXAgaGVyZT8NCj4NCldlIGFsc28gcmV0
dXJuZWQgMCB3aGVuIHdhcm5pbmcgd2FzIHRyaWdnZXJlZC4NCj5XaWxsDQo=
