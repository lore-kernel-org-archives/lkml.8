Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED432C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD550206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7147+zT9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7147+zT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgGFNp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:45:26 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:16263
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729054AbgGFNpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyv4ODfLMnyiHTxTy9n4Exe0hH150b1AaEBelt13WcA=;
 b=7147+zT9A5m7WbhipSCw65K2MN/FnuBReXL8bVrX8lu93+Mqgt51ajB74rZReZ61Ws/cGIATCU9T7ryNDffpzBqsFwwnnCY2aQKE0KnmSIcOw7iAFPp0P0Tjy0dIwhQ2cCLuGssgyF5nxZNZivuj9qdkqlYm2SYOcB3+4yvuBB0=
Received: from DB8P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::30)
 by DB8PR08MB4011.eurprd08.prod.outlook.com (2603:10a6:10:a2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 13:45:21 +0000
Received: from DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::eb) by DB8P191CA0020.outlook.office365.com
 (2603:10a6:10:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Mon, 6 Jul 2020 13:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT055.mail.protection.outlook.com (10.152.21.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 13:45:21 +0000
Received: ("Tessian outbound f7489b7e84a7:v62"); Mon, 06 Jul 2020 13:45:21 +0000
X-CR-MTA-TID: 64aa7808
Received: from a2876271bd5e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 61D15026-CC06-418E-B2E6-26094679476A.1;
        Mon, 06 Jul 2020 13:45:16 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a2876271bd5e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 06 Jul 2020 13:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaI5UFI7nJLLqxkSwmQvEBxVv10E10PkmtQ+w0Xvb2LGY37r0QIJXtfXT0Qpi39vPaRRqR3MXoGvf/c7sSOJBaRP5jX/8f3XXWrpns5ggmYXDlp4AwKrRj1EEBIrQrZsfCa7W12tnHkK2qeQINS/jcak2odWDCiMTuiKj+nrXzA+sZstaMSJcjVjgfaFErUEHgUsVfN8iIpxvf/hBlMgFc/3Xl8jlD0isYKBIOPjhVbmu4bxNJzO5GjEHdZrzy4MFGd2musu1vBAmyagD6YHn+sdqjUZKvz+uU6QZHO2XcNZnpJJbKc/h5zMj/DxkmrlBnlxY7Fi2oFTPvemxVLjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyv4ODfLMnyiHTxTy9n4Exe0hH150b1AaEBelt13WcA=;
 b=N/nG9veKm/zQ2AyezVtHfFGadrOmhuj6mYNgfF5ewSIvlVf9LKzdd3JcwU1sEVsSouuKQeGrHwABCEVO/hPRTLC3z2noG6bx6kNmzhCQlUojWS/BpVBzKG5Ckg7CGigE57beIo7WdEIfVrW4SFZK+LwduAvGWvz413oOE++JiUr8rVhtZLsn2N03v2hFuc3zzPxbEZLlaORhFvHiC0GY8D9EpcNa4QYiUEb1QXnLdlAZAKUUXzQYCNqW4LMgK3sbjWyOTNDCtijTXOeE3fVJ/jIJf3mrYsU9awk1vJGPv8nwsY/1CBvDY2RU7uDs82fyYQlGM6Mt+RnMssVsMSCF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyv4ODfLMnyiHTxTy9n4Exe0hH150b1AaEBelt13WcA=;
 b=7147+zT9A5m7WbhipSCw65K2MN/FnuBReXL8bVrX8lu93+Mqgt51ajB74rZReZ61Ws/cGIATCU9T7ryNDffpzBqsFwwnnCY2aQKE0KnmSIcOw7iAFPp0P0Tjy0dIwhQ2cCLuGssgyF5nxZNZivuj9qdkqlYm2SYOcB3+4yvuBB0=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 13:45:13 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:45:13 +0000
From:   Justin He <Justin.He@arm.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kaly Xin <Kaly.Xin@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH 2/3] mm/memory_hotplug: harden try_offline_node against
 bogus nid
Thread-Topic: [PATCH 2/3] mm/memory_hotplug: harden try_offline_node against
 bogus nid
Thread-Index: AQHWUzOeeaTBJrAIHUCdKg/zGmF8B6j6L+IAgABZAEA=
Date:   Mon, 6 Jul 2020 13:45:13 +0000
Message-ID: <AM6PR08MB40697FCA7F2374EBE6459FE4F7690@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200706011947.184166-1-justin.he@arm.com>
 <20200706011947.184166-3-justin.he@arm.com>
 <4b864877-1147-8336-5e9a-e89ac5c99be3@redhat.com>
In-Reply-To: <4b864877-1147-8336-5e9a-e89ac5c99be3@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 85922f61-5aaf-4799-82da-de088905d144.1
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10f83752-97f2-432f-601e-08d821b2d3f0
x-ms-traffictypediagnostic: AM7PR08MB5496:|DB8PR08MB4011:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB4011464DF7C405013F87F40DF7690@DB8PR08MB4011.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1728;OLM:1728;
x-forefront-prvs: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qyIDe3PtFE94XLNQCtJlJgumIJBb6CviidsR+mKhgEVP+mrD6e1oFPRlcR0Clbm+OV8fdV1x/FvfGEVWd/MvntYUiYj/LVljUav4zOWqySJ4vPWEH2myH41l+1v7Q3BDQPLvn9NFaFE6lTw99GUUZqW4C267CL5rKGxhSGx0xYzljGSJBIvh5jaKKJcgiXnVUboLDxtEusY/Eow5eJvK1xys46C3+dl0Tn7fmLkYKJv2Blo978cOGv6SZARt6QXfV70uvMlusWCmUTn75ugE9ETVC62yHZ5PGWHpA6h30x24w7I3FoMungNJFMPC3owllWkUFwjbUNA/cNB+8B3Qew==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(7696005)(478600001)(53546011)(6506007)(86362001)(5660300002)(55016002)(9686003)(83380400001)(33656002)(6916009)(8936002)(8676002)(2906002)(26005)(71200400001)(186003)(66946007)(76116006)(66476007)(316002)(66556008)(64756008)(66446008)(4326008)(54906003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8bBRNVyhvcPhz7TOjXMOQ93LTtFr8giUKwof7wRqXz5gTjgVsrlFx2pcM5f/ny9Zau6dUnmoUgp5paDQnIjFBYyLnMOXzjC+eboe5gd82nVRaB14+cGVLSR6fRlkol7R5AlFiyx6jN+XD3gbcUsjqjD54tv0oCEGoPGD6n+dp4VJOsCJAHWWY7RGWYFy+iH84SVFJJdY8Yi3PpVVJw1EyBdRvSkZEDOYe7yGLBT0BPDiuV/mxSLWamVLqc0brt2kyIhTCt6rU3r9xZ279mogMUoZfq4cfAODTSnCNZPiIDSpvQ9IFDPphNnBVhL+4Krbv407skjhQPQxr4N+diMX86drw/az46qckvD97IL7NxeOtnycRDfan5OOCQz6uq3zZniOTWdWHZ8m2Mkyqq/Cnl17ldzC+SHriFQ6WZr9CqqhmWRCN2jIXAtL9XZtRI847H+hQkNgcVKjYeYeGwBRJPnoJMDYfB2CP+Unwvr23jU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966005)(316002)(70586007)(186003)(9686003)(4326008)(2906002)(26005)(82740400003)(356005)(33656002)(81166007)(82310400002)(86362001)(6862004)(47076004)(336012)(83380400001)(70206006)(53546011)(8936002)(8676002)(5660300002)(7696005)(6506007)(478600001)(54906003)(55016002)(52536014);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c36e7fc4-f850-4e63-1d79-08d821b2cf48
X-Forefront-PRVS: 04569283F9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9kc+kvU6ufJnIHJfXdpgKka68EaaierOFA/FaNmQjLPimfeRYfda4DtNlRTr1736W5MSAIWFVCoumIOtVbyC22vEZxaFgv7Bk3FxVsrQqH7T0a6i/Pdd88NOYKJKOjhYCe8EHWpNmzPvSPt4QYZ5zY643ovwYf9BB34VZVy2NZc8vsA8V1bOZeqH27HighcOqRMJWDqXy1hZj9ZAh+I8j3YfDs2mYU64N52ApsuPy4Ly5sEOEjs0j6q5BWswPE3+/dK0Uz2KximE6PMM0gX6U9ElTVnxyNhFjk1Z7plAjHAb1AkXNUJIXJjZ7kbJnbYOCNkwneP1Ld53absynI8hsPeA6rSs7i7P9RBjDKhnj68bHmAOcL2rdzWmjfjzgPgmO7o35tCH5scOtnbDhIUvg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 13:45:21.6506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f83752-97f2-432f-601e-08d821b2d3f0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDYsIDIw
MjAgMzo1OCBQTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT47IENhdGFsaW4g
TWFyaW5hcw0KPiA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyBXaWxsIERlYWNvbiA8d2lsbEBr
ZXJuZWwub3JnPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
Zz47IE1pa2UgUmFwb3BvcnQNCj4gPHJwcHRAbGludXguaWJtLmNvbT47IEJhb3F1YW4gSGUgPGJo
ZUByZWRoYXQuY29tPjsgQ2h1aG9uZyBZdWFuDQo+IDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT47IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgS2FseSBYaW4gPEthbHkuWGluQGFybS5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBtbS9tZW1vcnlfaG90cGx1ZzogaGFyZGVu
IHRyeV9vZmZsaW5lX25vZGUNCj4gYWdhaW5zdCBib2d1cyBuaWQNCj4gDQo+IE9uIDA2LjA3LjIw
IDAzOjE5LCBKaWEgSGUgd3JvdGU6DQo+ID4gV2hlbiB0ZXN0aW5nIHRoZSByZW1vdmVfbWVtb3J5
IHBhdGggb2YgZGF4IHBtZW0sIHRoZXJlIHdpbGwgYmUgYSBwYW5pYw0KPiB3aXRoDQo+ID4gY2Fs
bCB0cmFjZToNCj4gPiAgIHRyeV9yZW1vdmVfbWVtb3J5KzB4ODQvMHgxNzANCj4gPiAgIHJlbW92
ZV9tZW1vcnkrMHgzOC8weDU4DQo+ID4gICBkZXZfZGF4X2ttZW1fcmVtb3ZlKzB4M2MvMHg4NCBb
a21lbV0NCj4gPiAgIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweGZjLzB4MWM4DQo+
ID4gICBkZXZpY2VfcmVsZWFzZV9kcml2ZXIrMHgyOC8weDM4DQo+ID4gICBidXNfcmVtb3ZlX2Rl
dmljZSsweGQ0LzB4MTU4DQo+ID4gICBkZXZpY2VfZGVsKzB4MTYwLzB4M2EwDQo+ID4gICB1bnJl
Z2lzdGVyX2Rldl9kYXgrMHgzMC8weDY4DQo+ID4gICBkZXZtX2FjdGlvbl9yZWxlYXNlKzB4MjAv
MHgzMA0KPiA+ICAgcmVsZWFzZV9ub2RlcysweDE1MC8weDI0MA0KPiA+ICAgZGV2cmVzX3JlbGVh
c2VfYWxsKzB4NmMvMHgxZDANCj4gPiAgIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsw
eDEwYy8weDFjOA0KPiA+ICAgZHJpdmVyX2RldGFjaCsweGFjLzB4MTcwDQo+ID4gICBidXNfcmVt
b3ZlX2RyaXZlcisweDY0LzB4MTMwDQo+ID4gICBkcml2ZXJfdW5yZWdpc3RlcisweDM0LzB4NjAN
Cj4gPiAgIGRheF9wbWVtX2V4aXQrMHgxNC8weGZmYzQgW2RheF9wbWVtXQ0KPiA+ICAgX19hcm02
NF9zeXNfZGVsZXRlX21vZHVsZSsweDE4Yy8weDJkMA0KPiA+ICAgZWwwX3N2Y19jb21tb24uY29u
c3Rwcm9wLjIrMHg3OC8weDE2OA0KPiA+ICAgZG9fZWwwX3N2YysweDM0LzB4YTANCj4gPiAgIGVs
MF9zeW5jX2hhbmRsZXIrMHhlMC8weDE4OA0KPiA+ICAgZWwwX3N5bmMrMHgxNjQvMHgxODANCj4g
Pg0KPiA+IEl0IGlzIGNhdXNlZCBieSB0aGUgYm9ndXMgbmlkICgtMSkuIEFsdGhvdWdoIHRoZSBy
b290IGNhdXNlIGlzIHBtZW0gZGF4DQo+ID4gdHJhbnNsYXRlcyBmcm9tIHB4bSB0byBub2RlX2lk
IGluY29ycmVjdGx5IGR1ZSB0byBudW1hX29mZiwgaXQgaXMgd29ydGgNCj4gPiBoYXJkZW5pbmcg
dGhlIGNvZGVzIGluIHRyeV9vZmZsaW5lX25vZGUoKSwgcXVpdGluZyBpZiAhcGdkYXQuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWEgSGUgPGp1c3Rpbi5oZUBhcm0uY29tPg0KPiA+IC0tLQ0K
PiA+ICBtbS9tZW1vcnlfaG90cGx1Zy5jIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMg
Yi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+ID4gaW5kZXggZGEzNzRjZDNkNDViLi5lMWUyOTA1Nzdi
NDUgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiA+ICsrKyBiL21tL21l
bW9yeV9ob3RwbHVnLmMNCj4gPiBAQCAtMTY4MCw2ICsxNjgwLDkgQEAgdm9pZCB0cnlfb2ZmbGlu
ZV9ub2RlKGludCBuaWQpDQo+ID4gIAlwZ19kYXRhX3QgKnBnZGF0ID0gTk9ERV9EQVRBKG5pZCk7
DQo+ID4gIAlpbnQgcmM7DQo+ID4NCj4gPiArCWlmIChXQVJOX09OKCFwZ2RhdCkpDQo+ID4gKwkJ
cmV0dXJuOw0KPiA+ICsNCj4gPiAgCS8qDQo+ID4gIAkgKiBJZiB0aGUgbm9kZSBzdGlsbCBzcGFu
cyBwYWdlcyAoZXNwZWNpYWxseSBaT05FX0RFVklDRSksIGRvbid0DQo+ID4gIAkgKiBvZmZsaW5l
IGl0LiBBIG5vZGUgc3BhbnMgbWVtb3J5IGFmdGVyIG1vdmVfcGZuX3JhbmdlX3RvX3pvbmUoKSwN
Cj4gPg0KPiANCj4gSG0uIElmIEkgYW0gbm90IHdyb25nLCBzb21lYm9keSB1c2VkIGFkZF9tZW1v
cnkoKSB3aXRoIGFub3RoZXIgbmlkIHRoYW4NCj4gdHJ5X3JlbW92ZV9tZW1vcnkoKT8NCj4gDQoN
ClllcyBhZnRlciBjb21taXQgZmE2ZDllYzc5MDU1MCwgaXQgY2FuIHByZXZlbnQgdGhpcyBwb3Nz
aWJpbGl0eS4NCkkgd2lsbCBkcm9wIHRoaXMgc2luZ2xlIHBhdGNoLiBUaGFua3MNCi0tDQpDaGVl
cnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
