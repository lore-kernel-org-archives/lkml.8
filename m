Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621B0C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D542083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="P2DtWjX+";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="P2DtWjX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAQPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:02:32 -0500
Received: from mail-vi1eur05on2050.outbound.protection.outlook.com ([40.107.21.50]:14656
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbgAQPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdwHladTKtuNAu3YvL+dRm4XdEBsdqWx+A3DHMGTl9c=;
 b=P2DtWjX+0aT5LKGHLzMMJ7+3fpLO3E9MOVGtk0HR5MZ8uVF+eKVRenKgObnoMtlV8aYefGFJ00VM3A5zcJoKLKLUWZ21++Phu0SWUl5IbVT8S6NWDjPOqOaTFDmRLDbJVzV3H0KNloRGLxLn25EPR6xb0OwBX5GvCF/M4YRsAnk=
Received: from AM6PR08CA0013.eurprd08.prod.outlook.com (2603:10a6:20b:b2::25)
 by AM0PR08MB2993.eurprd08.prod.outlook.com (2603:10a6:208:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Fri, 17 Jan
 2020 15:00:45 +0000
Received: from AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM6PR08CA0013.outlook.office365.com
 (2603:10a6:20b:b2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Fri, 17 Jan 2020 15:00:44 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT027.mail.protection.outlook.com (10.152.16.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Fri, 17 Jan 2020 15:00:44 +0000
Received: ("Tessian outbound e09e55c05044:v40"); Fri, 17 Jan 2020 15:00:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ce0c058230d43667
X-CR-MTA-TID: 64aa7808
Received: from a7140a881193.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5CD18B9C-0264-41EF-BD55-55969B52A574.1;
        Fri, 17 Jan 2020 15:00:39 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a7140a881193.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 17 Jan 2020 15:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyjDe9MitMEkv3RAC7sNjn73x+kE6i3PIjyH57AyM3fZbP2vhlbIhUTAU7+KH4dVbhCqxZxtf+Ueg5oZ8cMzqfOPP9Wu89p38PdIzQfBjjgNAZwWLDdgZeZy0qeOX8q++dUEwvY8BIKRtI/Ji87o9q0TxJKS4aKM8VaLSiL26lO+AV21Q/Kr1HiZmfDuvmpEfe8V/k2NGHBnuUPHooXxPyeDmY8Kq32NkhDVAsEYF/0QlGbmsOiISSmlNP/u6dcevpw5nmr1TwWtACEPDn8jEUQwpiFxnRGBmsDYCc8NptLbM+1P/FKwUtBlIRe7HbIq2jkrmkXXjW37/97ir6rt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdwHladTKtuNAu3YvL+dRm4XdEBsdqWx+A3DHMGTl9c=;
 b=ar/7L0D8Zkf16LJUm+ff+D2n1phsxvs1F26dR6HPLCJUtDZmpBhhJM/lO3T+Wm5d9EzXWNItBJHP3qu7nYKYnGBbxHsVBPovz+e/6Oh9Qvy/kE2VAHB7nbZVaDdbA97U5zkAReBIzo4mXBWrPKAjcirnCXSlQJ4eelCB2YiLzgg21D0618WQWukATx2xdQqI/kx6sVtmJia9hyiwjDLjUXK8d/QtKA8mBsrTiofIyWLVi8k9/1H3oxhPx2F2bm78NwBEFhFT+zcF1qjZ8R6qvosSNf2Xx4PItczbdtSktAUtShuYAaf7JEFZBTqQJuHfp4UTo4PI8mgaPcpU7o4DSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdwHladTKtuNAu3YvL+dRm4XdEBsdqWx+A3DHMGTl9c=;
 b=P2DtWjX+0aT5LKGHLzMMJ7+3fpLO3E9MOVGtk0HR5MZ8uVF+eKVRenKgObnoMtlV8aYefGFJ00VM3A5zcJoKLKLUWZ21++Phu0SWUl5IbVT8S6NWDjPOqOaTFDmRLDbJVzV3H0KNloRGLxLn25EPR6xb0OwBX5GvCF/M4YRsAnk=
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com (10.169.225.144) by
 DB6PR0801MB1719.eurprd08.prod.outlook.com (10.169.226.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 15:00:38 +0000
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33]) by DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33%8]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 15:00:37 +0000
Received: from [10.32.36.146] (217.140.106.40) by LO2P123CA0001.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Fri, 17 Jan 2020 15:00:36 +0000
From:   James Clark <James.Clark@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
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
Thread-Index: AQHVy5LeO0vQVupKYkmqxxzraShD1qfuzyKAgAAXA4CAABBzgA==
Date:   Fri, 17 Jan 2020 15:00:37 +0000
Message-ID: <1231fd60-79cd-fcdf-8b99-a3be746bf2d1@arm.com>
References: <20200115105855.13395-1-james.clark@arm.com>
 <20200115105855.13395-2-james.clark@arm.com>
 <20200117123920.GB8199@willie-the-truck>
 <20200117140143.GD14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200117140143.GD14879@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::13) To DB6PR0801MB1638.eurprd08.prod.outlook.com
 (2603:10a6:4:38::16)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b18f04f8-8ca1-43e4-ee73-08d79b5e0764
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1719:|DB6PR0801MB1719:|AM0PR08MB2993:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB29937A9F8D96F55DF41A7894E2310@AM0PR08MB2993.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0285201563
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(4326008)(2616005)(2906002)(478600001)(31686004)(16576012)(6486002)(956004)(316002)(54906003)(52116002)(36756003)(71200400001)(110136005)(81166006)(16526019)(44832011)(26005)(53546011)(186003)(5660300002)(31696002)(66946007)(66446008)(66556008)(86362001)(64756008)(8676002)(66476007)(8936002)(7416002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1719;H:DB6PR0801MB1638.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bgWu88xMV9bysis7UhwdJ/MQci+tr1TxCs8rfCwJmwDQQkSJQXNjmctX/mi44mlyqU5l/oHk8+MysslcQUoMaPZ+KdzqZXYxFAU6CSTq9KThKp6p4b9mTiazOdze7V9iB3PRvAnjH1JtztLtoIgVqn+BVHMQry3G6J4R4eG3dU+CGWoBreoYHu1CGGypTGcQIyzUejly/lodGGlBRVljYmy7+yQ/xrg3ffDLzgJYAojBSaYlYhPwCsyyamGGLHCABEeIZENylpb7+pG0jJJ7JlHXLgxmote+YcbusXTpjJRMOF9NUE+fF1XIDdIzJPo+dpLQMk4gFygNrlT9cqss9oJFomlp6xtzU647pqdiGxuYZ4nAiQREaKha9OM6o89YI+hPdN55j5SjSFAF9e8rfY94nwHKA4NSqV65V87g12t5IS02z6/DKK0FJDTXYzQb
Content-Type: text/plain; charset="utf-8"
Content-ID: <0284A2D25D767245B58FF469E59F5F11@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1719
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(189003)(199004)(16576012)(2906002)(26826003)(31696002)(4326008)(478600001)(26005)(356004)(5660300002)(8936002)(53546011)(81166006)(36756003)(8676002)(81156014)(36906005)(110136005)(31686004)(6486002)(70586007)(70206006)(186003)(2616005)(54906003)(316002)(86362001)(16526019)(956004)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB2993;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c0a3fe11-2ee5-4efe-d796-08d79b5e02f9
X-Forefront-PRVS: 0285201563
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLuhZ5U4k7ekhPxXlr7JVzB747+3uIjhGUX1mVs1LdrURvqmZt5wwIjp9L8A1pmJMn0vOyg4UJc8esil9eA8nH0zs17TMqA0Ny/7Ue4mWF2CJziDMBHOIQrdvZrzFYh7bsScqWYBIK10BlhV5PLQbpBDdxRQwifephaTxHNog8bqbeLY456KY++rkeqdTs0prlr/0OflYn0KVm0eqOPt3hBq+5c89ABC2hzLOyS//ln+MyvUuKMsvlkRPIftDH8xXIbnqpjFb8ohORrzuf5nrbJbkrKtomXQOj2/QJZvuChYGLFb6H0KhrJ+od4Kz70GQW2H+4Gc9b1vqmgUSXo1pO3mzt1U7bQhwDaFtBaSotK0Igta1KH/Mgnf3w84wYXEl8LSqVOj4d9/QR1xK3ftjdlsamLisEUcP9pUWBx8tUntUTHwGJrLRf0Yf45ga+/+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 15:00:44.8890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18f04f8-8ca1-43e4-ee73-08d79b5e0764
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCkRvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIHRoaXM/DQoNCg0KZGlmZiAt
LWdpdCBhL2tlcm5lbC9ldmVudHMvY29yZS5jIGIva2VybmVsL2V2ZW50cy9jb3JlLmMNCmluZGV4
IDQzZDFkNDk0NTQzMy4uZjc0YWNkMDg1YmVhIDEwMDY0NA0KLS0tIGEva2VybmVsL2V2ZW50cy9j
b3JlLmMNCisrKyBiL2tlcm5lbC9ldmVudHMvY29yZS5jDQpAQCAtMTA4MTIsNiArMTA4MTIsMTIg
QEAgcGVyZl9ldmVudF9hbGxvYyhzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyLCBpbnQgY3B1
LA0KICAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtdTsNCiAgICAgICAgfQ0KIA0KKyAgICAgICBp
ZiAoZXZlbnQtPmF0dHIucHJlY2lzZV9pcCAmJg0KKyAgICAgICAgICAgICAgICEocG11LT5jYXBh
YmlsaXRpZXMgJiBQRVJGX1BNVV9DQVBfUFJFQ0lTRV9JUCkpIHsNCisgICAgICAgICAgICAgICBl
cnIgPSAtRU9QTk9UU1VQUDsNCisgICAgICAgICAgICAgICBnb3RvIGVycl9wbXU7DQorICAgICAg
IH0NCisNCiAgICAgICAgZXJyID0gZXhjbHVzaXZlX2V2ZW50X2luaXQoZXZlbnQpOw0KICAgICAg
ICBpZiAoZXJyKQ0KICAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtdTsNCg0KDQpPciBzaG91bGQg
aXQgb25seSBiZSBkb25lIHZpYSBzeXNmcyB0byBub3QgYnJlYWsgdXNlcnNwYWNlPw0KDQpJZiB0
aGlzIHdhcyBkb25lIHZpYSBzeXNmcyB3b3VsZCBpdCBiZSBwb3NzaWJsZSB0byBleHByZXNzIHRo
YXQgc29tZSBldmVudHMgc3VwcG9ydA0Kc29tZSBhdHRyaWJ1dGVzIGFuZCBvdGhlcnMgZG9uJ3Q/
IEl0IHNlZW1zIGxpa2UgdGhlICJjYXBzIiBmb2xkZXIgY291bGRuJ3QgYmUNCnRoYXQgZmluZSBn
cmFpbmVkLg0KDQpPbiAxNy8wMS8yMDIwIDE0OjAxLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4g
T24gRnJpLCBKYW4gMTcsIDIwMjAgYXQgMTI6Mzk6MjFQTSArMDAwMCwgV2lsbCBEZWFjb24gd3Jv
dGU6DQo+IA0KPj4gUGVyaGFwcyBhIGJldHRlciB3YXkgd291bGQgYmUgdG8gZXhwb3NlIHNvbWV0
aGluZyB1bmRlciBzeXNmcywgYSBiaXQgbGlrZQ0KPj4gdGhlIGNhcHMgZGlyZWN0b3J5IGZvciB0
aGUgU1BFIFBNVSwgd2hpY2ggaWRlbnRpZmllcyB0aGUgZmllbGRzIG9mIHRoZSBhdHRyDQo+PiBz
dHJ1Y3R1cmUgdGhhdCB0aGUgZHJpdmVyIGRvZXMgbm90IGlnbm9yZS4gSSB0aGluayBkb2luZyB0
aGlzIGFzIGFuIEFybS1QTVUNCj4+IHNwZWNpZmljIHRoaW5nIGluaXRpYWxseSB3b3VsZCBiZSBm
aW5lLCBidXQgaXQgd291bGQgYmUgZXZlbiBiZXR0ZXIgdG8gaGF2ZQ0KPj4gc29tZXRoaW5nIHdo
ZXJlIGEgZHJpdmVyIGNhbiB0ZWxsIHBlcmYgY29yZSBhYm91dCB0aGUgcGFydHMgaXQgcmVzcG9u
ZHMgdG8NCj4+IGFuZCBoYXZlIHRoaXMgc3R1ZmYgcG9wdWxhdGVkIGF1dG9tYXRpY2FsbHkuIFRo
ZSBjdXJyZW50IGRlc2lnbiBtYWtlcyBpdA0KPj4gaW5ldml0YWJsZSB0aGF0IFBNVSBkcml2ZXJz
IHdpbGwgaGF2ZSBpc3N1ZXMgbGlrZSB0aGUgb25lIHlvdSBwb2ludCBvdXQgaW4NCj4+IHRoZSBj
b3ZlciBsZXR0ZXIuDQo+Pg0KPj4gVGhvdWdodHM/DQo+IA0KPiBXZSBoYXZlIFBFUkZfUE1VX0NB
UF8gZmxhZ3Mgd2UgY291bGQgZXh0ZW5kIHRvIHRoYXQgcHVycG9zZS4NCj4gDQo=
