Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A21C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C37A20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y53ysHDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHUBxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:53:33 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33572 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725859AbgHUBxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:53:32 -0400
X-UUID: fda6d9ce0bbe4b7a92ed9bd87c58ef39-20200821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DNATBZmya/r8+01Q+rXYCbAj9lKFVgdL+QN+XzMD0nY=;
        b=Y53ysHDiVT91reZQ3uvOky6WNRgUX4jXYcPKPACSJ/MyzaoT5j4BnEa8d/N3RCaVtq0wKEXvZ7A3LzNhwIevE6So5Z2Xblt/F30WzqEA+Q4Ml4L3EPblzplX7OiASu8CUxHQXumpbERawI5l5jWetpmbaVpvV1YFooFeOppMuOI=;
X-UUID: fda6d9ce0bbe4b7a92ed9bd87c58ef39-20200821
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1128992780; Fri, 21 Aug 2020 09:53:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 Aug
 2020 09:53:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 21 Aug 2020 09:53:22 +0800
Message-ID: <1597974730.21253.4.camel@mhfsdcap03>
Subject: Re: [PATCH v2 09/11] usb: phy: phy-mv-usb: convert to
 readl_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Date:   Fri, 21 Aug 2020 09:52:10 +0800
In-Reply-To: <c28a906c-ed1a-8884-3016-b8664a313331@gmail.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
         <1597902349-8998-9-git-send-email-chunfeng.yun@mediatek.com>
         <c28a906c-ed1a-8884-3016-b8664a313331@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BFAD47B2BB6678131E731A333C4AC4201A6540906581AA4BE044CDB55F7722AC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTIwIGF0IDEzOjE3ICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IE9uIDIwLjA4LjIwMjAgODo0NSwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiANCj4gPiBVc2Ug
cmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYygpIHRvIHNpbXBsaWZ5IGNvZGUNCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gdjI6IHVkZWxheSAxMHVzIGluc3RlYWQgb2YgMjB1cyBhY2NvcmRpbmcgdG8g
a2VybmVsZG9jDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3VzYi9waHkvcGh5LW12LXVzYi5jIHwg
MTYgKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvcGh5
L3BoeS1tdi11c2IuYyBiL2RyaXZlcnMvdXNiL3BoeS9waHktbXYtdXNiLmMNCj4gPiBpbmRleCBj
ZTc2N2VjLi5lODAxNTY5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL3BoeS9waHktbXYt
dXNiLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9waHkvcGh5LW12LXVzYi5jDQo+ID4gQEAgLTgs
NiArOCw3IEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICAjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4N
Cj4gPiAgICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9w
cm9jX2ZzLmg+DQo+ID4gQEAgLTEzNSw4ICsxMzYsOCBAQCBzdGF0aWMgaW50IG12X290Z19zZXRf
dGltZXIoc3RydWN0IG12X290ZyAqbXZvdGcsIHVuc2lnbmVkIGludCBpZCwNCj4gPiAgIA0KPiA+
ICAgc3RhdGljIGludCBtdl9vdGdfcmVzZXQoc3RydWN0IG12X290ZyAqbXZvdGcpDQo+ID4gICB7
DQo+ID4gLQl1bnNpZ25lZCBpbnQgbG9vcHM7DQo+ID4gICAJdTMyIHRtcDsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gICANCj4gPiAgIAkvKiBTdG9wIHRoZSBjb250cm9sbGVyICovDQo+ID4gICAJdG1w
ID0gcmVhZGwoJm12b3RnLT5vcF9yZWdzLT51c2JjbWQpOw0KPiA+IEBAIC0xNDYsMTUgKzE0Nywx
MiBAQCBzdGF0aWMgaW50IG12X290Z19yZXNldChzdHJ1Y3QgbXZfb3RnICptdm90ZykNCj4gPiAg
IAkvKiBSZXNldCB0aGUgY29udHJvbGxlciB0byBnZXQgZGVmYXVsdCB2YWx1ZXMgKi8NCj4gPiAg
IAl3cml0ZWwoVVNCQ01EX0NUUkxfUkVTRVQsICZtdm90Zy0+b3BfcmVncy0+dXNiY21kKTsNCj4g
PiAgIA0KPiA+IC0JbG9vcHMgPSA1MDA7DQo+ID4gLQl3aGlsZSAocmVhZGwoJm12b3RnLT5vcF9y
ZWdzLT51c2JjbWQpICYgVVNCQ01EX0NUUkxfUkVTRVQpIHsNCj4gPiAtCQlpZiAobG9vcHMgPT0g
MCkgew0KPiA+IC0JCQlkZXZfZXJyKCZtdm90Zy0+cGRldi0+ZGV2LA0KPiA+ICsJcmV0ID0gcmVh
ZGxfcG9sbF90aW1lb3V0X2F0b21pYygmbXZvdGctPm9wX3JlZ3MtPnVzYmNtZCwgdG1wLA0KPiA+
ICsJCQkJKHRtcCAmIFVTQkNNRF9DVFJMX1JFU0VUKSwgMTAsIDEwMDAwKTsNCj4gPiArCWlmIChy
ZXQgPCAwKSB7DQo+ID4gKwkJZGV2X2VycigmbXZvdGctPnBkZXYtPmRldiwNCj4gPiAgIAkJCQki
V2FpdCBmb3IgUkVTRVQgY29tcGxldGVkIFRJTUVPVVRcbiIpOw0KPiANCj4gICAgIFlvdSBmb3Jn
b3QgdG8gcmUtYWxpZ24gdGhpcyBhcmd1bWVudCwgaXQgc2hvdWxkIHN0YXJ0IHVuZGVyICYgb24g
dGhlIA0KPiBwcmV2aW91cyBsaW5lLi4uDQpZZXMsIHdpbGwgZml4IGl0LCB0aGFua3MNCg0KPiAN
Cj4gWy4uLl0NCj4gDQo+IE1CUiwgU2VyZ2VpDQoNCg==

