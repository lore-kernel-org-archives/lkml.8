Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F484207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Rm/6FLc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHKGnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:43:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55389 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727902AbgHKGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:43:39 -0400
X-UUID: b8f27bd5428248f6b1bf8bb726c852dd-20200811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IwFjIoBMs4hG3mm1jnyEzvP2yfokZU6BNDof81MOmbQ=;
        b=Rm/6FLc06lk0ABvWubi2UgHn1uwVkJE4twzSHJ9hFVHhG805KyBmqp0cS2HR/gwbiZe1zgGmExNIWa6HjsZyxsZgwS/jbDLJGrO1rNQNk/lA93yyM2M8Y3pFhwsXCCMGFLUOHh0ItU9bBQu+idtw0q3yL+MOpu9MdTNoS2w3mZs=;
X-UUID: b8f27bd5428248f6b1bf8bb726c852dd-20200811
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 806667961; Tue, 11 Aug 2020 14:43:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Aug 2020 14:43:24 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Aug 2020 14:43:24 +0800
Message-ID: <1597128205.20627.14.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/5] clk: mediatek: Add configurable enable control
 to mtk_pll_data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 11 Aug 2020 14:43:25 +0800
In-Reply-To: <CANMq1KCG1xUan5-=DBZewvTqmUH=p7=nxy0Va=pdYBhAfYhhjQ@mail.gmail.com>
References: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com>
         <1596012277-8448-5-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KCG1xUan5-=DBZewvTqmUH=p7=nxy0Va=pdYBhAfYhhjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E7F37730596799C3F49018D181AD9A3F682732CFE65456F2E376CEB7F0DDFEE32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTI5IGF0IDE4OjU4ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDI5LCAyMDIwIGF0IDQ6NDQgUE0gV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiBhbGwgTWVkaWFUZWsgUExMIGRlc2lnbiwg
