Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3CC206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n6Sz4IPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgENHDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:03:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:11775 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbgENHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:03:54 -0400
X-UUID: fcb38e2b35a447638b004c071c864383-20200514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dUbZ4h/pak8n0CVkjJFglNd+gPQf1JMPki21rpI0rB4=;
        b=n6Sz4IPkrLAZYE/pA3143h6ZlgvdagIG5IWiBhuXBr2jSZQ0o9lfvwDsWcZPlVKmdw5ECq7EKIpCvIQo4zlnPcc7TX1xiZJM1S/sztzUFj9mdZb+Hvs9rHb5kXAVyEqKVr8nIigjGoEfef0duvVSuwaojy+NweWy+8kvQ9esy2c=;
X-UUID: fcb38e2b35a447638b004c071c864383-20200514
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1275437998; Thu, 14 May 2020 15:03:42 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 May
 2020 15:03:41 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 May 2020 15:03:41 +0800
Message-ID: <1589439742.5899.2.camel@mhfsdcap03>
Subject: Re: [PATCH V3 6/8] phy: tegra: xusb: Add support for charger detect
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 14 May 2020 15:02:22 +0800
In-Reply-To: <1589437363-16727-7-git-send-email-nkristam@nvidia.com>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
         <1589437363-16727-7-git-send-email-nkristam@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 630653DF28017AEEC4A91D6B8F0C31D2D6B4094032B02BF0A5F4434F43D9BF9A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTE0IGF0IDExOjUyICswNTMwLCBOYWdhcmp1bmEgS3Jpc3RhbSB3cm90
