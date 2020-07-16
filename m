Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5BCC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D50B2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JhgbGC+L";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SlnJvwDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgGPSBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:01:07 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12541 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPSBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594922465; x=1626458465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jOtBopjMkRhPIf8K6MVoHIecrJxaMFomtvCNWi4menk=;
  b=JhgbGC+Lm/2IgyG6ofQvCgKHmlWW1HaNZE0BEslqFjIdeN9frls9UP3l
   NY9fX6EMEusT+PPJpG2IdAEYVNWrOC0XXeTuP9nWE5DyCIWqBXQQaT7dO
   DncGcfMyl6yuUuSOt161KVVCWrdGn/NjTGclK+mBG2bIj3sSzreAexTQM
   lihvBu+YCF+zpG4dCxs1/wkwMjTTzQXvGXatyXq/AaMyUclEyRuuLmMEN
   eOtfUofUkWGxWrfn0W5Qy0rCMPK5Co2VhgrfovCg8HRZsIJ+U9hEr7Lsh
   eVQYmnwpCZ65eCNHd6S5Wv/BrJbemXwvXRe4vYDFlg7uMeJ68CIsCLEe6
   A==;
IronPort-SDR: 1r7y6gpVjfn7i+0j88XRQWiHNrYzo3t9sE5oOdn/A0mX+hRJiMmRdPipzZ30cj179ROCwBomIs
 BdePNlvpDp69l7/ck2ufiQ/qzo9GR+e3JccOh+gF2lzA/gdZG0i1tC4ufbis/ASdBBujfHiCAk
 HCmf1NhXltTmxQPSeg7VcwLskMwcYL9+zTFURpukneC5ja6z1xMDgsLfga+hb2qGgEDCTiFYiP
 esqvOp/DXKI6S7ZuUprSM8quYFkfol2cJCOQaM0Egvzbzk/g5iE/+wyXC4Zn1eeE/t8K9ZXt4A
 Mig=
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="87909449"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2020 11:01:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 11:00:29 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 16 Jul 2020 11:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gStqTvAvR79sW5+NWPq5yqEOOo+kIiHbAUAzz21jwXNprBmaAzN8WIgrWLofV3LqQW2tLPexNriDl8Bbi6obTjpK70sD3pRLqTxRioYrZLD3gIIo4CJvy2Slt/HQBHzkzynajJZpT6WQcM47C5/txV2YKa2rpKMHdfPx9uZ4QZqNS74SVgWW/u+gMD3d9N8kjrcNvWLfGMFupF+XeqGzYktalzfsvQFQs7YvJBvyp0CrM7q86qXGVHCNMrSrevBlfeEISLJWRJ2nk72VhBnwRe4L17xBrpahhK4MXZ71rrPOmIYIPsR07PvL+OLI9eQN0bS0EevUizfi6KKwlqnT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOtBopjMkRhPIf8K6MVoHIecrJxaMFomtvCNWi4menk=;
 b=hkiKNrl7uKV/ZprWy8ilxSho5zjoud1qU7ZoDFV6UlNGAfjFAY3mg63FJE5pFwAK9HNve0kbQmHfunFN+Wp9dCarpFiBNM2JGc42i/Hw2W1vJ1MMWvJ3NpeZUC2LvtluJjRVU5FSty7NiOejrzetTqHkdvrv9DpbDaRTa0twyYMfkUZ3WY5eGzDhyHIohXOO7ALblTPRLGLSq6d+vdCyxsEoP1mywwJG6bIzDhcgwPhUw8xb5JO9tYvkJW/sMKLxjUczs2yqz4ogXtnJ9e5tyHJDb5jB7j+mQKwkG8Oo6xheAkFsNlvIDxYQlQMIdB7+5oeN/4BpxKWHUbknKRl4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOtBopjMkRhPIf8K6MVoHIecrJxaMFomtvCNWi4menk=;
 b=SlnJvwDrwOEStk11umlLgtvDld/3AxoqcdhDqoahPqZcPNSLoelfAZpD5fnBUHmfCcS8F7RxUpb4qg6Z24f9HNXn7tUc05xgs2RqWUh+ezlz4EtJb8jDR8oMoqmBapgxqxSJkm7/d/MeTSvBN2LrPmtMJU+COZTa0cse7X/vE/o=
