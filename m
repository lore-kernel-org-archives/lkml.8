Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4614CC3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2062C20679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G+b/Ifdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgBQKPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:15:24 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59774 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728942AbgBQKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:15:23 -0500
X-UUID: 42c1b312a6e94496981f5328d2733f1a-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ABI0N2j/Jh+drizYMIhvk5l8R+23rLL1RNKJu4e6TbI=;
        b=G+b/IfdwcG3M8LNEPiHJAT5OhXWEJsTb08T16n0eZiJnYalDcqUirVFDMgpUxjL4aOVuSxItbkeWmV8Br9pdESUwUaPsik++imSBJfsgqJK9wCrYYj1hs9dM/+QJU0k1Xc4jQ7RVZxjKwKA+3uFKqkZgovD92Nv2XIbHxHBbvM4=;
X-UUID: 42c1b312a6e94496981f5328d2733f1a-20200217
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.liang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1977825806; Mon, 17 Feb 2020 18:15:15 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Feb
 2020 18:11:01 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 18:14:35 +0800
Message-ID: <1581934493.27500.4.camel@mhfsdcap03>
Subject: Re: [PATCH 1/1] amr64: dts: modify mt8183.dtsi
From:   Yong Liang <yong.liang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Feb 2020 18:14:53 +0800
In-Reply-To: <b0345cfc-0e7c-65a8-5ff3-ea064b6c8905@gmail.com>
References: <Add watchdog device node>
         <20200217081922.22544-1-yong.liang@mediatek.com>
         <20200217081922.22544-2-yong.liang@mediatek.com>
         <b0345cfc-0e7c-65a8-5ff3-ea064b6c8905@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C869A12EC30298FAB5FD83CF057EFEA45400B4271D34EE09E02F69FD808CD1172000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTE3IGF0IDE4OjA1ICswODAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTcvMDIvMjAyMCAwOToxOSwgWW9uZyBMaWFuZyB3cm90ZToNCj4gPiBGcm9t
OiAieW9uZy5saWFuZyIgPHlvbmcubGlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCB3
YXRjaGRvZyBkZXZpY2Ugbm9kZQ0KPiA+IERvY3VtZW50IGJhc2Ugb24gaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIwMjAtSmFudWFyeS8wMjY0MTUu
aHRtbA0KPiA+IA0KPiANCj4gQ29tbWl0IG1lc3NhZ2Ugc2hvdWxkbid0IGNvbnRhaW4gbGlua3Mg
dG8gdGhlIG1haWxpbmdsaXN0IHRoaXMgaXMgYWRkaXRpb25hbA0KPiBpbmZvcm1hdGlvbiBqdXN0
IGZvciByZXZpZXcgYW5kIHNob3VsZCBnbyBhZnRlciAnLS0tJw0KPiANCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogeW9uZy5saWFuZyA8eW9uZy5saWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
IA0KPiBOZXh0IHRpbWUgcGxlYXNlIHB1dCByZWZlcmVuY2UgdG8gc2VyaWVzIHlvdXIgcGF0Y2hl
cyBhcmUgYmFzZWQgb24gaGVyZSA6KQ0KPiANCj4gSSBmaXhlZCB0aGUgY29tbWl0IG1lc3NhZ2Ug
KHRoZSBzdWJqZWN0IHdhc24ndCByZWFsbHkgdXNlZnVsbCwgSSBmaXhlZCB0aGF0IHRvbykNCj4g
YW5kIHB1c2hlZCBpdCB0byB2NS42LW5leHQvZHRzNjQNCj4gDQo+IFRoYW5rcywNCj4gTWF0dGhp
YXMNCg0KICBIaSBNYXR0aGlhczoNCiAgICAgU28gdGhpcyBwYXRjaCBjb25maXJtZCB0byBiZSBt
ZXJnZWQ/DQogICAgIFRoYW5zayB5b3UgdmVyeSBtdWNoIQ0KPiANCj4gPiAgYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE4My5kdHNpDQo+ID4gaW5kZXggMTBiMzI0NzFiYzdiLi44YjU5ZTBlYmEyZWIgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCj4gPiBA
QCAtMjUzLDYgKzI1MywxMyBAQA0KPiA+ICAJCQkjaW50ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiA+
ICAJCX07DQo+ID4gIA0KPiA+ICsJCXdhdGNoZG9nOiB3YXRjaGRvZ0AxMDAwNzAwMCB7DQo+ID4g
KwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXdkdCIsDQo+ID4gKwkJCQkgICAgICJt
ZWRpYXRlayxtdDY1ODktd2R0IjsNCj4gPiArCQkJcmVnID0gPDAgMHgxMDAwNzAwMCAwIDB4MTAw
PjsNCj4gPiArCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICAJ
CWFwbWl4ZWRzeXM6IHN5c2NvbkAxMDAwYzAwMCB7DQo+ID4gIAkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTgzLWFwbWl4ZWRzeXMiLCAic3lzY29uIjsNCj4gPiAgCQkJcmVnID0gPDAgMHgx
MDAwYzAwMCAwIDB4MTAwMD47DQo+ID4gDQoNCg==

