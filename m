Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8ECC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6C520709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lmc1Q07V";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fMt8p13J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbgGVPTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:19:10 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:6850 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgGVPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595431147; x=1626967147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ooqY3uGKQ/zgrFWYr14l/c7bm1A04x+u2YSAEJbXLQA=;
  b=lmc1Q07VSErzaZw0Skfx+2gbwkFdDdLvmAikYy32PjkyY9r4Rn8kGR4s
   tTRCObYfQLy78T5p4qxMG7DsT6f23MSy+/MaJLFVu3Y/asTZXWKlnoJFm
   nGirZiM7d8uBGJpl6nXWEOPfcVFwbKPNY7JIcO98NFYYP67lwtnm90qEg
   nA3W+HBpw7YXwy/5jbDD/9NFUoNdnrWw6YP38T2+1WNaxe3S+CrZqxx/q
   Fo0pRtM+IXjC+iyzvHboQNCAnXEUEPD5s8gGEMlXGzKxFp6Isr3Z06gpi
   iQYNXkw65xwSEHgQRWwHNHZLxQACQnJK7bCoI48GUh1mQqOIRrjwwqxa8
   Q==;
IronPort-SDR: VqsjRegBCQFsrbN30qox5E2NF99kYPh6bVNox3uvII9TfGWLPdEzW9C0XKLdWH9uAjMSbQ064v
 kA7MI/30FrwCCYIu7PMIHzjASj4ZbrL/i0vKQGw+ykm7Um/4T31aKp4CGRKQO+bptjVh+q14qH
 4eUEYXv071GHgJWu15Ny0GdWRuF5dPRbD/3dHLZ/cw+HPHyvjwkflmtM4+kJE2b73JQysvtGDc
 mPib5Q/0tdq+FcYRS6l7HXUwm3elg6VO3x+ufpFFtyK+K7hkMK0JX681/vnRe16J/aveBnVndu
 pYA=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="84211138"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 08:18:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 08:18:14 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 22 Jul 2020 08:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2+U8UAYL5LULdfXfWwo5Svdktic+IFEBI2jkc8FkiNc3cdyjAdSvK72brnZ7MaeO3Dnbw9BSjFgPqWJqEZ8/09qFhAciamtAZTw/zuW3rWcSvIpfdIEaqsht2eZMehdmi+BI1WVOLBUrKg7qDo4FqLFxge9zDAcTrv2cNikDLXOxMs5NQiQ9E0Kv3loep1qYM2bz8+nupEe2BIpJ0xkelMWWzCKY8xsPR4kZ4e2Mf13ZFZGAhqN2Vj1eZbB6JEeRBhJJ45R6zuEWrzkIqbyS0cKG5oQlLWZaYDxEz0woVQf+sAtJfsU+KQ1VYDkzD/CGllUJ7n3MofVXf0sVQe44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooqY3uGKQ/zgrFWYr14l/c7bm1A04x+u2YSAEJbXLQA=;
 b=MhnzProomCwRjTUZVOrEm5oyDDlbOiYx18u91VwcU6ynn1uFFQXWdr0C804qb4GxUNwb4PaxDZ1YE6tncnqMpx/WMywX0Uoo7WRo5aqGLTk09lvR6P2Zj3Jc+ibAMDb3qeOvAVpWRPu4gMC8AiPIKe9b74Ex1a1k2yw07JSIn1mB/8w5cFJZRtFVDAtsTMDBQ98HzE5863Hs+d6lNsTfLcOdQsg7RvuwM+mNhtC25KNwtQ9gREnZjWwt2EIgRdvMrynG9y+fxu0jHqmCIW/ssU44ZsiwdKMzcesdSxcFV4/Y5mdgg9u6+miadra8KbRqzdQJMKXAVYTvXe6Qxh5P2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooqY3uGKQ/zgrFWYr14l/c7bm1A04x+u2YSAEJbXLQA=;
 b=fMt8p13Jmdcwn0I/8aZV2jFdKVHM+K0xNwfenw2BobFlnlBYT1rKbdAp565UXwc6mZlHG9VYVz798FYemLnwc5ckk+zAqLhWQXIlz86XGqjpSNadIgftqzO9Zy1zQ7Rnr4Lvtegs+FAoqhxCkfqe6BCQK4L21uhtyT3ZJahVvK4=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3830.namprd11.prod.outlook.com (2603:10b6:a03:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 15:18:51 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::7424:cb9d:3c63:5181]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::7424:cb9d:3c63:5181%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 15:18:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <alexander.sverdlin@nokia.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ibr@ilbers.de>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
