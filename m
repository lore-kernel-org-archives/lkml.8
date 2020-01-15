Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B08C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935672187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oFGhMka7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oFGhMka7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgAOMC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:02:28 -0500
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:35808
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729892AbgAOMC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyAPK9BgiqR1V+kXYhaWElPEAlhuoBWu2XyxsJPZJ0g=;
 b=oFGhMka7wmOUPXDkVeOmzVaxo9R6DxefBhb4jmEJno6OatVwuODm1RvM/EVsBAo6BZuB6QlQjqeY6c7MEmGpjPOhesd3F6i97WUYTSJnoz7uC2qqKCPBqeqo8UwMPl46ygUlDIBNhSXT994pdeNnPjf2hRj+u5dNbm6Rfxme0oM=
Received: from DB6PR0802CA0033.eurprd08.prod.outlook.com (2603:10a6:4:a3::19)
 by DB8PR08MB5194.eurprd08.prod.outlook.com (2603:10a6:10:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Wed, 15 Jan
 2020 12:02:20 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by DB6PR0802CA0033.outlook.office365.com
 (2603:10a6:4:a3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Wed, 15 Jan 2020 12:02:19 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 12:02:19 +0000
Received: ("Tessian outbound 1da651c29646:v40"); Wed, 15 Jan 2020 12:02:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3af7ab29f6f2e31f
X-CR-MTA-TID: 64aa7808
Received: from f40e48ce71c1.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0F489556-E0F2-46EA-94F7-4B12C731AFA6.1;
        Wed, 15 Jan 2020 12:02:14 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f40e48ce71c1.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 15 Jan 2020 12:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYP/3xmX8Gbp+cZmfqlq4a7HiS5++BOh4tlc0oXeNGbKXghK0Xr2QwAGM+k3QXSTFcohAjp1Gs4KdeOnCGGdUgjXguvRUpKmnbEHVz3VzUbpGkJgxzgmjK3nxxCNvovKSl/w4af+VjxUcz9gYleJ90wjB5Ii64QtG2GaJ8dboBf2rPiTW8o0rrLCzog2EqNru75tL0zsj1rKfL2ae2GaGRfyvFWcLoTj6Ix5KRHhr/WZ16UlDkZVfVg8ehpfXls59VX7Y32hpdIRRLQE1wKyQ2A0V/LS1gX/+h1lkeDHOLLsCdhpOGCTYJo2J8Kv0hbhFW46tRY1nRuLs5OG6KMouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyAPK9BgiqR1V+kXYhaWElPEAlhuoBWu2XyxsJPZJ0g=;
 b=QJS/1IE3BwVg77H79ZDaqSW7qIW1vHnOi02Xhna9UJIGec9gOIuaDMSHqqbGlXSpMm8fJrgepR+NsTGeEQLWqhJ24a1kWeDPnuvd/HULQX/oZo4Ole4gRSpBbqYCnRuFXLmU3eoTLhPICdwHnSholoNjkkJAoKJ6O0jUvAxMPxI5jRRPYvQqNPmoZDcG7f4koJN0ra5+q5UiEQ4pCyCko7pIRkeKN/ijBFE+mGJy4NondJctLzDxa6wU+dD0dC1+VkfPgfZVnQGu+IIAzR0cyFn8wT1buP/BZKYgnyPGLzpD/TKkZvYYVf+RdMkCGBGzGcwVclSImK2mNrtwQ59Kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyAPK9BgiqR1V+kXYhaWElPEAlhuoBWu2XyxsJPZJ0g=;
 b=oFGhMka7wmOUPXDkVeOmzVaxo9R6DxefBhb4jmEJno6OatVwuODm1RvM/EVsBAo6BZuB6QlQjqeY6c7MEmGpjPOhesd3F6i97WUYTSJnoz7uC2qqKCPBqeqo8UwMPl46ygUlDIBNhSXT994pdeNnPjf2hRj+u5dNbm6Rfxme0oM=
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com (10.169.225.144) by
 DB6PR0801MB1943.eurprd08.prod.outlook.com (10.168.85.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 12:02:10 +0000
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33]) by DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33%8]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 12:02:10 +0000
Received: from [10.32.36.146] (217.140.106.40) by LO2P123CA0028.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 12:02:09 +0000
From:   James Clark <James.Clark@arm.com>
To:     Tan Xiaojun <tanxiaojun@huawei.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "liuqi115@hisilicon.com" <liuqi115@hisilicon.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH 6/6] perf tools: arm-spe: fix record hang after being
 terminated
Thread-Topic: [PATCH 6/6] perf tools: arm-spe: fix record hang after being
 terminated
Thread-Index: AQHVtXIKzjHX0csLHUGYXwbffjbnM6frzFQA
Date:   Wed, 15 Jan 2020 12:02:10 +0000
Message-ID: <e581ed83-97d2-f37e-b1c1-b13b24e601c8@arm.com>
References: <20191218075455.5106-1-tanxiaojun@huawei.com>
 <20191218075455.5106-7-tanxiaojun@huawei.com>
