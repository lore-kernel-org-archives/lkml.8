Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB6CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B795205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bg9Pgjd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgENHe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:34:56 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25851 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgENHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:34:56 -0400
X-UUID: 72bfeb9eaa344ce58a72c6db30dc0aad-20200514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/nREqLi1Ldl8sd0riITmmpWJKuTNyeKnEZWI4u7Mg0Y=;
        b=bg9Pgjd9KHnY+znNILPTWZKAHNkxlugL4jlyX1guMYRskgMMgE8jl+Z+r8xM7pRv1NEVrIcjRn4BqJf2uQJ1Au8l+So/+zDkV+X5uR+UqUo8X1Kc3UcAJ/01yUKgXKWHE887B4wOsDD4XISz7fjLG+OXJ+Kekile5fcawNQIdZk=;
X-UUID: 72bfeb9eaa344ce58a72c6db30dc0aad-20200514
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 549127802; Thu, 14 May 2020 15:34:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 May
 2020 15:34:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 May 2020 15:34:44 +0800
Message-ID: <1589441605.28160.27.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: musb: mediatek: add reset FADDR to zero in reset
 interrupt handle
From:   Min Guo <min.guo@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Date:   Thu, 14 May 2020 15:33:25 +0800
In-Reply-To: <1589428872-29282-1-git-send-email-macpaul.lin@mediatek.com>
References: <1589428872-29282-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3929ED25672ED9116AC7BC7CCB30D4C22ADBA5D38237F4E1188FC580E959644C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTE0IGF0IDEyOjAxICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
V2hlbiByZWNlaXZpbmcgcmVzZXQgaW50ZXJydXB0LCBGQUREUiBuZWVkIHRvIGJlIHJlc2V0IHRv
IHplcm8gaW4NCj4gcGVyaXBoZWFybCBtb2RlLiBPdGhlcndpc2UgZXAwIGNhbm5vdCBkbyBlbnVt
ZXJhdGlvbiB3aGVuIHJlLXBsdWdpbmcgVVNCDQo+IGNhYmxlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL3VzYi9tdXNiL21lZGlhdGVrLmMgfCAgICA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL211c2IvbWVk
aWF0ZWsuYyBiL2RyaXZlcnMvdXNiL211c2IvbWVkaWF0ZWsuYw0KPiBpbmRleCA2MTk2YjBlLi5l
ZWJlYWRkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9tdXNiL21lZGlhdGVrLmMNCj4gKysr
IGIvZHJpdmVycy91c2IvbXVzYi9tZWRpYXRlay5jDQo+IEBAIC0yMDgsNiArMjA4LDEyIEBAIHN0
YXRpYyBpcnFyZXR1cm5fdCBnZW5lcmljX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpfX2hjaSkN
Cj4gIAltdXNiLT5pbnRfcnggPSBtdXNiX2NsZWFydyhtdXNiLT5tcmVncywgTVVTQl9JTlRSUlgp
Ow0KPiAgCW11c2ItPmludF90eCA9IG11c2JfY2xlYXJ3KG11c2ItPm1yZWdzLCBNVVNCX0lOVFJU
WCk7DQo+ICANCj4gKwlpZiAoKG11c2ItPmludF91c2IgJiBNVVNCX0lOVFJfUkVTRVQpICYmICFp
c19ob3N0X2FjdGl2ZShtdXNiKSkgew0KPiArCQkvKiBlcDAgRkFERFIgbXVzdCBiZSAwIHdoZW4g
KHJlKWVudGVyaW5nIHBlcmlwaGVyYWwgbW9kZSAqLw0KPiArCQltdXNiX2VwX3NlbGVjdChtdXNi
LT5tcmVncywgMCk7DQo+ICsJCW11c2Jfd3JpdGViKG11c2ItPm1yZWdzLCBNVVNCX0ZBRERSLCAw
KTsNCj4gKwl9DQo+ICsNCj4gIAlpZiAobXVzYi0+aW50X3VzYiB8fCBtdXNiLT5pbnRfdHggfHwg
bXVzYi0+aW50X3J4KQ0KPiAgCQlyZXR2YWwgPSBtdXNiX2ludGVycnVwdChtdXNiKTsNCj4gIA0K
DQpBY2tlZC1ieTpNaW4gR3VvIDxtaW4uZ3VvQG1lZGlhdGVrLmNvbT4NCg0K

