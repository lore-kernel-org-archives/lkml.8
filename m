Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3062073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="kEaBJJ2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgC3GHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:07:24 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com ([40.107.8.131]:17531
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728857AbgC3GHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLRjUANr+N6SiF3DGe2MGNbU+Fsc83FkBTC61jg0P2UVI6C/ZGYNLQM52BT73cMk8InGy11pQYFen7wP36/+a8hGkZL6PovbN8LYyG2avgMqJ9EcovrqNfGVsEZSYXWEfPth1BjBNFvItgpEgXIuYXMRrdX2k45WOxuDmlbvt2zhk7HtMZ7lXZnpvnbTuH53PqD6pOyaYzQ/v46oPiPUIf37x7942vrWDbhwHQ30Vvg/U+nrAg+3f/Tr6WiXjKFnrPYUlwMQ9GQugfXR/DgBhoDLLWKKW1cxIqj3yITlr1PmIKAHIRv/4iX4mJQCJ7cJVBPCo186kmK57mZ8qFfyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCgCTGFQvwW8ufcqjdSi8/PsDVhf3IDabLVnEatyHGQ=;
 b=hVDSdDoBWWi9j84xosP2iyVh0koxfVK05BvprYBXS0NsP9j01Cyq5u70UiFtnKc+5anDKAKYVEVw8+DhILEirVdHforQbEY0G1/DXElqFydqzLlohvPM5ifgp3+PJ8xxwVTHZRRSYpjDI/a8AkIJX8DP/iweKAqdegCJxqK7TO/rPNujA0Acz7vF4MTgUYua2IY3K5vsApdsNBNkQO6eAHmpB5pXU7kGIvCFKWv76ZJvprPE1ntM6DjE3TGy9pdt9hjmBhoNnvCxcXbLAqfKr+CJfbTbAm4MguLbVKoVgr1Cx8CxXPDwkgmAgdJ5OBJfHpLX/Ejj7HtZ2VnQvIpPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCgCTGFQvwW8ufcqjdSi8/PsDVhf3IDabLVnEatyHGQ=;
 b=kEaBJJ2ewelKQ4vrMXbJu18EisScSdystHgJIyxDDpoL5oUIbO3exKH4s8iPuZ8U0rV5Dn7LAH61poyxMAjjWNPaSjlq+5dvu/FLBVdNroO6D031IL6nruAMtbx3fmKkdY1lgmKwXSsbdxfUGiJs1f4BunzdoefFlFYqFAu/AfA=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB4546.eurprd02.prod.outlook.com (20.178.17.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Mon, 30 Mar 2020 06:07:19 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 06:07:19 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 4/6] habanalabs: unify and improve device cpu init
Thread-Topic: [PATCH 4/6] habanalabs: unify and improve device cpu init
Thread-Index: AQHWBN5CqzsZCl9110GPHQZo4w9J9ahgqCuA
Date:   Mon, 30 Mar 2020 06:07:19 +0000
Message-ID: <AM0PR02MB55239AAADD7EB8084B4CABEAB8CB0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
 <20200328085238.3428-4-oded.gabbay@gmail.com>
In-Reply-To: <20200328085238.3428-4-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.15.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcf47e6c-225b-4ff2-8f2f-08d7d4709aa8
x-ms-traffictypediagnostic: AM0PR02MB4546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB4546198595491265561B3807B8CB0@AM0PR02MB4546.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(39840400004)(366004)(396003)(136003)(376002)(558084003)(478600001)(26005)(5660300002)(52536014)(8676002)(53546011)(6506007)(4326008)(71200400001)(8936002)(86362001)(2906002)(9686003)(110136005)(55016002)(316002)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(33656002)(186003)(81156014)(81166006)(7696005)(6636002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lpr66YbBBgyBpSNl7yVhzyIwQbbUO+S4+8upp8of94FwwAm3bGRzhtwwUjTtbbWtRkBJepcqP9xa/w+bXLgUFBxDmLrFgXsTI9hhmr8po55IbnSwgvX/WEXkolTtWow1a4KMin+l4PDAWj2RmLwOV6NaFxZHVnOriDiJoZ8j1q+iGjucfxZtc9lMQMu/s3TfVA52mdSkc1fD576Yo/l4WHbVEgY2/tnpzUPK3HPv97RuPqVlC9Mdae0rCWSaasri73Veh6hfNLwO5wQ/sh6b/SFoHT9gByzUgWm5IUn1BiiFO8eF3ayc+u8uoP6xEwBAU7YYGkYLKq4idxB7PoiDqvNFdCS5zZSWPAkXbMXkkqG438Ulj8Mctbl1d0S1Xx/8M6pD8W3T63kKE6nN+4yyVky3IzR5cc430Sg2zd72LKxw3Ny5BAXe2m0h6Hrg9/n
x-ms-exchange-antispam-messagedata: 9g8drszJzFtQ259zexADRSHkmoldmK1wQMS92RTc+6Rdvg0jsM7gKw9qBRFSaY+VCA55FK2teqn7x28syLavuy/hM/gohnNPa24ziZk0azucnkj38A3I0J2zNCnDXA3UIQtPd69+++ov+lndOTuiuw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf47e6c-225b-4ff2-8f2f-08d7d4709aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 06:07:19.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJaCCyYSsV6BXXod6tAVIzpSY7ncd3Ickd5UXdiv5J7JqFmLcAGwzANNJtqlekrs20dp+CH9U/01KdRwfMMsGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMjgsIDIwMjAgYXQgMTE6NTMgQU0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBNb3ZlIHRoZSBjb2RlIG9mIGRldmljZSBDUFUgaW5pdGlh
bGl6YXRpb24gZnJvbSBiZWluZyBBU0lDLURlcGVuZGVudCB0byBjb21tb24NCj4gY29kZS4gSW4g
YWRkaXRpb24sIGFkZCBzdXBwb3J0IGZvciB0aGUgbmV3IGVycm9yIHJlcG9ydGluZyBmZWF0dXJl
IG9mIHRoZSBmaXJtd2FyZQ0KPiBib290IGNvZGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE9kZWQg
R2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVyIFNocGln
ZWxtYW4gPG9zaHBpZ2VsbWFuQGhhYmFuYS5haT4NCg==
