Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37D6C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C14206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rKu1TgLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGQSTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:19:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:2793 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQSTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:19:33 -0400
IronPort-SDR: RoEg6YUJKwuL3J9p9ocrK5KEtAkUGahHuo7vrzxfgnsukMsqiLLvq6KYH5o9Oz4e9kccH4bIvt
 eEBuTyufVk+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="147159653"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="147159653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:19:32 -0700
IronPort-SDR: zkhjN+agGeER85B4SVTEKH0coSGPkzBoRN9sHSzgWdhd9rBLpRt3peJoRR63OqqrIPr9FjnPmi
 0itmmZQKLamg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="391462076"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2020 11:19:32 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:19:32 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:19:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7n99wI/m0UfU5Zt/MMzNWhknzIzaSTWEnIF9TuRmIfv3cdOc/x6+vt7LMRXRey/Ey6a/xu/EHeui1kFvht6LE4QW1vPr/MyUizAXyA7ntrOw3vN5Cw6M3O5q7VMQPBMZ+W8wY6BR9jQUCY/ymvCYriqY5inSzMJeTXAwigvwn4+IbpQ7gM4piAIuBYixIaAVXeBE+/IWlh9UismjRyQ+w1nnphEloAJDdjHkN0NiYgKaYBX7Ytm71WM5AVMfpYvhJIXH1NvbJCPinRnw1WerL3P6bPVFYZTmG9IAugJnisHQjDbnTPq7+ORmlLaaMn77e0sdjnAyDCcuWQTVKGTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBIksLMoLpe2cMy7cY53Td9HBUyYYlVR7iaoIB82LhM=;
 b=UXlEbeUwIn1KaP5vn9nH+oP6Goe2/FApUdFKAUud9Hy6GSZImQXHYgiXUc/DzqPUFud+vfOw9dG3E9+c3gESBB943xWXqN01ZlXe+SvVZJgIbQapwT3pKgsOmA45ppkPheMKVN+qrQsoBYyUsyBDS0jAzwVOrshV2BAYsCZlnNFkvyXjsFy0xcwwvB/Nar4ewN9oQl7kxcvCTXDRZ87xXDxMxXBnDU1fUVQ/GhKPkJz9OorYqfOZgdf9MUv6NxQyCBI1qDC44DoA1bBXg2zEKIeLqSDpZlOQLk2uRP72je+YEyzignnK8wzYM0eCpANRtKlQR/5rlTZCl47/CuHcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBIksLMoLpe2cMy7cY53Td9HBUyYYlVR7iaoIB82LhM=;
 b=rKu1TgLcU7o6LHSOJl2MurkCHUi3cxbqZq8Cfu2LPeBUNotrRLgMQwo4s8vhbY+hbVUb3vqwQFsaB6ATvt5vLCB5F6nY7PC+hJWv/HGm+kdBRt+ZWcrTgoqjGpRaQUHZlBulhTU9bYgjr3MbFNnEvERstJ7mhDWqKaU0uuCtAWE=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 18:19:30 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 18:19:30 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 09/20] dlb2: add ioctl to configure ports, query poll mode
Thread-Topic: [PATCH 09/20] dlb2: add ioctl to configure ports, query poll
 mode
Thread-Index: AQHWWGH6OjmPpRPrj0S/yp/6773J66kL/tiQ
Date:   Fri, 17 Jul 2020 18:19:30 +0000
Message-ID: <SN6PR11MB2574CAD5B23E44C30767A0ACF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-10-gage.eads@intel.com>
 <CAK8P3a2zr5JXr0K_vwJSkmH-YAbYbZtWFD8Pk-TOOdZhitw44A@mail.gmail.com>
