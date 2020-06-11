Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A9FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1906720720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="pBN66u9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgFKVOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:14:44 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47740 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgFKVOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:14:43 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C4970806AC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:14:39 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1591910079;
        bh=gnWZOIGjj8uxjcxUa9qLsZsnfaNKGQItVqVlx322Hlw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=pBN66u9ZEJJr0Kes6F7JMsCQdMA5uU0dLv8pSJmbakizxssJzSYuBomcct8CSdCnt
         2CVuUL5QFx/q0lsdsM/9p7e287POfLVvolrPyvPjzoj/q+rtNoenqS7/4P32y1XgDK
         LP4MRa387qeIZiqkdUew6iO4qpUoa3SzMkv+BcU7lQIOel9iLHoqQwguG5vILjzjfC
         NXasZBtc272cXBKF02y2JdtVhA4ffXc6bfWpHYfVlioUYCrel+HGW/Ld/bKm+5ENws
         OIms4SD+B7PiOhpEBmZ52m3jSaJ+4U6m2sEn8HA0vmtXn4JidbG1Noga0NcMdXOUZ3
         Q5dwfXPGPfzgA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee29ec00001>; Fri, 12 Jun 2020 09:14:40 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Jun 2020 09:14:39 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Fri, 12 Jun 2020 09:14:39 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc: Remove inaccessible CMDLINE default
Thread-Topic: [PATCH v2] powerpc: Remove inaccessible CMDLINE default
Thread-Index: AQHWP6I/tXmW8ZPpE0iYl1XQldsjyajSHuIAgAEDTwA=
Date:   Thu, 11 Jun 2020 21:14:38 +0000
Message-ID: <ab4db077-ae04-ada3-5bb0-79bfb0c94137@alliedtelesis.co.nz>
References: <20200611034140.9133-1-chris.packham@alliedtelesis.co.nz>
 <34bb20ad-8522-6071-7a36-9f615204561f@csgroup.eu>
