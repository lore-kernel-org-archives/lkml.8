Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF638C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D577206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="C156U2y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHCMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:12:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:6797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEHCM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:12:29 -0400
IronPort-SDR: aiv/cFw5z4zmGFLU8dEezWXqKkNjQvTIH4EEjYhapbjRdrMq3l2zyzUHGIbFJiJ6NXGR8tztsQ
 RC0WRys7I4Bw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 19:12:29 -0700
IronPort-SDR: 4nbpUhmYmmi4BprSnKAkerJPkFXI9F8gkAnmKq7DdzcPRdrgBdIbs1RVyojcUbD3OftwG/+w9X
 SNTnn9PW/Liw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="285224540"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 19:12:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 19:12:29 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 19:12:28 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 May 2020 19:12:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 7 May 2020 19:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPAMwHdVIsd2u+w7TTGsINlWMEIMVlgvKc3Dih0T6N77W1pUkq7WHH3I2iZ0McFuchAijWbRXTAAOfhFD6bedPaG3uKkzX3fPgsmIkMJ7acGjbECKwCnlDwgMJA23DcIWeNWc76LMJBpWNL6ZZRPgLckGJ4NvJrwIaQf+Lmd58+OBjSrCbzxW3NVvzkLyT0VbZAb/r8vzBPS0RRylMABCEb3Y6mZpmYj3ezg4StS+9fXv2k0x3IZ6NtWp/V0O7NN0DmgqGt7Vze6rn1I8z3wwmI78kkV1Xo+2ZCO4434ZlFoNpGZb/d//0YQNq/UNZ/FQsTYpHMGhQihjE3tJbQHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tRYP4drHgJcJ2ZkZSf/1nKLtEFfVaX09yRi6v/7bHo=;
 b=HY8n7kX+TZtuHBnHQbLLcgAB9Vw8chX7QSCF036PO8JVWOT46uEIKuVTh5IXF6bAVB0YKyKJuG4xqq12I/jQJPhLWzr32ZlEhhlB1yw+BzJJSgQqkyUKqyisv1H24lh/vp0GCfJhWtr38ydI5xp8Quz+d0Mp5UVZ/sA9xR3E73BvaLuFytqfL4kdt2jCjJViLI3ATOwFCbQT54OWbbT8dqVE3Ys7FY7bH1WqGyOPEn8w7hpBay1uVD/OCp2MTF5LdYZZ1OWGMeIvIq75LNoLuYbAWWIXVVWYQCwG1QOrYUVsAvK/nqqRTsoU39aOHE+sF7T2kGReW0YPWVpzNhM7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tRYP4drHgJcJ2ZkZSf/1nKLtEFfVaX09yRi6v/7bHo=;
 b=C156U2y4wz3ynntkHR8pHT9X9QurTU3ltheaNSjQSu6Bs/HYVVABhvgncbWHtMqd0eM9RCRKw46fy6Ap/gXW6pADEltmIAjZ9Yqk9K5xshbJ5Ro27Q3KRzC3+7rTavfgAFbhfH8x2YODSD38dZrupUK5C7Wk6xt1q29VXNZ4Nqg=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1374.namprd11.prod.outlook.com (2603:10b6:300:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Fri, 8 May
 2020 02:12:25 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 02:12:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
Thread-Topic: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
Thread-Index: AQHWJArS9bHSXYAkjk+yfEGapC3IHKicG8bggACBgYCAANZmwA==
Date:   Fri, 8 May 2020 02:12:25 +0000
Message-ID: <MWHPR11MB16450F77A9A450AFE51D8F7A8CA20@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1645CE4337BEDBC4598318A88CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
 <3c41a395-95b6-f80c-d3fd-bcd1ec166b24@linux.intel.com>
In-Reply-To: <3c41a395-95b6-f80c-d3fd-bcd1ec166b24@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21cb00e1-3a67-4c6e-e6c0-08d7f2f54036
x-ms-traffictypediagnostic: MWHPR11MB1374:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB137486BD3872CC6D6B850C058CA20@MWHPR11MB1374.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZqfv0DbkR4cdjEThSpg5M+eOqepMoBrGulJSt0JecMFwHqJO/KXDbo0PX3pxkjQAZHYkjLTslSNTpql/vQNBKxNfniptzOi2C7MiF3mJCAmCT+lksimy1Mq4oUVRTIj+HndD1kmsFMI+HARk1D7g1Jo5bAOW7xOJI1NaIWTB+JQkZ0hEpiSqJfsMEovgUnvbhqEQHSCsEBqXCnca1AQri29fF1YkIG/hsNWSxPnk9b5m1pqZHdCrIg0xX7qV+wJt4l4meFGxqzkyTFC49Vf9VzD9ypALqCMNMcv/JMg7xqnjjRTs1UpwtYzeye/fVHcZemqa9tk1WU/4p16j6akrIs4wEKnYfiQGRgQjREUrjcR02b8D9XVX58Vb6XobzTF9feqlpaOle/Ux6OqbCy3yz/PEYC6c4Klw547NitPH/rEUt7WvHJkDCT2qWy+xPzJJxTwDt87JaV3zfal+WFlfPsdzZz4piI5WxQnQCySbcOu0c5lpkABH7l7sIvv0AokLhrWPx+1uVHv/i/lr9u2Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(33656002)(66446008)(54906003)(66476007)(66556008)(316002)(52536014)(110136005)(64756008)(4326008)(55016002)(6506007)(2906002)(9686003)(186003)(478600001)(71200400001)(53546011)(5660300002)(86362001)(76116006)(66946007)(33440700001)(26005)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001)(7696005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wT+rjcynE4UuHA04U0/73TysUL4laMLCIWIrIC9H5LxRCXw86LwO9rothwL1IKeWLXEAZfC8HSFwp2etTgyDAS2AsX2kkhmhhz7Se9LViGBUh1sUmhEHyr1Vz9GRAKutha5UYVRbgGu8yLeyhOb/djJ8apLwehc6REeDlP/7Pi4wdJ7kE6fOFTMhVqigYFSA1ewdHQ7JFXuea97CPmNlHVbwr8v7+wJFph3X/7VTM+CoMD9oq9smZkyDtgRVlwdxzwRVJu23xqUlz8k7g+Ra0DnnmJwaBQ7wqGGs1r+Myo2aOcjfY0LNPCfJ9iSs3aNrqqWj6ChQBJjPobLK2anWDEnxXXuIEe3/uV5FOlT1ZJB/ZZXiIayP3GFOFa5YziKq9wNYuQmB8vrK6HRmmUz7dkC9xQjELsFUPhFnTLmJhmE5MBtWLOA1wM/FgBmk5do9/mEK21kb94A6+SclpT9Nkh9l5kDV5+2jFkzcXEO82eJYROokvLK2ANwyR7l9txauCnQzv5CHeGKUL37JwwFOPm3x99E5xcMVo+jt7V7GXDBfPg5lu9w6SR7Xwa5NSE0yPbC2DpubgofjMcx+g73J7JvnzR041dp1bmF0QwDpvL1QOUkZmYS7GRG3GAHy8upVf7M0HJM9rgSAyMQJNKL1NJa9e8DkzyE6nUaAjQ/nYF2GucuDS2WATaIoNQIgOfgxaeG238w8oUMcdWm+Uto3e9Uen3Y7MICM4156Q4VqK3y0w3dc2qcXk/fPyJO9UCbXg8Djr28AezCa+BZzf7pF0GFPtAbtQk4E91iG541WknA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb00e1-3a67-4c6e-e6c0-08d7f2f54036
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 02:12:25.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsZJ8AOoolUwPJUJZzzXNOaXNNY0kxG1IE25PmdmbEs0MAupRwNLnqPkAJxhoDa/D3hLFRMkfEliUZVe5yOScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1374
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWF5IDcsIDIwMjAgOToyMyBQTQ0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBPbiAyMDIw
LzUvNyAxMzo0NSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1PGJhb2x1
Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIE1heSA3LCAyMDIwIDg6
NTYgQU0NCj4gPj4NCj4gPj4gV2hlbiBhIFBBU0lEIGlzIHVzZWQgZm9yIFNWQSBieSB0aGUgZGV2
aWNlLCBpdCdzIHBvc3NpYmxlIHRoYXQgdGhlIFBBU0lEDQo+ID4+IGVudHJ5IGlzIGNsZWFyZWQg
YmVmb3JlIHRoZSBkZXZpY2UgZmx1c2hlcyBhbGwgb25nb2luZyBETUEgcmVxdWVzdHMuIFRoZQ0K
PiA+PiBJT01NVSBzaG91bGQgaWdub3JlIHRoZSBub24tcmVjb3ZlcmFibGUgZmF1bHRzIGNhdXNl
ZCBieSB0aGVzZQ0KPiByZXF1ZXN0cy4NCj4gPj4gSW50ZWwgVlQtZCBwcm92aWRlcyBzdWNoIGZ1
bmN0aW9uIHRocm91Z2ggdGhlIEZQRCBiaXQgb2YgdGhlIFBBU0lEIGVudHJ5Lg0KPiA+PiBUaGlz
IHNldHMgRlBEIGJpdCB3aGVuIFBBU0lEIGVudHJ5IGlzIGNsZWFyZWQgaW4gdGhlIG1tIG5vdGlm
aWVyIGFuZA0KPiA+PiBjbGVhciBpdCB3aGVuIHRoZSBwYXNpZCBpcyB1bmJvdW5kLg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+
ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8ICA0ICsrLS0NCj4g
Pj4gICBkcml2ZXJzL2lvbW11L2ludGVsLXBhc2lkLmMgfCAyNiArKysrKysrKysrKysrKysrKysr
KystLS0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwtcGFzaWQuaCB8ICAzICsrLQ0KPiA+
PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwtc3ZtLmMgICB8ICA5ICsrKysrKy0tLQ0KPiA+PiAgIDQg
ZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4+DQo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgYi9kcml2ZXJzL2lv
bW11L2ludGVsLWlvbW11LmMNCj4gPj4gaW5kZXggZDE4NjZjMDkwNWIxLi43ODExNDIyYjVhNjgg
MTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYw0KPiA+PiArKysg
Yi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMNCj4gPj4gQEAgLTUzNTIsNyArNTM1Miw3IEBA
IHN0YXRpYyB2b2lkDQo+IF9fZG1hcl9yZW1vdmVfb25lX2Rldl9pbmZvKHN0cnVjdA0KPiA+PiBk
ZXZpY2VfZG9tYWluX2luZm8gKmluZm8pDQo+ID4+ICAgCWlmIChpbmZvLT5kZXYpIHsNCj4gPj4g
ICAJCWlmIChkZXZfaXNfcGNpKGluZm8tPmRldikgJiYgc21fc3VwcG9ydGVkKGlvbW11KSkNCj4g
Pj4gICAJCQlpbnRlbF9wYXNpZF90ZWFyX2Rvd25fZW50cnkoaW9tbXUsIGluZm8tPmRldiwNCj4g
Pj4gLQkJCQkJUEFTSURfUklEMlBBU0lEKTsNCj4gPj4gKwkJCQkJUEFTSURfUklEMlBBU0lELCBm
YWxzZSk7DQo+ID4+DQo+ID4+ICAgCQlpb21tdV9kaXNhYmxlX2Rldl9pb3RsYihpbmZvKTsNCj4g
Pj4gICAJCWRvbWFpbl9jb250ZXh0X2NsZWFyKGlvbW11LCBpbmZvLT5kZXYpOw0KPiA+PiBAQCAt
NTU4Nyw3ICs1NTg3LDcgQEAgc3RhdGljIHZvaWQgYXV4X2RvbWFpbl9yZW1vdmVfZGV2KHN0cnVj
dA0KPiA+PiBkbWFyX2RvbWFpbiAqZG9tYWluLA0KPiA+PiAgIAlhdXhpbGlhcnlfdW5saW5rX2Rl
dmljZShkb21haW4sIGRldik7DQo+ID4+DQo+ID4+ICAgCXNwaW5fbG9jaygmaW9tbXUtPmxvY2sp
Ow0KPiA+PiAtCWludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShpb21tdSwgZGV2LCBkb21haW4t
PmRlZmF1bHRfcGFzaWQpOw0KPiA+PiArCWludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShpb21t
dSwgZGV2LCBkb21haW4tPmRlZmF1bHRfcGFzaWQsDQo+ID4+IGZhbHNlKTsNCj4gPj4gICAJZG9t
YWluX2RldGFjaF9pb21tdShkb21haW4sIGlvbW11KTsNCj4gPj4gICAJc3Bpbl91bmxvY2soJmlv
bW11LT5sb2NrKTsNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwt
cGFzaWQuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtcGFzaWQuYw0KPiA+PiBpbmRleCA3OTY5ZTNk
YWMyYWQuLjExYWVmNmMxMjk3MiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRl
bC1wYXNpZC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtcGFzaWQuYw0KPiA+PiBA
QCAtMjkyLDcgKzI5MiwyMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcGFzaWRfY2xlYXJfZW50cnko
c3RydWN0DQo+ID4+IHBhc2lkX2VudHJ5ICpwZSkNCj4gPj4gICAJV1JJVEVfT05DRShwZS0+dmFs
WzddLCAwKTsNCj4gPj4gICB9DQo+ID4+DQo+ID4+IC1zdGF0aWMgdm9pZCBpbnRlbF9wYXNpZF9j
bGVhcl9lbnRyeShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBwYXNpZCkNCj4gPj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBwYXNpZF9jbGVhcl9lbnRyeV93aXRoX2ZwZChzdHJ1Y3QgcGFzaWRfZW50cnkg
KnBlKQ0KPiA+PiArew0KPiA+PiArCVdSSVRFX09OQ0UocGUtPnZhbFswXSwgUEFTSURfUFRFX0ZQ
RCk7DQo+ID4+ICsJV1JJVEVfT05DRShwZS0+dmFsWzFdLCAwKTsNCj4gPj4gKwlXUklURV9PTkNF
KHBlLT52YWxbMl0sIDApOw0KPiA+PiArCVdSSVRFX09OQ0UocGUtPnZhbFszXSwgMCk7DQo+ID4+
ICsJV1JJVEVfT05DRShwZS0+dmFsWzRdLCAwKTsNCj4gPj4gKwlXUklURV9PTkNFKHBlLT52YWxb
NV0sIDApOw0KPiA+PiArCVdSSVRFX09OQ0UocGUtPnZhbFs2XSwgMCk7DQo+ID4+ICsJV1JJVEVf
T05DRShwZS0+dmFsWzddLCAwKTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiArc3RhdGljIHZvaWQN
Cj4gPj4gK2ludGVsX3Bhc2lkX2NsZWFyX2VudHJ5KHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IHBh
c2lkLCBib29sIHBmX2lnbm9yZSkNCj4gPiBIaSwgQmFvbHUsDQo+ID4NCj4gPiBKdXN0IGN1cmlv
dXMgd2hldGhlciBpdCBtYWtlcyBzZW5zZSB0byBhbHdheXMgc2V0IEZQRCBoZXJlLiBZZXMsIFNW
QSBpcw0KPiA+IG9uZSBrbm93biBleGFtcGxlIHRoYXQgbm9uLXJlY292ZXJhYmxlIGZhdWx0IGFz
c29jaWF0ZWQgd2l0aCBhIFBBU0lEDQo+ID4gZW50cnkgbWlnaHQgYmUgY2F1c2VkIGFmdGVyIHRo
ZSBlbnRyeSBpcyBjbGVhcmVkIGFuZCB0aG9zZSBhcmUgY29uc2lkZXJlZA0KPiA+IGJlbmlnbi4g
IEJ1dCBldmVuIGluIGEgZ2VuZXJhbCBjb250ZXh0ICh3L28gU1ZBKSB3aHkgZG8gd2UgY2FyZSBh
Ym91dA0KPiA+IHN1Y2ggZmF1bHRzIGFmdGVyIGEgUEFTSUQgZW50cnkgaXMgdG9ybiBkb3duPw0K
PiANCj4gRmlyc3QgbGV2ZWwgcGFnZSB0YWJsZXMgYXJlIGFsc28gdXNlZCBmb3IgRE1BIHByb3Rl
Y3Rpb24uIEZvciBleGFtcGxlLA0KPiB0aHVuZGVyYm9sdCBwZXJpcGhlcmFscyBhcmUgYWx3YXlz
IHVudHJ1c3RlZCBhbmQgc2hvdWxkIGJlIHByb3RlY3RlZA0KPiB3aXRoIElPTU1VLiBJT01NVSBz
aG91bGQgYWx3YXlzIHJlcG9ydCB1bnJlY292ZXJhYmxlIGZhdWx0cyBnZW5lcmF0ZWQNCj4gYnkg
dGhvc2UgZGV2aWNlIHRvIGRldGVjdCBwb3NzaWJsZSBETUEgYXR0YWNrcy4NCg0Kd2hlbiB1bnRy
dXN0ZWQgZGV2aWNlcyBhcmUgcHJvdGVjdGVkIGJ5IElPTU1VLCBJIGRvbid0IHRoaW5rIFBBU0lE
DQplbnRyeSAob2YgUklEMlBBU0lEKSB3aWxsIGhhdmUgcHJlc2VudCBiaXQgY2xlYXJlZC4NCg0K
PiANCj4gQVRTL1BSSSBkZXZpY2VzIGFyZSBhbHdheXMgdHJ1c3RlZCBkZXZpY2VzLCBoZW5jZSB3
ZSBjb3VsZCB0b2xlcmF0ZQ0KPiBzZXR0aW5nIEZQRCBiaXQgaW4gdGhlIHRpbWUgd2luZG93IGJl
dHdlZW4gbW1fcmVsZWFzZSBub3RpZmllciBhbmQNCj4gdW5iaW5kKCkuDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IGJhb2x1DQo=