Thread-Topic: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
Thread-Index: AQHWYDReSXNx4qFwZkKE6j6AE/Ov3Q==
Date:   Wed, 22 Jul 2020 15:18:50 +0000
Message-ID: <99e3f6c7-e9a6-584c-883a-0882f5137b7b@microchip.com>
References: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
 <b5c17892-24ec-a690-96ca-d2238b8925d1@microchip.com>
 <20200722143604.GQ5180@lahna.fi.intel.com>
In-Reply-To: <20200722143604.GQ5180@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bfc29cb-d35a-4103-0c10-08d82e5289ff
x-ms-traffictypediagnostic: BYAPR11MB3830:
x-microsoft-antispam-prvs: <BYAPR11MB3830138B30E9D67AB6B8D969F0790@BYAPR11MB3830.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiGoKIeTuv2MCHCpBaA8Uq00GsWLBjXI/6xqvene1ZMSyzS6FKxRwinpk/FQo6M6SnLNp/xgPScS6Mdx52W2GFQwBIiittg5z6y7beTXN2OiDpfy8fGVnX3Jr9DclzmuUV4avb8Op4Vrkp5v2DXD/pQd8nLi0BpTfz+MrrOSDRp7cpXF9aFf6a8BbgIg56ishMLHZLsEE5kWzhuM9SgT6N6IVupJI6eNiUbWoi4HXICHV591xG4guOGj/11FB+cCKlRU5y+ggQ645Qz2wbQNjhesfj+aHI1xiWxlZUX6bImz8+6yuuieIJT2VHXQ67U/WCH/tSU5FjmApJ0AXeb/uIbbUCuqtRvrKxziF7Tcl2nA5gZsTHrhWLJVBpvZRCGj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(4326008)(6512007)(53546011)(31686004)(86362001)(6506007)(6486002)(26005)(478600001)(5660300002)(6916009)(186003)(54906003)(66946007)(2906002)(76116006)(8936002)(91956017)(31696002)(66556008)(66476007)(36756003)(64756008)(66446008)(71200400001)(316002)(8676002)(2616005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TBFvLdwd7wvyujqGidNSwtKmADVPbzrsAWgRYNGjv+mIlwlFM7vabhKa3ndztMmDSnchY8m/UhJtOIuELt4OSxDIGu0/4a1d3tBO6nEzZ0KVoNi3haQL+DrBzdMIhRdIpjqkou3ni+7psl99cFmSKGMysyK0STXpx0sy/5E+dTBEfwwfiwxrtg18mHTdDlkulK93fMCRfIEdendglj9rKlWIkIBcji+OZLXp6X1AvduUgtPbSomDesie7nrO04FWkeF/cFkzjBKpnfRs1gi1sgPTxKEJl8lYTYV53LDsB54euNTXhbrw1cw5GksjRhF8sHuE4FN54W0nojrx2ZbD5JatlOsyyQeDINlaK+1s5sfFTEMYAd25ZyXRyZnzOj8bzFEeLA6AyDFGdghF9mG2TqlyXPrZjqoC8DLU5ReAeFCPiNaP9kNnKWLKZ1+J2osvoJiL5gl6A1Jzvr8/5YLYGSYT1QdRo24kzEslkXUgmamNzYFVlu3ad5tgpLWLx/zI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C58886E6C4FFB4C9BC373984F80B070@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfc29cb-d35a-4103-0c10-08d82e5289ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 15:18:50.9045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hi1YpRg0f0vRMBUhbNzwVyw9CImGlmNSfOBOeGmyrDUaD8ynVLWF3gZWsHtymvkjihhCvHVHZPSBUH3yeaUQjopxHWdeejVzKWLvlChjPSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMi8yMCA1OjM2IFBNLCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksDQo+IA0KPiBPbiBXZWQsIEp1bCAyMiwg
MjAyMCBhdCAwMjoyODozMFBNICswMDAwLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+PiArIE1pa2ENCj4+DQo+PiBIaSwgTWlrYSwNCj4+DQo+PiBXb3VsZCB5b3UgcGxlYXNl
IHJldmlldyB0aGUgcGF0Y2ggZnJvbSBiZWxvdz8NCj4gDQo+IFN1cmUsIHRoZXJlIGlzIG1pbm9y
IGNvbW1lbnQgYmVsb3cuDQo+IA0KPj4NCj4+IFRoYW5rcyENCj4+DQo+PiBPbiA3LzIyLzIwIDU6
MDEgUE0sIEFsZXhhbmRlciBTdmVyZGxpbiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEZyb206IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFu
ZGVyLnN2ZXJkbGluQG5va2lhLmNvbT4NCj4+Pg0KPj4+IEFmdGVyIHNwaV9ub3Jfd3JpdGVfZGlz
YWJsZSgpIHJldHVybiBjb2RlIGNoZWNrcyB3ZXJlIGludHJvZHVjZWQgaW4gdGhlDQo+Pj4gc3Bp
LW5vciBmcm9udCBlbmQgaW50ZWwtc3BpIGJhY2tlbmQgc3RvcHBlZCB0byB3b3JrIGJlY2F1c2Ug
V1JESSB3YXMgbmV2ZXINCj4+PiBzdXBwb3J0ZWQgYW5kIGFsd2F5cyBmYWlsZWQuDQo+Pj4NCj4+
PiBKdXN0IHByZXRlbmQgaXQgd2FzIHN1Y2Vzc2Z1bCBhbmQgaWdub3JlIHRoZSBjb21tYW5kIGl0
c2VsZi4gSFcgc2VxdWVuY2VyDQo+Pj4gc2hhbGwgZG8gdGhlIHJpZ2h0IHRoaW5nIGF1dG9tYXRp
Y2FsbHksIHdoaWxlIHdpdGggU1cgc2VxdWVuY2VyIHdlIGNhbm5vdA0KPj4+IGRvIGl0IGFueXdh
eSwgYmVjYXVzZSB0aGUgb25seSB0b29sIHdlIGhhZCB3YXMgcHJlb3Bjb2RlIGFuZCBpdCBtYWtl
cyBubw0KPj4+IHNlbnNlIGZvciBXUkRJLg0KPj4+DQo+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4+PiBGaXhlczogYmNlNjc5ZTVhZTNhICgibXRkOiBzcGktbm9yOiBDaGVjayBmb3Ig
ZXJyb3JzIGFmdGVyIGVhY2ggUmVnaXN0ZXIgT3BlcmF0aW9uIikNCj4+PiBTaWduZWQtb2ZmLWJ5
OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBub2tpYS5jb20+DQo+Pj4g
LS0tDQo+Pj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3BpLmMgfCA4
ICsrKysrKysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNwaS5j
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9sbGVycy9pbnRlbC1zcGkuYw0KPj4+IGluZGV4
IDYxZDJhMGEuLjEzNGIzNTYgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9j
b250cm9sbGVycy9pbnRlbC1zcGkuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29u
dHJvbGxlcnMvaW50ZWwtc3BpLmMNCj4+PiBAQCAtNjEyLDYgKzYxMiwxNCBAQCBzdGF0aWMgaW50
IGludGVsX3NwaV93cml0ZV9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwgdTggb3Bjb2RlLCBjb25z
dCB1OCAqYnVmLA0KPj4+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+PiAgICAgICAgIH0N
Cj4+Pg0KPj4+ICsgICAgICAgLyoNCj4+PiArICAgICAgICAqIFdlIGhvcGUgdGhhdCBIVyBzZXF1
ZW5jZXIgd2lsbCBkbyB0aGUgcmlnaHQgdGhpbmcgYXV0b21hdGljYWxseSBhbmQNCj4+PiArICAg
ICAgICAqIHdpdGggdGhlIFNXIHNldWVuY2VyIHdlIGNhbm5vdCB1c2UgcHJlb3Bjb2RlIGFueSB3
YXksIHNvIGp1c3QgaWdub3JlDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5e
DQo+IFR5cG8sIHNob3VsZCBiZSBzZXF1ZW5jZXIuDQo+IA0KPiBPdGhlcndpc2UgbG9va3MgZ29v
ZCB0byBtZS4NCj4gDQoNCkl0IGxvb2tzIGdvb2QgdG8gbWUgdG9vLiBTaG91bGQgSSBhZGQgeW91
ciBSLWIgdGFnIHdoZW4gYXBwbHlpbmc/DQpJIGNhbiBmaXggdGhlIHR5cG8uDQoNCkNoZWVycywN
CnRhDQoNCg==