Yml0MCBvZiBDT04wIHJlZ2lzdGVyIGlzIGFsd2F5cw0KPiA+IHRoZSBlbmFibGUgYml0Lg0KPiA+
IEhvd2V2ZXIsIHRoZXJlJ3MgYSBzcGVjaWFsIGNhc2Ugb2YgdXNicGxsIG9uIE1UODE5Mi4NCj4g
PiBUaGUgZW5hYmxlIGJpdCBvZiB1c2JwbGwgaXMgbW92ZWQgdG8gYml0MiBvZiBvdGhlciByZWdp
c3Rlci4NCj4gPiBBZGQgY29uZmlndXJhYmxlIGVuX3JlZyBhbmQgcGxsX2VuX2JpdCBmb3IgZW5h
YmxlIGNvbnRyb2wgb3INCj4gPiBkZWZhdWx0IDAgd2hlcmUgcGxsIGRhdGEgYXJlIHN0YXRpYyB2
YXJpYWJsZXMuDQo+ID4gSGVuY2UsIENPTjBfQkFTRV9FTiBjb3VsZCBhbHNvIGJlIHJlbW92ZWQu
DQo+ID4gQW5kIHRoZXJlIG1pZ2h0IGhhdmUgYW5vdGhlciBzcGVjaWFsIGNhc2Ugb24gb3RoZXIg
Y2hpcHMsDQo+ID4gdGhlIGVuYWJsZSBiaXQgaXMgc3RpbGwgb24gQ09OMCByZWdpc3RlciBidXQg
bm90IGF0IGJpdDAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRr
LmggfCAgMiArKw0KPiA+ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxsLmMgfCAxOCArKysr
KysrKysrKy0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdGsuaCBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaA0KPiA+IGluZGV4IGMz
ZDY3NTYuLjgxMGViOTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ay5oDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oDQo+ID4gQEAg
LTIzMyw2ICsyMzMsOCBAQCBzdHJ1Y3QgbXRrX3BsbF9kYXRhIHsNCj4gPiAgICAgICAgIHVpbnQz
Ml90IHBjd19jaGdfcmVnOw0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IG10a19wbGxfZGl2X3Rh
YmxlICpkaXZfdGFibGU7DQo+ID4gICAgICAgICBjb25zdCBjaGFyICpwYXJlbnRfbmFtZTsNCj4g
PiArICAgICAgIHVpbnQzMl90IGVuX3JlZzsNCj4gPiArICAgICAgIHVpbnQ4X3QgcGxsX2VuX2Jp
dDsNCj4gPiAgfTsNCj4gPg0KPiA+ICB2b2lkIG10a19jbGtfcmVnaXN0ZXJfcGxscyhzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5vZGUsDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1wbGwuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0KPiA+IGluZGV4IDNj
NzllMWEuLjE0MzRlOTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LXBsbC5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQo+ID4gQEAg
LTE2LDcgKzE2LDYgQEANCj4gPiAgI2RlZmluZSBSRUdfQ09OMCAgICAgICAgICAgICAgIDANCj4g
PiAgI2RlZmluZSBSRUdfQ09OMSAgICAgICAgICAgICAgIDQNCj4gPg0KPiA+IC0jZGVmaW5lIENP
TjBfQkFTRV9FTiAgICAgICAgICAgQklUKDApDQo+ID4gICNkZWZpbmUgQ09OMF9QV1JfT04gICAg
ICAgICAgICBCSVQoMCkNCj4gPiAgI2RlZmluZSBDT04wX0lTT19FTiAgICAgICAgICAgIEJJVCgx
KQ0KPiA+ICAjZGVmaW5lIFBDV19DSEdfTUFTSyAgICAgICAgICAgQklUKDMxKQ0KPiA+IEBAIC00
NCw2ICs0Myw3IEBAIHN0cnVjdCBtdGtfY2xrX3BsbCB7DQo+ID4gICAgICAgICB2b2lkIF9faW9t
ZW0gICAgKnR1bmVyX2VuX2FkZHI7DQo+ID4gICAgICAgICB2b2lkIF9faW9tZW0gICAgKnBjd19h
ZGRyOw0KPiA+ICAgICAgICAgdm9pZCBfX2lvbWVtICAgICpwY3dfY2hnX2FkZHI7DQo+ID4gKyAg
ICAgICB2b2lkIF9faW9tZW0gICAgKmVuX2FkZHI7DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3Qg
bXRrX3BsbF9kYXRhICpkYXRhOw0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTU2LDcgKzU2LDcgQEAg
c3RhdGljIGludCBtdGtfcGxsX2lzX3ByZXBhcmVkKHN0cnVjdCBjbGtfaHcgKmh3KQ0KPiA+ICB7
DQo+ID4gICAgICAgICBzdHJ1Y3QgbXRrX2Nsa19wbGwgKnBsbCA9IHRvX210a19jbGtfcGxsKGh3
KTsNCj4gPg0KPiA+IC0gICAgICAgcmV0dXJuIChyZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19D
T04wKSAmIENPTjBfQkFTRV9FTikgIT0gMDsNCj4gPiArICAgICAgIHJldHVybiAocmVhZGwocGxs
LT5lbl9hZGRyKSAmIEJJVChwbGwtPmRhdGEtPnBsbF9lbl9iaXQpKSAhPSAwOw0KPiA+ICB9DQo+
ID4NCj4gPiAgc3RhdGljIHVuc2lnbmVkIGxvbmcgX19tdGtfcGxsX3JlY2FsY19yYXRlKHN0cnVj
dCBtdGtfY2xrX3BsbCAqcGxsLCB1MzIgZmluLA0KPiA+IEBAIC0yNDcsOCArMjQ3LDggQEAgc3Rh
dGljIGludCBtdGtfcGxsX3ByZXBhcmUoc3RydWN0IGNsa19odyAqaHcpDQo+ID4gICAgICAgICB3
cml0ZWwociwgcGxsLT5wd3JfYWRkcik7DQo+ID4gICAgICAgICB1ZGVsYXkoMSk7DQo+ID4NCj4g
PiAtICAgICAgIHIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKSB8IENPTjBfQkFT
RV9FTjsNCj4gPiAtICAgICAgIHdyaXRlbChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsN
Cj4gPiArICAgICAgIHIgPSByZWFkbChwbGwtPmVuX2FkZHIpIHwgQklUKHBsbC0+ZGF0YS0+cGxs
X2VuX2JpdCk7DQo+ID4gKyAgICAgICB3cml0ZWwociwgcGxsLT5lbl9hZGRyKTsNCj4gPg0KPiA+
ICAgICAgICAgciA9IHJlYWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApIHwgcGxsLT5kYXRh
LT5lbl9tYXNrOw0KPiA+ICAgICAgICAgd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NP
TjApOw0KPiA+IEBAIC0yODMsOSArMjgzLDkgQEAgc3RhdGljIHZvaWQgbXRrX3BsbF91bnByZXBh
cmUoc3RydWN0IGNsa19odyAqaHcpDQo+ID4gICAgICAgICByICY9IH5wbGwtPmRhdGEtPmVuX21h
c2s7DQo+ID4gICAgICAgICB3cml0ZWwociwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQo+
ID4NCj4gPiAtICAgICAgIHIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCj4g
PiAtICAgICAgIHIgJj0gfkNPTjBfQkFTRV9FTjsNCj4gPiAtICAgICAgIHdyaXRlbChyLCBwbGwt
PmJhc2VfYWRkciArIFJFR19DT04wKTsNCj4gPiArICAgICAgIHIgPSByZWFkbChwbGwtPmVuX2Fk
ZHIpOw0KPiA+ICsgICAgICAgciAmPSB+QklUKHBsbC0+ZGF0YS0+cGxsX2VuX2JpdCk7DQo+IA0K
PiAxIGxpbmUsIGJ1dCB0aGF0J2xsIGNvbWUgbmF0dXJhbGx5IGZyb20gdGhlIGNoYW5nZSBJIHJl
cXVlc3RlZCBpbiB0aGUNCj4gcHJldmlvdXMgcGF0Y2guDQo+IA0KDQpPSywgSSdsbCBwdXQgaXQg
aW50byBvbmUgbGluZSBpbiBwcmV2aW91cyBwYXRjaC4NCg0KPiA+ICsgICAgICAgd3JpdGVsKHIs
IHBsbC0+ZW5fYWRkcik7DQo+ID4NCj4gPiAgICAgICAgIHIgPSByZWFkbChwbGwtPnB3cl9hZGRy
KSB8IENPTjBfSVNPX0VOOw0KPiA+ICAgICAgICAgd3JpdGVsKHIsIHBsbC0+cHdyX2FkZHIpOw0K
PiA+IEBAIC0zMjcsNiArMzI3LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xrICptdGtfY2xrX3JlZ2lz
dGVyX3BsbChjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhLA0KPiA+ICAgICAgICAgICAg
ICAgICBwbGwtPnR1bmVyX2FkZHIgPSBiYXNlICsgZGF0YS0+dHVuZXJfcmVnOw0KPiA+ICAgICAg
ICAgaWYgKGRhdGEtPnR1bmVyX2VuX3JlZykNCj4gPiAgICAgICAgICAgICAgICAgcGxsLT50dW5l
cl9lbl9hZGRyID0gYmFzZSArIGRhdGEtPnR1bmVyX2VuX3JlZzsNCj4gPiArICAgICAgIGlmIChk
YXRhLT5lbl9yZWcpDQo+ID4gKyAgICAgICAgICAgICAgIHBsbC0+ZW5fYWRkciA9IGJhc2UgKyBk
YXRhLT5lbl9yZWc7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIHBsbC0+
ZW5fYWRkciA9IHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjA7DQo+IA0KPiBEb24ndCB5b3UgbmVl
ZCB0byBzZXQgcGxsLT5kYXRhLT5wbGxfZW5fYml0IHRvIENPTjBfQkFTRV9FTiBoZXJlPw0KPiAo
d2hpY2ggcHJvYmFibHkgbWVhbnMgdGhhdCB5b3UgbmVlZCB0byBhZGQgYSBwbGwtPmVuX2JpdCBm
aWVsZCB0bw0KPiBzdHJ1Y3QgbXRrX2Nsa19wbGwpDQo+IA0KDQpCZWNhdXNlIGFsbCBtdGtfY2xr
X3BsbCBkYXRhIGFyZSBzdGF0aWMgdmFyaWFibGVzLCBlbl9iaXQgd291bGQgYmUgMCBpZg0KTk8g
dmFsdWUgYXNzaWduZWQuDQoNCnIgPSByZWFkbChwbGwtPmVuX2FkZHIpIHwgQklUKHBsbC0+ZGF0
YS0+cGxsX2VuX2JpdCk7DQp3cml0ZWwociwgcGxsLT5lbl9hZGRyKTsNCg0KDQo+ID4gICAgICAg
ICBwbGwtPmh3LmluaXQgPSAmaW5pdDsNCj4gPiAgICAgICAgIHBsbC0+ZGF0YSA9IGRhdGE7DQo+
ID4NCj4gPiAtLQ0KPiA+IDEuOC4xLjEuZGlydHkNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlz
dA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW1lZGlhdGVrX187ISFDVFJOS0E5d01nMEFSYnchMlh2QVhadUFKSmpYVjFqQXhFenUw
Y1lWWkNEN3ZRbXVPdEp0d0hlV19ucEZiRUl3VlNaTU1Yc1RrRVhKRUFYdiQgDQoNCg==

