Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456952083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="Fqd1JoDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgG2BZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:25:45 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:11379
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728364AbgG2BZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spr1VJwfxitvXGa0FE6arZuB2kmG4H+Mpt5vDYs2ye36ubAxhZnOCa3zypANgiHq8NNnuH2LINcY+9xfwbao1UWqKwGBAnID5Y6OmT5QUffMeLJogLVj/zy3SKNNraRZmVNAORu/qUGAyw6Y4tmkqbx8S585eOSUgvRGQVHg08rzDNGtdwm4OZKoptFbjzXcLDVjSqf5YVzHoa5K1y8jm5KwLDZsc5Q18mP7M8ZiMhDlerHh0g8iRwfyl94cinQBiWju8SLB4vKrL7pYdwLyrVU9Pm9sNO6QxNQUGJePrq33OzNjHIih1oXWDOOjzL/2H3Q4kmxEqd1XxSGo/LaAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mboMopw+/BgBfr1WKI2D/4SkBivmVE1zMeR78HINAnc=;
 b=SQAzXv3+aK5Bo8grqLMzLCeilbUBptUzoS2aZ6E/wUaadgbe4ZE5rWhNklx6uJbhnWdEV6GtPFiYqiicCJJd0y6W4ap6qmJtX9K+V9iWJeutX6XBTv1SMUCD1rDBHuqu49YAwJqMQpdICXjnRJmAOJIgeQcQ6GUfpfK7+Shwf0JGT+faRKQXzqGuJ8gzDAkAvRniHoV670JgOL9Okb+f5BAQPD9tum/sBYfxNNnU2dJVnvr2B5ZF+PuvSgll3LqQoDI9lHhwASVOe2YCoRcGiDFz0rVQyor0at5jKcffpPMMwwtOy4BRpA88UXAFln2OXstOeCDdB0rwssGd6vUqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mboMopw+/BgBfr1WKI2D/4SkBivmVE1zMeR78HINAnc=;
 b=Fqd1JoDOylomaMmbCel0hzkJJXxUgw9y9quaqZPQQ2uwQyvYp6PEcineTe1pc2TSR82EVw6/icL9MllPVkeMa5xgTSxfRpOUAUKPPo1OjAQjfi8tYecrJCu/h4x7YUuHlInZ/yxAOk6X6Mu/6Urm4Ygn+MpKIoMLRXJ793qSLOU=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3910.namprd11.prod.outlook.com (2603:10b6:a03:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 01:25:41 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3216.033; Wed, 29 Jul 2020
 01:25:40 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     David Rientjes <rientjes@google.com>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBtbS9zbGFiLmM6IGFkZCBub2RlIHNwaW5sb2NrIHBy?=
 =?gb2312?B?b3RlY3QgaW4gX19jYWNoZV9mcmVlX2FsaWVu?=
Thread-Topic: [PATCH] mm/slab.c: add node spinlock protect in
 __cache_free_alien
Thread-Index: AQHWZMQFoTkD7weJCUOnJq5QL+ZCSqkdZfCAgABbbpU=
Date:   Wed, 29 Jul 2020 01:25:40 +0000
Message-ID: <BYAPR11MB2632BEC45DC867E80F841B82FF700@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200728095551.30634-1-qiang.zhang@windriver.com>,<alpine.DEB.2.23.453.2007281238580.2664959@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.23.453.2007281238580.2664959@chino.kir.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fde134a-28ea-44dd-3616-08d8335e4e81
x-ms-traffictypediagnostic: BY5PR11MB3910:
x-microsoft-antispam-prvs: <BY5PR11MB3910F0B83E5230F9BB472F57FF700@BY5PR11MB3910.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6eebIcYFEWTOUBWh6MXdSlAsFyoJY0Xdw271ulXWhjGruiJ9V7ClLxf5Woga3ZhSh/Q8jtuV53u3v5znTMMOVq3WltFjFExY4XweWIJkysRGQRb+58ukud2efomgKmlfOomAoFuKefWQAu9TJV1Knhozptj7LKeADRpO4e2778VOXIrWBHEdRmCSxHyfGVcLcTOtgCEcAlossWBZTzBH0KFEvVEjIKRbfa6+uYIA6Zxirud1hLCTHeNTQCW99TInLps0uWN9icPDBWFyrpJG4mDTrpyoPkTWLAJ+hVMVZzJ6R5+WHb8XcJ0TTsv76zlh1uiWNkFja58s21MGLKkaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39850400004)(376002)(346002)(136003)(6506007)(7696005)(26005)(33656002)(8936002)(5660300002)(6916009)(83380400001)(186003)(52536014)(86362001)(4326008)(2906002)(478600001)(71200400001)(316002)(54906003)(66946007)(224303003)(55016002)(66446008)(66476007)(91956017)(76116006)(9686003)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8adb55q5FQ9aMhMwxk2avNH6mvRWzTj8AHLaA+bZqxnSQKc5uGTiT0K6onXXoU1GCFsB5J6fBOfI7wxjx1VJvwmEUiIAQmLicelEiZOiOawQtuZdZr/8nflGrjlMVn9LB4sN4Y2QAxxOylSRICDze9BGNIJukxSc02IKPX61W0KodlrI3Mc5+CyMouxiZ5n90nQFWrwNbymxgyQ6oVQ2+qiXpeFZKrnLOMZGeoNVMZl0wnCptu2pJzC2SUW5B4CUJfwauXxijwSXv0N2Se7Bv85Mo0rXeWD7grmnO+jznZeZh8Tdoebhr4r86KOnkhsuy1rAQQ8BrUE5yYPl3F9ffdYysaIjGFuxcq7qXpBvuJB718JZAtN4ze/5yDxGQfg60hwqBDklopz4FZ/CCrWnqmF1DRlYAl33XHtWs8IWPclnRPUTxf+lsFlz7o/mGmGU69k9OByr3zaMrAo6QIHdWtFJ8D95T487c1NpdaUqVmM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fde134a-28ea-44dd-3616-08d8335e4e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 01:25:40.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rli4JDSsEiPVqA1FeSrlP0Oo/2KBV0qOPtJGGQ/c5Dd1MJtQlKxPn79LwBokKpb8b/3pHuAo/SoCPzFT9B1YgOXc3J0CYlP2264LZLMh7yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogRGF2aWQg
UmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5jb20+Creiy83KsbzkOiAyMDIwxOo31MIyOcjVIDM6
NDYKytW8/sjLOiBaaGFuZywgUWlhbmcKs63LzTogY2xAbGludXguY29tOyBwZW5iZXJnQGtlcm5l
bC5vcmc7IGlhbWpvb25zb28ua2ltQGxnZS5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7
IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW98ziOiBS
ZTogW1BBVENIXSBtbS9zbGFiLmM6IGFkZCBub2RlIHNwaW5sb2NrIHByb3RlY3QgaW4gX19jYWNo
ZV9mcmVlX2FsaWVuCgpPbiBUdWUsIDI4IEp1bCAyMDIwLCBxaWFuZy56aGFuZ0B3aW5kcml2ZXIu
Y29tIHdyb3RlOgoKPiBGcm9tOiBaaGFuZyBRaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNv
bT4KPgo+IFdlIHNob3VsZCBhZGQgbm9kZSBzcGlubG9jayBwcm90ZWN0ICJuLT5hbGllbiIgd2hp
Y2ggbWF5IGJlCj4gYXNzaWduZWQgdG8gTlVMTCBpbiBjcHV1cF9jYW5jZWxlZCBmdW5jLiBjYXVz
ZSBhZGRyZXNzIGFjY2Vzcwo+IGV4Y2VwdGlvbi4KPgoKPkhpLCBkbyB5b3UgaGF2ZSBhbiBleGFt
cGxlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSB3aGVyZSB5b3UgaGF2ZSBoaXQKPnRoaXM/Cgo+
VGhpcyByYXRoZXIgbG9va3MgbGlrZSBzb21ldGhpbmcgdG8gZml4IHVwIGluIGNwdXVwX2NhbmNl
bGVkKCkgc2luY2UgaXQncwo+Y3VycmVudGx5IG1hbmlwdWxhdGluZyB0aGUgYWxpZW4gY2FjaGUg
Zm9yIHRoZSBjYW5jZWxlZCBjcHUncyBub2RlLgoKeWVzICwgaXQgaXMgZml4IHVwIGluIGNwdXVw
X2NhbmNlbGVkICBpdCdzCmN1cnJlbnRseSBtYW5pcHVsYXRpbmcgdGhlIGFsaWVuIGNhY2hlIGZv
ciB0aGUgY2FuY2VsZWQgY3B1J3Mgbm9kZSB3aGljaCAgbWF5IGJlIHRoZSBzYW1lIGFzIHRoZSBu
b2RlIGJlaW5nIG9wZXJhdGVkIG9uIGluIHRoZSBfX2NhY2hlX2ZyZWVfYWxpZW4gZnVuYy4KCnZv
aWQgY3B1dXBfY2FuY2VsZWQKewogICAgICAgIG4gPSBnZXRfbm9kZShjYWNoZXAsIG5vZGUpOwog
ICAgICAgIHNwaW5fbG9ja19pcnEoJm4tPmxpc3RfbG9jayk7CiAgICAgICAgLi4uCiAgICAgICAg
bi0+YWxpZW4gPSBOVUxMOwogICAgICAgIHNwaW5fdW5sb2NrX2lycSgmbi0+bGlzdF9sb2NrKTsK
ICAgICAgICAgLi4uLgp9Cgo+IEZpeGVzOiAxOGJmODU0MTE3YzYgKCJzbGFiOiB1c2UgZ2V0X25v
ZGUoKSBhbmQga21lbV9jYWNoZV9ub2RlKCkgZnVuY3Rpb25zIikKPiBTaWduZWQtb2ZmLWJ5OiBa
aGFuZyBRaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPiAtLS0KPiAgbW0vc2xhYi5j
IHwgNyArKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbW0vc2xhYi5jIGIvbW0vc2xhYi5jCj4gaW5kZXggYTg5
NjMzNjAzYjJkLi4yOTA1MjNjOTBiNGUgMTAwNjQ0Cj4gLS0tIGEvbW0vc2xhYi5jCj4gKysrIGIv
bW0vc2xhYi5jCj4gQEAgLTc1OSw4ICs3NTksMTAgQEAgc3RhdGljIGludCBfX2NhY2hlX2ZyZWVf
YWxpZW4oc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlcCwgdm9pZCAqb2JqcCwKPgo+ICAgICAgIG4g
PSBnZXRfbm9kZShjYWNoZXAsIG5vZGUpOwo+ICAgICAgIFNUQVRTX0lOQ19OT0RFRlJFRVMoY2Fj
aGVwKTsKPiArICAgICBzcGluX2xvY2soJm4tPmxpc3RfbG9jayk7Cj4gICAgICAgaWYgKG4tPmFs
aWVuICYmIG4tPmFsaWVuW3BhZ2Vfbm9kZV0pIHsKPiAgICAgICAgICAgICAgIGFsaWVuID0gbi0+
YWxpZW5bcGFnZV9ub2RlXTsKPiArICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZuLT5saXN0X2xv
Y2spOwo+ICAgICAgICAgICAgICAgYWMgPSAmYWxpZW4tPmFjOwo+ICAgICAgICAgICAgICAgc3Bp
bl9sb2NrKCZhbGllbi0+bG9jayk7Cj4gICAgICAgICAgICAgICBpZiAodW5saWtlbHkoYWMtPmF2
YWlsID09IGFjLT5saW1pdCkpIHsKPiBAQCAtNzY5LDE0ICs3NzEsMTUgQEAgc3RhdGljIGludCBf
X2NhY2hlX2ZyZWVfYWxpZW4oc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlcCwgdm9pZCAqb2JqcCwK
PiAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgIGFjLT5lbnRyeVthYy0+YXZhaWwrK10g
PSBvYmpwOwo+ICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJmFsaWVuLT5sb2NrKTsKPiAtICAg
ICAgICAgICAgIHNsYWJzX2Rlc3Ryb3koY2FjaGVwLCAmbGlzdCk7Cj4gICAgICAgfSBlbHNlIHsK
PiArICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZuLT5saXN0X2xvY2spOwo+ICAgICAgICAgICAg
ICAgbiA9IGdldF9ub2RlKGNhY2hlcCwgcGFnZV9ub2RlKTsKPiAgICAgICAgICAgICAgIHNwaW5f
bG9jaygmbi0+bGlzdF9sb2NrKTsKPiAgICAgICAgICAgICAgIGZyZWVfYmxvY2soY2FjaGVwLCAm
b2JqcCwgMSwgcGFnZV9ub2RlLCAmbGlzdCk7Cj4gICAgICAgICAgICAgICBzcGluX3VubG9jaygm
bi0+bGlzdF9sb2NrKTsKPiAtICAgICAgICAgICAgIHNsYWJzX2Rlc3Ryb3koY2FjaGVwLCAmbGlz
dCk7Cj4gICAgICAgfQo+ICsKPiArICAgICBzbGFic19kZXN0cm95KGNhY2hlcCwgJmxpc3QpOwo+
ICAgICAgIHJldHVybiAxOwo+ICB9Cj4KPiAtLQo+IDIuMjYuMgo+Cj4K
