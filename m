Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB69C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BED20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RI/UL489";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hjP8J8TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbgGVO2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:28:33 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:1787 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGVO2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595428113; x=1626964113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2d4P2rmN5yKyPy94hnKpeX0+h9MooSdNJAghy8ZCARI=;
  b=RI/UL489MTiJ9shJLZyX41UfA3C7VdPU9gUtvozqrcBMiHSiVvs8HYVu
   AKyYiVuBkVKU7Z+zLRBy0/wSiDN/N+NXSCGxNV6jyerZIM66EDNX2/vmK
   nAzZmmjXDTMkVamJIiondQPLTTf8Rh6cSQ2nhUtsPbwgLoYoKwr9/2i+B
   r1+US0IWBQdVOY/4QMFk5gM4oDO8OMI6NkNsanKg4Bfv61L1AyyQhrt4a
   bRxbLLKCslTE+tyDntxQjxxE2S6Y6j4z1Hc70AkCoNTH1/TOdyVSezsMk
   +P+dwjRL+mfvp1/X+T0cfV+HqKuk1561uHolEq04ASN+V4xbCCMVs+6ik
   w==;
IronPort-SDR: HAFnD9Iw4CCpxdvhphRDMIMnMK1PlC5V9FJm1rdcXvnxcjCYnSlygO9xadtJ+48Fi/CdtwyFH6
 GN38r3n4sipqllQO8rfQ+tBjB/OHrPrxL7W+BbUAyev//wUUERWjd0yvsXMCC9nJLA48nI+pJX
 u9VIUDCdfPBMsEVgiCRlqHdOzEJCoecRJL79FjUGinKDCKRSd9ScEFrB1UteavjGasiLUNFc5j
 fkTiRmnR2Ska+8+wd9dS7LSYILSc1pyPMtayVR5W27OMjfaPC4QsyLd572HC/Ua3GdmzDcdspZ
 E/0=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="84204445"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 07:28:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 07:28:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 22 Jul 2020 07:27:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK34OduzZosxbc7BMA2SPo2nXHsMNth4zQzSwy+CLl5TpNTn9QlHRHZ8/LwXmO2jGq+McztjvJML/pxsEn0RTCRwZSPJdg3eUAdOKOgL7GLGSGuOGBOIDRg7uEvfLTmqkVJ3j3SaLMLxZVi/y34tVsCwekDxIxkSPl8e1CJGAKEsIagDVp5i4cJRqubqeIq6Ldjj4XSQCnzPQV1eT6GTnw7oscI+lQcJbQtPC59R7NLuZAMiVhVLBWXInfJxGW6f5keflFQGX2ONVLOFKGmT1OVO5xhC4Vmv5FCGGkUpQGyWdJpE076xbz3EJCITKjIApZlzQlN+Qjwm/PEZH2PRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d4P2rmN5yKyPy94hnKpeX0+h9MooSdNJAghy8ZCARI=;
 b=COV9ZSl+SnuIlrEnR/urUSKQczwSrLACzIPtOHhqkI8Y807bc/p/Yiy3QwH8veKyaphtSe8AI/Ytdx0C1euY0bxd8DBIM6N/uCvxuvl/DNKQpBtOuBlH0yOwpf4SCh2JaKTGJVlBQudnDkdUF7fMsCjnzjONltNA72eFTI12YmzxK/aGfnmXzhcIrBdftJlhMcfU4Bw1JPxsJn57AjNh6TSbX3br/Eg6hQapK6Kl/50aEvG14NeTrYT6ga51eOq2FpvocZ2D1FcRO9vHV6GQlOs2PaCPsiKBINyUEFKqIxQIr0+TYdyeaNg2rxil8fKPU+q4dig6TccHatTp4jemcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d4P2rmN5yKyPy94hnKpeX0+h9MooSdNJAghy8ZCARI=;
 b=hjP8J8TVwTqnGxHwHm+1Haolp8BmNUNI75QWyIgFKVI4oZPPsbCAJw80ax+s4ZC3oXfIQAm7bXURu2gSxJbQY/gKF/aJf0BgVJjTT8iuKrUVhKCHb7iZhnamwNm7U5TR8zzqZYllAszdYZl6U1m8LGO7+EZINyB8SaZN6oTP6fU=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3079.namprd11.prod.outlook.com (2603:10b6:a03:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 14:28:30 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::7424:cb9d:3c63:5181]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::7424:cb9d:3c63:5181%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 14:28:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexander.sverdlin@nokia.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <mika.westerberg@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <ibr@ilbers.de>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
