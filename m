Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6661C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757CC205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KB41Mns6";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZE/fc+UE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgGPR4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:56:34 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61388 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgGPR4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594922192; x=1626458192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xHOYSXMpXm7GnVYzGGZCaRnAaiLy5ZVXDb6u2UyBfEE=;
  b=KB41Mns6aONn2cicq76Eg0fq6tuXf7YtLpdn7G5rnHF7tVe9ywBB9iKv
   5uz35xxWdSrVE7nXQiUgXK/v3POgYJakjclwkp0/+ANuNVVzrtG8eSV1k
   RAAW8S3WWOzxKtR+NeluG/9D/1qxrNFEEfOyC/f//Sei+OqstGaWg95yd
   m+zSSkVxqUZ1Xt7cTtGOp7vAMjLDz2VMSiX7/Zeaphf3DV4pHdG52MPUO
   3Ti0kCyR7UC4DBDUKhX9Fw7csMkzMv3Ws2Ovs1jUTxaUnbX3gqO/3IOAE
   xx+VR9i+/hLOHgHpFiqML/WD15j2vHXWqiMG0O4FLn9aJO3PbR/UOmNDz
   w==;
IronPort-SDR: uuizLfjowjdU/R3riGOHDybZ7LA9N1vB7hVlVo4iq94lMk9PrwjIJ8ZsodQBXoeo42l6yrs9G8
 Ad44tx9c0RHK20b6wLDyD0Go7Lqai/21HnDMGLS4tWzpskBv/Wcs6LRP9enG4894EcJRqZQOon
 ktkj2vxTI2qi5Ws78tW88/qDzpqZeIoWuL9kHx6bK1psytM3i3Sa6Nnorkmpreq4eEZF1wjz4J
 lVlbUQQv9G10jHKv6AmEkBChqUwe8YvwnabIauuoMMqjXM6nLdY3INQMLp5VLJkzoDLbfevfgB
 puQ=
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="19474139"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2020 10:56:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 10:56:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 16 Jul 2020 10:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgOh1lcL92hrO9E+fZU0vxk8Z7WiBAwmKovjV83reROElbw1B07qmMJP/ZzQzvYfv6rdZ3oP9AD1ryqr3H7cK6ULWbF8PFCDwtW9h1WagmH0Z/ZD8c9a2C2IVS54OY9jorry2jp/K/CvIH8NuAxaQvWXmUb8eMdesTQu0MKm2+1ZdqNO3Ye1qIw8Am2r60Arx22TdxPgSFE/l/4NeePRNtme9oEGa8vzyAB09DzcMI88V7mCAhrf1uzGWHoQfzoXrma1qB8DyuiqChGnuUjHydwm+tMubzyyn3uIoNOqO5NE1IQqFN+rjTGp6s0XQ19eXPXSUXBQgf4ydt0GnqTVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHOYSXMpXm7GnVYzGGZCaRnAaiLy5ZVXDb6u2UyBfEE=;
 b=hjloZcIq4ATVCvKLZA4bmH/xsLqJqiTKqrNLI4BBwtUXxGWBYDKOnMYsMoXFdnEyycC3aifS5okZu2gYzNyDjtoKxAHL+RClCTcPolWCnWHbZUHAUY/34ukr/QuOv9wybzPPh2r8qvTVXt3QgAVYbKcOOzqNdFUIvdtQ/vUCseHSfv0EdLPxAbT/mAwAJhHXtCbYwHUeLv2EEepc4CvtqcV6Kwjd6cpV2cNbdH7mtCC8/8B8ZZ6rwY83hFCshEFpgoy4xoMav9Dcis1QKpfzKCP/fA+Bp7hwyO8A74LqE2T2KjistMZDwlFi463bC98gk/eUDfrKX6EgDNs+mUpnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHOYSXMpXm7GnVYzGGZCaRnAaiLy5ZVXDb6u2UyBfEE=;
 b=ZE/fc+UEOAwAtUMGeCLoaksq9bi/cpbPj/ad3ameQ/Ev9oK8dNtjJ7p4UZ36y+BVPEfcOBQ/13Jt+0j8hFyVGrj/dgMSm8EynOzbd9Av07dfMWN5BMjYona587Md4xim/HDM+mXVr7ALVARifw3FLPW+UyEzPFOtI3up3vTvk30=
