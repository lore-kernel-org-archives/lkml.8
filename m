Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7902084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WXhXoS0b";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WXhXoS0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGBJyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:54:54 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:39910
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgGBJyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApjUig0fzXuSfOTe/Py5sjuEq3+npILdfic0JE3DI8s=;
 b=WXhXoS0bKl766OEyI/mjBaqem6Lw6tYXYnKEdq/dPDWlgGapORgdMbiLL6aCv3EXu8pMjyCFeUwsch3SHUKfJDUq3DMRg8N09WtAOioJMUCyV6PMilfOTdfd6RvyZxn9T1/anfzLvrxdSpOLwNFOQrK20jkMTaLbLC8nvh87uDY=
Received: from AM6P193CA0086.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::27)
 by DB8PR08MB5081.eurprd08.prod.outlook.com (2603:10a6:10:e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 09:54:49 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::8e) by AM6P193CA0086.outlook.office365.com
 (2603:10a6:209:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Thu, 2 Jul 2020 09:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 09:54:48 +0000
Received: ("Tessian outbound 2dd9eeca983c:v62"); Thu, 02 Jul 2020 09:54:48 +0000
X-CR-MTA-TID: 64aa7808
Received: from 0654fbda37fc.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7DE0C5B9-F757-4344-BB9B-DE37D3EF9287.1;
        Thu, 02 Jul 2020 09:54:43 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0654fbda37fc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Jul 2020 09:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATy2aqBmAk47YNQUQKvl/WU3m1dUwkdj+0YA7gCz6UaQaUAK20LCJrL7qx/+Z3LwUW41jDmvrfq9VkLKLp0ey6r4yBB0Ox/ivZzDH+BNQYD9TBwZTgQ3nKg/W5UUlHWDQxNYEVcN0sZ12l0FHLiVinGe02I9rBT7lOxRVUMs/nYmwj2yaYzip/8XvBWp1UWdgvzbyI4vmPZ4xPuDZG//w/silCw5debzFEjAQlq39n0Kcwo/LzLhuuUOzO5URMB6E0sx63Kc1bgKYCLaAdzPHXMWl2416GDQSTP3hhBd2sBRDmDAFVQF+3pe3X4/9vESFLcH8qsjvO3yLyucpf8iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApjUig0fzXuSfOTe/Py5sjuEq3+npILdfic0JE3DI8s=;
 b=iFjNLe/l+98RjSqhYcfSJAsJEQ1rLld8agUXv1lU5YM1kgjB/98OohmOtvVjdlvu/7TQjr50PmqkTAlR4rccsAqNX8X+QY9BBGDmQCDIwO7M2oIFQ6eq+/YKfMRGmEyQXsqxdExF8d6nRB0pPqMFVIpEhIIj9NWP4YFJFom3vIt6tjkRxce609R+vQBiAgc5u3sHDbwOF1fPkYi/++sOSUoi07IiYJ4LdlKqYHRLG9UZK7gGj6Fbbsr/pWGl9EGtmRXpQhZTyy5kmCu6Yh72s7CMedaYyx1dRfEVdKndp7NIRpJ0T1fz6UpnUSzecaC2G0QgzdPO8F9OmSRbVHJVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApjUig0fzXuSfOTe/Py5sjuEq3+npILdfic0JE3DI8s=;
 b=WXhXoS0bKl766OEyI/mjBaqem6Lw6tYXYnKEdq/dPDWlgGapORgdMbiLL6aCv3EXu8pMjyCFeUwsch3SHUKfJDUq3DMRg8N09WtAOioJMUCyV6PMilfOTdfd6RvyZxn9T1/anfzLvrxdSpOLwNFOQrK20jkMTaLbLC8nvh87uDY=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR08MB2826.eurprd08.prod.outlook.com (2603:10a6:7:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Thu, 2 Jul
 2020 09:54:42 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::9:c111:edc1:d65a%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 09:54:42 +0000
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
Thread-Index: AQHWT1C8uFH8AvHCck+eqX9WRLxleKjyjr6AgADqeMCAAHS8gIAAIGIA
Date:   Thu, 2 Jul 2020 09:54:41 +0000
Message-ID: <HE1PR0802MB2555BD29BC9B8528AA914998F46D0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200701023821.5387-1-jianyong.wu@arm.com>
 <20200701105927.GA20762@nautica>
 <HE1PR0802MB25552E53839BA81FB26210ABF46D0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <20200702075627.GA23996@nautica>
In-Reply-To: <20200702075627.GA23996@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: db08b96e-ff10-45b1-8455-9ec620d5c5d4.1
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56645b01-d5f1-4a9a-676f-08d81e6df553
x-ms-traffictypediagnostic: HE1PR08MB2826:|DB8PR08MB5081:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB50817B7C5C950F0E1B1A3270F46D0@DB8PR08MB5081.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:10000;
x-forefront-prvs: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sb26EiP8/PrtCK7J0UMziesl4Rnp1hWJVooOzWSjqNm4zDxPknsiigdVoS4jMBR8cKPtHSvKmZooKffzBAinkQQ0KISZoMKoqLGQ2VPaVsRkUwqOaKiFUqXpGEJyfDg3bB+uX5yEpB9aTaQovz30Zh2PkjRis3Qoo2xPXb7zP52s6+Uk7yVY+Tbn/E1nJSD+CY1jrfEI+m+AV4BWyZss4fSp6+RatGKGge2owTWi9oIbLBGe3SM93A2u+A2S9TJXg4AB2Juuz5KMqwWjTjpPCLSXdMsG8CDttV/V0XIsQsNlQkeV00kanNyZ8tXwg0t5
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(7696005)(76116006)(54906003)(8676002)(66946007)(9686003)(2906002)(55016002)(5660300002)(66476007)(66556008)(64756008)(66446008)(6916009)(52536014)(478600001)(316002)(4326008)(71200400001)(33656002)(86362001)(26005)(53546011)(6506007)(83380400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5DrR+yh7cAM5+htNQP7hHtb0yCOE1IIMM7sR8GrRQh27lJi6yzT9JCLkAJ2u5kttdGapUeT28BGAxQe2u76Peb4gvQCOMq/wHO3frhwe1PvbQIzbH0UHokFurhJdmsPc8VqeA1P6q0mVl1ETyYIO2utKrf5v8vm64mwcJMWbVPdoMhDP/Bo1KHsQhapfgbwM2X3E3gLVkHT/yd3kg4dubABanh23B7OB207Zv7DCDvcmVZwVsheyjE/QBwwjSI2tXOd2Gjq+Y6p22rhDwrNWEaya3MkKCWsD6kuS9qEM0az6MKCEWDyaKVxrS6oith2ZYQh8/iZk4/RlGyZlyTyzkFn+OXEZ5A0H/kEkaVv+r3gDbPYXBhEONsuXpLHJW8sdvikTNEYXMeIHMy8d443izqhzH36g08F47Q0dkJ+jHU+Sa4QH6zTHUwzkqxvvU0+P76BUeKHUa9QK+RjinAhDbxNsRFooSGo78vfS67QLeJg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2826
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(6506007)(5660300002)(26005)(82740400003)(6862004)(316002)(33656002)(36906005)(70586007)(336012)(9686003)(47076004)(55016002)(83380400001)(7696005)(82310400002)(478600001)(4326008)(53546011)(186003)(70206006)(8676002)(2906002)(8936002)(52536014)(54906003)(86362001)(356005)(81166007);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 382b71ed-a7c8-4560-ebd6-08d81e6df148
X-Forefront-PRVS: 0452022BE1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59a2HZhFfVsD4fbDKmrRDTX92QDftvK8gt+dA+2tcStb0VFvDx4yoMcmx9mA2tTwILyEFsl9HBmPDrVv3OMU4g0X+hPBUu8QtYDeE/jALf4htVIyN0bKloEeuagniKfhgOyHbs0rUrIPm9BuiR8Zc8IkB7Ws/2cojTdEkDGD8M9rIyU6zeGdyvXWZT7+ACVZlwim8Xlm3enAVtKG+1zneHq2mEeaQo8S1YXLnnFsGl7stbAkX+UrooT2XEDHizpDf8bQqHjmwqapN1lLyCUY3x3j7ssY31mnauhsDw3XhI5TSMW7NPTp9ewYsCnALVDzYYZ6Nq+6gk+2qDPXU4/gsdxZmwHp91fg6GBKLcEIWYnxayaLU6c5153soJJTRsMmtCFN5z1Q1luBLHRicupyMQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:54:48.8427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56645b01-d5f1-4a9a-676f-08d81e6df553
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIEp1bHkgMiwgMjAyMCAzOjU2IFBNDQo+IFRvOiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VA
YXJtLmNvbT4NCj4gQ2M6IGVyaWN2aEBnbWFpbC5jb207IGx1Y2hvQGlvbmtvdi5uZXQ7IHY5ZnMt
DQo+IGRldmVsb3BlckBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IFN0ZXZlDQo+IENhcHBlciA8U3RldmUuQ2FwcGVyQGFybS5jb20+OyBLYWx5IFhp
biA8S2FseS5YaW5AYXJtLmNvbT47IEp1c3RpbiBIZQ0KPiA8SnVzdGluLkhlQGFybS5jb20+OyBX
ZWkgQ2hlbiA8V2VpLkNoZW5AYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gOXA6
IHJldHJpZXZlIGZpZCBmcm9tIGZpbGUgd2hlbiBmaWxlIGluc3RhbmNlIGV4aXN0Lg0KPg0KPiBK
aWFueW9uZyBXdSB3cm90ZSBvbiBUaHUsIEp1bCAwMiwgMjAyMDoNCj4gPiBZZWFoLCBzaG91bGQg
Y2hlY2sgZmlkIGJlZm9yZSAidjlmc19maWRfbG9va3VwIiwgaG93IGFib3V0DQo+ID4NCj4gPiBp
ZiAoaWF0dHItPmlhX3ZhbGlkICYgQVRUUl9GSUxFKSB7DQo+ID4gICAgICAgICAgICAgICAgIGZp
ZCA9IGlhdHRyLT5pYV9maWxlLT5wcml2YXRlX2RhdGE7DQo+ID4gICAgICAgICAgICAgICAgIFdB
Uk5fT04oIWZpZCk7DQo+ID4gIH0NCj4gPiBJZiAoIWZpZCkNCj4gPiBmaWQgPSB2OWZzX2ZpZF9s
b29rdXAoZGVudHJ5KTsNCj4NCj4gWWVzLCB0aGF0IHdvdWxkIGJlIGZpbmUuDQo+DQpPaywgSSB3
aWxsIGFwcGx5IHRoaXMgY2hhbmdlIGJvdGggaW4gdmZzX2lub2RlLmMgYW5kIHZmc19pbm9kZV9k
b3RsLmMgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MNCkppYW55b25nDQoNCj4gLS0NCj4gRG9taW5p
cXVlDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55
IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBh
bnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5
IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
