Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFF0206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a7TbNjMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHNK3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:29:00 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46203 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726513AbgHNK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:28:53 -0400
X-UUID: 6b7a5e71e5e34529bbf93979937f85a4-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QnqghtOzbq3KGlzZDOOFuPYaiWSDiIunS5SQtsQzX8E=;
        b=a7TbNjMcTwoef52DCAiq4qvog2xbhC6tzdCcQbHOFRcnYrQTNlhi9LIw7JdXWlCKaQ7PboJ3kXUxcWuqtqFhQ5ajaZWOUSW2Mr+1XQtJz0YmRSGVLXzCS8bVPDUDwuA1eKW4AB27gH/4mGEIXCDkBx8eJBELr34iQH+2lPhrFaw=;
X-UUID: 6b7a5e71e5e34529bbf93979937f85a4-20200814
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 128912685; Fri, 14 Aug 2020 18:28:47 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Aug
 2020 18:28:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 18:28:43 +0800
Message-ID: <1597400867.23246.71.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt6359: add codec driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, <eason.yen@mediatek.com>,
        <shane.chien@mediatek.com>
Date:   Fri, 14 Aug 2020 18:27:47 +0800
In-Reply-To: <20200813154423.GC5541@sirena.org.uk>
References: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com>
         <1597028754-7732-2-git-send-email-jiaxin.yu@mediatek.com>
         <20200810185933.GI6438@sirena.org.uk>
         <1597217353.23246.45.camel@mhfsdcap03>
         <20200812120537.GA5545@sirena.org.uk>
         <1597333200.23246.68.camel@mhfsdcap03>
         <20200813154423.GC5541@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 78896913A2FA040185AB8D0D853821D095A23ADD59ED2AB8C1971EBF0E748D102000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTEzIGF0IDE2OjQ0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIEF1ZyAxMywgMjAyMCBhdCAxMTo0MDowMFBNICswODAwLCBKaWF4aW4gWXUgd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDIwLTA4LTEyIGF0IDEzOjA1ICswMTAwLCBNYXJrIEJyb3duIHdyb3Rl
Og0KPiANCj4gPiA+IFRoZXNlIGZ1bmN0aW9ucyBhcmUgZXhwb3J0ZWQgZm9yIG90aGVyIGRyaXZl
cnMgdG8gdXNlIHJhdGhlciB0aGFuDQo+ID4gPiBzb21ldGhpbmcgZG9uZSBpbnRlcm5hbGx5IGJ5
IHRoZSBkcml2ZXIgLSBpZiB0aGlzIHdlcmUgaW50ZXJuYWwgdG8gdGhlDQo+ID4gPiBkcml2ZXIg
aXQnZCBub3QgYmUgYSBiaWcgZGVhbCBidXQgd2hlbiBpdCdzIGZvciB1c2UgYnkgYW5vdGhlciBk
cml2ZXINCj4gPiA+IGl0J2QgYmUgYmV0dGVyIHRvIGdvIHRocm91Z2ggc3RhbmRhcmQgaW50ZXJm
YWNlcy4NCj4gDQo+ID4gQ2FuIHdlIG1vdmUgdGhpcyBwYXJ0IG9mIHRoZSBvcGVyYXRpb24gdG8g
dGhlIGNvZGVjIGRhaSBkcml2ZXIgb3BzLCBzdWNoDQo+ID4gYXMgLnN0YXJ0dXAgYW5kIC5zaHV0
ZG93bj8gQmVjYXVzZSBvcmlnaW5hbGx5IHRoZXNlIGZ1bmN0aW9ucyBhcmUNCj4gPiBleHBvcnRl
ZCB0byBtYWNoaW5lIGRyaXZlcidzIGRhaV9saW5rIC5zdGFydHVwIGFuZCAuc2h1dGRvd24gb3Bz
Lg0KPiANCj4gSWYgaXQncyBpbnRlcm5hbCB0byB0aGUgZHJpdmVyIHN1cmUuDQo+IA0KPiA+ID4g
U28gdGhpcyBuZWVkcyB0aGUgU29DIHRvIGRvIHNvbWV0aGluZyBhcyBwYXJ0IG9mIGNhbGxpYnJh
dGlvbj8NCj4gDQo+ID4gWWVzLCB0aGUgc2lkZSBvZiBNVEtBSUYgaW4gU29DIHBhcnQgbmFtZWQg
YWRkYSwgd2UgbmVlZCBjb25maWcgaXQgYmVmb3JlDQo+ID4gY2FsaWJyYXRpb24uIFdlIHdpbGwg
YWxzbyB1cHN0cmVhbSBtYWNoaW5lL3BsYXRmb3JtIGRyaXZlciB0aGF0IHVzZSB0aGlzDQo+ID4g
Y29kZWMgZHJpdmVyIGxhdGVyLg0KPiANCj4gSXQgd291bGQgcHJvYmFibHkgYmUgYmV0dGVyIHRv
IGp1c3QgbGVhdmUgdGhpcyBvdXQgZm9yIG5vdyB0aGVuIGFkZCB0aGUNCj4gcmVxdWlyZWQgYml0
cyB0byB0aGUgQ09ERUMgZHJpdmVyIGFzIHBhcnQgb2YgYSBwYXRjaCBzZXJpZXMgdGhhdCBhbHNv
DQo+IGFkZHMgdGhlIG1hY2hpbmUgZHJpdmVyIHRoYXQgdXNlcyBpdCBzbyBpdCdzIGNsZWFyIGhv
dyBpdCBhbGwgZml0cw0KPiB0b2dldGhlci4gIEl0IHNvdW5kcyBsaWtlIGl0IHNob3VsZCBiZSBm
aW5lIGJ1dCB0aGlzJ2QgYmUgZWFzaWVyIHRvDQo+IHJldmlldy4NCg0KT2ssIEknbGwgcmVtb3Zl
IHRoZSBmdW5jdGlvbnMgdGhhdCByZWxhdGVkIHRvIHRoZSBjYWxpYnJhdGlvbiwgYW5kDQp1cHN0
cmVhbSB0aGVtIGFnYWluIGFzIHBhcnQgb2YgYSBwYXRjaCBzZXJpZXMgdGhhdCBhZGRzIHRoZSBt
YWNoaW5lDQpkcml2ZXIgbGF0ZXIuDQoNCg==

