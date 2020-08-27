Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4282CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C972080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="pda0FoJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgH0QES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:04:18 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:47066 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgH0QEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:04:15 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 7BC108224D;
        Thu, 27 Aug 2020 19:04:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598544252;
        bh=bUOXK6u27L4klWcRinmN6IcOpvxrHqpRrAZnW1Wp9Ww=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=pda0FoJy02F9y4i/MgdpB+xyv/Jg5EROB7yYv/JFU7xauRpU7NxB529j50QAWyWfU
         htmqCrJfo0hebLYHglLFrAmSA43b3qqTVL3M6a8+h0wF8IpD3X5DcTD9TqN2vdJPz3
         upd56W+3i8OLwvND7ouvujjWkBzia3/SLFYt97pw=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 19:04:12 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 19:04:12 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
Subject: RE: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AdZ30tAfM9dNSlAKR92rLVrbgJq3AP//6yCA//Z5wbA=
Date:   Thu, 27 Aug 2020 16:04:11 +0000
Message-ID: <7db29d4314b24ff68526cb816ebae3a3@paragon-software.com>
References: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
 <5dfec6f4-0688-217d-587b-ec26f0bb9727@infradead.org>
In-Reply-To: <5dfec6f4-0688-217d-587b-ec26f0bb9727@infradead.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQpTZW50OiBGcmlkYXks
IEF1Z3VzdCAyMSwgMjAyMCA4OjM2IFBNDQo+IE9uIDgvMjEvMjAgOToyNSBBTSwgS29uc3RhbnRp
biBLb21hcm92IHdyb3RlOg0KPiANCj4gDQo+ID4gKy8qIE86QkFHOkJBRDooQTtPSUNJO0ZBOzs7
V0QpICovDQo+IA0KPiBXaGF0IGlzIHRoYXQgbm90YXRpb24sIHBsZWFzZT8NCj4gDQoNCkFwb2xv
Z2llcy4gSXQncyBNUydzIFNTREwuIFdlIHdpbGwgaGF2ZSBpdCBleHBsYWluZWQgYSBiaXQgbW9y
ZSBpbiBWMy4NCg0KPiA+ICtjb25zdCB1OCBzX2Rpcl9zZWN1cml0eVtdIF9fYWxpZ25lZCg4KSA9
IHsNCltdDQo+IA0KPiANCj4gPiArTU9EVUxFX0FVVEhPUigiS29uc3RhbnRpbiAgIEtvbWFyb3Yi
KTsNCj4gDQo+IERyb3Agb25lIHNwYWNlIGluIHRoZSBuYW1lLg0KPiANCg0KRG9uZSwgd2lsbCBi
ZSBwb3N0ZWQgd2l0aCBWMy4NCg0KPiANCj4gdGhhbmtzLg0KPiAtLQ0KPiB+UmFuZHkNCg0K
