Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD67C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBC620702
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yWauA9AS";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yWauA9AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgF1Gvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:51:42 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:54022
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgF1Gvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iupa0qIeJha3akXpE9IMR3bJbXYJRW2ji9lDDAj8d4=;
 b=yWauA9ASrfcGB8q5n0pbnIphlnkpR60s/9XvJZ+YAPEBe3C7s8uF6+W1ulRjZ9T38+pUClmdGsLlmq2OGXkvPfwEEktNINQQEo+LaQct7mCWM+B9QJm9pRznBmOnVcCO7NbX2Ob0H2Yku15GnYwzxrOl6nXCJaeGMwNMMQbhWpE=
Received: from DB8P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::14)
 by AM0PR08MB5476.eurprd08.prod.outlook.com (2603:10a6:208:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Sun, 28 Jun
 2020 06:51:35 +0000
Received: from DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::56) by DB8P191CA0004.outlook.office365.com
 (2603:10a6:10:130::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Sun, 28 Jun 2020 06:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT063.mail.protection.outlook.com (10.152.20.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Sun, 28 Jun 2020 06:51:35 +0000
Received: ("Tessian outbound 4df70ead97c2:v60"); Sun, 28 Jun 2020 06:51:35 +0000
X-CR-MTA-TID: 64aa7808
Received: from fe3982425053.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 703BE5BC-BF20-4D21-8EDF-039CEA9CA27C.1;
        Sun, 28 Jun 2020 06:51:30 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fe3982425053.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sun, 28 Jun 2020 06:51:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5WD/PHbPIoDkmv4iefiumuNFOijpdJDVmmXtlrX7PzwMABT7PRJQi0TlD2U01fJH9SEtf6M11NF/a/HYUw8/ck6FYxl1sodLtBZdoG3HYBxp2u2iMCDa9Wcr0qfM2EEIKFMzHon/cZNCAM8c2I0b5NGaeq/uIrHpBVgCfGCvljQ8rSBzwyKyXaRyuwPiW7kj6HvlXDA3m34U83MUzpX38c03MLG4AL1SBB64vBLOKUGoUgosisq0Lxvodwq8S9LE2mGUqYP+Sxf3y4yASxdFRTcwUj4zs4oOObuGOUIwGS8FbmJgF3T6sFKJhB7Ia8kSHOdRh7WB9nIUl+e12OLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iupa0qIeJha3akXpE9IMR3bJbXYJRW2ji9lDDAj8d4=;
 b=NBnc2QJcjcLaTbogeHc66QwBh7r/GBXGGOmwgrFxEXU+cbiW9HpmB6cYfFao3WQKfvNfNGGp7Uq30M/msVaYwoIcSG5dxcC4W/uXX95bs+/usb+utmd1qpQYubNhxe3pZfiZGJl5FLVUPrnou9GGezoPIKMeuhj1XqFWQfUQst+k7CzAEE62dA4dCXR9HaQPwiOJuXvIYXF0znbi13gVI8nQwbtOaFC6Vu0PqynLxFNLr/EOuBHidIL/R61OFOQh+VhaiWsCHRdXuwBJOkh6HvR0lulW151PptdceqF2WSeltSmrUq0i6Gsz34Yb7+lKBd3joYD/VnRTz7KOA1tB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iupa0qIeJha3akXpE9IMR3bJbXYJRW2ji9lDDAj8d4=;
 b=yWauA9ASrfcGB8q5n0pbnIphlnkpR60s/9XvJZ+YAPEBe3C7s8uF6+W1ulRjZ9T38+pUClmdGsLlmq2OGXkvPfwEEktNINQQEo+LaQct7mCWM+B9QJm9pRznBmOnVcCO7NbX2Ob0H2Yku15GnYwzxrOl6nXCJaeGMwNMMQbhWpE=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR08MB2924.eurprd08.prod.outlook.com (2603:10a6:7:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Sun, 28 Jun
 2020 06:51:27 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a%6]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 06:51:27 +0000
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
Subject: RE: [RFC PATCH 1/2] 9p: retrieve fid from file when file instance
 exist.
Thread-Topic: [RFC PATCH 1/2] 9p: retrieve fid from file when file instance
 exist.
Thread-Index: AQHWTPDA0ysky3vK30iFs4N2skTYSKjtkMQAgAADTjA=
Date:   Sun, 28 Jun 2020 06:51:26 +0000
Message-ID: <HE1PR0802MB25556829FCB3A4171E3BDE9DF4910@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200628020608.36512-1-jianyong.wu@arm.com>
 <20200628020608.36512-2-jianyong.wu@arm.com> <20200628062824.GB13335@nautica>
In-Reply-To: <20200628062824.GB13335@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 626c3eae-8639-4272-9e11-ac92210f1d89.1
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3615ca6d-defa-4d63-9463-08d81b2fb34a
x-ms-traffictypediagnostic: HE1PR08MB2924:|AM0PR08MB5476:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5476079466EF41A4C9E03799F4910@AM0PR08MB5476.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0448A97BF2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5waxWEiW0Jsbp1BhEpUSiC9A3dAgouJ7drOi4HgVW+2Hhbot7hi2JUZ8KbAgeySWTO4c5t8WRZFkZ6qi3GTlhYz9tFA4DiZo2TP9c3v3Kz1Olmg8UwhHdnFk/mChhN5EMJZNzWUhmKLonoUfdduVCd/rGimZHfuXcDyQC1TSTP4BXlmF5ONTGWUd/7B2/B5KBQfyFC/yRBf8aAGUcYFjJxfEE/hlz4wMiOh6YfgQ+9EeLAHXVQz4qfcPmvPPcOBPA0z8W5m14kf9Ucr8O11HtABmsSzxSSIU2Ltk+P/2yGMIi00Ehp27y6Bm5sN7UQUeyo5SGjOd1WAUty5jIE5fx5xw0mHZtmW5Ahgb2/dg7xMR8vGXp2G/YTznuKiBt5XS
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(52536014)(53546011)(6506007)(7696005)(478600001)(8676002)(71200400001)(5660300002)(6916009)(2906002)(4326008)(8936002)(26005)(55016002)(66476007)(64756008)(66946007)(186003)(83380400001)(76116006)(66556008)(9686003)(54906003)(316002)(33656002)(66446008)(86362001)(396324004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4STfhXn2cm7lZ8RfS6JpQethdbIbGvwFXZtSSlo2Gf36K+k69Z/gNyDmoTp63vMh7MehOefe/x53d2Zykou+IjbqaW6PWTAmD41Yhil5jIAYuvdY0aJD7hJw1+USMI9Y4AHq7eGbCL0tJ28za/DmeIZM1evKbv2UIBLRdnhsXJjo8fp9qEVBUggUvF+YUy618RLBVAdCaglRVh/R1haJcI9iUhpSJH7cHoxx3k5NmHtLuIyEetxYLxJosIzo9TWiCQgVFAWKQU9KIFT1amH7SSmBFxX26XeTgBVU5Q2PieYRuHTwT1hB7bbjO4DhM0O4FxFI4l4vFPUFPJCRo3qYJRXftY2zIYrisINsyZZEPntKgLzXZwrWbKo4lKMix6hPhDIjIYro3ljzuNbrr5skYTm8b1vjMTd0ITZeYwJ3qYElSX9OwmPCN5hBWGZng8KdG6D3db8Y2TtbC1WUboa9Koi3aClNgqF1D6OSMsxk7XA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2924
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(39850400004)(376002)(46966005)(336012)(54906003)(4326008)(6862004)(52536014)(47076004)(316002)(86362001)(70586007)(82740400003)(70206006)(55016002)(81166007)(26005)(186003)(82310400002)(9686003)(7696005)(53546011)(6506007)(33656002)(8936002)(2906002)(8676002)(356005)(83380400001)(478600001)(5660300002)(396324004);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d6266758-6dd6-4864-5807-08d81b2fae0c
X-Forefront-PRVS: 0448A97BF2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIYlP4o0T5xh9KjANG6GG7WiThXqZNSMxTVL3qHSOZi31Idl7rBWr9bIXvoLQvgLK7IVS7nMq1Tr9IyVuQGKuSmplH5qa+XtwolJVeyxNqSXmjXCGztLRv6sqZDgx6Pz2DSTCqR2JDnDwJMyJwURNC/HeddJSd1QsjNKw++Zj2/BuU67VmH8tuJgx0HCj43x6O1oqZABuuJvR58w2lJVGnk+YKpJAxGyzR1gqXUe03JyBkUoObZP8bgruXZHHR0qxNlAZcdAHUBOVrOqqhtgKT0Ccvwr/qofBX2k40ED+wjI+m32SLaRt6f2G0a5tDRfSd7bjX3NPXz66HB5oWfJh4ocxxWG86zZMyCMJIuXtcSZpluzirx+p0BFRLGMPXl3Zkrn9razFN39U42pPyxCJjJYqG8sQiJAZWZKIvJlsp4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2020 06:51:35.8157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3615ca6d-defa-4d63-9463-08d81b2fb34a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogU3VuZGF5
LCBKdW5lIDI4LCAyMDIwIDI6MjggUE0NCj4gVG86IEppYW55b25nIFd1IDxKaWFueW9uZy5XdUBh
cm0uY29tPg0KPiBDYzogZXJpY3ZoQGdtYWlsLmNvbTsgbHVjaG9AaW9ua292Lm5ldDsgdjlmcy0N
Cj4gZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgU3RldmUNCj4gQ2FwcGVyIDxTdGV2ZS5DYXBwZXJAYXJtLmNvbT47IEthbHkgWGlu
IDxLYWx5LlhpbkBhcm0uY29tPjsgSnVzdGluIEhlDQo+IDxKdXN0aW4uSGVAYXJtLmNvbT47IFdl
aSBDaGVuIDxXZWkuQ2hlbkBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAxLzJd
IDlwOiByZXRyaWV2ZSBmaWQgZnJvbSBmaWxlIHdoZW4gZmlsZSBpbnN0YW5jZQ0KPiBleGlzdC4N
Cj4NCj4gSmlhbnlvbmcgV3Ugd3JvdGUgb24gU3VuLCBKdW4gMjgsIDIwMjA6DQo+ID4gSW4gdGhl
IGN1cnJlbnQgc2V0YXR0ciBpbXBsZW1lbnRhdGlvbiBpbiA5cCwgZmlkIHdpbGwgYWx3YXlzIHJl
dHJpZXZlZA0KPiA+IGZyb20gZGVudHJ5IG5vIG1hdHRlciBmaWxlIGluc3RhbmNlIGV4aXN0IG9y
IG5vdCB3aGVuIHNldGF0dHIuIFRoZXJlDQo+ID4gd2lsbCBiZSBzb21lIGluZm8gcmVsYXRlZCB0
byBvcGVuIGZpbGUgaW5zdGFuY2UgZHJvcHBlZC4gc28gaXQncw0KPiA+IGJldHRlciB0byByZXRy
aWV2ZSBmaWQgZnJvbSBmaWxlIGluc3RhbmNlIGlmIGZpbGUgaW5zdGFuY2UgaXMgcGFzc2VkIHRv
IHNldGF0dHIuDQo+ID4NCj4gPiBmb3IgZXhhbXBsZToNCj4gPiBmZD1vcGVuKCJ0bXAiLCBPX1JE
V1IpOw0KPiA+IGZ0cnVuY2F0ZShmZCwgMTApOw0KPiA+DQo+ID4gdGhlIGZpbGUgY29udGV4dCBy
ZWxhdGVkIHdpdGggZmQgaW5mbyB3aWxsIGxvc3QgYXMgZmlkIHdpbGwgYWx3YXlzIGJlDQo+ID4g
cmV0cmlldmVkIGZyb20gZGVudHJ5LCB0aGVuIHRoZSBiYWNrZW5kIGNhbid0IGdldCB0aGUgaW5m
byBvZiBmaWxlIGNvbnRleHQuDQo+ID4gaXQgaXMgYWdhaW5zdCB0aGUgb3JpZ2luYWwgaW50ZW50
aW9uIG9mIHVzZXIgYW5kIG1heSBsZWFkIHRvIGJ1Zy4NCj4NCj4gSSBhZ3JlZSBvbiBwcmluY2lw
bGUsIHRoaXMgbWFrZXMgbW9yZSBzZW5zZSB0byB1c2UgdGhlIGZpbGUncyBmaWQuDQo+DQpUaGFu
a3MhDQoNCj4gSnVzdCBhIGNvbW1lbnQgYmVsb3csIGJ1dCB3aGlsZSBJJ20gdXAgaW4gY29tbWl0
IG1lc3NhZ2UgSSdsbCBhbHNvIGJlDQo+IGFubm95aW5nIHdpdGggaXQgLS0gcGxlYXNlIHRyeSB0
byBmaXggZ3JhbW1hciBtaXN0YWtlcyBmb3IgbmV4dA0KPiBwYXRjaGVzL3ZlcnNpb24gKG1vc3Rs
eSBtaXNzaW5nIHNvbWUgJ2JlJyBmb3IgZnV0dXJlIHBhc3NpdmUgZm9ybTsgYnV0IEkgZG9uJ3QN
Cj4gdW5kZXJzdGFuZCB3aHkgeW91IHVzZSBmdXR1cmUgYXQgYWxsIGFuZCBzb21lIHBhc3NpdmUg
Zm9ybXMgY291bGQgcHJvYmFibHkNCj4gYmUgbWFkZSBhY3RpdmUgdG8gc2ltcGxpZnkuLi4gQW55
d2F5IHdlJ3JlIG5vdCBoZXJlIHRvIGRpc2N1c3MgRW5nbGlzaA0KPiBncmFtbWFyIGJ1dCB3b3Jk
cyBtaXNzaW5nIG91dCBpcyBzbG9wcHkgYW5kIHRoYXQgZ2l2ZXMgYSBiYWQgaW1wcmVzc2lvbiBm
b3INCj4gbm8gZ29vZCByZWFzb24pDQo+DQpTb3JyeSB0byBteSBwb29yIEVuZ2xpc2ggYW5kIHRo
YW5rcyB0byBwb2ludCBvdXQgdGhlIGdyYW1tYXIgbWlzdGFrZXMsICBJJ2xsIGZpeCBpdC4NCg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3UgPGppYW55b25nLnd1QGFybS5jb20+
DQo+ID4gLS0tDQo+ID4gIGZzLzlwL3Zmc19pbm9kZS5jICAgICAgfCA1ICsrKystDQo+ID4gIGZz
LzlwL3Zmc19pbm9kZV9kb3RsLmMgfCA1ICsrKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzLzlw
L3Zmc19pbm9kZS5jIGIvZnMvOXAvdmZzX2lub2RlLmMgaW5kZXgNCj4gPiBjOTI1NWQzOTk5MTcu
LjAxMDg2OTM4OTUyMyAxMDA2NDQNCj4gPiAtLS0gYS9mcy85cC92ZnNfaW5vZGUuYw0KPiA+ICsr
KyBiL2ZzLzlwL3Zmc19pbm9kZS5jDQo+ID4gQEAgLTExMDAsNyArMTEwMCwxMCBAQCBzdGF0aWMg
aW50IHY5ZnNfdmZzX3NldGF0dHIoc3RydWN0IGRlbnRyeQ0KPiA+ICpkZW50cnksIHN0cnVjdCBp
YXR0ciAqaWF0dHIpDQo+ID4NCj4gPiAgcmV0dmFsID0gLUVQRVJNOw0KPiA+ICB2OXNlcyA9IHY5
ZnNfZGVudHJ5MnY5c2VzKGRlbnRyeSk7DQo+ID4gLWZpZCA9IHY5ZnNfZmlkX2xvb2t1cChkZW50
cnkpOw0KPiA+ICtpZiAoaWF0dHItPmlhX3ZhbGlkICYgQVRUUl9GSUxFKQ0KPiA+ICtmaWQgPSBp
YXR0ci0+aWFfZmlsZS0+cHJpdmF0ZV9kYXRhOw0KPg0KPiBobW0sIG5vcm1hbGx5IHNldGF0dHIg
Y2Fubm90IGhhcHBlbiBvbiBhIGZpbGUgdGhhdCBoYXNuJ3QgYmVlbiBvcGVuZWQgc28NCj4gcHJp
dmF0ZV9kYXRhIHNob3VsZCBhbHdheXMgYmUgc2V0LCBidXQgaXQgZG9lc24ndCBjb3N0IG11Y2gg
dG8gcGxheSBzYWZlIGFuZA0KPiBjaGVjaz8gZS5nLiBzb21ldGhpbmcgbGlrZSB0aGlzIGlzIG1v
cmUgY29uc2VydmF0aXZlOg0KPg0KPiBzdHJ1Y3QgcDlfZmlkICpmaWQgPSBOVUxMOw0KPiAuLi4N
Cj4gaWYgKGlhdHRyLT5pYV92YWxpZCAmIEFUVFJfRklMRSkgew0KPiBmaWQgPSBpYXR0ci0+aWFf
ZmlsZS0+cHJpdmF0ZV9kYXRhOw0KPiBXQVJOX09OKCFmaWQpOw0KPiB9DQo+IGlmICghZmlkKQ0K
PiBmaWQgPSB2OWZzX2ZpZF9sb29rdXAoZGVudHJ5KTsNCj4NCj4NCj4NCj4gV2hhdCBkbyB5b3Ug
dGhpbms/DQo+DQpUaGFua3MsIEkgdGhpbmsgaXQncyBiZXR0ZXIuIEknbGwgdGFrZSBpdC4NCg0K
VGhhbmtzDQpKaWFueW9uZw0KDQo+IC0tDQo+IERvbWluaXF1ZQ0KSU1QT1JUQU5UIE5PVElDRTog
VGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlk
ZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5k
IGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0
IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55
IG1lZGl1bS4gVGhhbmsgeW91Lg0K
