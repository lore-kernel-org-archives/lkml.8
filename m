Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF95BC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A50220728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8iKe08hj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8iKe08hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAQNLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:11:31 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:6056
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgAQNLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdARaZoCgpNi+0ha2mfPyAMMVMaHGQrx17p7N11OXoo=;
 b=8iKe08hj7Uz5IJM210bTFSpQFFfiUmuhX0ymD7hv2DRE/RSabVeQVz7uVTKCu9i/yBojKxvXnkF9/0ki5Z9VKiVEyz3LL2eBeCc3ZqSolHn5rj+JqEn6qiYKB7iaplqX7syiHvwZKYpXNHHFn5i4i8uedDoOUN5Q0UxArLiSSdU=
Received: from AM6PR08CA0012.eurprd08.prod.outlook.com (2603:10a6:20b:b2::24)
 by AM0PR08MB5075.eurprd08.prod.outlook.com (2603:10a6:208:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Fri, 17 Jan
 2020 13:11:24 +0000
Received: from VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by AM6PR08CA0012.outlook.office365.com
 (2603:10a6:20b:b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Fri, 17 Jan 2020 13:11:24 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT026.mail.protection.outlook.com (10.152.18.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Fri, 17 Jan 2020 13:11:24 +0000
Received: ("Tessian outbound 4f3bc9719026:v40"); Fri, 17 Jan 2020 13:11:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4ef89b0dfeedf5f2
X-CR-MTA-TID: 64aa7808
Received: from def48f88f6e5.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 76DFF247-C165-4922-B8BA-D334A25034F9.1;
        Fri, 17 Jan 2020 13:11:18 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id def48f88f6e5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 17 Jan 2020 13:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI6f/b979GZWZ86hqenHMnW6llGnsXB4+0bGHy5/KLgfKFqgMfh4ImigIBbXwaZQTqFxJVJgnCjk3i0WjXDyxr3WuiDAPWsJmWB5QJ7yI8oEdgnHHn04qB0iarsTksIZM0iH6eJI5hcI1xMI9+c/E9np6aC5H0AzfTY5UFsbzkgt7vcu5ndZUL3cu3ZE4lKBem9dcVp2az5oR9gYhl6T8ahm52Fh7vY6bAnyiu7l9IFqqLXEw7AYiZYjzsOYjGbTwo0inPElFDl+fd+G/snTRMbXXPp4R622kXbuZOG6XWucdk76IlVuZxmpYW49Cqn8ptsCFMs3QCM9JPQzD4hXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdARaZoCgpNi+0ha2mfPyAMMVMaHGQrx17p7N11OXoo=;
 b=f1dbfc6qpJBIg3AMnNAhL1DUJfSphq9iar4N3CIabl1eTCHh+0LdjBaUlGAS+sUWqP9DjpDZR/4qUh9BjZpcD/wMoOyWVSSBl2apxgmIvMpsSUMD2PKEnB8JBPq3hCYzcIOTAGoFUyrmbOGaHkCsuM2Zvpal923ltSyI5X4dt4qOx+WUY5AYlvu/2xyxh4D/Hb2QV8N+F1YkY2nqpLZW6/cyAAmmbMVMQRLw+p2C/H3qpF/OSTlXc13Cb3myLMlGlWzhavNDGwDTkM5uPiJy4vIzA6NCuErhdVfNIb/06Qks25UdS4heWlzbhRHLiWVFp7Ra3rRHgBFYbDqk5s3f1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdARaZoCgpNi+0ha2mfPyAMMVMaHGQrx17p7N11OXoo=;
 b=8iKe08hj7Uz5IJM210bTFSpQFFfiUmuhX0ymD7hv2DRE/RSabVeQVz7uVTKCu9i/yBojKxvXnkF9/0ki5Z9VKiVEyz3LL2eBeCc3ZqSolHn5rj+JqEn6qiYKB7iaplqX7syiHvwZKYpXNHHFn5i4i8uedDoOUN5Q0UxArLiSSdU=
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com (10.169.225.144) by
 DB6PR0801MB1639.eurprd08.prod.outlook.com (10.169.227.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 13:11:17 +0000
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33]) by DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33%8]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 13:11:17 +0000
Received: from [10.32.36.146] (217.140.106.40) by LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 13:11:16 +0000
From:   James Clark <James.Clark@arm.com>
To:     Will Deacon <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <Al.Grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Return EINVAL when precise_ip perf events are
 requested on Arm
Thread-Topic: [PATCH 1/1] Return EINVAL when precise_ip perf events are
 requested on Arm
Thread-Index: AQHVy5LeO0vQVupKYkmqxxzraShD1qfuzyKAgAAHXwCAAAGLgA==
Date:   Fri, 17 Jan 2020 13:11:16 +0000
Message-ID: <1fea63d9-9b8d-d5ff-d043-a1e8f6b9b862@arm.com>
References: <20200115105855.13395-1-james.clark@arm.com>
 <20200115105855.13395-2-james.clark@arm.com>
 <20200117123920.GB8199@willie-the-truck>
 <20200117130543.GA9093@willie-the-truck>
In-Reply-To: <20200117130543.GA9093@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15)
 To DB6PR0801MB1638.eurprd08.prod.outlook.com (2603:10a6:4:38::16)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58e31618-4afb-47dc-1b56-08d79b4ec100
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1639:|DB6PR0801MB1639:|AM0PR08MB5075:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5075E7663D91760052E41620E2310@AM0PR08MB5075.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:5236;OLM:5236;
x-forefront-prvs: 0285201563
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(376002)(366004)(396003)(136003)(189003)(199004)(4744005)(6916009)(5660300002)(81166006)(81156014)(7416002)(52116002)(8676002)(186003)(8936002)(16526019)(53546011)(26005)(4326008)(2616005)(956004)(6486002)(478600001)(31686004)(44832011)(36756003)(2906002)(54906003)(31696002)(66556008)(66946007)(86362001)(71200400001)(316002)(16576012)(66446008)(66476007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1639;H:DB6PR0801MB1638.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TSn+aKk4mNXef9XdZxKmL/na0O9BXi3/pEiqXcH6fTq3h0wROCDMsADNB6KSPvc/is9mLbu8FllPYLqDNgsLJnPrKObUHod9eJi8oYHEQGxsWVZ4lsbMXBtHiNOhUD5FqaS86o36yallZUgUg9daKYLYh+bCEied74dKEquXg+timmuqUTleoIbQeHiLNiqnyTCTkHbwxPjzgHJLn3nJlRyn15fIfJzJ/ATkIyZh4p9eei+F8XuSWYvQxgcfgq8gqbBaeiavnqgmXy8/MYyX3dyf6Arx4Jz3cW8hCh8EYmy6zlSNl9y52N0fU0Bz7tpjAwSVtvmaUSFL3we46Unzp35+HUjUFV/l7RPbv97ILV+5mblvx+zbWl+JCC8asmpjKY1dAMsSj1M4dU+nNckpSCihbv2kH3xjq9FRseDfko0q/8rcMjhYLQDVlZ7sAnA5
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C7D8FEB2AFBD4986EA5EAEA968FCA5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1639
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39850400004)(396003)(346002)(199004)(189003)(356004)(8936002)(8676002)(81156014)(81166006)(336012)(186003)(16526019)(5660300002)(26005)(53546011)(4744005)(31696002)(316002)(36906005)(36756003)(86362001)(4326008)(16576012)(2906002)(70206006)(54906003)(478600001)(31686004)(956004)(6862004)(70586007)(2616005)(6486002)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5075;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9580083b-8f4e-4c66-f737-08d79b4ebc71
X-Forefront-PRVS: 0285201563
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JotLKiU144DV/wo27EiXYNoLbYcb9XaJMhlYihoF9sxkrPW0t7f3rD+TiStqDPY+JPzwepizz7hX1ducwzuvlCL861Er73xfUEGno7uBjiXeMDZBt811G7+azWciwt9Sk3cd8ozlKfa6Odo6Cq17KNAt6hyW/7o4W0h3FM7+rFsRqQsqTZ7+NeiCObeU+oRM7+l5xyc8ws5P+zjL10Yecsh/+TYTRJ15GGxXcfuEqwD788nvfQXBh90qfgNTrGF/992MRVLpbR+afzmENVfAqA08/Do2P97ppk6z48roW+pN2ricSkLCfCMYrAu1NatTujqCYFGHXjs9jw7XZfBkANr7vd3ANo1jmetAyHmcAAtMjt6IyJ9bUsEEyDxfSBF0DrnB29pYt2NxvMYq0YsuGx1PRj9WOWE6TZnrYDbK1VsmA3pjO/11Xd4g2H+a68Bg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 13:11:24.2747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e31618-4afb-47dc-1b56-08d79b4ec100
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCwNCg0KWWVzIHlvdSdyZSByaWdodCwgSSd2ZSBzb21laG93IG1hbmFnZWQgdG8gcG9z
dCBhIHZlcnNpb24gb2YgdGhlIHBhdGNoDQpmcm9tIGJlZm9yZSBJIGJ1aWx0IGFuZCB0ZXN0ZWQg
aXQuDQoNCkkgd2lsbCByZXBvc3QgaXQgc2hvcnRseSB3aXRoIHRoZSBvdGhlciBjaGFuZ2Ugc3Bs
aXQgb3V0IGFzIHdlbGwuDQoNCg0KVGhhbmtzDQpKYW1lcyANCg0KT24gMTcvMDEvMjAyMCAxMzow
NSwgV2lsbCBEZWFjb24gd3JvdGU6DQo+PiBPbiBXZWQsIEphbiAxNSwgMjAyMCBhdCAxMDo1ODo1
NUFNICswMDAwLCBKYW1lcyBDbGFyayB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
ZXJmL2FybV9wbXUuYyBiL2RyaXZlcnMvcGVyZi9hcm1fcG11LmMNCj4+PiBpbmRleCBkZjM1MmIz
MzRlYTcuLjRkZGJkYjkzYjNiNiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3BlcmYvYXJtX3Bt
dS5jDQo+Pj4gKysrIGIvZHJpdmVycy9wZXJmL2FybV9wbXUuYw0KPj4+IEBAIC0xMDIsNiArMTAy
LDkgQEAgYXJtcG11X21hcF9ldmVudChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsDQo+Pj4gIAl1
NjQgY29uZmlnID0gZXZlbnQtPmF0dHIuY29uZmlnOw0KPj4+ICAJaW50IHR5cGUgPSBldmVudC0+
YXR0ci50eXBlOw0KPj4+ICANCj4+PiArCWlmIChldmVudC0+YXR0ci5wcmVjaXNlKQ0KPj4+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiANCj4gQWxzbywgZG9lcyB0aGlzIGZpZWxkIGV2ZW4gZXhpc3Q/
IEd1ZXNzaW5nIHlvdSBtZWFuICdwcmVjaXNlX2lwJywgYnV0DQo+IHRoZW4gdGhhdCBtZWFucyB0
aGlzIGhhc24ndCBldmVuIHNlZW4gYSBjb21waWxlciA6KA0KPiANCj4gV2lsbA0KPiANCg==
