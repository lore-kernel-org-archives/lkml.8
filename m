Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183AEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D4B2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="kq0zbk9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHDWU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:20:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:48466 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHDWUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:20:55 -0400
IronPort-SDR: 76YnbJlD1WFOmnl2Ua/ssaaSRcrLntjsxeJMCyU/nnolpZQP1FLeHveBGoSMXgfelscsdrrZac
 /ksNHIESoP/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="131984744"
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="131984744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 15:20:54 -0700
IronPort-SDR: 8kpJ3N15Ojg4MCdfAiCEz7OntyxjOceYYC4uSgv9TMxF+7dFyno4yyDnNWmn5RVj8ukRI6jaj8
 A4gWjDOqHEHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="274605419"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2020 15:20:54 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Aug 2020 15:20:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Aug 2020 15:20:53 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 4 Aug 2020 15:20:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 4 Aug 2020 15:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUr+5acxwhavlPdsC3yULWr3b8hQm+aFoA0VPqI03/Q7chxOHe8eVVTT3A1iyuX/uVQl7xv273VTrh5OkHZ4gvsVqdaG1Caq5GNzh/vHiT/+1wxohx53ya2Vmep4X0YeaNEOmWzauaw9DauEkDIJSHzVO6+oE0rwTFcI+xNh/Yk1XS47ZNcxBGBDJrdGgIqoswWokiZveUlKUD4/tIZsNkbBq6+u7TV0RgJMYQx5BAbEuwpIBgN9ngNQZBwQrDFoT7lFy3re5BgbYNCvc+ZM3nN2qCgbAU1H6vn9Dd4VXj5nGcppep8CZVyBBi2/EKC0bWuIfF9J2nHFfIa87wcHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGxs3tBQSD7TrJHBD8IDfp38jo/PfhY1V1kbVnScgZo=;
 b=A6kSo7vdojlP2o6N6pmGjtK7JpAlTjNsXCdY9ZFyfvVrjcVq5nuYqb6Al4xN0ZhxanYP15QsoUZhLW+AE4ATNHQiAtIGO5PDoe73gzqvv1OQkphU0utxlFSn5X4mG/C97k6QABEFjBUySsibTHibG7M8Jn3MN6MU5eTCD7L8He5fTQXRAtLZjn6IStBszsL8gM1YnmMxQtqZ6852DNCKcEjdGghg8Hh5rPEF/6BdXvkJHFGCq/15SsntxTBTgvRKFkn7vGYJOOJJhmru32CJKIsZDDdtCNvomVE79Z4fJkSR027OOtInZgEWTWNPCWAyuhzxRf2WjkoDEIu3EaNY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGxs3tBQSD7TrJHBD8IDfp38jo/PfhY1V1kbVnScgZo=;
 b=kq0zbk9tAnjqnbrOjmeSjf0RbOIQEN87ss9VBheup/mPpxQ3qRCLelVICCMNI8cxkodh86LTivEW5TGJsmx7bcMavsPxiOZUgl+sTJqBS9a+r3cEhl7creokTcl5DuvByQWW8TeEtQBEZXrAOM5fl1n+WetQlB+xa500U7ajykQ=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB3054.namprd11.prod.outlook.com (2603:10b6:805:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 22:20:47 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd%7]) with mapi id 15.20.3261.015; Tue, 4 Aug 2020
 22:20:47 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Topic: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Index: AQHWWGERiGLMQx7oL0apZ2u4U144JKkooA3A