Thread-Topic: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
Thread-Index: AQHWYDReSXNx4qFwZkKE6j6AE/Ov3Q==
Date:   Wed, 22 Jul 2020 14:28:30 +0000
Message-ID: <b5c17892-24ec-a690-96ca-d2238b8925d1@microchip.com>
References: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
In-Reply-To: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edad1c83-365e-43d7-9676-08d82e4b819c
x-ms-traffictypediagnostic: BYAPR11MB3079:
x-microsoft-antispam-prvs: <BYAPR11MB3079A7D0004E7E8CAE35A298F0790@BYAPR11MB3079.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7OzNVjnWEq5OQ3gEsna2rOYPCOjoyCl+B7AhGeVSNdH9gOr8GjzAx5qPQBKfrJbDEeo8Dc9gqhGunIOmzPZkCSL4Kb9fw+suXn0cPHgzFfDi3ZERtwO1EKgqvEUExYB+csHEMY4YW62WPcH+pqHugp3VnV/xulAxd4CpBIl6kKLKUY3Q//d/XeuVdM1NztfDfqV6z4D9vKg18erXI8spKoPSZ094Y4lK+vHEt661obFMF3jbJbvMUMoZyj6eQyKmJJH2+Zypf1FhymcfpckOLOMm5P5mBigZs2kfLpBrmAxU/8emM8eMSXP1YBBZJRIbmVShyyyWzYz0spyGpPA70LC0lkW5HcXyzam7h2KeMXg1aoumAtA9RsXUwrzixZY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(31696002)(76116006)(91956017)(36756003)(5660300002)(2616005)(8676002)(71200400001)(86362001)(186003)(2906002)(110136005)(54906003)(4326008)(53546011)(478600001)(296002)(316002)(6512007)(31686004)(66446008)(64756008)(66556008)(8936002)(26005)(66946007)(6486002)(66476007)(6506007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sOdzEW8iFpCZo1isjfFDJRWiVfYvJyXO5W3hOSwNWzB2i/Tlvj2K7Xm9aBOOKJoSWqA+O6zua+Jdx6zZDJwb3IXyLVC3iAYEEYpld6U0KfzE9XuB0sxOvwKqRkFSo6HKytv6tnPVNQ8KvvaUJiOulZKN5CTqAllntvqcGZVBBkM15DruZdC/awqgKaxObFD6/RQ0QOTSyr7f5kiyd/dgQjYD2Ycww2tLzhc1OPWPPoZofrsd1G7zm53OL5MX443pNQ5wXNKD0mZjwk77xTrUZagWU3zOqaG+I9sqweP4bHVyz2l7mW6jHk131oVFDoSnlerVMHWGkSVM/3wsymzYPhsB9yc8D4Pm05JeSkpRzeNjWZTkPBtEdFQZBQzAAIWWcwAl1vQ7133t1Nugb8SgAZQqZko35gxBbTj4unCbx3HTHLytuwlGybHLoKBdXMbXUr15W0PdHnJ0YPMIMOU6Oibi6SxjN8BzSevJBRyDOMw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <384A485FECB9F24993F0605FDF80C572@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edad1c83-365e-43d7-9676-08d82e4b819c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 14:28:30.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDlB8c62XkaLVolaMLb3QKowBKpNHqXpFw4R7z+WB8BIIFC6PK6xHrDFdtnYwu5VqB2hvsbuXmJEF8iHKFhpTt/XvymnR+MZgejrLoh2MO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBNaWthDQoNCkhpLCBNaWthLA0KDQpXb3VsZCB5b3UgcGxlYXNlIHJldmlldyB0aGUgcGF0Y2gg
ZnJvbSBiZWxvdz8NCg0KVGhhbmtzIQ0KDQpPbiA3LzIyLzIwIDU6MDEgUE0sIEFsZXhhbmRlciBT
dmVyZGxpbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0K
PiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBub2tpYS5jb20+
DQo+IA0KPiBBZnRlciBzcGlfbm9yX3dyaXRlX2Rpc2FibGUoKSByZXR1cm4gY29kZSBjaGVja3Mg
d2VyZSBpbnRyb2R1Y2VkIGluIHRoZQ0KPiBzcGktbm9yIGZyb250IGVuZCBpbnRlbC1zcGkgYmFj
a2VuZCBzdG9wcGVkIHRvIHdvcmsgYmVjYXVzZSBXUkRJIHdhcyBuZXZlcg0KPiBzdXBwb3J0ZWQg
YW5kIGFsd2F5cyBmYWlsZWQuDQo+IA0KPiBKdXN0IHByZXRlbmQgaXQgd2FzIHN1Y2Vzc2Z1bCBh
bmQgaWdub3JlIHRoZSBjb21tYW5kIGl0c2VsZi4gSFcgc2VxdWVuY2VyDQo+IHNoYWxsIGRvIHRo
ZSByaWdodCB0aGluZyBhdXRvbWF0aWNhbGx5LCB3aGlsZSB3aXRoIFNXIHNlcXVlbmNlciB3ZSBj
YW5ub3QNCj4gZG8gaXQgYW55d2F5LCBiZWNhdXNlIHRoZSBvbmx5IHRvb2wgd2UgaGFkIHdhcyBw
cmVvcGNvZGUgYW5kIGl0IG1ha2VzIG5vDQo+IHNlbnNlIGZvciBXUkRJLg0KPiANCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gRml4ZXM6IGJjZTY3OWU1YWUzYSAoIm10ZDogc3BpLW5v
cjogQ2hlY2sgZm9yIGVycm9ycyBhZnRlciBlYWNoIFJlZ2lzdGVyIE9wZXJhdGlvbiIpDQo+IFNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQG5va2lh
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNw
aS5jIHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3Bp
LmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNwaS5jDQo+IGluZGV4
IDYxZDJhMGEuLjEzNGIzNTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29u
dHJvbGxlcnMvaW50ZWwtc3BpLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9s
bGVycy9pbnRlbC1zcGkuYw0KPiBAQCAtNjEyLDYgKzYxMiwxNCBAQCBzdGF0aWMgaW50IGludGVs
X3NwaV93cml0ZV9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwgdTggb3Bjb2RlLCBjb25zdCB1OCAq
YnVmLA0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgICAgfQ0KPiANCj4gKyAg
ICAgICAvKg0KPiArICAgICAgICAqIFdlIGhvcGUgdGhhdCBIVyBzZXF1ZW5jZXIgd2lsbCBkbyB0
aGUgcmlnaHQgdGhpbmcgYXV0b21hdGljYWxseSBhbmQNCj4gKyAgICAgICAgKiB3aXRoIHRoZSBT
VyBzZXVlbmNlciB3ZSBjYW5ub3QgdXNlIHByZW9wY29kZSBhbnkgd2F5LCBzbyBqdXN0IGlnbm9y
ZQ0KPiArICAgICAgICAqIHdyaXRlIGRpc2FibGUgb3BlcmF0aW9uIGFuZCBwcmV0ZW5kIGl0IHdh
cyBjb21wbGV0ZWQgc3VjY2Vzc2Z1bGx5Lg0KPiArICAgICAgICAqLw0KPiArICAgICAgIGlmIChv
cGNvZGUgPT0gU1BJTk9SX09QX1dSREkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4g
Kw0KPiAgICAgICAgIHdyaXRlbCgwLCBpc3BpLT5iYXNlICsgRkFERFIpOw0KPiANCj4gICAgICAg
ICAvKiBXcml0ZSB0aGUgdmFsdWUgYmVmb3JlaGFuZCAqLw0KPiAtLQ0KPiAyLjEwLjINCj4gDQoN
Cg==
