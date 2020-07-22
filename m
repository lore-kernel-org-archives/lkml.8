Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1E5C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6AA20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r/2wK72k";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vVWs0j1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbgGVOno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:43:44 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:19628 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgGVOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595429023; x=1626965023;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=HMgRTes1zXbIMns3lebCO3moFgt4xL2XENw+fth3zlU=;
  b=r/2wK72kwux2w9UgPTTekQ5TGadth2KyU0uwXMe2SzrMVKanuMLNqi48
   3i63Dh9WEwXB9mT3IM6Ijs5MHL1LayvfLGsJDvzNwnSUvwTUqBzjxqsBV
   Ltm6p1aVrKUAu2KHxYRh4ch7e0BLcdnwydNSbEwZGLKDyvl7q/9P8IcPV
   qqQIph8PWpio3xTixzZ6PSO6BzXfCrLwFzK4uQN3M3vmP1oIFxAoltRt2
   4NPWLtsk3amPP0FuBqzBttq14RV6ipDJdOdT/prSdm55/doGbKrNmC1/7
   +VFpj2WWFhspnOhoJJgHjJVlVS3QgfzbrR5PrXqmgBhpf4pgY3pJmeg7T
   A==;
IronPort-SDR: v75nD4lGlKOWt/mbgfiZa0ZrBtLhgDac+cHPci49ZzSIs5chAF8lxRM6AL0lT03gQuCFweNol3
 ueWSgzS0JbYJVe+pG77seZruL3vbjp/iv3c6gpaNagSG59nqZ4QAjE0tzxfJM3JZQcR9TH3D51
 qpJ1uQs3dPHBVaboku2/Dgrek0BGwyeAgWjGPFNTkj2h7nvHcd7hdQss8JNVUXabVb4r1oTOmX
 LUnqauVGsVXqO84U5DhrpjbkQDFcWk0qfnG/gPCc1fmIfCS4wtSFoRqg+lp4CuCq41SaS3YiP3
 fSs=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="88674241"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 07:43:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 07:43:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 22 Jul 2020 07:43:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGv9VqQPu1MwweOeikgWzV93dupMxFZ+RQL3quxnFrZQ76h8PP/xYVMSYbMoZD5WkLzW+pXE5DWAqeBbLCDIiR3Uwoue9ZETu8Rz2mnCzscb7QY3SS42IfciJQetwgtdMxft6bucEDpSpfFRrZNuNV3zi1M8PzcYVR6JB8EiXZjBoF2NyQzd8Ju6Nbsi4HaoxGrZlQqP6RCTc4ifV6T6v2UrUzSq1ra9EcvFJJCj51ygjNOz9RJ9gzPamsO5Arw4nBZ3ML/iTub4kwnQjYlVkPXlcYTlgroXlxLPCLlt8czrihUzcAho0QERKRgM5GkTHbRMKHnofZRprnG2m/1RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMgRTes1zXbIMns3lebCO3moFgt4xL2XENw+fth3zlU=;
 b=PvDONBlhBIXRGeqFcv77U2PtGloIZwKA0JFqwVm+UpqUCZFeE52Fgy+4v19V+h+dEaPOID9jHoMiPYWVPPYuCtkU7waDoxcBu/q/gS+H+Y3i2s4Nrn2/MfJnTs5GbklOk6Xk7TtqNxSWH5onRxA0H2NXZ/ZvefNoDLwumZWRYPmku+d5tBDR4vdd431t7KjBID9G/xOVPt43Q9viasbXBc6aBHwM1Mc0C846gqiuQNIwlGDMaTSJwbyOkNxrIMw2W1fV42HMrVreXNGzWvjDo0zOgAsXJY2+ScrwyndFIFDQduzfPu+LjBHEnLlhSkJMlXEI0kKclGu2kGRT3nnPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMgRTes1zXbIMns3lebCO3moFgt4xL2XENw+fth3zlU=;
 b=vVWs0j1qV7+mvFvcZMlZNy1SnlbR2hKRg++cPrRruf+uYMMllp9Dv8/OpaFhoL6xTGeGyPusb91DOn7+/Us8QAa9bN7O0fhXaxobcckRLqmPTB6VX0uGVrOuaPEx67Hy0pFt6HPemJtjEieU1edgun2T6p8jPxclTSqvL7XO+nk=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20; Wed, 22 Jul 2020 14:43:39 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 14:43:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Cristian.Birsan@microchip.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] usb: gadget: udc: atmel: use
 of_find_matching_node_and_match
