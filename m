Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E310C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE582065D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PJ51StK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGQPZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:25:12 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:35170 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgGQPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594999511; x=1626535511;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=G75k//OFjohU38ZgosvGO5q8OosY9IuKew7WVhx6Up0=;
  b=PJ51StK5n5n5riZrPRdrzzapaPbfapbNVDZziuPhAB16s83gqH/3Njk3
   lHCRLd5AYa4SY3mnzVN3tJ1gVRakT+gJl7yM0PbFAXYlMxqpuvKcrfR/i
   BPCIaXV9Nq8o1T9wdvgE7m1OJo7HA/wa/CuM+dIPzReCzBc7YShM+MjyN
   E=;
IronPort-SDR: e1//RxWVXOsjAC65SEGU+2scnm0JZMIo9PmeGqu5BZ40eJge8dvUXtQP4wXhIddTnkvYQT8Csp
 G3oOG+K11Mog==
X-IronPort-AV: E=Sophos;i="5.75,362,1589241600"; 
   d="scan'208";a="52415837"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Jul 2020 15:25:09 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 32E86A261C;
        Fri, 17 Jul 2020 15:25:07 +0000 (UTC)
Received: from EX13D21UWB002.ant.amazon.com (10.43.161.177) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 15:25:06 +0000
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13D21UWB002.ant.amazon.com (10.43.161.177) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 15:25:06 +0000
Received: from EX13D02UWC001.ant.amazon.com ([10.43.162.243]) by
 EX13D02UWC001.ant.amazon.com ([10.43.162.243]) with mapi id 15.00.1497.006;
 Fri, 17 Jul 2020 15:25:06 +0000
From:   "Saidi, Ali" <alisaidi@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        Ali Saidi <aliaidi@amazon.com>, Marc Zyngier <maz@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] genirq/affinity: Handle affinity setting on inactive
 interrupts correctly
Thread-Topic: [PATCH] genirq/affinity: Handle affinity setting on inactive
 interrupts correctly
