Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A10C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875E520829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="STSWl461"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgGaIKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:10:47 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:44778
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731522AbgGaIKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:10:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsx/a3ABU4rT4Z+vHCl2R9efIhLeSZn2Y6Y8Yq738GHRv4Y2CMTjVxTeskntASn6juMouOWF6obrpGa4zlfe0ieStL2kcZrtqZsJq1YCWBcWPU6NKprpE0Qq+l9cGtc3hAnaZZaJNE3Ti8KzUGE/j9WiZlWiv9VxyrfByTvrz+SbTrqbnPQYi6Nu3iyVPNfnQNVep10be8fAFMl18lE/ALKtG1/6rQlvXATOc7q50PfyD6T/vHjTmgTqT/ApFTtfl5Qk+IVY+6WEgdA45C+WCLnnuncTFLMMLqyqxoH54JtTpndIfnbSKxox3C+JheHx3t2zxd3mRkGoHtF+QdlkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6haI+YEDjvzQrpXN5c8gqlHGnQ9xk0LVZpWV46hZQkc=;
 b=lfPsTbzruFGXvGvdrlixdXKRiujcZIgg+ikWHW/GVnLE7dgMJnQK78zfXE3SfMI2Wz/PL/5QG4XN03pjZ5l+hNNzmnRYd/cnsviJ43Wp3cuL317tddCAalpxVpbwZ2PQFXPjus1hptcB7b0Z6cf+CiTIq0EOpgyr+Sp7G5sPHEMLav0Gv5SJddiSoryol+U2bLOp/gM+CxhLNBAW/lL0YK6jzo7g69BbwQ5m2Ey22xqHYgLAJUUPEOB+OzaEAokyDap1Aeanbm2JoOkqOi3UQmAiQ8niG6I1el/IFXlxmMBwJmBSuU+T+miHQ8FJeVq7zusunlBGriiSe/wu+uqINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6haI+YEDjvzQrpXN5c8gqlHGnQ9xk0LVZpWV46hZQkc=;
 b=STSWl461yaWjZfukm458zqVvQ12Sj35OPfrGk8x+PSZq58oUI56bRVYps9pNBihqYLdJ4IeRrqJsulSBE9XTkZdQXnexxwcFvo2aA89+u5xzB060jAcRDjvVbDEiKc5p/PU2rTpwCMdV+L4Yuj7NemTb1vt696AfdYduNb/IcJE=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2917.namprd11.prod.outlook.com (2603:10b6:a03:89::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 08:10:43 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3216.033; Fri, 31 Jul 2020
 08:10:43 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     David Rientjes <rientjes@google.com>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYzXSBtbS9zbGFiLmM6IGFkZCBub2RlIHNwaW5sb2Nr?=
 =?gb2312?B?IHByb3RlY3QgaW4gX19jYWNoZV9mcmVlX2FsaWVu?=
Thread-Topic: [PATCH v3] mm/slab.c: add node spinlock protect in
 __cache_free_alien
Thread-Index: AQHWZllr2e2B+VfSNkGh7y4SoV6M/6kgyi8AgAAcVOiAAGy+Qg==
Date:   Fri, 31 Jul 2020 08:10:43 +0000
Message-ID: <BYAPR11MB26323F02BC8A654C9DD4F431FF4E0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200730101934.38343-1-qiang.zhang@windriver.com>,<alpine.DEB.2.23.453.2007301644400.3634587@chino.kir.corp.google.com>,<BYAPR11MB2632F9297E72A360F83A51E0FF4E0@BYAPR11MB2632.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2632F9297E72A360F83A51E0FF4E0@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a7e9cd4-078b-4183-ddac-08d83529388e
x-ms-traffictypediagnostic: BYAPR11MB2917:
x-microsoft-antispam-prvs: <BYAPR11MB29179C67D3EA46A0EFA28BD2FF4E0@BYAPR11MB2917.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+VLL0KhZI04TkAiP+B6Jb5kbuYaplkPYy8jnAN5HHCo20jTbA2ZZw3sAl5ROBGlBIXtVVq/rwc38EXuEbGpyyOSILdk3ey8PHm4/r/5r2tiWRWTlbJMI/bBY8VxTbH0No9Yj6q0BLbaPmg4AhxbYvoAOfKYwFaVqTUwSoKx69/emKaJlAfnz13PADIo5lkER0JpQBwwjrnMj9hFsaLXjl5WdTWPD9lR7cKQSyoZs9ume2tXMoCc6ScnNWx7PmgEnYf7EW6hoz2Voz/o+IELLEEUdX/wZFzj1h6nAzJBrJ/fURx8Xsr6LBvtt1I5HBUhZA66UYj0JJyYxDoJXKGbRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39850400004)(346002)(376002)(366004)(2906002)(9686003)(316002)(186003)(54906003)(26005)(8936002)(478600001)(71200400001)(2940100002)(52536014)(83380400001)(55016002)(86362001)(224303003)(33656002)(91956017)(4326008)(66946007)(7696005)(6506007)(6916009)(76116006)(64756008)(66446008)(5660300002)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nOehYtlebUNqzb4mILLkN6cjFCV9u2eQ+6TLcSabxAasmimUPFBbj4xEWWlEoPDKcWR379yyuJylf+FD3CMP4PpTB/53N7nTWAz1KClnE8xjLE/xjS7Rtx7xRKPlWctNnt3K6qpcxH037CyHuzJdRUG1umeRWOkdhWDdZ7DplxPPRUr2CAArSgF5YFQQrnNBv6MnmnHIue3fXmiwFgfcZY3W7n7eqPf1yjgJfZ9z0gv3BHqqUbeOURb+6ixtFHMSxb25ObCnervN800fjBM4ehlSzZJoiA13RfcOCC2XoptdkJb5il43UDQ+71GPAvs/iDYNZFTJzhww9R0al5ON9RXyX9/TUNAFG1KOcOEbBesdFEAute6vYqJrHxqYDJALFoC3mUffCn6H3Klfmn0VeKWnB6Bb/2Siky1izX4EEB43NwZx1nRTe87CJfAJZtkoHM7ZIZTQroEIdQDB7o6APp1LSXxac3CHXrBNmRLR2GbUtaliQLZqu+kXd/5ZoujEFF+k9v+cV4hzmOaOeLQFj/9dixkNe5n10XaeUEr5JfmWUIckADMPH0CidBZHQxvh9/Hlk2DqnWq0L+zYd7MmmfTvBRx8yecmms5MamgkIcrjU+j8rsiLZd5AWcrkOKjN9C0PU690UasfUYjwrilpIw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7e9cd4-078b-4183-ddac-08d83529388e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 08:10:43.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlvD2XwgCeXdMm5mV6bG5f9FOyYfNmH67BbRZL5ZwBLba9qqFNsPZe22RpCCT7L1MQD1FcZDolhSurkRpbb25KPNRpAnF1XaQVuEACRrwN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogWmhhbmcs
IFFpYW5nIDxRaWFuZy5aaGFuZ0B3aW5kcml2ZXIuY29tPgq3osvNyrG85DogMjAyMMTqN9TCMzHI
1SA5OjI3CsrVvP7IyzogRGF2aWQgUmllbnRqZXMKs63LzTogY2xAbGludXguY29tOyBwZW5iZXJn
QGtlcm5lbC5vcmc7IGlhbWpvb25zb28ua2ltQGxnZS5jb207IGFrcG1AbGludXgtZm91bmRhdGlv
bi5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW
98ziOiC72Li0OiBbUEFUQ0ggdjNdIG1tL3NsYWIuYzogYWRkIG5vZGUgc3BpbmxvY2sgcHJvdGVj
dCBpbiBfX2NhY2hlX2ZyZWVfYWxpZW4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwq3orz+yMs6IERhdmlkIFJpZW50amVzIDxyaWVudGplc0Bnb29nbGUuY29tPgq3
osvNyrG85DogMjAyMMTqN9TCMzHI1SA3OjQ1CsrVvP7IyzogWmhhbmcsIFFpYW5nCrOty806IGNs
QGxpbnV4LmNvbTsgcGVuYmVyZ0BrZXJuZWwub3JnOyBpYW1qb29uc29vLmtpbUBsZ2UuY29tOyBh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcK1vfM4jogUmU6IFtQQVRDSCB2M10gbW0vc2xhYi5jOiBhZGQgbm9k
ZSBzcGlubG9jayBwcm90ZWN0IGluIF9fY2FjaGVfZnJlZV9hbGllbgoKT24gVGh1LCAzMCBKdWwg
MjAyMCwgcWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbSB3cm90ZToKCj4gRnJvbTogWmhhbmcgUWlh
bmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Cj4KPiBmb3IgZXhhbXBsZToKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBub2RlMAo+ICAgICAgIGNwdTAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdTEKPiBzbGFiX2RlYWRfY3B1Cj4gICAgPm11
dGV4X2xvY2soJnNsYWJfbXV0ZXgpCj4gICAgICA+Y3B1dXBfY2FuY2VsZWQgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2xhYl9kZWFkX2NwdQo+ICAgICAgICA+bWFzayA9IGNwdW1hc2tfb2Zf
bm9kZShub2RlKSAgICAgICAgICAgICAgID5tdXRleF9sb2NrKCZzbGFiX211dGV4KQo+ICAgICAg
ICA+biA9IGdldF9ub2RlKGNhY2hlcDAsIG5vZGUwKQo+ICAgICAgICA+c3Bpbl9sb2NrX2lycShu
Ji0+bGlzdF9sb2NrKQo+ICAgICAgICA+aWYgKCFjcHVtYXNrX2VtcHR5KG1hc2spKSA9PSB0cnVl
Cj4gICAgICAgICAgICAgICA+c3Bpbl91bmxvY2tfaXJxKCZuLT5saXN0X2xvY2spCj4gICAgICAg
PmdvdG8gZnJlZV9zbGFiCj4gICAgICAgIC4uLi4KPiAgICA+bXV0ZXhfdW5sb2NrKCZzbGFiX211
dGV4KQo+Cj4gLi4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ID5jcHV1cF9jYW5jZWxlZAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgID5tYXNrID0gY3B1bWFza19vZl9ub2RlKG5vZGUpCj4ga21lbV9jYWNoZV9m
cmVlKGNhY2hlcDAgKSAgICAgICAgICAgICAgICAgICAgICAgICAgPm4gPSBnZXRfbm9kZShjYWNo
ZXAwLCBub2RlMCkKPiAgPl9fY2FjaGVfZnJlZV9hbGllbihjYWNoZXAwICkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgID5zcGluX2xvY2tfaXJxKG4mLT5saXN0X2xvY2spCj4gICAgPm4gPSBn
ZXRfbm9kZShjYWNoZXAwLCBub2RlMCkgICAgICAgICAgICAgICAgICAgPmlmICghY3B1bWFza19l
bXB0eShtYXNrKSkgPT0gZmFsc2UKPiAgICA+aWYgKG4tPmFsaWVuICYmIG4tPmFsaWVuW3BhZ2Vf
bm9kZV0pICAgICAgICAgICA+YWxpZW4gPSBuLT5hbGllbgo+ICAgICAgPmFsaWVuID0gbi0+YWxp
ZW5bcGFnZV9ub2RlXSAgICAgICAgICAgICAgICAgID5uLT5hbGllbiA9IE5VTEwKPiAgICAgID4u
Li4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA+c3Bpbl91bmxvY2tf
aXJxKCZuLT5saXN0X2xvY2spCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPi4uLi4KPgoKPkFzIG1lbnRpb25lZCBpbiB0aGUgcmV2aWV3IG9mIHYx
IG9mIHRoaXMgcGF0Y2gsIHdlIGxpa2VseSB3YW50IHRvIGRvIGEgZml4Cj5mb3IgY3B1dXBfY2Fu
Y2VsZWQoKSBpbnN0ZWFkLgoKPkkgc2VlLCB5b3UgbWVhbiAgZG8gZml4IGluICJjcHV1cF9jYW5j
ZWxlZCIgZnVuYz8KCiBJJ20gdmVyeSBzb3JyeSwgZHVlIHRvIGNwdV9kb3duIHJlY2VpdmUgZ29i
YWwgICJjcHVfaG90cGx1Z19sb2NrIiB3cml0ZSBsb2NrICBwcm90ZWN0LiBtdWx0aXBsZSBjcHUg
b2ZmbGluZSBpcyBzZXJpYWyjrHRoZSBzY2VuYXJpbyBJIGRlc2NyaWJlZCBhYm92ZSBkb2VzIG5v
dCBleGlzdC4=
