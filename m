Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8660C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8941D20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="erN3b8Bv";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="erN3b8Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgGHG4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:56:53 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:25133
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728753AbgGHG4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9KjTfjizXxP12ARgMEOLY8C/RR4KIvup9neUM1k+CI=;
 b=erN3b8Bvy8cR8hK/mbpieykrvfUSCyz3ztbtX5k6cQXXr/iZ5ywlr2RgHklwtcsyHXWI5BxU4m994yPNjgb2PGrfjwSRO69SVOmS8aSxNsqoe+aMOcEuzNwO1dhBik/xyuvZnVe92V5gYh6i0rvPotFdewKzTqMfIDINSuUu2as=
Received: from AM0P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::26)
 by AM6PR08MB4295.eurprd08.prod.outlook.com (2603:10a6:20b:b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 06:56:45 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:190:cafe::33) by AM0P190CA0016.outlook.office365.com
 (2603:10a6:208:190::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Wed, 8 Jul 2020 06:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Wed, 8 Jul 2020 06:56:45 +0000
Received: ("Tessian outbound 2dd9eeca983c:v62"); Wed, 08 Jul 2020 06:56:44 +0000
X-CR-MTA-TID: 64aa7808
Received: from fbe4b376364c.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2B1B6EC7-E5AB-451C-99A5-5A00DDD691A8.1;
        Wed, 08 Jul 2020 06:56:39 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fbe4b376364c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 06:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5+l5NxJoH0uaQT7lWJoqPic94y+y8fZFv3d44185dyHZ2O3e8t94eesgxUAp2wOx2p/m+iyVPa2l7mQyY7DdRMODyFAec04TaJx+BxHbyNj1vFWdc436yJ9WcqNobOYTkgjEqbMx5+0IkEXRekJXBFnbjzznGpqHMOgIgq4DBeD4WPvEiFcluQZK/bCEd6eU9tzHUOTZRLMzv1F/H4BUmHVEicAljrw/pob4q3oh8h7pd/mCNCYqli8UoH7uNteo3bP6e9fgXqVZAMgVxV4LqUI6pN+V7ss0ft3Qxuocu277gqMbJDPPMqutrF+FPNvue0S4RG2G1XnKhMhhUSWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9KjTfjizXxP12ARgMEOLY8C/RR4KIvup9neUM1k+CI=;
 b=a9T/pJIbog/HwLFJbITrl3IjYPjhY4wBLdstpGaqaLwgIbZdCMuKKsvbkPjTdgAYrzoyJonb3qj53ylwGBANDnS2V8xhhn2R6KElhIbnOMTODg9bWRmdRw93A9o8fFbbXfv0RXdj7SvHcovCnx5GHbk0yM8GbigGeqcttzv8MhcnIFArZqUnlEWTwkJaI0ntkhndeyy4KyZVOe3QiUF3tiH6/vDU7bYNeKvUz9af7Y9RHBqxPtHTXH5bgvdG0Ot8Duz4w2JBhSrqp4sAtVxUQ/JngjY8qf7aMzk8JjUiSyKQCqiluxW6G1wcX6eT7TeXqdpjeQN38+EabAveQBDtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9KjTfjizXxP12ARgMEOLY8C/RR4KIvup9neUM1k+CI=;
 b=erN3b8Bvy8cR8hK/mbpieykrvfUSCyz3ztbtX5k6cQXXr/iZ5ywlr2RgHklwtcsyHXWI5BxU4m994yPNjgb2PGrfjwSRO69SVOmS8aSxNsqoe+aMOcEuzNwO1dhBik/xyuvZnVe92V5gYh6i0rvPotFdewKzTqMfIDINSuUu2as=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB5207.eurprd08.prod.outlook.com (2603:10a6:20b:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 06:56:38 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 06:56:38 +0000
From:   Justin He <Justin.He@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Topic: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Index: AQHWVCPSGGxRNvjq20KjOcC2mjPWIqj8ApMAgADwVZCAABxdAIAAGtaAgAAEYYCAAAZuAA==
Date:   Wed, 8 Jul 2020 06:56:38 +0000
Message-ID: <AM6PR08MB4069AC46B435AB32BE9E2834F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <20200708053239.GC386073@linux.ibm.com>
 <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
In-Reply-To: <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 3c8e218e-6f3c-4a46-9bef-c6f091b1f269.1
x-checkrecipientchecked: true
x-ts-email-id: e84b7eec-f554-4438-b455-78fea75428a0
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ae26d90-053f-4eba-c360-08d8230c13d7
x-ms-traffictypediagnostic: AM6PR08MB5207:|AM6PR08MB4295:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42953A489CE794D0E37DBBF6F7670@AM6PR08MB4295.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CszeoZH6fTvkeGvibgxoPRlL0u+f+yH40fgMmgnXdybxhz9RSDBJeY54VmNCiK18HgzhAnjpUIVMKakpmIRHwunpDJzWDL3HT2tpRsXPOxMUH5xLB2xPjpv508EwN4MZ/bVC0rd/hJzLsPC3a+QvzUifNR6GnSJFAln5JmtLfflD/YxDtn0aAv+A3X+mdVe86jFC6Rt63gU+UNkJ1opoEcJwbWsm9iYboJLcCu1bRL6cgJFPS8jcfb1zrv8rjFDoiLdQXrfWCAKrjoqw9EnWpwhfMvFE1xMc10MjBTfjPOOycc3xZRUPUVhTBO3XxgIv6S9uKGcKySaNjgZWnc6Dnw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(6506007)(54906003)(316002)(76116006)(5660300002)(66946007)(71200400001)(33656002)(66476007)(64756008)(66446008)(7696005)(66556008)(9686003)(52536014)(86362001)(55016002)(53546011)(4326008)(26005)(186003)(83380400001)(6916009)(2906002)(478600001)(7416002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HTUGYcHGLQKTjaXgYz0Q2ELj4Lq5828sWd1gJJCufB3LYS4BUjcygeLjxa9c7vzFVPvc2+KiEry6sKPWruXGq2L5jdMy58bPDBGsXnKkYNxSAjjEKbpQnJVK1aBtaQnHbOLvEppKqnH+vBY0BmR8K8gCaRi83kIv+bcu9k13KZzvZME/FRyWhMeu1l8rRr6YxvurzLet0wNutFMk7/sXf1PATXn5G5mtAeMYMs5yBF6EawiknLzRXE8uz3UXzT39DYLKmKw6eIruq3j9wSM4PBOWOtT7D6TohN+aVebjQSyC7K2R3E36hT728IwS7HgU+WU0G0BwbOuobZfOUpKW9cxPyAEa2z2w2GX+FhhHzK0KcIC3R3YnNZva3BM1VX8qReEiSNp0U5kfIjvYEN3ORog40Re2fdiCREmGFyNv7+ERcqNMb8BPht9qO5XjnrPPRZxQJJbs+B7db0gyL5p0XviB+pGWpYx6/Bo6VYzmVII=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5207
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39850400004)(136003)(396003)(46966005)(6862004)(316002)(82740400003)(478600001)(8676002)(47076004)(9686003)(6506007)(83380400001)(55016002)(82310400002)(52536014)(4326008)(336012)(36906005)(5660300002)(53546011)(7696005)(356005)(70206006)(70586007)(81166007)(26005)(33656002)(54906003)(186003)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: dec253fb-8144-45a6-381c-08d8230c1004
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EX2UlGj2Q5f6yDzaDeAO06931pTtfC1GjVp7ywP6DEL1CeL3vpJhsyk6efrRBKzb1+KsajOOKNfyti5D3Xn5FLC7dp4VzioAoDrOjRHYhMaaXwxr0TZJZVeE1+KwTTfTxqYApjJrHK1kQuTv1MJ69vEGEGQUaO8yLPQynO0yqy73muAriftMNTjQXCWzUXmNUPrebhxgs8kMPE6/KKFqKaut5/4FQ6x7Uf0j9UVRDcGh6vnm9c/nOXtHwOko2z5nNyCSj3ZeasHGt9g1k2oYRE5rpVs0clwY/Ftst3fRFbA5LQMOjHfJK7GYrvFUSP9ZkR5rqjTJaT0IlYts3lNY6xYfKAiQvkUsBQNhue+R2eIdkRINDAYVl+MYvXpTaXGHdjzvPkPyyr45gxJwevK99A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 06:56:45.1633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae26d90-053f-4eba-c360-08d8230c13d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxp
YW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA4
LCAyMDIwIDE6NDggUE0NCj4gVG86IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4N
Cj4gQ2M6IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBNaWNoYWwgSG9ja28gPG1ob2Nr
b0BrZXJuZWwub3JnPjsgRGF2aWQNCj4gSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+OyBD
YXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsNCj4gV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz47IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29t
PjsNCj4gRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBBbmRyZXcgTW9ydG9uIDxh
a3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZz47IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29t
PjsgQ2h1aG9uZyBZdWFuDQo+IDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT47IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZzsNCj4gS2FseSBY
aW4gPEthbHkuWGluQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8zXSBhcm02
NC9udW1hOiBleHBvcnQgbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQNCj4gYXMgRVhQT1JUX1NZ
TUJPTF9HUEwNCj4gDQo+IE9uIFR1ZSwgSnVsIDcsIDIwMjAgYXQgMTA6MzMgUE0gTWlrZSBSYXBv
cG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgSnVsIDA3
LCAyMDIwIGF0IDA4OjU2OjM2UE0gLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgSnVsIDcsIDIwMjAgYXQgNzoyMCBQTSBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29t
PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gSGkgTWljaGFsIGFuZCBEYXZpZA0KPiA+ID4gPg0K
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogTWlj
aGFsIEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz4NCj4gPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBK
dWx5IDcsIDIwMjAgNzo1NSBQTQ0KPiA+ID4gPiA+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBh
cm0uY29tPg0KPiA+ID4gPiA+IENjOiBDYXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bh
cm0uY29tPjsgV2lsbCBEZWFjb24NCj4gPiA+ID4gPiA8d2lsbEBrZXJuZWwub3JnPjsgRGFuIFdp
bGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBWaXNoYWwNCj4gVmVybWENCj4gPiA+
ID4gPiA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPjsgRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0Bp
bnRlbC5jb20+Ow0KPiBBbmRyZXcNCj4gPiA+ID4gPiBNb3J0b24gPGFrcG1AbGludXgtZm91bmRh
dGlvbi5vcmc+OyBNaWtlIFJhcG9wb3J0DQo+IDxycHB0QGxpbnV4LmlibS5jb20+Ow0KPiA+ID4g
PiA+IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPjsgQ2h1aG9uZyBZdWFuIDxoc2xlc3Rlcjk2
QGdtYWlsLmNvbT47DQo+IGxpbnV4LQ0KPiA+ID4gPiA+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtDQo+ID4gPiA+
ID4gbW1Aa3ZhY2sub3JnOyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBLYWx5IFhpbg0KPiA8
S2FseS5YaW5AYXJtLmNvbT4NCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10g
YXJtNjQvbnVtYTogZXhwb3J0DQo+IG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkDQo+ID4gPiA+
ID4gYXMgRVhQT1JUX1NZTUJPTF9HUEwNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFR1ZSAwNy0w
Ny0yMCAxMzo1OToxNSwgSmlhIEhlIHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhpcyBleHBvcnRzIG1l
bW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKCkgZm9yIG1vZHVsZSBkcml2ZXIgdG8NCj4gdXNlLg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKCkgaXMg
YSBmYWxsYmFjayBvcHRpb24gdG8gZ2V0IHRoZSBuaWQNCj4gaW4gY2FzZQ0KPiA+ID4gPiA+ID4g
TlVNQV9OT19OSUQgaXMgZGV0ZWN0ZWQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU3VnZ2Vz
dGVkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiA+ICBhcmNoL2FybTY0L21tL251bWEuYyB8IDUgKysrLS0NCj4gPiA+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL251bWEuYyBi
L2FyY2gvYXJtNjQvbW0vbnVtYS5jDQo+ID4gPiA+ID4gPiBpbmRleCBhYWZjZWUzZTNmN2UuLjdl
ZWIzMTc0MDI0OCAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvbW0vbnVtYS5j
DQo+ID4gPiA+ID4gPiArKysgYi9hcmNoL2FybTY0L21tL251bWEuYw0KPiA+ID4gPiA+ID4gQEAg
LTQ2NCwxMCArNDY0LDExIEBAIHZvaWQgX19pbml0IGFybTY0X251bWFfaW5pdCh2b2lkKQ0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAvKg0KPiA+ID4gPiA+ID4gICAqIFdlIGhvcGUgdGhhdCB3
ZSB3aWxsIGJlIGhvdHBsdWdnaW5nIG1lbW9yeSBvbiBub2RlcyB3ZQ0KPiBhbHJlYWR5IGtub3cN
Cj4gPiA+ID4gPiBhYm91dCwNCj4gPiA+ID4gPiA+IC0gKiBzdWNoIHRoYXQgYWNwaV9nZXRfbm9k
ZSgpIHN1Y2NlZWRzIGFuZCB3ZSBuZXZlciBmYWxsIGJhY2sgdG8NCj4gdGhpcy4uLg0KPiA+ID4g
PiA+ID4gKyAqIHN1Y2ggdGhhdCBhY3BpX2dldF9ub2RlKCkgc3VjY2VlZHMuIEJ1dCB3aGVuIFNS
QVQgaXMgbm90DQo+IHByZXNlbnQsDQo+ID4gPiA+ID4gdGhlIG5vZGUNCj4gPiA+ID4gPiA+ICsg
KiBpZCBtYXkgYmUgcHJvYmVkIGFzIE5VTUFfTk9fTk9ERSBieSBhY3BpLCBIZXJlIHByb3ZpZGUg
YQ0KPiBmYWxsYmFjaw0KPiA+ID4gPiA+IG9wdGlvbi4NCj4gPiA+ID4gPiA+ICAgKi8NCj4gPiA+
ID4gPiA+ICBpbnQgbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQodTY0IGFkZHIpDQo+ID4gPiA+
ID4gPiAgew0KPiA+ID4gPiA+ID4gLSAgIHByX3dhcm4oIlVua25vd24gbm9kZSBmb3IgbWVtb3J5
IGF0IDB4JWxseCwgYXNzdW1pbmcgbm9kZQ0KPiAwXG4iLA0KPiA+ID4gPiA+IGFkZHIpOw0KPiA+
ID4gPiA+ID4gICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ICtFWFBP
UlRfU1lNQk9MX0dQTChtZW1vcnlfYWRkX3BoeXNhZGRyX3RvX25pZCk7DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gZXhwb3J0IGEgbm9vcCBmdW5jdGlvbj8gV291
bGRuJ3QgbWFrZSBtb3JlDQo+IHNlbnNlDQo+ID4gPiA+ID4gdG8gc2ltcGx5IG1ha2UgaXQgc3Rh
dGljIGlubGluZSBzb21ld2hlcmUgaW4gYSBoZWFkZXI/IEkgaGF2ZW4ndA0KPiBjaGVja2VkDQo+
ID4gPiA+ID4gd2hldGhlciB0aGVyZSBpcyBhbiBlYXN5IHdheSB0byBkbyB0aGF0IHNhbmVseSBi
dSB0aGlzIGp1c3QgaGl0IG15DQo+IGV5ZXMuDQo+ID4gPiA+DQo+ID4gPiA+IE9rYXksIEkgY2Fu
IG1ha2UgYSBjaGFuZ2UgaW4gbWVtb3J5X2hvdHBsdWcuaCwgc3RoIGxpa2U6DQo+ID4gPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L21lbW9yeV9ob3RwbHVnLmgNCj4gPiA+ID4gQEAgLTE0OSwxMyArMTQ5LDEzIEBAIGlu
dCBhZGRfcGFnZXMoaW50IG5pZCwgdW5zaWduZWQgbG9uZyBzdGFydF9wZm4sDQo+IHVuc2lnbmVk
IGxvbmcgbnJfcGFnZXMsDQo+ID4gPiA+ICAgICAgICAgICAgICAgc3RydWN0IG1ocF9wYXJhbXMg
KnBhcmFtcyk7DQo+ID4gPiA+ICAjZW5kaWYgLyogQVJDSF9IQVNfQUREX1BBR0VTICovDQo+ID4g
PiA+DQo+ID4gPiA+IC0jaWZkZWYgQ09ORklHX05VTUENCj4gPiA+ID4gLWV4dGVybiBpbnQgbWVt
b3J5X2FkZF9waHlzYWRkcl90b19uaWQodTY0IHN0YXJ0KTsNCj4gPiA+ID4gLSNlbHNlDQo+ID4g
PiA+ICsjaWYgIWRlZmluZWQoQ09ORklHX05VTUEpIHx8ICFkZWZpbmVkKG1lbW9yeV9hZGRfcGh5
c2FkZHJfdG9fbmlkKQ0KPiA+ID4gPiAgc3RhdGljIGlubGluZSBpbnQgbWVtb3J5X2FkZF9waHlz
YWRkcl90b19uaWQodTY0IHN0YXJ0KQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAgICAgICAgIHJldHVy
biAwOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPiArI2Vsc2UNCj4gPiA+ID4gK2V4dGVybiBpbnQgbWVt
b3J5X2FkZF9waHlzYWRkcl90b19uaWQodTY0IHN0YXJ0KTsNCj4gPiA+ID4gICNlbmRpZg0KPiA+
ID4gPg0KPiA+ID4gPiBBbmQgdGhlbiBjaGVjayB0aGUgbWVtb3J5X2FkZF9waHlzYWRkcl90b19u
aWQoKSBoZWxwZXIgb24gYWxsIGFyY2hlcywNCj4gPiA+ID4gaWYgaXQgaXMgbm9vcChyZXR1cm4g
MCksIEkgY2FuIHNpbXBseSByZW1vdmUgaXQuDQo+ID4gPiA+IGlmIGl0IGlzIG5vdCBub29wLCBh
ZnRlciB0aGUgaGVscGVyLA0KPiA+ID4gPiAjZGVmaW5lIG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9f
bmlkDQo+ID4gPiA+DQo+ID4gPiA+IFdoYXQgZG8geW91IHRoaW5rIG9mIHRoaXMgcHJvcG9zYWw/
DQo+ID4gPg0KPiA+ID4gRXNwZWNpYWxseSBmb3IgYXJjaGl0ZWN0dXJlcyB0aGF0IHVzZSBtZW1i
bG9jayBpbmZvIGZvciBudW1hIGluZm8NCj4gPiA+ICh3aGljaCBzZWVtcyB0byBiZSBldmVyeW9u
ZSBleGNlcHQgeDg2KSB3aHkgbm90IGltcGxlbWVudCBhIGdlbmVyaWMNCj4gPiA+IG1lbW9yeV9h
ZGRfcGh5c2FkZHJfdG9fbmlkKCkgdGhhdCBkb2VzOg0KPiA+DQo+ID4gVGhhdCB3b3VsZCBiZSBv
bmx5IGFybTY0Lg0KPiA+DQo+IA0KPiBEYXJuLCBJIHNhdyBBUkNIX0tFRVBfTUVNQkxPQ0sgYW5k
IGhhZCBkZWx1c2lvbnMgb2YgZ3JhbmRldXIgdGhhdCBpdA0KPiBjb3VsZCBzb2x2ZSBteSBudW1h
IGFwaSB3b2VzLiBBdCBsZWFzdCBmb3IgeDg2IHRoZSBwcm9ibGVtIGlzIGFscmVhZHkNCj4gc29s
dmVkIHdpdGggcmVzZXJ2ZWQgbnVtYV9tZW1pbmZvLCBidXQgbm93IEknbSB0cnlpbmcgdG8gd3Jp
dGUgZ2VuZXJpYw0KPiBkcml2ZXJzIHRoYXQgdXNlIHRob3NlIGFwaXMgYW5kIGZpbmRpbmcgdGhl
c2UgZ2FwcyBvbiBvdGhlciBhcmNocy4NCg0KRXZlbiBvbiBhcm02NCwgdGhlcmUgaXMgYSBkZXBl
bmRlbmN5IGlzc3VlIGluIGRheF9wbWVtIGttZW0gY2FzZS4NCklmIGRheCBwbWVtIHVzZXMgbWVt
b3J5X2FkZF9waHlzYWRkcl90b19uaWQoKSB0byBkZWNpZGUgd2hpY2ggbm9kZSB0aGF0DQptZW1i
bG9jayBzaG91bGQgYWRkIGludG8sIGdldF9wZm5fcmFuZ2VfZm9yX25pZCgpIG1pZ2h0IG5vdCBo
YXZlDQp0aGUgY29ycmVjdCBtZW1ibG9jayBpbmZvIGF0IHRoYXQgdGltZS4gVGhhdCBpcywgZ2V0
X3Bmbl9yYW5nZV9mb3JfbmlkKCkNCmNhbid0IGdldCB0aGUgY29ycmVjdCBtZW1ibG9jayBpbmZv
IGJlZm9yZSBhZGRfbWVtb3J5KCkNCg0KU28gSU1PLCBtZW1vcnlfYWRkX3BoeXNhZGRyX3RvX25p
ZCgpIHN0aWxsIGhhdmUgdG8gaW1wbGVtZW50IGFzIG5vb3Agb24NCmFybTY0IChyZXR1cm4gMCkg
dG9nZXRoZXIgd2l0aCBzaCxzMzkweD8gUG93ZXJwYywgeDg2LGlhNjQgY2FuIHVzZSB0aGVpcg0K
b3duIGltcGxlbWVudGF0aW9uLiBBbmQgcGh5c190b190YXJnZXRfbm9kZSgpIGNhbiB1c2UgeW91
ciBzdWdnZXN0ZWQoDQpmb3JfZWFjaF9vbmxpbmVfbm9kZSgpIC4uLikNCg0KV2hhdCBkbyB5b3Ug
dGhpbmsgb2YgaXQ/IFRoYW5rcw0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
