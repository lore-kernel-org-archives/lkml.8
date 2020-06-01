Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A071C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E51206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nod9XDeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgFAAKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 20:10:13 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:51316 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFAAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590970211; x=1622506211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WT0YoCcfE32mIIPxokLP/7KFZVrjOLNhWjf5wQdoHj4=;
  b=nod9XDeCg9g+w6bvkv2VzO9bgc7SHUrwXdI7zLOdSsZ0M7mlUxzMPjc4
   R9oJ2p+2I1I76Oec4j5LKa7SVpfzxHfNgVdIGhWAANYBBTY5CehiDZwsp
   BVqAbc7BZfE6R+O+gfV+7izdL1ySAe2Obhi+u3WwRp1NLHInhvwtOeO9+
   g=;
IronPort-SDR: 6xE1IQ/C5alJFpeuNhq4vm6v8jkguiY836fO6ZZfd00tUdbOVXVPrniqdkVXdHMAAT3vCwW3mK
 GTflfeHp80Hg==
X-IronPort-AV: E=Sophos;i="5.73,458,1583193600"; 
   d="scan'208";a="48473352"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 Jun 2020 00:10:09 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id D8ECFA1CFD;
        Mon,  1 Jun 2020 00:10:07 +0000 (UTC)
Received: from EX13D21UWB004.ant.amazon.com (10.43.161.221) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 1 Jun 2020 00:10:07 +0000
Received: from EX13D02UWB004.ant.amazon.com (10.43.161.11) by
 EX13D21UWB004.ant.amazon.com (10.43.161.221) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 1 Jun 2020 00:10:06 +0000
Received: from EX13D02UWB004.ant.amazon.com ([10.43.161.11]) by
 EX13D02UWB004.ant.amazon.com ([10.43.161.11]) with mapi id 15.00.1497.006;
 Mon, 1 Jun 2020 00:10:06 +0000
From:   "Saidi, Ali" <alisaidi@amazon.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Topic: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Index: AQHWN6kBcVxdzvL9G0WxbBRVg/ndQQ==
Date:   Mon, 1 Jun 2020 00:10:06 +0000
Message-ID: <CBF3C648-84C9-4034-A5A0-EC110A9124E4@amazon.com>
References: <eed907d48de84c96e3ceb27c1ed6f622@kernel.org>
In-Reply-To: <eed907d48de84c96e3ceb27c1ed6f622@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <58825ED36B0DF14A85B2A70BDB3FC3E4@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFyYywgDQoNCj4gT24gTWF5IDMxLCAyMDIwLCBhdCA2OjEwIEFNLCBNYXJjIFp5bmdpZXIgPG1h
ekBrZXJuZWwub3JnPiB3cm90ZToNCj4+IE5vdCBncmVhdCBpbmRlZWQuIEJ1dCB0aGlzIGlzIG5v
dCwgYXMgZmFyIGFzIEkgY2FuIHRlbGwsIGEgR0lDDQo+PiBkcml2ZXIgcHJvYmxlbS4NCj4+IA0K
Pj4gVGhlIHNlbWFudGljIG9mIGFjdGl2YXRlL2RlYWN0aXZhdGUgKHdoaWNoIG1hcHMgdG8gc3Rh
cnRlZC9zaHV0ZG93bg0KPj4gaW4gdGhlIElSUSBjb2RlKSBpcyB0aGF0IHRoZSBIVyByZXNvdXJj
ZXMgZm9yIGEgZ2l2ZW4gaW50ZXJydXB0IGFyZQ0KPj4gb25seSBjb21taXR0ZWQgd2hlbiB0aGUg
aW50ZXJydXB0IGlzIGFjdGl2YXRlZC4gVHJ5aW5nIHRvIHBlcmZvcm0NCj4+IGFjdGlvbnMgaW52
b2x2aW5nIHRoZSBIVyBvbiBhbiBpbnRlcnJ1cHQgdGhhdCBpc24ndCBhY3RpdmUgY2Fubm90IGJl
DQo+PiBndWFyYW50ZWVkIHRvIHRha2UgZWZmZWN0Lg0KDQpZZXMsIHRoZW4gaXQgYWJzb2x1dGVs
eSBtYWtlcyBzZW5zZSB0byBhZGRyZXNzIGl0IG91dHNpZGUgdGhlIEdJQy4gDQo+PiANCj4+IEkn
ZCByYXRoZXIgYWRkcmVzcyBpdCBpbiB0aGUgY29yZSBjb2RlLCBieSBwcmV2ZW50aW5nIHNldF9h
ZmZpbml0eSAoYW5kDQo+PiBwb3RlbnRpYWxseSBvdGhlcnMpIHRvIHRha2UgcGxhY2Ugd2hlbiB0
aGUgaW50ZXJydXB0IGlzIG5vdCBpbiB0aGUNCj4+IFNUQVJURUQgc3RhdGUuIFVzZXJzcGFjZSB3
b3VsZCBnZXQgYW4gZXJyb3IsIHdoaWNoIGlzIHBlcmZlY3RseQ0KPj4gbGVnaXRpbWF0ZSwgYW5k
IHdoaWNoIGl0IGFscmVhZHkgaGFzIHRvIGRlYWwgd2l0aCBpdCBmb3IgcGxlbnR5IG9mDQo+PiBv
dGhlcg0KPj4gcmVhc29ucy4NCj4gDQo+IEhvdyBhYm91dCB0aGlzOg0KPiANCj4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9pcnEvbWFuYWdlLmMgYi9rZXJuZWwvaXJxL21hbmFnZS5jDQo+IGluZGV4IDQ1
M2E4YTBmNDgwNC4uMWEyYWMxMzkyYzBmIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvaXJxL21hbmFn
ZS5jDQo+ICsrKyBiL2tlcm5lbC9pcnEvbWFuYWdlLmMNCj4gQEAgLTE0Nyw3ICsxNDcsOCBAQCBj
cHVtYXNrX3Zhcl90IGlycV9kZWZhdWx0X2FmZmluaXR5Ow0KPiBzdGF0aWMgYm9vbCBfX2lycV9j
YW5fc2V0X2FmZmluaXR5KHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gew0KPiAgICAgICBpZiAo
IWRlc2MgfHwgIWlycWRfY2FuX2JhbGFuY2UoJmRlc2MtPmlycV9kYXRhKSB8fA0KPiAtICAgICAg
ICAgICAhZGVzYy0+aXJxX2RhdGEuY2hpcCB8fCAhZGVzYy0+aXJxX2RhdGEuY2hpcC0+aXJxX3Nl
dF9hZmZpbml0eSkNCj4gKyAgICAgICAgICAgIWRlc2MtPmlycV9kYXRhLmNoaXAgfHwgIWRlc2Mt
PmlycV9kYXRhLmNoaXAtPmlycV9zZXRfYWZmaW5pdHkgfHwNCj4gKyAgICAgICAgICAgIWlycWRf
aXNfc3RhcnRlZCgmZGVzYy0+aXJxX2RhdGEpKQ0KPiAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gICAgICAgcmV0dXJuIHRydWU7DQo+IH0NCg0KQ29uZmlybWVkIEkgY2Fu4oCZdCByZXBy
b2R1Y2UgdGhlIGlzc3VlIHdpdGggeW91ciBmaXguIA0KDQpUaGFua3MsDQpBbGkNCg0K