Received: from DM6PR11MB3082.namprd11.prod.outlook.com (2603:10b6:5:6b::19) by
 DM5PR11MB1548.namprd11.prod.outlook.com (2603:10b6:4:c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Thu, 16 Jul 2020 18:01:02 +0000
Received: from DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::cf1:ea8d:b9f2:5238]) by DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::cf1:ea8d:b9f2:5238%5]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 18:01:02 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <mirq-linux@rere.qmqm.pl>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <songjun.wu@atmel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH RESEND 3/3] usb: gadget: udc: atmel: implement .pullup
 callback
Thread-Topic: [PATCH RESEND 3/3] usb: gadget: udc: atmel: implement .pullup
 callback
Thread-Index: AQHWVVMXGcSXru1iCUeqHvj5SC+CZKkJO12AgAFQHwA=
Date:   Thu, 16 Jul 2020 18:01:02 +0000
Message-ID: <bec0cf9f-d937-c4fb-5073-5fc152be2417@microchip.com>
References: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
 <63121e624012996a2f6f5f3763270ad834667a12.1594231056.git.mirq-linux@rere.qmqm.pl>
 <20200715215801.GG23553@piout.net>
In-Reply-To: <20200715215801.GG23553@piout.net>
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
x-ms-office365-filtering-correlation-id: 40827d70-6846-4d0c-bf9e-08d829b2341b
x-ms-traffictypediagnostic: DM5PR11MB1548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1548E45B586604097BE6B884EF7F0@DM5PR11MB1548.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eyr/CR+jaxBj2bdqxfKDArn6aecvovPXbE2QGO0mWngbdeQs7fOVW/LWIEDIRlRTGVUCv6GtgvOe23PsFI3Y5JclYeJ79mZHMQDoaAeiAl/dPp9O7Jl+Fz/YFbIaeGQDKFFHS+XmWCv1gi13LzujO1zIdGEccgjJkf3yi33wI+kLVwFFbbVbHfanY31UlvJ/3OLHkuGPPR1Y5OCO5n03la592jcxYS5w4VvpKMbOExswpRJYVyG4JPb4qCC6GH5XCRDhveBb9EzIjAVAcvZe0/7SKT8Rp4K/1/tBpOrbkwZwif13+uaWJEgQHOYCVHV1q7UmR9PkQql9iSVFTEyU2gLBHBUAhNPBLjG9Vb0yNJgdvPcDNkkWp3K8pkmo5DngbQTp/AWinbjR3TmUefvvpkFeKSqA5F0/NC190T9JLxN7LzjkPCo6MTmoRkRyoZVldhKE0+Br0APLQol8zbmH1E4m1mMSDt79488EvyeRgDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(346002)(366004)(376002)(66446008)(5660300002)(64756008)(110136005)(6512007)(186003)(8676002)(66946007)(4326008)(66476007)(8936002)(54906003)(91956017)(66556008)(316002)(31686004)(71200400001)(76116006)(83380400001)(36756003)(86362001)(31696002)(966005)(6506007)(6486002)(53546011)(2616005)(478600001)(2906002)(66574015)(142923001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xmuaQQjW1Fn3yo1CgACv3anfzoS72u6H+a4CQAarRSbkmFuZmpJv/FCEYzL17BcdKZV5YvFU5EOUq9r5qTHDIvOn4wv01MKW28pU603XA4jFX2iafc4cmPv1yPS1oaLjLzgws1BBffmG1RcGnxtdmop2fZb+8xyWRSC7ZJSB5R7gsl5z9WavP5VcEbRVHVJQMa9aU2c3IuuFS/NR5UzPh/DodvnwJkM9Ge8BrwcQ+aWzt2+EyHBJUdFJnKzir/oWiQFTDSFXU67tx+OdGm/vVUwHfSdH4Gyn99MiY4rJdXsbNbCQXvJ0XHtFArBD3/RpexvLqgphiPTKXHtBA7GCmXpbaSWQTiuyNiXRLZ1OXcnOnWAoOomi3zn2HCrZTNYzsBTGk7O2MshbL9EZthDfXdhGV84mkMwFznCMj+a8vGubIExfQOX86uzSJPIA96OzuzWgd+eZj+lf7TavMv63p/LIZG5TXrCftTXyX94KD2JhpMjt/T7i040MO5v9rT8YagZil7+W7YXTbIxQqzFqCyIJrk3bWOi8CzLgfPZdbHMD5CUpviZZcDdqUcYpmDV2
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5673FC114B889439424046E39CDF5B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3082.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40827d70-6846-4d0c-bf9e-08d829b2341b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 18:01:02.6967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peomAk4rY6wJUQ5TM02ceAqpRhrQnIQhAtIqs6qxk0SXqyPDos7MvZeBv8T1PFb2v46LDR7p3szRbZoKN1RFuEdu1JogcZnAcuW5z/QehFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMTYvMjAgMTI6NTggQU0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiANCj4g
T24gMDgvMDcvMjAyMCAyMDowNDoxMCswMjAwLCBNaWNoYcWCIE1pcm9zxYJhdyB3cm90ZToNCj4+
IEltcGxlbWVudCB1ZGMtPnB1bGx1cCBjYWxsYmFjaywgc28gdGhhdCB1ZGNfY29ubmVjdC9kaXNj
b25uZWN0IHdvcmsuDQo+PiBUaGlzIGlzIG5lZWRlZCBmb3IgY29tcG9zaXRlIGdhZGdldCwgYXMg
aXQgYXNzdW1lcyB1ZGNfZGlzY29ubmVjdCgpDQo+PiBhY3R1YWxseSB3b3JrcyBhbmQgY2FsbHMg
aXRzIC0+ZGlzY29ubmVjdCBjYWxsYmFjay4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYcWC
IE1pcm9zxYJhdyA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+DQo+IEFja2VkLWJ5OiBBbGV4YW5k
cmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQoNCkFja2VkLWJ5OiBD
cmlzdGlhbiBCaXJzYW4gPGNyaXN0aWFuLmJpcnNhbkBtaWNyb2NoaXAuY29tPg0KDQpJIGNoZWNr
ZWQgdGhlIHBhdGNoIG9uIHNhbWE1ZDJfeHBsYWluZWQgYm9hcmQgYW5kIG1vbml0b3JlZCB0aGUg
dHJhZmZpYyB3aXRoIGEgc25pZmZlci4gRXZlcnl0aGluZyBsb29rcyBnb29kLg0KDQo+IA0KPj4g
LS0tDQo+PiAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jIHwgMjAgKysr
KysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRj
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRjLmMNCj4+IGluZGV4IDkz
NDJhM2QyNDk2My4uYzUxMjhjMjI5YzUyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2F0bWVsX3VzYmFfdWRjLmMNCj4+IEBAIC0xMDI4LDYgKzEwMjgsNyBAQCB1c2JhX3VkY19zZXRf
c2VsZnBvd2VyZWQoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwgaW50IGlzX3NlbGZwb3dlcmVk
KQ0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IGF0bWVsX3Vz
YmFfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsIGludCBpc19vbik7DQo+PiAgc3Rh
dGljIGludCBhdG1lbF91c2JhX3N0YXJ0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsDQo+PiAg
ICAgICAgICAgICAgIHN0cnVjdCB1c2JfZ2FkZ2V0X2RyaXZlciAqZHJpdmVyKTsNCj4+ICBzdGF0
aWMgaW50IGF0bWVsX3VzYmFfc3RvcChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KTsNCj4+IEBA
IC0xMTAxLDYgKzExMDIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9nYWRnZXRfb3BzIHVz
YmFfdWRjX29wcyA9IHsNCj4+ICAgICAgIC5nZXRfZnJhbWUgICAgICAgICAgICAgID0gdXNiYV91
ZGNfZ2V0X2ZyYW1lLA0KPj4gICAgICAgLndha2V1cCAgICAgICAgICAgICAgICAgPSB1c2JhX3Vk
Y193YWtldXAsDQo+PiAgICAgICAuc2V0X3NlbGZwb3dlcmVkICAgICAgICA9IHVzYmFfdWRjX3Nl
dF9zZWxmcG93ZXJlZCwNCj4+ICsgICAgIC5wdWxsdXAgICAgICAgICAgICAgICAgID0gYXRtZWxf
dXNiYV9wdWxsdXAsDQo+PiAgICAgICAudWRjX3N0YXJ0ICAgICAgICAgICAgICA9IGF0bWVsX3Vz
YmFfc3RhcnQsDQo+PiAgICAgICAudWRjX3N0b3AgICAgICAgICAgICAgICA9IGF0bWVsX3VzYmFf
c3RvcCwNCj4+ICAgICAgIC5tYXRjaF9lcCAgICAgICAgICAgICAgID0gYXRtZWxfdXNiYV9tYXRj
aF9lcCwNCj4+IEBAIC0xOTU3LDYgKzE5NTksMjQgQEAgc3RhdGljIGlycXJldHVybl90IHVzYmFf
dmJ1c19pcnFfdGhyZWFkKGludCBpcnEsIHZvaWQgKmRldmlkKQ0KPj4gICAgICAgcmV0dXJuIElS
UV9IQU5ETEVEOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGludCBhdG1lbF91c2JhX3B1bGx1cChz
dHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCBpbnQgaXNfb24pDQo+PiArew0KPj4gKyAgICAgc3Ry
dWN0IHVzYmFfdWRjICp1ZGMgPSBjb250YWluZXJfb2YoZ2FkZ2V0LCBzdHJ1Y3QgdXNiYV91ZGMs
IGdhZGdldCk7DQo+PiArICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4gKyAgICAgdTMyIGN0
cmw7DQo+PiArDQo+PiArICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmdWRjLT5sb2NrLCBmbGFncyk7
DQo+PiArICAgICBjdHJsID0gdXNiYV9yZWFkbCh1ZGMsIENUUkwpOw0KPj4gKyAgICAgaWYgKGlz
X29uKQ0KPj4gKyAgICAgICAgICAgICBjdHJsICY9IH5VU0JBX0RFVEFDSDsNCj4+ICsgICAgIGVs
c2UNCj4+ICsgICAgICAgICAgICAgY3RybCB8PSBVU0JBX0RFVEFDSDsNCj4+ICsgICAgIHVzYmFf
d3JpdGVsKHVkYywgQ1RSTCwgY3RybCk7DQo+PiArICAgICBzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZ1ZGMtPmxvY2ssIGZsYWdzKTsNCj4+ICsNCj4+ICsgICAgIHJldHVybiAwOw0KPj4gK30NCj4+
ICsNCj4+ICBzdGF0aWMgaW50IGF0bWVsX3VzYmFfc3RhcnQoc3RydWN0IHVzYl9nYWRnZXQgKmdh
ZGdldCwNCj4+ICAgICAgICAgICAgICAgc3RydWN0IHVzYl9nYWRnZXRfZHJpdmVyICpkcml2ZXIp
DQo+PiAgew0KPj4gLS0NCj4+IDIuMjAuMQ0KPj4NCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxs
b25pLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4g
aHR0cHM6Ly9ib290bGluLmNvbQ0KPiANCg==
