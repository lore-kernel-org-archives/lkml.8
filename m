Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C08C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B439205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ApCG7qZz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CRyi1N3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHKHo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:44:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgHKHo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597131895; x=1628667895;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OUg8/shN9EQirft2OacXekUWRSBPGlVr2/tyhdACrbY=;
  b=ApCG7qZzhJTNO/MFK5xdehZ+iV+ohflvTHEdRnjbmhGRGaimUoPg6imR
   08RyFgat92uA10OqfMMMwHosfdU54SfY9yfMiEbcorfysiKW+zcrlz3CZ
   qUjXjspJJE69zHzru99MRu0BLv+N4v72FymY3V24hyuIOy0F93gLPdlo0
   5GIaYAAu8pELd/y7+S31YuLCkW3Olz1CZ/W4/mtbB8pW0kvOYJYqVk8Hr
   WqNMheaypQHSlVM1UCif8fQ5iA3KslU3J/Q8iBbO/mcgTngFtXQtvzvEp
   E9RJ4Q0MOQFLonKGP752VBlvj739cReZJL86uz4KhTdr5ZIW3/ttcYCNd
   Q==;
IronPort-SDR: r03BopJ8YCNisQFDEnGijxmALQT9+1IrIwEqWOxMBn0SLtYmc6rq6DUnu9Ft+cTvQMs6LFYm9G
 Nl8utlaI4iyhSRB7WyDvKACIbt7vxTAB83ZTk6K9BusfJfjzlzoXYMLGn69PlFcfRkcktghjmD
 1cv/3zsBVeqYz+tYpTBtqO593wPGK1RcTdnPOdRfKafnH1KHOZg6kCWO0Dc+brh3yhi+ORaKww
 DSBb/8FjQ595l93fy3DdeRsVkbXntNm4XwrqHdXNdU3TxtURNW/mXzapbCE99937XWzvmCcgsJ
 wa4=
