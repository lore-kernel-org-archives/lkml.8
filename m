Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B162070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z51hqa03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgFRKm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:42:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30235 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727114AbgFRKmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:42:23 -0400
X-UUID: 9b5abe8c3c9c4a61be1627a91e7385d6-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XTee4WTWk0GsYS5TUaH3YIhRLs7IDEHM/OwJ8rQWt2g=;
        b=Z51hqa03zT5yChmzBm6m/tyFizYkGtGB0s/UjTta8SdT9CinSB40REBN1Cg3ElhI6q9EwDsPrz/fPE3q0BfgBHLtP9TbvFwO2aL6YDXMOY4vtSvCFx+oAb7qyYHsm1yZNwvDKJzjQTor4XpDLBsI0Gz3PBXYRaOaU9V7c1OF26o=;
X-UUID: 9b5abe8c3c9c4a61be1627a91e7385d6-20200618
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 404080360; Thu, 18 Jun 2020 18:42:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 18:42:15 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 18:42:14 +0800
Message-ID: <1592476935.32278.2.camel@mtkswgap22>
Subject: Re: [PATCH] clk: mediatek: Remove ifr{0,1}_cfg_regs structures
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Owen Chen <owen.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        "kbuild test robot" <lkp@intel.com>
Date:   Thu, 18 Jun 2020 18:42:15 +0800
In-Reply-To: <20200609211847.27366-1-sboyd@kernel.org>
References: <20200609211847.27366-1-sboyd@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BC5186872D0807A0D678B76395CFEA1D33760DAC6FCF3F36C30BD9251BB57B732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTA5IGF0IDE0OjE4IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFRoZXNlIGFyZW4ndCB1c2VkIGFuZCB0aGUgbWFjcm9zIHRoYXQgcmVmZXJlbmNlIHRoZW0gYXJl
bid0IHVzZWQgZWl0aGVyLg0KPiBSZW1vdmUgdGhlIGRlYWQgY29kZSB0byBhdm9pZCBjb21waWxl
IHdhcm5pbmdzLg0KPiANCj4gQ2M6IE93ZW4gQ2hlbiA8b3dlbi5jaGVuQG1lZGlhdGVrLmNvbT4N
Cj4gQ2M6IE1hcnMgQ2hlbmcgPG1hcnMuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiBDYzogTWFjcGF1
bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCj4gRml4ZXM6IDFhY2E5OTM5YmY3MiAo
ImNsazogbWVkaWF0ZWs6IEFkZCBNVDY3NjUgY2xvY2sgc3VwcG9ydCIpDQo+IFJlcG9ydGVkLWJ5
OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Rl
cGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdDY3NjUuYyB8IDMwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDMwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NjUuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dDY3NjUuYw0KPiBpbmRleCAzZWM1M2NiNjJlY2UuLmRiOGRiMWIzYjc5ZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDY3NjUuYw0KPiBAQCAtNTM0LDE4ICs1MzQsNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19nYXRlIHRvcF9jbGtzW10gPSB7DQo+ICAJR0FURV9UT1AyKENMS19UT1Bf
QVBMTDEyX0RJVjMsICJhcGxsMTJfZGl2MyIsICJhdWRfMV9jayIsIDUpLA0KPiAgfTsNCj4gIA0K
PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIGlmcjBfY2dfcmVncyA9IHsNCj4g
LQkuc2V0X29mcyA9IDB4MjAwLA0KPiAtCS5jbHJfb2ZzID0gMHgyMDAsDQo+IC0JLnN0YV9vZnMg
PSAweDIwMCwNCj4gLX07DQo+IC0NCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVn
cyBpZnIxX2NnX3JlZ3MgPSB7DQo+IC0JLnNldF9vZnMgPSAweDc0LA0KPiAtCS5jbHJfb2ZzID0g
MHg3NCwNCj4gLQkuc3RhX29mcyA9IDB4NzQsDQo+IC19Ow0KPiAtDQo+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19nYXRlX3JlZ3MgaWZyMl9jZ19yZWdzID0gew0KPiAgCS5zZXRfb2ZzID0gMHg4
MCwNCj4gIAkuY2xyX29mcyA9IDB4ODQsDQo+IEBAIC01NzAsMjQgKzU1OCw2IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBpZnI1X2NnX3JlZ3MgPSB7DQo+ICAJLnN0YV9vZnMg
PSAweGM4LA0KPiAgfTsNCj4gIA0KPiAtI2RlZmluZSBHQVRFX0lGUjAoX2lkLCBfbmFtZSwgX3Bh
cmVudCwgX3NoaWZ0KSB7CVwNCj4gLQkJLmlkID0gX2lkLAkJCQlcDQo+IC0JCS5uYW1lID0gX25h
bWUsCQkJCVwNCj4gLQkJLnBhcmVudF9uYW1lID0gX3BhcmVudCwJCQlcDQo+IC0JCS5yZWdzID0g
JmlmcjBfY2dfcmVncywJCQlcDQo+IC0JCS5zaGlmdCA9IF9zaGlmdCwJCQlcDQo+IC0JCS5vcHMg
PSAmbXRrX2Nsa19nYXRlX29wc19ub19zZXRjbHJfaW52LAlcDQo+IC0JfQ0KPiAtDQo+IC0jZGVm
aW5lIEdBVEVfSUZSMShfaWQsIF9uYW1lLCBfcGFyZW50LCBfc2hpZnQpIHsJXA0KPiAtCQkuaWQg
PSBfaWQsCQkJCVwNCj4gLQkJLm5hbWUgPSBfbmFtZSwJCQkJXA0KPiAtCQkucGFyZW50X25hbWUg
PSBfcGFyZW50LAkJCVwNCj4gLQkJLnJlZ3MgPSAmaWZyMV9jZ19yZWdzLAkJCVwNCj4gLQkJLnNo
aWZ0ID0gX3NoaWZ0LAkJCVwNCj4gLQkJLm9wcyA9ICZtdGtfY2xrX2dhdGVfb3BzX25vX3NldGNs
ciwJXA0KPiAtCX0NCj4gLQ0KPiAgI2RlZmluZSBHQVRFX0lGUjIoX2lkLCBfbmFtZSwgX3BhcmVu
dCwgX3NoaWZ0KSB7CVwNCj4gIAkJLmlkID0gX2lkLAkJCQlcDQo+ICAJCS5uYW1lID0gX25hbWUs
CQkJCVwNCg0KVGhhbmsgeW91IHNvIG11Y2ghDQpPd2VuIGFuZCBJIHdlcmUgYnVzeSBpbiBvdGhl
ciBpc3N1ZXMgaGVuY2UgY2Fubm90IGhlbHAgZml4IHRoaXMgaXNzdWUNCmluIHRpbWUuDQoNClRo
YW5rcyBhIGxvdCENCkJSLA0KTWFjcGF1bCBMaW4NCg==

