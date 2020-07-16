Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66198C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FB52070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Cw4Td7i9";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="IXkXMNQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgGPRzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:55:53 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24951 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594922150; x=1626458150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w4+oLkJntJW2BwFYrNn/5Zt8Ai5Pb0SFAM3p8/ZIyQ4=;
  b=Cw4Td7i9DPf5lngNtzsZ+Ka3239xY5DZGuhuLnoQooxarbHT2uDM9A2c
   HT+C9PC565FOsJ39gJyO82TejGvz4/lyauJF69LCW1uDpwCd20+SAWle3
   knqR0mvuiMz02QYUnD/kYsNRUD0c6STKevGwwkEV80QmU+t7Z4ApsYl8W
   GwfavAh/3aQyTvYQ3IKAy4rq+ZZaNP7+DmcNvx0tyG1LCiG04Pxb+lzQ2
   gdZgSD5iTrwHD2FzO93FbiVMYT0H2t1FsIEQYzOeV9s50jO/BwUboAL6L
   /sZgdXKdEOvI/mk3fqdlrP5u7A2kyLmr5VKdEPFNR6NrDIXwVbZvccayD
   Q==;
IronPort-SDR: UYhUZdzaowOv0iDDQniL1JB8Uzre8aosQqLwPTWa7j/naIl2JqW+q3X9qjz279iyqKGQMGaW0d
 rfCc7d4R195w/cDl3+wc5p9ABUh7xZ1vL1gJBhMn8Q6jWae+yTvfZS/DOauhb/6HxHSM7L6Jr0
 zXtRB3Qa0E4ZJ3aOogBxy4l4x0YPN0z75eqyomsS2jJyOmAQkENSsuEj5Ik/o96H5krXY7Knh/
 6urKGu17MG6IbB6nBXJZfh8wjp6hEaMN+auMYmctnLW0KKqHkEHbqZ0wdYVMexxabhjDyfKRwp
 psE=
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="83470496"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2020 10:55:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 10:55:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 16 Jul 2020 10:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+n9pp5/hlyLaF7bK9s+iIZvjb5Ow76pVkNx5FhJb/k3ePkpX/pzqew9GtydN5V+QlflPIO3ZD0ohQUz7vXU6YbvRaTyN8mZzWOto4oArvs8X1GO4INhwrtJPdX3Mzxr1bCurfPr3UMHmEd3ogFrGFHnmaieqBMBLpyE8IgHvPMGr7JU5qpPeIIQBH1Cu5kDiz8OSKkeNjpRkyD2HcSI2u8xL8R5zyM6fXIp+oOxkBAz0NmoW4PAMoCdQI/eo5KivljL3GJFNLHbd+Xgnnj1CvZlgMY/EMuzde/qvHC6lAJUQhzWJYEnsEh505xtLy9OQjeIRvb8PfJUVs3WX/shhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4+oLkJntJW2BwFYrNn/5Zt8Ai5Pb0SFAM3p8/ZIyQ4=;
 b=IWP5UNtJqp40qUsDMaOcUMONaFqOwqgMKZrsZGm4TsfKDWpcbFRTieFfvMObvFolgXuzCekdB8DDRF4hSezSXt4ISuBGM8AIIhnfdIpeYMClLOZYQJUbpaDk3qnOIFlHrTZrFEnA4dWi3BWHg0ZGz269hlf3E/AfSwLFcgqXu2udCNr2Dg/OIha1pLipkDIC4ofeKV5eDfN52WjmdJGyhENzdnNdFcXpp4qMj6aabgdVqQ1V4I/9RjGajAWgmlh+ZZTvHkDB+FxcoRYO/mlaDRCXkCp1ZPzhq0o2xdyJkIgabwYSYaC0INIZSmXqfjzaz4G2QNbdDlVN6X9PuS7aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4+oLkJntJW2BwFYrNn/5Zt8Ai5Pb0SFAM3p8/ZIyQ4=;
 b=IXkXMNQkFbIh5POktXec180Qzpn5vIga94RhswRi1crZ17J+23Sd9iJm7jNKxOTRCIpLYN/6f8i+YsCCXhEFqvoPgeheZikg/cit9AQTdkhQEtnmDaamF3uLUqjHa/DWThTnmbEA0+kZDlPQarmGuGyZMui2OH9LWTU5nAVeYcs=
