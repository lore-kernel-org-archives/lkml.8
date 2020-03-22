Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0921C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7348820719
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Kq77EmLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCVTFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:05:18 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:32825
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbgCVTFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 15:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRVrE9uWFAVuiOCoEieuWBh5KvJNkuR+XU0Bb1E4hX2I/nslqV+asSZ/vLsE7BBi+CCtJDIICsepr7j0ZrSaiSedb5eeEcd+svfWFQ3ePGU6sx/uklSuZ4QQdNlD5tu+SuIRfVmwmwB3vqW9FgGvzj61n+4DhpAKCekWvwwB1Jr0klri6F4OsUgWxf7X7HzmPVVOOkeBD29WYjGBahzagGnCNT2E+RUeOLgvgs7ZFow3/wzpWt6vH6hooeIZ3bIh831qiIP2R7yDiyAS/YkVWvCSbxX5VUEbCJQvR8182HYSkPHeYge40BRBS+MROHEQelmRXm1Sb5LsMUu6duRg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uNfIu5M7z/Sl8nYJ9NZTdnafnKR/RSNzI1QAhRadsE=;
 b=G31duX6sdT01G2W/zsp7xc3VQRj6unEjj1Wtz69yd6Asaw5o0ppLxGASE5M7xsfstgA6yGoDTCJFFBG7uWEdjBVNlGgeNgQAk5eD0RKx3KQB1wH73+zydEEAyUUts5S4cMmVTSM9pWPARhI5qS4+OGcA/KdVd+PPH5hEDlIpfl6C75vqQIXcYcAk3k5ksZK/JVKzTK/FcMwpidVoeBlIRfSGIj6IXrVIUIdhRtKr4fpDU3yQauk1exmpQtp1Yb8gjyqGZ/IcjT6fXYGIzRwD8/neMLFUBQDQKBE6mM8w9ZXA+5pGMv05MM3hQzTaFgzQed+dtH9UQFO/Fike9NCLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uNfIu5M7z/Sl8nYJ9NZTdnafnKR/RSNzI1QAhRadsE=;
 b=Kq77EmLzGu9iz9D/H2lJYFLh2xWXOR8IvnlWYMGQ29IA2+N8SZEEmOyWQr9Tf9xLQj/K7yHQ31/JxNbyIp8NuxbHA5XlulTafD1zwUSJ7jtkAJPc9XISUekTMhxT+M0v6LzyxBsubJkYfUyosmUduGzWQA79cjodkGprXQXgzy0=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB4371.eurprd02.prod.outlook.com (20.178.16.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Sun, 22 Mar 2020 19:05:12 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5%3]) with mapi id 15.20.2835.021; Sun, 22 Mar 2020
 19:05:12 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: fix pm manual->auto in GOYA
Thread-Topic: [PATCH] habanalabs: fix pm manual->auto in GOYA
Thread-Index: AQHWAFelqDAynMlSDkWN4XBdq2sjWKhU9+Ag
Date:   Sun, 22 Mar 2020 19:05:12 +0000
Message-ID: <AM0PR02MB552324CE31E5D531EE845453B8F30@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200322143904.2305-1-oded.gabbay@gmail.com>
In-Reply-To: <20200322143904.2305-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.14.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8f27ad6-93aa-4b3b-c061-08d7ce93f2cf
x-ms-traffictypediagnostic: AM0PR02MB4371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB43714BFF204DD0E783E457D7B8F30@AM0PR02MB4371.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(39840400004)(396003)(199004)(9686003)(76116006)(66556008)(66946007)(66446008)(64756008)(66476007)(52536014)(71200400001)(5660300002)(478600001)(81156014)(8676002)(81166006)(8936002)(4744005)(4326008)(86362001)(6506007)(2906002)(186003)(53546011)(55016002)(6636002)(7696005)(33656002)(26005)(316002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4371;H:AM0PR02MB5523.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ToTDl8OTsrhwoNQDTohIZh0hhtt6MtAmQG31k0ecFrhKBOu12En6z0F/RewbeQeSw/5qAXezBvUK4GfuJPZOZOYEyGwt3QeOlV64K+uvswZv5XFUgUrd0KrsCdhyELi+LKG+Em5gSXXLjSSwuvCI2IjG7lUwc0EhJy33Hr2TYBK35qdo6pizSTTktNQDn4ctB3VHh8zEtBord1Lyaq+IlTwbyru0EbPr+J80HwswleqZTL8kZDO8Wj58vKQxay8HBI2sD1fHQvF2m35r+0I49gfzqbsLUk0dGaCmVctyHZKfrXkYsvdhJk/cndcZY2NqwoGoRJmsHU9tBV9hpp87pjhLMuoMyUdgbrH8M3qcSe2voxABrYfm8m/2zDhIj1w+1W5MUuCLuatE8+fABnNLxZRUeeIWlkv21q3RBp4+lWt++UXzJiN1dWGLkIVVim3
x-ms-exchange-antispam-messagedata: OIiDn1UOhEymvgB38RuZoAg25+g//XDahTCMn1OgKJgYqGgsFbpfMujvRId8nPgrFlbQzda6sENOcLxf5VugQv3inlXa+70oGuEroGYT3QVcKhzbNOWXy3XlWWxvdiq5Rjijhp3mc5qM+hntAk+08g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f27ad6-93aa-4b3b-c061-08d7ce93f2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 19:05:12.4051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ha6ERJI36exz+IUf6shbpHsO9CSOB9YPEGhd3QmQ6BU8Q4tVwWflvC4B52RHkcN5DG/GZchBmBSpiCcd21DRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBNYXIgMjIsIDIwMjAgYXQgNDozOSBQTSwgT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IFdoZW4gbW92aW5nIGZyb20gbWFudWFsIHRvIGF1dG9tYXRp
YyBwb3dlciBtYW5hZ2VtZW50IG1vZGUNCj4gaW4gR09ZQSwgdGhlIGRyaXZlciBkaWRuJ3QgY29y
cmVjdGx5IHBsYWNlIHRoZSBkZXZpY2UgaW4gTE9XIHBvd2VyDQo+IG1vZGUuIEFzIGEgcmVzdWx0
LCBpZiBhbiBhcHBsaWNhdGlvbiB3YXMgcnVuIGltbWVkaWF0ZWx5IGFmdGVyIHRoZQ0KPiBtb3Zl
LCBpdCB3b3VsZCBoYXZlIHJ1biB3aXRoIGxvdyBmcmVxdWVuY2llcy4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IE9tZXIgU2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
