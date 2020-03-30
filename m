Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80548C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A062073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="CXEoalC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgC3GON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:14:13 -0400
Received: from mail-vi1eur05on2130.outbound.protection.outlook.com ([40.107.21.130]:12129
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728492AbgC3GOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:14:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmHUvcOOldGAkM0+dI6lWB7q1PnImnN+PbcE4DoNVGryMy78densvloQEVdCrkwEah0a9P2nE3SH39sfbMOvvPJJnXxcI6mH+jO6MUM89coCIYTWp+B4E1NM1Au3GwOT1GyZfeX4MO7+DTL9FpKWTWJkQs4YBQX4R0sMdyWYpSXUozzAIxUQkHXle359gtj+SuQ0SLCwx5ruujZwej51pqq6ALBIfl7LLvLj9hi7//Xogx8jwN/SoqOVNWfyJD2+USJmjSU/AifZz1S+CwxLiwa3923D2bRRftPwonfAgg1UqoR6EWUm4jZ6hwCKnpAO1BvhYuYAS453F0L28P1FTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9oj02QM0Uyzx+9UcmSWoVlLT8hO6Dq7zQj0P/+e70g=;
 b=fJohYhegXgC7djI13SUyjVrsQBAhQkpWOwk41g/prQP9tKW4NY8rv4fVK+bP/8IV2+8ZPFhU0+13i9jC8fD4Ih5fJkEzcgnhBSDzLMPOxGIQQpFqrrH820rdUV5VJ7zVPZZOgL7i4wPHYCiSfaztMJPrjxqjVQ8PhC5ySVM/b92lawULpqOkW1Tu1tYP0orfpveArqzrP3wf5fZtR4RHSXGsw2g/9mQApXkAHiSSel9Goh86Q8G9IhutS+/YX5AJFg3caPcSVs05tRcpKkmVU/8BxAVTsPZwnLXrkkYMMJMhDC/tN6w5IB5h1drBJesRCTXJ1YK3HcMBYsD7I8L1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9oj02QM0Uyzx+9UcmSWoVlLT8hO6Dq7zQj0P/+e70g=;
 b=CXEoalC6FxBfhoAd+pNYG+tSCEIEIcfA8Fz9Jc0N8h6B0OFpfa+oP97PhbBeR2LU9rjs1Nl4Rs2Mt17/wmtMsBNynd/FQ5F/AeT6MGeWXYZdLy95wACFGMdQWo8KlfSJ/9T4WtwcDJkap1jvzNoUX463y+xBpyq3hyIRvVYKSjU=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB4964.eurprd02.prod.outlook.com (20.178.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 06:14:07 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 06:14:07 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 6/6] habanalabs: increase timeout during reset
Thread-Topic: [PATCH 6/6] habanalabs: increase timeout during reset
Thread-Index: AQHWBN5EpMmx+cbS3UONVVMnseQbTahgqi5w
Date:   Mon, 30 Mar 2020 06:14:07 +0000
Message-ID: <AM0PR02MB5523AC0E528B32AD791AC9A9B8CB0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
 <20200328085238.3428-6-oded.gabbay@gmail.com>
In-Reply-To: <20200328085238.3428-6-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.15.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e76ede-066a-44ee-5e71-08d7d4718e1f
x-ms-traffictypediagnostic: AM0PR02MB4964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB49649D583718F6C7CB169DCCB8CB0@AM0PR02MB4964.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39840400004)(52536014)(5660300002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(2906002)(26005)(33656002)(316002)(8936002)(110136005)(55016002)(186003)(6636002)(71200400001)(81156014)(81166006)(8676002)(478600001)(6506007)(4326008)(53546011)(4744005)(7696005)(9686003)(86362001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2UhN/XewtWhMMifpuz3N/xSMHcN6YSsPtMRlreOBnmG7y7G/ub8C5CYL1IVKnjo7OOUCavv0fY8froveLDj4C79DDx18kUmtpurcnUiiF/UQsLl+LV+OYbiJcdlD7gASGU74D7oZ76hKPHaoJ94PARVacRfY+gompfnWAWQgSqvruyjp6fzVLRItZnMVUKnaAfuGw48enQCJHI3nlczgK5oKk+8DFlc0u+7fs4X/woCTAkuXNM5dwxzrId4fLStMnq6bFqzDJwSgdCev+P/TBHDpB1aaeCVGHornxdLTJmh0kM0bMr6WbJzQldwWLQ9DCkC88XfsbZVHHgtCwz0fEXCogjgG+glN/cTa5u8m4NrtjZG5aQh4LH4TRGBlBxsruR2SecD0Lr5USrPZw9AJXU4jA4mTwio61TIbWVGw36OtwZZ/9ymz24NqWT1GBlvI
x-ms-exchange-antispam-messagedata: LI+Fq0sI95msmuYRnNzRGPUlSnBBqecRqRhXnsVSx9m6ApHqmb01CZdn/QvuhTqPtCSe5gSafymRj3Wrwnezf2Rx1PHEjj5AjOXEFnH3ljEY8aM94t8H/TRdUyy2+qVwhnPZL2Ql7QRmwZdMn5efgw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e76ede-066a-44ee-5e71-08d7d4718e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 06:14:07.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4oUiNp1zogPZ3B4sFFbVXAp2HpUSqwfXA1SywPgua1lThBR41fC0s39BQtRs5yJfINBhnX1iwF/MgBe2cXZog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMjgsIDIwMjAgYXQgMTE6NTMgQU0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBXaGVuIGRvaW5nIHRyYWluaW5nLCB0aGUgREwgZnJhbWV3
b3JrIChlLmcuIHRlbnNvcmZsb3cpIHBlcmZvcm1zIGh1bmRyZWRzIG9mDQo+IHRob3VzYW5kcyBv
ZiBtZW1vcnkgYWxsb2NhdGlvbnMgYW5kIG1hcHBpbmdzLiBJbiBjYXNlIHRoZSBkcml2ZXIgbmVl
ZHMgdG8NCj4gcGVyZm9ybSBoYXJkLXJlc2V0IGR1cmluZyB0cmFpbmluZywgdGhlIGRyaXZlciBr
aWxscyB0aGUgYXBwbGljYXRpb24gYW5kIHVubWFwcyBhbGwNCj4gdGhvc2UgbWVtb3J5IGFsbG9j
YXRpb25zLiBVbmZvcnR1bmF0ZWx5LCBiZWNhdXNlIG9mIHRoYXQgbGFyZ2UgYW1vdW50IG9mDQo+
IG1hcHBpbmdzLCB0aGUgZHJpdmVyIGlzbid0IGFibGUgdG8gZG8gdGhhdCBpbiB0aGUgY3VycmVu
dCB0aW1lb3V0ICg1IHNlY29uZHMpLg0KPiBUaGVyZWZvcmUsIGluY3JlYXNlIHRoZSB0aW1lb3V0
IHNpZ25pZmljYW50bHkgdG8gMzAgc2Vjb25kcyB0byBhdm9pZCBzaXR1YXRpb24NCj4gd2hlcmUg
dGhlIGRyaXZlciByZXNldHMgdGhlIGRldmljZSB3aXRoIGFjdGl2ZSBtYXBwaW5ncywgd2hpY2gg
c29tZXRpbWUgY2FuDQo+IGNhdXNlIGEga2VybmVsIGJ1Zy4NCj4NCj4gQlRXLCBpdCBkb2Vzbid0
IG1lYW4gd2Ugd2lsbCBzcGVuZCBhbGwgdGhlIDMwIHNlY29uZHMgYmVjYXVzZSB0aGUgcmVzZXQg
dGhyZWFkDQo+IGNoZWNrcyBldmVyeSBvbmUgc2Vjb25kIGlmIHRoZSB1bm1hcCBvcGVyYXRpb24g
aXMgZG9uZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdt
YWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFi
YW5hLmFpPg0KDQoNCg==
