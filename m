Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4454FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C6D20768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PiWfS6Fb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PiWfS6Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgF1HiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:38:06 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:42979
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbgF1HiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ21TKRGPQd9arDyP6leqZVj5seRfZjtpGmsVWzoApE=;
 b=PiWfS6FbkQUPUib161834aVW5SOXhl6KaNyuns2+xmUte6QV+Be5WO7rV/hac60GfVWjvE4qXNZWL1XYI/0m8b0aPcB2Zuz4F/52ud9KRcbBrOgh2rC+LKsv0L7sRT2t73iaeOo4GiMm0+cZgV8WcEBFEmWG2AwxhWKHu0EA0oE=
Received: from MRXP264CA0038.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::26)
 by VI1PR08MB4368.eurprd08.prod.outlook.com (2603:10a6:803:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Sun, 28 Jun
 2020 07:37:58 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:14:cafe::c7) by MRXP264CA0038.outlook.office365.com
 (2603:10a6:500:14::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Sun, 28 Jun 2020 07:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Sun, 28 Jun 2020 07:37:57 +0000
Received: ("Tessian outbound 1e00bf306733:v60"); Sun, 28 Jun 2020 07:37:57 +0000
X-CR-MTA-TID: 64aa7808
Received: from d1261a2c0069.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9E0C37DE-5DF2-4FC5-A687-C67B832FA256.1;
        Sun, 28 Jun 2020 07:37:51 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d1261a2c0069.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sun, 28 Jun 2020 07:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxL+NUol42yZ+B3YZWwtigYS0yNwEF8ykI56YTQ19rFQTteYj7O/5xGw+Kh09OBMYrTNOlTyT/7NwqaVU4J1Qu5OkhOdtqKhk5+YATCy4NJoW1+3Fk08FnPrx9FHl7k2jkN2tPM8XwNUqgfl651FhtED/4MpqIOym81+iTC71AzeVzj7CM1reVMoVz65FRHxSz7YuT0UT7KYvhJ7/4+mGJMXDTyJUEN6CZzKFThpp3LRnD0h8yrArAYoEsfACSNovjXu7BVPw5OC5rIgvyaHJaTQYW3AE3lDhRvvZC4JpBE9dTh2d28LQx5O6n2vMFwvzbkGqomp/phUKsm7mqzNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ21TKRGPQd9arDyP6leqZVj5seRfZjtpGmsVWzoApE=;
 b=Eti/EEc8WvzKzlDWnVAsU6aUkiVPUFSYR5uUZAdTjAghOzjrdjWy/MOaDjUAK4l5of5+n3BQlu9nNDp5Tl7v0mX0b5wWin3/fNqR/XyNE3ozTwAIKttFSr/YWbkfIuoCFgO6yhEeT1qJeTtPLn9D9qKrZLnsvql49gm9TOGzzGhNq8JeF45hibuyPClpl4Y1DvLHvRyFc/T1v+y/XoBZcD2BD8VYdxvcN/4GGDLgJDsGHI52AGOzq1N369+y5v5ySUeKgAASqG7mnd48n0QKiBr0jAYbiI/RQf9dyJyU/PjS7T1PQOmf/5LFP9loxWF2Mjr0tn2XUyxjwLHDaqGdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ21TKRGPQd9arDyP6leqZVj5seRfZjtpGmsVWzoApE=;
 b=PiWfS6FbkQUPUib161834aVW5SOXhl6KaNyuns2+xmUte6QV+Be5WO7rV/hac60GfVWjvE4qXNZWL1XYI/0m8b0aPcB2Zuz4F/52ud9KRcbBrOgh2rC+LKsv0L7sRT2t73iaeOo4GiMm0+cZgV8WcEBFEmWG2AwxhWKHu0EA0oE=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0802MB2553.eurprd08.prod.outlook.com (2603:10a6:3:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Sun, 28 Jun
 2020 07:37:48 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a%6]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 07:37:47 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Justin He <Justin.He@arm.com>,
        Wei Chen <Wei.Chen@arm.com>
Subject: RE: [RFC PATCH 2/2] 9p: remove unused code in 9p
Thread-Topic: [RFC PATCH 2/2] 9p: remove unused code in 9p
Thread-Index: AQHWTPDBydmju/A/WUKh1sO640Qlb6jthqUAgAAQlGA=
Date:   Sun, 28 Jun 2020 07:37:47 +0000
Message-ID: <HE1PR0802MB255555FEE31EBF85981A2AC4F4910@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200628020608.36512-1-jianyong.wu@arm.com>
 <20200628020608.36512-3-jianyong.wu@arm.com> <20200628055210.GA13335@nautica>
In-Reply-To: <20200628055210.GA13335@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: d0a580d3-a78f-4211-a31f-be1436c9e5ac.1
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09577faa-23ce-449c-4fa7-08d81b362d71
x-ms-traffictypediagnostic: HE1PR0802MB2553:|VI1PR08MB4368:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB43681D62072AFA806B285F55F4910@VI1PR08MB4368.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:9508;
x-forefront-prvs: 0448A97BF2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kFBYeIKi2zfO9u6fMYm+CmNagX/dDOegj50rHsApPaW+EjtuCfmBNLVPJEGUcxplcCkl2704q4aXfd5/3m+a2KnWYBF/8TszTuQCzL1ZuNjGL6D3QAdNmc/reAAThnQop79Uu/jht/a6BiEu3H5IrTa4cT2Yxy1Vfbx4ZWIgsNBzEaYImA5PPN48oaVEJJnoMu5CqfRZdwNlykerehKnqnZKxSb6v5tQLoPq/WXeQ29Qnb0fNjCPYzj7RzJaH9zQCbes4EAPcmQPujRot/hMEbqQ8HrU8uF2NFVY8FpaQO+atwUEMP6zQQq2bLfnSoYVDs332VYIfV3x/IyiQjRaJg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39850400004)(136003)(366004)(4326008)(316002)(86362001)(7696005)(52536014)(5660300002)(6506007)(53546011)(478600001)(55016002)(66946007)(71200400001)(66446008)(64756008)(66556008)(66476007)(6916009)(76116006)(8676002)(26005)(33656002)(186003)(9686003)(83380400001)(2906002)(8936002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: z5/Q6oz7+3HMMMqiZbuYftaTSIJ4u/et06amFuAdvlQFbARf340NQQkDA9I9Hq/qoj2H5DIgWhtg0qVoJwvELsDm8CGpHtzePdgexKkJdGTu04j4old87Wl05E7aOoFL86gHz9APwS6XbK7yuhMpenrUDrjmd/mkSf9OBPUarC+cdStjPGCR9HbT27XEa23YF1FZRU/WWvSbj+LhK7fgyjxiEhGhJ6W7VwU0f+qhygljzRI1GlpUeip++gTjMfNFYi6yOvpGw49QW1IOWDMdIzLW5C99Y7wtcRuWw2oXV7XRq9HTfymB5BRkJQPQj0p0Rzw5Rh5t7rYHa0eb6qnKvB6vwlkZ9RwL31h9B9XUDhI5zFWag4QSD+UbRn0x5sikbASxlgRwzvDt++Gust+Tk3W5SS598OceWkwyfD+gBZtyIx0sSzjmUoqSs8glrG1taSLz3qkTWWxtv7xUzyiOg1iv+wzGFPHZ9O38LPqN+iQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2553
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39850400004)(136003)(46966005)(52536014)(86362001)(55016002)(36906005)(336012)(83380400001)(6862004)(54906003)(316002)(53546011)(33656002)(7696005)(5660300002)(9686003)(478600001)(6506007)(186003)(82310400002)(81166007)(26005)(4326008)(8936002)(356005)(2906002)(70586007)(82740400003)(8676002)(47076004)(70206006);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5f2284b9-7b82-4df6-e0c6-08d81b362796
X-Forefront-PRVS: 0448A97BF2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yYjKx367FRSJ3covTEf5f/9Ab6gt+ZcWn6aMOy+Yp011+MF5ow+AIuGdqulvsFDbzwIIGYKg3NuKIzZfGE+XE8vcgk1BDuyv6JKOMv2WDTmAk/jimKHTY8qUo95RTgM/jV0J76+CBQq9Y+5CyxurlDMel/mjZTGjI0B0IZlSC0mlBKDx579Lvnjp42OTUKQ7Ts9dmfCMwoRxdrkhBWl2Qqk42OiE6JeR8JH949ecqUC4PGZtU4kXdTHD07Iu0VoUWi0nu4GeFTOzOqeGqsB1rD80fcmOYCnAobzLSsAWFL6FsGZ+mzEe4X0NDidIhlwurdkHbLQ8PzOjPSO+rn9JkKhfV+zhBOmtybo/NFvBxmQW9NEaFAXAL9p43rAhoSk9YJIjCwUgxrb6H6+ivuXHQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2020 07:37:57.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09577faa-23ce-449c-4fa7-08d81b362d71
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogU3VuZGF5
LCBKdW5lIDI4LCAyMDIwIDE6NTIgUE0NCj4gVG86IEppYW55b25nIFd1IDxKaWFueW9uZy5XdUBh
cm0uY29tPg0KPiBDYzogZXJpY3ZoQGdtYWlsLmNvbTsgbHVjaG9AaW9ua292Lm5ldDsgdjlmcy0N
Cj4gZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgU3RldmUNCj4gQ2FwcGVyIDxTdGV2ZS5DYXBwZXJAYXJtLmNvbT47IEthbHkgWGlu
IDxLYWx5LlhpbkBhcm0uY29tPjsgSnVzdGluIEhlDQo+IDxKdXN0aW4uSGVAYXJtLmNvbT47IFdl
aSBDaGVuIDxXZWkuQ2hlbkBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAyLzJd
IDlwOiByZW1vdmUgdW51c2VkIGNvZGUgaW4gOXANCj4NCj4gSmlhbnlvbmcgV3Ugd3JvdGUgb24g
U3VuLCBKdW4gMjgsIDIwMjA6DQo+ID4gVGhlc2UgY29kZSBoYXMgYmVlbiBjb21tZW50ZWQgb3V0
IHNpbmNlIDIwMDcgYW5kIGxpZWQgaW4ga2VybmVsIHNpbmNlDQo+ID4gdGhlbi4gaXQncyB0aW1l
IHRvIHJlbW92ZSB0aGVzdCBubyB1c2VkIGNvZGUuDQo+DQo+IEdvb2QgcG9pbnQsIGhhcHB5IHRv
IHRha2UgdGhpcyAtIHBsZWFzZSByZXNlbmQgd2l0aG91dCBSRkMgc2VwYXJhdGVseSAodGhlDQo+
IHR3byBjb21taXRzIGFyZW4ndCByZWxhdGVkKSBhZnRlciBmaXhpbmcgdGhlIGNvbW1pdCBtZXNz
YWdlIChsaWUvbGF5IGlzDQo+IGNvbXBsaWNhdGVkIGFuZCBJJ20gbm90IHN1cmUgd2hhdCBzaG91
bGQgYmUgdXNlZCB0aGVyZSBidXQgbGllZCBkZWZpbml0ZWx5DQo+IGlzbid0IGNvcnJlY3QsIHRo
ZSBxdWFsaWZpY2F0aW9uIGRvZXNuJ3QgcmVhbGx5IG1hdHRlciB0aG91Z2ggc28gcHJvYmFibHkN
Cj4gc2ltcGxlciB0byByZW1vdmU7IGFuZCAndGhlc3Qgbm8gdXNlZCBjb2RlJyBkb2VzIG5vdA0K
PiBwYXJzZSkNCj4NClRoYW5rcywgSSB0aGluayAibGF5IiBpcyByaWdodC4gSSB3aWxsIGZpeCBp
dCBhbmQgcmVzZW5kLg0KDQpUaGFua3MNCkppYW55b25nDQoNCj4gLS0NCj4gRG9taW5pcXVlDQpJ
TVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRl
ciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3Ro
ZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBp
bmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
