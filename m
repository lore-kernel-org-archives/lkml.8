Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB962C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EB8206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1JdroQWP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1JdroQWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGJNOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:14:09 -0400
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:12197
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbgGJNOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++q/zPJYxPwlKDTq3CZb6axDsxRAI2fjYY01w3bJfpc=;
 b=1JdroQWPUBSh36J8tXBxTGrX/5iyLQyGVk66xICO/SZ0DX/BRzv5CIU41hRPXiLhMRZ/71tpQFES24SxKtlqQz7Bs/qeI+9LX7vX2ctlBlSDO/lX6kDqcOMTcfnAlj6lYQ916pM07ticd1NBnQQqSDfYfDJqKF06r0h+KbSY45g=
Received: from AM5PR0602CA0024.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::34) by AM0PR08MB3476.eurprd08.prod.outlook.com
 (2603:10a6:208:dd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 13:14:03 +0000
Received: from AM5EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:a3:cafe::d7) by AM5PR0602CA0024.outlook.office365.com
 (2603:10a6:203:a3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 13:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT007.mail.protection.outlook.com (10.152.16.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 13:14:03 +0000
Received: ("Tessian outbound c4059ed8d7bf:v62"); Fri, 10 Jul 2020 13:14:02 +0000
X-CR-MTA-TID: 64aa7808
Received: from 71f697084cb6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6673BB7F-54DC-4740-B6FF-F3378343169B.1;
        Fri, 10 Jul 2020 13:13:57 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 71f697084cb6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 10 Jul 2020 13:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1yIhj908v7xLWWY1y/XRg275pat24thKKxsw2eBD5cjZm4Gb/vMmtQMivzN9InBuccQBefePT4fazE+46jvT9l906O3J3a7M0RM7jOTrpsblhxyWMo3LB5OsvwJYr5Op2ZgqF5QHC6ZzMeqtKgD/FJvsoYrIHcMvt0IhFu2JL+9S9grWtIV+hC/n7/ZCHyMwFzQKDH3DwUQHJZ7fsVb1QlxjPOkxkuqUSZDgRF28520vLhuPTkBQ7/aJLrA6/3FKyAbCXGI7BZNVbCaLn2nCyrNeBbmZTDP5jblsYS2La8omEJVIuuEGgXad3MTUYlkeX4pZ20MoQLn4xroEOvYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++q/zPJYxPwlKDTq3CZb6axDsxRAI2fjYY01w3bJfpc=;
 b=FSgL4GFhKS791WSFc7uPH3VxbQl1iEAABQXRUrVcMGdwZagJwUoBzSyZygpdugqMwfgT6RU6bPHkk1iKwrfLTrVKFVOG14wRAi5D5YwsGxxzv1UB3XEe7GeJUQj9sXGaeTNXrzpkFC2iS8hWASYTIHwGQy/BHi3mbMZ96ttVYP7y2A85u0zbTc2DVImR3KuD87GI3tr4f6SmXWtcbJfrplg2yRdj6PSS8HwVJa7ljyy15vCcA0Uu62fu9O9uhGj00iwZwzt6Wbo9RgHNwwPqoV22CSIvC9BPDrDMO8Cgp7DT+x4vLWvUI/uRFnTZT6xTWrQUMNdO81WzMy56Yl0ORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++q/zPJYxPwlKDTq3CZb6axDsxRAI2fjYY01w3bJfpc=;
 b=1JdroQWPUBSh36J8tXBxTGrX/5iyLQyGVk66xICO/SZ0DX/BRzv5CIU41hRPXiLhMRZ/71tpQFES24SxKtlqQz7Bs/qeI+9LX7vX2ctlBlSDO/lX6kDqcOMTcfnAlj6lYQ916pM07ticd1NBnQQqSDfYfDJqKF06r0h+KbSY45g=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4723.eurprd08.prod.outlook.com (2603:10a6:20b:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 13:13:52 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 13:13:51 +0000
From:   Justin He <Justin.He@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: RE: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
Thread-Topic: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
Thread-Index: AQHWVmiq+FAjJUzClE67BDeP0d/JJ6kAe80AgABODeA=
Date:   Fri, 10 Jul 2020 13:13:51 +0000
Message-ID: <AM6PR08MB40698B1225FE05220D1A1F9FF7650@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200710031619.18762-1-justin.he@arm.com>
 <23e79097-6517-a301-b0da-4d5505de3d3f@redhat.com>
In-Reply-To: <23e79097-6517-a301-b0da-4d5505de3d3f@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: b0781ec9-66de-46d5-8cf6-0de601389276.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [223.166.32.234]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 145cc511-2cbc-43f4-d7f8-08d824d31e3b
x-ms-traffictypediagnostic: AM6PR08MB4723:|AM0PR08MB3476:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB347637647AED9F8335AA04EDF7650@AM0PR08MB3476.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Qut2CD3tGUNyTIInvH3SE9cNCbXBuM2S4YDXLdDzCjAeqONKmrEY5ljM+pYXmwD901nWwDaAQ/yyMfN48B9feqZHUXtCP3ZVa+ynqC3WAt6895DkT2rgxwDRXF6BLrgW6yacXB4qh6lxM/KYSgtLNPFLWegBYgAntbxGRoueALrdSwDsX+rtowjt7rg/OzqLvey0qvZB5rtz9kSwHWAZHRmpG54LED/4apdiw5Kpv+vzvZI3zFSpf+0UGsLI9MCULoNjLbDzvN2iETXhypzwq8I2MpirboTqfTmtRM4Hr4L952foS7BHC7lzX7rgRkjjrO/B3LnRFkPvP9rtZP135wVf5k6x9f+oKjDqWateE3G6aXZCeJzgd1ggpsA+vNGS
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(26005)(8676002)(4326008)(8936002)(2906002)(86362001)(66446008)(64756008)(52536014)(66556008)(71200400001)(55016002)(33656002)(478600001)(9686003)(66946007)(186003)(66476007)(76116006)(110136005)(5660300002)(7696005)(54906003)(316002)(83380400001)(7406005)(53546011)(6506007)(7416002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Cno/Q1UNNWZudQquilMMYQ0QQfUx5wExU6FNyn/4xK61EYCeHC8EXE4xVzxx+EyUx52u+sEb1wLm826UpvbZ6LiDcXqptUdEgxgTG8zjPH0WCPeSxs6qnRUMNZiLKa9EEVUFwdR1QHtUilkrFP1/eT6OqyTfv7diP6mfDDorg6XLZRN8n+ydaNYqcpfaeCX7+mQ/wKfiTPGZaYHtjDNaZ5horGGAgL2p6pP0tj72vXsKPIXaLTRhzKYy1PHWm/Y96ks6UpeCzONAok9uVUaYOYHQXOCAt16AChb3SS6l79ZCbMx5bmc68fXCOGzzWxRl0Cq+NDEEsV6rXyFoUJ2tYeckO7ewRECXRv1BZ3pvkfuFE6kU+Ju5XsQT5JvKCdqpiiPq0CDLVl4d07nOsV1MfXavAmXFm1IlQ8wwbeVBJz/SGNF7Rum7RSQ2vlQBDGmUOoHDr6xOcpm2eiH8xvsjtrPd8QvJlM8G7tVZxL8s34S95VIJQhpDcrYyK9XHxF+g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4723
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(83380400001)(110136005)(2906002)(82310400002)(82740400003)(81166007)(47076004)(55016002)(8936002)(9686003)(356005)(33656002)(8676002)(186003)(336012)(26005)(86362001)(4326008)(450100002)(36906005)(7696005)(478600001)(70586007)(70206006)(54906003)(52536014)(316002)(53546011)(5660300002)(6506007)(921003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 78635c42-3f5c-4a0a-227e-08d824d3173c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+/IxMzOdVRhzIzoCUKWgSTPUkLzw34GerYtrVS4tOtphHUToMDybzuOoYUpiEhaDeBeMvSfQqczpEY4geoHZuLVhqRztAoIb7R150ZnxInzgYKtTvO3kG3i+m3lcanWvG6b7mnJ8esksNcjPqwupP7Y+IdTzLhrns2iwzUxSolMRazbrLdqV1cOaY1dkhB6QoESAv5O/Hnsdn34tdYfI/OuPoU/b57unjOrZreBAN4VOmB6cGdRTOoKquN7jKtofQzRV1/Pm/4aZG0d2ZmrndMTNSSfcvSOfieU4ofwAJePWa/EQGwNXzc0VfM/1ZSON3EhK3VDwWBsowvs4cjnJEXGWkLl3hr/gxxXWrciSlpO6AQys4d1zMQbwYidNOuMWIhyyp1vzujwK/TsZjcOiTR8JpnwzE7HNcKiCSyhcc4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:14:03.5803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145cc511-2cbc-43f4-d7f8-08d824d31e3b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBEYXZpZA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDEwLCAy
MDIwIDQ6MzAgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBDYXRhbGlu
IE1hcmluYXMNCj4gPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxA
a2VybmVsLm9yZz47IFRvbnkgTHVjaw0KPiA8dG9ueS5sdWNrQGludGVsLmNvbT47IEZlbmdodWEg
WXUgPGZlbmdodWEueXVAaW50ZWwuY29tPjsgWW9zaGlub3JpIFNhdG8NCj4gPHlzYXRvQHVzZXJz
LnNvdXJjZWZvcmdlLmpwPjsgUmljaCBGZWxrZXIgPGRhbGlhc0BsaWJjLm9yZz47IERhdmUgSGFu
c2VuDQo+IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+OyBBbmR5IEx1dG9taXJza2kgPGx1
dG9Aa2VybmVsLm9yZz47IFBldGVyDQo+IFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsNCj4gSW5nbyBNb2xuYXIgPG1p
bmdvQHJlZGhhdC5jb20+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gQ2M6IHg4
NkBrZXJuZWwub3JnOyBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT47IERhbiBXaWxsaWFt
cw0KPiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsgVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52
ZXJtYUBpbnRlbC5jb20+OyBEYXZlDQo+IEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT47IEFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+Ow0KPiBCYW9xdWFuIEhlIDxi
aGVAcmVkaGF0LmNvbT47IENodWhvbmcgWXVhbiA8aHNsZXN0ZXI5NkBnbWFpbC5jb20+OyBNaWtl
DQo+IFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+OyBMb2dhbiBHdW50aG9ycGUgPGxvZ2Fu
Z0BkZWx0YXRlZS5jb20+Ow0KPiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PjsgTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBpYTY0QHZnZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnOw0KPiBsaW51eC1tbUBrdmFjay5vcmc7IEpvbmF0aGFuIENhbWVy
b24gPEpvbmF0aGFuLkNhbWVyb25ASHVhd2VpLmNvbT47IEthbHkNCj4gWGluIDxLYWx5LlhpbkBh
cm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvMl0gRml4IGFuZCBlbmFibGUgcG1l
bSBhcyBSQU0gZGV2aWNlIG9uIGFybTY0DQo+IA0KPiBPbiAxMC4wNy4yMCAwNToxNiwgSmlhIEhl
IHdyb3RlOg0KPiA+IFRoaXMgZml4aWVzIGEgZmV3IGlzc3VlcyB3aGVuIEkgdHJpZWQgdG8gZW5h
YmxlIHBtZW0gYXMgUkFNIGRldmljZSBvbg0KPiBhcm02NC4NCj4gPg0KPiA+IFRvIHVzZSBtZW1v
cnlfYWRkX3BoeXNhZGRyX3RvX25pZCBhcyBhIGZhbGxiYWNrIG5pZCwgaXQgd291bGQgYmUgYmV0
dGVyDQo+ID4gaW1wbGVtZW50IGEgZ2VuZXJhbCB2ZXJzaW9uIChfX3dlYWspIGluIG1tL21lbW9y
eV9ob3RwbHVnLiBBZnRlciB0aGF0LA0KPiBhcm02NC8NCj4gPiBzaC9zMzkwIGNhbiBzaW1wbHkg
dXNlIHRoZSBnZW5lcmFsIHZlcnNpb24sIGFuZCBQb3dlclBDL2lhNjQveDg2IHdpbGwNCj4gdXNl
DQo+ID4gYXJjaCBzcGVjaWZpYyB2ZXJzaW9uLg0KPiA+DQo+ID4gVGVzdGVkIG9uIFRodW5kZXJY
MiBob3N0L3FlbXUgIi1NIHZpcnQiIGd1ZXN0IHdpdGggYSBudmRpbW0gZGV2aWNlLiBUaGUNCj4g
PiBtZW1ibG9ja3MgZnJvbSB0aGUgZGF4IHBtZW0gZGV2aWNlIGNhbiBiZSBlaXRoZXIgaG90LWFk
ZGVkIG9yIGhvdC0NCj4gcmVtb3ZlZA0KPiA+IG9uIGFybTY0IGd1ZXN0LiBBbHNvIHBhc3NlZCB0
aGUgY29tcGlsYXRpb24gdGVzdCBvbiB4ODYuDQo+ID4NCj4gPiBDaGFuZ2VzOg0KPiA+IHY0OiAt
IHJlbW92ZSAiZGV2aWNlLWRheDogdXNlIGZhbGxiYWNrIG5pZCB3aGVuIG51bWFfbm9kZSBpcyBp
bnZhbGlkIiwNCj4gd2FpdA0KPiA+ICAgICAgIGZvciBEYW4gV2lsbGlhbXMnIHBoeXNfYWRkcl90
b190YXJnZXRfbm9kZSgpIHBhdGNoDQo+IA0KPiBTbywgdGhpcyBzZXJpZXMgbm8gbG9uZ2VyIGRv
ZXMgd2hhdCBpdCBwcm9taXNlcz8gIkZpeCBhbmQgZW5hYmxlIHBtZW0gYXMNCj4gUkFNIGRldmlj
ZSBvbiBhcm02NCINCj4gDQpIbW0sIGEgbGl0dGxlIGJpdCBhd2t3YXJkIGJ1dCBzZWVtcyBubyBs
b25nIHdoYXQgaXQgcHJvbWlzZXMuIEhvdyBhYm91dA0Kc2VuZGluZyBwYXRjaDEgcGF0Y2gyIGlu
ZGl2aWR1YWxseSB3aXRob3V0IHRoaXMgY292ZXItbGV0dGVyPw0KDQotLQ0KQ2hlZXJzLA0KSnVz
dGluIChKaWEgSGUpDQoNCg0K
