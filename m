Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B996DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9762C20737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mTtQrMUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgGQSUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:20:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:56897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQSUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:20:12 -0400
IronPort-SDR: rpjIA05+Je9ZU5hEn5WCQp+Fb3Nq8OTMYeDPcmbYZ9xrxwGoIPLAL2/Bb2gz+N/xB/SqMiFX95
 XpGfNYxKSYUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="211198443"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="211198443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:20:09 -0700
IronPort-SDR: D8zNzvNJpfs91mPwLNALdmbgMQbmpmdibsmTcLcIhd8bKNQRdQlcRvWyTKsLdl5jaAU7eYZ7WD
 nJngXSBj4DaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="286890196"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2020 11:20:09 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:20:08 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX121.amr.corp.intel.com (10.22.225.226) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:20:08 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jul 2020 11:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiJI1J1SJGngamUMPnRCtxQ4UxAzae7Ykx3fQRs3xw3e5w4IEm5/Rurs5mx/TnNj5voRDltVkvTI4j4kWnlhG28IgwRxdg94nEAbQMPpJ7pmNCW9K0bP83L2YR9Ix1LwXhaheZUUmmZwZk9cg3HtQFpN5LAwL1+YlauLa1FUS6NWGZrsifGOWOvAqlqUFQ5W99Il4+RDLC2pjYQbTfLJvZE4YPO8JOCCWxF23O0L9Fdw+sde4U3icHINxN+5l2khEFAZyIacNTERKX8aBI4updakzVNjBF98k00HOdwUwKrKSa5AmbYcLKGsEu/AfPrs41MqM8Mv7q8oaC6blKZCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ben7ipjK1juUP+i5FE/OEE6awtVueBABmfDtMX9Ii4k=;
 b=a4E1jzUrt5ZIWyeHS7szYuRydDkwJXEWsWKC9MlzBtVIR1zf2oomohtNIfvQR9xGGyyrbdCjv341ak04rtpdHEtGHz3MNhfrlM+kt1QwEaV9fk0wt+vFTO58AE0i2rKuHQY6b3KIW7teby98lAY3Av+oqV9+RsKRuGEfznPSuVQP/Jo9GgNBvTZgWzEkMQ4eE3d+RMno0MDJKIlzIrUydc7D0fj94t4ouJ03Ne3f2lM7Nfg9rUsu54ALjRFTIhTMvOTibe62YuwJ7pWM2JFqAXq0SJ+eh6J41rDV8pSyRkA1eddPS0tk1/AnpKy4Agt+wsbUpeymVXjH0C2mvo30KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ben7ipjK1juUP+i5FE/OEE6awtVueBABmfDtMX9Ii4k=;
 b=mTtQrMUUNcpux1q51+TeqBHyzXo7jfU8PqIoib0RaZSHZMBCNYSqk409Bm3RoNSsowkilF2MJt0fleukj9tubceeAfysfvg4pf5VNxrnA4arhRY9A/H8KO+JVg2lBpO1e5EWGclh4/p+9bWiYcPAYI8fOQU9XUc6YzBKHnEzrHk=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB3485.namprd11.prod.outlook.com (2603:10b6:805:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 18:20:06 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 18:20:06 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Topic: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Index: AQHWWFw7iGLMQx7oL0apZ2u4U144JKkMGDzw
Date:   Fri, 17 Jul 2020 18:20:06 +0000
Message-ID: <SN6PR11MB2574EC1876D0D3DC63C9D608F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <b25e3544-d975-b966-5374-639401541e59@infradead.org>
In-Reply-To: <b25e3544-d975-b966-5374-639401541e59@infradead.org>
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
x-ms-office365-filtering-correlation-id: 4145571d-f105-462a-515a-08d82a7e0871
x-ms-traffictypediagnostic: SN6PR11MB3485:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3485FFADCF324448E7EDFEC9F67C0@SN6PR11MB3485.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8SwKND2sxK6MFUhzBvqItOAdOXqTgaxF0lkkRN4Kgg2cTOSui6X7q6DtHL5Nk3NUfdKIloiCnTPOPMA9iwLHJ46U4FD3QaILLJCEnBmWf+sF0LgywqAaCoRGerw5yJn5ws/8Az41UXibowPny8r06KX4h+DKe5XMZeoMgoGwsrVWXye5BbIY1YmlWg51FZI50mdRRr2+9xvqaVaoZot/p3ajjFnxm3jwYW7V9n1BY6pWMoxp6zplwRxdVGSpngboiWT6kqLrhQGfvFNjcgaXS3CBh8cpHNC5D1+isdohm773IzicHom4cKG+nbTeXTsYUqt0rcaPlyUoV9/BLKeHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(478600001)(6506007)(53546011)(186003)(26005)(2906002)(76116006)(4326008)(66446008)(64756008)(66556008)(66476007)(110136005)(66946007)(316002)(54906003)(33656002)(8936002)(7696005)(9686003)(8676002)(83380400001)(5660300002)(52536014)(71200400001)(86362001)(107886003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: A/jvef1F6MfJTfzsr8Pocqo7RR8sKvObDWigCnLK0+gfX/gXOYa4slWAeBMYKjBeuhWIZDwELiMi9VnDRxF2amjjDTIJUsbtaGF8k0FGSQYFWJoPH5PE9yti4t7OBxad7ekdBb9zs9insmFhC4cuc+ZSepPjvsKJ6y5uHhqwPP6lsGq+KgYLfra/KffYznnJc1lZrjR9NlcMACd+sTMr7OxZzPg+sQk0XplYhScn/ggv3J+KrmlZPpcv5JUKb+/qCTt0STcqW9Fhf+BwhiLkmkzNdnNFx+dNyfNDvNyeGdRvyslmvG/PARt1V7Y/w4DiLsaxAh7V92nPB7zAcCTezvQvx1DkXZyGJT/7zltME7PxsIIt7fIoqEDU4P/3YsU54Z3x8SZruqCTjErGToa3RNJqkahxHysI0y4lgCLvN0p2beHTt1qJVZ3P09sA2vRBMkXW8vqW5DDiM1p6S+2s13itjTwMZk1v8cy9T1BLIME=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4145571d-f105-462a-515a-08d82a7e0871
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 18:20:06.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bH8xRdwXHioYFYE+D7SHjfnORQ2P1JOn/dUwmE0T+KsFD9kPY7hEg4hcjRxLvG3D3yXjmWTEJDLgqwEqPMpUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3485
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgSnVseSAxMiwgMjAyMCA5OjU0
IEFNDQo+IFRvOiBFYWRzLCBHYWdlIDxnYWdlLmVhZHNAaW50ZWwuY29tPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gYXJuZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmcNCj4gQ2M6IEthcmxzc29uLCBNYWdudXMgPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5jb20+
OyBUb3BlbCwgQmpvcm4NCj4gPGJqb3JuLnRvcGVsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwNC8yMF0gZGxiMjogYWRkIGRldmljZSBpb2N0bCBsYXllciBhbmQgZmlyc3QgNCBp
b2N0bHMNCj4gDQo+IE9uIDcvMTIvMjAgNjo0MyBBTSwgR2FnZSBFYWRzIHdyb3RlOg0KPiA+ICtp
bnQgZGxiMl9pb2N0bF9kaXNwYXRjaGVyKHN0cnVjdCBkbGIyX2RldiAqZGV2LA0KPiA+ICsJCQkg
IHVuc2lnbmVkIGludCBjbWQsDQo+ID4gKwkJCSAgdW5zaWduZWQgbG9uZyBhcmcpDQo+ID4gK3sN
Cj4gPiArCXUxNiBzeiA9IF9JT0NfU0laRShjbWQpOw0KPiA+ICsNCj4gPiArCWlmIChfSU9DX05S
KGNtZCkgPj0gTlVNX0RMQjJfQ01EKSB7DQo+IA0KPiBEb2VzIHRoaXMgYm91bmRzIGNoZWNrIG5l
ZWQgdG8gdXNlIGFycmF5X2luZGV4X25vc3BlYygpIGZyb20NCj4gPGxpbnV4L25vc3BlYy5oPiA/
DQo+IA0KPiA+ICsJCWRldl9lcnIoZGV2LT5kbGIyX2RldmljZSwNCj4gPiArCQkJIlslcygpXSBV
bmV4cGVjdGVkIERMQiBjb21tYW5kICVkXG4iLA0KPiA+ICsJCQlfX2Z1bmNfXywgX0lPQ19OUihj
bWQpKTsNCj4gPiArCQlyZXR1cm4gLTE7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGRs
YjJfaW9jdGxfY2FsbGJhY2tfZm5zW19JT0NfTlIoY21kKV0oZGV2LCBhcmcsIHN6KTsgfQ0KPiAN
Cj4gSSBkb24ndCBrbm93IGlmIGl0IG5lZWRzIHRvIG9yIG5vdC4gSSBqdXN0IHdhbnQgdG8gbWFr
ZSBzdXJlIHRoYXQgeW91IG9yDQo+IHNvbWVvbmUgaGFzIHRob3VnaHQgYWJvdXQgaXQuDQoNClRo
YW5rcyBmb3IgY2F0Y2hpbmcgdGhpcyAtLSBpdCBkb2VzLiBQZXIgQXJuZCdzIHN1Z2dlc3Rpb24s
IEknbSBnb2luZyB0byBjb252ZXJ0IHRoaXMgdG8gYSBzd2l0Y2ggc3RhdGVtZW50IGFuZCBhdm9p
ZCB0aGUgaW5kZXggYWx0b2dldGhlci4NCg0KVGhhbmtzLA0KR2FnZQ0KDQo+IA0KPiAtLQ0KPiB+
UmFuZHkNCg==
