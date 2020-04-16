Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B36C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D2722201
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Jlux2HqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgDPV2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:28:25 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53949 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDPV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:28:24 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6A0468066C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:28:16 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1587072496;
        bh=PbB4ou7PO5+THw+bx+oHN8/DciTud8oA+xxf15+y1SM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Jlux2HqCOLS4af3/I+mGcnLJElBGnoRDC+IMOouYEMCLp9S/C6DaTB7Z80N5MIAQU
         FZUBUruq+zI+OyvOJJzVoVugg5Nqud+Hqm+9NWZr3YgoP5+k/HqRrv9WX3LbTaXPSl
         vskrr4P/WHarB0lsD6qfRyQQv+0CtcpCGGswNU2hfK5DY88O5WenJX2fubHEj8GiIc
         2byyYnExTEqxwe0erWb+Y0D922rF1jWgeu0HLbpur6k6dtsjeaBLP6qzaxFEjaVZTg
         v5SjY4RsQsgd9v+u6KSHIJK2ZSaD+y1Jx+m5qfivRc+Um5XV5r7clXiKZ+ZYhouhtK
         PgpdqJAj+BT7A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e98cdef0001>; Fri, 17 Apr 2020 09:28:15 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Apr 2020 09:28:16 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Fri, 17 Apr 2020 09:28:16 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "oss@buserror.net" <oss@buserror.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Re: [PATCH v2] powerpc/setup_64: Set cache-line-size based on
 cache-block-size
Thread-Topic: [PATCH v2] powerpc/setup_64: Set cache-line-size based on
 cache-block-size
Thread-Index: AQHWAlQjUst7lNY0iUusXBl8ThU16Kh6g10AgAB3MQCAAKN/gA==
Date:   Thu, 16 Apr 2020 21:28:15 +0000
Message-ID: <4d84f89aa682dc78bc0d3a8df2f14b0452465da4.camel@alliedtelesis.co.nz>
References: <dd342c71e03e654a8786302d82f9662004418c6e.camel@alliedtelesis.co.nz>
         <20200325031854.7625-1-chris.packham@alliedtelesis.co.nz>
         <343c0e8b01ab74481e0b8dfbe588b1c84127a487.camel@alliedtelesis.co.nz>
         <87tv1jirlj.fsf@mpe.ellerman.id.au>
In-Reply-To: <87tv1jirlj.fsf@mpe.ellerman.id.au>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <75AAF93CAFA3014AA38E4311E77144F3@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTE2IGF0IDIxOjQzICsxMDAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiBDaHJpcyBQYWNraGFtIDxDaHJpcy5QYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdy
aXRlczoNCj4gPiBIaSBBbGwsDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIwLTAzLTI1IGF0IDE2OjE4
ICsxMzAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiA+ID4gSWYge2ksZH0tY2FjaGUtYmxvY2st
c2l6ZSBpcyBzZXQgYW5kIHtpLGR9LWNhY2hlLWxpbmUtc2l6ZSBpcw0KPiA+ID4gbm90LA0KPiA+
ID4gdXNlDQo+ID4gPiB0aGUgYmxvY2stc2l6ZSB2YWx1ZSBmb3IgYm90aC4gUGVyIHRoZSBkZXZp
Y2V0cmVlIHNwZWMgY2FjaGUtDQo+ID4gPiBsaW5lLQ0KPiA+ID4gc2l6ZQ0KPiA+ID4gaXMgb25s
eSBuZWVkZWQgaWYgaXQgZGlmZmVycyBmcm9tIHRoZSBibG9jayBzaXplLg0KPiA+ID4gDQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVz
aXMuY28ubno+DQo+ID4gPiAtLS0NCj4gPiA+IEl0IGxvb2tzIGFzIHRob3VnaCB0aGUgYnNpemVw
ID0gbHNpemVwIGlzIG5vdCByZXF1aXJlZCBwZXIgdGhlDQo+ID4gPiBzcGVjDQo+ID4gPiBidXQg
aXQncw0KPiA+ID4gcHJvYmFibHkgc2FmZXIgdG8gcmV0YWluIGl0Lg0KPiA+ID4gDQo+ID4gPiBD
aGFuZ2VzIGluIHYyOg0KPiA+ID4gLSBTY290dCBwb2ludGVkIG91dCB0aGF0IHUtYm9vdCBzaG91
bGQgYmUgZmlsbGluZyBpbiB0aGUgY2FjaGUNCj4gPiA+IHByb3BlcnRpZXMNCj4gPiA+ICAgKHdo
aWNoIGl0IGRvZXMpLiBCdXQgaXQgZG9lcyBub3Qgc3BlY2lmeSBhIGNhY2hlLWxpbmUtc2l6ZQ0K
PiA+ID4gYmVjYXVzZQ0KPiA+ID4gaXQNCj4gPiA+ICAgcHJvdmlkZXMgYSBjYWNoZS1ibG9jay1z
aXplIGFuZCB0aGUgc3BlYyBzYXlzIHlvdSBkb24ndCBoYXZlIHRvDQo+ID4gPiBpZg0KPiA+ID4g
dGhleSBhcmUNCj4gPiA+ICAgdGhlIHNhbWUuIFNvIHRoZSBlcnJvciBpcyBpbiB0aGUgcGFyc2lu
ZyBub3QgaW4gdGhlIGRldmljZXRyZWUNCj4gPiA+IGl0c2VsZi4NCj4gPiA+IA0KPiA+IA0KPiA+
IFBpbmc/IFRoaXMgdGhyZWFkIHdlbnQga2luZCBvZiBxdWlldC4NCj4gDQo+IEkgcmVwbGllZCBp
biB0aGUgb3RoZXIgdGhyZWFkOg0KPiANCj4gICANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXhwcGMtZGV2Lzg3MzY5eHg5OXUuZnNmQG1wZS5lbGxlcm1hbi5pZC5hdS8NCj4gDQo+IEJ1
dCB0aGVuIHRoZSBtZXJnZSB3aW5kb3cgaGFwcGVuZWQgd2hpY2ggaXMgYSBidXN5IHRpbWUuDQo+
IA0KDQpZZWFoIEkgZmlndXJlZCB0aGF0IHdhcyB0aGUgY2FzZS4NCg0KPiBXaGF0IEknZCByZWFs
bHkgbGlrZSBpcyBhIHYzIHRoYXQgaW5jb3Jwb3JhdGVzIHRoZSBpbmZvIEkgd3JvdGUgaW4NCj4g
dGhlDQo+IG90aGVyIHRocmVhZCBhbmQgYSBGaXhlcyB0YWcuDQo+IA0KPiBJZiB5b3UgZmVlbCBs
aWtlIGRvaW5nIHRoYXQsIHRoYXQgd291bGQgYmUgZ3JlYXQuIE90aGVyd2lzZSBJJ2xsIGRvDQo+
IGl0DQo+IHRvbW9ycm93Lg0KDQpJJ2xsIHJlYmFzZSBhZ2FpbnN0IExpbnVzJ3MgdHJlZSBhbmQg
aGF2ZSBhIGdvIGEgYWRkaW5nIHNvbWUgbW9yZSB3b3Jkcw0KdG8gdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KDQo+IA0KPiBjaGVlcnMNCg==
