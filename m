Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA61C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EC320781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733229AbgGWD2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:28:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387488AbgGWD2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:28:40 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id E6161C4C0FC87783442E;
        Thu, 23 Jul 2020 11:28:37 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.195]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Thu, 23 Jul 2020 11:28:31 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        sujunfei <sujunfei2@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        butao <butao@hisilicon.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVtbWFw?=
 =?utf-8?Q?_for_sparse_memory_model_that_define_VMEMMAP?=
Thread-Topic: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Index: AQHWXzEQMpvo3yT4K0COUiys26URoqkT7ruAgACVOXA=
Date:   Thu, 23 Jul 2020 03:28:31 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F23130896@dggemm526-mbx.china.huawei.com>
References: <20200721073203.107862-1-liwei213@huawei.com>
 <dce65cf2-399b-28a7-8375-c8d5a69a9c81@arm.com>
In-Reply-To: <dce65cf2-399b-28a7-8375-c8d5a69a9c81@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.77.141]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQW5zaHVtYW4gS2hhbmR1YWwg
W21haWx0bzphbnNodW1hbi5raGFuZHVhbEBhcm0uY29tXSANCuWPkemAgeaXtumXtDogMjAyMOW5
tDfmnIgyM+aXpSAxMDozMw0K5pS25Lu25Lq6OiBsaXdlaSAoQ00pIDxsaXdlaTIxM0BodWF3ZWku
Y29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGxAa2VybmVsLm9yZw0K5oqE6YCBOiBT
b25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IHN1
anVuZmVpIDxzdWp1bmZlaTJAaGlzaWxpY29uLmNvbT47IFhpYXFpbmcgKEEpIDxzYWJlcmxpbHku
eGlhQGhpc2lsaWNvbi5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IHN0ZXZlLmNhcHBlckBhcm0uY29tOyBDaGVuZmVuZyAocHVjaykgPHB1Y2suY2hlbkBoaXNpbGlj
b24uY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcnBwdEBsaW51eC5pYm0uY29t
OyBmZW5nYmFvcGVuZyA8ZmVuZ2Jhb3BlbmcyQGhpc2lsaWNvbi5jb20+OyBuc2FlbnpqdWxpZW5u
ZUBzdXNlLmRlOyBidXRhbyA8YnV0YW9AaGlzaWxpY29uLmNvbT4NCuS4u+mimDogUmU6IFtQQVRD
SF0gYXJtNjQ6IG1tOiBmcmVlIHVudXNlZCBtZW1tYXAgZm9yIHNwYXJzZSBtZW1vcnkgbW9kZWwg
dGhhdCBkZWZpbmUgVk1FTU1BUA0KDQoNCg0KT24gMDcvMjEvMjAyMCAwMTowMiBQTSwgV2VpIExp
IHdyb3RlOg0KPiBGb3IgdGhlIG1lbW9yeSBob2xlLCBzcGFyc2UgbWVtb3J5IG1vZGVsIHRoYXQg
ZGVmaW5lIFNQQVJTRU1FTV9WTUVNTUFQIA0KPiBkbyBub3QgZnJlZSB0aGUgcmVzZXJ2ZWQgbWVt
b3J5IGZvciB0aGUgcGFnZSBtYXAsIHRoaXMgcGF0Y2ggZG8gaXQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBXZWkgTGkgPGxpd2VpMjEzQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENoZW4g
RmVuZyA8cHVjay5jaGVuQGhpc2lsaWNvbi5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpYSBRaW5n
IDxzYWJlcmxpbHkueGlhQGhpc2lsaWNvbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9tbS9p
bml0LmMgfCA4MSANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDEwIGRlbGV0
aW9ucygtKQ0KDQpUaGlzIHBhdGNoIGRvZXMgbm90IGNvbXBpbGUgb24gNS44LXJjNiB3aXRoIGRl
ZmNvbmZpZy4NCg0KSGksDQoNCldlJ3JlIHdvcmtpbmcgb24gcGF0Y2ggdjIgYXMgc29vbiBhcyBw
b3NzaWJsZS4NCg0KVGhhbmtzLg0K
