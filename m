Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CD6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A889720768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hALw+ltj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgF3H3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:29:24 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2851 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726943AbgF3H3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:29:24 -0400
X-UUID: bdfb1f422f734719ba678fd10bf1da45-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HAx+5BTPXfGNqdXAn2CnRwU8idpAgHvW4EJmH0eOK5s=;
        b=hALw+ltjvCgo8K/x7tJTs59w+VHEF1BeidKYbG+3dl16gCt4nF5/f+X3+aoZYd2nxcqrWle0FDoYIqIDtNXQqCaNLwwJk+SrF8+z4sgg6gB3/qRd+M6ebb8nciyv0bU/mC7oJM/WQ2YD0q6iJIVtLof9BCfu4/HkqN4ogCvrBCM=;
X-UUID: bdfb1f422f734719ba678fd10bf1da45-20200630
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 762714230; Tue, 30 Jun 2020 15:29:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Jun
 2020 15:29:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 15:29:17 +0800
Message-ID: <1593502139.23885.5.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] usb: mtu3: fix NULL pointer dereference
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Date:   Tue, 30 Jun 2020 15:28:59 +0800
In-Reply-To: <99fc1f6e-7907-6723-612a-8b68ffa871e5@web.de>
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
         <1593410434-19406-2-git-send-email-chunfeng.yun@mediatek.com>
         <99fc1f6e-7907-6723-612a-8b68ffa871e5@web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C01562A8C5541EC7257F9E298FE7512CE55EAEBA0420D98040392F23F24A9DAF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDEwOjAwICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gPiBTb21lIHBvaW50ZXJzIGFyZSBkZXJlZmVyZW5jZWQgYmVmb3JlIHN1Y2Nlc3NmdWwgY2hl
Y2tzLg0KPiANCj4gSSBzdWdnZXN0IHRvIHJlY29uc2lkZXIgYW5kIGltcHJvdmUgdGhlIGNoYW5n
ZSBkZXNjcmlwdGlvbi4NCj4gDQo+ICogV291bGQgYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2Ug
YmUgcG9zc2libGUgb25seSB3aXRoIHRoZSB2YXJpYWJsZXMg4oCcbWVw4oCdDQo+ICAgYW5kIOKA
nG1yZXHigJ0gaW4gdGhlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBmdW5jdGlvbiDigJxtdHUzX2dh
ZGdldF9kZXF1ZXVl4oCdPw0KPiANCj4gKiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGFkanVz
dCBhbnkgbW9yZSB2YXJpYWJsZSBpbml0aWFsaXNhdGlvbnM/DQpZZXMsIEknbGwgZG8gaXQgaWYg
bmVlZCwgdGhhbmtzDQoNCj4gDQo+ICogV2lsbCBpdCBiZWNvbWUgaGVscGZ1bCB0byBhZGQgdGhl
IHRhZyDigJxGaXhlc+KAnSB0byB0aGUgY29tbWl0IG1lc3NhZ2U/DQpNYXliZSBuZWVkbid0DQoN
Cj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQo=