Thread-Index: AQHWXE5yOF+Kj67jZUWJl7gBhLLD9A==
Date:   Fri, 17 Jul 2020 15:25:05 +0000
Message-ID: <BBA90891-8A4A-4A39-BF51-13EECDE414F1@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.34]
Content-Type: text/plain; charset="utf-8"
Content-ID: <84714F54C0845F43865AFD07549EBBE3@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQrvu79PbiA3LzE3LzIwLCA5OjAwIEFNLCAiVGhvbWFzIEdsZWl4bmVyIiA8dGdseEBsaW51dHJv
bml4LmRlPiB3cm90ZToNCg0KICAgIFNldHRpbmcgaW50ZXJydXB0IGFmZmluaXR5IG9uIGluYWN0
aXZlIGludGVycnVwdHMgaXMgaW5jb25zaXN0ZW50IHdoZW4NCiAgICBoaWVyYXJjaGljYWwgaXJx
IGRvbWFpbnMgYXJlIGVuYWJsZWQuIFRoZSBjb3JlIGNvZGUgc2hvdWxkIGp1c3Qgc3RvcmUgdGhl
DQogICAgYWZmaW5pdHkgYW5kIG5vdCBjYWxsIGludG8gdGhlIGlycSBjaGlwIGRyaXZlciBmb3Ig
aW5hY3RpdmUgaW50ZXJydXB0cw0KICAgIGJlY2F1c2UgdGhlIGNoaXAgZHJpdmVycyBtYXkgbm90
IGJlIGluIGEgc3RhdGUgdG8gaGFuZGxlIHN1Y2ggcmVxdWVzdHMuDQoNCiAgICBYODYgaGFzIGEg
aGFja3kgd29ya2Fyb3VuZCBmb3IgdGhhdCBidXQgYWxsIG90aGVyIGlycSBjaGlwcyBoYXZlIG5v
dCB3aGljaA0KICAgIGNhdXNlcyBwcm9ibGVtcyBlLmcuIG9uIEdJQyBWMyBJVFMuDQoNCiAgICBJ
bnN0ZWFkIG9mIGFkZGluZyBtb3JlIHVnbHkgaGFja3MgYWxsIG92ZXIgdGhlIHBsYWNlLCBzb2x2
ZSB0aGUgcHJvYmxlbSBpbg0KICAgIHRoZSBjb3JlIGNvZGUuIElmIHRoZSBhZmZpbml0eSBpcyBz
ZXQgb24gYW4gaW5hY3RpdmUgaW50ZXJydXB0IHRoZW46DQoNCiAgICAgICAgLSBTdG9yZSBpdCBp
biB0aGUgaXJxIGRlc2NyaXB0b3JzIGFmZmluaXR5IG1hc2sNCiAgICAgICAgLSBVcGRhdGUgdGhl
IGVmZmVjdGl2ZSBhZmZpbml0eSB0byByZWZsZWN0IHRoYXQgc28gdXNlciBzcGFjZSBoYXMNCiAg
ICAgICAgICBhIGNvbnNpc3RlbnQgdmlldw0KICAgICAgICAtIERvbid0IGNhbGwgaW50byB0aGUg
aXJxIGNoaXAgZHJpdmVyDQoNCiAgICBUaGlzIGlzIHRoZSBjb3JlIGVxdWl2YWxlbnQgb2YgdGhl
IFg4NiB3b3JrYXJvdW5kIGFuZCB3b3JrcyBjb3JyZWN0bHkNCiAgICBiZWNhdXNlIHRoZSBhZmZp
bml0eSBzZXR0aW5nIGlzIGVzdGFibGlzaGVkIGluIHRoZSBpcnEgY2hpcCB3aGVuIHRoZQ0KICAg
IGludGVycnVwdCBpcyBhY3RpdmF0ZWQgbGF0ZXIgb24uDQoNCiAgICBOb3RlLCB0aGF0IHRoaXMg
aXMgb25seSBlZmZlY3RpdmUgd2hlbiBoaWVyYXJjaGljYWwgaXJxIGRvbWFpbnMgYXJlIGVuYWJs
ZWQNCiAgICBieSB0aGUgYXJjaGl0ZWN0dXJlLiBEb2luZyBpdCB1bmNvbmRpdGlvbmFsbHkgd291
bGQgYnJlYWsgbGVnYWN5IGlycSBjaGlwDQogICAgaW1wbGVtZW50YXRpb25zLg0KDQogICAgRm9y
IGhpZXJhcmNoaWFsIGlycSBkb21haW5zIHRoaXMgd29ya3MgY29ycmVjdGx5IGFzIG5vbmUgb2Yg
dGhlIGRyaXZlcnMgY2FuDQogICAgaGF2ZSBhIGRlcGVuZGVuY3kgb24gYWZmaW5pdHkgc2V0dGlu
ZyBpbiBpbmFjdGl2ZSBzdGF0ZSBieSBkZXNpZ24uDQoNCiAgICBSZW1vdmUgdGhlIFg4NiB3b3Jr
YXJvdW5kIGFzIGl0IGlzIG5vdCBsb25nZXIgcmVxdWlyZWQuDQoNCiAgICBGaXhlczogMDJlZGVl
MTUyZDZlICgieDg2L2FwaWMvdmVjdG9yOiBJZ25vcmUgc2V0X2FmZmluaXR5IGNhbGwgZm9yIGlu
YWN0aXZlIGludGVycnVwdHMiKQ0KICAgIFJlcG9ydGVkLWJ5OiBBbGkgU2FpZGkgPGFsaXNhaWRp
QGFtYXpvbi5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+DQogICAgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCiAgICBMaW5rOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAwNTI5MDE1NTAxLjE1NzcxLTEtYWxpc2FpZGlA
YW1hem9uLmNvbQ0KICAgIC0tLQ0KICAgIA0KDQpUZXN0ZWQgb24gYW4gYXJtNjQgc3lzdGVtIHRo
YXQgb3JpZ2luYWxseSBleHBlcmllbmNlZCB0aGUgaXNzdWUgYW5kIGNvdWxkbid0IHJlcHJvZHVj
ZSBpdCB3aXRoIHRoaXMgcGF0Y2guDQpUZXN0ZWQtYnk6IEFsaSBTYWlkaSA8YWxpc2FpZGlAYW1h
em9uLmNvbT4NCg0KVGhhbmtzLA0KQWxpDQoNCg0K
