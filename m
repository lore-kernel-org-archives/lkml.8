Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0321BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C73207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="pkARVToz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgEZKEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:04:53 -0400
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:32192
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbgEZKEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:04:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNyzXab/Y9eRXh1wCcAUMrUuO7dnUDovNn7bboTB4QVb+3TFTWdZNjBL9sD4ftXdZpQ4ptEUM9XEmzGb4vIDtynZx3As0mgiPqpq/CtERmPpyZMq2VjW3+x2um/7QU0n6ZGmMP81hn6HggvOPDcgTjMB1SyJLyAWm4YawIuOEvEQ7hq7mhrErl+FnB3cZUyTQDjyHblCyQHGnZF/hzhXFXfuvC4nQ0rdZlnkPFDvIcPOJkHpHyhQXP27D9GpBx4EHJVnaVXXqCB6bCziHQdQAmsqwILjsKu1k8Uyc0yts0ZQS9CNaSE6u47Xj5wMCwCGmw6SfYq0ydRW5cLIGfvhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7gJA42HLsJ2FpMQdQZqgzL0+QSdKtEdLjwC+QJ1qs4=;
 b=RO6tonaRHvW2X4GdeZd/7scZqMajS+0pSBjoTFKg+nH9IC4jQsBQjlULeaHsbstbj7alpkUgKmpHhH2Iw4ISqDSSwMHpB5wF4VxzScnojqmmJkvVOAkKb2zl15qHnHSoJwiOYEME+xVVF2jbp9bZ60NxzN87mcGYORaMlTCOgG1Qpr5+gIiCWG83s2E6dWAJ7/zVSjZ8HV/TrkZd89nYXxIRhoDtAPPe8IIa7/M7ODCmHEa4o44jXsjeCNegVNMUbq3d7U2Bll3QB9zMKqeFqQX++BnTNLrPQx4OjiReo1wUwliwLEtgFnJVbOfdW/dpgZlI3kR34ca0XbSdnuGUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7gJA42HLsJ2FpMQdQZqgzL0+QSdKtEdLjwC+QJ1qs4=;
 b=pkARVTozaZ9id7B/PvLabfGaGNqYJ3ABG8DltSvaiIRHPFdNW8HqL7CTr+apdtUwNUQbJX+HeD/odcKzW/Fac++N3HWeWnUcPFqBhuHuHWZFJlsY8JzyRDnOHSEUaKKBZUD9EjosBbScC4kh7tTKLFkpkFNJPwNUyDsrzOk/Afc=
