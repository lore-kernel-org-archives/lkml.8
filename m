Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D10FC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F932082E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDUCWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:22:36 -0400
Received: from mx20.baidu.com ([111.202.115.85]:54664 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbgDUCWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:22:35 -0400
X-Greylist: delayed 1860 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 22:22:35 EDT
Received: from BJHW-Mail-Ex16.internal.baidu.com (unknown [10.127.64.39])
        by Forcepoint Email with ESMTPS id 33EDADFD214200CDC8BC;
        Tue, 21 Apr 2020 09:35:42 +0800 (CST)
Received: from BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) by
 BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 21 Apr 2020 09:35:41 +0800
Received: from BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) by
 BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) with mapi id
 15.01.1713.004; Tue, 21 Apr 2020 09:35:41 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBzY2hlZC9pc29sYXRpb246IGFsbG93IGlzb2xjcHVz?=
 =?gb2312?Q?_and_nohz=5Ffull_for_different_cpus?=
Thread-Topic: [PATCH] sched/isolation: allow isolcpus and nohz_full for
 different cpus
Thread-Index: AQHWFzGM1HZWICvs0EuekKauwS8wAKiCxS5A
Date:   Tue, 21 Apr 2020 01:35:41 +0000
Message-ID: <1d04cd31871648128267dda5303db99e@baidu.com>
References: <1587027078-16239-1-git-send-email-lirongqing@baidu.com>
 <20200420163409.GB10024@lenoir>
