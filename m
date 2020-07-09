Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30E3206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xQRmKImm";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xQRmKImm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGIJhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:37:00 -0400
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:62201
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbgGIJg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNkJ1GT23bvVx7BKqyG/rMU6wJA3ldpjaggg8j/RWz4=;
 b=xQRmKImmnytsy8+mYv45XybSb71RGGbGRoDBT+mv6eeyfvUEKVaKSnZdr7SM5GSDdQffCbZB7YtTONS2sDpc6hVbcv1XqoXx8Fck4qs5/FIAAB4GOrYorFSrtdvxqiSc/IacUxm4qJ0S6K7xqMEifEAQOWQWLps35n95aliox2o=
Received: from AM4PR0302CA0023.eurprd03.prod.outlook.com (2603:10a6:205:2::36)
 by DB7PR08MB3308.eurprd08.prod.outlook.com (2603:10a6:5:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 09:36:52 +0000
Received: from AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:205:2:cafe::dc) by AM4PR0302CA0023.outlook.office365.com
 (2603:10a6:205:2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Thu, 9 Jul 2020 09:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT027.mail.protection.outlook.com (10.152.16.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 09:36:52 +0000
Received: ("Tessian outbound 73b502bf693a:v62"); Thu, 09 Jul 2020 09:36:51 +0000
X-CR-MTA-TID: 64aa7808
Received: from e4cf6cc6711d.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8C2728F8-1433-4020-A5A6-DB44C55AFBD7.1;
        Thu, 09 Jul 2020 09:36:46 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e4cf6cc6711d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 Jul 2020 09:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJLfq9G1JAhsSfpJYU8hZVWH2i6OpreXtBVmZSh9ht9Gvpeic7CDSKSOO/5UpKsGGdYHn9W7tKfbnPP5rdYKsBBRUqh6ERaZxNKDpxyLnAU/6HjFemjbr+I7XJC2cA9YDx8gLUAVI+nN0uautfgJtdmseJvHTvOqiMW0WRezeJibtSsqL527VdfVyo+Q6PuKGyBsy4jmLPv51xS0Eu2Yz/g2BK37RQfzkMOJ3m8+3pYyr0z0NwYGGhaIXdLdqsdN+hLUt1bvFf4yot7/T3ezqEpuzcuQ9cILvizDzxUrwyT/MwULJdZ/ya6M/IJLtaYXLwCW9fNW7JIeiKI7b2EumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNkJ1GT23bvVx7BKqyG/rMU6wJA3ldpjaggg8j/RWz4=;
 b=SGuJPa/tEUGBQQv2sbwMUSyTnadicyNAR/QYtdK3p/WFV3aErkn+ep/VUaRpJvt0PMQAXslImDmK8Yfn0yaIczqXVB7L7QtYpipUGI/0mBlhzk4lqD9Qvaah5AyXuT7w7he6xFWDLRKjhq8gXVBVZvqoqTNYYOy5wlskJpKBOyP9XYtqZ8oswiV4iuOeV5YIHwasCni/3fPuXKpeO25erjR6TXWzs/AGC4OjktDa/xEuBMdOsuGhx8YZTrrdDHujgMqBJJ5hpMolqFrQrbILOr3Bz5cLv4Zu+/RQmqrmPfXRppZayyD42gF++Vf85Z5mNCq5BarhBvpXqIVQJSHaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNkJ1GT23bvVx7BKqyG/rMU6wJA3ldpjaggg8j/RWz4=;
 b=xQRmKImmnytsy8+mYv45XybSb71RGGbGRoDBT+mv6eeyfvUEKVaKSnZdr7SM5GSDdQffCbZB7YtTONS2sDpc6hVbcv1XqoXx8Fck4qs5/FIAAB4GOrYorFSrtdvxqiSc/IacUxm4qJ0S6K7xqMEifEAQOWQWLps35n95aliox2o=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4408.eurprd08.prod.outlook.com (2603:10a6:20b:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 9 Jul
 2020 09:36:43 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 09:36:43 +0000
From:   Justin He <Justin.He@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: RE: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in
 arch specific directory
Thread-Topic: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in
 arch specific directory
Thread-Index: AQHWVZW4cB9QLv1x3USSUrS3ZjVOOaj+gToAgAB3WoCAAAAygIAABM2g
Date:   Thu, 9 Jul 2020 09:36:42 +0000
Message-ID: <AM6PR08MB406932241B7FB3753B77B113F7640@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-5-justin.he@arm.com>
 <20200709021104.GZ25523@casper.infradead.org>
 <20200709091815.GF781326@linux.ibm.com>
 <49a53674-f246-fdd6-009b-447a88cdb68e@redhat.com>
In-Reply-To: <49a53674-f246-fdd6-009b-447a88cdb68e@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2231c3a8-8a59-4901-a186-35c2b1673aa8.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7da9418c-4ece-4679-2c41-08d823eb9ca4
x-ms-traffictypediagnostic: AM6PR08MB4408:|DB7PR08MB3308:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB33084813E3B2C0522ABB6DBEF7640@DB7PR08MB3308.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:220;OLM:220;
x-forefront-prvs: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6hx1R9TLODq9DK6z3C4G5SvHatMqwOS7s7RM7Bg4GVdNU0SR+QOZ9Kr/It7d4u5QqBH1TqSHEYVM0ksIZgMarnSbxjbUwDcvHksO/3QjshScfcp5iWbc0UhMm1T0i9I2U+VNTMEwkYEw3fUQwu1ocVZ8rpB1Y9U7DHqjJdsLdRqerz7H0O92AcTU9sdgJbbCZdeYjCGZ392Uzk3xNa0m8PkBSGEljnHx0OCV/9fBb7kbWSJn4h4H7Wgnj2P7vdU2CYGq66T/AJsDz5O1g94PpP/0q4zBwOCsbQAUBGEPxAfImF49xzpADLDsf6UCDEFfagygCCaUcwiNVbNyrWeW5g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(316002)(6506007)(54906003)(110136005)(9686003)(86362001)(8676002)(52536014)(83380400001)(53546011)(5660300002)(26005)(33656002)(2906002)(66446008)(66476007)(64756008)(66556008)(66946007)(478600001)(55016002)(4326008)(71200400001)(7696005)(7416002)(186003)(8936002)(76116006)(7406005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LdVu64nkDjfdyPLZTLUM6C2bEskHMWCv56YV+OF7Of9zHgd9RyMCezG6mJvzV4a8PqKOR1Ld0aTUnl5d6DIk+TsjPOge5TTRWrLYC8ym1A6tYDorTXTw9o8RiPaDu2KH6uYxl4cIVtiGRAmeadOm9hPt0dy/kcUF8xZq/J6B74yHNUShv/RgWOp9yh0YiitOyG55cDurlzRxz+o3iGAiUGZlCNeyNF96vc3ZWvZiZWzO3cxIzMOJdim+caMvbSDE3hH7LGonLnZtdvSdMiI7YT/5K0Y0JKJIFDEulvXwSq0NrgIQdl8VG/QqoR9fK3aO0HKHn8/XTfEYcQIbZ+TqtyQNyZYO8Bqe61PsrC1g/vWwfdPSi8w+MbkkPOQw8aUAHPulP/TJYQIavdkXo7H+EZKVx2NfK3e16L3rKt36v6KOxa6Z+V8K2jxEqIle+uVDAH7aGPJWzKe/QQyWXdlCjgqgCxkSqwzYyQsaI2Jk8WA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4408
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966005)(8936002)(336012)(70586007)(2906002)(47076004)(81166007)(356005)(8676002)(82740400003)(6506007)(53546011)(110136005)(316002)(450100002)(478600001)(36906005)(70206006)(86362001)(54906003)(55016002)(52536014)(7696005)(5660300002)(9686003)(33656002)(83380400001)(26005)(186003)(4326008)(82310400002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 169e7c69-2863-4e2c-df06-08d823eb971e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6JvpPx1rKVsitVabdDU4E9uyOqjU+sa+DXbhaIT7kbuAfTgeBFwKww6wT2cXazqxMf0IdtlknMjcpWqAklPgDzEbP4ZtJzw3kC948O81IpvCzx1z2TzMuR8zgy6y++uiIZtJhDbSGjYet3cjd4Yv09uDhJVC25cBVJzUCmprmwtT+i0amFSB21j5usgNqJT4DnNSqMWFRpknn0Yxx4fiNyHEMMhU9e8afmEljtPxi519zUvNLldkMKV7X2d93lzWbbUelHtICQRnHltv/LnTPshi59NHM+ECbmhZEaudf4FCDIjd0iEc2vKOlkZIu7hYl5s5g/z+na8bAukKGg9xikWvXUhR97VYeSPllnPVhLutB1k3AbxslmTw/Qq1seM/9MMtebzr97BfJqPQ/DaIQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 09:36:52.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da9418c-4ece-4679-2c41-08d823eb9ca4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgOSwg
MjAyMCA1OjE5IFBNDQo+IFRvOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+OyBN
YXR0aGV3IFdpbGNveA0KPiA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IEp1c3RpbiBIZSA8
SnVzdGluLkhlQGFybS5jb20+OyBDYXRhbGluIE1hcmluYXMNCj4gPENhdGFsaW4uTWFyaW5hc0Bh
cm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IFRvbnkgTHVjaw0KPiA8dG9u
eS5sdWNrQGludGVsLmNvbT47IEZlbmdodWEgWXUgPGZlbmdodWEueXVAaW50ZWwuY29tPjsgWW9z
aGlub3JpIFNhdG8NCj4gPHlzYXRvQHVzZXJzLnNvdXJjZWZvcmdlLmpwPjsgUmljaCBGZWxrZXIg
PGRhbGlhc0BsaWJjLm9yZz47IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRl
bC5jb20+OyBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz47IFBldGVyDQo+IFppamxz
dHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJv
bml4LmRlPjsNCj4gSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBCb3Jpc2xhdiBQZXRr
b3YgPGJwQGFsaWVuOC5kZT47DQo+IHg4NkBrZXJuZWwub3JnOyBILiBQZXRlciBBbnZpbiA8aHBh
QHp5dG9yLmNvbT47IERhbiBXaWxsaWFtcw0KPiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsg
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBEYXZlDQo+IEppYW5nIDxk
YXZlLmppYW5nQGludGVsLmNvbT47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlv
bi5vcmc+Ow0KPiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT47IENodWhvbmcgWXVhbiA8aHNs
ZXN0ZXI5NkBnbWFpbC5jb20+OyBMb2dhbg0KPiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5j
b20+OyBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPjsNCj4gTWljaGFsIEhv
Y2tvIDxtaG9ja29Ac3VzZS5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlhNjRAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFu
LkNhbWVyb25AaHVhd2VpLmNvbT47IEthbHkgWGluIDxLYWx5LlhpbkBhcm0uY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDQvNl0gbW06IGRvbid0IGV4cG9ydCBtZW1vcnlfYWRkX3BoeXNh
ZGRyX3RvX25pZCBpbg0KPiBhcmNoIHNwZWNpZmljIGRpcmVjdG9yeQ0KPiANCj4gT24gMDkuMDcu
MjAgMTE6MTgsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+ID4gT24gVGh1LCBKdWwgMDksIDIwMjAg
YXQgMDM6MTE6MDRBTSArMDEwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+ID4+IE9uIFRodSwg
SnVsIDA5LCAyMDIwIGF0IDEwOjA2OjI3QU0gKzA4MDAsIEppYSBIZSB3cm90ZToNCj4gPj4+IEFm
dGVyIGEgZ2VuZXJhbCB2ZXJzaW9uIG9mIF9fd2VhayBtZW1vcnlfYWRkX3BoeXNhZGRyX3RvX25p
ZA0KPiBpbXBsZW1lbnRlZA0KPiA+Pj4gYW5kIGV4cG9ydGVkICwgaXQgaXMgbm8gdXNlIGV4cG9y
dGluZyB0d2ljZSBpbiBhcmNoIGRpcmVjdG9yeSBldmVuIGlmDQo+ID4+PiBlLGcsIGlhNjQveDg2
IGhhdmUgdGhlaXIgc3BlY2lmaWMgdmVyc2lvbi4NCj4gPj4+DQo+ID4+PiBUaGlzIGlzIHRvIHN1
cHByZXNzIHRoZSBtb2Rwb3N0IHdhcm5pbmc6DQo+ID4+PiBXQVJOSU5HOiBtb2Rwb3N0OiB2bWxp
bnV4OiAnbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQnIGV4cG9ydGVkIHR3aWNlLg0KPiA+Pj4g
UHJldmlvdXMgZXhwb3J0IHdhcyBpbiB2bWxpbnV4DQo+ID4+DQo+ID4+IEl0J3MgYmFkIGZvcm0g
dG8gaW50cm9kdWNlIGEgd2FybmluZyBhbmQgdGhlbiBzZW5kIGEgZm9sbG93LXVwIHBhdGNoIHRv
DQo+ID4+IGZpeCB0aGUgd2FybmluZy4gIEp1c3QgZm9sZCB0aGlzIHBhdGNoIGludG8gcGF0Y2gg
MS82Lg0KPiA+DQo+ID4gTW9yZW92ZXIsIEkgdGhpbmsgdGhhdCBwYXRjaGVzIDEtNCBjYW4gYmUg
bWVyZ2VkIGludG8gb25lLg0KPiA+DQo+IA0KPiArMQ0KDQpPa2F5LCB3aWxsIHVwZGF0ZSwgdGhh
bmtzDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
