Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809EC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81FA2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yje1cTAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgCPMQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:16:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21972 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730902AbgCPMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:16:44 -0400
X-UUID: ec2881c02c9f420c96da1362f9eb7070-20200316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rwQaVz2lOkNOsMwjmIb1LBzk1XQeJzfgIv8n7AqSQsM=;
        b=Yje1cTAemjks09evdCbLUcLJTTTPmwPS82EUaVkeXVtYFr7fQbtNvaruGZh9MHtlfVyjOmZnQ9FhYFQYNtNXP/hHGQsIuGHYXimhlwypLvoUbgocMF+Akv4L0HNaYOeB0voJplq74MdZQP1gDTeccss7PEJdZky7YRRDWKU4VrI=;
X-UUID: ec2881c02c9f420c96da1362f9eb7070-20200316
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1031916809; Mon, 16 Mar 2020 20:16:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Mar 2020 20:15:38 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Mar 2020 20:13:40 +0800
Message-ID: <1584360997.14769.1.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/1] dt-bindings: cpu: Add a support cpu type for
 cortex-a75
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 16 Mar 2020 20:16:37 +0800
In-Reply-To: <CANMq1KA1ngYhr7XO0k3xb0h7L-DX+TjiekvnGGOTRqz=BQPREA@mail.gmail.com>
References: <1584345050-3738-1-git-send-email-hanks.chen@mediatek.com>
         <CANMq1KA1ngYhr7XO0k3xb0h7L-DX+TjiekvnGGOTRqz=BQPREA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTE2IGF0IDE5OjAyICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDE2LCAyMDIwIGF0IDM6NTEgUE0gSGFua3MgQ2hlbiA8aGFua3MuY2hl
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIGFybSBjcHUgdHlwZSBjb3J0ZXgt
YTc1Lg0KPiANCj4gQWxyZWFkeSBpbiBSb2IncyB0cmVlIGhlcmU6DQo+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JvYmgvbGludXguZ2l0L2NvbW1pdC8/
aD1kdC9uZXh0JmlkPTVjMjYxNGU5OTVkZTA3YjQxZWIzNTUxNTVlYjVlMGUzZDU5MzcxOGINCj4g
DQpHb3QgaXQsIFRoYW5rcyBmb3IgcmV2aWV3aW5nIDopDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
YW5rcyBDaGVuIDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jcHVzLnlhbWwgfCAgICAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jcHVzLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbA0KPiA+IGluZGV4IGMyM2MyNGYu
LjUxYjc1ZjcgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9jcHVzLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL2NwdXMueWFtbA0KPiA+IEBAIC0xMjgsNiArMTI4LDcgQEAgcHJvcGVydGllczoN
Cj4gPiAgICAgICAgLSBhcm0sY29ydGV4LWE1Nw0KPiA+ICAgICAgICAtIGFybSxjb3J0ZXgtYTcy
DQo+ID4gICAgICAgIC0gYXJtLGNvcnRleC1hNzMNCj4gPiArICAgICAgLSBhcm0sY29ydGV4LWE3
NQ0KPiA+ICAgICAgICAtIGFybSxjb3J0ZXgtbTANCj4gPiAgICAgICAgLSBhcm0sY29ydGV4LW0w
Kw0KPiA+ICAgICAgICAtIGFybSxjb3J0ZXgtbTENCj4gPiAtLQ0KPiA+IDEuNy45LjUNCj4gPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IExpbnV4
LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiA+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW1lZGlhdGVrDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0
ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

