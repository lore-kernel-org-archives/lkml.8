Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2368AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB1920739
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HPwNJUBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGIHGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:06:07 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12609 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbgGIHGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:06:05 -0400
X-UUID: c11e3528d1124c2485795b03bf731af9-20200709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JCdqhnmOrA4bIemjU77tSTchJtgxF3g3bcC1iZfUepU=;
        b=HPwNJUBfC5mAmkq6ABB39yQCe3NGDKGEbk1VUPa9jI4VaCMy2mBj9KHePSK1DwEMtakTDttKta+WIGVOwIS9uxhjCM76+XHmLW0Sb44trDkjmf9/cTXZi4KPlG0DATBXHmAkmNRteq6fR8+05dKpcWPADMv3bWdlbNwS5im3p74=;
X-UUID: c11e3528d1124c2485795b03bf731af9-20200709
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 746041579; Thu, 09 Jul 2020 15:06:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Jul
 2020 15:05:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jul 2020 15:05:58 +0800
Message-ID: <1594278321.23885.26.camel@mhfsdcap03>
Subject: Re: [V2 PATCH] usb: mtu3: fix NULL pointer dereference
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 9 Jul 2020 15:05:21 +0800
In-Reply-To: <87lfjt6vjm.fsf@kernel.org>
References: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com>
         <87lfjt6vjm.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F3256F28A9F380161FC65DD621C2647F2BB492FBFB0CAC48B3BADA5C9B75167D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA3LTA5IGF0IDA5OjQwICswMzAwLCBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4g
PiBTb21lIHBvaW50ZXJzIGFyZSBkZXJlZmVyZW5jZWQgYmVmb3JlIHN1Y2Nlc3NmdWwgY2hlY2tz
Lg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3
ZWIuZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVk
aWF0ZWsuY29tPg0KPiANCj4gZG8geW91IG5lZWQgYSBGaXhlcyB0YWcgaGVyZT8gUGVyaGFwcyBh
IENjIHN0YWJsZSB0b28/DQpJdCB3aWxsIG5vdCBjYXVzZSBzb21lcyBpc3N1ZXMsIEkgdGhpbmsg
bm8gbmVlZCBhZGQgaXQuDQoNCkFjY29yZGluZyB0byBHcmVnJ3MgY29tbWVudCwgSSBndWVzcyBo
ZSBtZWFucyBubyBuZWVkIGNoZWNrIHRoZXNlDQpwb2ludGVycyBhdCBhbGwsIHNvIEknbGwgc2Vu
ZCBhIG5ldyB2ZXJzaW9uIHRvIHJlbW92ZSBjaGVja3MuDQoNClRoYW5rIHlvdQ0KDQo+IA0KDQo=

