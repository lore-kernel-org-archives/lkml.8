Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC1C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D743620775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgD2JJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:09:18 -0400
Received: from mx20.baidu.com ([111.202.115.85]:36918 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbgD2JJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:09:17 -0400
Received: from BC-Mail-Ex32.internal.baidu.com (unknown [172.31.51.26])
        by Forcepoint Email with ESMTPS id 31488EF6B05385D52B1B;
        Wed, 29 Apr 2020 16:53:21 +0800 (CST)
Received: from BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) by
 BC-Mail-Ex32.internal.baidu.com (172.31.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Wed, 29 Apr 2020 16:53:20 +0800
Received: from BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) by
 BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) with mapi id
 15.01.1713.004; Wed, 29 Apr 2020 16:53:21 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHg4NjogbW92ZSB0dXJib19kaXNhYmxlZCgpIG91?=
 =?utf-8?B?dCBvZiBpbnRlbF9zZXRfbWF4X2ZyZXFfcmF0aW8=?=
Thread-Topic: [PATCH] x86: move turbo_disabled() out of
 intel_set_max_freq_ratio
Thread-Index: AQHWHf5SNM6UMcxYQk+vHgcwGgRbdKiPywfQ
Date:   Wed, 29 Apr 2020 08:53:20 +0000
Message-ID: <98dec9ed285d4f96baccc73195cac84e@baidu.com>
References: <1588125007-8799-1-git-send-email-lirongqing@baidu.com>
 <1588148110.21179.63.camel@suse.cz>
In-Reply-To: <1588148110.21179.63.camel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.9]
x-baidu-bdmsfe-datecheck: 1_BC-Mail-Ex32_2020-04-29 16:53:21:041
x-baidu-bdmsfe-viruscheck: BC-Mail-Ex32_GRAY_Inside_WithoutAtta_2020-04-29
 16:53:21:025
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEhlbGxvLA0KPiANCj4gdGhlIHByb2JsZW0gaXMgdGhhdCB0dXJibyBjYW4gYmUgZW5hYmxl
ZC9kaXNhYmxlZCBieSB0aGUgZmlybXdhcmUgYXQgcnVudGltZSwNCj4gYWZ0ZXIgdGhlIG1hY2hp
bmUgaGFzIGJvb3RlZC4NCj4gDQo+IFRoaXMgaGFwcGVucyBmb3IgZXhhbXBsZSB3aXRoIHRoZSBE
ZWxsIFhQUyAxMywgd2hlcmUgdHVyYm8gZ2V0cyBkaXNhYmxlZCBieQ0KPiB0aGUgZmlybXdhcmUg
aWYgdGhlIG1hY2hpbmUgaXMgZGlzY29ubmVjdGVkIGZyb20gQUMgcG93ZXIgYW5kIHJ1bnMgb24g
YmF0dGVyeS4NCj4gVGhlIGxhcHRvcCBjb3VsZCBib290IG9uIGJhdHRlcnkgKHR1cmJvIGRpc2Fi
bGVkKSwgdGhlbiBhZnRlciBzb21lIHRpbWUgdGhlDQo+IHVzZXIgY29ubmVjdHMgdGhlIEFDIHBv
d2VyIHN1cHBseSwgdHVyYm8gZ2V0cyBlbmFibGVkLCBhbmQgd2l0aCB5b3VyIHBhdGNoDQo+IHdl
IHdvdWxkbid0IGtub3cgd2hhdCBpcyB0aGUgdHVyYm9fZnJlcS9iYXNlX2ZyZXEgcmF0aW8gdG8g
ZG8gZnJlcXVlbmN5DQo+IGludmFyaWFuY2UgKHdlIHNraXBwZWQgcmVhZGluZyBNU1JfVFVSQk9f
UkFUSU9fTElNSVQgYXQgYm9vdCBiZWNhdXNlDQo+IHR1cmJvIHdhcyBkaXNhYmxlZCBhdCB0aGF0
IHRpbWVkKS4NCj4gDQo+IFRoaXMgYmVoYXZpb3Igd2FzIHJlcXVlc3RlZCBieSByZXZpZXdlcnMg
aW4gdGhpcyB0aHJlYWQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTkwNjQyNi5I
RHFhVmE3MW1GQGtyZWFjaGVyLw0KPiBhbmQgaW1wbGVtZW50ZWQgd2l0aCA5MTgyMjljZGQ1YWIg
KCJ4ODYvaW50ZWxfcHN0YXRlOiBIYW5kbGUgcnVudGltZSB0dXJibw0KPiBkaXNhYmxlbWVudC9l
bmFibGVtZW50IGluIGZyZXF1ZW5jeSBpbnZhcmlhbmNlIikuDQo+IA0KDQoNClRoYW5rcyBmb3Ig
eW91IGV4cGxhbmF0aW9uDQoNClNvcnJ5IGZvciBub2lzZQ0KDQotTGkNCg0KPiANCj4gVGhhbmtz
LA0KPiBHaW92YW5uaSBHaGVyZG92aWNoDQo=
