Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D8DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E072C2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="OM0wVyfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgF2SnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:43:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:30075 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgF2Smx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:53 -0400
IronPort-SDR: 7KAd3cwHZZ8dHxj6b/Q1epblE+h/V4kHMyOnUs1aFAk/uMc4nYkFFFUqsZ20WMiC3467glQDrh
 5qPvqcnN+KHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133440408"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="133440408"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 09:51:24 -0700
IronPort-SDR: 32QtBc79sTfXvuUOzpY7B/3eTfM7h7JUZXbX7qFI3+TsYwuY1Cat1mi6S+3AlYWer4L5wVGsAh
 vA+KmOgcZwow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="280929348"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2020 09:51:23 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 09:51:23 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 09:51:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 29 Jun 2020 09:51:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYQewe24W1bpC1dIQUPlKGU9h2RBJdXipTiDrMe11tmesuPo8qfcBpHIF5vxOyY5FX9A2YDQK3sOTs91qbT99PxJDRYoUZkF173KdzsnLz1DG5nO/Sa9O0S0+4HstLAPIpEPFetNuMR0+myLLQeaVd1LNfqMbLSCRem6cYVgAruSa7jvMlwYTpAp8ti5J2MWYqEEXaEKHcxWDvZFMZdkni0PJrxGqLpRmtewG5QinX340MzY9NZJgCMCHqrl07HjvphFjalFwzoPgs9l//LsKipa/+/EckjFcYznVqHCLT/LcFkPaQd04avl8mq5eVetbZXA35OGukWuYHe+8BG+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiPlLrVr1vToDHzjnmwPmL3lGNzFSXbk0vICoF52MSs=;
 b=KveTY9c+RQTmx2rtidtxycBYFptZKZWEJ9ehlrMrkg0BaGoMyd8l6BwESm0oa9OfxPVe4ikkzFhG8dKo48n2fGaYB7pWJtQ80Qrfnmyu/UBYaR91e1kJ+dTqjXPLtR/EyaaMoh/1l+WOXLU3LxKk72u6mEHVc6FBULt19wtCtphDfhTyhGBVMgqzuXVd0Poox7x4E4rZ9wKWCi2QY2g3NuwLLxJ72yLM05F/Cigjv95K3JpdCcjVVPAFZ7VCOBKu+A+MNP6U/aRRkkLY1BH+a5L3jOTcI51YIm7EA8VV8pXomQX9jWtaUGR7wmLEF5iFmEX/37PNUqIBAVs3PDh9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiPlLrVr1vToDHzjnmwPmL3lGNzFSXbk0vICoF52MSs=;
 b=OM0wVyfIr2B/IUG0YKL7kUNCenxcCC76TYOraU06z95gm7VGW1Ot6IcpmusjS9E0bhPIUE85TlVPneyCJ9er/FjV7f1jIyxXrCeMXgUr25Xfak4hHghE1R5CErEAgFGpSU3cYEFH61xY8PcfiDkMOqJkT73EtOkN7OTYNXxvEeM=