Received: from DM6PR11MB3082.namprd11.prod.outlook.com (2603:10b6:5:6b::19) by
 DM5PR11MB1548.namprd11.prod.outlook.com (2603:10b6:4:c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Thu, 16 Jul 2020 17:56:17 +0000
Received: from DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::cf1:ea8d:b9f2:5238]) by DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::cf1:ea8d:b9f2:5238%5]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:56:17 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <mirq-linux@rere.qmqm.pl>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <songjun.wu@atmel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH RESEND 2/3] usb: gadget: udc: atmel: fix uninitialized
 read in debug printk
Thread-Topic: [PATCH RESEND 2/3] usb: gadget: udc: atmel: fix uninitialized
 read in debug printk
Thread-Index: AQHWVVJJ7PBXO+opJEOajBCCvmHl7KkJN/mAgAFSMgA=
Date:   Thu, 16 Jul 2020 17:56:17 +0000
Message-ID: <38c65e57-628e-f497-9538-50f6f5a9df04@microchip.com>
References: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
 <248e7089f7fbb3727e83a1dfb43820d96a69e8c2.1594231056.git.mirq-linux@rere.qmqm.pl>
 <20200715214551.GF23553@piout.net>
In-Reply-To: <20200715214551.GF23553@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2a02:2f01:5d1d:6d00:8053:86f0:6820:9e8f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fcac46c-f91f-42cd-9ce9-08d829b18a4b
x-ms-traffictypediagnostic: DM5PR11MB1548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1548B636FBA03E93FD685806EF7F0@DM5PR11MB1548.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:179;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQxV8tCQFpgvJGy6QXSjaAl/dPVkj7kndI8BkNVdMp/nYtU/Zo7fQyqz/+kBh8ZVHJVhz2ZXiSuRpi7Q7ztR+FmGI0qR4qvAA5yg7ZJHxkItVvJSntjxbvsT/vWEIykwoEGKau0x4nxNy0jqt02Aul75qcyHt2Si2zVr/IesGbwux2sqJ2hsyn8kymMzxBTQXzbK5JMNb0vNmjlzqwBQoLU/pXBHx2/2Ist6bKffL8OVGiPRseLOfaS/X8TA0CUht4xOViAE6LtWIxXrp2BBLPw2c3p36yzSXkSPb0NvqguATt+H7N0uFIvY/PKd5u0doBHzRwwDlnq5p7qMl+B1YROJ5OE9Cc3G6q58zyx//FItxAsTkj6DZz/dbZ5khLH2hy/6uJsArYcsQ3TLgvkcj22thKSUUt+LB/zyegrLCtMva5t+MDMB3XbfRgBG/u9/jYk44V10U4imVG4SPQRf8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(346002)(366004)(376002)(66446008)(5660300002)(64756008)(110136005)(6512007)(186003)(8676002)(66946007)(4326008)(66476007)(8936002)(54906003)(91956017)(66556008)(316002)(31686004)(71200400001)(76116006)(83380400001)(36756003)(86362001)(31696002)(966005)(6506007)(6486002)(53546011)(2616005)(478600001)(2906002)(66574015)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iucvUz3m9NGKGitaCJeqjZRK/i/PCsiu1H/59nRLATX2a/3Mgw4ePQbbjUWx9bJ1FxibtUYQPVusSCeGpO6+EpDntH0NLYiTfUGdUUvlroKQ52sAL5Vez2tZIM38YNSh8LPFANmYfJxX9/ArCi23zOGcBeNw/8rd3AUq8LKsZWxdlPtzzefejVjPLAJIo5+E1ilkcwP8t5fg3Q7ETUOJ/AX8rs4mdvbfrk/52YlniOUy9ct3foUETkBZaK+Am+p41aFnhkqB1GL/a1eB21mpPsAJOXIH/1V6mHox+rD6UPcJVf/jqQoZ5ZIolVk0nCQtaaSfNV/PT9QpppM2hJGSiMkig1Y4nHttBKMpPpY7z3fTS2L6Tz/8kr7yXd34LaTsskZSBjfhzXpIQlpPOtHzAtU2p84OCfERHy+jmnFru+vSFzKdzXssoJ688qqBgcmTmyjs3XfPET+uLv8agTwue2tglW85GZQPK98DBCdmLS379c7qqigsRAMYuoYmL9jPQGuB+ctXVaK+wyMIdC86xjQcXGCXaHXalIJgRZXf+NroLuHibBdWq9ErClKQgasd
Content-Type: text/plain; charset="utf-8"
Content-ID: <778451F403692E44AFF3277D9627C68E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3082.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcac46c-f91f-42cd-9ce9-08d829b18a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 17:56:17.8227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4AdSGFMgiSEMuzqFNHm2c6rAIeJ2QwAsFkwNz2LmJd+9Ce6ynKGLGAWrDDs5iTBCAfYv1agHsjjjHzWfGu2QH34IVo21qcVJcXK7AtQguk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMTYvMjAgMTI6NDUgQU0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA4LzA3LzIwMjAgMjA6MDQ6
MDkrMDIwMCwgTWljaGHFgiBNaXJvc8WCYXcgd3JvdGU6DQo+PiBGaXhlZCBjb21taXQgbW92ZWQg
dGhlIGFzc2lnbm1lbnQgb2YgJ3JlcScsIGJ1dCBkaWQgbm90IHVwZGF0ZSBhDQo+PiByZWZlcmVu
Y2UgaW4gdGhlIERCRygpIGNhbGwuIFVzZSB0aGUgYXJndW1lbnQgYXMgaXQgd2FzIHJlbmFtZWQu
DQo+Pg0KPj4gRml4ZXM6IDVmYjY5NGY5NmU3YyAoInVzYjogZ2FkZ2V0OiB1ZGM6IGF0bWVsOiBm
aXggcG9zc2libGUgb29wcyB3aGVuIHVubG9hZGluZyBtb2R1bGUiKQ0KPj4gU2lnbmVkLW9mZi1i
eTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPg0KPiBBY2tlZC1i
eTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KDQpB
Y2tlZC1ieTogQ3Jpc3RpYW4gQmlyc2FuIDxjcmlzdGlhbi5iaXJzYW5AbWljcm9jaGlwLmNvbT4N
Cg0KPiANCj4+IC0tLQ0KPj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMu
YyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91c2Jh
X3VkYy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jDQo+PiBpbmRl
eCA5MTUzZTIyMDg0OGQuLjkzNDJhM2QyNDk2MyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNi
L2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9hdG1lbF91c2JhX3VkYy5jDQo+PiBAQCAtODY1LDcgKzg2NSw3IEBAIHN0YXRpYyBpbnQg
dXNiYV9lcF9kZXF1ZXVlKHN0cnVjdCB1c2JfZXAgKl9lcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpf
cmVxKQ0KPj4gICAgICAgdTMyIHN0YXR1czsNCj4+DQo+PiAgICAgICBEQkcoREJHX0dBREdFVCB8
IERCR19RVUVVRSwgImVwX2RlcXVldWU6ICVzLCByZXEgJXBcbiIsDQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgZXAtPmVwLm5hbWUsIHJlcSk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgZXAt
PmVwLm5hbWUsIF9yZXEpOw0KPj4NCj4+ICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ1ZGMtPmxv
Y2ssIGZsYWdzKTsNCj4+DQo+PiAtLQ0KPj4gMi4yMC4xDQo+Pg0KPiANCj4gLS0NCj4gQWxleGFu
ZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVl
cmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQo+IA0K