X-IronPort-AV: E=Sophos;i="5.75,460,1589212800"; 
   d="scan'208";a="144696957"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 15:44:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7X2XpXjRYEumHAiHyAif0d7E+Spy8+hDHTOlKVuD80O2131PRwXglpkVFr4DU8bQmFX2wprTJSrFpWOOmBtQCPkdp2hknGTHnHfkpATm2Zh+7FTP8Il0+hDjAMogBITHcGR5RmHGm866POtxKRJgZa8+tN+dtPevP6pyGf+TI/ApUhQhqX8sfGvTNmtG8WQFk7F785ckAb2YA9zg7VwIF9Uhdi0u5zQ7us5cPDsnfYuKB1hv0AQQjfbD/bImRuj3XO+SzHDi2puc6jWITaUwdWHzbqHkgcutHoDnN14rDp4FOSWrlBwSKa4mGWzr8l1mmug+7aJvvBIAdSe7ZGQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUg8/shN9EQirft2OacXekUWRSBPGlVr2/tyhdACrbY=;
 b=IqTRexEo5YNWjsBO/b8KgGROCHWOd+Kw/ngj0PO6ZZ6A5k48tL444rBJ+W7JGr5u/fB+mZfisa+K49+Eyho8/epzJnAqcNXQqv4XiwTqO6pDnso/4G2UQnAq3DQRxw6JPJyerZ6tMNM657/QDbW6wlypOL+t/jQ3fud2GYgtHOfGN7vHz3AqChDioNqO+q3+bI395MZLi1+PT05YFpn2K2Asyv37D1IcQhNV6MxZUOmRiV6ceh2UmsdA7UBJuWYgDRRYDlQ946RNv0iuqlP+z64u0pF83dChXAlTc0XHyEluo7SThq8CpYI3HmRB5wBKJghcfme9TKRohuCSJqkPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUg8/shN9EQirft2OacXekUWRSBPGlVr2/tyhdACrbY=;
 b=CRyi1N3aSaYwlTASE4/gWR/CJ8Xw5Ug4zhFVRDSgjM4bNnt2RlohLknfhJifkMm1A5UZbXFP64sWYtyvWHWxnq05NQyae9jTUof1K8aAlHnMYy9aakXmEwD/WdVk1BXsx5ODWqvY7anJ0nnF0s/JjRRquZitz67XmI7rqcbItUg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0761.namprd04.prod.outlook.com (2603:10b6:903:e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 07:44:51 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3261.024; Tue, 11 Aug
 2020 07:44:51 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?gb2312?B?x/HOxLKp?= <qiuwenbo@phytium.com.cn>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Setup exception vector for K210 properly
Thread-Topic: [PATCH] riscv: Setup exception vector for K210 properly
Thread-Index: AQHWb7NLL+0eJv6tREy53XCvFXQq4w==
Date:   Tue, 11 Aug 2020 07:44:51 +0000
Message-ID: <CY4PR04MB3751474F3EC95CE50CC05AF9E7450@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
 <CY4PR04MB375124E6D2AD38BF1D71C1D5E7450@CY4PR04MB3751.namprd04.prod.outlook.com>
 <1ff8e8cb.a4c6.173dc56db41.Coremail.qiuwenbo@phytium.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: phytium.com.cn; dkim=none (message not signed)
 header.d=none;phytium.com.cn; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39de6ca9-394a-4f50-1f12-08d83dca6e14
x-ms-traffictypediagnostic: CY4PR04MB0761:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0761B2DE2E0B34A861C9026CE7450@CY4PR04MB0761.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VodBJgopdwS0i9CGr7Sjot6AV1KIsLOnUJTtom/M39ngHxG1HLB+6OjoC4lhjETj8nDY1xSIMFtzXuSRr23RQgZ3LBOBZIXCnB1YxhLK1Tg3yxoqdmnNTk4csBl0/oXd3t0B6O6ZujBP/bt5LfJ3lq7vx4MPgvXOjQjKx8B8v0H/0fWUQ4/5jNMfxQOQ4egWU/Dc1mG6V/DOp2urrWJn05Omt+gLj6d9MZAI/CwHNd5tcXrttK/BsRMbiG8p4QQWvULAdebmM79kdqeyk0QAyc5i6mdjAYttssi7jvPjRIwefNhpJ1ZDfITfdjhH1JkOOrpDZLjin4rmjtzIFeenRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(52536014)(8676002)(86362001)(6916009)(4326008)(83380400001)(5660300002)(9686003)(7416002)(55016002)(2906002)(8936002)(33656002)(71200400001)(66446008)(64756008)(53546011)(91956017)(316002)(26005)(66556008)(66476007)(186003)(66946007)(6506007)(54906003)(478600001)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dwFDs3z3T3m0AJA2lj/RgsxHSN+4rHUWAjYdJou5INDZuhzuz7xoJsshr554rPoiULrFcGT+UgvqS0NUvjZYMqe6nQcnC5Ub7ofMRCgKQ2mSHvql45/U7EZ9/gMJ5bAvFh8nivP2uugzVb3+I62fTklV4kSWdkYroGNOSE+/40IU9mGLnyKI9TRAyxdgRciwS90aCjD9mLD3ptrkVohDVg+MpSTfLHcvoKwTBscNbDJqwMzRAECJGctp+cj9o0yTaw6t9WPgfQn395SUUtSp/Wpv2ZLXVQ4k1C3oJG+54MwPgljfST1IkvFX1nroh0q/qljjAnlAz8VbykJ1udTlFHsnc3k6JOf30Nu/YC56N6PKHb9fx2yOJ5AGoP7ccoiQs97idTwQMt0Vq+WukbMJl5sOehTx5uw9Bw+2VgWAVGpocW5QyTIwftH1QVtFtsEoNpbZxV8VuVimxf3GaCBxiV2GM8+6iV9ijEqpRaUUh+1p+pckqgorOXXpSjWlvCDpt2hNynADw+9iBkyh4LM9w39BnddYS5tmRRUb0bG/JrDsm0rrKq4BXahnZKW4o2KgunGQYpsmKLE1wQgL5NadWo0Noz8x7ukNCQqaF5bD0HPPIzrCCZWGKpF7YKb88GPM7qSBGUdk3ZbnWrPRcz05GQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39de6ca9-394a-4f50-1f12-08d83dca6e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 07:44:51.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZXBF89E9Jef5A7z8kVzjv8YcteQrHNuCbe+wevneCluk2W9GOYa9w6HwzlEeI4T4f0eGXLFZz0kH5kE5UTvHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC8wOC8xMSAxNjowNiwgx/HOxLKpIHdyb3RlOgo+IFRoZSBzZXJpYWwgcG9ydCBkaWQg
bm90IHByaW50IGFueXRoaW5nIGFmdGVyIGVhcmx5IGNvbnNvbGUuIAo+IAo+IFsgICAgMC4wMDAw
MDBdIFNvcnRpbmcgX19leF90YWJsZS4uLgo+IFsgICAgMC4wMDAwMDBdIG1lbSBhdXRvLWluaXQ6
IHN0YWNrOm9mZiwgaGVhcCBhbGxvYzpvZmYsIGhlYXAgZnJlZTpvZmYKPiBbICAgIDAuMDAwMDAw
XSBNZW1vcnk6IDY0ODBLLzgxOTJLIGF2YWlsYWJsZSAoMTAyNEsga2VybmVsIGNvZGUsIDExMUsg
cndkYXRhLCAxNzBLIHJvZGF0YSwgMTAxSyBpbml0LCA5N0sgYnNzLCAxNzEySyByZXNlcnZlZCwg
MEsgY21hLXJlc2VydmVkKQo+IFsgICAgMC4wMDAwMDBdIHJjdTogSGllcmFyY2hpY2FsIFJDVSBp
bXBsZW1lbnRhdGlvbi4KPiBbICAgIDAuMDAwMDAwXSByY3U6IFJDVSBjYWxjdWxhdGVkIHZhbHVl
IG9mIHNjaGVkdWxlci1lbmxpc3RtZW50IGRlbGF5IGlzIDI1IGppZmZpZXMuCj4gWyAgICAwLjAw
MDAwMF0gTlJfSVJRUzogNjQsIG5yX2lycXM6IDY0LCBwcmVhbGxvY2F0ZWQgaXJxczogMAo+IFsg
ICAgMC4wMDAwMDBdIHJpc2N2LWludGM6IDY0IGxvY2FsIGludGVycnVwdHMgbWFwcGVkCj4gWyAg
ICAwLjAwMDAwMF0gcGxpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAYzAwMDAwMDogbWFwcGVkIDY1
IGludGVycnVwdHMgd2l0aCAyIGhhbmRsZXJzIGZvciA0IGNvbnRleHRzLgo+IFsgICAgMC4wMDAw
MDBdIHJhbmRvbTogZ2V0X3JhbmRvbV9ieXRlcyBjYWxsZWQgZnJvbSAweDAwMDAwMDAwODAwMDE5
YTQgd2l0aCBjcm5nX2luaXQ9MAo+IFsgICAgMC4wMDAwMDBdIHJpc2N2X3RpbWVyX2luaXRfZHQ6
IFJlZ2lzdGVyaW5nIGNsb2Nrc291cmNlIGNwdWlkIFswXSBoYXJ0aWQgWzBdCj4gWyAgICAwLjAw
MDAwMF0gY2xvY2tzb3VyY2U6IHJpc2N2X2Nsb2Nrc291cmNlOiBtYXNrOiAweGZmZmZmZmZmZmZm
ZmZmZmYgbWF4X2N5Y2xlczogMHgzOTkwYmU2OGIsIG1heF9pZGxlX25zOiA4ODE1OTA0MDQyNzIg
bnMKPiBbICAgIDAuMDAwMDE1XSBzY2hlZF9jbG9jazogNjQgYml0cyBhdCA3TUh6LCByZXNvbHV0
aW9uIDEyOG5zLCB3cmFwcyBldmVyeSA0Mzk4MDQ2NTExMDU0bnMKPiBbICAgIDAuMDA4MjU0XSBD
b25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1CgpJbnRlcmVzdGluZy4gTmV2ZXIgc2F3
IHRoYXQgaGFwcGVuaW5nLi4uIFRoYW5rcyAhCgo+IAo+IAo+IAo+ICZndDsgLS0tLS3Urcq808q8
/i0tLS0tCj4gJmd0OyC3orz+yMs6ICJEYW1pZW4gTGUgTW9hbCIgPGRhbWllbi5sZW1vYWxAd2Rj
LmNvbT4KPiAmZ3Q7ILeiy83KsbzkOiAyMDIwLTA4LTExIDE0OjQyOjE1ICjQx8batv4pCj4gJmd0
OyDK1bz+yMs6ICJRaXUgV2VuYm8iIDxxaXV3ZW5ib0BwaHl0aXVtLmNvbS5jbj4sICJQYWxtZXIg
RGFiYmVsdCIgPHBhbG1lckBkYWJiZWx0LmNvbT4sICJQYXVsIFdhbG1zbGV5IiA8cGF1bC53YWxt
c2xleUBzaWZpdmUuY29tPiwgImxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmciIDxsaW51
eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnPgo+ICZndDsgs63LzTogIkFsYmVydCBPdSIgPGFv
dUBlZWNzLmJlcmtlbGV5LmVkdT4sICJBdGlzaCBQYXRyYSIgPGF0aXNoLnBhdHJhQHdkYy5jb20+
LCAiQW51cAo+ICZndDsgIFBhdGVsIiA8YW51cEBicmFpbmZhdWx0Lm9yZz4sICJHdW8gUmVuIiA8
Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPiwgIlpvbmcgTGkiIDx6b25nLmxpQHNpZml2ZS5jb20+
LCAiR3JlZW50aW1lIEh1IiA8Z3JlZW50aW1lLmh1QHNpZml2ZS5jb20+LCAiVmluY2VudCBDaGVu
IiA8dmluY2VudC5jaGVuQHNpZml2ZS5jb20+LCAibGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZyIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Cj4gJmd0OyDW98ziOiBSZTogW1BBVENI
XSByaXNjdjogU2V0dXAgZXhjZXB0aW9uIHZlY3RvciBmb3IgSzIxMCBwcm9wZXJseQo+ICZndDsg
Cj4gJmd0OyBPbiAyMDIwLzA4LzExIDE1OjM4LCBRaXUgV2VuYm8gd3JvdGU6Cj4gJmd0OyAmZ3Q7
IEV4Y2VwdGlvbiB2ZWN0b3IgaXMgbWlzc2luZyBvbiBub21tdSBwbGF0Zm9ybSBhbmQgaXQgaXMg
YSBiaWcgaXNzdWUuCj4gJmd0OyAmZ3Q7IFRoaXMgcGF0Y2ggaXMgdGVzdGVkIGluIFNpcGVlZCBN
QUlYIEJpdCBEZXYgQm9hcmQuCj4gJmd0OyAmZ3Q7IAo+ICZndDsgJmd0OyBGaXhlczogNzliMWZl
YmE1NDU1ICgiUklTQy1WOiBTZXR1cCBleGNlcHRpb24gdmVjdG9yIGVhcmx5IikKPiAmZ3Q7ICZn
dDsgU2lnbmVkLW9mZi1ieTogUWl1IFdlbmJvIDxxaXV3ZW5ib0BwaHl0aXVtLmNvbS5jbj4KPiAm
Z3Q7ICZndDsgLS0tCj4gJmd0OyAmZ3Q7ICBhcmNoL3Jpc2N2L2tlcm5lbC9zbXBib290LmMgfCAg
MSArCj4gJmd0OyAmZ3Q7ICBhcmNoL3Jpc2N2L2tlcm5lbC90cmFwcy5jICAgfCAxMSArKysrKysr
KysrLQo+ICZndDsgJmd0OyAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4gJmd0OyAmZ3Q7IAo+ICZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNj
di9rZXJuZWwvc21wYm9vdC5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jCj4gJmd0OyAm
Z3Q7IGluZGV4IDM1NjgyNWE1NzU1MS4uMjNjZGUwY2ViMzlkIDEwMDY0NAo+ICZndDsgJmd0OyAt
LS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9zbXBib290LmMKPiAmZ3Q7ICZndDsgKysrIGIvYXJjaC9y
aXNjdi9rZXJuZWwvc21wYm9vdC5jCj4gJmd0OyAmZ3Q7IEBAIC0xNTQsNiArMTU0LDcgQEAgYXNt
bGlua2FnZSBfX3Zpc2libGUgdm9pZCBzbXBfY2FsbGluKHZvaWQpCj4gJmd0OyAmZ3Q7ICAJbW1n
cmFiKG1tKTsKPiAmZ3Q7ICZndDsgIAljdXJyZW50LSZndDthY3RpdmVfbW0gPSBtbTsKPiAmZ3Q7
ICZndDsgIAo+ICZndDsgJmd0OyArCXRyYXBfaW5pdCgpOwo+ICZndDsgJmd0OyAgCW5vdGlmeV9j
cHVfc3RhcnRpbmcoY3Vycl9jcHVpZCk7Cj4gJmd0OyAmZ3Q7ICAJdXBkYXRlX3NpYmxpbmdzX21h
c2tzKGN1cnJfY3B1aWQpOwo+ICZndDsgJmd0OyAgCXNldF9jcHVfb25saW5lKGN1cnJfY3B1aWQs
IDEpOwo+ICZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMuYyBi
L2FyY2gvcmlzY3Yva2VybmVsL3RyYXBzLmMKPiAmZ3Q7ICZndDsgaW5kZXggYWQxNGY0NDY2ZDky
Li5hMzkwMjM5ODE4YWUgMTAwNjQ0Cj4gJmd0OyAmZ3Q7IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVs
L3RyYXBzLmMKPiAmZ3Q7ICZndDsgKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMuYwo+ICZn
dDsgJmd0OyBAQCAtMTc0LDcgKzE3NCwxNiBAQCBpbnQgaXNfdmFsaWRfYnVnYWRkcih1bnNpZ25l
ZCBsb25nIHBjKQo+ICZndDsgJmd0OyAgfQo+ICZndDsgJmd0OyAgI2VuZGlmIC8qIENPTkZJR19H
RU5FUklDX0JVRyAqLwo+ICZndDsgJmd0OyAgCj4gJmd0OyAmZ3Q7IC0vKiBzdHZlYyAmYW1wOyBz
Y3JhdGNoIGlzIGFscmVhZHkgc2V0IGZyb20gaGVhZC5TICovCj4gJmd0OyAmZ3Q7ICsvKiBzdHZl
YyAmYW1wOyBzY3JhdGNoIGlzIGFscmVhZHkgc2V0IGZyb20gaGVhZC5TIHdoZW4gbW11IGlzIGVu
YWJsZWQgKi8KPiAmZ3Q7ICZndDsgIHZvaWQgdHJhcF9pbml0KHZvaWQpCj4gJmd0OyAmZ3Q7ICB7
Cj4gJmd0OyAmZ3Q7ICsjaWZuZGVmIENPTkZJR19NTVUKPiAmZ3Q7ICZndDsgKwkvKgo+ICZndDsg
Jmd0OyArCSAqIFNldCBzdXAwIHNjcmF0Y2ggcmVnaXN0ZXIgdG8gMCwgaW5kaWNhdGluZyB0byBl
eGNlcHRpb24gdmVjdG9yCj4gJmd0OyAmZ3Q7ICsJICogdGhhdCB3ZSBhcmUgcHJlc2VudGx5IGV4
ZWN1dGluZyBpbiB0aGUga2VybmVsCj4gJmd0OyAmZ3Q7ICsJICovCj4gJmd0OyAmZ3Q7ICsJY3Ny
X3dyaXRlKENTUl9TQ1JBVENILCAwKTsKPiAmZ3Q7ICZndDsgKwkvKiBTZXQgdGhlIGV4Y2VwdGlv
biB2ZWN0b3IgYWRkcmVzcyAqLwo+ICZndDsgJmd0OyArCWNzcl93cml0ZShDU1JfVFZFQywgJmFt
cDtoYW5kbGVfZXhjZXB0aW9uKTsKPiAmZ3Q7ICZndDsgKyNlbmRpZgo+ICZndDsgJmd0OyAgfQo+
ICZndDsgJmd0OyAKPiAmZ3Q7IAo+ICZndDsgTG9va3MgT0sgdG8gbWUuIEJ1dCBvdXQgb2YgY3Vy
aW9zaXR5LCBob3cgZGlkIHlvdSB0cmlnZ2VyIGEgcHJvYmxlbSA/IEkgbmV2ZXIKPiAmZ3Q7IGdv
dCBhbnkgd2VpcmQgZXhjZXB0aW9ucyB3aXRoIG15IGJ1c3lib3ggdXNlcnNwYWNlLgo+ICZndDsg
Cj4gJmd0OyAtLSAKPiAmZ3Q7IERhbWllbiBMZSBNb2FsCj4gJmd0OyBXZXN0ZXJuIERpZ2l0YWwg
UmVzZWFyY2gKPiA8L3FpdXdlbmJvQHBoeXRpdW0uY29tLmNuPjwvbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz48L3ZpbmNlbnQuY2hlbkBzaWZpdmUuY29tPjwvZ3JlZW50aW1lLmh1QHNpZml2
ZS5jb20+PC96b25nLmxpQHNpZml2ZS5jb20+PC9ndW9yZW5AbGludXguYWxpYmFiYS5jb20+PC9h
bnVwQGJyYWluZmF1bHQub3JnPjwvYXRpc2gucGF0cmFAd2RjLmNvbT48L2FvdUBlZWNzLmJlcmtl
bGV5LmVkdT48L2xpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc+PC9wYXVsLndhbG1zbGV5
QHNpZml2ZS5jb20+PC9wYWxtZXJAZGFiYmVsdC5jb20+PC9xaXV3ZW5ib0BwaHl0aXVtLmNvbS5j
bj48L2RhbWllbi5sZW1vYWxAd2RjLmNvbT4KPiAKPiAKPiAKPiAKPiAKCgotLSAKRGFtaWVuIExl
IE1vYWwKV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoCg==
