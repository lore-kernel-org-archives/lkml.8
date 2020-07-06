Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1E620720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MWJn9FYN";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MWJn9FYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgGFMgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:36:22 -0400
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:57787
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728885AbgGFMgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHboy8WDF8W+UzHVH0AMJHBO6SkwnqDtpakqJwuKrm4=;
 b=MWJn9FYNz2S52a/Ig3sGZZ8fdintUkvaOktzR7iS8DmFD2Ke19S/8jAP03BZerTLVz2cpL+3uxfOEPwMPyWzBy8/3clkWuOUNeTiifQ/U5a5DvFnxTmPS6ujpgjFgtSL+g8ZpqEqCcNNqfDB+dN5eTQeWV4PJW+w6Ove26lFZxs=
Received: from AM7PR03CA0004.eurprd03.prod.outlook.com (2603:10a6:20b:130::14)
 by VI1PR08MB5357.eurprd08.prod.outlook.com (2603:10a6:803:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 12:36:17 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::c4) by AM7PR03CA0004.outlook.office365.com
 (2603:10a6:20b:130::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Mon, 6 Jul 2020 12:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 12:36:16 +0000
Received: ("Tessian outbound a4b10e5b482d:v62"); Mon, 06 Jul 2020 12:36:15 +0000
X-CR-MTA-TID: 64aa7808
Received: from 3c688a6c00eb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 77B7E04A-0E04-442B-986F-73571CA1882A.1;
        Mon, 06 Jul 2020 12:36:10 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3c688a6c00eb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 06 Jul 2020 12:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqiWp8qUM7CYMZsuViru6gU+lmzu647my4TLjIzERxbZC9AhbKykCKxiKBcqd7ZU3PBS1SuyHqR4Ud5fBYgXyDUNZJSy3oJV89eKtkpvbcmK/Bk59KGoquXtciE9RmwKaTqZF4S0s7eLEc3MmXBKwhIUgiLuDuwiTobODkOKzwZfPjh6B4Lc06FKnUBXvdr5AkcQ4nI4mnjreo2Jv1rUGah9saCiYdN1pWEAJan/Q33ip1ZoNtlDCEmLgbOGQYrsGkvTxRhiocty/ViS4XQm1L/hd14l9Gf8W0dX7MGTVzPyxpIwzBtW/k1cpiXhPyxno9KoaC+22in3d/XERnTdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHboy8WDF8W+UzHVH0AMJHBO6SkwnqDtpakqJwuKrm4=;
 b=ZwpvlktZnddALw2YxXeDcrlG+8flD7b/tUMV8TT1GvdsV55nF1BJdVPwJtt0hNWGUVYb97/MB8XvwoR16eivuYE4hnX8+ptSm7ktKhUPG+04PJWEjebYYyvzehdrP7Rjku8qiI1Pdu06PIuZELFpRyj13F0doUPbMacqRkNQ8aahCZl50wRpS5xaUAzSQNd76VCHg9yCF5cEihRibaHIfbxqZwyiHmHfQ7swMZIG7JwM2u2xwgci/wsoFMMebghJp8VaQa590U2XR0G2cYGRiMY6UGaT6JXlliEmgvIRxwWknS4xa3GYJMShe1FVUcLGo5LdIFf0Ubgf8VDuAhurIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHboy8WDF8W+UzHVH0AMJHBO6SkwnqDtpakqJwuKrm4=;
 b=MWJn9FYNz2S52a/Ig3sGZZ8fdintUkvaOktzR7iS8DmFD2Ke19S/8jAP03BZerTLVz2cpL+3uxfOEPwMPyWzBy8/3clkWuOUNeTiifQ/U5a5DvFnxTmPS6ujpgjFgtSL+g8ZpqEqCcNNqfDB+dN5eTQeWV4PJW+w6Ove26lFZxs=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB3286.eurprd08.prod.outlook.com (2603:10a6:209:40::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 12:36:09 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 12:36:09 +0000
From:   Justin He <Justin.He@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: RE: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
Thread-Topic: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
Thread-Index: AQHWUzObVAN7sC9CEkOu+o81HJjSXaj6MUEAgABLIAA=
Date:   Mon, 6 Jul 2020 12:36:09 +0000
Message-ID: <AM6PR08MB4069A96C32135C2C4A8A9FD2F7690@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200706011947.184166-1-justin.he@arm.com>
 <20200706011947.184166-2-justin.he@arm.com>
 <5006eb38-a80e-e368-48db-7f497e15c8af@redhat.com>
In-Reply-To: <5006eb38-a80e-e368-48db-7f497e15c8af@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 051db68e-227c-490b-9065-138640efd50e.1
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [223.167.32.51]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbd3878e-7425-4869-f866-08d821a92d4b
x-ms-traffictypediagnostic: AM6PR08MB3286:|VI1PR08MB5357:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB53572ADE33C0E8A65121D902F7690@VI1PR08MB5357.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gVuH4WuMEercBa5yg0T4ei6bL6csNg5rnBZZtpcoxQOoYDmrOjohS3b0ljhVNzPGsUKGAkJnV9MoylZTe3K3yEhFzJuKAmMqkpoRnratlGBTo055jqAy1KRQyc2jgG/PyzDLTpNrXUXCQhdiQSFpg2jE9GhI9PidX58fRH2MuclU1kFQcjvs61G97cZa7LbqMagkgC+MVyyovbYOHaDxBmVLkKW5FkU7XftK2prA/Hby/trZS3VB2ewDNVnlLmkVXKT5dAsGIk71obdqPx3pMbc2FvAVLQlfpIgdgHdqbCwzY8weK6CvNBpKlfjI403/udM9bGe51QFRS2irlqiHXqPdm866rOlmCLn7abPb8dZZB6xiVH2Kkdvdcr+owAxBUSVBpzVWN5JKG03ssYkA3A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(55016002)(5660300002)(9686003)(66556008)(66446008)(66476007)(64756008)(52536014)(33656002)(71200400001)(86362001)(186003)(2906002)(26005)(6506007)(53546011)(7696005)(76116006)(66946007)(83380400001)(8936002)(4326008)(8676002)(54906003)(966005)(316002)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: k979IcZMlmv1lRzSv3EGauRhP1vLl+5syFyIrBD+i6/2DDxjplCZ3HAN/MoP4a7zENyQCJZLVglrD8BvR5gV6/e2K81lazpYcKz0iDL/sxDD5jprv2A0nNXeza49V1lJEzvGWxViokxJTBFyP2DUS7w5CfJzO9zkvn+ixrw75FHfg7LlVD6VDdkXmOku2QcbhyZ/+XLbG5p3cmEuZ82IX1R3JZ4nXoxccKJ0QO7DG+Y93H1deZcPnb86rBb013b0qZfbAGtOQSuwRMzvXuv12bF2mNKLjG3JIeoJuAvmZXsWEuLNwP+fXJVAaFGFhgpySrfQTRQ5M8EY6Z3xwE/KDLPlGG15sYO5mQXxVKYMXoDL2Jfs5Fq5v2Jvp/gpWnG/INefxeWYNViGMHMffb5j8v7wDYKkcmZZ9sC3R79DapSmTdDArbclLpLjz0pf81exo5IF2/87sXXJq+Zt1UL4A+TXAsr4M8gfLJBX7WQj4oI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3286
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(6506007)(53546011)(8676002)(7696005)(2906002)(36906005)(52536014)(55016002)(82310400002)(9686003)(47076004)(26005)(186003)(86362001)(70206006)(70586007)(82740400003)(478600001)(4326008)(356005)(8936002)(83380400001)(336012)(110136005)(54906003)(5660300002)(316002)(33656002)(81166007)(966005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 68d087ca-1fd8-4793-3544-08d821a928ea
X-Forefront-PRVS: 04569283F9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJFJMWMd+DB3APOGLEeLnwdo/mfv6gGhFasn8I4kK6ygJ3OAqCQ3iLB3FgO3aFQXrgSFPP1frPCyM6UWdvZtI9SkakcNfq8xhNPzq0TwToPjLcr6ahS2u9PMA5FlLbnJ749FwP7WtEASEQO0ZnKRXOIegkk7f2Ewlw9Jun4qCecZ19/yqUCjPawi2IiE5GndyTNjIMS20++Mi5uNpBeJIoCO8+QPWGDVgGbOaOpAdtdxcn+BZE/j8bC+mupmqpvohbac0mFIGnbV+2oRCVt9eLKUATN9llmrozjXEhj8/Th/d6FRj9A2luzrb0rBgQ5ujLqmPoiyvDLYlBgVUhjI/hdFxRgr62oa/ovKd/TX46A6B4shA4/44+NJRlE9GUGBybOxzGs97t1r7BCh+/mGhqYooKITPLk7F/pqQr2wrXHHedYsznx5+G7OcpQCO3KL823QNQHbzI7B01lGaxwwuJBc79EAjXaLAxbuhmG9b54=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 12:36:16.2639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd3878e-7425-4869-f866-08d821a92d4b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsIHRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLiBTZWUgbXkgYW5zd2VyIHBsZWFzZToN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBIaWxkZW5icmFu
ZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDYsIDIwMjAgNDowMyBQ
TQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT47IENhdGFsaW4gTWFyaW5hcw0K
PiA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3Jn
Pg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IE1pa2Ug
UmFwb3BvcnQNCj4gPHJwcHRAbGludXguaWJtLmNvbT47IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPjsgQ2h1aG9uZyBZdWFuDQo+IDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT47IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgS2FseSBYaW4gPEthbHkuWGluQGFybS5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBhcm02NC9udW1hOiBzZXQgbnVtYV9vZmYgdG8gZmFsc2Ug
d2hlbiBudW1hIG5vZGUNCj4gaXMgZmFrZQ0KPiANCj4gT24gMDYuMDcuMjAgMDM6MTksIEppYSBI
ZSB3cm90ZToNCj4gPiBQcmV2aW91c2x5LCBudW1hX29mZiBpcyBzZXQgdG8gdHJ1ZSB1bmNvbmRp
dGlvbmFsbHkgaW4gZHVtbXlfbnVtYV9pbml0KCksDQo+ID4gZXZlbiBpZiB0aGVyZSBpcyBhIGZh
a2UgbnVtYSBub2RlLg0KPiA+DQo+ID4gQnV0IGFjcGkgd2lsbCB0cmFuc2xhdGUgbm9kZSBpZCB0
byBOVU1BX05PX05PREUoLTEpIGluDQo+IGFjcGlfbWFwX3B4bV90b19ub2RlKCkNCj4gPiBiZWNh
dXNlIGl0IHJlZ2FyZHMgbnVtYV9vZmYgYXMgdHVybmluZyBvZmYgdGhlIG51bWEgbm9kZS4NCj4g
Pg0KPiA+IFdpdGhvdXQgdGhpcyBwYXRjaCwgcG1lbSBjYW4ndCBiZSBwcm9iZWQgYXMgYSBSQU0g
ZGV2aWNlIG9uIGFybTY0IGlmDQo+IFNSQVQgdGFibGUNCj4gPiBpc24ndCBwcmVzZW50Lg0KPiA+
DQo+ID4gJG5kY3RsIGNyZWF0ZS1uYW1lc3BhY2UgLWZlIG5hbWVzcGFjZTAuMCAtLW1vZGU9ZGV2
ZGF4IC0tbWFwPWRldiAtcyAxZyAtDQo+IGEgNjRLDQo+ID4ga21lbSBkYXgwLjA6IHJlamVjdGlu
ZyBEQVggcmVnaW9uIFttZW0gMHgyNDA0MDAwMDAtMHgyYmZmZmZmZmZdIHdpdGgNCj4gaW52YWxp
ZCBub2RlOiAtMQ0KPiA+IGttZW06IHByb2JlIG9mIGRheDAuMCBmYWlsZWQgd2l0aCBlcnJvciAt
MjINCj4gPg0KPiA+IFRoaXMgZml4ZXMgaXQgYnkgc2V0dGluZyBudW1hX29mZiB0byBmYWxzZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4g
LS0tDQo+ID4gIGFyY2gvYXJtNjQvbW0vbnVtYS5jIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvbW0vbnVtYS5jIGIvYXJjaC9hcm02NC9tbS9udW1hLmMNCj4gPiBpbmRleCBh
YWZjZWUzZTNmN2UuLjc2ODk5ODYwMjBkOSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L21t
L251bWEuYw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvbW0vbnVtYS5jDQo+ID4gQEAgLTQ0MCw3ICs0
NDAsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBkdW1teV9udW1hX2luaXQodm9pZCkNCj4gPiAgCQly
ZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gLQludW1hX29mZiA9IHRydWU7DQo+ID4gKwkv
KiBmb3JjZSBudW1hX29mZiB0byBiZSBmYWxzZSBzaW5jZSB3ZSBoYXZlIGEgZmFrZSBudW1hIG5v
ZGUgaGVyZQ0KPiAqLw0KPiA+ICsJbnVtYV9vZmYgPSBmYWxzZTsNCj4gPiAgCXJldHVybiAwOw0K
PiA+ICB9DQo+ID4NCj4gPg0KPiANCj4gV2hhdCB3b3VsZCBoYXBwZW4gaWYgd2UgdXNlIHNvbWV0
aGluZyBsaWtlIHRoaXMgaW4gZHJpdmVycy9kYXgva21lbS5jDQo+IGluc3RlYWQ6DQo+IA0KPiBu
dW1hX25vZGUgPSBkZXZfZGF4LT50YXJnZXRfbm9kZTsNCj4gaWYgKG51bWFfbm9kZSA9PSBOVU1B
X05PX05PREUpDQo+IAludW1hX25vZGUgPSBtZW1vcnlfYWRkX3BoeXNhZGRyX3RvX25pZChrbWVt
X3N0YXJ0KTsNCj4gDQo+IGFuZCBldmVudHVhbGx5IGRyb3BwaW5nIHRoZSBwcl93YXJuIGluDQo+
IGFybTY0L21lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKCkgPyBXb3VsZCB0aGF0IHdvcms/DQoN
ClllcywgaXQgd29ya3MuIEkgc2VudCBhIHNpbWlsYXIgcGF0Y2ggWzFdIGJlZm9yZS4gQnV0IHNl
ZW1zIHBtZW0NCm1haW50YWluZXIgZGlkbid0IHNhdGlzZnkgaXQuIERvIHlvdSB0aGluayBtZW1v
cnlfYWRkX3BoeXNhZGRyX3RvX25pZCgpDQppcyBiZXR0ZXIgdGhhbiBudW1hX21lbV9pZCgpPyAN
Cg0KWzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzgvMTYvMzY3DQoNCi0tDQpDaGVlcnMs
DQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