In-Reply-To: <20191218075455.5106-7-tanxiaojun@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P123CA0028.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::16)
 To DB6PR0801MB1638.eurprd08.prod.outlook.com (2603:10a6:4:38::16)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a2866c5-df84-40e2-181e-08d799b2c5de
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1943:|DB6PR0801MB1943:|DB8PR08MB5194:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB51943C35421293F03DEA64DAE2370@DB8PR08MB5194.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 02830F0362
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(6636002)(64756008)(44832011)(7416002)(6486002)(4326008)(5660300002)(53546011)(66446008)(66556008)(86362001)(31696002)(478600001)(316002)(966005)(2616005)(66476007)(2906002)(71200400001)(186003)(16526019)(6666004)(956004)(81166006)(31686004)(110136005)(81156014)(8676002)(54906003)(36756003)(66946007)(52116002)(16576012)(8936002)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1943;H:DB6PR0801MB1638.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: dmBMBbTaQUnhIK8qeaLXmY8qIUZ2HExMoIPav4ViAGfLlgFCcW8fm+y7VxxpCJZD/IYUk2BSiesFy6fjQurMafnw7I6hD1bTLXjf3TPf1YtQWrYqY0oSiIGbGWAD1eX04hrj5HDF+Gr6Z2azwwFdnyzlMOhkPKU8qLq7wNTKv8deJmDDYwkNX/dXd8kRtOrFSro5kbfNOeADlX9nLAGW0S+KIymcPyLZtKQ5l5akiVhLJqjMgfVvONfkQbPcYEN9o1V6J80ZuI2DnqGQHGkkpTaoXpvWTYiAn+IZaStdeMPmZ4zFd/7Myk1ogPzk8Ah4Xj6yjcRPhfEa0DcGHQHUdDdzm8KaQlA5vpUo0EiFhVqhCk5MnIjR0F1u3SDrDr0M9QvojoYeDMrgjYOfbe/3nIINiEfIYEIMcVCjolUhy1rkRusMYLqVll9ceCJNwgNETLozQkQq202m0VW5xz5WG1xl4F5bsr08lNJtbRorzDLfzO59FTbxmpnZRr5B6qipxCpVjKf9EZgnBd8Tp1M9/ln2r3U1N2wPVm1aFDfRIesTE1pOFReVebS3ha+wi4T4BbAi7VcEZKyvTUOpwgVfbQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A8D9264D0A62944978321BDFF361D87@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1943
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(2906002)(8936002)(4326008)(966005)(110136005)(956004)(36756003)(81166006)(356004)(316002)(2616005)(86362001)(31696002)(70206006)(6636002)(31686004)(54906003)(6666004)(8676002)(81156014)(16576012)(450100002)(6486002)(478600001)(186003)(26826003)(16526019)(336012)(26005)(53546011)(70586007)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5194;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9f78c869-02c6-4bbb-65e0-08d799b2c026
X-Forefront-PRVS: 02830F0362
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d06SFX5/6rWVhZGvhFsrBVf7a1zH7I1BReQKYwtKp4skyLCTxHCUygWOyVqpSsyA6VdFMpMTw5bnLMAPCum7UCyYNdQy4W/hc98KG1iNYrAgRiLMZF305tUTWUe3i4XX7KuNzFfAU1iebGJjXliiHID1+lUyerkWu30cT2qMnP0Z9vzwbYUc8rdmOZvTjWnt20VEmFE8+AM6ZVqLwngupOwWyT4RsVtLyT6iNnCAfQKW4vlqmSeIhEIE/f3iX3WrSYgOTViLiPAWJ2xl8eE7opStk83bA9LLQZ4bTL1AYugRlKZdMsJldCr6/8kiKfB4faiPJ6b8CyCM/j9rsNi3GqGzsx07Z4fXTIYZe81zofTMp1BjKjdGYWs+hsbozjFQkUXnsB1PPlgFqm0hYwjvJa1mHXKIPQwYeMTnyG6xFSZxyHAJ4zTbV7/nbjH5K3fgQkn9hPO+7+DrQga0HsmbNeGi0B0vjZlHIIhFkR3RomxPo2zhQI0mPHM/95AZDwLCnthlImpKjhpjRJ7XRBVhFrRIgOqCS9LcbBZOjznqPkM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 12:02:19.8409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2866c5-df84-40e2-181e-08d799b2c5de
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWGlhb2p1biwNCg0KSSd2ZSB0ZXN0ZWQgdGhpcyBhbmQgaXQgYWxsIHNlZW1zIHRvIGJlIHdv
cmtpbmcgT0suIEkgb25seSBoYXZlIG9uZSBmaW5hbCBjaGFuZ2UgdG8gcHJvcG9zZSwgdGhhdCBp
ZiB3ZSB1bnNldCBwcmVjaXNlX2lwLCBhbG9uZyB3aXRoIHRoaXMgY2hhbmdlIA0KaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LWFybS1rZXJuZWwvMjAyMC1KYW51YXJ5
LzcwNTcyMC5odG1sIHdlIHdpbGwgZ2V0IGZlZWRiYWNrIGlmIGFuIGV2ZW50IGlzIG5vdCBzdXBw
b3J0ZWQgaW4gcHJlY2lzZSBtb2RlLg0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2Fy
bS1zcGUuYyBiL3Rvb2xzL3BlcmYvdXRpbC9hcm0tc3BlLmMNCmluZGV4IDBmY2FlZmQzODZhNi4u
YTNjMjNkMjg5NDgyIDEwMDY0NA0KLS0tIGEvdG9vbHMvcGVyZi91dGlsL2FybS1zcGUuYw0KKysr
IGIvdG9vbHMvcGVyZi91dGlsL2FybS1zcGUuYw0KQEAgLTkzNyw2ICs5MzcsNyBAQCB2b2lkIGFy
bV9zcGVfcHJlY2lzZV9pcF9zdXBwb3J0KHN0cnVjdCBldmxpc3QgKmV2bGlzdCwgc3RydWN0IGV2
c2VsICpldnNlbCkNCiAgICAgICAgICAgICAgICAgICAgICAgIGV2c2VsLT5jb3JlLmF0dHIuY29u
ZmlnID0gU1BFX0FUVFJfVFNfRU5BQkxFDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IFNQRV9BVFRSX0JSQU5DSF9GSUxURVI7DQogICAgICAgICAgICAg
ICAgICAgICAgICBldnNlbC0+Y29yZS5hdHRyLmNvbmZpZzEgPSBTUEVfQVRUUl9FVl9CUkFOQ0g7
DQorICAgICAgICAgICAgICAgICAgICAgICAgZXZzZWwtPmNvcmUuYXR0ci5wcmVjaXNlX2lwID0g
MDsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgIH0NCiB9DQoNClRoYW5rcw0KSmFtZXMNCg0K
T24gMTgvMTIvMjAxOSAwNzo1NCwgVGFuIFhpYW9qdW4gd3JvdGU6DQo+IEZyb206IFdlaSBMaSA8
bGl3ZWkzOTFAaHVhd2VpLmNvbT4NCj4gDQo+IElmIHRoZSBzcGUgZXZlbnQgaXMgdGVybWluYXRl
ZCwgd2UgZG9uJ3QgZW5hYmxlIGl0IGFnYWluIGhlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBX
ZWkgTGkgPGxpd2VpMzkxQGh1YXdlaS5jb20+DQo+IFRlc3RlZC1ieTogUWkgTGl1IDxsaXVxaTEx
NUBoaXNpbGljb24uY29tPg0KPiAtLS0NCj4gIHRvb2xzL3BlcmYvYXJjaC9hcm02NC91dGlsL2Fy
bS1zcGUuYyB8IDEwICsrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9hcmNoL2Fy
bTY0L3V0aWwvYXJtLXNwZS5jIGIvdG9vbHMvcGVyZi9hcmNoL2FybTY0L3V0aWwvYXJtLXNwZS5j
DQo+IGluZGV4IGViYTY1NDFlYzBmMS4uNjI5YmFkZGE3MjRkIDEwMDY0NA0KPiAtLS0gYS90b29s
cy9wZXJmL2FyY2gvYXJtNjQvdXRpbC9hcm0tc3BlLmMNCj4gKysrIGIvdG9vbHMvcGVyZi9hcmNo
L2FybTY0L3V0aWwvYXJtLXNwZS5jDQo+IEBAIC0xNjUsOSArMTY1LDEzIEBAIHN0YXRpYyBpbnQg
YXJtX3NwZV9yZWFkX2ZpbmlzaChzdHJ1Y3QgYXV4dHJhY2VfcmVjb3JkICppdHIsIGludCBpZHgp
DQo+ICAJc3RydWN0IGV2c2VsICpldnNlbDsNCj4gIA0KPiAgCWV2bGlzdF9fZm9yX2VhY2hfZW50
cnkoc3Blci0+ZXZsaXN0LCBldnNlbCkgew0KPiAtCQlpZiAoZXZzZWwtPmNvcmUuYXR0ci50eXBl
ID09IHNwZXItPmFybV9zcGVfcG11LT50eXBlKQ0KPiAtCQkJcmV0dXJuIHBlcmZfZXZsaXN0X19l
bmFibGVfZXZlbnRfaWR4KHNwZXItPmV2bGlzdCwNCj4gLQkJCQkJCQkgICAgIGV2c2VsLCBpZHgp
Ow0KPiArCQlpZiAoZXZzZWwtPmNvcmUuYXR0ci50eXBlID09IHNwZXItPmFybV9zcGVfcG11LT50
eXBlKSB7DQo+ICsJCQlpZiAoZXZzZWwtPnRlcm1pbmF0ZWQpDQo+ICsJCQkJcmV0dXJuIDA7DQo+
ICsJCQllbHNlDQo+ICsJCQkJcmV0dXJuIHBlcmZfZXZsaXN0X19lbmFibGVfZXZlbnRfaWR4KA0K
PiArCQkJCQkJc3Blci0+ZXZsaXN0LCBldnNlbCwgaWR4KTsNCj4gKwkJfQ0KPiAgCX0NCj4gIAly
ZXR1cm4gLUVJTlZBTDsNCj4gIH0NCj4gDQo=
