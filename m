Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0421C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73910206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ByP4ZaAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHKBU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:20:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:29930 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgHKBU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:20:58 -0400
IronPort-SDR: /zEsAkgFKGQIOkAXGY/qYJ9Io1V9WY/YYMkHQqoq/zgOykWnr0hAzMu4rbg5IsXRcg/KooNULR
 6+9+Dx9K6AwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151079205"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="151079205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 18:20:51 -0700
IronPort-SDR: sEOX4bI/r8aXHdgg/6lTaXEaCN3iQ8Df+2ZL5Xm9sg/v6x6vWXtlAep+wqNaH9zszGMKzK0O7M
 SA4hschtgq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="368806094"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com) ([10.18.84.211])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2020 18:20:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 18:20:50 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Aug 2020 18:20:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 10 Aug 2020 18:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PucgYJvFcNFlr4PqT4G+I617NDAof4aC4/JPQqLS8QQ/DLx90p93i/BNCGja2AAjWCZP0UozwJc9CtdxO4NQ/GKPR6Xqq9hGXzk0CZQcJYspBNDoM1wMSh9Mo7BUgNm5EEZeJzB2prDLEcg0jKHnQGa+8fZMELT4b9wn+V/asJUkeuXEBhy/YSO07tqxvxHIdoQd9BMdlZqcCdvZM1A80TUT532e/I5fAbydWeWKbRXTsdOus1i/ixD00KPhBNqJ1aWbZJSKVeefULC9OiRXJ6Xg1NABoGN0sQChOYLN8mRZQq1QcIKhUFlwWZlaX1q0Lq6CotD5wvQhQTSUPxyX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UUaGg+yWefPgS0cZWMbpZN6nC1PmtR8+jUm968UhMA=;
 b=QOLorHnzg/L7n94vW47DjlMOTx8j3NBMVNH8t2qZlLCTO3L17xz3e/Q8dIV2oALqiuopIHVmDAqNrluYJPoADOsFQkTJRYV4caukbOBxH70phLf/wu3Yh19ILLVKlcvTP0VVPM/l6pT5mGSdutO1t/AmsmJMGZQLLbzzhR7V3quxkZSk3XhW2Xv0PMqdYm1yFlHIwykb7X1mVvrPOX4uY68WGT6iutezjw2m7bW9hJoeWivqp0RBkgJf/wAaAEpUF+KvAbAHcz0Sj9QF0IoldQMLqErxnGq0SsC0NuaT+Bg6A4Gk9GsPwXNOQC0EOX7duKApQsDAtmVREvCQNCttgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UUaGg+yWefPgS0cZWMbpZN6nC1PmtR8+jUm968UhMA=;
 b=ByP4ZaAAoSNge0VaAKAtJqrvAJm5nF99iZvQkjK/sSH9v99QBrb/fx7bMlXtNz7ZAQJsXLIWNa7SjmCppL8WwNIUe6hZ1rcirNFXF2RkKE1CuhLvXL3TLq122sem3/eg5PhCQXCNmrjh9UiExT0n0OtOldWUGbfYE54onSIYpag=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3608.namprd11.prod.outlook.com (2603:10b6:a03:b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 11 Aug
 2020 01:20:48 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::20c5:c870:d7c7:bfa0]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::20c5:c870:d7c7:bfa0%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 01:20:48 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] libnvdimm for v5.9
