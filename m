Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8464DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC5D20737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="wOwSRd4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGQSUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:20:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:54614 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQSUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:20:20 -0400
IronPort-SDR: NrjipcfP/ib/M827hMK0Tgd+ajEnYWKmBmB/GY6VSDN1rim2QXeNS931+pEqLeHH5gpWgqVbl9
 dYPI775+qYtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="148818372"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="148818372"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:20:17 -0700
IronPort-SDR: uoUIWsFuI1ggkZ+90mAWSDhzaxElWi27C1B+/JAR5ghIqW5NufNKkvEYG2qJtdOxSpAVP19Htz
 irHUWL9/bYpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="325500586"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2020 11:20:16 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jul 2020 11:20:16 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 Jul 2020 11:20:16 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jul 2020 11:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eib6HwLVoXeaV7auHqbpouh81lluFO61QxhvFgtoFyvSYDC6NOz0obfhhOutvzlziAHsGiWF3c0boqABqaAJaBl81tJk6yI66/lojGu8svp6Lr4tTBZ7qQKPFA675fxqEOxIhBASaIe6trsMFigiZXZ69nCyrjb1mDdQjkjB5dwJ1AExHLTARzzLtvElHrYnYLKNPBv+aXWqEYGp7EnzjZCP/htCKYsk9y68inrMGIDPnhIh57L2yWOa4W/I3eL2H2LkGoBva/2BpjdgsH1q2jS/onvlEzc2e/E63yruxV+3IqkD2CRChSlWgflf2mZBTICMpOqTfvLmC50t46cpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riZMtts0ffci9nbXLu3GOvTbMlEBlb7ug4cALPOi61s=;
 b=Ksu2G31De7IJmSadjHw6djd2NOFRuk4dX10vx0dtzfUTaNcepEz7jURsBk2YK8j40/KaFK4vCPX7KgLboMxV3PUrkUO5CdXUrgz6eXcMLRbTx7sl1AtL+00voHmJxOwBpt1IS1MgQYDkH70JeI1THOjBhPYtQyrwm70JoerDCsLsN31AtyXYUXhaCbhab/hz8pxOcQObx/UjWKzC2hp48z0jaeTDwGHdJjr69pI2hOV4QVoAIJWyoF1XsamzJFOmxUYCJbo1knb9UUYG8+vzuKEZtqKsjSu46/4IvGDUvhYJzUMfAhW92H84FA1DbMsHYwmP1ASA8cbI8CgL6v51VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riZMtts0ffci9nbXLu3GOvTbMlEBlb7ug4cALPOi61s=;
 b=wOwSRd4tm9WtwigRIqlN0GzUrvoIV4Il0Q1cyOxlsGiTlolH/GQx5uEieslIpjej/xz8WuJvpi96V7eb48sJtrs2HbIbV4M+kIYOS2HMphwvPGhT1K5eXVcJNULzaStXZ7kVQL5k67kfbV33dQERvY6jwSU96UIR0woW0BJ8XpY=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB3485.namprd11.prod.outlook.com (2603:10b6:805:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 18:20:13 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 18:20:13 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Topic: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Index: AQHWWFqviGLMQx7oL0apZ2u4U144JKkMGHww
Date:   Fri, 17 Jul 2020 18:20:12 +0000
Message-ID: <SN6PR11MB2574B116D9A729D139E25486F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <68d23285-9028-a70d-1dee-f044c507109d@infradead.org>
In-Reply-To: <68d23285-9028-a70d-1dee-f044c507109d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ee7fb9b-033a-4ef2-5272-08d82a7e0c31
x-ms-traffictypediagnostic: SN6PR11MB3485:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB34851CDF0150A40AD36B5D03F67C0@SN6PR11MB3485.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gobJAJ2Qm4KjjDdssdqjGPWsNv3F+p6l/0FatIbckn1xTygCkGjg3itTOQbn7sOe5HkQ+Y81QjBDnTD4DlQCvzWfNQXxb+jw2tiVWFHSqHgySdpwuBE/OI6PZhPACWNA5WLmmgd9nwpRpLkSnh8/KBEDtYXG87LPGUc+mstZ+1PxYm+/opoCWPnxgx3NTPCfXPfm+r41fW7YHNDUclNlUy2Vf5ANX6fxfOiQbOagV8X4KXW1OSs715H1ZrG9f4/GcgltqU9ZtT0jSBWmqv3mYdDGXxOUC50sKmZ7sS1isukeBjuGVHcxUxF+V+XG1SE1D+Jl8uo4pXwiFroqVStckQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(478600001)(6506007)(53546011)(186003)(26005)(2906002)(76116006)(4326008)(66446008)(64756008)(66556008)(66476007)(110136005)(66946007)(316002)(54906003)(33656002)(8936002)(7696005)(9686003)(8676002)(83380400001)(5660300002)(52536014)(71200400001)(86362001)(107886003)(55016002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lxMw6ETiRbyah/QxIbqxUgu/Wm0/DY6tEqv0Bu6hGXwFNJf2m/GFJUV4AXYKvzcHVNy1ZqUYupZcqOjQgXB+jbtEj8/K85zGGMwT+GCdooAdZ8yY5g2eeFo0ISpPcGxUb6zfM+/yTO0tUihTi6NDviF7PSVe5gbdS9lMKo5XQApjz0ixxHq8nnSVM+Mg0eu/et620Z56O8VYM1FMdSMDvSzRE2PRQcs7C3uXH6X5Kk6U1vDLdlQMnLkvdm50Huzn34T8NoeMBlstsgquVlWppJLsmQO65lYkTj/KrJDxzYR70jXMTan5EgL3056BzI01CJiQ2GrtT0j6Bf17rHMZ+YRKyCwgRmsd57XYRVW5jH1M1tvnwW65GOaJOJRoaeNV/AhINFO5kiizwZfcoxvZW+178yPAqDdXrjmA2y55l1XP/BgUGS3fCAz3w771BNbVVMvdSpToSJC0oI1fHnDs/3VhpVIl3xJz30zYH+iV+Bs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee7fb9b-033a-4ef2-5272-08d82a7e0c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 18:20:13.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /U6FEmicMWhtbtbZNOgQM1STqGjdKOktC8T+cXFPP76EViN2tDJUiUBg/PvIpUW0K1M7F0uQDBl5d0M8tpKkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3485
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgSnVseSAxMiwgMjAyMCA5OjQy
IEFNDQo+IFRvOiBFYWRzLCBHYWdlIDxnYWdlLmVhZHNAaW50ZWwuY29tPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gYXJuZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmcNCj4gQ2M6IEthcmxzc29uLCBNYWdudXMgPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5jb20+
OyBUb3BlbCwgQmpvcm4NCj4gPGJqb3JuLnRvcGVsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwNC8yMF0gZGxiMjogYWRkIGRldmljZSBpb2N0bCBsYXllciBhbmQgZmlyc3QgNCBp
b2N0bHMNCj4gDQo+IE9uIDcvMTIvMjAgNjo0MyBBTSwgR2FnZSBFYWRzIHdyb3RlOg0KPiA+ICsv
KioqKioqKioqKioqKioqKioqKiovDQo+ID4gKy8qIGRsYjIgaW9jdGwgY29kZXMgKi8NCj4gPiAr
LyoqKioqKioqKioqKioqKioqKioqLw0KPiA+ICsNCj4gPiArI2RlZmluZSBETEIyX0lPQ19NQUdJ
QyAgJ2gnDQo+IA0KPiBIaSwNCj4gVGhpcyBtYWdpYyB2YWx1ZSBzaG91bGQgYmUgZG9jdW1lbnRl
ZCBpbiBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS0NCj4gYXBpL2lvY3RsL2lvY3RsLW51bWJlci5y
c3QuDQo+IA0KPiB0aGFua3MuDQo+IC0tDQo+IH5SYW5keQ0KDQpXaWxsIGZpeCBpbiB2Mi4NCg0K
VGhhbmtzLA0KR2FnZQ0K
