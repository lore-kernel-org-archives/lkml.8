Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214F5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AE220722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="TKo0MhaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHCJof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:44:35 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:54369
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbgHCJoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:44:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRYjS68Rc7HblysAIumsxrbIyBhpJPnX7N9j52iL+PsI2gvgvvV3JcCsr6tNJuAE1yWE2NnfWzB3cP9MFhjJPo+o7/estjiOa8VWRwaFlYP5Ha1KNz6YqqG6DWc6RY8r291b6wlu/bG4csr9wJSW45xpo4fnnhzDDnyqIik5VkkIu6ElHMZVtyGi5glS4uD800mXpwUN5GQpgleTsYGl+f7Q4ctfb37prOAQslSoXi5rbV4YHqopIX3GTiHoOQ8AOkcPgF3NwXlw4GHf0Jjh7kRwYVaGqg5Noz6v6V46lUqKIuLn5oJGY1MK+hPNrUCO+vXbVq00YawzQYad3KPKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBfeONgKqo3d6Ri3S05XRe9BlAtPU1f027OaCCqghFg=;
 b=BOu2Yx/f3wHbmFGAad271tm2/CcolElxpJl94GZ495ySGNl2ztQoqYzFIBg239Wq8lMlHopLL73irvfXis13lM9+7tlR0jjX3xDy2H08ANqygydudDb7vp86JT8Vk5+HbtW9hpDchmpSDCxl96L+V7vI3yd/oNh2gtrIYkGBDzVjDxOT1om8ppMic6Ua7pJcX9sCJ7pb2zLonZBjP6736dSi18Fw4L65hCyymVsQ29yPx2GBbj/YCIPeYRhm4oAFH7CwXVJyL54fLSvrvAHqGsuFwyEoGup0cC1oFhHhMsUi0icR94C3W8ipICoro5spBvPX4aboXUY1AoNdi99iEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBfeONgKqo3d6Ri3S05XRe9BlAtPU1f027OaCCqghFg=;
 b=TKo0MhaFTIb7MzTIWTsw+BZJHmI+Y18obgNtmgLzxpN2kFJ7Iqd996vPGRqsTzWn/gJ0QczW3zTplUjnhafBAV6wSEW3Jh5anfCiiu9zv1bwcXLPFR5Bv/ZDE7SY9KpqCfsQp15hht804mRgWqti+4ISxgQJAU+C5KwlvqI2PJM=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Mon, 3 Aug
 2020 09:44:31 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:44:30 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIXSBBTFNBOiBzZXE6IEtBU0FOOiB1c2UtYWZ0?=
 =?gb2312?B?ZXItZnJlZSBSZWFkIGluIGRlbGV0ZV9hbmRfdW5zdWJzY3JpYmVfcG9ydA==?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIXSBBTFNBOiBzZXE6IEtBU0FOOiB1c2UtYWZ0ZXItZnJl?=
 =?gb2312?B?ZSBSZWFkIGluIGRlbGV0ZV9hbmRfdW5zdWJzY3JpYmVfcG9ydA==?=
