Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76265C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5611720714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBKC1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:27:00 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:47836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727493AbgBKC1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:27:00 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 7425392B010A867031DC;
        Tue, 11 Feb 2020 10:26:56 +0800 (CST)
Received: from dggeme765-chm.china.huawei.com (10.3.19.111) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 10:26:51 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 11 Feb 2020 10:26:51 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Tue, 11 Feb 2020 10:26:51 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Wanpeng Li <kernellwp@gmail.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] KVM: Pre-allocate 1 cpumask variable per cpu for
 both pv tlb and pv ipis
Thread-Topic: [PATCH v2 2/2] KVM: Pre-allocate 1 cpumask variable per cpu for
 both pv tlb and pv ipis
Thread-Index: AdXggrZmg97Y1seqSJWOii/1n81pMQ==
Date:   Tue, 11 Feb 2020 02:26:51 +0000
Message-ID: <5d472766470e44e1b91fe1e5b2f247f8@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGk6DQo+RnJvbTogV2FucGVuZyBMaSA8d2FucGVuZ2xpQHRlbmNlbnQuY29tPg0KPg0KPlRoaXMg
cGF0Y2ggZml4ZXMgaXQgYnkgcHJlLWFsbG9jYXRlIDEgY3B1bWFzayB2YXJpYWJsZSBwZXIgY3B1
IGFuZCB1c2UgaXQgZm9yIGJvdGggcHYgdGxiIGFuZCBwdiBpcGlzLi4NCj4NCj5SZXBvcnRlZC1i
eTogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+QWNrZWQtYnk6
IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPg0KPkNjOiBQZXRlciBa
aWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+Q2M6IE5pY2sgRGVzYXVsbmllcnMgPG5k
ZXNhdWxuaWVyc0Bnb29nbGUuY29tPg0KPlNpZ25lZC1vZmYtYnk6IFdhbnBlbmcgTGkgPHdhbnBl
bmdsaUB0ZW5jZW50LmNvbT4NCg0KTG9va3MgZmluZSBmb3IgbWUuIFRoYW5rcy4NClJldmlld2Vk
LWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0K
