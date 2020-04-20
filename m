Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6080C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC272078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EcjpzCRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTFno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:43:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48494 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbgDTFno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:43:44 -0400
X-UUID: d985ed20ac654ad5a9d8b5b3a70e0855-20200420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8WMihIX1G3xwXKUcZ3oRNUz/6PgZiIB1kiu0iy+8nSo=;
        b=EcjpzCRQ4Y3w7v5xxB8Qag5Nxhy1JRp6xPxLrp0wU30CEVEWqBB0R0MfzcZSF5XsJlEC29gFjZ9rRY2nsFzWOI/NqLLgp7fhcGdseIEO2yZEw9Z+HTmfsDwwXUTgSHbKrKKOvUXZnqckQm8w7846GcgVD75IhIFbOZU6aLsLTgs=;
X-UUID: d985ed20ac654ad5a9d8b5b3a70e0855-20200420
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1695885634; Mon, 20 Apr 2020 13:43:41 +0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 13:43:38 +0800
Received: from MTKMBS06N2.mediatek.inc ([fe80::35cb:62e4:53bc:637d]) by
 mtkmbs06n2.mediatek.inc ([fe80::35cb:62e4:53bc:637d%18]) with mapi id
 15.00.1497.000; Mon, 20 Apr 2020 13:43:40 +0800
From:   =?utf-8?B?V2FsdGVyLVpIIFd1ICjlkLPnpZblr7Ap?= 
        <Walter-ZH.Wu@mediatek.com>
To:     David Gow <davidgow@google.com>,
        "trishalfonso@google.com" <trishalfonso@google.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Andrey Konovalov" <andreyknvl@google.com>
Subject: RE: [PATCH v6 2/5] KUnit: KASAN Integration
Thread-Topic: [PATCH v6 2/5] KUnit: KASAN Integration
Thread-Index: AQHWFTAiYFnHEtPY6kiUTjs5y2r2caiBgWxg
Date:   Mon, 20 Apr 2020 05:43:40 +0000
Message-ID: <eb68aacaf65b4e37962f1b746d3e7c5c@mtkmbs06n2.mediatek.inc>
References: <20200418031833.234942-1-davidgow@google.com>
 <20200418031833.234942-3-davidgow@google.com>
In-Reply-To: <20200418031833.234942-3-davidgow@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCglzdGFydF9yZXBvcnQoJmZsYWdzKTsNCiAJcHJfZXJyKCJCVUc6IEtBU0FO
OiBkb3VibGUtZnJlZSBvciBpbnZhbGlkLWZyZWUgaW4gJXBTXG4iLCAodm9pZCAqKWlwKTsNCiAJ
cHJpbnRfdGFncyh0YWcsIG9iamVjdCk7DQpAQCAtNDg2LDYgKzUxMywxNCBAQCB2b2lkIF9fa2Fz
YW5fcmVwb3J0KHVuc2lnbmVkIGxvbmcgYWRkciwgc2l6ZV90IHNpemUsIGJvb2wgaXNfd3JpdGUs
IHVuc2lnbmVkIGxvbg0KIAl2b2lkICp1bnRhZ2dlZF9hZGRyOw0KIAl1bnNpZ25lZCBsb25nIGZs
YWdzOw0KIA0KKwlpZiAobGlrZWx5KCFyZXBvcnRfZW5hYmxlZCgpKSkNCisJCXJldHVybjsNCg0K
a2FzYW5fcmVwb3J0KCkgYWxyZWFkeSBoYXMgdGhlIHRlc3QgZXhwcmVzc2lvbiwgaXQgc2hvdWxk
IG5vdCBuZWVkIGR1cGxpY2F0aW5nIGlmIHN0YXRlbWVudC4NCg0KDQpXYWx0ZXINCg0KKw0KKyNp
ZiBJU19FTkFCTEVEKENPTkZJR19LVU5JVCkNCisJaWYgKGN1cnJlbnQtPmt1bml0X3Rlc3QpDQor
CQlrYXNhbl91cGRhdGVfa3VuaXRfc3RhdHVzKGN1cnJlbnQtPmt1bml0X3Rlc3QpOw0KKyNlbmRp
ZiAvKiBJU19FTkFCTEVEKENPTkZJR19LVU5JVCkgKi8NCisNCiAJZGlzYWJsZV90cmFjZV9vbl93
YXJuaW5nKCk7DQogDQogCXRhZ2dlZF9hZGRyID0gKHZvaWQgKilhZGRyOw0KLS0NCjIuMjYuMS4z
MDEuZzU1YmMzZWI3Y2I5LWdvb2cNCg0KLS0NCllvdSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgYmVj
YXVzZSB5b3UgYXJlIHN1YnNjcmliZWQgdG8gdGhlIEdvb2dsZSBHcm91cHMgImthc2FuLWRldiIg
Z3JvdXAuDQpUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5n
IGVtYWlscyBmcm9tIGl0LCBzZW5kIGFuIGVtYWlsIHRvIGthc2FuLWRldit1bnN1YnNjcmliZUBn
b29nbGVncm91cHMuY29tLg0KVG8gdmlldyB0aGlzIGRpc2N1c3Npb24gb24gdGhlIHdlYiB2aXNp
dCBodHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2QvbXNnaWQva2FzYW4tZGV2LzIwMjAwNDE4MDMx
ODMzLjIzNDk0Mi0zLWRhdmlkZ293JTQwZ29vZ2xlLmNvbS4NCg==
