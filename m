Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9132AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3E02087D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cuPgd/V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHYA5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:57:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:41154 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYA5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:57:16 -0400
IronPort-SDR: druqhCmGkm4iVoGC1a+qLCQuj+ZuoFADlA2zHguZEnpg7h4kzQfliWvFhHnZlfXaaJ8CdeoJCA
 It8X8RaDw2+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156009196"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="156009196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:57:14 -0700
IronPort-SDR: 4HhPG9uBEMu2PFDYD4vZg+wVImuZDtynHGu/7sMj5kl9pY0PLDwhFQH65Bpm0qdWinymQjCsFn
 hHeNtgaRnPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="312386452"
Received: from orsmsx603-2.jf.intel.com (HELO ORSMSX603.amr.corp.intel.com) ([10.22.229.83])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 17:57:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 17:57:14 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 17:57:14 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Aug 2020 17:57:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 24 Aug 2020 17:57:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRob54H4muidgygZuwhyiaBWCkFeRLj55ULUEQCF3URE+ZuTuRRNpZxFzbr2cGuKPxV0QZ2ob9LyDtl5Y9vcaUUBwQ460WWfz7MBftCfvAtHyKyU3XuYZyC2kiV9AGlGMQRZ+bF2aV39PQAi8JXlrHoMqT/sO6kQI2NHyuam37sPGB8hHSo+cN1SNtnFtOF1bXzqdbTebNrKplZa+KtZ6UyCVKwHBF2UbPd1UAtkEfmT026vnP3Of9q3b1t6TNGJnAV+USHNFBrSWz1o5LJ69iYczoVVFm2LOwLv4W1SIbuiu++qmCt6lUkKWswuBlX153M4oaXxXOJwJjRX+C0Puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3K2i5trnlwoXhbFH4YRBhD/65O9njFyXSiZE8oSQpg=;
 b=bElT+E/a/0/4RYsfh0yFWQNb+jpPqseVHCcMAPH8ySEHyNRV28CMQAD4RcCSXcQV5fAydovgcAhqflN83l/BoJR1263ZN4ayLbgUIaxugbvKyHBvGrTbdgoe0MUfobpm5E698EzGvIzTrYD6ynMm7QCpzrCI25qrRdlVHTgkYmjPMzjuSRNjT4RwSDcHVFc+8QqD3h6+j7K/SP+Fl2FY+USwil8Z4GMIIxyMlc8aHM/kJsCn9VHCvFXs/QFmsL8b6pSzVuZwrdj93kJcHZ3SoXvPFpEaa+QNK4Gf5zcSXay6UetCYR/+lg7KewxJxrZ2K90aMU+FQQ+rGnkSq2+3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3K2i5trnlwoXhbFH4YRBhD/65O9njFyXSiZE8oSQpg=;
 b=cuPgd/V+ww8zLmp3yUU1YV+oTvONDmJq5ndmwOIeWWBhnFZX6KfBqml+b9nOFbEkkBfOW0U9XMx9a/YPgqBKH+nDIJkvfTbj1lYCw3yaO2olOkjVKsDqUjy8li0OYEWkPRFUCXt4gxV0baGrapGV+hneJ4Zobc0k+YDa4iYQz88=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3031.namprd11.prod.outlook.com (2603:10b6:a03:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 00:57:12 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 00:57:12 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ahuang12@lenovo.com" <ahuang12@lenovo.com>
Subject: [GIT PULL] libnvdimm fixes for v5.9-rc3
Thread-Topic: [GIT PULL] libnvdimm fixes for v5.9-rc3
Thread-Index: AQHWenqqqJZ8PrwLrEypxrPcYT2tmA==
Date:   Tue, 25 Aug 2020 00:57:12 +0000
Message-ID: <7d850f417b20bfa559e6ef3eb133d336fb2eda3f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee6311d-9e51-4615-4257-08d84891cd56
x-ms-traffictypediagnostic: BYAPR11MB3031:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3031E89B83F98627769474C7C7570@BYAPR11MB3031.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zyFA/FJPJBAqBOaLhTsQmpAAdWl6yojL1QP1y9Vcrypfz/WwzfNhRSYKyPP3HgmqVoHgAaYJwEMHq+AKWy3QIFMzUJKSfINkpkDu80aoMfbX5ma+xrS1WaYmsPooHyF8Y0AbKvb3SbjEJ9HlM9YSI6bS1IGLZfCxrqD+HShc7KYxB8/0aSDbWMTshBUAs0RQUwvodHAaLiS/ludib0Q/8OwUpcXr4wASbMkHSarDxyyogNE/o9MWYOXpOW3uW5wGM9mzZoWxO21FhzxKz3yo1sZwPx+mPQT+gsN45ua31loo7FlU9FaWjXrF88UuzAh0O4t5JcsoJBWbDSohZA7VPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(2616005)(5660300002)(71200400001)(66476007)(64756008)(66946007)(2906002)(76116006)(66446008)(478600001)(66556008)(83380400001)(4326008)(6916009)(6512007)(8936002)(6486002)(6506007)(54906003)(86362001)(316002)(26005)(186003)(8676002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: O6M2mbpdJRaby91xWZfI8qqHlcifHdCxuofiVzVBcUdMaZI73ypsoDMxisQHC6Azk1eGM2qfoZU9hOOz4QAzg5bcoPF5Iju1+7zI8DAjUEi79etBVRU5fI/9yArPIa5GoIa5NQXbFR38jHuB4otdTHUCCvEDs9vsTxX/cOPgTuFRhQUiWOCCl6z9nCvuZRVtYR2798PtAAINoS23cdz2FKeJqA5/WmISd+gpGn/5K5NS2T5Xw3OArqAJKmGXHIl2PtebRRAgfDIoSowOo6hTafU3cZJXaBg/6zVico75e6JG//dkcLMkpMIXCBzT9LJfyl7n1b+iDbUDoOOyWMtxCjlqCVguE89eTRgxDwMnlnsTHxCsZn1JyQEuFQvEi6TBC+rznyrNYYhhKQ83P6h2y3RzfvUeFWdaWWQu0XWj1zPsRYmTCjHnQkgwL/J11xLhIjuuj5tUwfxJc447qdmndq5ljF0duIR+M5Z4dT/lvzC7eUBh0H5l4+d4B2a8nfwof0l/C5DvPYWixdwIlViPiaRanN5XSBFZqwgcANiNgNcK2o3y2o5gcKPOgo9e5GfwuBmX/66jhiL4R/5/JpgcXNRxnUDPIAf5W0oHnfCTUMoh7lxCTp+k0HhkB6liBlQqKNH8Kdzz1vctV6xvgLlEog==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E9B7956718CF14FA9FF7F1AD7DE926B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee6311d-9e51-4615-4257-08d84891cd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 00:57:12.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ifsuz/OLZAybJLOjOwjaQ6+8JppJrHWsEhCDOgf7KIqKdGWwrWmEqmgF4pR940JkxOyq+OIfozq/lEjZ9kgNiYu5WWdrt6htjXWhk9sRzc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3031
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsIHBsZWFzZSBwdWxsIGZyb206DQoNCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9udmRpbW0vbnZkaW1tLmdpdA0KdGFncy9saWJudmRpbW0tZml4
LXY1LjktcmMzDQoNCi4uLnRvIHJlY2VpdmUgYSBjb3VwbGUgb2YgbWlub3IgZml4ZXMgZm9yIHRo
aW5ncyBtZXJnZWQgaW4gNS45LXJjMS4gT25lDQppcyBhbiBvdXQtb2YtYm91bmRzIGFjY2VzcyBj
YXVnaHQgYnkgS0FTQU4sIGFuZCB0aGUgc2Vjb25kIGlzIGEgdHdlYWsgdG8NCnNvbWUgb3Zlcnpl
YWxvdXMgbG9nZ2luZyBhYm91dCBkYXggc3VwcG9ydCBldmVuIGZvciB0cmFkaXRpb25hbCBibG9j
aw0KZGV2aWNlcyB3aGljaCB3YXMgdW5uZWNlc3NhcnkuIFRoZXNlIGhhdmUgYXBwZWFyZWQgaW4g
LW5leHQgd2l0aG91dCBhbnkNCnByb2JsZW1zLg0KDQotLS0NCg0KVGhlIGZvbGxvd2luZyBjaGFu
Z2VzIHNpbmNlIGNvbW1pdCA5MTIzZTNhNzRlYzdiOTM0YTRhMDk5ZTk4YWY2YTYxYzJmODBiYmY1
Og0KDQogIExpbnV4IDUuOS1yYzEgKDIwMjAtMDgtMTYgMTM6MDQ6NTcgLTA3MDApDQoNCmFyZSBh
dmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9udmRpbW0vbnZkaW1tLmdpdCB0YWdzL2xpYm52
ZGltbS1maXgtdjUuOS1yYzMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGMyYWZm
ZTkyMGIwZTA2Njk2NTA5NDNhYzA4NjIxNWNmNjUxOWJlMzQ6DQoNCiAgZGF4OiBkbyBub3QgcHJp
bnQgZXJyb3IgbWVzc2FnZSBmb3Igbm9uLXBlcnNpc3RlbnQgbWVtb3J5IGJsb2NrIGRldmljZSAo
MjAyMC0wOC0yMCAxMTo0MzoxOCAtMDYwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbGlibnZkaW1tIGZpeGVzIGZv
ciB2NS45LXJjMw0KDQpGaXggYW4gb3V0LW9mLWJvdW5kcyBhY2Nlc3MgaW50cm9kdWNlZCBpbiBs
aWJudmRpbW0gdjUuOS1yYzENCmRheDogZG8gbm90IHByaW50IGVycm9yIG1lc3NhZ2UgZm9yIG5v
bi1wZXJzaXN0ZW50IG1lbW9yeSBibG9jayBkZXZpY2UNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQWRyaWFuIEh1YW5n
ICgxKToNCiAgICAgIGRheDogZG8gbm90IHByaW50IGVycm9yIG1lc3NhZ2UgZm9yIG5vbi1wZXJz
aXN0ZW50IG1lbW9yeSBibG9jayBkZXZpY2UNCg0KWnFpYW5nICgxKToNCiAgICAgIGxpYm52ZGlt
bTogS0FTQU46IGdsb2JhbC1vdXQtb2YtYm91bmRzIFJlYWQgaW4gaW50ZXJuYWxfY3JlYXRlX2dy
b3VwDQoNCiBkcml2ZXJzL2RheC9zdXBlci5jICAgICAgICB8IDYgKysrKysrDQogZHJpdmVycy9u
dmRpbW0vZGltbV9kZXZzLmMgfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgvc3VwZXIuYyBiL2RyaXZlcnMvZGF4L3N1cGVy
LmMNCmluZGV4IGM4MmNiY2I2NDIwMi4uMzI2NDI2MzRjMWJiIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9kYXgvc3VwZXIuYw0KKysrIGIvZHJpdmVycy9kYXgvc3VwZXIuYw0KQEAgLTEwMCw2ICsxMDAs
MTIgQEAgYm9vbCBfX2dlbmVyaWNfZnNkYXhfc3VwcG9ydGVkKHN0cnVjdCBkYXhfZGV2aWNlICpk
YXhfZGV2LA0KIAkJcmV0dXJuIGZhbHNlOw0KIAl9DQogDQorCWlmICghZGF4X2RldiAmJiAhYmRl
dl9kYXhfc3VwcG9ydGVkKGJkZXYsIGJsb2Nrc2l6ZSkpIHsNCisJCXByX2RlYnVnKCIlczogZXJy
b3I6IGRheCB1bnN1cHBvcnRlZCBieSBibG9jayBkZXZpY2VcbiIsDQorCQkJCWJkZXZuYW1lKGJk
ZXYsIGJ1ZikpOw0KKwkJcmV0dXJuIGZhbHNlOw0KKwl9DQorDQogCWlkID0gZGF4X3JlYWRfbG9j
aygpOw0KIAlsZW4gPSBkYXhfZGlyZWN0X2FjY2VzcyhkYXhfZGV2LCBwZ29mZiwgMSwgJmthZGRy
LCAmcGZuKTsNCiAJbGVuMiA9IGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmX2VuZCwg
MSwgJmVuZF9rYWRkciwgJmVuZF9wZm4pOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL2Rp
bW1fZGV2cy5jIGIvZHJpdmVycy9udmRpbW0vZGltbV9kZXZzLmMNCmluZGV4IDYxMzc0ZGVmNTE1
NS4uYjU5MDMyZTA4NTliIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udmRpbW0vZGltbV9kZXZzLmMN
CisrKyBiL2RyaXZlcnMvbnZkaW1tL2RpbW1fZGV2cy5jDQpAQCAtNTI5LDYgKzUyOSw3IEBAIHN0
YXRpYyBERVZJQ0VfQVRUUl9BRE1JTl9SVyhhY3RpdmF0ZSk7DQogc3RhdGljIHN0cnVjdCBhdHRy
aWJ1dGUgKm52ZGltbV9maXJtd2FyZV9hdHRyaWJ1dGVzW10gPSB7DQogCSZkZXZfYXR0cl9hY3Rp
dmF0ZS5hdHRyLA0KIAkmZGV2X2F0dHJfcmVzdWx0LmF0dHIsDQorCU5VTEwsDQogfTsNCiANCiBz
dGF0aWMgdW1vZGVfdCBudmRpbW1fZmlybXdhcmVfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29i
aiwgc3RydWN0IGF0dHJpYnV0ZSAqYSwgaW50IG4pDQoNCg==
