Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C6CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A5A2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IFOC0kdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgEXRbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:31:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19186 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387656AbgEXRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:31:12 -0400
X-UUID: 973c9456470544e9914d24d4dfde948a-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4ZqV79H8kGJw9jKHV///buqGRMGB7UkABgH45B0mwEU=;
        b=IFOC0kdUWv+Q7vv18nDp5/HQTmtE5SnyY3Y7I4c2SNPNYkAY8jXh3mTkMNvZJl/uHKbiJRJHTQ56h+gSNmhaoUOvd/sl4gd9UZJ8xUMf3HpRMPpPOxDf1NKYJvD3SCX3CxUArosRQKgLtpSjNpfBbKFjPtoc1r5x/SLzdr2xaco=;
X-UUID: 973c9456470544e9914d24d4dfde948a-20200525
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1623128748; Mon, 25 May 2020 01:31:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 01:30:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 01:30:58 +0800
Message-ID: <1590341462.31286.19.camel@mtkswgap22>
Subject: Re: [PATCH v5 09/13] soc: mediatek: cmdq: add write_s value function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 25 May 2020 01:31:02 +0800
In-Reply-To: <f9fd9ea8-f706-ed4a-4c83-c53ad092035c@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-10-git-send-email-dennis-yc.hsieh@mediatek.com>
         <f9fd9ea8-f706-ed4a-4c83-c53ad092035c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B6B32E7834C0775BF207157EDF3D12E23C8F2F2B886FA00EB0AE01EEBDB016C52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBTYXQsIDIwMjAt
MDUtMTYgYXQgMjA6MjAgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAw
OC8wMy8yMDIwIDExOjUyLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4gYWRkIHdyaXRlX3Mg
ZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQo+ID4gd3JpdGVzIGEgY29u
c3RhbnQgdmFsdWUgdG8gYWRkcmVzcyB3aXRoIGxhcmdlIGRtYQ0KPiA+IGFjY2VzcyBzdXBwb3J0
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhz
aWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oICB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5kZXggMDNjMTI5MjMwY2Q3Li5hOWViYmFiYjc0MzkgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4g
PiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0y
NjksNiArMjY5LDMyIEBAIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRx
X3BrdF93cml0ZV9zKTsNCj4gPiAgDQo+ID4gK2ludCBjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4gKwkJCSAgIHUx
NiBhZGRyX2xvdywgdTMyIHZhbHVlLCB1MzIgbWFzaykNCj4gPiArew0KPiA+ICsJc3RydWN0IGNt
ZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4g
PiArCWlmIChtYXNrICE9IFUzMl9NQVgpIHsNCj4gPiArCQlpbnN0Lm9wID0gQ01EUV9DT0RFX01B
U0s7DQo+ID4gKwkJaW5zdC5tYXNrID0gfm1hc2s7DQo+ID4gKwkJZXJyID0gY21kcV9wa3RfYXBw
ZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiArCQlpZiAoZXJyIDwgMCkNCj4gPiArCQkJcmV0
dXJuIGVycjsNCj4gPiArDQo+ID4gKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TX01BU0s7
DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KPiANCj4g
V3JpdGluZyB1MTYgdmFsdWUgaW4gYSA1IGJpdCB3aWRlIHZhcmlhYmxlPw0KDQpXZSBuZWVkIG9u
bHkgNSBiaXRzIGluIHRoaXMgY2FzZS4gSSdsbCBjaGFuZ2UgaGlnaF9hZGRyX3JlZ19pZHgNCnBh
cmFtZXRlciB0byB1OC4NCg0KPiANCj4gPiArCWluc3Qub2Zmc2V0ID0gYWRkcl9sb3c7DQo+ID4g
KwlpbnN0LnZhbHVlID0gdmFsdWU7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVu
ZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChjbWRxX3Br
dF93cml0ZV9zX3ZhbHVlKTsNCj4gPiArDQo+ID4gIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGNtZHFfaW5zdHJ1
Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oDQo+ID4gaW5kZXggMDFiNDE4NGFmMzEwLi5mZWMyOTJhYWM4M2MgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBAQCAtMTM1LDYgKzEzNSwyMCBA
QCBpbnQgY21kcV9wa3RfcmVhZF9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRy
X3JlZ19pZHgsIHUxNiBhZGRyX2xvdywNCj4gPiAgaW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPiAgCQkgICAgIHUxNiBh
ZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4LCB1MzIgbWFzayk7DQo+ID4gIA0KPiA+ICsvKioNCj4g
PiArICogY21kcV9wa3Rfd3JpdGVfc192YWx1ZSgpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB3
aXRoIG1hc2sgdG8gdGhlIENNRFENCj4gPiArICoJCQkgICAgICBwYWNrZXQgd2hpY2ggd3JpdGUg
dmFsdWUgdG8gYSBwaHlzaWNhbCBhZGRyZXNzDQo+ID4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tl
dA0KPiA+ICsgKiBAaGlnaF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzZ2VyIElEIHdoaWNo
IGNvbnRhaW5zIGhpZ2ggYWRkcmVzcyBvZiBwYQ0KPiANCj4gcmVnaXN0ZXINCg0Kd2lsbCBmaXgN
Cg0KDQpSZWdhcmRzLA0KRGVubmlzDQoNCj4gDQo+ID4gKyAqIEBhZGRyX2xvdzoJbG93IGFkZHJl
c3Mgb2YgcGENCj4gPiArICogQHZhbHVlOgl0aGUgc3BlY2lmaWVkIHRhcmdldCB2YWx1ZQ0KPiA+
ICsgKiBAbWFzazoJdGhlIHNwZWNpZmllZCB0YXJnZXQgbWFzaw0KPiA+ICsgKg0KPiA+ICsgKiBS
ZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4g
PiArICovDQo+ID4gK2ludCBjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4gKwkJCSAgIHUxNiBhZGRyX2xvdywgdTMy
IHZhbHVlLCB1MzIgbWFzayk7DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogY21kcV9wa3Rfd2Zl
KCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4g
PiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4gDQoNCg==

