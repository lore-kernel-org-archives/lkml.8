Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FADC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23F8206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1TqYOV1Q";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1TqYOV1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgFKPqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:46:49 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:55588
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbgFKPqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9NLrrgf91ToaU0F+dBv9Qyup0qbWVqOw5XVK54hKSM=;
 b=1TqYOV1QwCng1o9w5GG5qzwRW1qJ58ib3SOyvT/v10cuD3XR6h2vDXCcpOqPwZ88gnJp1fTL9CsNZbCFYvu+r8Ye+hJC1rutnvwwkuOtKPaPfPcCyPupG1eNd/Ai552WpyAVLOxsxC7rHBz2VxGpBwAPWoibbe+4v3ZU34z0Fxg=
Received: from DB3PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:8:1::31) by
 AM5PR0802MB2545.eurprd08.prod.outlook.com (2603:10a6:203:a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 15:46:43 +0000
Received: from DB5EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::53) by DB3PR06CA0018.outlook.office365.com
 (2603:10a6:8:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Thu, 11 Jun 2020 15:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT032.mail.protection.outlook.com (10.152.20.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 15:46:43 +0000
Received: ("Tessian outbound d3ae83885012:v59"); Thu, 11 Jun 2020 15:46:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e78fca2ff21d95c1
X-CR-MTA-TID: 64aa7808
Received: from cd96d1aac321.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D99C5F1A-941A-4255-83F6-4595569C8AC0.1;
        Thu, 11 Jun 2020 15:46:37 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cd96d1aac321.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 11 Jun 2020 15:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjPaRNUxXlsdoaiImzJpDL4ct+TOVPi+/cS/PJ1nD4r/GhjfBOGKajg8TzvE2gebNSmL9JiXP8Cv2frgO0CjGzm9VD0pRjHdZHiIBBR7MAJXR9LKaRbgC+PduO1urTcF0kWRO5GzDa6fw6s2ThRNChTg0RvMq9ALkNOtJ+AysRRn4pUz6c8HAsoksSSmy701cUvrUWH+9Onv07Jzr3cfddmxmaceRcv2XS9KicbLUcoWLcLELJQelM/czbKO0NRVYHsbD+NabThUPgJ7PBXaHA+KkuQBB8FOrrncx8yUsKl8eyGRHqkmsEbInT3wSSM2JaxJE35QJdHv1fD+jseZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9NLrrgf91ToaU0F+dBv9Qyup0qbWVqOw5XVK54hKSM=;
 b=e381b8eGwWx9N7BTuERWJ/ylpJs+J/dxOpGaV1M482ySueJgHTimZQthtXtOGN/JwtGsvg1cG8SZMkxbXy2P1B0wyOMdE2C/7wUzPhE4h7rtYYbTpLDas1aH459OKqKNKaUuQqZ/3hSjwfR4oveYzGEOuLCHJWo5FiWD/LUhsj5KVQmUmncTFLkda23zTgejHt1WXOpylbJfJ1wZSHwpzV4SNBCcfHqOPMqtw+hV2T/jZg9xgMsx7iB/S3ZzM4v8hRMU/yj+9SNFjxTVxJT9TVMdBBQLB3dZ9Iue2iI5n8dz11c70icYQ9ShmNees4GO6vHJnuip90fKPR9umgOwUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9NLrrgf91ToaU0F+dBv9Qyup0qbWVqOw5XVK54hKSM=;
 b=1TqYOV1QwCng1o9w5GG5qzwRW1qJ58ib3SOyvT/v10cuD3XR6h2vDXCcpOqPwZ88gnJp1fTL9CsNZbCFYvu+r8Ye+hJC1rutnvwwkuOtKPaPfPcCyPupG1eNd/Ai552WpyAVLOxsxC7rHBz2VxGpBwAPWoibbe+4v3ZU34z0Fxg=
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com (2603:10a6:4:73::21)
 by DB6PR0801MB1670.eurprd08.prod.outlook.com (2603:10a6:4:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Thu, 11 Jun
 2020 15:46:35 +0000
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::a1b3:fa5:e0d2:b57a]) by DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::a1b3:fa5:e0d2:b57a%9]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:46:35 +0000
From:   Achin Gupta <Achin.Gupta@arm.com>
To:     Will Deacon <will@kernel.org>
CC:     Rob Herring <robh@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, nd <nd@arm.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Thread-Topic: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Thread-Index: AQHWN/n43KKtdAeK40mk/wmuvCbNoqjQ7LSAgACZF4CAAhk1gA==
Date:   Thu, 11 Jun 2020 15:46:35 +0000
Message-ID: <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus> <20200610074346.GB15939@willie-the-truck>
In-Reply-To: <20200610074346.GB15939@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.14)
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [84.68.67.25]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 985c8eb0-d86f-4237-cf6c-08d80e1ea3c6
x-ms-traffictypediagnostic: DB6PR0801MB1670:|AM5PR0802MB2545:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2545E9CB434D29E508C6D1FAFF800@AM5PR0802MB2545.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DS6GgnPlgoIr68ht8ImbqHFqIHzeMzkYIlSc+1u4CMEh8qpXdb/QTTeHkTq13VCz4r1P2VvRHCuoXasBvK5nLs0ePGPRP3dk83cAZN4QqTABzkzFmRakNMoTQALuByJ9LhBWHE9UpqMTLr9LCXeozCs82bkTfS6N0AQ0JSSgqV5VIAtQS+1kJKG6AHk9SfDxYPOSjwiz+Ydv3Ih7AqDSkAZGs0XlL7odv6DEg09BdnTmUKM87OBAahRRTHtBOXZ3aRlxMdOpUv5ilvmw442ptrxu84Oim/uw2u9DzJMaeOGPTKmB2kQdnNu8PWW0R5R1DBmtIAyPaOkN1hvaDcG+xg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0801MB1861.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(4326008)(478600001)(53546011)(6916009)(6486002)(86362001)(33656002)(6506007)(54906003)(6512007)(76116006)(64756008)(8676002)(26005)(186003)(71200400001)(5660300002)(8936002)(66446008)(36756003)(2906002)(316002)(66946007)(2616005)(66476007)(66556008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KCCNU3e5SD3pvHV01gvQ7V2T8CU9m8BtLGZDsHOEJQmBjUUgFYN9QH/kdihS/od6tmsxe+5BzUcCu4eVPuHYDmXDJP+XkTDkuPNcVLkoh68TCzmIBTGU+ZFwGHbEKzHGF+tS8rs0fc8tonv160lJP7OloFA7mDHrEreoopb8okAl2zqQ0777M/SknH1fMWCrCtqMm7dUHHR5F7Fr+NFBBtg3SfHLT22+wyoDXv9Iz9bTppa1Ig4LuyyNXkMehKXAzQSnGz+OQh46sm3KeWkeErFgI1nMSui5RTPtqbRsxhjMMnSYBlHiH7MKPMCwR7GKASrRUO/BCputthWF3m4Y3Zhl864mewCyuZWfFby+df/re7gNvGyLZcgUgX5qMpwj7FT0BM4ZlZ4L7DTce/w+aZD1+edbRuNV1mZTbjVbsiwaS2ju8XHVMp109x7bHbPde9ZMGjYRrraMUxu8e+KvsZdUJS+Qj+obAesokkxwfis=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCD78BCFC6211649B3AA9B29B2B0CCBA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1670
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966005)(5660300002)(450100002)(33656002)(6506007)(6486002)(53546011)(186003)(26005)(36756003)(4326008)(86362001)(2906002)(356005)(82310400002)(81166007)(478600001)(6512007)(2616005)(8676002)(47076004)(8936002)(82740400003)(6862004)(70206006)(54906003)(336012)(316002)(70586007);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e23569a0-6e6d-4592-7e6d-08d80e1e9f6d
X-Forefront-PRVS: 0431F981D8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLWREhWCxQvGWllo1QJuatozw4KMd789V87CQXcMBjcph+48Okm6Go/+GbxfkzQruiJOaXhkZnFMauMbdPVrVGBF7UlOW1/aLlZWGuHOVI+LaGjQJxG2znRS61Ytty58sCLh6fFLx+daBsAoCmzL10RzJipo+xyeXzEEoKBvkY/hHaxESBVi8pmLAxRn6LBt0sc/7Nr75UoaLr3UGozWbz+82xp4Y9HatbofOLG0xhYtW0eaYPpzokud7nULXgYIJuulvKMqd8uE0VojsMo4uk3gkZpCQyQmto+I20MfFy+8tDuCx/9HSAsmGH+3zL5gmC0JrYFgBxbwVegai0gPATUqYg6StCulRFy0jt4ztZaaUqfze++1GsPTOnsOb3OjjH89Glu9DIKYEDFz1hRpzg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:46:43.2353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985c8eb0-d86f-4237-cf6c-08d80e1ea3c6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCwNCg0KPiBPbiAxMCBKdW4gMjAyMCwgYXQgMDg6NDMsIFdpbGwgRGVhY29uIDx3aWxs
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdW4gMDksIDIwMjAgYXQgMDQ6MzU6
NTFQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+PiBPbiBNb24sIEp1biAwMSwgMjAyMCBh
dCAxMDo0NToxMEFNICswMTAwLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+Pj4gQWRkIGRldmljZXRy
ZWUgYmluZGluZ3MgZm9yIGEgQXJtIFBTQSBGRi1BIGNvbXBsaWFudCBub24tc2VjdXJlIHBhcnRp
dGlvbg0KPj4+IGF0IHZpcnR1YWwgaW50ZXJmYWNlKFZNcykuDQo+Pj4gDQo+Pj4gU2lnbmVkLW9m
Zi1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4+PiAtLS0NCj4+PiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXJtLHBzYS1mZmEudHh0ICAgfCA0NyArKysrKysr
KysrKysrKysrKysrDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykNCj4+PiBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9h
cm0scHNhLWZmYS50eHQNCj4+IA0KPj4gSSdtIGhvcGluZyB0aGlzIGdvZXMgYXdheSBpZiB0aGUg
ZmlybXdhcmUgaXMgZGlzY292ZXJhYmxlLCBidXQgaWYgbm90IERUIA0KPj4gYmluZGluZ3MgYXJl
IERUIHNjaGVtYSBub3cuDQo+IA0KPiBXZSdsbCBuZWVkIHRoZSBiaW5kaW5nIGZvciB0aGUga3Zt
IGhvc3Qgc2lkZSwgYmVjYXVzZSB0aGVyZSBhcmUgcGxlbnR5DQo+IG9mIHBhcnRpdGlvbiBwcm9w
ZXJ0aWVzIHRoYXQgYXJlIG5vdCBkaXNjb3ZlcmFibGUgKGUuZy4gbnVtYmVyIG9mIHZDUFVzKS4N
Cg0KSnVzdCB0cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGUgcmVxLiBhIGJpdCBiZXR0ZXLigKYNCg0K
VGhlIEZGLUEgZHJpdmVyIGluIHRoZSBob3N0IGNhbiB1c2UgRkZBX1BBUlRJVElPTl9JTkZPX0dF
VCB0byBkZXRlcm1pbmUgdGhlIGNvdW50IG9mIHBhcnRpdGlvbnMgYW5kIHRoZWlyIHZDUFVzLg0K
DQpJcyB0aGlzIGFib3V0IGEgZ3Vlc3QgYmVpbmcgYWJsZSB0byBmaW5kIG91dCBob3cgbWFueSB2
Q1BVcyBpdCBoYXM/IA0KDQpDaGVlcnMsDQpBY2hpbg0KDQo+IA0KPiBJJ2xsIGhhdmUgYSBnbyBh
IHlhbWxpZnlpbmcgd2hhdCBJIGhhdmUuLi4NCj4gDQo+IFdpbGwNCj4gDQoNCg==