Thread-Topic: [PATCH v3 1/6] usb: gadget: udc: atmel: use
 of_find_matching_node_and_match
Thread-Index: AQHWYDZ7vQs+wibSwkmzkBgy4Ym1sQ==
Date:   Wed, 22 Jul 2020 14:43:39 +0000
Message-ID: <9cf8e546-09ce-d902-6dca-e2490fd8c4ae@microchip.com>
References: <20200722134421.190741-1-cristian.birsan@microchip.com>
 <20200722134421.190741-2-cristian.birsan@microchip.com>
In-Reply-To: <20200722134421.190741-2-cristian.birsan@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.76.227.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbb9c1dc-c9b8-4b51-7c66-08d82e4d9f4e
x-ms-traffictypediagnostic: DM6PR11MB4074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB40749760AE40AED7F2822DD587790@DM6PR11MB4074.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f7+d2+wkku5bOj59wBuWSWhNl2diXg6V+s1iH1//AedhgylLNow73jfRNLCJ/Y6R2CVNuDAfiUjED1AftX6tjm3KI63NILxtaKu0LqGI1ly/ex+RvoKnVRBMqb3yud0TPWT4rVXYEem6g30EACsns7szpPQlX6vAMNeCKx/i1f8VZOXOM65T4gTd2M7n7G+N3eliE5G1CW0cmGg+jm5ULfwqXs3i9Cd+Lnmkz0tU8tJW0C9P6Of98eUihUG+wg+eB6/oHQWu4u/lRhs7mSkoE1wWLyaTZ85xs4Vl2DYY/P5WPdynnA5rM1uTo9vZm3nHWTOjKdQlcHJCPfdVClnOsrrn7Q1+huLQ9TgjUPelg2aWwZhCDNtBH0XrSqR7t/7BzXggXk89P+9aMkxm05C/fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(76116006)(91956017)(110136005)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(2906002)(6512007)(31686004)(6486002)(478600001)(5660300002)(186003)(31696002)(71200400001)(36756003)(83380400001)(2616005)(53546011)(86362001)(26005)(8936002)(6506007)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: j+cWuTnYT/YY5xphlE7Nn4J3uLegpsJEabhNqprh8dIZF6U7y2FMM3/5UYR8y8Pi+hew4MOE3dUSdcFP4BAb99f+fkr6xnX8IUTWLTZ/oUWt6L1ufdMu1xFruazqXks25bRAQwBjV4dVS+N79GDzkXyxORlpgSe91Vpj3emjnfj/e1w4IPG8hdC2B1oM9+pcqsWcRm+/qFQN6DPfbeK16k7E+J7GkYucLAjegZi/i6yrHsm0PY3kQcWVllANNcU7rfbJsE/mVJN1Spb4BzfrROB8hcdDnQRz8GESpJIcjGUwVOQoG3MDfPe6vXkBuPdWhTAE1yKUeqVuQuyBFhdceuNFtIdy97o3wJQVkLXBcWZH/B5NFF3i2TjS+3jda/kcPNT932JTAhDepcS0cNaeM9xlm37NPEJhpO9hHXFFRq6eB+UUQyixF5F2JhD/AwwhoXQdLgZFpIUa6HTbVuhfPqhy0MZRyF4OFNryYDITvfo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C4466A49ED4D646B291092A4D8587D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb9c1dc-c9b8-4b51-7c66-08d82e4d9f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 14:43:39.1296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmqdfWQFrTdo4cxNO87dlfHFuzs+ZpCV9cTlDA+RPrD2xEwiYu2oBE8/A8xt244eOpvZM4NVeXiRvR8o9DG5L/jtHqSDkKqDSzBsgQiTe84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIyLjA3LjIwMjAgMTY6NDQsIGNyaXN0aWFuLmJpcnNhbkBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCj4gDQo+IEluc3RlYWQgb2YgdHJ5aW5nIHRvIG1hdGNoIGV2ZXJ5IHBvc3NpYmxlIGNvbXBh
dGlibGUgdXNlDQo+IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9hbmRfbWF0Y2goKSBhbmQgcGFzcyB0
aGUgY29tcGF0aWJsZSBhcnJheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVh
IDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYyB8IDI1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYyBi
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYw0KPiBpbmRleCBjNTEyOGMy
MjljNTIuLmVlMmI1NTBhYTQwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9hdG1lbF91c2JhX3VkYy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxf
dXNiYV91ZGMuYw0KPiBAQCAtMjExMiw2ICsyMTEyLDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIGF0bWVsX3VkY19kdF9pZHNbXSA9IHsNCj4gIA0KPiAgTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgYXRtZWxfdWRjX2R0X2lkcyk7DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIGF0bWVsX3BtY19kdF9pZHNbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxl
ID0gImF0bWVsLGF0OTFzYW05ZzQ1LXBtYyIgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gImF0bWVs
LGF0OTFzYW05cmwtcG1jIiB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4
NS1wbWMiIH0sDQo+ICsJeyAvKiBzZW50aW5lbCAqLyB9DQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMg
c3RydWN0IHVzYmFfZXAgKiBhdG1lbF91ZGNfb2ZfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2LA0KPiAgCQkJCQkJICAgIHN0cnVjdCB1c2JhX3VkYyAqdWRjKQ0KPiAgew0KPiBAQCAt
MjEyOCwxMyArMjEzNSwxNyBAQCBzdGF0aWMgc3RydWN0IHVzYmFfZXAgKiBhdG1lbF91ZGNfb2Zf
aW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgDQo+ICAJdWRjX2NvbmZpZyA9
IG1hdGNoLT5kYXRhOw0KPiAgCXVkYy0+ZXJyYXRhID0gdWRjX2NvbmZpZy0+ZXJyYXRhOw0KPiAt
CXVkYy0+cG1jID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZSgiYXRtZWwsYXQ5
MXNhbTlnNDUtcG1jIik7DQo+IC0JaWYgKElTX0VSUih1ZGMtPnBtYykpDQo+IC0JCXVkYy0+cG1j
ID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZSgiYXRtZWwsYXQ5MXNhbTlybC1w
bWMiKTsNCj4gLQlpZiAoSVNfRVJSKHVkYy0+cG1jKSkNCj4gLQkJdWRjLT5wbWMgPSBzeXNjb25f
cmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKCJhdG1lbCxhdDkxc2FtOXg1LXBtYyIpOw0KPiAt
CWlmICh1ZGMtPmVycmF0YSAmJiBJU19FUlIodWRjLT5wbWMpKQ0KPiAtCQlyZXR1cm4gRVJSX0NB
U1QodWRjLT5wbWMpOw0KPiArCWlmICh1ZGMtPmVycmF0YSkgew0KPiArCQlwcCA9IG9mX2ZpbmRf
bWF0Y2hpbmdfbm9kZV9hbmRfbWF0Y2goTlVMTCwgYXRtZWxfcG1jX2R0X2lkcywNCj4gKwkJCQkJ
CSAgICAgTlVMTCk7DQo+ICsJCWlmICghcHApDQo+ICsJCQlyZXR1cm4gRVJSX1BUUigtRU5PREVW
KTsNCj4gKw0KPiArCQl1ZGMtPnBtYyA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChwcCk7DQo+ICsJ
CW9mX25vZGVfcHV0KHBwKTsNCj4gKwkJaWYgKElTX0VSUih1ZGMtPnBtYykpDQo+ICsJCQlyZXR1
cm4gRVJSX0NBU1QodWRjLT5wbWMpOw0KPiArCX0NCg0KVGhpcyBzZWVtcyBhIGJpdCBub3Qgc2lt
aWxhci4gSSBtYXkgaGFkIGJlZW4gd3JvbmcgYXQgdGhlIG1vbWVudCBJIHdyb3RlDQp0aGlzIHBh
dGNoLiBQcm9iYWJseSB0aGUgYmVzdCB3b3VsZCBiZToNCg0KKwl1ZGMtPnBtYyA9IEVSUl9QVFIo
LUVOT0RFVik7DQorCXBwID0gb2ZfZmluZF9tYXRjaGluZ19ub2RlX2FuZF9tYXRjaChOVUxMLCBh
dG1lbF9wbWNfZHRfaWRzLA0KKwkJCQkJICAgICBOVUxMKTsNCisJaWYgKHBwKSB7DQorCQl1ZGMt
PnBtYyA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChwcCk7DQorCQlvZl9ub2RlX3B1dChwcCk7DQor
CX0NCisNCisJaWYgKCghcHAgfHwgSVNfRVJSKHVkYy0+cG1jKSkgJiYgdWRjLT5lcnJhdGEpDQor
CQlyZXR1cm4gRVJSX0NBU1QodWRjLT5wbWMpOw0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5l
YQ0KDQo+ICANCj4gIAl1ZGMtPm51bV9lcCA9IDA7DQo+ICANCj4g
