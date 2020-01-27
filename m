Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E53C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE39221739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SgyJTeTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0SCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:02:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:32891 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0SCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:02:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 10:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,370,1574150400"; 
   d="scan'208";a="221806784"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2020 10:02:42 -0800
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Jan 2020 10:02:41 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Jan 2020 10:02:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 27 Jan 2020 10:02:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjnw+KS0Ubu570cdO2iGodz1+4CtFc2Vs3n5EugnMxXTg5ELOXbf+7XZmhaTS6R1L4TbqlyoZ6LqmefHjnhbq0DxXE6W2BeCQI3YQM4Mpp4D2k6GBRdNLQgqBPqr8IGCmEssOy86AeF+yCocM/rYDIEOUvyHcL5s89uxaf5xg+QB412LJSWUWSl/6p3odvZqBEu5oGCkNND3QuNvHbMQ4ex1YA8/2iLncJgCdIfPZnxrILyEjelGCIQMdErU+0r0gf1aw1F//juCh94GQfzPxQV6Ox0r0oj+dqHF1Q3vNnKp2Sbwbiu8oRco/C5+AfPpr3Mt26yqrIHntEE4GbNthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux2/K7EAriV0n6DTUs2UDSeUP8ukGf5a8knE91WPFKI=;
 b=ARstxll+xHYixgFaxtAuASMJEV3rV7EUHfASd5LWA3Adb/Vxxz952TkRLJpIDQiPRG3gssRyuNlqJA3UrlbLqM+gnODkTTq0kWIT2aXxpWBtmO6falP23J1IclCASBbs5Qtt28C7PRofkr8Py0YUe2k+iHLKQYnlWDbZb14uYRyJlMC/0ctKR45eRMTlRq8H8lw8fZqAf7W/FdEl188JWt9uBu+9w6l/p7CLHEqPyOdazNpgXFTQuYw5A2OGcoacTclCFzPp6v1R8qULyBM4Va+DNMnpdi11PTFAgWV7qr+2xLeT+72m8/M6gY1sXLOy14xx57J9NIAf/To5dbTdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux2/K7EAriV0n6DTUs2UDSeUP8ukGf5a8knE91WPFKI=;
 b=SgyJTeTIbkT6Z6lX3SEp/tlYT5ShDwnvoc3vt3QBxfUkEG+Z+lMDLd751TtSucffqgyeYzPqo1Ne3udeciPw/pO4Z1f5WVUlpXvz4y9QFIpxReBsOm/pXH8drqBpmB7HXyR6HG1aQCB9xdZ4fHcaSA1P7PP2tnTJd2T8bFcaBGU=
