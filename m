Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CCCC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30295206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBSLSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:18:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23254 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgBSLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:18:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-237-G-f7kF86NV-7-N2Q1N07Ew-1; Wed, 19 Feb 2020 11:18:28 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 19 Feb 2020 11:18:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 19 Feb 2020 11:18:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'chris hyser' <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dhaval.giani@oracle.com" <dhaval.giani@oracle.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "qperret@qperret.net" <qperret@qperret.net>,
        "pjt@google.com" <pjt@google.com>, "tj@kernel.org" <tj@kernel.org>
Subject: RE: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
Thread-Topic: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
Thread-Index: AQHV5q881FBlSjXcbk+qN0I8G32+xqgiV6OQ
Date:   Wed, 19 Feb 2020 11:18:27 +0000
Message-ID: <3ce2e8940fb14d95b011c8b30892aa62@AcuMS.aculab.com>
References: <20200116120230.16759-1-parth@linux.ibm.com>
 <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
In-Reply-To: <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: G-f7kF86NV-7-N2Q1N07Ew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogY2hyaXMgaHlzZXINCj4gU2VudDogMTggRmVicnVhcnkgMjAyMCAyMzowMA0KLi4uDQo+
IEFsbCwgSSB3YXMgYXNrZWQgdG8gdGFrZSBhIGxvb2sgYXQgdGhlIG9yaWdpbmFsIGxhdGVuY3lf
bmljZSBwYXRjaHNldC4NCj4gRmlyc3QsIHRvIGNsYXJpZnkgb2JqZWN0aXZlcywgT3JhY2xlIGlz
IG5vdA0KPiBpbnRlcmVzdGVkIGluIHRyYWRpbmcgdGhyb3VnaHB1dCBmb3IgbGF0ZW5jeS4NCj4g
V2hhdCB3ZSBmb3VuZCBpcyB0aGF0IHRoZSBEQiBoYXMgc3BlY2lmaWMgdGFza3Mgd2hpY2ggZG8g
dmVyeSBsaXR0bGUgYnV0DQo+IG5lZWQgdG8gZG8gdGhpcyBhcyBhYnNvbHV0ZWx5IHF1aWNrbHkg
YXMgcG9zc2libGUsIGllIGV4dHJlbWUgbGF0ZW5jeQ0KPiBzZW5zaXRpdml0eS4gU2Vjb25kLCB0
aGUga2V5IHRvIGxhdGVuY3kgcmVkdWN0aW9uDQo+IGluIHRoZSB0YXNrIHdha2V1cCBwYXRoIHNl
ZW1zIHRvIGJlIGxpbWl0aW5nIHZhcmlhdGlvbnMgb2YgImlkbGUgY3B1IiBzZWFyY2guDQo+IFRo
ZSBsYXR0ZXIgcGFydGljdWxhcmx5IGludGVyZXN0cyBtZSBhcyBhbiBleGFtcGxlIG9mICJwbGF0
Zm9ybSBzaXplDQo+IGJhc2VkIGxhdGVuY3kiIHdoaWNoIEkgYmVsaWV2ZSB0byBiZSBpbXBvcnRh
bnQgZ2l2ZW4gYWxsIHRoZSB2YXJ5aW5nIHNpemUNCj4gVk1zIGFuZCBjb250YWluZXJzLg0KDQpG
cm9tIG15IGV4cGVyaW1lbnRzIHRoZXJlIGFyZSBhIGZldyB0aGluZ3MgdGhhdCBzZWVtIHRvIGFm
ZmVjdCBsYXRlbmN5DQpvZiB3YWtpbmcgdXAgcmVhbCB0aW1lIChzY2hlZCBmaWZvKSB0YXNrcyBv
biBhIG5vcm1hbCBrZXJuZWw6DQoNCjEpIFRoZSB0aW1lIHRha2VuIGZvciB0aGUgKGludGVsIHg4
NikgY3B1IHRvIHdha2V1cCBmcm9tIG1vbml0b3IvbXdhaXQuDQogICBJZiB0aGUgY3B1IGlzIGFs
bG93ZWQgdG8gZW50ZXIgZGVlcGVyIHNsZWVwIHN0YXRlcyB0aGlzIGNhbiB0YWtlIDkwMHVzLg0K
ICAgQW55IGNoYW5nZXMgdG8gdGhpcyBhcmUgc3lzdGVtLXdpZGUgbm90IHByb2Nlc3Mgc3BlY2lm
aWMuDQoNCjIpIElmIHRoZSBjcHUgYW4gUlQgcHJvY2VzcyBsYXN0IHJhbiBvbiAoaWUgdGhlIG9u
ZSBpdCBpcyB3b2tlbiBvbikgaXMNCiAgIHJ1bm5pbmcgaW4ga2VybmVsLCB0aGUgcHJvY2VzcyBz
d2l0Y2ggd29uJ3QgaGFwcGVuIHVudGlsIGNvbmRfcmVzaGVkKCkNCiAgIGlzIGNhbGxlZC4NCiAg
IE9uIG15IHN5c3RlbSB0aGUgY29kZSB0byBmbHVzaCB0aGUgZGlzcGxheSBmcmFtZSBidWZmZXIg
dGFrZXMgMy4zbXMuDQogICBDb21waWxpbmcgYSBrZXJuZWwgd2l0aCBDT05GSUdfUFJFRU1QVD15
IHdpbGwgcmVkdWNlIHRoaXMuDQoNCjMpIElmIGEgaGFyZHdhcmUgaW50ZXJydXB0IGhhcHBlbnMg
anVzdCBhZnRlciB0aGUgcHJvY2VzcyBpcyB3b2tlbg0KICAgdGhlbiB5b3UgaGF2ZSB0byB3YWl0
IHVudGlsIGl0IGZpbmlzaGVzIGFuZCBhbnkgJ3NvZnRpbnQnIHdvcmsNCiAgIHRoYXQgaXMgc2No
ZWR1bGVkIG9uIHRoZSBzYW1lIGNwdSBmaW5pc2hlcy4NCiAgIFRoZSBldGhlcm5ldCBkcml2ZXIg
dHJhbnNtaXQgY29tcGxldGlvbnMgYW4gcmVjZWl2ZSByaW5nIGZpbGxpbmcNCiAgIGNhbiBlYXNp
bHkgdGFrZSAxbXMuDQogICBCb290aW5nIHdpdGggJ3RocmVhZGlycScgbWlnaHQgaGVscCB0aGlz
Lg0KDQo0KSBJZiB5b3UgbmVlZCB0byBhY3F1aXJlIGEgbG9jay9mdXRleCB0aGVuIHlvdSBuZWVk
IHRvIGFsbG93IGZvciB0aGUNCiAgIHByb2Nlc3MgdGhhdCBob2xkcyBpdCBiZWluZyBkZWxheWVk
IGJ5IGEgaGFyZHdhcmUgaW50ZXJydXB0IChldGMpLg0KICAgU28gZXZlbiBpZiB0aGUgbG9jayBp
cyBvbmx5IGhlbGQgZm9yIGEgZmV3IGluc3RydWN0aW9ucyBpdCBjYW4gdGFrZQ0KICAgYSBsb25n
IHRpbWUgdG8gYWNxdWlyZS4NCiAgIChJIG5lZWQgdG8gY2hhbmdlIHNvbWUgbGlua2VkIGxpc3Rz
IHRvIGFycmF5cyBpbmRleGVkIGJ5IGFuIGF0b21pY2FsbHkNCiAgIGluY3JlbWVudGVkIGdsb2Jh
bCBpbmRleC4pDQoNCkZXSVcgSSBjYW4ndCBpbWFnaW5lIGhvdyBhIGRhdGFiYXNlIGNhbiBoYXZl
IGFueXRoaW5nIHRoYXQgaXMgdGhhdA0KbGF0ZW5jeSBzZW5zaXRpdmUuDQpXZSBhcmUgZG9pbmcg
bG90cyBvZiBjaGFubmVscyBvZiBhdWRpbyBwcm9jZXNzaW5nIGFuZCBoYXZlIGEgbG90IG9mIHdv
cmsNCnRvIGRvIHdpdGhpbiAxMG1zIHRvIGF2b2lkIGF1ZGlibGUgZXJyb3JzLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

