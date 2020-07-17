Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B8BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF532074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Iq/OLKdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGQUFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:05:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:17014 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgGQUFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:05:13 -0400
IronPort-SDR: UOgPF/wQxtk9WR0E2Usa/dCgNBH19Z0APbHQB0tbqjkOjo3HUDKpHjTjJ9qqa04+QxCtk0HHik
 /91yjcvNPcAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="234521484"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="234521484"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 13:05:11 -0700
IronPort-SDR: wsce0T9w2oZoesqkEHCI00UoSqf+hKuMkiy7qNSXJqldH1O6PbWOfOowTzovT3Z7aUTJdNn8zO
 1XBTTre0jwFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="318879053"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2020 13:05:11 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 13:05:11 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX162.amr.corp.intel.com (10.22.240.85) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 13:05:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 13:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRmsb//DCHEGCZjjMxxetFZaC23bmBt5GH4UcxTMxyVvUX90796dCQCDeAVhKpXCQafrMZVW5iUS5vgt8NyQd0oNV/Hd4mV38odYQJr4Zzr2uhF5T676VtAzZM2xNaXDHRQr62gJLUPv+Qsir+sv3aBxxzOpYK/PZg1pJnDEyINlC13NdrzMop2a7OMkX0jYi5ZdSHWhZd4wFfn2M1hx5Z8tW2TkKij6UrHqJgMTzG3xu1wSSwTY8qCrZOr8hZAtSW7JEaG9NJTQshha8i1M6dMJimWXOnLQy5pXN2J1EMlsNqj5X4TpCltsGR6RYZdBY5Khpziu2shSbieNSaPMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDr63iAXz/VN/jXgr8zBXq4VIQHGeaMZJMKNcLnXPdw=;
 b=VT2bRIzDKMNB/BTMCXLLeAies6N320WIuHkXLUhb4fZQRxPBVIByU43z1+OOaVNf2E3aV0kuymaEu8WjFggk/FJyhF66qNPeImWhXtaSYcar+KKQ3k1pOQPupG9Kt/5wnPvRhadF2ntsNAjRIcaX0EccFqLLBz2ZAj2JGH58ioFSlFNgfudXzZ6NU6d8MU+SmWu4Cby6WEh01sFMD6L7jDOvE2keAyFPQJxxl/idvWNSzHXb+IIB3aZeLC4w2Wjg5+Bo7syC0u8aPnbcrdYH7ljqZAhjJesldOfY4CCvywi0j/2DEsxAtd1Xw3AtJQ5NCOj4aYPYwksRuDCU19EWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDr63iAXz/VN/jXgr8zBXq4VIQHGeaMZJMKNcLnXPdw=;
 b=Iq/OLKdE/4G0UlwtTfje9jPQ1+naJSSlVLE0IlmjNhPdPsbC5uOSPRCbiFHW6Mx1K78CJ5Kk62AjLrzqEUpoAN9KaxhuxY7UKvD2uqVCMdUylCRlHpXXCICzLbdffvtFxxijACm5WIfmHEZfARzp5pov+Flhu/7muKXXSlb4mbU=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB2640.namprd11.prod.outlook.com (2603:10b6:805:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 20:05:08 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 20:05:08 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Topic: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Index: AQHWWGERiGLMQx7oL0apZ2u4U144JKkL/3pAgAAnx4CAAAfxoA==
Date:   Fri, 17 Jul 2020 20:05:08 +0000
Message-ID: <SN6PR11MB257499106855871ACD053253F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
 <SN6PR11MB2574F33CF9C422517B3C13CFF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <CAK8P3a09C6-auonW9jw30z_CijLgT+LkWfYowYoVdrwSzNGWKg@mail.gmail.com>
In-Reply-To: <CAK8P3a09C6-auonW9jw30z_CijLgT+LkWfYowYoVdrwSzNGWKg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 64c3c675-00b9-4b95-2921-08d82a8cb466
x-ms-traffictypediagnostic: SN6PR11MB2640:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB264035B809FF3B6BF9482ED2F67C0@SN6PR11MB2640.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rI6peJDNQvM8upEAA912L15/ePG9UgVJv9LqGqZyJw0BrvTsYfwA40oaN+nQ1kRvcnc6vhUSHmU62XDMwXktz3LVdBYwoPNd7rDXbvgv4nlAd/bztYblMc4ta+46hBFSwDOw55vduoDJDb54VGW5pw/8bAHsKSCw/dW7+30ZF5AwlnpBtAgs+xPUYu1qZvxvO8qtO93LxZgeKLT+QEqN33ODy1dg4JkAN0wsVJiEnIT8huMQFn4jn+gNVr0LpXvswW92qM/0j3DQf+FZABUFRFm75YhQb6zlDmX75NfJ8b+e7daosJwNwiM1ub09EYPSlTmtUlqrd3covt4lvJmLBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(107886003)(8936002)(2906002)(54906003)(8676002)(316002)(71200400001)(83380400001)(9686003)(76116006)(55016002)(53546011)(5660300002)(6506007)(6916009)(52536014)(26005)(186003)(86362001)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(7696005)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yBp0dmbO+JUT7P91YGtzhGQy8LwnmltahbtDBT1ITSl0g5nNUvk7w1yuDWPHwdB63aZrbCLLZXshK5uJBiDCkmfXb8TOL2ZH47Vc3q7RBdQjZhJR3PdepVdkXlqrFvyDO9hHQeyzXUOVp+aAxwzDRylQoKuspBpSdzAMEhSYzxzK9wSajuW5vGhN8rJ/80m1qR3ZDCeDxSDNqW8l8v931EsCO9kplZgPFcCVA9wMCJOE+msAQm6Yj7UAab/c/Lp/NYb6WbAOjYxNgNhg4rBDmlTxc3+AJsjFbQXZNkJKHA5cAdGtxhdSDt+XHP/pN4J1Gzjw0CxcCDJO0Ztob8HfK3xmIxwgt4x8I5RITwMMVg3Z+51AZTQJ7G3zD8OvyCBffx3bi4h4924g9mV23tLa8D3/Q94S9+SEv3VLHwZIKpZOreUUcEbAdrLup8MjE3/NHJkVeLoXBNeKRA0y8fWJke8BXq0BNujxX7JjNm8tWEQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c3c675-00b9-4b95-2921-08d82a8cb466
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 20:05:08.1388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7pxNyr3z9KO0xLSPe0GYVN8EXfWrl2qfuCZJWOmylm8u3GOYtFmtsyTOoqICN+X9J2EY7tI8O0b9C6pgzaznQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2640
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDE3LCAyMDIwIDE6NTcgUE0NCj4g
VG86IEVhZHMsIEdhZ2UgPGdhZ2UuZWFkc0BpbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBncmVna2ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4g
S2FybHNzb24sIE1hZ251cyA8bWFnbnVzLmthcmxzc29uQGludGVsLmNvbT47IFRvcGVsLCBCam9y
bg0KPiA8Ympvcm4udG9wZWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA0LzIw
XSBkbGIyOiBhZGQgZGV2aWNlIGlvY3RsIGxheWVyIGFuZCBmaXJzdCA0IGlvY3Rscw0KPiANCj4g
T24gRnJpLCBKdWwgMTcsIDIwMjAgYXQgODoxOSBQTSBFYWRzLCBHYWdlIDxnYWdlLmVhZHNAaW50
ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gPiBBIHBsYWluIGNvcHlfZnJvbV91c2VyKCkgaW4gcGxh
Y2Ugb2YgdGhpcyBmdW5jdGlvbiBzaG91bGQgYmUgZmluZS4NCj4gPg0KPiA+IFRoaXMgZnVuY3Rp
b24gYWxzbyB2YWxpZGF0ZXMgdGhlIHVzZXIgc2l6ZSBhcmcgdG8gcHJldmVudCBidWZmZXIgb3Zl
cmZsb3c7DQo+IGNlbnRyYWxpemluZyBpdCBoZXJlIGF2b2lkcyB0aGUgY2FzZSB3aGVyZSBhIHBy
b2dyYW1tZXIgYWNjaWRlbnRhbGx5IGZvcmdldHMNCj4gdGhlIGNoZWNrIGluIGFuIGlvY3RsIGhh
bmRsZXIgKGFuZCByZWR1Y2VzIGNvZGUgZHVwbGljYXRpb24pLiBJZiBpdCdzIGFscmlnaHQgd2l0
aA0KPiB5b3UsIEknbGwga2VlcCB0aGUgZnVuY3Rpb24gYnV0IGRyb3AgdGhlIGRldl9lcnIoKSBw
cmludHMuDQo+IA0KPiBPbmNlIHlvdSB1c2UgYSAnc3dpdGNoKGNtZCknIHN0YXRlbWVudCBpbiB0
aGUgdG9wIGlvY3RsIGhhbmRsZXIsIHRoZSBkYXRhDQo+IHN0cnVjdHVyZSBzaXplIHdpbGwgYmUg
Zml4ZWQsIHNvIHRoZXJlIGlzIG5vIHdheSB0aGUgYXJndW1lbnQgc2l6ZSBjYW4gZ28gd3Jvbmcu
DQo+IA0KDQpBaCwgdW5kZXJzdG9vZC4gV2lsbCBmaXggaW4gdjIuDQoNCj4gPiA+DQo+ID4gPiA+
ICsvKiBbNzowXTogZGV2aWNlIHJldmlzaW9uLCBbMTU6OF06IGRldmljZSB2ZXJzaW9uICovICNk
ZWZpbmUNCj4gPiA+ID4gK0RMQjJfU0VUX0RFVklDRV9WRVJTSU9OKHZlciwgcmV2KSAoKCh2ZXIp
IDw8IDgpIHwgKHJldikpDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbnQgZGxiMl9pb2N0
bF9nZXRfZGV2aWNlX3ZlcnNpb24oc3RydWN0IGRsYjJfZGV2ICpkZXYsDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyB1c2VyX2Fy
ZywNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MTYg
c2l6ZSkgew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBkbGIyX2dldF9kZXZpY2VfdmVyc2lvbl9h
cmdzIGFyZzsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgZGxiMl9jbWRfcmVzcG9uc2UgcmVzcG9u
c2U7DQo+ID4gPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAg
IGRldl9kYmcoZGV2LT5kbGIyX2RldmljZSwgIkVudGVyaW5nICVzKClcbiIsIF9fZnVuY19fKTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJlc3BvbnNlLnN0YXR1cyA9IDA7DQo+ID4gPiA+
ICsgICAgICAgcmVzcG9uc2UuaWQgPSBETEIyX1NFVF9ERVZJQ0VfVkVSU0lPTigyLCBETEIyX1JF
Vl9BMCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICByZXQgPSBkbGIyX2NvcHlfZnJvbV91
c2VyKGRldiwgdXNlcl9hcmcsIHNpemUsICZhcmcsIHNpemVvZihhcmcpKTsNCj4gPiA+ID4gKyAg
ICAgICBpZiAocmV0KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgIHJldCA9IGRsYjJfY29weV9yZXNwX3RvX3VzZXIoZGV2LCBh
cmcucmVzcG9uc2UsDQo+ID4gPiA+ICsgJnJlc3BvbnNlKTsNCj4gPiA+DQo+ID4gPiBCZXR0ZXIg
YXZvaWQgYW55IGluZGlyZWN0IHBvaW50ZXJzLiBBcyB5b3UgYWx3YXlzIHJldHVybiBhIGNvbnN0
YW50DQo+ID4gPiBoZXJlLCBJIHRoaW5rIHRoZSBlbnRpcmUgaW9jdGwgY29tbWFuZCBjYW4gYmUg
cmVtb3ZlZCB1bnRpbCB5b3UNCj4gPiA+IGFjdHVhbGx5IG5lZWQgaXQuIElmIHlvdSBoYXZlIGFu
IGlvY3RsIGNvbW1hbmQgdGhhdCBuZWVkcyBib3RoIGlucHV0DQo+ID4gPiBhbmQgb3V0cHV0LCB1
c2UgX0lPV1IoKSB0byBkZWZpbmUgaXQgYW5kIHB1dCBhbGwgYXJndW1lbnRzIGludG8gdGhlIHNh
bWUNCj4gc3RydWN0dXJlLg0KPiA+DQo+ID4gT2ssIEknbGwgbWVyZ2UgdGhlIHJlc3BvbnNlIHN0
cnVjdHVyZSBpbnRvIHRoZSBpb2N0bCBzdHJ1Y3R1cmUgKGhlcmUgYW5kDQo+IGVsc2V3aGVyZSku
DQo+ID4NCj4gPiBTYXkgSSBhZGQgdGhpcyBjb21tYW5kIGxhdGVyOiB3aXRob3V0IGRyaXZlciB2
ZXJzaW9uaW5nLCBob3cgd291bGQNCj4gPiB1c2VyLXNwYWNlIGtub3cgaW4gYWR2YW5jZSB3aGV0
aGVyIHRoZSBjb21tYW5kIGlzIHN1cHBvcnRlZD8NCj4gPiBJdCBjb3VsZCBhdHRlbXB0IHRoZSBj
b21tYW5kIGFuZCBpbnRlcnByZXQgLUVOT1RUWSBhcyAidW5zdXBwb3J0ZWQiLA0KPiA+IGJ1dCB0
aGF0IHN0cmlrZXMgbWUgYXMgYW4gaW5lbGVnYW50IHdheSB0byByZXZlcnNlLWVuZ2luZWVyIHRo
ZSB2ZXJzaW9uLg0KPiANCj4gVGhlcmUgaXMgbm90IHJlYWxseSBhIGRyaXZlciAidmVyc2lvbiIg
b25jZSB0aGUgZHJpdmVyIGlzIHVwc3RyZWFtLCB0aGUgY29uY2VwdA0KPiBkb2Vzbid0IHJlYWxs
eSBtYWtlIHNlbnNlIGhlcmUgd2hlbiBhcmJpdHJhcnkgcGF0Y2hlcyBjYW4gZ2V0IGJhY2twb3J0
ZWQNCj4gZnJvbSB0aGUgbGF0ZXN0IGtlcm5lbCBpbnRvIHdoYXRldmVyIHRoZSB1c2VyIGlzIHJ1
bm5pbmcuDQo+IA0KDQoiRHJpdmVyIGludGVyZmFjZSB2ZXJzaW9uIiBpcyB0aGUgYmV0dGVyIHRl
cm0gZm9yIHdoYXQgSSdtIHRyeWluZyB0byBhY2NvbXBsaXNoIGhlcmUuIEFueSBiYWNrcG9ydHMg
d291bGQgaGF2ZSB0byBiZSBkb25lIGluIHN1Y2ggYSB3YXkgdGhhdCB0aGUgaW50ZXJmYWNlIHZl
cnNpb24gaXMgaG9ub3JlZCwgYnV0IGlmIHRoYXQgY2FuJ3QgYmUgcmVhc29uYWJseSBleHBlY3Rl
ZC4uLnRoZW4gSSBhZ3JlZSwgdmVyc2lvbmluZyBpcyB1bndvcmthYmxlLg0KDQo+IFRoZSBFTk9U
VFkgY2hlY2sgaXMgaW5kZWVkIHRoZSBub3JtYWwgd2F5IHRoYXQgdXNlciBzcGFjZSBkZWFscyB3
aXRoDQo+IGludGVyZmFjZXMgdGhhdCBtYXkgaGF2ZSBiZWVuIGFkZGVkIGxhdGVyLiBXaGF0IHlv
dSBub3JtYWxseSB3YW50IGlzIHRvDQo+IGtlZXAgdXNpbmcgdGhlIG9yaWdpbmFsIGludGVyZmFj
ZXMgYW55d2F5LCB1bmxlc3MgeW91IGFic29sdXRlbHkgbmVlZCBhIGxhdGVyDQo+IHJldmlzaW9u
IGZvciBhIGNlcnRhaW4gZmVhdHVyZSwgYW5kIGluIHRoYXQgY2FzZSB0aGUgdXNlciBzcGFjZSBw
cm9ncmFtIHdpbGwgZmFpbA0KPiBubyBtYXR0ZXIgd2hhdC4NCj4gDQo+ID4gPiBUaGlzIGZ1bmN0
aW9uIGNhbiBhbHNvIGJlIHJlbW92ZWQgdGhlbiwganVzdCBjYWxsIHRoZSBkaXNwYXRjaGVyIGRp
cmVjdGx5Lg0KPiA+ID4gPiAgICAgICAgIGludCBlcnI7DQo+ID4gPiA+DQo+ID4gPiA+IC0gICAg
ICAgcHJfaW5mbygiJXNcbiIsIGRsYjJfZHJpdmVyX25hbWUpOw0KPiA+ID4gPiArICAgICAgIHBy
X2luZm8oIiVzIC0gdmVyc2lvbiAlZC4lZC4lZFxuIiwgZGxiMl9kcml2ZXJfbmFtZSwNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgIERMQjJfVkVSU0lPTl9NQUpPUl9OVU1CRVIsDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICBETEIyX1ZFUlNJT05fTUlOT1JfTlVNQkVSLA0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgRExCMl9WRVJTSU9OX1JFVklTSU9OX05VTUJFUik7DQo+ID4gPiA+ICAgICAgICAg
cHJfaW5mbygiJXNcbiIsIGRsYjJfZHJpdmVyX2NvcHlyaWdodCk7DQo+ID4gPg0KPiA+ID4gSnVz
dCByZW1vdmUgdGhlIHByX2luZm8gY29tcGxldGVseS4NCj4gPg0KPiA+IENhbiB5b3UgZWxhYm9y
YXRlPyBQcmludGluZyB0aGUgZHJpdmVyIG5hbWUvY29weXJpZ2h0L2V0Yy4gc2VlbXMgdG8gYmUg
YQ0KPiBjb21tb24gcGF0dGVybiBpbiB1cHN0cmVhbSBkcml2ZXJzLg0KPiANCj4gTW9zdCBkcml2
ZXJzIGRvbid0IGRvIGl0LCBhbmQgaXQncyBnZW5lcmFsbHkgbm90IHJlY29tbWVuZGVkLiBZb3Ug
Y2FuIHByaW50IGENCj4gbWVzc2FnZSB3aGVuIHNvbWV0aGluZyBnb2VzIHdyb25nLCBidXQgbW9z
dCB1c2VycyBkb24ndCBjYXJlIGFib3V0IHRoYXQNCj4gc3R1ZmYgYW5kIGl0IGNsdXR0ZXJzIHVw
IHRoZSBrZXJuZWwgbG9nIGlmIGVhY2ggZHJpdmVyIHByaW50cyBhIGxpbmUgb3IgdHdvLg0KPiAN
Cg0KRmFpciBlbm91Z2guIEknbGwgcmVtb3ZlIGl0Lg0KDQpUaGFua3MsDQpHYWdlDQoNCj4gICAg
ICBBcm5kDQo=
