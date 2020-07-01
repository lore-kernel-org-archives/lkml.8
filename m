Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B3F2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AtFGXMmM";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="An8y+yzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgGAH66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:58:58 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:10211 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgGAH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593590335; x=1625126335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sYsbF1W4v+NZZ+TYqj3gahnfDsfvjd+G2bjbbN+JiqU=;
  b=AtFGXMmM5rq43SVqRxr7sadvVymoMy+Htwe9tvaM3l4zVldnw/G9s6ZD
   tUr014EezU3ZpYVeNUO1Hej9MpZlwXgxA1IDIbAeFD30gW1ePtcn+kPxT
   51CYudLmkVs0rI2NBizmx/gAEsJNR/P/JRVymfHzz40zQUHbbnNoycuIp
   9Dr52f97QA+9nudoJFhHlhWABhRyiJIN5QllxpRm8AfiiVgh29ihuO6ZA
   xE6vFQdhE1JLrn+uuiIDBo4NZFVDKJ2zOv4A/gAzAV+6ffcGl6TfCSduY
   +MROQ/nAQxv0zfLx48lrElDk3SKDzkx4fz4iJHxTz2eu5IGtHA75jSe/2
   w==;
IronPort-SDR: V27pm+WuIpFd/UodRsQIciD2qmwlfz6d+RubVmDAbrRUkVg/UTj4gd/XAmevqrLR3Uwe2jfBoX
 /Jdr5y/pcTiJZbxO6hwl0gWFAZc8v3wAloSxE9ZvZVu310edFXLVBwgeJ9Gc1/Y5kotZC4CNOg
 0YL+Cq6Z9Xxt5vB4oA95Q7zczjbYkJv88pjJzP325WT+SM/siObTs1CE18klFGMZ1rwcTxdlj1
 vHR1TrnqZ0XnMYqqSDUfSfM+hQNRgVQWb8jfnVGe97wrlqx2g9bpb5C/RTAaEOf7R8AzhQr3YI
 dn0=
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="82190898"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2020 00:58:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 1 Jul 2020 00:58:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 1 Jul 2020 00:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+mqxVzAv4a2TmhHnj3rcHKhqH12a5B7zXj89Oz4TfMQLh2A0jy4MHg1rqtifLvHrnVgEXWsskUn5N/AUVjD/VOm11rz7b4CfZb/4jq5/0N62hNIRIck1TQlU4NysndJZC5gqyCuwSMjFvSUxEHCR8rJ4P+rmK8YQ6GqItclr5TFNLk/xdKr3eYIltJeC9LssLs+tugPc3fwbhe+C+B1Z83cuR63s9zmT2u/eSn7rmFW5ZJxhEdb7//8QHem2+oNJuCyNV0oBvWONGmwvydVWzNqnWyzpIXvYEPt3ruFUh0sgMOi/SFoymBIPof6CM/AJqcMsxLtCsyDOW4OTNFPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYsbF1W4v+NZZ+TYqj3gahnfDsfvjd+G2bjbbN+JiqU=;
 b=f2zoiLpMLhPqMp5acr86/7oXAGXDw/muw0NoPIyxiGxiD/bo/plj3n7lPa3sBdl2HlIC6+yg9QdPdoLnBU/VD0gvGtI5b8NAPfuwW5avwAg78VTRWiUXeZfT4ZSPtF5J2lEdO2V02b7y1agxR1btBs5ZkcKVYauWuY2LTK1nsKrxfU3xj0Z1GcKyLVDmiAO+1nNduVdJ7S6cmd1RSOID+pMUSnN65Ehd/D3gA5a2Rz39xXDI5TazKzIuFVm1BEW0MMLuoRKf45IlrLe6cWNpREHA7fvkiQ+OOejdXQDYVk/pK9pVCmCeZniS8oPmQQ94WW7lyPonH9ZOrC+Yq3a55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYsbF1W4v+NZZ+TYqj3gahnfDsfvjd+G2bjbbN+JiqU=;
 b=An8y+yzBTxBhIeWyk7wfbvCdjy0b7hVkBt91FBBKFwr+KvoRgNJGf2YSZV3Qj5bwEGLqfeq1cJbX57HN8TPhW6rc1TDFBXdAXV4x95i+5dqhZadn4S9+nmJ1Zm/qxsAJXUNwfO7cfE3iMrf8bVM75QtbgpqBrdDLY9bVpK0a7gM=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3751.namprd11.prod.outlook.com (2603:10b6:a03:f8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 07:58:52 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 07:58:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     <thor.thayer@linux.intel.com>, <vigneshr@ti.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <p.zabel@pengutronix.de>, <miquel.raynal@bootlin.com>,
        <tglx@linutronix.de>
Subject: Re: [PATCH] mtd: spi-nor: Fix runtime PM imbalance in cqspi_probe
Thread-Topic: [PATCH] mtd: spi-nor: Fix runtime PM imbalance in cqspi_probe
Thread-Index: AQHWT311TUMJ5i8fEEWqSo+Rmrg95Q==
Date:   Wed, 1 Jul 2020 07:58:52 +0000
Message-ID: <328b6db3-3298-047e-51a1-d9a8bfded41a@microchip.com>
References: <20200522100520.22130-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200522100520.22130-1-dinghao.liu@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: zju.edu.cn; dkim=none (message not signed)
 header.d=none;zju.edu.cn; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.52.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01e0b787-3858-4666-19db-08d81d949876
x-ms-traffictypediagnostic: BYAPR11MB3751:
x-microsoft-antispam-prvs: <BYAPR11MB375170B705015C65F241D992F06C0@BYAPR11MB3751.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KH5vIUa2JwZIZwBg3Hoa/6N9X+hAwSMNnucYfV1dQLD5EX7uBoSta3kY57Tiwo0gV7tQyH2sfcL74PLNValw42hLLuFagzTJyPUwheHTnSEKutoP+r430ZcmiqbHIXeXE05rtFSJovGNM97yv43bGU91+G0qeW6GU/VeJWLHD9m5tcikNY5xq+1z7gxPHZBPQefUH7pXZz32te5amjYjNlnaryGFAoBqJtbN2SLrsNe4aAXrVijZuaN8xrSP7gpJ8en1+8pskLvKwM0PiP/p6xGoQK9Yp6t05uT/4eLeG7wM0EnHPJG+1nRRSUlFOfavvI6MwcPBP5P0DCljQsQr8quggPic/szEnd9584jobiKxJ5d0XHMCYQ6d0x2EaZ3a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(396003)(366004)(8936002)(186003)(2906002)(31686004)(86362001)(6506007)(26005)(31696002)(2616005)(5660300002)(53546011)(110136005)(66476007)(4326008)(6486002)(8676002)(66446008)(76116006)(91956017)(64756008)(71200400001)(66556008)(66946007)(54906003)(316002)(478600001)(36756003)(7416002)(6512007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zD/jgJDvbZuCDzjWQizfA7ddiTRFiNoFKS4mDUWWfUf601DZl140WI5oE+alnKUBfz9VB9KvkQwu+ofLRZZ/WUHll6SIYGVZt+shjxLzrmIDWQE66SU7dvQED/8x8z8Dke0bMsgLcMia2Q7xD3QluZJIX/DTeuM5YAjMPoCr9YWnKmVFkGJz6wMnyE1X3kouRXUIvngQ0uWGn+HJjWJltpebWNxTABkO1ZKG04SDdsXrAAKL1phG9wmM02KFHwbbiEuyS/4jn/PyelQ5CzBiqrvtbU6ktOAh6KIB4HMnYxxisDvng4Q0k8jytH9xmHkY4/WRK4QRcSWWEDHDF3wnzsn5stpR/rg+cPNY2syp7joIjwpnBCy3o/RKhdF/sJuS9kzCHrKU8ZbYlIvM0Jmpg3PmMYBrF9OgnZOE7QDId+GPbfuztpC5dw9cRzH5GledQ2PkIl9Gv2RttOctNW9vW5osmDHj58gF4CppHKg3B0w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6C5DB38314BB34FB4B7DB28871997D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e0b787-3858-4666-19db-08d81d949876
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:58:52.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gGPSUMNSlJSgpBzvHMHY8QOFmSLD+mwu755WswLNHW9KcOUusXE08L9BNdNp8A/RHfPPmrXX9sH7HLI4TQRwq5vrS2FyDMfw5UmQZDIw+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMi8yMCAxOjA1IFBNLCBEaW5naGFvIExpdSB3cm90ZToNCj4gV2hlbiBkZXZtX3Jlc2V0
X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZSgpIHJldHVybnMNCj4gYW4gZXJyb3IgY29k
ZSwgYSBwYWlyaW5nIHJ1bnRpbWUgUE0gdXNhZ2UgY291bnRlcg0KPiBkZWNyZW1lbnQgaXMgbmVl
ZGVkIHRvIGtlZXAgdGhlIGNvdW50ZXIgYmFsYW5jZWQuDQo+IA0KPiBBbHNvLCBjYWxsIHBtX3J1
bnRpbWVfZGlzYWJsZSgpIHdoZW4gcG1fcnVudGltZV9nZXRfc3luYygpDQo+IGFuZCBkZXZtX3Jl
c2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZSgpIHJldHVybiBhbg0KPiBlcnJvciBj
b2RlLg0KPiANCg0KSSBzZWUgdGhhdCB0aGlzIGlzIG5vdyBmaXhlZCB3aXRoIHRoZSBtb3ZlIHRv
IGRyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYw0KDQpUaGFua3MsDQp0YQ0KDQo+IFNp
Z25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvY2FkZW5jZS1xdWFkc3BpLmMgfCA1
ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9sbGVycy9jYWRlbmNlLXF1YWRzcGkuYyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvY2FkZW5jZS1xdWFkc3BpLmMNCj4gaW5k
ZXggNDk0ZGNhYjRhYWFhLi5lYWJkZjAxZTBkMDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29udHJvbGxlcnMvY2FkZW5jZS1xdWFkc3BpLmMNCj4gKysrIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9jb250cm9sbGVycy9jYWRlbmNlLXF1YWRzcGkuYw0KPiBAQCAtMTM3Nyw2ICsx
Mzc3LDcgQEAgc3RhdGljIGludCBjcXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gIAlpZiAocmV0IDwg
MCkgew0KPiAgCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsNCj4gKwkJcG1fcnVudGltZV9k
aXNhYmxlKGRldik7DQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+IEBAIC0xMzkwLDEy
ICsxMzkxLDE2IEBAIHN0YXRpYyBpbnQgY3FzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gIAlyc3RjID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNs
dXNpdmUoZGV2LCAicXNwaSIpOw0KPiAgCWlmIChJU19FUlIocnN0YykpIHsNCj4gIAkJZGV2X2Vy
cihkZXYsICJDYW5ub3QgZ2V0IFFTUEkgcmVzZXQuXG4iKTsNCj4gKwkJcG1fcnVudGltZV9wdXRf
c3luYyhkZXYpOw0KPiArCQlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gIAkJcmV0dXJuIFBU
Ul9FUlIocnN0Yyk7DQo+ICAJfQ0KPiAgDQo+ICAJcnN0Y19vY3AgPSBkZXZtX3Jlc2V0X2NvbnRy
b2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShkZXYsICJxc3BpLW9jcCIpOw0KPiAgCWlmIChJU19F
UlIocnN0Y19vY3ApKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiQ2Fubm90IGdldCBRU1BJIE9DUCBy
ZXNldC5cbiIpOw0KPiArCQlwbV9ydW50aW1lX3B1dF9zeW5jKGRldik7DQo+ICsJCXBtX3J1bnRp
bWVfZGlzYWJsZShkZXYpOw0KPiAgCQlyZXR1cm4gUFRSX0VSUihyc3RjX29jcCk7DQo+ICAJfQ0K
PiAgDQo=