In-Reply-To: <34bb20ad-8522-6071-7a36-9f615204561f@csgroup.eu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF0974C74629824FB29421077D9A1B0F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8wNi8yMCA1OjQ2IHBtLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPg0KPg0KPiBM
ZSAxMS8wNi8yMDIwIMOgIDA1OjQxLCBDaHJpcyBQYWNraGFtIGEgw6ljcml0wqA6DQo+PiBTaW5j
ZSBjb21taXQgY2JlNDZiZDRmNTEwICgicG93ZXJwYzogcmVtb3ZlIENPTkZJR19DTURMSU5FICNp
ZmRlZiBtZXNzIikNCj4+IENPTkZJR19DTURMSU5FIGhhcyBhbHdheXMgaGFkIGEgdmFsdWUgcmVn
YXJkbGVzcyBvZiBDT05GSUdfQ01ETElORV9CT09MLg0KPj4NCj4+IEZvciBleGFtcGxlOg0KPj4N
Cj4+IMKgICQgbWFrZSBBUkNIPXBvd2VycGMgZGVmY29uZmlnDQo+PiDCoCAkIGNhdCAuY29uZmln
DQo+PiDCoCAjIENPTkZJR19DTURMSU5FX0JPT0wgaXMgbm90IHNldA0KPj4gwqAgQ09ORklHX0NN
RExJTkU9IiINCj4+DQo+PiBXaGVuIGVuYWJsaW5nIENPTkZJR19DTURMSU5FX0JPT0wgdGhpcyB2
YWx1ZSBpcyBrZXB0IG1ha2luZyB0aGUgJ2RlZmF1bHQNCj4+ICIuLi4iIGlmIENPTkZJR19DTURM
SU5FX0JPT0wnIGluZWZmZWN0aXZlLg0KPj4NCj4+IMKgICQgLi9zY3JpcHRzL2NvbmZpZyAtLWVu
YWJsZSBDT05GSUdfQ01ETElORV9CT09MDQo+PiDCoCAkIGNhdCAuY29uZmlnDQo+PiDCoCBDT05G
SUdfQ01ETElORV9CT09MPXkNCj4+IMKgIENPTkZJR19DTURMSU5FPSIiDQo+Pg0KPj4gUmVtb3Zl
IENPTkZJR19DTURMSU5FX0JPT0wgYW5kIHRoZSBpbmFjY2Vzc2libGUgZGVmYXVsdC4NCj4NCj4g
WW91IGFsc28gaGF2ZSB0byByZW1vdmUgYWxsIENPTkZJR19DTURMSU5FX0JPT0wgZnJvbSB0aGUg
ZGVmY29uZmlncw0KDQpPSy4gSSdsbCBkbyBzbyBhcyBhIGZvbGxvdy11cCBwYXRjaCBhbmQgc2Vu
ZCBhIHYzLg0KDQo+DQo+IENocmlzdG9waGUNCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiBSZXZpZXdl
ZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjLXMuZnI+DQo+PiAtLS0N
Cj4+IEl0IHRvb2sgbWUgYSB3aGlsZSB0byBnZXQgcm91bmQgdG8gc2VuZGluZyBhIHYyLCBmb3Ig
YSByZWZyZXNoZXIgdjEgDQo+PiBjYW4gYmUgZm91bmQgaGVyZToNCj4+DQo+PiBodHRwOi8vcGF0
Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eHBwYy1kZXYvcGF0Y2gvMjAxOTA4MDIwNTAy
MzIuMjI5NzgtMS1jaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubnovIA0KPj4NCj4+DQo+
PiBDaGFuZ2VzIGluIHYyOg0KPj4gLSBSZWJhc2Ugb24gdG9wIG9mIExpbnVzJ3MgdHJlZQ0KPj4g
LSBGaXggc29tZSB0eXBvcyBpbiBjb21taXQgbWVzc2FnZQ0KPj4gLSBBZGQgcmV2aWV3IGZyb20g
Q2hyaXN0b3BoZQ0KPj4gLSBSZW1vdmUgQ09ORklHX0NNRExJTkVfQk9PTA0KPj4NCj4+IMKgIGFy
Y2gvcG93ZXJwYy9LY29uZmlnIHwgNiArLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dl
cnBjL0tjb25maWcgYi9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KPj4gaW5kZXggOWZhMjNlYjMyMGZm
Li41MWFiYzU5YzMzMzQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KPj4g
KysrIGIvYXJjaC9wb3dlcnBjL0tjb25maWcNCj4+IEBAIC04NTksMTIgKzg1OSw4IEBAIGNvbmZp
ZyBQUENfREVOT1JNQUxJU0FUSU9ODQo+PiDCoMKgwqDCoMKgwqDCoCBBZGQgc3VwcG9ydCBmb3Ig
aGFuZGxpbmcgZGVub3JtYWxpc2F0aW9uIG9mIHNpbmdsZSBwcmVjaXNpb24NCj4+IMKgwqDCoMKg
wqDCoMKgIHZhbHVlcy7CoCBVc2VmdWwgZm9yIGJhcmUgbWV0YWwgb25seS7CoCBJZiB1bnN1cmUg
c2F5IFkgaGVyZS4NCj4+IMKgIC1jb25maWcgQ01ETElORV9CT09MDQo+PiAtwqDCoMKgIGJvb2wg
IkRlZmF1bHQgYm9vdGxvYWRlciBrZXJuZWwgYXJndW1lbnRzIg0KPj4gLQ0KPj4gwqAgY29uZmln
IENNRExJTkUNCj4+IC3CoMKgwqAgc3RyaW5nICJJbml0aWFsIGtlcm5lbCBjb21tYW5kIHN0cmlu
ZyIgaWYgQ01ETElORV9CT09MDQo+PiAtwqDCoMKgIGRlZmF1bHQgImNvbnNvbGU9dHR5UzAsOTYw
MCBjb25zb2xlPXR0eTAgcm9vdD0vZGV2L3NkYTIiIGlmIA0KPj4gQ01ETElORV9CT09MDQo+PiAr
wqDCoMKgIHN0cmluZyAiSW5pdGlhbCBrZXJuZWwgY29tbWFuZCBzdHJpbmciDQo+PiDCoMKgwqDC
oMKgIGRlZmF1bHQgIiINCj4+IMKgwqDCoMKgwqAgaGVscA0KPj4gwqDCoMKgwqDCoMKgwqAgT24g
c29tZSBwbGF0Zm9ybXMsIHRoZXJlIGlzIGN1cnJlbnRseSBubyB3YXkgZm9yIHRoZSBib290IA0K
Pj4gbG9hZGVyIHRvDQo+Pg==
