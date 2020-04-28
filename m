Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B7F206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgD1Ltf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:49:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2065 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgD1Ltf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:49:35 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 2CE5A9A64A1CC1F80253;
        Tue, 28 Apr 2020 19:49:33 +0800 (CST)
Received: from dggeme705-chm.china.huawei.com (10.1.199.101) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 28 Apr 2020 19:49:32 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme705-chm.china.huawei.com (10.1.199.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 28 Apr 2020 19:49:32 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Tue, 28 Apr 2020 19:49:32 +0800
From:   Hushijie <hushijie3@huawei.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nixiaoming <nixiaoming@huawei.com>,
        "wangxu (AE)" <wangxu72@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        yangerkun <yangerkun@huawei.com>,
        "Wangle (RTOS FAE)" <wangle6@huawei.com>,
        "Chengang (L)" <cg.chen@huawei.com>
Subject: Re [PATCH] [RFC]hugetlbfs: Get unmapped area below TASK_UNMAPPED_BASE
 for hugetlbfs
Thread-Topic: Re [PATCH] [RFC]hugetlbfs: Get unmapped area below
 TASK_UNMAPPED_BASE for hugetlbfs
Thread-Index: AdYdUmUl7otGISMhRXK04Qrl9WrqxA==
Date:   Tue, 28 Apr 2020 11:49:32 +0000
Message-ID: <2f7fcfd8d66d4df7ac0c972fd9c3abc1@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.103.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IE9uIDQvMjgvMjAgNjo0NiBBTSwgTWlrZSBLcmF2ZXR6IHdyb3RlOg0KPkp1c3QgY3VyaW91cy4g
IEhhdmUgeW91IGFjdHVhbGx5IHNlZWluZyBhIHByb2JsZW0gd2l0aCB0aGlzIGNvZGUsIG9yIGlz
DQo+dGhlIHJlYXNvbiBmb3IgdGhlIHByb3Bvc2VkIGNoYW5nZSBqdXN0IHRoZSByZXN1bHQgb2Yg
Y29kZSBpbnNwZWN0aW9uPyAgSSBhc2sNCj5iZWNhdXNlIG1hbnkgYXJjaGl0ZWN0dXJlcyBoYXZl
IHRoZWlyIG93biB2ZXJzaW9uIG9mIGh1Z2V0bGJfZ2V0X3VubWFwcGVkX2FyZWEuDQo+U28sIGlm
IHlvdSBhcmUgc2VlaW5nIHRoaXMgaXNzdWUgaXQgd291bGQgYmUgaW50ZXJlc3RpbmcgdG8ga25v
dyB3aGF0DQo+YXJjaGl0ZWN0dXJlIHlvdSBhcmUgcnVubmluZy4NCg0KVGhhbmtzIGZvciB5b3Vy
IHJlcGx5Lg0KDQpXZSBhY3R1YWxseSBmb3VuZCB0aGlzIHByb2JsZW0gb24gYXJtNjQgYXJjaGl0
ZWN0dXJlLCBydW5uaW5nIGEgMzItYml0IA0KcHJvZ3JhbS4gV2hlbiB0aGUgYWRkcmVzcyBzcGFj
ZSBiZWxvdyBUQVNLX1VOTUFQUEVEX0JBU0UgaXMgY29tcGxldGVseSANCmV4aGF1c3RlZCwgc2ht
YXQoKSBmb3IgaHVnZSBwYWdlcyB3aWxsIHJldHVybiBFTk9NRU0sIGJ1dCBzaG1hdCgpIGZvciAN
Cm5vcm1hbCBwYWdlcyBjYW4gc3RpbGwgc3VjY2Vzcy4NCg0KPlRoZSByb3V0aW5lIGh1Z2V0bGJf
Z2V0X3VubWFwcGVkX2FyZWEgaGFzIG5vdCBjaGFuZ2VkIG11Y2ggc2luY2UgdGhpcyBmaXJzdA0K
PmdpdCB2ZXJzaW9uLiAgSSBzdXNwZWN0IHRoaXMgaXMgYmVjYXVzZSBpdCBpcyBtb3N0bHkgdW51
c2VkLg0KPg0KPkkgbm90aWNlZCB0aGF0IGh1Z2V0bGJfZ2V0X3VubWFwcGVkX2FyZWEgaXMgb25l
IG9mIG9ubHkgYSBmZXcgcGxhY2VzIGluIGFyY2gNCj5pbmRlcGVuZGVudCBjb2RlIGNhbGxpbmcg
dm1fdW5tYXBwZWRfYXJlYSgpLiAgVGhlIG90aGVyIGNhbGxlcnMgYXJlIGFyY2gNCj5pbmRlcGVu
ZGVudCBmYWxsIGJhY2sgcm91dGluZXMgZm9yIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWEqIHJvdXRp
bmVzLiAgSWYgd2UNCj5tb3ZlIGZvcndhcmQgd2l0aCBjaGFuZ2VzIHRvIHRoaXMgcm91dGluZSwg
d291bGQgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIHVzZQ0KPnRoZSBhcmNoX2dldF91bm1hcHBlZF9h
cmVhKiByb3V0aW5lcyBpbnN0ZWFkIG9mIGNhbGxpbmcgdm1fdW5tYXBwZWRfYXJlYQ0KPmRpcmVj
dGx5PyAgVGhpcyB3b3VsZCB0YWtlIGFkdmFudGFnZSBvZiBhbnkgYXJjaCBzcGVjaWZpYyBpZiBp
dCBleGlzdHMuDQoNCkkgdG90YWxseSBhZ3JlZSB3aXRoIHlvdS4NCiANCkl0IGlzIG1vcmUgYXBw
cm9wcmlhdGUgdG8gaW1wbGVtZW50aW5nIGh1Z2V0bGJfZ2V0X3VubWFwcGVkX2FyZWEoKSBmb3Ig
YSANCnNwZWNpZmljIGFyY2hpdGVjdHVyZSwgaW5zdGVhZCBvZiBjaGFnaW5nIGNvbW1vbiBodWdl
dGxiX2dldF91bm1hcHBlZF9hcmVhKCkgDQppbnRlcmZhY2UgYXQgImZzL2h1Z2V0bGJmcy9pbm9k
ZS5jIi4NCg0KSSB3aWxsIHN1Ym1pdCBhbm90aGVyIHBhdGNoIGp1c3QgZm9yIHNwZWNpZmljIGFy
Y2hpdGVjdHVyZXMgKGFybTY0KSBsYXRlci4gDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkgYW5kIGFk
dmlzZS4NCg==
