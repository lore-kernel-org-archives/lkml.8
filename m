Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ACCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D1C206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tFoFBUxr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tFoFBUxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390110AbgE1NFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:05:48 -0400
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:6030
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390060AbgE1NFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzOy10LSwpzEObZrYv8zN0nDKkJ/N3TvrAl0SuzWi8A=;
 b=tFoFBUxr1+JpDbaHTpiuBDwSzI+mS6bijoIvjtir8YCUGv8OSsFmddtwmh18ttPiJd53/yOotS6SjbUEL/lr0weyAIyfFSLr86J3T65O1EgTKZPAZlcso35w3evKHMHucTtWMO0WMb8zlNmQaQZp7x5Nk6pYdZ8ypG0Yj3J4qPA=
Received: from DB6P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::28) by
 DB6PR0802MB2389.eurprd08.prod.outlook.com (2603:10a6:4:9e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Thu, 28 May 2020 13:05:27 +0000
Received: from DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:cb:cafe::be) by DB6P195CA0018.outlook.office365.com
 (2603:10a6:4:cb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Thu, 28 May 2020 13:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT024.mail.protection.outlook.com (10.152.20.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 28 May 2020 13:05:26 +0000
Received: ("Tessian outbound b157666c5529:v57"); Thu, 28 May 2020 13:05:26 +0000
X-CR-MTA-TID: 64aa7808
Received: from f0ddba7d02b2.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8AA18E8B-1BBC-4F74-94D1-D87936637E75.1;
        Thu, 28 May 2020 13:05:21 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f0ddba7d02b2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 28 May 2020 13:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4YHDkSBKTYRAcqe7zQiXye2g+jxgNlZkzN8hRIDVH+sLaSeLpsAd892yhziZTY4/UGX01WYrqoNMQBwjOKaf1WQ3ZMi67x5gG/hkeZZoaUsX6ynEUUPLfkr5BlE/IIqhAGQk1jF6Z5Aw4nw66MwU/pmCtiYCo22AasT01lL1cA93gXBvi1X7SuWWAUmIxfqEkjqOp8UezVHYXngYAQDkP4+L4IC1KNXrD43QdNeKOJQb2HoAreyMvlUtms5Arp8vbPjZSNRUZFI1X5J3yCuUqMIdgboXhr42GyvoO3jdAW+oOXOWzqonQx6SEtspRc2K2kInIxBeuUNTwE2Ej1Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzOy10LSwpzEObZrYv8zN0nDKkJ/N3TvrAl0SuzWi8A=;
 b=j7/+JQ/pcTVCciip/Jp8E4KhS8hjIxNQ8YrvQGRvfsDTVWqaxBtAgSBbX43lnEWqjCB84/U/FOfqlVWPuFOb4uHpyP1Yq5Dv0SGGDLeR5LQsqURYnwn5Xr5RyJzxVjvpbNYe1Q2PhLBwWrDdpSzG3PmAMmwLMDyjW54R+gpymh0vu+PM8qPfuO6zBi21u3pTR0e8ulFH56PY9wIBu9/zjydMi+sEthT7HwciM88sCqXahzKGLthCf2gyWEFIdWhYBntyDVchoQLWHbn5jPfr1k3eCqKiF9bY5inqNselzbrwC8Lk5VxWGhkeE+MZnzTMiq/scsDE7/gu38vgisSVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzOy10LSwpzEObZrYv8zN0nDKkJ/N3TvrAl0SuzWi8A=;
 b=tFoFBUxr1+JpDbaHTpiuBDwSzI+mS6bijoIvjtir8YCUGv8OSsFmddtwmh18ttPiJd53/yOotS6SjbUEL/lr0weyAIyfFSLr86J3T65O1EgTKZPAZlcso35w3evKHMHucTtWMO0WMb8zlNmQaQZp7x5Nk6pYdZ8ypG0Yj3J4qPA=
Received: from AM6PR08MB4311.eurprd08.prod.outlook.com (2603:10a6:20b:b4::12)
 by AM6PR08MB4072.eurprd08.prod.outlook.com (2603:10a6:20b:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 13:05:16 +0000
Received: from AM6PR08MB4311.eurprd08.prod.outlook.com
 ([fe80::bdc9:c971:a9e0:647b]) by AM6PR08MB4311.eurprd08.prod.outlook.com
 ([fe80::bdc9:c971:a9e0:647b%2]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 13:05:16 +0000
From:   Jose Marinho <Jose.Marinho@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Harb Abdulhamid (harb@amperecomputing.com)" 
        <harb@amperecomputing.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francois Ozog <francois.ozog@linaro.org>, nd <nd@arm.com>
Subject: RE: [PATCH 2/2] firmware: smccc: Add ARCH_SOC_ID support
Thread-Topic: [PATCH 2/2] firmware: smccc: Add ARCH_SOC_ID support
Thread-Index: AQHWMFmt9AGTrbTq2UeBYD1povy8MKi0cKaAgAF9e4CAACUkgIAHVVvA
Date:   Thu, 28 May 2020 13:05:16 +0000
Message-ID: <AM6PR08MB4311A937BE505BAE0CDF9106888E0@AM6PR08MB4311.eurprd08.prod.outlook.com>
References: <20200522124951.35776-1-sudeep.holla@arm.com>
 <20200522124951.35776-3-sudeep.holla@arm.com>
 <CAK8P3a1t6BrB_Gti138VDRbmaiR_TjwR9d6qMstLBFDWxZ1kjQ@mail.gmail.com>
 <20200522165422.GA18810@bogus>
 <CAK8P3a33_5q1bNRrt+4sQ55QKrN12rOkuzmPH0BDujbug1RTyA@mail.gmail.com>
 <20200523172721.GC18810@bogus>
 <CAK8P3a1+jjgOyJcRQm60RULjwtvWzvYK1QwrjOX_aRAbDGKuJg@mail.gmail.com>
In-Reply-To: <CAK8P3a1+jjgOyJcRQm60RULjwtvWzvYK1QwrjOX_aRAbDGKuJg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 19f4f50a-ca78-4fd4-a169-a7db6f88b5af.1
x-checkrecipientchecked: true
Authentication-Results-Original: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=arm.com;
x-originating-ip: [2a02:c7f:1edb:a800:1c4d:8700:d19e:860d]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee10e3dd-9c46-4f11-54fe-08d80307ca7b
x-ms-traffictypediagnostic: AM6PR08MB4072:|DB6PR0802MB2389:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB238906417183C508FB5764A2888E0@DB6PR0802MB2389.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tsf0s6CTZ0qAI6tcnURE5ppVyvtXlq5qZ2uTV7ugTECpnPGBPXTLdoBUh4r9vZd7476htZY2GTO620D2Mlc737Su8FnV5RBIpLGPQ4yrU0o1X+RskZ+yV727MCHBBUphXOYzstOt9QLjqGTbooNtC8sHjnkixWw9yyjruFREBr1wtGa6lJwYDgIQcih7IeD1VA3lHJvoJK0j2fVTxjVipsqVvLiWYsh/UT05UymVd1Kj6H+fka1LMTiF+ZKlEcH9EB9mg+D6F7coLwrOGsBPq3hHt7jn1oH0m5eKf9R9DfARhWKReFIFsducYowb2mQfGmQyWrNw5HJno9lqoUfBvA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4311.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(7696005)(66446008)(5660300002)(52536014)(66946007)(76116006)(64756008)(4326008)(8676002)(316002)(110136005)(8936002)(54906003)(66476007)(53546011)(71200400001)(33656002)(6506007)(86362001)(55016002)(9686003)(66556008)(478600001)(6636002)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /I2PhM4SGLIpI0I1rtPAk56kn4v6F+OGAWghRJyX5KXzxnoZj/Ey7pjG4z6/jmj2pFPc2kiMH37dyQfr6o9CbNTZcH8EFLBf3B1UNjR5C8krdA/KTHwhrS2GaiwUA65V50JU6sPTmgIkbmN/A4mtt8FECTw6vvKnD0SSn9enDdW0cdueN7w985d1Fo/LFrrKSNeG50kKHz9/+b0W981pXBSL+4FP7Q0mURJwIkGjzBgbmrxX12Kr9PkTfvDVqjQfedHz2Sw4qWTzAEhLJlly2rYz1LgyozOR2CmnIwD/pXm8lCP+HeuvIfFOqV4DMxdk2FJ6PBDbCnC6F20XM8ilKmewbEVAnLIUn1/Q4T4Ej32ZETEPRKB27BVDuhcpgl0I8cwpUAKf3yNIefRD2Fe3Kd0YB1MiqA0pJ+sW+Pb/1sq0UrqX4gbQkvj1abwGUHy6NTZ9zs22tZKlyrobpF1pJcHWAuoPkpCh377WZBa5pfx741waAIfiq65Z6qTpOLDf5jUjldG1kN5gd/njx66Cb1uEhpmKH6E+7qhircKuj9L0hr7dWzTiN+Rq4/u5Jpi4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4072
Original-Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(86362001)(4326008)(356005)(336012)(81166007)(53546011)(47076004)(6506007)(7696005)(82740400003)(54906003)(478600001)(33656002)(316002)(110136005)(26005)(186003)(9686003)(2906002)(55016002)(82310400002)(8676002)(52536014)(8936002)(70586007)(6636002)(70206006)(5660300002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e7dd1098-e493-4d1b-dda2-08d80307c458
X-Forefront-PRVS: 0417A3FFD2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdX+cI62KdUtJqnvAooPglRNd98Vx0b6tysCDFhPGD5sRkn0ZXDlZR8TjIxeEQQiWyHnRFepqrl/xeD6bOleDonx/CHZhT/VQWiYglYvIKiFqVrh3SpO2xt8u95ysgOet6j6kQ/W1vQ79CNXDnjhD6IIJd5P36LA2gppqp5MshIg/zgcxx2x62QjjYBxJ2CXZVXz6ZhbsxMJ4Zwukve7/hQS+ix8C9uMJl+q+C4EOzQBHt4ZFp+yJIEE/citNkkpxJcPNdh1z0BRncdqYbpkvFF0MOaD1CJsfXZhn9pr0Ao/yrtwKS8v5HPyltp/Loup/L/nyiTRQST+kqLzJWp1uLHKjejFVGADdgB77She8TrcTKMKWPFiqloo6S0EMySs6H22sIRpACaU8evzBtdKRw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:05:26.9589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee10e3dd-9c46-4f11-54fe-08d80307ca7b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFNhdCwgTWF5IDIzLCAyMDIwIGF0IDc6MjcgUE0gU3VkZWVwIEhvbGxhIDxzdWRlZXAu
aG9sbGFAYXJtLmNvbT4NCj4gd3JvdGU6DQo+ID4gT24gRnJpLCBNYXkgMjIsIDIwMjAgYXQgMDg6
NDE6NTlQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgTWF5IDIy
LCAyMDIwIGF0IDY6NTQgUE0gU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiA+IGplcDEwNjo1Njc4ICh0aGUgSU1QX0RFRl9TT0NfSUQgZmllbGQg
aW4gbXkgZXhhbXBsZSkgd291bGQgcHJvYmFibHkNCj4gPiA+IGJlIHN1ZmZpY2llbnQgdG8gbm90
IGNvbmZsaWN0IHdpdGggYSBhbm90aGVyIHNvY19kZXZpY2UgZHJpdmVyLCBidXQNCj4gPiA+IGlz
IHF1aXRlIGxpa2VseSB0byBjbGFzaCB3aXRoIGFuIElEIHVzZWQgYnkgYW5vdGhlciBtYW51ZmFj
dHVyZXIuDQo+ID4gPg0KPiA+DQo+ID4gSUlVQywgeW91IGFyZSBmaW5lIHdpdGggImplcDEwNjox
MjM0OjU2NzgiIHdoZXJlIDEyMzQgaXMgamVwMTA2DQo+IG1hbnVmYWN0dXJlDQo+ID4gaWQgY29k
ZSBhbmQgNTY3OCBpcyBzb2NfaWQgYXMgaXQgbWF5IGF2b2lkIGFsbCB0aGUgY29uZmxpY3RzIGFj
cm9zcw0KPiA+IHRoZSBtYW51ZmFjdHVyZSBuYW1lc3BhY2VzLg0KPiANCj4gSSB0aGluayBlaXRo
ZXIgamVwMTA2OjU2Nzggb3IgamVwMTA2OjEyMzQ6NTY3OCAob3Igc29tZSB2YXJpYXRpb24gd2l0
aA0KPiBkaWZmZXJlbnQgZmllbGQgc2VwYXJhdG9ycyBpZiB5b3UgcHJlZmVyKSB3b3VsZCBiZSBm
aW5lIGhlcmUuDQo+IA0KPiA+ID4gamVwMTA2OjEyMzQgKHRoZSBtYW51ZmFjdHVyZXIgSUQpIGlu
IHR1cm4gc2VlbXMgdG9vIGJyb2FkIGZyb20NCj4gPiA+IHRoZSBzb2NfaWQgZmllbGQsIGFzIHRo
YXQgd291bGQgaW5jbHVkZSBldmVyeSBjaGlwIG1hZGUgYnkgb25lDQo+ID4gPiBjb21wYW55Lg0K
PiA+ID4NCj4gPg0KPiA+IEkgdW5kZXJzdGFuZCwgYW5kIElJVUMgeW91IHByZWZlciB0aGlzIHRv
IGJlIGVtYmVkZGVkIHdpdGggc29jX2lkDQo+ID4gZXNwZWNpYWxseSB0byBhdm9pZCBuYW1lc3Bh
Y2UgY29uZmxpY3RzIHdoaWNoIG1ha2VzIHNlbnNlLg0KPiA+DQo+ID4gVGhhbmtzIGZvciBhbGwg
dGhlIGRpc2N1c3Npb24gYW5kIHZhbHVhYmxlIGlucHV0cy4gSSBhbSBub3cgYml0IG5lcnZvdXMN
Cj4gPiB0byBhZGQgU29DIGluZm8gZnJvbSBTTUNDQyBBUkNIX1NPQ19JRCB0byBzeXNmcyB5ZXQg
YXMgd2UgbmVlZCBtb3JlDQo+IGluZm8NCj4gPiBlc3BlY2lhbGx5ICJtYWNoaW5lIiBhbmQgInNl
cmlhbF9udW1iZXIiIGZvciBlbHNld2hlcmUoT0VNIGZpcm13YXJlDQo+IG1vc3RseQ0KPiA+IGZy
b20gRFQgb3IgQUNQSSkuDQo+IA0KPiBJIHByb2JhYmx5IHdvdWxkbid0IG1peCB0aG9zZSBpbiB3
aXRoIHRoZSBzYW1lIGRyaXZlci4gSWYgbWFjaGluZSBhbmQNCj4gc2VyaWFsX251bWJlciBoYXZl
IG5vIHNtY2NjIGludGVyZmFjZSwgdGhlbiB0aGV5IHNob3VsZCBiZSBsZWZ0IG91dCwNCj4gYnV0
IHRoZXJlIGNvdWxkIGJlIGEgc2VwYXJhdGUgc29jX2RldmljZSB0aGF0IGdldHMgdGhhdCBpbmZv
cm1hdGlvbg0KPiBieSBvdGhlciBtZWFucywgdXN1YWxseSB1c2luZyBvbmUgb2YgdGhlIGV4aXN0
aW5nIGhhcmR3YXJlIGlkIHJlZ2lzdGVyDQo+IGRyaXZlcnMuDQo+IA0KPiA+IFRCSCwgdGhlIG1p
eCBtaWdodCBiZSBiaXQgb2YgYSBtZXNzIGFzIHRoZXJlIGFyZSBzb2MgZHJpdmVycyB0aGF0IHJl
bHkNCj4gPiBvbiBEVCBjb21wbGV0ZWx5IHRvZGF5LiBBbnl3YXlzLCB0aGlzIFNPQ19JRCBjYW4g
YmUgYWRkZWQgYXMgbGlicmFyeSB0aGF0DQo+ID4gY2FuIGJlIHVzZWQgYnkgYSAqZ2VuZXJpYyog
c29jIGRyaXZlciBvbmNlIHdlIGRlZmluZSBhIHN0YW5kYXJkIHdheSB0bw0KPiA+IGZldGNoIG90
aGVyIGluZm9ybWF0aW9uKCJtYWNoaW5lIiBhbmQgInNlcmlhbF9udW1iZXIiKS4gSSBhbSBoYXBw
eSB0bw0KPiA+IGdldCBzdWdnZXN0aW9ucyBvbiB0aGF0IGZyb250IGVzcGVjaWFsbHkgZnJvbSB5
b3UgYW5kIEZyYW5jb2lzIGFzIHlvdQ0KPiA+IGhhdmUgZ290IHNvbWUgY29udGV4dCBhbHJlYWR5
Lg0KPiANCj4gV2VsbCwgSSBzdXBwb3NlIHdlIGNvdWxkIGhhdmUgdGhlIGVudGlyZSBkYXRhIGZy
b20gdGhlIHNtY2NjIGludGVyZmFjZQ0KPiBpbiBhIGNlbnRyYWwgcGxhY2Ugc29tZXdoZXJlLCBz
dWNoIGFzICh0byBzdGF5IHdpdGggbXkgZXhhbXBsZSkNCj4gIjEyMzQ6NTY3ODo5YWJjZGVmMCIg
aW4gYW4gYXR0cmlidXRlIG9mIGFueSBzb2NfZGV2aWNlIGRyaXZlciB0aGF0DQo+IGFkZHMgYSBj
YWxsIHRvIGEgbGlicmFyeSBmdW5jdGlvbiBmb3IgdGhlIGplcDEwNiBJRCwgb3IgcG9zc2libHkg
aW4NCj4gL3N5cy9maXJtd2FyZSBvciBldmVuIGEgZmllbGQgYWRkZWQgdG8gL3Byb2MvY3B1aW5m
by4NCg0KSSB0aGluayB0aGlzIGlzIGEgZ3JlYXQgd2F5IHRvIGV4cG9zZSB0aGUgU29DIElEIGlu
Zm8uIEl0J3MgaW1wb3J0YW50IHRvIGhhdmUgdGhlIFNvQyBJRCBhcyBhIHdob2xlIGluIGEgc3lz
ZnMgKG9yIHNvbWV3aGVyZSB3aGVyZSBpdCdzIGVhc3kgdG8gb2J0YWluIGFuZCBwYXJzZSBmcm9t
IHVzZXItc3BhY2UpLg0KVGhlIGluZm9ybWF0aW9uIHByb3ZpZGVkIGJ5IFNvQyBJRCBzaG91bGQg
YmUgbGlzdGVkIGluIHRoaXMgZm9ybSBqZXAxMDY6MTIzNDo1Njc4LCB0aGF0IGlzIGplcDEwNjo8
bWFudWZhY3R1cmVyIElEPjo8U29DIElEPiAuDQoNClJlZ2FyZHMsDQoNCkpvc2UNCg==