Received: from BYAPR11MB3253.namprd11.prod.outlook.com (2603:10b6:a03:77::31)
 by BYAPR11MB3352.namprd11.prod.outlook.com (2603:10b6:a03:1d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 10:04:50 +0000
Received: from BYAPR11MB3253.namprd11.prod.outlook.com
 ([fe80::18e7:4cfc:e31:8ccd]) by BYAPR11MB3253.namprd11.prod.outlook.com
 ([fe80::18e7:4cfc:e31:8ccd%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 10:04:49 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
CC:     Tejun Heo <tj@kernel.org>,
        "markus.elfring@web.de" <markus.elfring@web.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] workqueue: Fix double kfree for rescuer
Thread-Topic: [PATCH v3] workqueue: Fix double kfree for rescuer
Thread-Index: AQHWMnYjIawh3tW0rky8WfQ11dkEAqi6Eh6AgACVGYA=
Date:   Tue, 26 May 2020 10:04:49 +0000
Message-ID: <9e7c20bd-8161-0790-36de-108c6dae65df@windriver.com>
References: <20200525093019.2253-1-qiang.zhang@windriver.com>
 <CAJhGHyC4XcNL8yzWZKZ=73wZJej4JwCaAHGV8qjYn-AqcEAEjQ@mail.gmail.com>
In-Reply-To: <CAJhGHyC4XcNL8yzWZKZ=73wZJej4JwCaAHGV8qjYn-AqcEAEjQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BYAPR11MB3253.namprd11.prod.outlook.com
 (15.20.3021.029)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d6a503f-0fb0-4cfb-53c1-08d8015c3a4e
x-ms-traffictypediagnostic: BYAPR11MB3352:
x-microsoft-antispam-prvs: <BYAPR11MB33524D23DDDF850E25529564FFB00@BYAPR11MB3352.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YOQUJzxWIgYRrHF2S4FCb/dtGiN1yy8CL828LzedXCQK14pLi0f72rlrd2OfZ9EvyoMCSR/GpS22eM7cHORtpES4OEc70vX+o/yVtLj0eTk7BpVAHMcV0u9GYFyJiXtEfshflEoWRXAmKDCeexj2I3mhsNjjsXNH4YwGKyoyEHzqjTQJDeEu89e9d5hlumBQOryYIidxdHbXuzMPn0NTVOIftxJpIAuWgk6jf+J+HGbLxh9GUdvYR0WpHYL6tjvb3GWy3nsYa0y1HDOl4qlLXu8jUVyELdYwgnCJUKM7Zgy2ONZt7YhRJM50uj0IJNZT0w+tV2wbG+kGYEf+fH6gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3253.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(376002)(346002)(39850400004)(31686004)(66446008)(66946007)(66476007)(54906003)(478600001)(316002)(76116006)(91956017)(64756008)(66556008)(6916009)(6512007)(4326008)(71200400001)(6506007)(186003)(86362001)(26005)(6486002)(2616005)(5660300002)(36756003)(53546011)(31696002)(8676002)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: U1qWs7vygKgQNyCAb8L5QkaaGmT8yTFr/mFcM6B2BF80rSz5GBvlcBKPdjkuvDf3pd1ULb7J+q10cARHEUn5IC5yO8PAOhG4E3N/lOXpf5SPRpHKZ/rVTz0Pl/1oq9vIpgJBAJc/GvWp826+DVrh/bVx+FU0v4xwxPiTx3n4kmRGFf4wtCeKr4j5iPEKHHysg3DBChw8sKTo0Zm7tr5PrLIh/4AY6lUgc9nn2/6idoqaZhqd7ULfXSFLQBn827FiIbUHIgpBwbjM0YnQDZM5+78LBE2jS3u9DKkX1yVn9OziBAP2k22axa62S6m0DwT+vNo784hW24XR03U71eh2C/K9KqlyG0jmfm7XqJkvW2q8CofHS9HUCJhZco9GupvGlxs1kQvvqJNvMZ2SpCyW65RoWtk2Qb1zCdN9gbuOR7Pi8/AJXvnqAaziTNCGI3qafhXY72CQ3BX/00/el+3/08wCQtsLNpEHoE5mqIWPxww=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <A3DF76B732693E41A7B1288ECD2D7688@windriver.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6a503f-0fb0-4cfb-53c1-08d8015c3a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 10:04:49.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2BUicVnPGqNaJpujCVqrtqiXWVlT9pA5kJzg2fH3SZu5MAUvqpsjE53Y7Q9JwMjgbBdNRWfYz0xXkp5e9o42FOPB2wko5gH6W7HU4m6Epk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IHJlcGx5ClRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZyB3aXRoIG15IGRlc2NyaXB0
aW9uLiAgaXMgaXQgZmVhc2libGUgdG8gZGVzY3JpYmUgYXMgZm9sbG93czoKClRoZSByZXN1Y2Vy
IGlzIGFscmVhZHkgZnJlZSBpbiAiZGVzdHJveV93b3JrcXVldWUiIGFuZAogICAgIndxLT5yZXNj
dWVyID0gTlVMTCIgd2FzIGV4ZWN1dGVkLCBidXQgaW4gInJjdV9mcmVlX3dxIgogICAgaXQncyBy
ZWxlYXNlIGFnYWluIChlcXVpdmFsZW50IHRvIGtmcmVlKE5VTEwpKSwgdGhpcyBpcwogICAgdW5u
ZWNlc3NhcnksIHNvIHNob3VsZCByZW1vdmUuCgoKT24gNS8yNi8yMCA0OjU2IFBNLCBMYWkgSmlh
bmdzaGFuIHdyb3RlOgo+IE9uIE1vbiwgTWF5IDI1LCAyMDIwIGF0IDU6MjIgUE0gPHFpYW5nLnpo
YW5nQHdpbmRyaXZlci5jb20+IHdyb3RlOgo+Pgo+PiBGcm9tOiBaaGFuZyBRaWFuZyA8cWlhbmcu
emhhbmdAd2luZHJpdmVyLmNvbT4KPj4KPj4gVGhlIGNhbGxiYWNrIGZ1bmN0aW9uICJyY3VfZnJl
ZV93cSIgY291bGQgYmUgY2FsbGVkIGFmdGVyIG1lbW9yeQo+PiB3YXMgcmVsZWFzZWQgZm9yICJy
ZXNjdWVyIiBhbHJlYWR5LCBUaHVzIGRlbGV0ZSBhIG1pc3BsYWNlZCBjYWxsCj4+IG9mIHRoZSBm
dW5jdGlvbiAia2ZyZWUiLgo+IAo+IEhlbGxvCj4gCj4gd3EtPnJlc2N1ZXIgaXMgZ3VhcmFudGVl
ZCB0byBiZSBOVUxMIGluIHJjdV9mcmVlX3dxKCkKPiBzaW5jZSBkZWY5OGM4NGI2Y2QKPiAoIndv
cmtxdWV1ZTogRml4IHNwdXJpb3VzIHNhbml0eSBjaGVjayBmYWlsdXJlcyBpbiBkZXN0cm95X3dv
cmtxdWV1ZSgpIikKPiAKPiBBbmQgdGhlIHJlc3VjZXIgaXMgYWxyZWFkeSBmcmVlIGluIGRlc3Ry
b3lfd29ya3F1ZXVlKCkKPiBzaW5jZSA4ZWZlMTIyM2Q3M2MKPiAoIndvcmtxdWV1ZTogRml4IG1p
c3Npbmcga2ZyZWUocmVzY3VlcikgaW4gZGVzdHJveV93b3JrcXVldWUoKSIpCj4gCj4gVGhlIHBh
dGNoIGlzIGEgY2xlYW51cCB0byByZW1vdmUgYSAia2ZyZWUoTlVMTCk7Ii4KPiBCdXQgdGhlIGNo
YW5nZWxvZyBpcyBtaXNsZWFkaW5nLgo+IAo+Pgo+PiBGaXhlczogNmJhOTQ0MjljOGU3ICgid29y
a3F1ZXVlOiBSZW9yZGVyIHN5c2ZzIGNvZGUiKQo+IAo+IEl0IGlzIHRvdGFsbHkgdW5yZWxhdGVk
Lgo+IAo+PiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBRaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVy
LmNvbT4KPj4gLS0tCj4+ICAgdjEtPnYyLT52MzoKPj4gICBPbmx5IGNvbW1pdCBpbmZvcm1hdGlv
biBtb2RpZmljYXRpb24uCj4+ICAga2VybmVsL3dvcmtxdWV1ZS5jIHwgMSAtCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC93b3JrcXVl
dWUuYyBiL2tlcm5lbC93b3JrcXVldWUuYwo+PiBpbmRleCA4OTFjY2FkNWYyNzEuLmEyNDUxY2Rj
ZDUwMyAxMDA2NDQKPj4gLS0tIGEva2VybmVsL3dvcmtxdWV1ZS5jCj4+ICsrKyBiL2tlcm5lbC93
b3JrcXVldWUuYwo+PiBAQCAtMzQ5MSw3ICszNDkxLDYgQEAgc3RhdGljIHZvaWQgcmN1X2ZyZWVf
d3Eoc3RydWN0IHJjdV9oZWFkICpyY3UpCj4+ICAgICAgICAgIGVsc2UKPj4gICAgICAgICAgICAg
ICAgICBmcmVlX3dvcmtxdWV1ZV9hdHRycyh3cS0+dW5ib3VuZF9hdHRycyk7Cj4+Cj4+IC0gICAg
ICAga2ZyZWUod3EtPnJlc2N1ZXIpOwo+PiAgICAgICAgICBrZnJlZSh3cSk7Cj4+ICAgfQo+Pgo+
PiAtLQo+PiAyLjI0LjEKPj4K