Thread-Topic: [GIT PULL] libnvdimm for v5.9
Thread-Index: AQHWb32lEU1Cwshp8U6uHR2jAz+0zg==
Date:   Tue, 11 Aug 2020 01:20:48 +0000
Message-ID: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb060faf-d3d6-4a58-abc4-08d83d94c7c8
x-ms-traffictypediagnostic: BYAPR11MB3608:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB360838569DE4116568823BFDC7450@BYAPR11MB3608.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iavuQzqmd9n6DwjJV6IEgRHm6Lmud1emCy+q5Ft8KullPp3lr/hE26qGbL50Z42fWJyi2Sb3zQTeRDfkyzx/vfDhM6elkXlBCao6Wpc3GPo8+BJJ3TXECc2+Kn4rqn1czfsMaWiK01kKj85OEoa3/34rA+r++MOIk32xaK8pCDBHeRYVvKB6dO4VV7liOFGxGsYRusbx+oxbOvznmzvnfr2o6aKR4+cv/uee4pzv9iQbSpcjd8lMYZd8mr+pMdKigvEKdTDDn5x9JTYabK7bzYk3unfea6p9w9q7pSfnSPnA7ctwEEh+IeLmpIDRHU9ssPRZuL5pa2+V8yUosBQQNMCg9un81C4F28tLeZGIrMrGD+KyoAk8TsSruNALqvdlI0koLZsM1YdY2EEAa0BiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(8936002)(2616005)(4326008)(54906003)(6512007)(6506007)(83380400001)(71200400001)(8676002)(66556008)(64756008)(66446008)(6916009)(76116006)(66476007)(5660300002)(66946007)(186003)(86362001)(316002)(966005)(478600001)(36756003)(26005)(2906002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xPbArv8okOddMfrC2TCNZqw2CEnIXthmI0Dhs7JyWrBxNPEgqMuDsFNKBo2eIcW3h/5TFch5BB1evKC4Lwd2oknSaUtpjpNSetEcl5dvd/Nw970Uknb49BS9gsKaMpfkXxhR1u7L3YWl6c5HMr7uTBcgMIjIv1Ju41QefGA8X9mP1ATj4m6hsxRftVVS6NmG8tMESWjTmE/iW+iu5IS0be+SKFpP3NKrG5i2hdHk+XnUKiOXioaeTUCCU86Md+6oXR8bEQHkCxlspaiJxm4QwbnegclNvJaJxjhjFCTrD1HC7/ZsToMVtp/NNOz9Fea3AyFF7XrJIUnJ/r2S33cXFQsMjFA5ho5SqaK9LKpvR5PUufS3HHUoEYSxvJL6skNlq79r/l06B6u6p/DL6zRFvqbRZMCkADt+Mrx+cDkffXZXe0/jZLX23rq/eUZnLnRm/iKemM57+Uclg7IFQ0aALGD0NRAsp3T/ZWOSeevKOlVq6rE7vnlpqtWSdzHykkAGRICplkI9xGSOXjeeyG5rUSnZvtN7F/CHGn+sCDf3aaMQN2+AWde7+fY8kICYdvNu3P6sf52yLXgpVeYJ26dOpvdWX1//sCllWv6NJbnc6UcvBbpRmwwhz6g+Eh3ykDipd8WD7xySoiUVahYhUeppAw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <903175290BBC314B898F91AA1CE7B528@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb060faf-d3d6-4a58-abc4-08d83d94c7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 01:20:48.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD34zEgJ0gQfVMJuGyPw7F4mw6udYAMkTUeJk532ymC4KpVEcBjQZv9A+5wlRKMmYAsmbDy5dIx7j3p7k6vMO6ucKayt1C8Iscc2Rg+gG4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3608
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsIHBsZWFzZSBwdWxsIGZyb206DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L252ZGltbS9udmRpbW0uZ2l0Lw0KdGFncy9saWJudmRpbW0t
Zm9yLTUuOQ0KDQouLi50byByZWNlaXZlIGEgbmV3IGZlYXR1cmUgaW4gbGlibnZkaW1tIC0gJ1J1
bnRpbWUgRmlybXdhcmUNCkFjdGl2YXRpb24nLCBhbmQgYSBmZXcgc21hbGwgY2xlYW51cHMgYW5k
IGZpeGVzIGluIGxpYm52ZGltbSBhbmQgREFYLg0KDQpZb3UnZCBub3JtYWxseSByZWNlaXZlIHRo
aXMgcHVsbCByZXF1ZXN0IGZyb20gRGFuIFdpbGxpYW1zLCBidXQgaGUncw0KYnVzeSB3YXRjaGlu
ZyBhIG5ld2Jvcm4gKENvbmdyYXRzIERhbiEpLCBzbyBJJ20gd2F0Y2hpbmcgbGlibnZkaW1tIHRo
aXMNCmN5Y2xlLg0KDQpJJ2Qgb3JpZ2luYWxseSBpbnRlbmRlZCB0byBtYWtlIHNlcGFyYXRlIHRv
cGljLWJhc2VkIHB1bGwgcmVxdWVzdHMgLSBvbmUNCmZvciBsaWJudmRpbW0sIGFuZCBvbmUgZm9y
IERBWCwgYnV0IHNvbWUgb2YgdGhlIERBWCBtYXRlcmlhbCBmZWxsIG91dA0Kc2luY2UgaXQgd2Fz
bid0IHF1aXRlIHJlYWR5LiBJIGVuZGVkIHVwIG1lcmdpbmcgdGhlIHR3byBicmFuY2hlcyBpbnRv
DQpvbmUsIGFuZCBoZW5jZSBhIGNvdXBsZSBvZiAnaW50ZXJuYWwnIG1lcmdlcyAtIEkgaG9wZSB0
aGVzZSBhcmUgb2suIElmDQp5b3UgcHJlZmVyIHRoYXQgSSBzaG91bGQndmUgaGFuZGxlZCB0aGlz
IGRpZmZlcmVudGx5IHBsZWFzZSBsZXQgbWUga25vdyENCg0KSSB3YXMgYWxzbyBleHBlY3Rpbmcg
YSBwb3RlbnRpYWwgY29uZmxpY3QgLSBJIHdhcyBhc3N1bWluZyBHcmVnIGhhZA0KcHVsbGVkIGlu
IG9uZSBvZiBEYW4ncyBwYXRjaGVzWzFdIHRocm91Z2ggZHJpdmVyLWNvcmUsIGJ1dCBJIGRvbid0
IHNlZQ0KaXQgaW4gaGlzIHRyZWUsIGFuZCBhIHRlc3QgbWVyZ2Ugd2l0aCB0aGUgY3VycmVudCBt
YXN0ZXIgd2VudCB0aHJvdWdoDQpjbGVhbmx5Lg0KDQpUaGVyZSB3ZXJlIGEgc21hbGwgaGFuZGZ1
bCBvZiBsYXRlIGZpeGVzLCBidXQgZXZlcnl0aGluZyBoYXMgaGFkIGF0DQpsZWFzdCBhIHdlZWsg
b2YgLW5leHQgc29hayB0aW1lIHdpdGhvdXQgYW55IHJlcG9ydGVkIGlzc3Vlcy4gV2UndmUgYWxz
bw0KcmVjZWl2ZWQgYSBwb3NpdGl2ZSBidWlsZCBub3RpZmljYXRpb24gZnJvbSAwLWRheS4NCg0K
WzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udmRpbW0vMjAyMDA3MjExMDQ0NDIu
R0YxNjc2NjEyQGtyb2FoLmNvbS8NCg0KLS0tDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5j
ZSBjb21taXQgNDg3Nzg0NjRiYjdkMzQ2YjQ3MTU3ZDIxZmZkZTJhZjZiMmQzOTExMDoNCg0KICBM
aW51eCA1LjgtcmMyICgyMDIwLTA2LTIxIDE1OjQ1OjI5IC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxl
IGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvbnZkaW1tL252ZGltbS5naXQvIHRhZ3MvbGlibnZkaW1tLWZv
ci01LjkNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDdmNjc0MDI1ZDlmNzMyMWRl
YTExYjgwMmNjMGFiM2YwOWNiZTUxYzU6DQoNCiAgbGlibnZkaW1tL3NlY3VyaXR5OiBlbnN1cmUg
c3lzZnMgcG9sbCB0aHJlYWQgd29rZSB1cCBhbmQgZmV0Y2ggdXBkYXRlZCBhdHRyICgyMDIwLTA4
LTAzIDE4OjU0OjEzIC0wNjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpsaWJudmRpbW0gZm9yIDUuOQ0KDQotIEFk
ZCAnUnVudGltZSBGaXJtd2FyZSBBY3RpdmF0aW9uJyBzdXBwb3J0IGZvciBOVkRJTU1zIHRoYXQg
YWR2ZXJ0aXNlDQogIHRoZSByZWxldmFudCBjYXBhYmlsaXR5DQotIE1pc2MgbGlibnZkaW1tIGFu
ZCBEQVggY2xlYW51cHMNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQ29seSBMaSAoMSk6DQogICAgICBkYXg6IHByaW50
IGVycm9yIG1lc3NhZ2UgYnkgcHJfaW5mbygpIGluIF9fZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQo
KQ0KDQpEYW4gV2lsbGlhbXMgKDEyKToNCiAgICAgIGxpYm52ZGltbTogVmFsaWRhdGUgY29tbWFu
ZCBmYW1pbHkgaW5kaWNlcw0KICAgICAgQUNQSTogTkZJVDogTW92ZSBidXNfZHNtX21hc2sgb3V0
IG9mIGdlbmVyaWMgbnZkaW1tX2J1c19kZXNjcmlwdG9yDQogICAgICBBQ1BJOiBORklUOiBEZWZp
bmUgcnVudGltZSBmaXJtd2FyZSBhY3RpdmF0aW9uIGNvbW1hbmRzDQogICAgICB0b29scy90ZXN0
aW5nL252ZGltbTogQ2xlYW51cCBkaW1tIGluZGV4IHBhc3NpbmcNCiAgICAgIHRvb2xzL3Rlc3Rp
bmcvbnZkaW1tOiBBZGQgY29tbWFuZCBkZWJ1ZyBtZXNzYWdlcw0KICAgICAgdG9vbHMvdGVzdGlu
Zy9udmRpbW06IFByZXBhcmUgbmZpdF9jdGxfdGVzdCgpIGZvciBORF9DTURfQ0FMTCBlbXVsYXRp
b24NCiAgICAgIHRvb2xzL3Rlc3RpbmcvbnZkaW1tOiBFbXVsYXRlIGZpcm13YXJlIGFjdGl2YXRp
b24gY29tbWFuZHMNCiAgICAgIGRyaXZlci1jb3JlOiBJbnRyb2R1Y2UgREVWSUNFX0FUVFJfQURN
SU5fe1JPLFJXfQ0KICAgICAgbGlibnZkaW1tOiBDb252ZXJ0IHRvIERFVklDRV9BVFRSX0FETUlO
X1JPKCkNCiAgICAgIFBNLCBsaWJudmRpbW06IEFkZCBydW50aW1lIGZpcm13YXJlIGFjdGl2YXRp
b24gc3VwcG9ydA0KICAgICAgQUNQSTogTkZJVDogQWRkIHJ1bnRpbWUgZmlybXdhcmUgYWN0aXZh
dGUgc3VwcG9ydA0KICAgICAgQUNQSTogTkZJVDogRml4IEFSUyB6ZXJvLXNpemVkIGFsbG9jYXRp
b24NCg0KSGFvIExpICgxKToNCiAgICAgIGRheDogRml4IGluY29ycmVjdCBhcmd1bWVudCBwYXNz
ZWQgdG8geGFzX3NldF9lcnIoKQ0KDQpJcmEgV2VpbnkgKDIpOg0KICAgICAgZnMvZGF4OiBSZW1v
dmUgdW51c2VkIHNpemUgcGFyYW1ldGVyDQogICAgICBkcml2ZXJzL2RheDogRXhwYW5kIGxvY2sg
c2NvcGUgdG8gY292ZXIgdGhlIHVzZSBvZiBhZGRyZXNzZXMNCg0KSmFuZSBDaHUgKDMpOg0KICAg
ICAgbGlibnZkaW1tL3NlY3VyaXR5OiBmaXggYSB0eXBvDQogICAgICBsaWJudmRpbW0vc2VjdXJp
dHk6IHRoZSAnc2VjdXJpdHknIGF0dHIgbmV2ZXIgc2hvdyAnb3ZlcndyaXRlJyBzdGF0ZQ0KICAg
ICAgbGlibnZkaW1tL3NlY3VyaXR5OiBlbnN1cmUgc3lzZnMgcG9sbCB0aHJlYWQgd29rZSB1cCBh
bmQgZmV0Y2ggdXBkYXRlZCBhdHRyDQoNClZpc2hhbCBWZXJtYSAoMik6DQogICAgICBNZXJnZSBi
cmFuY2ggJ2Zvci01LjkvZGF4JyBpbnRvIGxpYm52ZGltbS1mb3ItbmV4dA0KICAgICAgTWVyZ2Ug
YnJhbmNoICdmb3ItNS45L2Zpcm13YXJlLWFjdGl2YXRlJyBpbnRvIGxpYm52ZGltbS1mb3ItbmV4
dA0KDQogRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtbmZpdCAgICAgICAgICAg
fCAgMTkgKw0KIERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLW52ZGltbSAgICAg
ICAgIHwgICAyICsNCiAuLi4vZHJpdmVyLWFwaS9udmRpbW0vZmlybXdhcmUtYWN0aXZhdGUucnN0
ICAgICAgICB8ICA4NiArKysrKw0KIGRyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTU3ICsrKysrKy0tLQ0KIGRyaXZlcnMvYWNwaS9uZml0L2ludGVs
LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzg2ICsrKysrKysrKysrKysrKysrKysrKw0K
IGRyaXZlcnMvYWNwaS9uZml0L2ludGVsLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYx
ICsrKysNCiBkcml2ZXJzL2FjcGkvbmZpdC9uZml0LmggICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAzOCArLQ0KIGRyaXZlcnMvZGF4L3N1cGVyLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEzICstDQogZHJpdmVycy9udmRpbW0vYnVzLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMTYgKw0KIGRyaXZlcnMvbnZkaW1tL2NvcmUuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTQ5ICsrKysrKysrDQogZHJpdmVycy9udmRpbW0vZGltbV9kZXZz
LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMjMgKysrKysrLQ0KIGRyaXZlcnMvbnZkaW1t
L25hbWVzcGFjZV9kZXZzLmMgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQogZHJpdmVycy9u
dmRpbW0vbmQtY29yZS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZl
cnMvbnZkaW1tL3Bmbl9kZXZzLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQog
ZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIg
Ky0NCiBkcml2ZXJzL252ZGltbS9zZWN1cml0eS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxMyArLQ0KIGZzL2RheC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDE1ICstDQogaW5jbHVkZS9saW51eC9kZXZpY2UuaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDQgKw0KIGluY2x1ZGUvbGludXgvbGlibnZkaW1tLmggICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDUyICsrLQ0KIGluY2x1ZGUvbGludXgvc3VzcGVuZC5oICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCiBpbmNsdWRlL2xpbnV4L3N5c2ZzLmggICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQogaW5jbHVkZS91YXBpL2xpbnV4L25kY3Rs
LmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KIGtlcm5lbC9wb3dlci9oaWJlcm5h
dGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDk3ICsrKysrKw0KIHRvb2xzL3Rlc3Rp
bmcvbnZkaW1tL3Rlc3QvbmZpdC5jICAgICAgICAgICAgICAgICAgIHwgMzY3ICsrKysrKysrKysr
KysrKystLS0tDQogMjQgZmlsZXMgY2hhbmdlZCwgMTQ4NiBpbnNlcnRpb25zKCspLCAxMzcgZGVs
ZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcv
c3lzZnMtYnVzLW52ZGltbQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RyaXZl
ci1hcGkvbnZkaW1tL2Zpcm13YXJlLWFjdGl2YXRlLnJzdA0K