In-Reply-To: <20200420163409.GB10024@lenoir>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.2]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex16_2020-04-21 09:35:42:154
x-baidu-bdmsfe-viruscheck: BJHW-Mail-Ex16_GRAY_Inside_WithoutAtta_2020-04-21
 09:35:42:122
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogRnJlZGVyaWMgV2Vpc2JlY2tlciBb
bWFpbHRvOmZyZWRlcmljQGtlcm5lbC5vcmddDQo+ILeiy83KsbzkOiAyMDIwxOo01MIyMcjVIDA6
MzQNCj4gytW8/sjLOiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ILOty806
IHBldGVyekBpbmZyYWRlYWQub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQGtlcm5lbC5v
cmc7DQo+IHNyaWthckBsaW51eC52bmV0LmlibS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4g1vfM4jogUmU6IFtQQVRDSF0gc2NoZWQvaXNvbGF0aW9uOiBhbGxvdyBpc29sY3B1
cyBhbmQgbm9oel9mdWxsIGZvciBkaWZmZXJlbnQNCj4gY3B1cw0KPiANCj4gT24gVGh1LCBBcHIg
MTYsIDIwMjAgYXQgMDQ6NTE6MThQTSArMDgwMCwgTGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gd2hl
biBib3RoIGlzb2xjcHVzIGFuZCBub2h6X2Z1bGwgYXJlIHNldCwgdGhlaXIgY3B1cyBtdXN0IGJl
IHNhbWUgbm93LA0KPiA+IGluIGZhY3QgaXNvbGNwdXMgYW5kIG5vaHpfZnVsbCBhcmUgbm90IHJl
bGF0ZWQsIGFuZCBkaWZmZXJlbnQgY3B1cyBhcmUNCj4gPiBleHBlY3RlZCBmb3Igc29tZSBjYXNl
cywgZm9yIGV4YW1wbGUsIHNvbWUgY29yZXMgZm9yIHBvbGxpbmcgdGhyZWFkcw0KPiA+IHdhbnRz
IHRvIGlzb2xjcHVzLCBhbmQgc29tZSBjb3JlcyBmb3IgZGVkaWNhdGVkIHRocmVhZHMsIG9ubHkN
Cj4gPiBub2h6X2Z1bGwgaXMgZXhwZWN0ZWQNCj4gPg0KPiA+IHNvIGRlZmluZSB0d28gaG91c2Vr
ZWVwaW5nIG1hc2sgdG8gc2F2ZSB0aGVzZSB0d28gY29uZmlndXJhdGlvbg0KPiA+IHNlcGFyYXRl
bHkgYW5kIG1ha2UgY3B1cyBzYW1lIG9ubHkgd2hlbiBib3RoIG5vaHpfZnVsbCBhbmQgaXNvbGNw
dXMNCj4gPiB3aXRoIG5vaHogYXJlIHBhc3NlZCBpbnRvIGtlcm5lbA0KPiA+DQo+ID4gZml4IGEg
YnVpbGQgZXJyb3Igd2hlbiBDT05GSUdfQ1BVTUFTS19PRkZTVEFDSyBpcyBub3QgY29uZmlndXJl
ZA0KPiA+IHJlcG9ydGVkIGJ5IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiAN
Cj4gV2hhdCBpcyB0aGUgdXNlY2FzZSB3aGVuIHlvdSB3YW50IHRvIGFmZmluZSBtYW5hZ2VkIGlu
dGVycnVwdD8NCj4gRG8geW91IG9ubHkgd2FudCB0byBhZmZpbmUgSVJRIG9yIGRvIHlvdSBhbHNv
IHdhbnQgdG8gYWZmaW5lIGV2ZXJ5IHVuYm91bmQNCj4gd29yaywgc3VjaCBhcyBrdGhyZWFkLCB3
b3JrcXVldWVzLCB0aW1lcnMsIGV0Yy4uLj8NCj4gDQoNCkFzIGNsb3VkIGNvbXB1dGUgbm9kZSwg
Ym90aCBxZW11IGFuZCBvdnMtZHBkayBydW4gb24gaXQNCg0KU29tZSBjb3JlcyBhcmUgYm91bmQg
dG8gcnVuIG92cy1kcGRrLCBhbmQgc2hvdWxkIGJlIGlzb2xhdGVkIGZyb20gYW55IGRpc3R1cmIg
KGlzb2xjcHVzPSBub2h6X2Z1bGw9ICByY3Vfbm9jYnM9ICkNCg0KT3RoZXIgY29yZXMgcnVuIGt2
bSBxZW11LCBhbmQgZG8gbm90IHdhbnRzIHRvIGJlIGRpc3R1cmJlZCBieSBocnRpbWVyIChvbmx5
IG5vaHpfZnVsbD0pIGJ5IHVzaW5nIHRoaXMgZmVhdHVyZSBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL2NvdmVyLzExMDMzNTMzLw0KDQpUaGFua3MNCg0KLUxpUm9uZ1FpbmcNCg0KPiBJbiB0
aGUgZW5kIEkgd291bGQgbGlrZSB0byBncm91cCB0aGUgaXNvbGF0aW9uIGZlYXR1cmVzIHRoYXQg
b25seSBtYWtlIHNlbnNlDQo+IHRvZ2V0aGVyLiBTbyB3ZSBjb3VsZCBlbmQgdXAgd2l0aCB0aHJl
ZSBjcHVtYXNrcywgb25lIGZvciAiZG9tYWlucyIsIG9uZSBmb3INCj4gIm5vaHoiIGFuZCBvbmUg
Zm9yIGFsbCAidW5ib3VuZCIgd29ya3MuDQo+IA0KPiBJbiBmYWN0ICJkb21haW5zIiBzaG91bGQg
ZXZlbiBkaXNhcHBlYXIgYW5kIGJlY29tZSAidW5ib3VuZCIgKw0KPiAibG9hZF9iYWxhbmNlIiwg
YXMgdGhhdCdzIHRoZSBkZXNpcmVkIG91dGNvbWUgb2YgaGF2aW5nIE5VTEwgZG9tYWlucy4NCj4g
DQo+IEknbSB0cnlpbmcgdG8gcHJlcGFyZSBhIHN1aXRhYmxlIGludGVyZmFjZSBmb3IgYWxsIHRo
YXQgaW4gY3B1c2V0cyB3aGVyZSB3ZQ0KPiBhbHJlYWR5IGhhdmUgdGhlIGxvYWRfYmFsYW5jZSBw
YXJ0Lg0KPiANCj4gVGhhbmtzLg0K