Received: from BY5PR11MB4307.namprd11.prod.outlook.com (2603:10b6:a03:1bd::27)
 by BYAPR11MB3816.namprd11.prod.outlook.com (2603:10b6:a03:f8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 16:51:20 +0000
Received: from BY5PR11MB4307.namprd11.prod.outlook.com
 ([fe80::81b2:faf6:4cc3:261a]) by BY5PR11MB4307.namprd11.prod.outlook.com
 ([fe80::81b2:faf6:4cc3:261a%4]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 16:51:20 +0000
From:   "N, Harshapriya" <harshapriya.n@intel.com>
To:     =?utf-8?B?xYF1a2FzeiBNYWpjemFr?= <lma@semihalf.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        "Ross Zwisler" <zwisler@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bob Brandt <brndt@google.com>,
        "Marcin Wojtas" <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>,
        "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>
Subject: RE: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
Thread-Topic: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
Thread-Index: AQHWTgYTwQHbv3cvDU6zdR5ijzs9kqjvzAZQ
Date:   Mon, 29 Jun 2020 16:51:20 +0000
Message-ID: <BY5PR11MB4307284BAE6DA415CFC0865CFD6E0@BY5PR11MB4307.namprd11.prod.outlook.com>
References: <20200521162518.1809995-1-lma@semihalf.com>
 <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
 <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com>
 <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
 <268b11b6-9f4c-d769-a7f9-536d77198705@linux.intel.com>
 <CAFJ_xboUTDtnpvskb2dY4fGhGLNkEgT0sH3dU0NYJV_Cb_gqPw@mail.gmail.com>
In-Reply-To: <CAFJ_xboUTDtnpvskb2dY4fGhGLNkEgT0sH3dU0NYJV_Cb_gqPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: semihalf.com; dkim=none (message not signed)
 header.d=none;semihalf.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.23.139.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e53c365-e098-430c-f0a5-08d81c4ca631
x-ms-traffictypediagnostic: BYAPR11MB3816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB38162AB9AD201DD666C98C5EFD6E0@BYAPR11MB3816.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xGl5nPObWBtbK95PaFxov7bQTqLKVBza24jL2HCXss8rfa2cirUPGOBJi0J6l0nIiWFTF2tfSkbQNmYKlO72o9qxAUUZfdwXNQqWmyMMIUhAtbfPAg3genhLTIRj7F5yD/x/DzE+ywws+N/4FSPXMixetMOiTaWECfqSz4IA3/5q34G4DM79y9fnYDXiAbi8uqWyJWgtmOwbIasM5aia772V2zltz/twtoylU8sqHUWC/zmw8FW+0mQ8/P2FZ9m6+/d722H5UBRSDLoQDn1MUWzg8BCl9VISGb8LBDSfuy+LCEyXBUlE13RChUWL7St45Cks2iQW8Rg20pL9H4QFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(8936002)(7416002)(7696005)(2906002)(26005)(8676002)(66946007)(76116006)(5660300002)(71200400001)(66446008)(6916009)(52536014)(66476007)(53546011)(33656002)(6506007)(64756008)(66556008)(186003)(9686003)(83380400001)(86362001)(54906003)(478600001)(316002)(4326008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Z2cJYYVcSgFNas8BXapxVKrfRPU3WwRMi5x1kV4yfyfLEgVSDW6bqnWR4u0FfRj53+n5uORp34e5Ll8O/zKPU1Rbpn5a69rD834raAsNzHvVNB25vBkKYiCdEksLpXzPPt2sx2kWPQpGJRMYoQTtrjidzrrzHPgVgEKRzIwcBfVdxUZSB/nT0c2BvH9o0hAktlnVnWAlu5kwlWq9iCU4Oz9avBlD9DMXTZ+I/HN6E0yqxZdF80G1s5x6iuonanM9BNCnWNbYOQ/HpI0Sq+J7iYKdhnVMr8Y+JBC41tN3r9qy5u5GOxFng+uxt1sHZ66yK9x5OrLZf6yYHf7BHXvh/bfB8AhCBE6FaJQKQeHVIK+aIh5dW46gtZin5i7DxoG5OOgOEtrlJOT9W0tvjfLbPZrMUAUeqWFbZsbo7r17CiBlUGf9HTwYpzmEanCtE0R1VeEoBl1nyRfRYCCdFPXYYOagJEUprvpAaQvVFAs0mos=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e53c365-e098-430c-f0a5-08d81c4ca631
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 16:51:20.2399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n39pIa4auOrt/iNS1TPH0eGyhpvF1jwGZLHeZYDh+k6oQScfi08YUUUID2tRTfeM5w4xjRjPFW/vxtf/9ku3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3816
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiDFgXVrYXN6IE1hamN6YWsgPGxt
YUBzZW1paGFsZi5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAyOSwgMjAyMCA0OjExIEFNDQo+
IFRvOiBOLCBIYXJzaGFwcml5YSA8aGFyc2hhcHJpeWEubkBpbnRlbC5jb20+DQo+IENjOiBhbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtDQo+
IGxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPjsgSmllIFlhbmcgPHlhbmcuamllQGxpbnV4
LmludGVsLmNvbT47IFJhZG9zbGF3DQo+IEJpZXJuYWNraSA8cmFkQHNlbWloYWxmLmNvbT47IFJv
c3MgWndpc2xlciA8endpc2xlckBnb29nbGUuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IExpYW0gR2lyZHdvb2QgPGxpYW0uci5naXJkd29vZEBsaW51eC5pbnRlbC5jb20+
Ow0KPiBCb2IgQnJhbmR0IDxicm5kdEBnb29nbGUuY29tPjsgTWFyY2luIFdvanRhcyA8bXdAc2Vt
aWhhbGYuY29tPjsgQWxleA0KPiBMZXZpbiA8bGV2aW5hbGVAY2hyb21pdW0ub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzXSBBU29DOiBJbnRlbDoga2JsX3J0NTY2M19ydDU1MTRfbWF4OTg5
Mjc6IFNwbGl0DQo+IGJlX2h3X3BhcmFtc19maXh1cCBmdW5jdGlvbg0KPiANCj4gSGkgSGFyc2hh
LA0KPiANCj4gV2Ugd291bGQgbGlrZSB0byBjb250aW51ZSB0aGUgd29yayBvbiB0aGlzLCBjb3Vs
ZCB5b3UgcGxlYXNlIHN1Z2dlc3QgdGhlDQo+IGNvcnJlY3QgYXBwcm9hY2guDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEx1a2Fzeg0KPiANCj4gY3p3LiwgMjEgbWFqIDIwMjAgbyAyMDoxMCBQaWVy
cmUtTG91aXMgQm9zc2FydCA8cGllcnJlLQ0KPiBsb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNv
bT4gbmFwaXNhxYIoYSk6DQo+ID4NCj4gPg0KPiA+DQo+ID4gT24gNS8yMS8yMCAxMjozMCBQTSwg
xYF1a2FzeiBNYWpjemFrIHdyb3RlOg0KPiA+ID4gSGkgUGllcnJlDQo+ID4gPg0KPiA+ID4gSWYg
eW91IHdpbGwgdGFrZSBhIGxvb2sgYXQgdGhlIG9yaWdpbmFsIGthYnlsYWtlX3NzcF9maXh1cCgp
IHlvdQ0KPiA+ID4gd2lsbCBzZWUgdGhhdCBpdCBpcyBjaGVja2luZyB3aGV0aGVyIHRoZSByZWxh
dGVkIEZFIGlzICJLYmwgQXVkaW8NCj4gPiA+IFBvcnQiLCAiS2JsIEF1ZGlvIEhlYWRzZXQgUGxh
eWJhY2siLCAiS2JsIEF1ZGlvIENhcHR1cmUgUG9ydCIgb3INCj4gPiA+ICJLYmwgQXVkaW8gRE1J
QyBjYXAiIC0gdGhlbiBmb3IgdGhlIGZpcnN0IDMgY2FzZXMgaXQgc2V0cyBtaW4vbWF4DQo+ID4g
PiBjaGFubmVscyB0byAyIHdoaWxlIGZvciB0aGUgIktibCBETUlDIGNhcCIgaXQgY2FuIGJlIDIg
b3IgNCwgdGhhdCdzDQo+ID4gPiBpcyB3aHkgSSdtIHRyeWluZyB0byBzcGxpdCB0aGlzLCBidXQg
bWF5YmUgSSdtIG1pc3NpbmcgaGVyZSBzb21ldGhpbmcuDQo+ID4NCj4gPiBJIGRvbid0IHVuZGVy
c3RhbmQgdGhpcyBjb2RlIGVpdGhlci4NCj4gPg0KPiA+IEkgYmVsaWV2ZSB0aGUgaW50ZW50IGlz
IHRoYXQgZm9yIGFsbCBTU1AxLVJUNTY2MyB1c2FnZXMsIHdlIHNob3VsZCB1c2UNCj4gPg0KPiA+
ICAgICAgICAgICAgICAgICByYXRlLT5taW4gPSByYXRlLT5tYXggPSA0ODAwMDsNCj4gPiAgICAg
ICAgICAgICAgICAgY2hhbi0+bWluID0gY2hhbi0+bWF4ID0gMjsNCj4gPiAgICAgICAgICAgICAg
ICAgc25kX21hc2tfbm9uZShmbXQpOw0KPiA+ICAgICAgICAgICAgICAgICBzbmRfbWFza19zZXRf
Zm9ybWF0KGZtdCwgU05EUlZfUENNX0ZPUk1BVF9TMjRfTEUpOw0KPiA+DQo+ID4gVGhhdCBpcyBw
cmV0dHkgZWFzeSB0byBtb3ZlIHRvIGEgZGVkaWNhdGVkIHNzcDEgZml4dXAuDQo+ID4NCj4gPiBm
b3IgU1NQMCwgd2UgaGF2ZSBSVDU1MTQgZm9yIGNhcHR1cmUgYW5kIG1heDk4OTI3IGZvciBwbGF5
YmFjaywgYnV0DQo+ID4gdGhlIGV4aXN0aW5nIGNvZGUgZG9lcyBub3QgZXhwbGljaXRseSBkZWFs
IHdpdGggcmF0ZS9jaGFubmVscy9mb3JtYXQNCj4gPiBmb3IgYWxsIGNhc2VzLCBzbyBpdCdzIG5v
dCBjbGVhciB3aGF0IHNob3VsZCBoYXBwZW4uDQo+ID4NCj4gPiBIYXJzaGEsIGNhbiB5b3UgaGVs
cCBoZXJlPw0KQXBvbG9naWVzIGZvciBtaXNzaW5nIHRoZSBlbWFpbCBJIGhhZCB0byByZXNwb25k
IHRvLg0KDQpTU1AwIC0gaGFzIHRoZSBzcGVha2Vycw0KU1NQMSAtIGhhcyBoZWFkc2V0IGFuZCBk
bWljDQpGb3Igc3BlYWtlcnMgYW5kIGhlYWRzZXRzIGl0cyA0OEtoeiwgMiBjaCBhbmQgMjQgYml0
IGFuZCB0aGlzIHNldHRpbmcgaXMgZG9uZSBiYXNlZCBvbiB0aGUgZnJvbnQtZW5kIGRhaQ0KRm9y
IHNwZWFrZXJzLCBob3dldmVyIHN1cHBvcnQgb25seSAxNiBiaXQsIHNvIHdlIHNldCBpdCBiYWNr
IHRvIDE2IGJpdA0KSWYgdGhlIGZyb250IGVuZCBkYWkgaXMgZG1pYywgdGhlbiB0aGUgY2hhbm5l
bCBpcyBzZXQgdG8gZWl0aGVyIDIgb3IgNCBkbWljX2NvbnN0cmFpbnRzLiBObyBvdGhlciBmb3Jt
YXRzIG5lZWQgdG8gYmUgc2V0Lg0KDQpBbGwgdGhlIFNTUDEgdXNhZ2VzIGRvIG5vdCBoYXZlIHRo
ZSBzYW1lIHBhcmFtZXRlcnMgKGFzIGRtaWMgaXMgb24gU1NQMSBhbmQgaXRzIGRpZmZlcmVudCBh
cyBnaXZlbiBhYm92ZSkNCk1vc3QgcGFyYW1ldGVycyBhcmUgc2FtZSBmb3Igc3BlYWtlcnMgYW5k
IGhlYWRzZXQgd2hpY2ggYXJlIG9uIGRpZmZlcmVudCBTU1AuIFRoaXMgaXMgdGhlIHJlYXNvbiB3
ZSBoYWQgYSBzaW5nbGUgZml4dXAgZnVuY3Rpb24uDQoNCklzIHRoZXJlIGEgcmVhc29uIHdoeSB0
aGUgZml4dXAgZnVuY3Rpb24gbmVlZHMgdG8gYmUgc3BsaXQ/DQoNCj4gPg0KPiA+ID4NCj4gPiA+
IEJlc3QgcmVnYXJkcywNCj4gPiA+IEx1a2Fzeg0KPiA+ID4NCj4gPiA+IGN6dy4sIDIxIG1haiAy
MDIwIG8gMTk6MTcgUGllcnJlLUxvdWlzIEJvc3NhcnQNCj4gPiA+IDxwaWVycmUtbG91aXMuYm9z
c2FydEBsaW51eC5pbnRlbC5jb20+IG5hcGlzYcWCKGEpOg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+
Pg0KPiA+ID4+IE9uIDUvMjEvMjAgMTI6MDggUE0sIMWBdWthc3ogTWFqY3phayB3cm90ZToNCj4g
PiA+Pj4+DQo+ID4gPj4+PiBkb24ndCBhZGQgYSBuZXcgZGFpbGluaywgdGhpcyBpcyBub3Qgcmln
aHQuDQo+ID4gPj4+Pg0KPiA+ID4+PiBDYW4geW91IGFkdmlzZSBhIGJldHRlciBzb2x1dGlvbiBo
b3cgdG8gYXNzaWduIGRpZmZlcmVudCBmaXh1cA0KPiA+ID4+PiBmdW5jdGlvbnMgdG8gbWljIGFu
ZCB0byBzcGVha2Vycz8gSSB3YXMgbG9va2luZyBhdCAiZG1pYzAxIg0KPiA+ID4+PiBkYWlsaW5r
IGluIHNrbF9uYXU4OGwyNV9tYXg5ODM1N2EuYyBhcyBhbiBleGFtcGxlLg0KPiA+ID4+DQo+ID4g
Pj4gSSBhbSBub3Qgc3VyZSBJIGZvbGxvdy4gdGhlIERNSUNzIGFyZSBoYW5kbGVkIG9uIGEgc2hh
cmVkIFNTUCwgc28NCj4gPiA+PiBob3cgd291bGQgb25lIHNldCBhIGRpZmZlcmVudCBmaXh1cD8g
VGhlIHdvcmQgbGVuZ3RoIGhhdmUgdG8gYmUgdGhlIHNhbWUuDQo=