In-Reply-To: <CAK8P3a2zr5JXr0K_vwJSkmH-YAbYbZtWFD8Pk-TOOdZhitw44A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13d04e0b-d8f6-4a41-7afa-08d82a7df2cf
x-ms-traffictypediagnostic: SA0PR11MB4751:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4751B2476A2F84B6AEA63A28F67C0@SA0PR11MB4751.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iN2KUw0qn3TZGs3xjmwfxLtIebBQWxOcVSa3UQI4nq1nb873OsZsDEw9Nj6t9rwIZ2ODpK9afdOd4Vl3FY6W416Z+3upX5RgHmPOEmyXIUNi59V3a/7zKZM9bPN+MHDnkOzBcrnLtsG4Zbb46GWFFSwgp/knV/fI4ulSG5h0dsKUAl0qYf64SLo7XTbcwoyXbfwboI3QID6mm74Ya5NDK1UDZYu5vmcO0+8krLZoA4xkZpGM9u6DRKTZPe98rReB1aTDOeskS9iTojVNUGuv6ETxcZd1UmI8rtu/EdmeIA+jty4x7+QHhvbNS7eEnOuZItmJr8D9sfk4xD1M4RmqPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(26005)(33656002)(9686003)(55016002)(7696005)(6506007)(8676002)(478600001)(53546011)(71200400001)(64756008)(66446008)(76116006)(66476007)(8936002)(186003)(86362001)(66556008)(66946007)(107886003)(6916009)(52536014)(2906002)(83380400001)(316002)(4326008)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sPopiTYhIEL9Fn5XTfXrbemfHWnMpYACUUqeQ/LDdNfEub6ilBLpHkm9/vbXfyOddRGBvvNhFYepuDu9WWenr3Ax7pK0i6OkeJy12N/ua3Xj0JKyQGdxJcSL0RiGiYn7PNu8uIhmF2Xj93rfDSR5nfcVa0qLAj2QT+K0P4fHOSFs7F99H/tk2HYadatRPhBkNc0h/hmJT253AqA1O/dUA83M6+jlpAtOH0a4DsLfR0ACsEeiqPDzu3wOnVIjKk8ntu6vSkxaW9ZOi+DPCmTH0mnqiwYTWOe/ne3sAmmPh3UjIOR+80x6AZjjnarRC1R4Wortrb0aYo7MkeGLKbz4AcOTk8NkAVK+nXSFyTOrO2nrL0aS9gNQwlOV3rQGLUrDYbkZyxUh8JgBX0qE5ubmIWK7L8gex+cTPcSAIE8C/MDq2OIfjZ5awUYLUvDd9UhC4x7bvke5d+ct0yIx4sSWJW9aFic+nwpkPArgIw4LbjE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d04e0b-d8f6-4a41-7afa-08d82a7df2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 18:19:30.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRmEcpozaLgcHtWytQcO9KMv3mPuobuEOlSnEO0hzgKkAebBSZZV4ZKFqN7NxwuKjDDOeTpyELvBZ4nBh8SLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogU3VuZGF5LCBKdWx5IDEyLCAyMDIwIDEwOjM0IEFNDQo+
IFRvOiBFYWRzLCBHYWdlIDxnYWdlLmVhZHNAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgZ3JlZ2toIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47DQo+
IEthcmxzc29uLCBNYWdudXMgPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5jb20+OyBUb3BlbCwgQmpv
cm4NCj4gPGJqb3JuLnRvcGVsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwOS8y
MF0gZGxiMjogYWRkIGlvY3RsIHRvIGNvbmZpZ3VyZSBwb3J0cywgcXVlcnkgcG9sbCBtb2RlDQo+
IA0KPiBPbiBTdW4sIEp1bCAxMiwgMjAyMCBhdCAzOjQ2IFBNIEdhZ2UgRWFkcyA8Z2FnZS5lYWRz
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gIGVudW0gZGxiMl91c2VyX2ludGVyZmFjZV9jb21tYW5k
cyB7DQo+ID4gICAgICAgICBETEIyX0NNRF9HRVRfREVWSUNFX1ZFUlNJT04sDQo+ID4gICAgICAg
ICBETEIyX0NNRF9DUkVBVEVfU0NIRURfRE9NQUlOLA0KPiA+ICAgICAgICAgRExCMl9DTURfR0VU
X1NDSEVEX0RPTUFJTl9GRCwNCj4gPiAgICAgICAgIERMQjJfQ01EX0dFVF9OVU1fUkVTT1VSQ0VT
LA0KPiA+ICAgICAgICAgRExCMl9DTURfR0VUX0RSSVZFUl9WRVJTSU9OLA0KPiA+ICsgICAgICAg
RExCMl9DTURfUVVFUllfQ1FfUE9MTF9NT0RFLA0KPiA+DQo+ID4gICAgICAgICAvKiBOVU1fRExC
Ml9DTUQgbXVzdCBiZSBsYXN0ICovDQo+ID4gICAgICAgICBOVU1fRExCMl9DTUQsDQo+IA0KPiA+
IEBAIC00MjcsNiArNTEzLDggQEAgc3RydWN0IGRsYjJfZ2V0X2Rpcl9xdWV1ZV9kZXB0aF9hcmdz
IHsgIGVudW0NCj4gPiBkbGIyX2RvbWFpbl91c2VyX2ludGVyZmFjZV9jb21tYW5kcyB7DQo+ID4g
ICAgICAgICBETEIyX0RPTUFJTl9DTURfQ1JFQVRFX0xEQl9RVUVVRSwNCj4gPiAgICAgICAgIERM
QjJfRE9NQUlOX0NNRF9DUkVBVEVfRElSX1FVRVVFLA0KPiA+ICsgICAgICAgRExCMl9ET01BSU5f
Q01EX0NSRUFURV9MREJfUE9SVCwNCj4gPiArICAgICAgIERMQjJfRE9NQUlOX0NNRF9DUkVBVEVf
RElSX1BPUlQsDQo+ID4gICAgICAgICBETEIyX0RPTUFJTl9DTURfR0VUX0xEQl9RVUVVRV9ERVBU
SCwNCj4gPiAgICAgICAgIERMQjJfRE9NQUlOX0NNRF9HRVRfRElSX1FVRVVFX0RFUFRILA0KPiAN
Cj4gDQo+IFlvdSBjYW5ub3QgYWRkIG5ldyBjb21tYW5kcyBpbiB0aGUgbWlkZGxlIHdpdGhvdXQg
Y2hhbmdpbmcgdGhlIEFCSS4NCj4gDQo+IE1heWJlIHVzZSBpbmRpdmlkdWFsICNkZWZpbmUgbGlu
ZXMgaW4gcGxhY2Ugb2YgdGhlIGVudW0gdG8gbWFrZSBzdXJlIHRoZXNlDQo+IHJlbWFpbiBjb25z
dGFudHMsIG9yIGFkZCBhIG51bWVyaWMgdmFsdWUgZm9yIGVhY2ggb25lIHdoZW4gdGhleSBhcmUN
Cj4gb3JpZ2luYWxseSBpbnRyb2R1Y2VkLg0KPiANCj4gKHllcywgSSByZWFsaXplIHRoaXMgaXMg
dGhlIGluaXRpYWwgY29udHJpYnV0aW9uIG9mIHRoZSBuZXcgZHJpdmVyLCBidXQgaXQgc3RpbGwg
c2VlbXMNCj4gd3JvbmcgdG8gaGF2ZSBpdCBjaGFuZ2UgaW4gdGhlIG1pZGRsZSBvZiB0aGUgc2Vy
aWVzKS4NCg0KT2ssIG5vIHByb2JsZW0gLS0gSSB3YXMgYXNzdW1pbmcgdGhpcyBwYXRjaHNldCB3
b3VsZCBiZSBjb25zaWRlcmVkIGFuIGF0b21pYyB1bml0LiBJJ2xsIGNvcnJlY3QgdGhpcyBpbiBW
Mi4NCg0KVGhhbmtzLA0KR2FnZQ0KDQo+IA0KPiAgICAgICBBcm5kDQo=
