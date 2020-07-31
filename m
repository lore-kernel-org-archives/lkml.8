Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4725A208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="O4M0dsmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgGaB2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:28:05 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:24801
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbgGaB2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:28:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM8Xxr1oz6E0j4n/P7qDjYQlCQRaKDJt8DmkHEpvODnOE0+c8sYZrIDtmBoXVxFbUfWUL8vtBf4rCD8McXdhSzzFoj/wC5g3KmvzdUtTK9kLuSr0oz9/MdEIWlTUzfZdPPb4Ir+rkP/K5250KmWBjPqVh7ZIBI7E5TNFJdZB3KblzzlxYMqro1imqH3H+gAgaagklW0ejv6HcqZnZ8Z4WuWxXH0ZDentU+SZ+X0v67McFBwXUe5mKiUavfYpjThhuj2CctxhCG88GCTmgkOv+dut2lYBISx7D8l3SU4hHSSJYtmuLj+oxNdEPlJaoT1+PjU05DAUMSLHRZdZBOi4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuJFflkgn4ifBFld/0e7Sptb8Q73e/qLQ71DFvCrwOw=;
 b=WRYbtN4XltmXYjQ7HL0pItwtTY8K/DooRX7ttkpZl5FJ4XMyfMEKATt3JnebIWEoi5TR+roZlnm96pcf99RKj6tYNC2TjocyjpWvUBVC3Kb6jJgU5h0mVy1DpBHrmArYjamovD1RejaYCD9sw3MacN+7UkYV4OSbULBjl0q0oc00nMZ9r6h9RYyHEMa66Wj0kxfndL+1f81bfi9GhO5egi/nDSjlDd2XJT50xewZKhVmHA55+MzV1zqPTiokbiUyCPGcmd+dgPtdi+BztDN6V0whgxXpGQU0KJKeDS4xNvyMXW5uFHWabdcCSehXbdu/3ofrW8x5oMr4KaQbTHj3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuJFflkgn4ifBFld/0e7Sptb8Q73e/qLQ71DFvCrwOw=;
 b=O4M0dsmczbH3tZ7k+cH+eHpsizpvvZm37qqb1uwz5kIQHxhxMFa4RrcxuezSr11zIwVcgXqfOJWN+meD4C4k4ibSfqz3VFz6J+K7LiqD42v7ehRSAx4KckKcVll5a/1sesp4Ia/Bg1KSTVvrd6iim1VxX2hNZlBpGpWAJ01K3PY=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3816.namprd11.prod.outlook.com (2603:10b6:a03:f8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 31 Jul
 2020 01:28:00 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3216.033; Fri, 31 Jul 2020
 01:28:00 +0000
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
Thread-Index: AQHWZllr2e2B+VfSNkGh7y4SoV6M/6kgyi8AgAAcVOg=
Date:   Fri, 31 Jul 2020 01:27:59 +0000
Message-ID: <BYAPR11MB2632F9297E72A360F83A51E0FF4E0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200730101934.38343-1-qiang.zhang@windriver.com>,<alpine.DEB.2.23.453.2007301644400.3634587@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.23.453.2007301644400.3634587@chino.kir.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73b45d86-bc76-4494-fed0-08d834f0f650
x-ms-traffictypediagnostic: BYAPR11MB3816:
x-microsoft-antispam-prvs: <BYAPR11MB381655C87BCDB56043DD1168FF4E0@BYAPR11MB3816.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WX6C44EsPm4Y6Rug12gX2nJpxXIy3Iekt71dUSruGzghxZVqF9iFaeHkO44Kmp/G9vV79J9YkydN6OxbKwnUitLviCXSCqHPHj25wzpD5hlY2tT2y/wF+eUk1aM+3kWizdl5zPrbyC3YY7wOg3mbzopQKmqCkZWwIcLpdSDjL9HIX+rOcPkDcYUxtqgb5fQLOuBhXvJcPFHFuqY5E0ciW0X0ZQVT2y1NTv3efcxsUtVYmV/iPEG72H7IuAppGbBXl+MUQ/hNsqxB+9/vFr9KM3DYdM51KyCNDjiFdFuRJHGBXBar/arKVvAwqgbnnxDp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(396003)(136003)(39850400004)(86362001)(2906002)(186003)(71200400001)(5660300002)(26005)(76116006)(66556008)(7696005)(6916009)(8936002)(9686003)(316002)(52536014)(478600001)(83380400001)(55016002)(4326008)(33656002)(224303003)(91956017)(66946007)(66446008)(66476007)(64756008)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KDrA7wjYFLXKLcmZS3FoYI21DAwYvfEkJE/5xg03C+8t9QNZZYef6x41XO05cKuBhwphT+j21RRq0iy3ZGLzrjQa5xHNFLljiG/eO2D2sSPNUdIiP7mHr/0GrYtqV6FWsI5+goqWhkLuUxqW296IEQjfGB1wN5/q9CMGEg4nzeY3QxmDxN/D797P40A3PosEPXfAsjSnUu2PRxsScDjrW0iZ1htPp9I31BwgQFFfJfocRjgIVbOITPe9YmytKc1Qjs70fHbdpOeVgPmX3/DS6d4j1tNTUaSrEtbwusIcr+1EXhYUVxutiUt8RudzSR5f/H98Z9kd4JAazNlaMgHzO5NU34IosRXHIwv0UIBCDuCTuXDu1nukEXWoNxI9/9ofqwjo4fFaioPe4ya8a2XTOckGCzo54MIz+faDzOsZW2rF4AG+BG1C1hlXbfN4OWmIyzJguoZlhZH3zVbuUclorECRm6D/ngptv5I2azLkYvA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b45d86-bc76-4494-fed0-08d834f0f650
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 01:27:59.9045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THRbAt0rdEBfpn2j5Qp8ba+cd8TTJrUADf63S9wi9Xes898vhyvJgJFp38LkSVK6PTgp3GIIU4SmMtz+rOd0LwnbBTRPjX2EoavxUEvAwB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3816
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogRGF2aWQg
UmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5jb20+Creiy83KsbzkOiAyMDIwxOo31MIzMcjVIDc6
NDUKytW8/sjLOiBaaGFuZywgUWlhbmcKs63LzTogY2xAbGludXguY29tOyBwZW5iZXJnQGtlcm5l
bC5vcmc7IGlhbWpvb25zb28ua2ltQGxnZS5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7
IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW98ziOiBS
ZTogW1BBVENIIHYzXSBtbS9zbGFiLmM6IGFkZCBub2RlIHNwaW5sb2NrIHByb3RlY3QgaW4gX19j
YWNoZV9mcmVlX2FsaWVuCgpPbiBUaHUsIDMwIEp1bCAyMDIwLCBxaWFuZy56aGFuZ0B3aW5kcml2
ZXIuY29tIHdyb3RlOgoKPiBGcm9tOiBaaGFuZyBRaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVy
LmNvbT4KPgo+IGZvciBleGFtcGxlOgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5v
ZGUwCj4gICAgICAgY3B1MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1MQo+IHNsYWJfZGVhZF9jcHUKPiAgICA+bXV0ZXhfbG9jaygmc2xhYl9tdXRleCkKPiAg
ICAgID5jcHV1cF9jYW5jZWxlZCAgICAgICAgICAgICAgICAgICAgICAgICAgICBzbGFiX2RlYWRf
Y3B1Cj4gICAgICAgID5tYXNrID0gY3B1bWFza19vZl9ub2RlKG5vZGUpICAgICAgICAgICAgICAg
Pm11dGV4X2xvY2soJnNsYWJfbXV0ZXgpCj4gICAgICAgID5uID0gZ2V0X25vZGUoY2FjaGVwMCwg
bm9kZTApCj4gICAgICAgID5zcGluX2xvY2tfaXJxKG4mLT5saXN0X2xvY2spCj4gICAgICAgID5p
ZiAoIWNwdW1hc2tfZW1wdHkobWFzaykpID09IHRydWUKPiAgICAgICAgICAgICAgID5zcGluX3Vu
bG9ja19pcnEoJm4tPmxpc3RfbG9jaykKPiAgICAgICA+Z290byBmcmVlX3NsYWIKPiAgICAgICAg
Li4uLgo+ICAgID5tdXRleF91bmxvY2soJnNsYWJfbXV0ZXgpCj4KPiAuLi4uICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPmNwdXVwX2NhbmNlbGVkCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPm1hc2sgPSBjcHVt
YXNrX29mX25vZGUobm9kZSkKPiBrbWVtX2NhY2hlX2ZyZWUoY2FjaGVwMCApICAgICAgICAgICAg
ICAgICAgICAgICAgICA+biA9IGdldF9ub2RlKGNhY2hlcDAsIG5vZGUwKQo+ICA+X19jYWNoZV9m
cmVlX2FsaWVuKGNhY2hlcDAgKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPnNwaW5fbG9j
a19pcnEobiYtPmxpc3RfbG9jaykKPiAgICA+biA9IGdldF9ub2RlKGNhY2hlcDAsIG5vZGUwKSAg
ICAgICAgICAgICAgICAgICA+aWYgKCFjcHVtYXNrX2VtcHR5KG1hc2spKSA9PSBmYWxzZQo+ICAg
ID5pZiAobi0+YWxpZW4gJiYgbi0+YWxpZW5bcGFnZV9ub2RlXSkgICAgICAgICAgID5hbGllbiA9
IG4tPmFsaWVuCj4gICAgICA+YWxpZW4gPSBuLT5hbGllbltwYWdlX25vZGVdICAgICAgICAgICAg
ICAgICAgPm4tPmFsaWVuID0gTlVMTAo+ICAgICAgPi4uLi4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgID5zcGluX3VubG9ja19pcnEoJm4tPmxpc3RfbG9jaykKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA+Li4uLgo+Cgo+
QXMgbWVudGlvbmVkIGluIHRoZSByZXZpZXcgb2YgdjEgb2YgdGhpcyBwYXRjaCwgd2UgbGlrZWx5
IHdhbnQgdG8gZG8gYSBmaXgKPmZvciBjcHV1cF9jYW5jZWxlZCgpIGluc3RlYWQuCgpJIHNlZSwg
eW91IG1lYW4gIGRvIGZpeCBpbiAiY3B1dXBfY2FuY2VsZWQiIGZ1bmM/
