Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA29C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0468C2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="bJMAz+KA";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="AhLEyyJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgIHT3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:29:31 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:19756 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbgIHT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2748; q=dns/txt; s=iport;
  t=1599593337; x=1600802937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BTJKt78EdgO0ivA536SV09mU6sGZ7cdyg15qZByn8W0=;
  b=bJMAz+KA0vemHfcrLJV2JffpQFIVyrq2edxK3HR2c2x/GN2arTgQz2z5
   dalydJFn0Y47OOfaDy8dtyd1wtH6KRpEU1TDF3YEEjDMS/0/EnzCmwiLD
   mCadTSxWSIhTrLi1buIn4m58JcnXdvAZ07CyzqGrMz1AFlwFfrh1lAzMT
   0=;
IronPort-PHdr: =?us-ascii?q?9a23=3Abxz0VRGgLsthYWVon8EVBp1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401A+bU4+d4PVB2KLasKHlDGoH55vJ8HUPa4dFWB?=
 =?us-ascii?q?JNj8IK1xchD8iIBQyeTrbqYiU2Ed4EWApj+He2YkZfXs35Yg6arni79zVHHB?=
 =?us-ascii?q?L5OEJ8Lfj0HYiHicOx2qiy9pTfbh8OiiC6ZOZ5LQ69qkPascxFjA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DRBQA02ldf/4wNJK1fHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgU+BUlEHgUkvLIQ4g0YDjXKYcYJTA1ULAQEBDAEBLQIEAQG?=
 =?us-ascii?q?ESwIXgXoCJDgTAgMBAQsBAQUBAQECAQYEbYVcAQuFcgEBAQECARIREQwBATc?=
 =?us-ascii?q?BDwIBCBgCAiYCAgIwFRACBA4FIoVQAw4gAad+AoE5iGF2gTKDAQEBBYUQGII?=
 =?us-ascii?q?QCRR6KoJxg2iGURuBQT+EIT6EPAEXgwCCYJJeATyjUwqCZZoyIYMJiW+TXpJ?=
 =?us-ascii?q?Rn1cCBAIEBQIOAQEFgWsjgVdwFYMkUBcCDVeNSAkag06KVnQ3AgYKAQEDCXy?=
 =?us-ascii?q?NcAEB?=
X-IronPort-AV: E=Sophos;i="5.76,406,1592870400"; 
   d="scan'208";a="801563527"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Sep 2020 19:28:55 +0000