Thread-Index: AQHWZ8sQtHTXuigAMkePkOt4rNcOXaki/9SAgAKbJxmAAFCjAIAAOLFm
Date:   Mon, 3 Aug 2020 09:44:30 +0000
Message-ID: <BYAPR11MB263286CE056BBFE368EEC20EFF4D0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200801062403.8005-1-qiang.zhang@windriver.com>,<s5hd0486yq3.wl-tiwai@suse.de>
In-Reply-To: <s5hd0486yq3.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c3d6615-5fbb-42db-ff67-08d83791d23a
x-ms-traffictypediagnostic: BYAPR11MB2808:
x-microsoft-antispam-prvs: <BYAPR11MB2808487F7A0F2459EA1CBCFFFF4D0@BYAPR11MB2808.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kopCj843xWnuMsJgISp8XU9RwoTqlWRAlKpLiZyR62Tx3jD8tQBLfJNpPfhXSb0pCDtRemR/f0Gj8Pvo/dj0Gd7HdF6FMBx5lhH62rYD5OrXAyKq47N3QPYnsoxR31iE49Hm39EYqeWxVdTX4DNNzwOIYPLrzpTSvVFkAwvOWkIG/gJW4nu0STDXJRownFzLde10ZXCBcC8tspJLYHsiKw74qgb3lf2gS43vDcq0mTD29z4NXtyo+zfIOLLEbB+OM9a4v4+lVCNFgDt4AUZo45IbDfwZwaa6Yw6jRInekMmebUCNhy0R/giCOjA2JnibDbLmWSXg4s+Nt/PDFNiHTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(346002)(376002)(366004)(136003)(316002)(33656002)(6916009)(186003)(7696005)(2906002)(8936002)(54906003)(26005)(6506007)(4326008)(71200400001)(478600001)(66556008)(66446008)(52536014)(5660300002)(86362001)(66946007)(55016002)(83380400001)(66476007)(64756008)(91956017)(76116006)(224303003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lOlUYXxfVWAjabGrcyTTZWPxPx1nJSEy/FQ8ENZLsbtK4Qa3spdVidT/8zdowUnnyLUUl/ViPypwdktxihe8rx/iXIiGBuoa7II+U0Ias6alHigWXlxxt6lClWAQ3J8ePIOIFhMWBhn2oMEnfLs8qQUGv/kH1qdRATspr9ZFXoe92hTKTkngZKZ3TkP5i9vxyhS8snPx2m+9XerufyjH2rRdEW0cAktE4vN/8DxPke2PmHwjKMCqMi/00dvKVe7mDuecZHsbewvNJs3+X94mfk4KRTEh7iNtYpSAe/P9mndhb+l546f9ahEqKLRS5axJXmGYOHGT0zL7Inu/3+oEAR2fIdHz17ap/KzVY2PBQfK/gNxEEwgnyjx0lMs7e3WcDXN0nsVe9dHBi4R/w/1ULqGjxLBe8zuklNdJZo4+FuXnGoqPWpcO0Q5f0/I5SLVe+pnHoZFuFQWiq1hruCJwDOJKlfauEozGWlGlYbgK1DimqDmRLOZBblPIjyaAoqF2BkQd9IkeRoDiIc5oFJXqJKm/6qhPw7jIEzdULIrhtgbSmz0WH73zWeteRda4Qfk9tCUjsR0OllnzFvUCj6va3KiUCg5X2LNUPAIEQ+s7iTX5Sc2sFClKebJn8K4a2EX/B4i9rnMki5EYX7LzFX5wIg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3d6615-5fbb-42db-ff67-08d83791d23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 09:44:30.8703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKOlYOHj+beR+wBphputjt5l0K5zSH3gTlxEq1k5GDcyRsGPeFqLyvCP9rSwH+AIbvafnVCylg9/pBnYc50H3Lp5DtM6RVnnIa8NLkxqTMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVGFrYXNo
aSBJd2FpIDx0aXdhaUBzdXNlLmRlPgq3osvNyrG85DogMjAyMMTqONTCM8jVIDE0OjE2CsrVvP7I
yzogWmhhbmcsIFFpYW5nCrOty806IHBlcmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbTsgYWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCtb3
zOI6IFJlOiC72Li0OiBbUEFUQ0hdIEFMU0E6IHNlcTogS0FTQU46IHVzZS1hZnRlci1mcmVlIFJl
YWQgaW4gZGVsZXRlX2FuZF91bnN1YnNjcmliZV9wb3J0CgpPbiBNb24sIDAzIEF1ZyAyMDIwIDAz
OjM1OjA1ICswMjAwLApaaGFuZywgUWlhbmcgd3JvdGU6Cj4KPiA+VGhhbmtzIGZvciB0aGUgcGF0
Y2guICBCdXQgSSdtIGFmcmFpZCB0aGF0IHRoaXMgY2hhbmdlIHdvdWxkIGJyZWFrIHRoZQo+ID5l
eGlzdGluZyBiZWhhdmlvciBhbmQgbWlnaHQgaGF2ZSBhIGJhZCBzaWRlLWVmZmVjdC4KPgo+ID5J
dCdzIGxpa2VseSB0aGUgc2FtZSBpc3N1ZSBhcyByZXBvcnRlZCBpbiBhbm90aGVyIHN5emthbGxl
ciByZXBvcnQKPiA+KCJLQVNBTjogaW52YWxpZC1mcmVlIGluIHNuZF9zZXFfcG9ydF9kaXNjb25u
ZWN0IiksIGFuZCBIaWxsZidzIHBhdGNoCj4gPmJlbG93IHNob3VsZCBjb3ZlcnQgdGhpcyBhcyB3
ZWxsLiAgQ291bGQgeW91IGNoZWNrIHdoZXRoZXIgaXQgd29ya3M/Cj4KPiB5ZXMgSXQncyBzaG91
bGQgc2FtZSBpc3N1ZSwgYWRkIG11dGV4IGxvY2sgaW4gb2Rldl9pb2N0bCwgZW5zdXJlIHNlcmlh
bGl6YXRpb24uCj4gaG93ZXZlciwgaXQgc2hvdWxkIG5vdCBiZSBuZWNlc3NhcnkgdG8gbXV0dWFs
bHkgZXhjbHVzaXZlIHdpdGggb3BlbiBhbmQgY2xvc2UuCgo+Pj5UaGF0J3MgYSBiaWctaGFtbWVy
IGFwcHJvYWNoIGluZGVlZCwgYnV0IGl0IHNob3VsZCBiZSBtb3JlIHJlYXNvbmFibGUKPj4+aW4g
dGhpcyBjYXNlLiAgSXQgbWFrZXMgdGhlIHBhdGNoIHNob3J0ZXIgYW5kIHNpbXBsZXIsIHdoaWxl
IHRoZSBPU1MKPj4+c2VxdWVuY2VyIGlzIGFuIGFuY2llbnQgaW50ZXJmYWNlIHRoYXQgd2Fzbid0
IGNvbnNpZGVyZWQgbXVjaCBmb3IgdGhlCj4+PmNvbmN1cnJlbmN5LCBhbmQgdGhpcyBtaWdodCBh
bHNvIGNvdmVyIHRoZSBjYXNlIHdoZXJlIHRoZSBhY2Nlc3MgdG8KPj4+YW5vdGhlciBzZXF1ZW5j
ZXIgb2JqZWN0IHRoYXQgaXMgYmVpbmcgdG8gYmUgY2xvc2VkLgoKPj4+U28sIGl0J2QgYmUgZ3Jl
YXQgaWYgeW91IGNhbiBjb25maXJtIHRoYXQgdGhlIHBhdGNoIGFjdHVhbGx5IHdvcmtzLgo+Pj5U
aGVuIHdlIGNhbiBicnVzaCB1cCBhbmQgbWVyZ2UgaXQgZm9yIDUuOS1yYzEuCgpKdXN0IGxpa2Ug
eW91IHNhaWQsIHRoaXMgY2hhbmdlIGlzIG1vcmUgcmVhc29uYWJsZS4gSXQgbWFrZXMgdGhlIHBh
dGNoIHNob3J0ZXIgYW5kIHNpbXBsZXIuIAoKCj4+PnRoYW5rcywKCj4+PlRha2FzaGkKCj4KPgo+
Cj4gPnRoYW5rcywKPgo+ID5UYWthc2hpCj4KPiA+LS0tCj4gPi0tLSBhL3NvdW5kL2NvcmUvc2Vx
L29zcy9zZXFfb3NzLmMKPiA+KysrIGIvc291bmQvY29yZS9zZXEvb3NzL3NlcV9vc3MuYwo+ID5A
QCAtMTY3LDExICsxNjcsMTcgQEAgb2Rldl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3Qg
Y2hhcgo+ICA+c3RhdGljIGxvbmcKPiAgPm9kZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVu
c2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKQo+ICA+ewo+ID4rICAgICAgIGxvbmcg
cmM7Cj4gPiAgICAgIHN0cnVjdCBzZXFfb3NzX2RldmluZm8gKmRwOwo+ID4rCj4gPisgICAgICAg
bXV0ZXhfbG9jaygmcmVnaXN0ZXJfbXV0ZXgpOwo+ID4gICAgICAgZHAgPSBmaWxlLT5wcml2YXRl
X2RhdGE7Cj4gPiAgICAgICAgaWYgKHNuZF9CVUdfT04oIWRwKSkKPiA+LSAgICAgICAgICAgICAg
IHJldHVybiAtRU5YSU87Cj4gPi0gICAgICAgcmV0dXJuIHNuZF9zZXFfb3NzX2lvY3RsKGRwLCBj
bWQsIGFyZyk7Cj4gPisgICAgICAgICAgICAgICByYyA9IC1FTlhJTzsKPiA+KyAgICAgICBlbHNl
Cj4gPisgICAgICAgICAgICAgICByYyA9IHNuZF9zZXFfb3NzX2lvY3RsKGRwLCBjbWQsIGFyZyk7
Cj4gPisgICAgICAgbXV0ZXhfdW5sb2NrKCZyZWdpc3Rlcl9tdXRleCk7Cj4gPisgICAgICAgcmV0
dXJuIHJjOwo+ICA+fQo+Cj4gID4jaWZkZWYgQ09ORklHX0NPTVBBVAo=
