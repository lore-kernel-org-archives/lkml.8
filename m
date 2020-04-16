Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B8AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59038206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506073AbgDPLGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:06:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2057 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505994AbgDPLBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:01:48 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 7070F6156CB31EE8123A;
        Thu, 16 Apr 2020 18:45:18 +0800 (CST)
Received: from DGGEML524-MBX.china.huawei.com ([169.254.1.24]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0487.000;
 Thu, 16 Apr 2020 18:45:12 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSBtbS91c2VyY29weTogZml4IHdhcm5pbmcg?=
 =?gb2312?Q?Comparison_to_bool?=
Thread-Topic: [PATCH -next] mm/usercopy: fix warning Comparison to bool
Thread-Index: AQHWEg3NM5G3b6CdWkWVy/pKazaWX6h6SkKAgAFHhdA=
Date:   Thu, 16 Apr 2020 10:45:12 +0000
Message-ID: <C3CD0DF8AD11A84CB25A1426DE537C61E594BFF6@dggeml524-mbx.china.huawei.com>
References: <1586835724-45738-1-git-send-email-zou_wei@huawei.com>
 <20200415160439.256c89d4cb67b76d4119935d@linux-foundation.org>
In-Reply-To: <20200415160439.256c89d4cb67b76d4119935d@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.212.180]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQpQZXJoYXBzIHRoaXMgaXMgYSBk
ZXRlY3Rpb24gcnVsZSBvZiBDb2NjaW5lbGxlIChjb2NjaWNoZWNrKSBzb2Z0d2FyZSBmb3IgcHJv
Z3JhbW1pbmcgc3BlY2lmaWNhdGlvbnMsDQphbmQgaXQncyBubyB3cm9uZyB3aXRoIHRoZSBjb2Rl
LCBqdXN0IGEgY29kaW5nIHN0eWxlLg0KDQpCZXN0IFJlZ2FyZHMNClpvdSBXZWkNCi0tLS0t08q8
/tStvP4tLS0tLQ0Kt6K8/sjLOiBBbmRyZXcgTW9ydG9uIFttYWlsdG86YWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZ10gDQq3osvNyrG85DogMjAyMMTqNNTCMTbI1SA3OjA1DQrK1bz+yMs6IFpvdXdl
aSAoU2FtdWVsKSA8em91X3dlaUBodWF3ZWkuY29tPg0Ks63LzTogbGludXgtbW1Aa3ZhY2sub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBSZTogW1BBVENIIC1uZXh0XSBt
bS91c2VyY29weTogZml4IHdhcm5pbmcgQ29tcGFyaXNvbiB0byBib29sDQoNCk9uIFR1ZSwgMTQg
QXByIDIwMjAgMTE6NDI6MDQgKzA4MDAgWm91IFdlaSA8em91X3dlaUBodWF3ZWkuY29tPiB3cm90
ZToNCg0KPiBmaXggYmVsb3cgd2FybmluZ3MgcmVwb3J0ZWQgYnkgY29jY2ljaGVjaw0KPiANCj4g
bW0vdXNlcmNvcHkuYzozMDQ6NS0xODogV0FSTklORzogQ29tcGFyaXNvbiB0byBib29sDQo+DQo+
IC4uLg0KPg0KPiAtLS0gYS9tbS91c2VyY29weS5jDQo+ICsrKyBiL21tL3VzZXJjb3B5LmMNCj4g
QEAgLTMwMSw3ICszMDEsNyBAQCBfX3NldHVwKCJoYXJkZW5lZF91c2VyY29weT0iLCANCj4gcGFy
c2VfaGFyZGVuZWRfdXNlcmNvcHkpOw0KPiAgDQo+ICBzdGF0aWMgaW50IF9faW5pdCBzZXRfaGFy
ZGVuZWRfdXNlcmNvcHkodm9pZCkgIHsNCj4gLQlpZiAoZW5hYmxlX2NoZWNrcyA9PSBmYWxzZSkN
Cj4gKwlpZiAoIWVuYWJsZV9jaGVja3MpDQo+ICAJCXN0YXRpY19icmFuY2hfZW5hYmxlKCZieXBh
c3NfdXNlcmNvcHlfY2hlY2tzKTsNCj4gIAlyZXR1cm4gMTsNCj4gIH0NCg0KTXkgaW5pdGlhbCBy
ZWFjdGlvbiBpcyAiZml4IGNvY2NpY2hlY2siLiAgVGhlcmUncyBub3RoaW5nIHdyb25nIHdpdGgg
dGhhdCBjb2RlPw0KDQo=
