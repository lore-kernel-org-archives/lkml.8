Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BA62083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgG0NkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:40:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:44906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728314AbgG0NkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:40:10 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 6C8E8FA6F30BD7BEA73B;
        Mon, 27 Jul 2020 21:40:09 +0800 (CST)
Received: from DGGEMI526-MBX.china.huawei.com ([169.254.8.132]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0487.000;
 Mon, 27 Jul 2020 21:40:03 +0800
From:   "Fangxiuning (Jack, EulerOS)" <fangxiuning@huawei.com>
To:     jingrui <jingrui@huawei.com>, Michal Hocko <mhocko@kernel.org>
CC:     "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogUFJPQkxFTTogY2dyb3VwIGNvc3QgdG9vIG11Y2ggbWVt?=
 =?gb2312?Q?ory_when_transfer_small_files_to_tmpfs?=
Thread-Topic: =?gb2312?B?tPC4tDogUFJPQkxFTTogY2dyb3VwIGNvc3QgdG9vIG11Y2ggbWVtb3J5IHdo?=
 =?gb2312?Q?en_transfer_small_files_to_tmpfs?=
Thread-Index: AdZfPbaDbBlN0uuzRT+WBs1zGYD4fAAETDVgAH9ylAAAE+ehUP//nlQA//tVE3D/9fVQYA==
Date:   Mon, 27 Jul 2020 13:40:02 +0000
Message-ID: <E76E3B653DA8834F9E97D3B9694D2E5B816B7C@DGGEMI526-MBX.china.huawei.com>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
 <20200724075508.GF4061@dhcp22.suse.cz>
 <2E04DD7753BE0E4ABABF0B664610AD6F2620D4F6@dggeml528-mbx.china.huawei.com>
 <20200724113530.GH4061@dhcp22.suse.cz>
 <2E04DD7753BE0E4ABABF0B664610AD6F2621907D@dggeml508-mbx.china.huawei.com>
In-Reply-To: <2E04DD7753BE0E4ABABF0B664610AD6F2621907D@dggeml508-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.95]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QFhpdW5pbmcgV291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhbmQgZ2l2ZSBzb21lIHN1Z2dl
c3Rpb24/DQpJIGRvbid0IHN1Z2dlc3QgdGhpcyBzb2x1dGlvbiBmb3IgdXNpbmcgaW4gbG9uZyB0
ZXJtIHdoaWNoIHNraXAgY2FsbCBwYW0tc3lzdGVtZC5zbyB0byBmaXggdGhpcyBpc3N1ZSwgU2Z0
cCBzZW5kcyBmaWxlcyBhbmQgY2FsbCBwYW0tc3lzdGVtZC5zbyB0byBjcmVhdGUgc2Vzc2lvbiB3
aGljaCBtYW5hZ2UgcmVzb3VyY2VzIG1vcmUgcmVhc29uYWJsZSwgdGhpcyBpcyBldm9sdXRpb24g
ZGlyZWN0aW9uIG9mIHN5c3RlbWQgdXBzdHJlYW0uIFN5c3RlbWQgZG9uJ3QgaGF2ZSBiZXR0ZXIg
c29sdXRpb24gYW5kIEtlcm5lbCBjZ3JvdXAgbWF5YmUgZ2l2ZSBhIGJldHRlciBvbmUgZm9yIHRo
aXMgaXNzdWUuDQoNCg==