ZToNCj4gUGVyZm9ybSBjaGFyZ2VyLWRldGVjdCBvcGVyYXRpb24gaWYgY29ycmVzcG9uZGluZyBk
dCBwcm9wZXJ0eSBpcyBlbmFibGVkLg0KPiBVcGRhdGUgdXNiLXBoeSB3aXRoIHRoZSBkZXRlY3Rl
ZCBjaGFyZ2VyIHN0YXRlIGFuZCBtYXggY3VycmVudCB2YWx1ZXMuDQo+IFJlZ2lzdGVyIGNoYXJn
ZXItZGV0ZWN0IEFQSSdzIG9mIHVzYi1waHkgdG8gcHJvdmlkZSBuZWVkZWQgZnVuY3Rpb25hbGl0
aWVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmFnYXJqdW5hIEtyaXN0YW0gPG5rcmlzdGFtQG52
aWRpYS5jb20+DQo+IC0tLQ0KPiBWMzoNCj4gIC0gQWxsaWdoZWQgZnVuY3Rpb25zIGFuZCBpdHMg
YXJndW1lbnRzLg0KPiAgLSByZXBsYWNlZCBzcGFjZWQgYnkgdGFicyBmb3IgTUFDUk8gZGVmaW5p
dGlvbiBhbGxpZ25tZW50cy4NCj4gIC0gVW5pZmllZCBwcmltYXJ5IGFuZCBzZWNvbmRhcnkgY2hh
cmdlciBkZXRlY3QgQVBJJ3MuDQo+ICAtIFVzZWQgcmVhZGxfcG9sbF90aW1lb3V0IGluc3RlYWQg
b2Ygd2hpbGUgbG9vcCBjb25kaXRpb24gY2hlY2sgZm9yIHJlZ2lzdGVyLg0KPiAgLSBGaXhlZCBv
dGhlciBjb21tZW50cyBhcyBwZXIgaW5wdXRzIGZyb20gVGhpZXJyeS4NCj4gLS0tDQo+IFYyOg0K
PiAgLSBQYXRjaCByZS1iYXNlZC4NCj4gLS0tDQo+ICBkcml2ZXJzL3BoeS90ZWdyYS9NYWtlZmls
ZSB8ICAgMiArLQ0KPiAgZHJpdmVycy9waHkvdGVncmEvY2QuYyAgICAgfCAyODMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3BoeS90ZWdy
YS94dXNiLmMgICB8ICA4MCArKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3BoeS90ZWdyYS94dXNi
LmggICB8ICAgNyArKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzNzEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L3RlZ3JhL2NkLmMN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS90ZWdyYS9NYWtlZmlsZSBiL2RyaXZlcnMv
cGh5L3RlZ3JhL01ha2VmaWxlDQo+IGluZGV4IDg5Yjg0MDYuLmJlZmRmYzQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvcGh5L3RlZ3JhL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvcGh5L3RlZ3Jh
L01ha2VmaWxlDQo+IEBAIC0xLDcgKzEsNyBAQA0KPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vbmx5DQo+ICBvYmotJChDT05GSUdfUEhZX1RFR1JBX1hVU0IpICs9IHBoeS10
ZWdyYS14dXNiLm8NCj4gIA0KPiAtcGh5LXRlZ3JhLXh1c2IteSArPSB4dXNiLm8NCj4gK3BoeS10
ZWdyYS14dXNiLXkgKz0geHVzYi5vIGNkLm8NCj4gIHBoeS10ZWdyYS14dXNiLSQoQ09ORklHX0FS
Q0hfVEVHUkFfMTI0X1NPQykgKz0geHVzYi10ZWdyYTEyNC5vDQo+ICBwaHktdGVncmEteHVzYi0k
KENPTkZJR19BUkNIX1RFR1JBXzEzMl9TT0MpICs9IHh1c2ItdGVncmExMjQubw0KPiAgcGh5LXRl
Z3JhLXh1c2ItJChDT05GSUdfQVJDSF9URUdSQV8yMTBfU09DKSArPSB4dXNiLXRlZ3JhMjEwLm8N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3RlZ3JhL2NkLmMgYi9kcml2ZXJzL3BoeS90ZWdy
YS9jZC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAuLmZkZGJlNGMN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3BoeS90ZWdyYS9jZC5jDQo+IEBAIC0w
LDAgKzEsMjgzIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAr
LyoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyMCwgTlZJRElBIENPUlBPUkFUSU9OLiAgQWxsIHJp
Z2h0cyByZXNlcnZlZC4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9waHkvcGh5Lmg+DQo+ICsNCj4gKyNpbmNsdWRlICJ4dXNiLmgiDQo+ICsNCj4gKy8qIERh
dGEgY29udGFjdCBkZXRlY3Rpb24gdGltZW91dCAqLw0KPiArI2RlZmluZSBURENEX1RJTUVPVVRf
TVMJCQkJNDAwDQo+ICsNCj4gKyNkZWZpbmUgVVNCMl9CQVRURVJZX0NIUkdfT1RHUEFEWF9DVEww
KHgpCSgweDgwICsgKHgpICogMHg0MCkNCj4gKyNkZWZpbmUgIFBEX0NIRwkJCQkJKDEgPDwgMCkN
Cj4gKyNkZWZpbmUgIFZEQ0RfREVUX0ZJTFRFUl9FTgkJCSgxIDw8IDQpDQo+ICsjZGVmaW5lICBW
REFUX0RFVAkJCQkoMSA8PCA1KQ0KPiArI2RlZmluZSAgVkRBVF9ERVRfRklMVEVSX0VOCQkJKDEg
PDwgOCkNCj4gKyNkZWZpbmUgIE9QX1NJTktfRU4JCQkJKDEgPDwgOSkNCj4gKyNkZWZpbmUgIE9Q
X1NSQ19FTgkJCQkoMSA8PCAxMCkNCj4gKyNkZWZpbmUgIE9OX1NJTktfRU4JCQkJKDEgPDwgMTEp
DQo+ICsjZGVmaW5lICBPTl9TUkNfRU4JCQkJKDEgPDwgMTIpDQo+ICsjZGVmaW5lICBPUF9JX1NS
Q19FTgkJCQkoMSA8PCAxMykNCj4gKyNkZWZpbmUgIFpJUF9GSUxURVJfRU4JCQkJKDEgPDwgMjEp
DQo+ICsjZGVmaW5lICBaSU5fRklMVEVSX0VOCQkJCSgxIDw8IDI1KQ0KPiArI2RlZmluZSAgRENE
X0RFVEVDVEVECQkJCSgxIDw8IDI2KQ0KVXNlIEJJVCgpID8NCj4gKw0KPiArI2RlZmluZSBVU0Iy
X0JBVFRFUllfQ0hSR19PVEdQQURYX0NUTDEoeCkJKDB4ODQgKyAoeCkgKiAweDQwKQ0KPiArI2Rl
ZmluZSAgUERfVlJFRwkJCQkoMSA8PCA2KQ0KPiArI2RlZmluZSAgVlJFR19MRVYoeCkJCQkJKCgo
eCkgJiAweDMpIDw8IDcpDQo+ICsjZGVmaW5lICBWUkVHX0RJUih4KQkJCQkoKCh4KSAmIDB4Mykg
PDwgMTEpDQo+ICsjZGVmaW5lICBWUkVHX0RJUl9JTgkJCQlWUkVHX0RJUigxKQ0KPiArI2RlZmlu
ZSAgVlJFR19ESVJfT1VUCQkJCVZSRUdfRElSKDIpDQo+ICsjZGVmaW5lICBVU0JPUF9SUERfT1ZS
RAkJCQkoMSA8PCAxNikNCj4gKyNkZWZpbmUgIFVTQk9QX1JQRF9PVlJEX1ZBTAkJCSgxIDw8IDE3
KQ0KPiArI2RlZmluZSAgVVNCT1BfUlBVX09WUkQJCQkJKDEgPDwgMTgpDQo+ICsjZGVmaW5lICBV
U0JPUF9SUFVfT1ZSRF9WQUwJCQkoMSA8PCAxOSkNCj4gKyNkZWZpbmUgIFVTQk9OX1JQRF9PVlJE
CQkJCSgxIDw8IDIwKQ0KPiArI2RlZmluZSAgVVNCT05fUlBEX09WUkRfVkFMCQkJKDEgPDwgMjEp
DQo+ICsjZGVmaW5lICBVU0JPTl9SUFVfT1ZSRAkJCQkoMSA8PCAyMikNCj4gKyNkZWZpbmUgIFVT
Qk9OX1JQVV9PVlJEX1ZBTAkJCSgxIDw8IDIzKQ0KPiArDQo+ICsjZGVmaW5lIFhVU0JfUEFEQ1RM
X1VTQjJfT1RHX1BBRFhfQ1RMMCh4KQkoMHg4OCArICh4KSAqIDB4NDApDQo+ICsjZGVmaW5lICBV
U0IyX09UR19QRDIJCQkJKDEgPDwgMjcpDQo+ICsjZGVmaW5lICBVU0IyX09UR19QRDJfT1ZSRF9F
TgkJCSgxIDw8IDI4KQ0KPiArI2RlZmluZSAgVVNCMl9PVEdfUERfWkkJCQkJKDEgPDwgMjkpDQo+
ICsNCj4gKyNkZWZpbmUgWFVTQl9QQURDVExfVVNCMl9CQVRURVJZX0NIUkdfVERDRF9EQk5DX1RJ
TUVSXzAgKDB4MjgwKQ0KPiArI2RlZmluZSAgIFREQ0RfREJOQyh4KQkJCQkoKCh4KSAmIDB4N2Zm
KSA8PCAwKQ0KPiArDQo+ICtzdGF0aWMgdm9pZA0KPiArdGVncmFfeHVzYl9wYWRjdGxfc2V0X2Rl
Ym91bmNlX3RpbWUoc3RydWN0IHRlZ3JhX3h1c2JfcGFkY3RsICpwYWRjdGwsDQo+ICsJCQkJICAg
IHUzMiBkZWJvdW5jZSkNCg0K

