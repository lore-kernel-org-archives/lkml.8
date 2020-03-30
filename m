Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D002073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="JUraLB/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgC3GBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:01:39 -0400
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com ([40.107.21.91]:41440
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbgC3GBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiylZa89Bgdiro36PvvbzCG+YrvUzC07AZ7r6eoKI+wKa+HezjvtGAU3QLrB8iN+HcmagTYWy2rRXy1beGn6LsOpgfHmLwx1ocqL/5VToZx/CFWmIADUhn6cGrwYT5/+mJnCLmQyOkkNzDS6gwbRMSiLcJ10EbzPxKpJchkFpUueiNtjqZkNfiI7mwnizoak38NoxuhwOJbujZg5OmWxyHpEWkuXK6OfGb+OGcCkSbrUiT8CRjhm9w40G2sLKwZejmFqfN4gh+JvJs7czM7e3tSzUeIsoNoTKP9NZVwbpC6u2MgC86N7gJ2UoEkB08Fw7d/vS5JIOAAHr95HIoJiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=calfb15DTdg2eL3+r9CwPRX0QdNlvOKBXXowDOHfYzo=;
 b=cVqcVsEbkbortHW98Y4EQO7YZReymqUyD2z9zoJCX626BAZwNIPa3RRYH6pECM/fVidgrIJYapvhyYjduuUJ2+0d+Qu+NuBeX5PvsvYFsK9AwnMPK48dqDlUXrPkVPtwCFyJPi3Q7diuZ0nQeX6ySKagKN3SlzFdOufNaopJH+9RHwHChCE5coYPg2HRqnmFDK8j13dRCRPvA9qBXTIpPvrHHXn1TbPquVUlzL6SSq6WHUjgnjabec2VOaPpPNH3YuzSTboLoTNAVBP3R8wW32QfXFIknXGS9sb/wZEVzJa3x+XGgW+bWOqDnG0M2nsGTMz9QrkDLplmnQU7e8bCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=calfb15DTdg2eL3+r9CwPRX0QdNlvOKBXXowDOHfYzo=;
 b=JUraLB/3vgo+U7bqa3Pg7Q2gJJKGY2GWQtgyJKlAYygeVOTXZ+mBEqGZ6Sv30yfKr2+V4fFK/GmkdAr822p65NC43N67JVtTZV1jY2dz2c5DzU7COuuxZlInGNfPHtx7mnIQaiLzsGrB+Em9Cu3b7p8YVsPxQiBVIDDvrT43yXU=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB4307.eurprd02.prod.outlook.com (20.177.108.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 06:01:35 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 06:01:35 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/6] habanalabs: don't wait for ASIC CPU after reset
Thread-Topic: [PATCH 1/6] habanalabs: don't wait for ASIC CPU after reset
Thread-Index: AQHWBN4+/fL4sfftcE2lKet6IpPVmqhgplqw
Date:   Mon, 30 Mar 2020 06:01:35 +0000
Message-ID: <AM0PR02MB5523B773F32BC0195FAF929EB8CB0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
In-Reply-To: <20200328085238.3428-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.15.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af283aeb-8fb5-43e2-e6b3-08d7d46fcdc1
x-ms-traffictypediagnostic: AM0PR02MB4307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB4307805367DAEECC1635F03BB8CB0@AM0PR02MB4307.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39840400004)(26005)(86362001)(66556008)(66476007)(33656002)(66946007)(76116006)(66446008)(64756008)(6636002)(9686003)(4744005)(55016002)(4326008)(5660300002)(186003)(6506007)(316002)(110136005)(52536014)(7696005)(81156014)(2906002)(8936002)(478600001)(71200400001)(53546011)(8676002)(81166006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ayKjtAg7Mjcu5UExB4qjpmpm/JSK0YYP4hJkJ0dk7RcQBMaSJSraSv0FRA9ycAhPMeag8kGt6MyncWH7V5qdREDUQCk0UP5utnAJe57ZldPKKdpDvl8kEhJgyaFooEEfkGPnjquHrrWRwwkYvLbKcgXNCLhXpy8N5B8g6ab3qLpTw0tdy7uud+3xs3aWJ38hGIMi/38ArBWuCnZV1BWxtBu1lPRjDH0cDeLxL3VNWWeOjeXgnaMMPPdJmv3TNaTI7+QNz7TEERLZK09qA8Y0YZ+Nfy8kNvwQ85VQz8E6sD0ZX2YbFY/M2zB0UjIWI7mpQCi4MvoO3g1rJ+HtuTlyfaPpliMVVreYY4aMxO8UDb7HmCVrirMX4MqjBV7P2TlS/1ijbpGv7jeYpZ3VEWjebokvTLu1Vh1YGhWbX7LokNz/28uSt5IvDl6KbI4/rgL
x-ms-exchange-antispam-messagedata: LU1hRF6YKl4BCOPa5tfW3fRG2pNPrP0O+Yr+hNv2sPM+HiVGOFhPq7GPj+Tvg7mBw3tIf+iaeVcybO+hs7JOSD03gCLzPCz5dv7PKh22GAd38XgSgB3p4sdNby5DmtfJ3t6HbuaL/w/0aEewqK05Tw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: af283aeb-8fb5-43e2-e6b3-08d7d46fcdc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 06:01:35.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCzpO6b0+sZonSMGaRUS6IC+mq5og9nX5iVkeZRu1xCpY26XDAylcP5bLqd7tMBbx2SC5njOuIBIvxe+swBVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4307
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMjgsIDIwMjAgYXQgMTE6NTMgQU0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBVcG9uIHJlc2V0IG9mIHRoZSBBU0lDLCB0aGUgZHJpdmVy
IHdvdWxkIGhhdmUgd2FpdGVkIGZvciB0aGUgQ1BVIHRvIGNvbWUgb3V0DQo+IG9mIHJlc2V0IGJl
Zm9yZSBmaW5pc2hpbmcgdGhlIHJlc2V0IHByb2Nlc3MuIFRoaXMgd2FzIGRvbmUgZm9yIHRoZSBw
dXJwb3NlIG9mDQo+IG1ha2luZyB0aGUgQ1BVIGF2YWlsYWJsZSB0byBhbnN3ZXIgRkxSIHJlcXVl
c3RzLiBIb3dldmVyLCB3aGVuIGEgVk0gc2h1dHMNCj4gZG93biwgdGhlIGRyaXZlciBpc24ndCBy
ZW1vdmVkIHNvIGEgcmVzZXQgbmV2ZXIgaGFwcGVucy4NCj4gVGhlcmVmb3JlLCByZW1vdmUgdGhp
cyB3YWl0aW5nIHBlcmlvZCBhcyB3ZSBkb24ndCBuZWVkIGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogT21l
ciBTaHBpZ2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo=