Date:   Tue, 4 Aug 2020 22:20:47 +0000
Message-ID: <SN6PR11MB2574422442C26A41FBC89DA1F64A0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87b4f692-fa01-431b-5bbb-08d838c4a353
x-ms-traffictypediagnostic: SN6PR11MB3054:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3054A359793AA34B964F9A5BF64A0@SN6PR11MB3054.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EipMpYNq+5hchM33qCFsi0rH1RXNIvHYnEPbNRDNSrW0s9neqckg+F1ZyScIrOGHM1o9B4w1fzSu6/4JXwuaF/UlH8KWZisqKPSNLJwnMWEEGsxVL8fGR6CNbchAG0ruTV1aYrDzo7t3Ku4EaMnyulqXuutlFXMl9JCfG0g6fLsSY5xhQPUrvL45HHDGFTV7Q/hLmVu66UaU4MQrq/t50BOhc62JeiQhy2dUs15S/bod00fU4t3QBzoC1bjuWy3fQOU6LT//F4DXAzHolBfvgRJjyjPSF8sVqug/t8J8ppEpHGj6DHMe7+qUQ000iTxr+z/vY/BuqvShiw2DBKhENg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(64756008)(107886003)(76116006)(8676002)(6916009)(71200400001)(66476007)(52536014)(66946007)(66446008)(33656002)(4326008)(2906002)(9686003)(66556008)(26005)(478600001)(55016002)(83380400001)(5660300002)(316002)(6506007)(7696005)(54906003)(8936002)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PbhOO0PKXBgIYGNX1NgWWjtW2yx0oYA4u63EvkMMdpgmWaTYB/8kpXp0+ol9LvpVX8kxqbV60Qy7TATumyekAlRoMyPw7vzEomLri+1P9FYt5pIX9ckS4dplYGFWE1/T14WHB00Me3KfSpPHlX4GnkuuqQcAqqfg8i2KUAVXZ38mBEo2wds0/D704pggo9mpIwSxuA66EDPMKwg70bfxgy5L1/8Ct4/HqqZ6kkvX3KicrDxN9XdTxdyb6TnFbP2Qo1t0iHl2VLIEEUKg5qACkEixw6tWCyZ1E1WlmBHrRddpEpXqCC56UkvWMiJCbnxKPA+KMbLfVBW2KZ3GNkdEHRdm2nEp2hF0Z5hhEjbUbMvt2d9yUgSAAYW2lq6dZfiDNsFy+8Tnz36US1MEnb5tHih1/R6PHsky18eNi5hOjvrrYlKO2B18ye1ZGzZ9u5eOSTeae3aCmyYHgjv9v6IMlS2/PpjTQK0zSdVBRx8twU2IUORlcPyRxXRH6QyfS1S3IfQcdXXPj6L3L1r5IeDuc1ERKTCJB1+/IxsIcEAdapXN7WtY3RnED+cN6ysjrCT0RadX0Ka6+KCoZj2vG5IkxK3LZof/og67mKzRs1Q21sgQgUUrRFoR7zGC2s9XJAXrx0tXDVYAb6fbCh4HADUMqA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b4f692-fa01-431b-5bbb-08d838c4a353
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 22:20:47.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1zlkn1rTcld3K7f48cnT7pzBR4Xv6hJiliYQuOuEVfcSO8O6JABCgi+Keh3GZrkvZVz86G/3r9no8A9Bwlsjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3054
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsvKiBbNzowXTogZGV2aWNlIHJldmlzaW9uLCBbMTU6OF06IGRldmljZSB2ZXJzaW9uICov
DQo+ID4gKyNkZWZpbmUgRExCMl9TRVRfREVWSUNFX1ZFUlNJT04odmVyLCByZXYpICgoKHZlcikg
PDwgOCkgfCAocmV2KSkNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZGxiMl9pb2N0bF9nZXRfZGV2
aWNlX3ZlcnNpb24oc3RydWN0IGRsYjJfZGV2ICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHVzZXJfYXJnLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2IHNpemUpDQo+ID4gK3sNCj4g
PiArICAgICAgIHN0cnVjdCBkbGIyX2dldF9kZXZpY2VfdmVyc2lvbl9hcmdzIGFyZzsNCj4gPiAr
ICAgICAgIHN0cnVjdCBkbGIyX2NtZF9yZXNwb25zZSByZXNwb25zZTsNCj4gPiArICAgICAgIGlu
dCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgZGV2X2RiZyhkZXYtPmRsYjJfZGV2aWNlLCAiRW50
ZXJpbmcgJXMoKVxuIiwgX19mdW5jX18pOw0KPiA+ICsNCj4gPiArICAgICAgIHJlc3BvbnNlLnN0
YXR1cyA9IDA7DQo+ID4gKyAgICAgICByZXNwb25zZS5pZCA9IERMQjJfU0VUX0RFVklDRV9WRVJT
SU9OKDIsIERMQjJfUkVWX0EwKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSBkbGIyX2NvcHlf
ZnJvbV91c2VyKGRldiwgdXNlcl9hcmcsIHNpemUsICZhcmcsIHNpemVvZihhcmcpKTsNCj4gPiAr
ICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICsgICAgICAgcmV0ID0gZGxiMl9jb3B5X3Jlc3BfdG9fdXNlcihkZXYsIGFyZy5yZXNwb25z
ZSwgJnJlc3BvbnNlKTsNCj4gDQo+IEJldHRlciBhdm9pZCBhbnkgaW5kaXJlY3QgcG9pbnRlcnMu
IEFzIHlvdSBhbHdheXMgcmV0dXJuIGEgY29uc3RhbnQNCj4gaGVyZSwgSSB0aGluayB0aGUgZW50
aXJlIGlvY3RsIGNvbW1hbmQgY2FuIGJlIHJlbW92ZWQgdW50aWwgeW91DQo+IGFjdHVhbGx5IG5l
ZWQgaXQuIElmIHlvdSBoYXZlIGFuIGlvY3RsIGNvbW1hbmQgdGhhdCBuZWVkcyBib3RoDQo+IGlu
cHV0IGFuZCBvdXRwdXQsIHVzZSBfSU9XUigpIHRvIGRlZmluZSBpdCBhbmQgcHV0IGFsbCBhcmd1
bWVudHMNCj4gaW50byB0aGUgc2FtZSBzdHJ1Y3R1cmUuDQoNCkkgc2hvdWxkJ3ZlIGNhdWdodCB0
aGlzIGluIG15IGVhcmxpZXIgcmVzcG9uc2UsIHNvcnJ5LiBUaGUgZGV2aWNlIHZlcnNpb24NCmNv
bW1hbmQgaXMgaW50ZW50aW9uYWxseSB0aGUgZmlyc3QgaW4gdGhlIHVzZXIgaW50ZXJmYWNlIGVu
dW0uIE15DQpnb2FsIGlzIGZvciBhbGwgZGV2aWNlIHZlcnNpb25zIChlLmcuIERMQiAxLjAgaW4g
dGhlIGZ1dHVyZSkgdG8gYmUgYWNjZXNzaWJsZQ0KdGhyb3VnaCBhIC9kZXYvZGxiJWQgbm9kZS4g
VG8gYWxsb3cgdGhpcywgYWxsIGRyaXZlcnMgd291bGQgc3VwcG9ydCB0aGUgc2FtZQ0KZGV2aWNl
LXZlcnNpb24gY29tbWFuZCBhcyBjb21tYW5kIDAsIHRoZW4gdGhlIHN1YnNlcXVlbnQgY29tbWFu
ZHMgY2FuIGJlDQp0YWlsb3JlZCB0byB0aGF0IHBhcnRpY3VsYXIgZGV2aWNlLiBVc2VyLXNwYWNl
IHdvdWxkIHF1ZXJ5IHRoZSB2ZXJzaW9uIGZpcnN0DQp0byBkZXRlcm1pbmUgd2hpY2ggc2V0IG9m
IGlvY3RsIGNvbW1hbmRzIGl0IG5lZWRzIHRvIHVzZS4NCg0KU28gZXZlbiB0aG91Z2ggdGhlIHJl
c3BvbnNlIGlzIGNvbnN0YW50IChmb3Igbm93KSwgaXQgbXVzdCBvY2N1cHkgY29tbWFuZCAwIGZv
cg0KdGhpcyBkZXNpZ24gdG8gd29yay4NCg0KVGhhbmtzLA0KR2FnZQ0K
