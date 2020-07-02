Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46EC2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ETqQbuKL";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ETqQbuKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGBBKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:10:02 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:47757
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbgGBBKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dR/fhaqAoXhenNWVILOb4UyWSfPVI67ngOSy5pNQs4=;
 b=ETqQbuKLhFBe+bN+2mq/f39VwM6LpZzYZ8DpwfHtEeMdHtAtm50UuSdn/Mu1LQXOP6x4wZMpkmTgw07UEMkdZ9C11OVquYbF9TH8b/qVYcgFVS8pFCNs/v0pzI8vmkMlY8Rla0/qBTDMavlGE4VMnTGMueKU2G/zZPTy2jyB1r4=
Received: from AM6P192CA0051.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::28)
 by AM6PR08MB3895.eurprd08.prod.outlook.com (2603:10a6:20b:81::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 01:09:57 +0000
Received: from AM5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::da) by AM6P192CA0051.outlook.office365.com
 (2603:10a6:209:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Thu, 2 Jul 2020 01:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT024.mail.protection.outlook.com (10.152.16.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 2 Jul 2020 01:09:56 +0000
Received: ("Tessian outbound 114f46c34313:v62"); Thu, 02 Jul 2020 01:09:56 +0000
X-CR-MTA-TID: 64aa7808
Received: from e36ba1de4db3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3A4618FB-DC20-4D38-A893-22E04BA5E67D.1;
        Thu, 02 Jul 2020 01:09:51 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e36ba1de4db3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Jul 2020 01:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W72mm/18p7qmCrUFdM3eiVbgfF6Jo0cEt329i6gq6/15BqMM4N1GaeZsUhIJZ8PJ/mhE0sFDOT4fT0phbp9eHvu4A8ZpakFF94CG6eyZymBfVY7nbFRjF0fkrJxVOJFyJbFqyenJWiSZbGO4C+sb1ho5Fz3AJ1ERW3nVl4hme5bQ/zzBcZnpFjXNsVEx0zSsRJ0trumF4xgQJOgxeVZHj4WMpW0z7EBNZ/rolh06caCWdpav3HLAnz73Sr6bVDSrQQgmAi65v37iqfhtj2wpJLn2LE4lC7AlKbNpG62jYB7SGFxoHEZ/54OmsBjdXvKvRuWGmx7CuiPpZY9OPHvRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dR/fhaqAoXhenNWVILOb4UyWSfPVI67ngOSy5pNQs4=;
 b=CqsWbG9avDQlQlBt0ias0DN/2vB2Yz38aj60LK06L7WOfZYeiqaM1J/EuzP7xORTmTqhSc39kcJ5qR450UpuxkBEV9OsxjCrxzi5HC3SuOV0T6MY945JTzRfNF9iQ6ev0iaBNtbx2I01TinGsl0zTvvTHQt7qE1tZrR8iRh5jCTKsrCGgOZHXIkgQEUx3az5sQSI2yFmVsdEI37Uk8SByvvc7SHk+oMvQBxQoGfSXIxeJMKXRyfrpbj2awOSRhU0BZ9vhINspW2/B2ueXNbRC2ei5pwt/sQniX8X+bhX+vNZYqi2BXN/fGyILcVMI1Xk7K+meJ81F4VHMkJqiizlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dR/fhaqAoXhenNWVILOb4UyWSfPVI67ngOSy5pNQs4=;
 b=ETqQbuKLhFBe+bN+2mq/f39VwM6LpZzYZ8DpwfHtEeMdHtAtm50UuSdn/Mu1LQXOP6x4wZMpkmTgw07UEMkdZ9C11OVquYbF9TH8b/qVYcgFVS8pFCNs/v0pzI8vmkMlY8Rla0/qBTDMavlGE4VMnTGMueKU2G/zZPTy2jyB1r4=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0802MB2250.eurprd08.prod.outlook.com (2603:10a6:3:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 2 Jul
 2020 01:09:50 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 01:09:49 +0000
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
Subject: RE: [PATCH v2] 9p: retrieve fid from file when file instance exist.
Thread-Topic: [PATCH v2] 9p: retrieve fid from file when file instance exist.
Thread-Index: AQHWT1C8uFH8AvHCck+eqX9WRLxleKjyjr6AgADqeMA=
Date:   Thu, 2 Jul 2020 01:09:49 +0000
Message-ID: <HE1PR0802MB25552E53839BA81FB26210ABF46D0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200701023821.5387-1-jianyong.wu@arm.com>
 <20200701105927.GA20762@nautica>
In-Reply-To: <20200701105927.GA20762@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 9d9ee054-48a3-4fa6-a559-067cf0ac8ec3.1
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 191b1433-3452-4b01-737c-08d81e24a2a5
x-ms-traffictypediagnostic: HE1PR0802MB2250:|AM6PR08MB3895:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3895EC25B3305F762F36AA50F46D0@AM6PR08MB3895.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mtnned0HZ84I2WSp/hFMECvKybAs181ravd7jn0Ok3r674UtIYPZa/jOPCE+3qHQiC7ON7ec1K3YFQHBE0OrCttnygCDmvmMMtAbRx8jaU+Q0ycvOkRbPS439mWMPieJl3woG9FsyH0jO1cl4f+t7XSqHtmuaq3PYgTqxk9MwW9iuLXqUU4a+AYC7QWgYhS6jSwkTUxAGEnpikDdy+GWozcWuPyje2H267qxM13LazifdrpTq9XFdBGaeiSx8hkllen0nU3H2RVYg1xUM26bPb+zqXotPwzVkWrgumAD/lhTwFCmN3LzBkx4iXmp0Zo3a9ARdqWDAUXQdWaF5tNbYA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(66946007)(52536014)(316002)(54906003)(55016002)(53546011)(33656002)(83380400001)(186003)(5660300002)(26005)(6506007)(66446008)(7696005)(76116006)(86362001)(71200400001)(6916009)(64756008)(66556008)(66476007)(8936002)(4326008)(2906002)(9686003)(8676002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7bJtbo2OS9XgpP3xZNCn+6LL+7ao1Tir0uOoQ6S5GBdqHBzm+oKXjXjipcwqfmKDAGUyVkauI+d4nnzOxrEZlt9m9/apxVMVI5PULhPgDDCbudSy83ZX56L18oi+iFQWMAHEFMxgqHSbZagQZds3C7OGjGmrI2xKWQgYFBi7+wNcI97tjt4Mi2WumRaRbZpBmaDTmRieEuqCanGQQJFCK6yLHSDPV37cg9gjm1j33ND/FWuG8arYm8tz5lyOrTVPnF3eIflDOwku+ITfxtXG/OE9KZrqaXrP2I/IaD4JfijAMVtUz7wT20Kdx0xdgD3p3CX1Z3j9dp7dbNXgWHj7iXkRwace7ZYfLqc9z9OGB2k0LLKqN0F+boCzKDZ7BeaP8CzNljkMeGdCRrgdUbK4PbAUKWEDsQ3UEnzBW+aS13eHAQhKZVlwlU4OfdSHqBmW3izDMJn01zxiBWchkBTZ4GkA6zmpYJ2P85dJAVOsjuU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2250
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966005)(53546011)(2906002)(82310400002)(5660300002)(55016002)(8676002)(356005)(6862004)(9686003)(47076004)(82740400003)(6506007)(81166007)(7696005)(54906003)(336012)(52536014)(26005)(33656002)(83380400001)(4326008)(36906005)(70586007)(70206006)(8936002)(316002)(186003)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 664c5c5c-515f-4332-284b-08d81e249e7c
X-Forefront-PRVS: 0452022BE1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbUe+7ztxRev37o4+hjGslr51uRtfXOGJHB+s9ORAJAOyCP+chj69R86fYwgppnPf6OKYIGHQpOGCuT4vUEjKe9ozHGtO1RaDU4TJZ8qZrfn3wbO6grPy5HhQMr3wcBbwhOOt40WO0z/J0+w7pX3G2Ec2x0YeR7WUR3ueWTrwe8/Vizg3rsnBu/HJ78pGfMbIx0sQQlTXPsZDd3/CVt/BOh7WCMOwmdOTxS5l6yp0dG/ajzuF7tT8uS9hmVKDx3iD5MsqlMF52hpTV+y7Fir9LY9QGkCRgNA9FS1NdCFNPtpwT8U5wxZeVANSXUUWicZahbwlwBoFK3QITeykspBB2xJ5+1AUvjUQImjIZeaOSwuZTqjavkKUktEA3eTSYeTo6AWhBErklwqEcyeTeDjBw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 01:09:56.8624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191b1433-3452-4b01-737c-08d81e24a2a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdWx5IDEsIDIwMjAgNjo1OSBQTQ0KPiBUbzogSmlhbnlvbmcgV3UgPEppYW55b25nLld1
QGFybS5jb20+DQo+IENjOiBlcmljdmhAZ21haWwuY29tOyBsdWNob0Bpb25rb3YubmV0OyB2OWZz
LQ0KPiBkZXZlbG9wZXJAbGlzdHMuc291cmNlZm9yZ2UubmV0OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBTdGV2ZQ0KPiBDYXBwZXIgPFN0ZXZlLkNhcHBlckBhcm0uY29tPjsgS2FseSBY
aW4gPEthbHkuWGluQGFybS5jb20+OyBKdXN0aW4gSGUNCj4gPEp1c3Rpbi5IZUBhcm0uY29tPjsg
V2VpIENoZW4gPFdlaS5DaGVuQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIDlw
OiByZXRyaWV2ZSBmaWQgZnJvbSBmaWxlIHdoZW4gZmlsZSBpbnN0YW5jZSBleGlzdC4NCj4NCj4g
SmlhbnlvbmcgV3Ugd3JvdGUgb24gV2VkLCBKdWwgMDEsIDIwMjA6DQo+ID4gSW4gdGhlIGN1cnJl
bnQgc2V0YXR0ciBpbXBsZW1lbnRhdGlvbiBpbiA5cCwgZmlkIGlzIGFsd2F5cyByZXRyaWV2ZWQN
Cj4gPiBmcm9tIGRlbnRyeSBubyBtYXR0ZXIgZmlsZSBpbnN0YW5jZSBleGlzdHMgb3Igbm90LiBU
aGVyZSBtYXkgYmUgc29tZQ0KPiA+IGluZm8gcmVsYXRlZCB0byBvcGVuZWQgZmlsZSBpbnN0YW5j
ZSBkcm9wcGVkLiBzbyBpdCdzIGJldHRlciB0bw0KPiA+IHJldHJpZXZlIGZpZCBmcm9tIGZpbGUg
aW5zdGFuY2UgaWYgZmlsZSBpbnN0YW5jZSBpcyBwYXNzZWQgdG8gc2V0YXR0ci4NCj4gPg0KPiA+
IGZvciBleGFtcGxlOg0KPiA+IGZkPW9wZW4oInRtcCIsIE9fUkRXUik7DQo+ID4gZnRydW5jYXRl
KGZkLCAxMCk7DQo+ID4NCj4gPiBUaGUgZmlsZSBjb250ZXh0IHJlbGF0ZWQgd2l0aCBmZCB3aWxs
IGJlIGxvc3QgYXMgZmlkIGlzIGFsd2F5cw0KPiA+IHJldHJpZXZlZCBmcm9tIGRlbnRyeSwgdGhl
biB0aGUgYmFja2VuZCBjYW4ndCBnZXQgdGhlIGluZm8gb2YgZmlsZQ0KPiA+IGNvbnRleHQuIEl0
IGlzIGFnYWluc3QgdGhlIG9yaWdpbmFsIGludGVudGlvbiBvZiB1c2VyIGFuZCBtYXkgbGVhZCB0
bw0KPiA+IGJ1Zy4NCj4NCj4gVGhhbmtzIGZvciB0aGUgY29tbWl0IG1lc3NhZ2UgLSBzdGlsbCBm
ZWVscyBhIGJpdCBvZGQgYnV0IGF0IGxlYXN0IGNvcnJlY3QNCj4gZW5vdWdoIGZvciBtZSA6KQ0K
Pg0KVGhhbmtzLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3UgPGppYW55b25nLnd1
QGFybS5jb20+DQo+ID4gLS0tDQo+ID4gIGZzLzlwL3Zmc19pbm9kZS5jICAgICAgfCA2ICsrKysr
LQ0KPiA+ICBmcy85cC92ZnNfaW5vZGVfZG90bC5jIHwgNiArKysrKy0NCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2ZzLzlwL3Zmc19pbm9kZS5jIGIvZnMvOXAvdmZzX2lub2RlLmMgaW5kZXgNCj4gPiBj
OTI1NWQzOTk5MTcuLmIzMzU3NGQzNDdmYSAxMDA2NDQNCj4gPiAtLS0gYS9mcy85cC92ZnNfaW5v
ZGUuYw0KPiA+ICsrKyBiL2ZzLzlwL3Zmc19pbm9kZS5jDQo+ID4gQEAgLTExMDAsNyArMTEwMCwx
MSBAQCBzdGF0aWMgaW50IHY5ZnNfdmZzX3NldGF0dHIoc3RydWN0IGRlbnRyeQ0KPiA+ICpkZW50
cnksIHN0cnVjdCBpYXR0ciAqaWF0dHIpDQo+ID4NCj4gPiAgcmV0dmFsID0gLUVQRVJNOw0KPiA+
ICB2OXNlcyA9IHY5ZnNfZGVudHJ5MnY5c2VzKGRlbnRyeSk7DQo+ID4gLWZpZCA9IHY5ZnNfZmlk
X2xvb2t1cChkZW50cnkpOw0KPiA+ICtpZiAoaWF0dHItPmlhX3ZhbGlkICYgQVRUUl9GSUxFKSB7
DQo+ID4gK2ZpZCA9IGlhdHRyLT5pYV9maWxlLT5wcml2YXRlX2RhdGE7DQo+ID4gK1dBUk5fT04o
IWZpZCk7DQo+DQo+IFRoYXQgd291bGQgY3Jhc2ggaW4gOXBfY2xpZW50X3dzdGF0IGEgZmV3IGxp
bmVzIGJlbG93IHdpdGggdGhlIGN1cnJlbnQgZWxzZSA7DQo+IHNvIEknbSBub3Qgc3VyZSBXQVJO
X09OIGlzIGFwcHJvcHJpYXRlIHdpdGggdGhpcyBjb2RlLg0KPg0KPiB0aGUgc25pcHBldCBJIGhh
ZCBzdWdnZXN0ZWQgaGFkIHY5ZnNfZmlkX2xvb2t1cCBpbiBhIGRpZmZlcmVudCBpZiwgbm90IGFz
IGEgZWxzZQ0KPiBzdGF0ZW1lbnQgdG8gYXZvaWQgdGhpcyBjcmFzaCAoYW5kIHRoZW4gd2Fybmlu
ZyBpcyBPSykNCj4NClllYWgsIHNob3VsZCBjaGVjayBmaWQgYmVmb3JlICJ2OWZzX2ZpZF9sb29r
dXAiLCBob3cgYWJvdXQNCg0KaWYgKGlhdHRyLT5pYV92YWxpZCAmIEFUVFJfRklMRSkgew0KICAg
ICAgICAgICAgICAgIGZpZCA9IGlhdHRyLT5pYV9maWxlLT5wcml2YXRlX2RhdGE7DQogICAgICAg
ICAgICAgICAgV0FSTl9PTighZmlkKTsNCiB9DQpJZiAoIWZpZCkNCmZpZCA9IHY5ZnNfZmlkX2xv
b2t1cChkZW50cnkpOw0KLi4uDQoNClRoYW5rcw0KSmlhbnlvbmcNCg0KPiA+ICt9IGVsc2UNCj4g
PiArZmlkID0gdjlmc19maWRfbG9va3VwKGRlbnRyeSk7DQo+DQo+IC0tDQo+IERvbWluaXF1ZQ0K
SU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5
b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90
aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUg
aW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
