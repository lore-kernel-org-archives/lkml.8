Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBDEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDDB2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="+BtWC0FE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="+BtWC0FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgEVPWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:22:44 -0400
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:6212
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgEVPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trliPlyC0B7I+7obHisMQO0eV3TNF+iG/STq+f+5M4k=;
 b=+BtWC0FEERPrh5oESLmBXGD2t45geX/ZIDuh8l+wIkTP8nT2Z/FXblea5i8YNGpjsQmThmPmXV+IbM9pfOjFYyioR3XyGfEsVNE8vTMbeXPoP2ZUmF0J+pPuwleP1xGbcBR1ZjQIvvOWXJinuHYywCVBf341/Yb+Q3Z9diZO0Ec=
Received: from MR2P264CA0132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::24)
 by HE1PR0801MB1963.eurprd08.prod.outlook.com (2603:10a6:3:4f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 15:22:37 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:30:cafe::29) by MR2P264CA0132.outlook.office365.com
 (2603:10a6:500:30::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Fri, 22 May 2020 15:22:37 +0000
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
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 15:22:36 +0000
Received: ("Tessian outbound facc38080784:v57"); Fri, 22 May 2020 15:22:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c408161a28354155
X-CR-MTA-TID: 64aa7808
Received: from 17773746ed05.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6336648E-3DDD-4E7D-9FAA-0A6E25CA0339.1;
        Fri, 22 May 2020 15:22:31 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 17773746ed05.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 22 May 2020 15:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d57mLRf5irAs0M3jSs+wjpUU0SexGywu3VfoB1qAMHkqtUlO6c6chOwIDiWGiHsOfejiv1ksIM3SBpxQJFpJR86sq6md8NTuZO9SoTSoElIoxBuQB7Q7vHbnz73KUVDA2O68o11c+1N0CqbWESJ+ScpfH0DPgK4TbWSB70ZzoxdmX4sq9QUTe4Rt04GA3AdaLaG3Cuw+5Bi5PWBsvwX5wNUt9UAkaHRpRKT66Jr8PDEc64W4FYesJJ0AkxlA/E77huoG5VRrzD6zcWdaDs6yrbtd7d2hQzFBbyz2VGfYBOXI42vlARrcfRYeZCTzYsBFLk/uHs5B28GOwzdmczEOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trliPlyC0B7I+7obHisMQO0eV3TNF+iG/STq+f+5M4k=;
 b=eycDGrAzChH3IDaa+ZctDHJdFT85B2UOQ+D/hjBOClU3jw84SvcY4CfIhxws1MztVw+kXUJ7PdFPe6u2nx06vFH1ty4Pq75fH+b2jsacNIoh4Gk0Io9KJTg6h12R4pUt/nbT6yw2YfPeSC/+v/HILiEVj3kaSrYAAPTSLVnBVNWUSWhOnzI3PrYZ1dGG9M4zK4v6PYjAlU1X35+v9sjWsZeQJlF4YSuLkxDMCHhF4BlJiRHgKbDHVhw8MNAXpOuflT4lUlpVk/2Brq1FaPl42iG4XvASL6wxRzTrpYmt5GdRox1Cg/gLbVKJzfQ2GkVV6zdwMQu+i3WFUdUYucrriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trliPlyC0B7I+7obHisMQO0eV3TNF+iG/STq+f+5M4k=;
 b=+BtWC0FEERPrh5oESLmBXGD2t45geX/ZIDuh8l+wIkTP8nT2Z/FXblea5i8YNGpjsQmThmPmXV+IbM9pfOjFYyioR3XyGfEsVNE8vTMbeXPoP2ZUmF0J+pPuwleP1xGbcBR1ZjQIvvOWXJinuHYywCVBf341/Yb+Q3Z9diZO0Ec=
Received: from DBBPR08MB4661.eurprd08.prod.outlook.com (2603:10a6:10:d6::16)
 by DBBPR08MB4630.eurprd08.prod.outlook.com (2603:10a6:10:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 15:22:29 +0000
Received: from DBBPR08MB4661.eurprd08.prod.outlook.com
 ([fe80::3591:2343:3c1e:e9f2]) by DBBPR08MB4661.eurprd08.prod.outlook.com
 ([fe80::3591:2343:3c1e:e9f2%5]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 15:22:29 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "C. Masloch" <pushbx@ulukai.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] docs: lzo: fix first byte interpretation off-by-one
Thread-Topic: [PATCH 1/2] docs: lzo: fix first byte interpretation off-by-one
Thread-Index: AQHWMELYinFr0zjPNkKUqVk77e36GKi0SdqA
Date:   Fri, 22 May 2020 15:22:29 +0000
Message-ID: <ED8A0242-10D3-4280-815F-BB38AB80251D@arm.com>
References: <20200522141040.1353769-1-pushbx@ulukai.org>
In-Reply-To: <20200522141040.1353769-1-pushbx@ulukai.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.37.20051002
Authentication-Results-Original: ulukai.org; dkim=none (message not signed)
 header.d=none;ulukai.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [80.5.131.174]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba2ab4cd-b46d-4511-120c-08d7fe63f571
x-ms-traffictypediagnostic: DBBPR08MB4630:|HE1PR0801MB1963:
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1963DA530C33211E6C9149CA8FB40@HE1PR0801MB1963.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:10000;
x-forefront-prvs: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 87LPAOQfDUWSAkTKi9UgIxsGZJhqQ+zx8V0iHmqMDq/CBPL8PqH/cT5CHn3fk3wvhfwhGJ04gceQxngLwx8uDeVIYG1pkf6FLW/p2JN96PAI8QlfO1T3alayuaNwAKoCQTErYdbMhLPKorPfLyITQIQS73ybzf0gfmWkJ7q0FM7+u8X4Zy8QPrOe+tFbPm+Ip+8REzuX12XWhLQ0Tz/UjJA0vx/MX9zdmB7To8qY0L9GTR9KP/h0ROGn6wyE4HxRQZwHtI/mi5U03PqhFm+hVoNNmhT1/FXkmT6bznDhxFrBRmg6arkxaM8esg5MbTj43Kbu2OtHLK7JOxTmHr0j0tZEtwO8L+5WciTeiRKhjAbBJrQxP9L6VlCkhFF+5ZO7olO0nEvqLDXigStTJpnnwOk+B6JZIP6UYH2pNFrP1o6s+QK/qj8GN+aJzP3ZHxCP
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4661.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(110136005)(4326008)(64756008)(478600001)(66446008)(66946007)(91956017)(2616005)(5660300002)(6506007)(6486002)(8676002)(8936002)(76116006)(316002)(36756003)(2906002)(26005)(44832011)(6512007)(33656002)(66476007)(54906003)(66556008)(71200400001)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Zj16drK0yWzuTSEMYjGp7Y12sX+9OTqTl8nKYMZ6EP/Bu4Ly4g9l8zko4p++toVpvekttIH8dVIRopFRAGhgJTEdvVU9OAwUFJqRgx+dVTg3H50izH1CZrRANl6JonJoChQhtEjnI2Yf2ptmvcu+6ALgE+nrGtrWcPUvbcYeH5DVbjcD8jYkLMaXuNDq7O1ijB4N68WjFk5X79Oebsji+BYfk/gSfx/R2jDeJESvFv0LLCit/u2f3oGdD7CybhuFivBJdgvEomNfomEvXB/vRTvlsOWhF+ljHnjA75WLh4IWEIYPnP9SRjdThBMbo/5Tuddh75lHBvWZREstLiZjlTfji+CE3v8zTZO1RjZMD7xKvh6nij2BjBmAuqLIwVhB9vdkZdjcXBrvA618UclavbKBEWqcFrdlMCgAH53TWW4ylH/n4as8dojBcuzVm/Irp4tRU4kvpo7XwgIXiqLUIKtHcNsr/EAWZNLyksge3ng=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <470D1CEE62E96041B53698D8CD194855@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4630
Original-Authentication-Results: ulukai.org; dkim=none (message not signed)
 header.d=none;ulukai.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966005)(47076004)(5660300002)(86362001)(6512007)(70206006)(8936002)(81166007)(2906002)(316002)(336012)(33656002)(4326008)(70586007)(36906005)(6506007)(186003)(8676002)(82740400003)(450100002)(44832011)(107886003)(6486002)(2616005)(82310400002)(26005)(54906003)(36756003)(110136005)(478600001)(356005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f8176fc0-dd71-4608-d139-08d7fe63f133
X-Forefront-PRVS: 04111BAC64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JT31Ejo9dy0ILL7tIEEOhjjOnKoayR1C5QX13SREd2wOKn6HuGPilIxMfTFA6NQrZjLZz3ylvdO88XCQVah37nix3jZaGZRM4L3pLqgFmRmeLommPhR7rc5ow5hvPHuweIRQm9fQZYZ78ySxVt4rP9knyUgFff2AhAmoZXHf7d38gbZSIwfFhyjb1yGeyTSu/HrFrSfhPlHjiM9wztMB6zQnm8Y2oPPHXf9OmeDWfHbl8K9oNtgOMKDBHxPLx4Fa2ohbz+/WE5DuE6oAd6vpO+xUFyIvkEzOOGmfIqaz4l4lEkNBxqMA4+Xsp+Qh0ldbDQYWhvYM065GWXenEdjbr4pIdGeD2u2snMOYNS1jOClJvy4QdcsVIrITDEpPoAdUvWa+sv0vkDDuvB6z2+KWHQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 15:22:36.7880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2ab4cd-b46d-4511-120c-08d7fe63f571
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1963
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WW91ciB1cGRhdGUgbG9va3MgY29ycmVjdCB0byBtZSwgdGhhbmtzLg0KDQpEYXZlDQoNCu+7v09u
IDIyLzA1LzIwMjAsIDE1OjExLCAiQy4gTWFzbG9jaCIgPHB1c2hieEB1bHVrYWkub3JnPiB3cm90
ZToNCg0KICAgIFRoZXJlIHdhcyBhbiBlcnJvciBpbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIGlu
aXRpYWwgYnl0ZSdzDQogICAgaW50ZXJwcmV0YXRpb24uIFdoaWxlICIxOC4uMjEiIHdhcyBsaXN0
ZWQgYXMgICJjb3B5IDAuLjMgbGl0ZXJhbHMiLA0KICAgIGl0IHNob3VsZCBhY3R1YWxseSBiZSBp
bnRlcnByZXRlZCBhcyAiY29weSAxLi40IGxpdGVyYWxzIi4NCg0KICAgIFRoZSAiYnl0ZSAtIDE3
IiBwYXJ0IGlzIGNvcnJlY3QuIDE3IHdvdWxkIGVuY29kZSBjb3B5aW5nICJ6ZXJvIg0KICAgIGxp
dGVyYWxzLCBidXQgZG9lcyBub3Qgb2NjdXIuIDE4IGVuY29kZXMgY29weWluZyAxIGxpdGVyYWws
DQogICAgMTkgdGhlbiAyIGxpdGVyYWxzLCAyMCBmb3IgMyBsaXRlcmFscywgMjEgZm9yIDQgbGl0
ZXJhbHMuDQogICAgVGhlIGRlc2NyaXB0aW9uIHNob3VsZCByZWFkICIxOC4uMjEiIGFzICJjb3B5
IDEuLjQgbGl0ZXJhbHMiLg0KICAgIExpa2V3aXNlLCAyMiBpbmRpY2F0ZXMgImNvcHlpbmcgNSBs
aXRlcmFscyIsIG5vdCAiNCBsaXRlcmFscyIuDQogICAgSG93ZXZlciwgdGhlIHN0YXRlIGlzIGlu
ZGVlZCBhbHdheXMgc2V0IHRvICJieXRlIC0gMTciICh3aGljaA0KICAgIGZvciAyMSByZXN1bHRz
IGluIDQgdG9vKS4NCg0KICAgIFNpZ25lZC1vZmYtYnk6IEMuIE1hc2xvY2ggPHB1c2hieEB1bHVr
YWkub3JnPg0KICAgIC0tLQ0KICAgICBEb2N1bWVudGF0aW9uL2x6by50eHQgfCA2ICsrKy0tLQ0K
ICAgICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQog
ICAgZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbHpvLnR4dCBiL0RvY3VtZW50YXRpb24vbHpv
LnR4dA0KICAgIGluZGV4IGNhOTgzMzI4OS4uZjgzOWQxMDRkIDEwMDY0NA0KICAgIC0tLSBhL0Rv
Y3VtZW50YXRpb24vbHpvLnR4dA0KICAgICsrKyBiL0RvY3VtZW50YXRpb24vbHpvLnR4dA0KICAg
IEBAIC0xMDgsMTIgKzEwOCwxMiBAQCBCeXRlIHNlcXVlbmNlcw0KICAgICAgICAgICAgICAgICAg
ICAgKHZlcnNpb24gMSBvbmx5KS4NCiAgICAgICAgICAgICAgICAgICAgIE90aGVyd2lzZSwgdGhl
IGJpdHN0cmVhbSB2ZXJzaW9uIGlzIDAuDQoNCiAgICAtICAgICAgMTguLjIxICA6IGNvcHkgMC4u
MyBsaXRlcmFscw0KICAgIC0gICAgICAgICAgICAgICAgc3RhdGUgPSAoYnl0ZSAtIDE3KSA9IDAu
LjMgIFsgY29weSA8c3RhdGU+IGxpdGVyYWxzIF0NCiAgICArICAgICAgMTguLjIxICA6IGNvcHkg
MS4uNCBsaXRlcmFscw0KICAgICsgICAgICAgICAgICAgICAgc3RhdGUgPSAoYnl0ZSAtIDE3KSA9
IDEuLjQgIFsgY29weSA8c3RhdGU+IGxpdGVyYWxzIF0NCiAgICAgICAgICAgICAgICAgICAgIHNr
aXAgYnl0ZQ0KDQogICAgICAgICAgIDIyLi4yNTUgOiBjb3B5IGxpdGVyYWwgc3RyaW5nDQogICAg
LSAgICAgICAgICAgICAgICBsZW5ndGggPSAoYnl0ZSAtIDE3KSA9IDQuLjIzOA0KICAgICsgICAg
ICAgICAgICAgICAgbGVuZ3RoID0gKGJ5dGUgLSAxNykgPSA1Li4yMzgNCiAgICAgICAgICAgICAg
ICAgICAgIHN0YXRlID0gNCBbIGRvbid0IGNvcHkgZXh0cmEgbGl0ZXJhbHMgXQ0KICAgICAgICAg
ICAgICAgICAgICAgc2tpcCBieXRlDQoNCiAgICAtLQ0KICAgIDIuMjYuMg0KDQoNCklNUE9SVEFO
VCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMg
YXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVk
aWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJz
b24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0
aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
