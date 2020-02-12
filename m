Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C8C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D43F20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBLMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:40:42 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:59772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbgBLMkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:40:42 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id EDE6AC5CC2F82D471DD7;
        Wed, 12 Feb 2020 20:40:36 +0800 (CST)
Received: from dggeme716-chm.china.huawei.com (10.1.199.112) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 20:40:36 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme716-chm.china.huawei.com (10.1.199.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 12 Feb 2020 20:40:36 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Wed, 12 Feb 2020 20:40:36 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: x86: remove duplicated KVM_REQ_EVENT request
Thread-Topic: [PATCH] KVM: x86: remove duplicated KVM_REQ_EVENT request
Thread-Index: AdXhn4JGl8Q5ROUkR4Km9wNMCbNdGQ==
Date:   Wed, 12 Feb 2020 12:40:36 +0000
Message-ID: <cd32d5cf40094a239d79a1dbca6a45b4@huawei.com>
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

UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4gd3JpdGU6DQo+IE9uIDA3LzAyLzIw
IDEwOjA1LCBWaXRhbHkgS3V6bmV0c292IHdyb3RlOg0KPj4ga3ZtX21ha2VfcmVxdWVzdCgpIGZy
b20ga3ZtX3NldF9yZmxhZ3MoKSBhcyBpdCBpcyBub3QgYW4gb2J2aW91cyANCj4+IGJlaGF2aW9y
IChlLmcuIHdoeSBrdm1fcmlwX3dyaXRlKCkgZG9lbnMndCBkbyB0aGF0IGFuZA0KPj4ga3ZtX3Nl
dF9yZmxhZ3MoKSBkb2VzID8pDQo+DQo+QmVjYXVzZSB3cml0aW5nIFJGTEFHUyBjYW4gY2hhbmdl
IElGIGFuZCB0aGVyZWZvcmUgY2F1c2UgYW4gaW50ZXJydXB0IHRvIGJlIGluamVjdGVkLg0KPg0K
DQpNYW55IHRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbi4gOikgSSB0aG91Z2h0IGl0IHdhcyBi
ZWNhdXNlIG9mIFRyYXAgRmxhZy4NCg0K