Received: from XCH-ALN-003.cisco.com (xch-aln-003.cisco.com [173.36.7.13])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 088JStxG026530
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 8 Sep 2020 19:28:55 GMT
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by XCH-ALN-003.cisco.com
 (173.36.7.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Sep
 2020 14:28:54 -0500
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by xhs-rtp-001.cisco.com
 (64.101.210.228) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Sep
 2020 15:28:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-003.cisco.com (64.101.210.230) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 8 Sep 2020 15:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwKXAo0Nwkx65UPVvfOx4ztqdUcRlQ4XQfqsbDP75+LN7gOBLwVfooV1i+9gL3mlu0+FoG85mPrY17sPNub2SOfG6gO9519EP1Wrneo1fUwtpTq9bhIFwj0JQjndYzRWHzb0UzsZjf5omTKYS5SlSw/zXaxh7GuqUubxDdVgCvT6GRleAkRKjTrOGcspIEkrKnWw6j6LCZZLhA0ZCdyEeNTf6adxWLns+6Iep5jcHWCqMsH1eqCRmO05sWHXGRF11yo5D1ZuozSjLyULlT4pvol/2TiCfZj7DLxy/zweNeHbYyIUWHmEDNjMa6xxHtB67c4d4gGF1It8oKxsLkz3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTJKt78EdgO0ivA536SV09mU6sGZ7cdyg15qZByn8W0=;
 b=QGoDutPOwFXqVggz1WuO19SdV+myCZ7Ghu2fF4ojC9uc8eyfURAmCyZbHyzr7VhZ62olh1GGbOScV4OzfsA77DvT4U/ubUQKZhvssgiFwUYGZBoJc4fXIaKk2yY2F91aYn9eYA5hSuflVP2dJukmaT/MABK30NqmsO/mGQfnZZKhSnHNngi8srULjh5n3Tx5nD3H/U+DjPQ5ZJYFJflyL1ZBZbFwFJPc8RSajNbxjOrt32nMCGkKwT0uOvuDa/ECyo+8wWXdiCN/6lLtinEuPGaX4v7wDrDk9ra6Fe4iPc7tD6523KrhhAwAe5PKDfM/Ks0nagzkGHRTqoqm1VF9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTJKt78EdgO0ivA536SV09mU6sGZ7cdyg15qZByn8W0=;
 b=AhLEyyJEpDXk8F8Qm7k7MysDmIgRDYoqznOqyt326+kE7hHTeyl+BG0ylCLKN2XzSU3uJCUxtOym+SRCR/1H2Toss7+RcObdkFRBt7f61fFo3abyx4HUTPjVCoATUSA+8p86bj1docfRpBxiEUM1YDi2LTzFQ604gdMM2/EWAgg=
Received: from BY5PR11MB4182.namprd11.prod.outlook.com (2603:10b6:a03:183::10)
 by BYAPR11MB3765.namprd11.prod.outlook.com (2603:10b6:a03:f6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 19:28:51 +0000
Received: from BY5PR11MB4182.namprd11.prod.outlook.com
 ([fe80::1d4e:2269:63d7:f2d6]) by BY5PR11MB4182.namprd11.prod.outlook.com
 ([fe80::1d4e:2269:63d7:f2d6%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 19:28:51 +0000
From:   "Julius Hemanth Pitti (jpitti)" <jpitti@cisco.com>
To:     "guro@fb.com" <guro@fb.com>
CC:     "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH] mm: memcg: yield cpu when we fail to charge pages
Thread-Topic: [PATCH] mm: memcg: yield cpu when we fail to charge pages
Thread-Index: AQHWhhEa7koixvCA0Eesx63uX92KqalfHoKAgAAB6gA=
Date:   Tue, 8 Sep 2020 19:28:51 +0000
Message-ID: <38c678cac5794cb647ba73799bcaf6df5ff6dc3e.camel@cisco.com>
References: <20200908185051.62420-1-jpitti@cisco.com>
         <20200908192159.GB567128@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200908192159.GB567128@carbon.DHCP.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2001:420:c0c8:1005::83d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81c133fe-a051-4371-80b6-08d8542d6aea
x-ms-traffictypediagnostic: BYAPR11MB3765:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB37659B7A1E7168000DB6218ADA290@BYAPR11MB3765.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUbv4ysbRWki7aaH/D5BKy9OA3vKlkThw5yaDvPvcXpDEVrFbwS0YMIwihonca15qG065YH0gNiBKKgkeh9X92iBGeX9rZG/Ib3rPA1IKSl4XDoThKFMQA55W5l/7mRH5LzUJnDGPtM0Am67uOXEX1UtoDngFHH5OyGY6F0gmodIbD7Nwnn6NXldtQU9Fc3fMAouLAQRzWr6EU6spLPoEL9N18TbV56Xnljz4eTYzI2RXAz5i2B/7e4BrNbsCvQaKR10sq1iHcNj9FAqkXdSVJzbtGAg+7SYvYCerYGYP4Gkjefb/hC+JF6XNDyNgERerOlK94GpDwMRB739uNiyXag5iRiMdOMppSAHOdDmCkNAzpuxJ8mscH1RHQ6U5O2F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(39860400002)(346002)(4326008)(6506007)(66476007)(66446008)(66556008)(64756008)(6916009)(2616005)(478600001)(6486002)(66946007)(186003)(316002)(76116006)(54906003)(71200400001)(5660300002)(83380400001)(8676002)(86362001)(8936002)(2906002)(36756003)(6512007)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6y1+1ZxLO4YiDJUf8krRbjjblLlPWPNU6efJSyGWpIT4VBqU9O4eeLzKKqq/gW7PWvp3OmlxPyWSg6+JAYfEPn37ezYS4Imvbmp6L5kXeDQkyjzPXWZ+T6rcwg4i1CS1KYOccm0SSO4yzOeXoDTwxFKXYNno3h70SZWFa4jwW3AUUDJZEW+Ta6wqE33R1MwYJ4cVVXTebgreVWvQG7ENAjs+R3iztXujLbgU4oTJfGjoHRqKJwc0U3xgF8c0SHoBxdUYIh1erW3CL/f1oa88nb+iqy2/Lki+SKO4CIcwmEt+4+2OY3qE/cWqLeGj4scAMefpiewcK25Y0EzcKt41JB/XmzJYilq7BENthHJw6foD1Ih49V/9B28y0dVo+AZpRi0RMaxEAGNPLnIt1wRU6xjn5SkHdsY7tW4iL2eoHZHr80f8UZ+7Tk1l+f9r/F6Cl0+XslfCKHLq0QK3tptxO9Mf2ey7GAWTARvFy+kuFzY6sOtt7e2kuJD/4IOd4Ly72rdls71IVHPTm+Vuje61drfxzhj1LYq32VcfFnoTrWJhvr3O4VTguGRCCUJMO8jEk32HkknW1icEkrVSlf/qmCCweaeg3RVbTbFoUYADisshxyQ2l6ovVpUZOIkffDQi81khSl+P0gDjZMW6Fl+bE8S2HWdFiwMcsosLJRAgW6g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <305EB9137EE72C40BBD18F012D23A2FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c133fe-a051-4371-80b6-08d8542d6aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 19:28:51.5400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxSPc/Xfe/aSEeao5xiYZ7AUMl+q5+H4yTJhTt7xYIHldh9wk5iUlxgR6FMzz7LkAI8YbmXSOMmY1Qz8wwqZww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3765
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.13, xch-aln-003.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDEyOjIxIC0wNzAwLCBSb21hbiBHdXNoY2hpbiB3cm90ZToN
Cj4gT24gVHVlLCBTZXAgMDgsIDIwMjAgYXQgMTE6NTA6NTFBTSAtMDcwMCwgSnVsaXVzIEhlbWFu
dGggUGl0dGkgd3JvdGU6DQo+ID4gRm9yIG5vbiByb290IENHLCBpbiB0cnlfY2hhcmdlKCksIHdl
IGtlZXAgdHJ5aW5nDQo+ID4gdG8gY2hhcmdlIHVudGlsIHdlIHN1Y2NlZWQuIE9uIG5vbi1wcmVl
bXB0aXZlDQo+ID4ga2VybmVsLCB3aGVuIHdlIGFyZSBPT00sIHRoaXMgcmVzdWx0cyBpbiBob2xk
aW5nDQo+ID4gQ1BVIGZvcmV2ZXIuDQo+ID4gDQo+ID4gT24gU01QIHN5c3RlbXMsIHRoaXMgZG9l
c24ndCBjcmVhdGUgYSBiaWcgcHJvYmxlbQ0KPiA+IGJlY2F1c2Ugb29tX3JlYXBlciBnZXQgYSBj
aGFuZ2UgdG8ga2lsbCB2aWN0aW0NCj4gPiBhbmQgbWFrZSBzb21lIGZyZWUgcGFnZXMuIEhvd2V2
ZXIgb24gYSBzaW5nbGUtY29yZQ0KPiA+IENQVSAob3IgY2FzZXMgd2hlcmUgb29tX3JlYXBlciBw
aW5uZWQgdG8gc2FtZSBDUFUNCj4gPiB3aGVyZSB0cnlfY2hhcmdlIGlzIGV4ZWN1dGluZyksIG9v
bV9yZWFwZXIgc2hhbGwNCj4gPiBuZXZlciBnZXQgc2NoZWR1bGVkIGFuZCB3ZSBzdGF5IGluIHRy
eV9jaGFyZ2UgZm9yZXZlci4NCj4gPiANCj4gPiBTdGVwcyB0byByZXBvIHRoaXMgb24gbm9uLXNt
cDoNCj4gPiAxLiBtb3VudCAtdCB0bXBmcyBub25lIC9zeXMvZnMvY2dyb3VwDQo+ID4gMi4gbWtk
aXIgL3N5cy9mcy9jZ3JvdXAvbWVtb3J5DQo+ID4gMy4gbW91bnQgLXQgY2dyb3VwIG5vbmUgL3N5
cy9mcy9jZ3JvdXAvbWVtb3J5IC1vIG1lbW9yeQ0KPiA+IDQuIG1rZGlyIC9zeXMvZnMvY2dyb3Vw
L21lbW9yeS8wDQo+ID4gNS4gZWNobyA0ME0gPiAvc3lzL2ZzL2Nncm91cC9tZW1vcnkvMC9tZW1v
cnkubGltaXRfaW5fYnl0ZXMNCj4gPiA2LiBlY2hvICQkID4gL3N5cy9mcy9jZ3JvdXAvbWVtb3J5
LzAvdGFza3MNCj4gPiA3LiBzdHJlc3MgLW0gNSAtLXZtLWJ5dGVzIDEwTSAtLXZtLWhhbmcgMA0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1bGl1cyBIZW1hbnRoIFBpdHRpIDxqcGl0dGlAY2lz
Y28uY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS9tZW1jb250cm9sLmMgfCAyICsrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vbWVt
Y29udHJvbC5jIGIvbW0vbWVtY29udHJvbC5jDQo+ID4gaW5kZXggMGQ2ZjNlYTg2NzM4Li40NjIw
ZDcwMjY3Y2IgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtY29udHJvbC5jDQo+ID4gKysrIGIvbW0v
bWVtY29udHJvbC5jDQo+ID4gQEAgLTI2NTIsNiArMjY1Miw4IEBAIHN0YXRpYyBpbnQgdHJ5X2No
YXJnZShzdHJ1Y3QgbWVtX2Nncm91cA0KPiA+ICptZW1jZywgZ2ZwX3QgZ2ZwX21hc2ssDQo+ID4g
IAlpZiAoZmF0YWxfc2lnbmFsX3BlbmRpbmcoY3VycmVudCkpDQo+ID4gIAkJZ290byBmb3JjZTsN
Cj4gPiAgDQo+ID4gKwljb25kX3Jlc2NoZWQoKTsNCj4gPiArDQo+IA0KPiBDYW4geW91LCBwbGVh
c2UsIGFkZCBhIHNob3J0IGNvbW1lbnQgaGVyZT8NCj4gU29tZXRoaW5nIGxpa2UgImdpdmUgb29t
X3JlYXBlciBhIGNoYW5jZSBvbiBhIG5vbi1TTVAgc3lzdGVtIj8NClN1cmUuDQoNCj4gDQo+ID4g
IAkvKg0KPiA+ICAJICoga2VlcCByZXRyeWluZyBhcyBsb25nIGFzIHRoZSBtZW1jZyBvb20ga2ls
bGVyIGlzIGFibGUgdG8NCj4gPiBtYWtlDQo+ID4gIAkgKiBhIGZvcndhcmQgcHJvZ3Jlc3Mgb3Ig
YnlwYXNzIHRoZSBjaGFyZ2UgaWYgdGhlIG9vbSBraWxsZXINCj4gPiAtLSANCj4gPiAyLjE3LjEN
Cj4gPiANCj4gDQo+IFRoZSBwYXRjaCBtYWtlcyB0b3RhbCBzZW5zZSB0byBtZS4gUGxlYXNlLCBm
ZWVsIGZyZWUgdG8gYWRkDQo+IEFja2VkLWJ5OiBSb21hbiBHdXNoY2hpbiA8Z3Vyb0BmYi5jb20+
IGFmdGVyIGFkZGluZyBhIGNvbW1lbnQuDQpUaGFua3MsIEkgc2hhbGwgYWRkLg0KDQo+IA0KPiBU
aGFuayB5b3UhDQo=