Received: from DM6PR11MB3082.namprd11.prod.outlook.com (2603:10b6:5:6b::19) by
 DM6PR11MB3002.namprd11.prod.outlook.com (2603:10b6:5:6d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Thu, 16 Jul 2020 17:55:47 +0000
Received: from DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::cf1:ea8d:b9f2:5238]) by DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::cf1:ea8d:b9f2:5238%5]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:55:47 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <mirq-linux@rere.qmqm.pl>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <songjun.wu@atmel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/3] usb: gadget: udc: atmel: remove outdated
 comment in usba_ep_disable()
Thread-Topic: [PATCH RESEND 1/3] usb: gadget: udc: atmel: remove outdated
 comment in usba_ep_disable()
Thread-Index: AQHWVVJNzw5hS4rB3kS1Tqr/60tonKkJN6IAgAFSZIA=
Date:   Thu, 16 Jul 2020 17:55:47 +0000
Message-ID: <9616d73d-d55c-1a33-58a0-6f36ba949f1c@microchip.com>
References: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
 <ab8ef3e2bf15fa75572f9ad51d6e7b10c67cb494.1594231056.git.mirq-linux@rere.qmqm.pl>
 <20200715214438.GE23553@piout.net>
In-Reply-To: <20200715214438.GE23553@piout.net>
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
x-ms-office365-filtering-correlation-id: ad94c631-e513-4282-7397-08d829b17854
x-ms-traffictypediagnostic: DM6PR11MB3002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3002F5F36B2AF11B5AAE8654EF7F0@DM6PR11MB3002.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sP72AAjkaBDwewaEYwN5Kn1PJ/5GaozKrP3amGO9BK/vaGOQ/kYplFwSz/TEjH3nGNPfuKdVWZJu8o6tNUD7Hve5zxEVUpplcWkpjXvGRJuI3lebMFeqvuFpyPw19gwDmPqaWOnjR71+H/us2fGWGiOF5oAI52GSKPuVjf5BsI+wdqdIKnBhfHX2pMf0FCMvyWdvj3sMb8Yc3AVwTEGp5hLreZhJzMYnATCOm8kU18Mjd77pH1qUm2PNlOLg+VGd4UmeMVYCUVeRqNG7HAhuCec9vEUqR6BDovKs8/+d08gwz/Inct5OibOO7bEI9+ZQwhDxxYUX2fihkDTI2QuDB+/ddTaqf+6w9Z7iEQApygno1VuYJDYJ6zzWdJriQX2cQQ3jbAqaJ8SwaSiAM3bVX8xFU1nzZn/Xv3NSosHVZi7h0cpwXb24dbEA52rorvdQjQf0Shp+gLSGyf7kcg4ICg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(376002)(39860400002)(346002)(110136005)(36756003)(31686004)(316002)(76116006)(54906003)(83380400001)(91956017)(71200400001)(2616005)(66946007)(31696002)(6512007)(66476007)(966005)(66556008)(66446008)(2906002)(6486002)(8936002)(478600001)(5660300002)(4326008)(66574015)(64756008)(186003)(53546011)(86362001)(6506007)(8676002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lwVo8BjZKZji357cvRaMF3IwsNdBlZyotk/5sflUE7vB2IN/X4k9/Ujv/owmgF9X0uELIWxJ+BG15+WsbYh/Ee8NIJsL8rUEsuxov0nocIQEgOn8g1kZHh719YC4OL2hwrzlFy9ZlKQq1DIyra60L1YkmxanILNqbNIQq+bMv4jgEQ3pk82sHh+xoNlS+S6WWZsoPoEkRRkNezEVp+hIw/sY4WLVGtmmb1eI0Tc0jrovkLrGTOD1dLHAQJKspc5l9vfT1SEPZrSebKXrn+DiAwQQzLsDmq/wmJ3eNWMgq+0CB7akLrdHu1nCex5Vmp96VjJgNp9nEwgbyssS29bp/FKv/shHexzkjHhtRUi+ixO5oRXK2KZz0U2EiCcfmXyrOqpofybuKFWJVdO5iNLoqUQo0wJYOMAzgRaZKeMVD4QZHDG5Xlcn7t7PcGi+zdj8Kk4xi1YuCPOanukKfhUlTIo+sCvO5lylvYReO2aOMezNFUT6maekh3nSI6S8buFXp8hkrgnJsAzPp/Wy9KjLCkFiNtZYyyzmlp+0VSKTn5Xs35epQLJmOVNwhLKL1cv8
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C19C15F629EE14EAAEE3F4CCADFE71B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3082.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad94c631-e513-4282-7397-08d829b17854
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 17:55:47.6846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pXQJoVwBkieB5zC4Vb0eFxKnQ7GP5TQsqnVUic+cZVmv0cAWddCBUE5xg9wjwMAswbzakcdx7EGQtLF1MGzoKI0Rcf8dnn3MScSO0Y5k7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMTYvMjAgMTI6NDQgQU0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiANCj4g
T24gMDgvMDcvMjAyMCAyMDowNDowOSswMjAwLCBNaWNoYcWCIE1pcm9zxYJhdyB3cm90ZToNCj4+
IEZpeGVkIGNvbW1pdCByZW1vdmVkIHRoZSBvZmZlbmRpbmcgYmVoYXZpb3VyIGZyb20gdGhlIGRy
aXZlciwgYnV0IG1pc3NlZA0KPj4gdGhlIGNvbW1lbnQgYW5kIGFzc29jaWF0ZWQgdGVzdC4gUmVt
b3ZlIHRoZW0gbm93Lg0KPj4NCj4+IEZpeGVzOiAzOGU1ODk4NmU2ZmMgKCJ1c2I6IGdhZGdldDog
dWRjOiBhdG1lbDogZG9uJ3QgZGlzYWJsZSBlbnBkb2ludHMgd2UgZG9uJ3Qgb3duIikNCj4+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4N
Cj4gQWNrZWQtYnk6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGlu
LmNvbT4NCg0KQWNrZWQtYnk6IENyaXN0aWFuIEJpcnNhbiA8Y3Jpc3RpYW4uYmlyc2FuQG1pY3Jv
Y2hpcC5jb20+DQoNCj4gDQo+PiAtLS0NCj4+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVs
X3VzYmFfdWRjLmMgfCA4ICstLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2F0bWVsX3VzYmFfdWRjLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3Vz
YmFfdWRjLmMNCj4+IGluZGV4IGQ2OWY2MWZmMDE4MS4uOTE1M2UyMjA4NDhkIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jDQo+PiArKysgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRjLmMNCj4+IEBAIC02NzYsMTMgKzY3
Niw3IEBAIHN0YXRpYyBpbnQgdXNiYV9lcF9kaXNhYmxlKHN0cnVjdCB1c2JfZXAgKl9lcCkNCj4+
DQo+PiAgICAgICBpZiAoIWVwLT5lcC5kZXNjKSB7DQo+PiAgICAgICAgICAgICAgIHNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJnVkYy0+bG9jaywgZmxhZ3MpOw0KPj4gLSAgICAgICAgICAgICAvKiBS
RVZJU0lUIGJlY2F1c2UgdGhpcyBkcml2ZXIgZGlzYWJsZXMgZW5kcG9pbnRzIGluDQo+PiAtICAg
ICAgICAgICAgICAqIHJlc2V0X2FsbF9lbmRwb2ludHMoKSBiZWZvcmUgY2FsbGluZyBkaXNjb25u
ZWN0KCksDQo+PiAtICAgICAgICAgICAgICAqIG1vc3QgZ2FkZ2V0IGRyaXZlcnMgd291bGQgdHJp
Z2dlciB0aGlzIG5vbi1lcnJvciAuLi4NCj4+IC0gICAgICAgICAgICAgICovDQo+PiAtICAgICAg
ICAgICAgIGlmICh1ZGMtPmdhZGdldC5zcGVlZCAhPSBVU0JfU1BFRURfVU5LTk9XTikNCj4+IC0g
ICAgICAgICAgICAgICAgICAgICBEQkcoREJHX0VSUiwgImVwX2Rpc2FibGU6ICVzIG5vdCBlbmFi
bGVkXG4iLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcC0+ZXAu
bmFtZSk7DQo+PiArICAgICAgICAgICAgIERCRyhEQkdfRVJSLCAiZXBfZGlzYWJsZTogJXMgbm90
IGVuYWJsZWRcbiIsIGVwLT5lcC5uYW1lKTsNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+PiAgICAgICB9DQo+PiAgICAgICBlcC0+ZXAuZGVzYyA9IE5VTEw7DQo+PiAtLQ0KPj4g
Mi4yMC4xDQo+Pg0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4gRW1i
ZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29t
DQo+IA0K