Received: from BL0PR11MB3107.namprd11.prod.outlook.com (20.177.205.12) by
 BL0PR11MB3076.namprd11.prod.outlook.com (20.177.206.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Mon, 27 Jan 2020 18:02:32 +0000
Received: from BL0PR11MB3107.namprd11.prod.outlook.com
 ([fe80::1979:abd1:5faf:5611]) by BL0PR11MB3107.namprd11.prod.outlook.com
 ([fe80::1979:abd1:5faf:5611%3]) with mapi id 15.20.2665.026; Mon, 27 Jan 2020
 18:02:32 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Box, David E" <david.e.box@intel.com>
Subject: RE: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Thread-Topic: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Thread-Index: AQHV0uehR65JqlDsd0qQ+gWeMY04Aqf+WQcAgAB1iqA=
Date:   Mon, 27 Jan 2020 18:02:32 +0000
Message-ID: <BL0PR11MB31071AD85775C09B8EC26608F20B0@BL0PR11MB3107.namprd11.prod.outlook.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
 <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com>
In-Reply-To: <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [134.134.136.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9c789a4-0f3b-462d-aec7-08d7a3531511
x-ms-traffictypediagnostic: BL0PR11MB3076:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3076DA924398DB468DBA6FD7F20B0@BL0PR11MB3076.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(71200400001)(6916009)(53546011)(6506007)(7696005)(478600001)(316002)(54906003)(8676002)(33656002)(86362001)(55016002)(9686003)(2906002)(26005)(4326008)(66476007)(5660300002)(64756008)(8936002)(81156014)(81166006)(66446008)(66946007)(66556008)(52536014)(186003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3076;H:BL0PR11MB3107.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UG/HRfInY63dJA2An3gRjI8D0jujujya/JH0o/VOVNA6Kk4IJH1kONEQKynPqv/gvC/NycpOdUSvMEXLf9ZFOIuIGi2uqRXc+/oSTxwTXEIXWLAnPnEfVP2gN7EEu3+igqokYEEHiUe/whhtsSaL0/PfPvXqrfFHfgPKlQp6p3WUFA0+bCC/1tNN3IuCHU28LTm2vL7TgbKxUYsPM5PQ57wjlc7+lPVC0jiczMhaSsGDTak0J7a0z+fuAZ3Ip2H63asZphZcDNykJXEDtsPN86T5hrOmW29yAnwe5ueDSiIR8fARool0s+t14Cp8Ohp02cMH+TYO4mNDqTcgHlRoBtXMKKOg1JkYaiCCFGSB7iH0W/ZfbE+6sn2H0O3tPZ937ByE9L42x0YWKGmTCt1YJHYfyF0+Jvt7AI4v0CUgbsfg85XH1p+VQniTi157R9za
x-ms-exchange-antispam-messagedata: 71S5CQThF2z7Of/3fMwASntJ532zBFzgjGl1RIRi88hZyG9G0wD2L1B7OJxWz5zaq7D31XOyugQRtQP4NB5hMR0Qeod/ohj2jXAZ4xvSyb38IJLAp35Ne8aEIMEHLe9f7GYHYX3wTGcyA+b+HyPwpQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c789a4-0f3b-462d-aec7-08d7a3531511
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 18:02:32.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwnDXV+yhbcCzkAEVGEiYb0vmEAtUHayV3s2uEkNK0ZiShIh+7SXDH4T2CWy/ZjKfHVdiB72myoCeE2go7u/OQXrVTKTXCbd+QL4P+ZnkT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3076
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjcs
IDIwMjAgMjo0OSBBTQ0KPiBUbzogS2FtbWVsYSwgR2F5YXRyaSA8Z2F5YXRyaS5rYW1tZWxhQGlu
dGVsLmNvbT4NCj4gQ2M6IFBsYXRmb3JtIERyaXZlciA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwNCj4gTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgU29tYXlhamksIFZpc2h3YW5hdGgNCj4gPHZpc2h3YW5hdGguc29t
YXlhamlAaW50ZWwuY29tPjsgRGFycmVuIEhhcnQgPGR2aGFydEBpbmZyYWRlYWQub3JnPjsNCj4g
V2VzdGVyYmVyZywgTWlrYSA8bWlrYS53ZXN0ZXJiZXJnQGludGVsLmNvbT47IFBldGVyIFppamxz
dHJhIChJbnRlbCkNCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgUHJlc3RvcGluZSwgQ2hhcmxl
cyBEDQo+IDxjaGFybGVzLmQucHJlc3RvcGluZUBpbnRlbC5jb20+OyBQYW5kcnV2YWRhLCBTcmlu
aXZhcw0KPiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+OyBBbmR5IFNoZXZjaGVua28N
Cj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IEJveCwgRGF2aWQgRQ0KPiA8
ZGF2aWQuZS5ib3hAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAvN10gcGxh
dGZvcm0veDg2OiBpbnRlbF9wbWNfY29yZTogQWRkIGRlYnVnZnMNCj4gZW50cmllcw0KPiANCj4g
T24gRnJpLCBKYW4gMjQsIDIwMjAgYXQgMTA6NTkgUE0gR2F5YXRyaSBLYW1tZWxhDQo+IDxnYXlh
dHJpLmthbW1lbGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gVGln
ZXIgTGFrZSBwbGF0Zm9ybSBzdXBwb3J0cyA4IHN1Yi1zdGF0ZXMvbG93IHBvd2VyIG1vZGVzIG9m
IFMwaXguIEFkZA0KPiA+IGRlYnVnZnMgZW50cmllcyB0byBwbWNfY29yZSBkcml2ZXIgdG8gYWNj
ZXNzIGxvdyBwb3dlciBtb2RlIHJlZ2lzdGVycw0KPiA+IGFuZCByZXNpZGVuY2llcy4NCj4gPg0K
PiA+IFBhdGNoIDE6IEFkZCBkZWJ1Z2ZzIGVudHJ5IHRvIGFjY2VzcyBzdWItc3RhdGUgcmVzaWRl
bmNpZXMgUGF0Y2ggMjoNCj4gPiBBZGQgZGVidWdmcyBlbnRyeSBmb3IgbG93IHBvd2VyIG1vZGUg
c3RhdHVzIHJlZ2lzdGVycyBQYXRjaCAzOg0KPiA+IFJlZmFjdG9yIHRoZSBkcml2ZXIgYnkgcmVt
b3ZpbmcgcmVkdW5kYW50IGNvZGUgUGF0Y2ggNDogUmVtb3ZlIHNscF9zMA0KPiA+IGF0dHJpYnV0
ZXMgZnJvbSB0Z2xfcmVnX21hcCBQYXRjaCA1OiBBZGQgYW4gYWRkaXRpb25hbCBwYXJhbWV0ZXIg
dG8NCj4gPiBwbWNfY29yZV9scG1fZGlzcGxheV9tYXAoKSBQYXRjaCA2OiBEdW1wIGxvdyBwb3dl
ciBzdGF0dXMgcmVnaXN0ZXJzIG9uDQo+ID4gYW4gUzBpeC55IGZhaWx1cmUgUGF0Y2ggNzogQWRk
IGRlYnVnZnMgc3VwcG9ydCB0byBhY2Nlc3MgbGl2ZSBzdGF0dXMNCj4gPiByZWdpc3RlcnMNCj4g
DQo+IEl0IGRvZXNuJ3QgYXBwbHkgdG8gb3VyIGZvci1uZXh0IGJyYW5jaC4NClNvcnJ5IHRvIGhl
YXIgdGhhdC4gSSd2ZSByZWJhc2VkIHRoZSBzZXJpZXMgb24gbWFpbmxpbmUgNS41LXJjNy4gU2hv
dWxkIEkgcmViYXNlIGl0IG9uIGZvci1uZXh0IGJyYW5jaD8NCj4gDQo+ID4NCj4gPiBHYXlhdHJp
IEthbW1lbGEgKDcpOg0KPiA+ICAgcGxhdGZvcm0veDg2OiBpbnRlbF9wbWNfY29yZTogQWRkIGRl
YnVnZnMgZW50cnkgdG8gYWNjZXNzIHN1Yi1zdGF0ZQ0KPiA+ICAgICByZXNpZGVuY2llcw0KPiA+
ICAgcGxhdGZvcm0veDg2OiBpbnRlbF9wbWNfY29yZTogQWRkIGRlYnVnZnMgZW50cnkgZm9yIGxv
dyBwb3dlciBtb2RlDQo+ID4gICAgIHN0YXR1cyByZWdpc3RlcnMNCj4gPiAgIHBsYXRmb3JtL3g4
NjogaW50ZWxfcG1jX2NvcmU6IFJlZmFjdG9yIHRoZSBkcml2ZXIgYnkgcmVtb3ZpbmcNCj4gPiAg
ICAgcmVkdW5kYW50IGNvZGUNCj4gPiAgIHBsYXRmb3JtL3g4NjogaW50ZWxfcG1jX2NvcmU6IFJl
bW92ZSBzbHBfczAgYXR0cmlidXRlcyBmcm9tDQo+ID4gICAgIHRnbF9yZWdfbWFwDQo+ID4gICBw
bGF0Zm9ybS94ODY6IGludGVsX3BtY19jb3JlOiBBZGQgYW4gYWRkaXRpb25hbCBwYXJhbWV0ZXIg
dG8NCj4gPiAgICAgcG1jX2NvcmVfbHBtX2Rpc3BsYXkoKQ0KPiA+ICAgcGxhdGZvcm0veDg2OiBp
bnRlbF9wbWNfY29yZTogRHVtcCBsb3cgcG93ZXIgc3RhdHVzIHJlZ2lzdGVycyBvbiBhbg0KPiA+
ICAgICBTMGl4LnkgZmFpbHVyZQ0KPiA+ICAgcGxhdGZvcm0veDg2OiBpbnRlbF9wbWNfY29yZTog
QWRkIGRlYnVnZnMgc3VwcG9ydCB0byBhY2Nlc3MgbGl2ZQ0KPiA+ICAgICBzdGF0dXMgcmVnaXN0
ZXJzDQo+ID4NCj4gPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfcG1jX2NvcmUuYyB8IDMw
MQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrLS0tICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbF9wbWNfY29yZS5oIHwNCj4gPiAyOCArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMDIg
aW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBDYzogU3Jpbml2YXMgUGFu
ZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+DQo+ID4gQ2M6IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiA+IENjOiBEYXZp
ZCBCb3ggPGRhdmlkLmUuYm94QGludGVsLmNvbT4NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+
IA0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
