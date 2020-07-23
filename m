Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F5CC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2A7206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ntRWEgnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgGWC5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:57:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54826 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729401AbgGWC5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:57:33 -0400
X-UUID: 0cfb7708c0c342ecad195c49272d0e7c-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WYDT42K+eq1n1qjiZfhiWIQP4kra/i2foem6eG/vJw8=;
        b=ntRWEgnEt6sFOWGQluImQ8Cg78J98/5814elObibCbBHvut8WppImk0+MIMAXHQST2bHgMkrYFDl2K3HvaHkrAS0UZ4J8Rn64iU3jbtEL9KkgdsBPBtAXPGqO7Z3+UiBxxA5KFSLFHSxG7m+DwLc4gjgp1JlzShucFLIJdmQBkg=;
X-UUID: 0cfb7708c0c342ecad195c49272d0e7c-20200723
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 560982418; Thu, 23 Jul 2020 10:57:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 10:57:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 10:57:23 +0800
Message-ID: <1595473043.5077.8.camel@mtksdaap41>
Subject: Re: [PATCH 3/4] clk: mediatek: Add configurable enable control to
 mtk_pll_data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 23 Jul 2020 10:57:23 +0800
In-Reply-To: <CANMq1KC5i8GU2zMxk+NvY5hF7Qvd-Jx-+pvY2cXfqzb=X-BWRQ@mail.gmail.com>
References: <1595400601-26220-1-git-send-email-weiyi.lu@mediatek.com>
         <1595400601-26220-4-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KC5i8GU2zMxk+NvY5hF7Qvd-Jx-+pvY2cXfqzb=X-BWRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTIyIGF0IDE2OjUxICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDIyLCAyMDIwIGF0IDI6NTAgUE0gV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiBhbGwgTWVkaWFUZWsgUExMIGRlc2lnbiwg
Yml0IDAgb2YgQ09OMCByZWdpc3RlciBpcyBhbHdheXMNCj4gPiB0aGUgZW5hYmxlIGJpdC4NCj4g
PiBIb3dldmVyLCB0aGVyZSdzIGEgc3BlY2lhbCBjYXNlIG9mIHVzYnBsbCBvbiBNVDgxOTIuDQo+
ID4gVGhlIGVuYWJsZSBiaXQgb2YgdXNicGxsIGlzIG1vdmVkIHRvIGJpdCAyIG9mIG90aGVyIHJl
Z2lzdGVyLg0KPiA+IEFkZCBjb25maWd1cmFibGUgZW5fcmVnIGFuZCBiYXNlX2VuX2JpdCBmb3Ig
ZW5hYmxlIGNvbnRyb2wgb3INCj4gPiB1c2luZyB0aGUgZGVmYXVsdCBpZiB3aXRob3V0IHNldHRp
bmcgaW4gcGxsIGRhdGEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWku
bHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGst
bXRrLmggfCAgMiArKw0KPiA+ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxsLmMgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10ay5oIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oDQo+
ID4gaW5kZXggYzNkNjc1Ni4uOGJiMGIzZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXRrLmgNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRr
LmgNCj4gPiBAQCAtMjMzLDYgKzIzMyw4IEBAIHN0cnVjdCBtdGtfcGxsX2RhdGEgew0KPiA+ICAg
ICAgICAgdWludDMyX3QgcGN3X2NoZ19yZWc7DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgbXRr
X3BsbF9kaXZfdGFibGUgKmRpdl90YWJsZTsNCj4gPiAgICAgICAgIGNvbnN0IGNoYXIgKnBhcmVu
dF9uYW1lOw0KPiA+ICsgICAgICAgdWludDMyX3QgZW5fcmVnOw0KPiA+ICsgICAgICAgdWludDhf
dCBiYXNlX2VuX2JpdDsNCj4gPiAgfTsNCj4gPg0KPiA+ICB2b2lkIG10a19jbGtfcmVnaXN0ZXJf
cGxscyhzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1wbGwuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0K
PiA+IGluZGV4IGY0NDBmMmNkLi5iOGNjZDQyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1wbGwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1w
bGwuYw0KPiA+IEBAIC00NCw2ICs0NCw3IEBAIHN0cnVjdCBtdGtfY2xrX3BsbCB7DQo+ID4gICAg
ICAgICB2b2lkIF9faW9tZW0gICAgKnR1bmVyX2VuX2FkZHI7DQo+ID4gICAgICAgICB2b2lkIF9f
aW9tZW0gICAgKnBjd19hZGRyOw0KPiA+ICAgICAgICAgdm9pZCBfX2lvbWVtICAgICpwY3dfY2hn
X2FkZHI7DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gICAgKmVuX2FkZHI7DQo+ID4gICAgICAg
ICBjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhOw0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAg
LTU2LDcgKzU3LDEwIEBAIHN0YXRpYyBpbnQgbXRrX3BsbF9pc19wcmVwYXJlZChzdHJ1Y3QgY2xr
X2h3ICpodykNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IG10a19jbGtfcGxsICpwbGwgPSB0
b19tdGtfY2xrX3BsbChodyk7DQo+ID4NCj4gPiAtICAgICAgIHJldHVybiAocmVhZGwocGxsLT5i
YXNlX2FkZHIgKyBSRUdfQ09OMCkgJiBDT04wX0JBU0VfRU4pICE9IDA7DQo+ID4gKyAgICAgICBp
ZiAocGxsLT5lbl9hZGRyKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gKHJlYWRsKHBsbC0+
ZW5fYWRkcikgJiBCSVQocGxsLT5kYXRhLT5iYXNlX2VuX2JpdCkpICE9IDA7DQo+ID4gKyAgICAg
ICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAocmVhZGwocGxsLT5iYXNlX2FkZHIg
KyBSRUdfQ09OMCkgJiBDT04wX0JBU0VfRU4pICE9IDA7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0
aWMgdW5zaWduZWQgbG9uZyBfX210a19wbGxfcmVjYWxjX3JhdGUoc3RydWN0IG10a19jbGtfcGxs
ICpwbGwsIHUzMiBmaW4sDQo+ID4gQEAgLTI1MSw2ICsyNTUsMTIgQEAgc3RhdGljIGludCBtdGtf
cGxsX3ByZXBhcmUoc3RydWN0IGNsa19odyAqaHcpDQo+ID4gICAgICAgICByIHw9IHBsbC0+ZGF0
YS0+ZW5fbWFzazsNCj4gPiAgICAgICAgIHdyaXRlbChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19D
T04wKTsNCj4gPg0KPiANCj4gVGhpcyBpcyBub3QgYSBuZXcgY2hhbmdlLCBidXQgSSdtIHdvbmRl
cmluZyBpZiB0aGUgYXN5bW1ldHJ5IGlzDQo+IGludGVudGlvbmFsIGhlcmUsIHRoYXQgaXMsIHBy
ZXBhcmUgc2V0cyBiaXQgcGxsLT5kYXRhLT5lbl9tYXNrIG9mDQo+IFJFR19DT04wOyB1bnByZXBh
cmUgY2xlYXJzIENPTjBfQkFTRV9FTiBvZiBSRUdfQ09OMC4NCj4gDQo+IFdpdGggdGhpcyBwYXRj
aCwgaWYgcGxsLT5lbl9hZGRyIGlzIHNldCwgeW91IHNldCBib3RoDQo+IHBsbC0+ZGF0YS0+ZW5f
bWFzayBfYW5kXyBwbGwtPmRhdGEtPmJhc2VfZW5fYml0LCBhbmQgY2xlYXIgb25seQ0KPiBwbGwt
PmRhdGEtPmJhc2VfZW5fYml0Lg0KPiANCg0KSGkgTmljb2xhcywNCg0KQUZBSUssIHRoZSBhc3lt
bWV0cnkgd2FzIGludGVudGlvbmFsLg0KZW5fbWFzayBpcyBhY3R1YWxseSBhIGNvbWJpbmF0aW9u
IG9mIGRpdmlkZXIgZW5hYmxlIG1hc2sgYW5kIHRoZSBwbGwNCmVuYWJsZSBiaXQoQ09OMF9CQVNF
X0VOKS4NCkV2ZW4gd2l0aG91dCBteSBwYXRjaCwgaXQgc3RpbGwgc2V0cyBkaXZpZGVyIGVuYWJs
ZSBtYXNrIGFuZCBlbl9iaXQsIGFuZA0Kb25seSBjbGVhcnMgZW5fYml0Lg0KWW91IGNvdWxkIHNl
ZSB0aGUgcGxsX2RhdGEgaW4gY2xrLW10ODE5Mi5jIG9mIHBhdGNoIFs0LzRdDQpUYWtlIG1haW5w
bGwgYXMgYW4gZXhhbXBsZSwNCnRoZSBlbmFibGUgbWFzayBvZiBtYWlucGxsIGlzIDB4ZmYwMDAw
MDEsIHdoZXJlIDB4ZmYwMDAwMDAgaXMgdGhlDQpkaXZpZGVyIGVuYWJsZSBtYXNrIGFuZCAweDEg
aXMgdGhlIGVuX2JpdA0KDQpGb3IgdXNicGxsIGluIHNwZWNpYWwgY2FzZSwgdXNicGxsIGRvZXNu
J3QgaGF2ZSBkaXZpZGVyIGVuYWJsZSBtYXNrIG9uDQpNVDgxOTIgc28gSSBnaXZlIG5vdGhpbmco
MHgwMDAwMDAwMCkgaW4gdGhlIGVuX21hc2sgZmllbGQuDQpIb3dldmVyLCB0aGUgbWFpbiByZWFz
b24gd2h5IEkgZG9uJ3Qgc2tpcCBzZXR0aW5nIHRoZSBlbl9tYXNrIG9mIE1UODE5Mg0KdXNicGxs
IGlzIHRoYXQgSSdkIGp1c3QgbGlrZSB0byByZXNlcnZlIHRoZSBkaXZpZGVyIGVuYWJsZSBtYXNr
IGZvciBhbnkNCnNwZWNpYWwgcGxscyB3aXRoIGRpdmlkZXIgZW5hYmxlIG1hc2sgaW4gbmVhciBm
dXR1cmUuDQoNCj4gPiArICAgICAgIGlmIChwbGwtPmVuX2FkZHIpIHsNCj4gPiArICAgICAgICAg
ICAgICAgciA9IHJlYWRsKHBsbC0+ZW5fYWRkcik7DQo+ID4gKyAgICAgICAgICAgICAgIHIgfD0g
QklUKHBsbC0+ZGF0YS0+YmFzZV9lbl9iaXQpOw0KPiA+ICsgICAgICAgICAgICAgICB3cml0ZWwo
ciwgcGxsLT5lbl9hZGRyKTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICBfX210
a19wbGxfdHVuZXJfZW5hYmxlKHBsbCk7DQo+ID4NCj4gPiAgICAgICAgIHVkZWxheSgyMCk7DQo+
ID4gQEAgLTI3Nyw5ICsyODcsMTUgQEAgc3RhdGljIHZvaWQgbXRrX3BsbF91bnByZXBhcmUoc3Ry
dWN0IGNsa19odyAqaHcpDQo+ID4NCj4gPiAgICAgICAgIF9fbXRrX3BsbF90dW5lcl9kaXNhYmxl
KHBsbCk7DQo+ID4NCj4gPiAtICAgICAgIHIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19D
T04wKTsNCj4gPiAtICAgICAgIHIgJj0gfkNPTjBfQkFTRV9FTjsNCj4gPiAtICAgICAgIHdyaXRl
bChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCj4gPiArICAgICAgIGlmIChwbGwtPmVu
X2FkZHIpIHsNCj4gPiArICAgICAgICAgICAgICAgciA9IHJlYWRsKHBsbC0+ZW5fYWRkcik7DQo+
ID4gKyAgICAgICAgICAgICAgIHIgJj0gfkJJVChwbGwtPmRhdGEtPmJhc2VfZW5fYml0KTsNCj4g
PiArICAgICAgICAgICAgICAgd3JpdGVsKHIsIHBsbC0+ZW5fYWRkcik7DQo+ID4gKyAgICAgICB9
IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICByID0gcmVhZGwocGxsLT5iYXNlX2FkZHIgKyBS
RUdfQ09OMCk7DQo+ID4gKyAgICAgICAgICAgICAgIHIgJj0gfkNPTjBfQkFTRV9FTjsNCj4gPiAr
ICAgICAgICAgICAgICAgd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KPiA+
ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICByID0gcmVhZGwocGxsLT5wd3JfYWRkcikgfCBD
T04wX0lTT19FTjsNCj4gPiAgICAgICAgIHdyaXRlbChyLCBwbGwtPnB3cl9hZGRyKTsNCj4gPiBA
QCAtMzIxLDYgKzMzNyw4IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrICptdGtfY2xrX3JlZ2lzdGVyX3Bs
bChjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhLA0KPiA+ICAgICAgICAgICAgICAgICBw
bGwtPnR1bmVyX2FkZHIgPSBiYXNlICsgZGF0YS0+dHVuZXJfcmVnOw0KPiA+ICAgICAgICAgaWYg
KGRhdGEtPnR1bmVyX2VuX3JlZykNCj4gPiAgICAgICAgICAgICAgICAgcGxsLT50dW5lcl9lbl9h
ZGRyID0gYmFzZSArIGRhdGEtPnR1bmVyX2VuX3JlZzsNCj4gPiArICAgICAgIGlmIChkYXRhLT5l
bl9yZWcpDQo+ID4gKyAgICAgICAgICAgICAgIHBsbC0+ZW5fYWRkciA9IGJhc2UgKyBkYXRhLT5l
bl9yZWc7DQo+IA0KPiBJZiB0aGUgYW5zd2VyIHRvIG15IHF1ZXN0aW9uIGFib3ZlIGhvbGRzIChh
c3ltbWV0cnkgaXMgbm90DQo+IGludGVudGlvbmFsKSwgdGhpcyBwYXRjaC90aGUgY29kZSBjb3Vs
ZCBiZSBzaW1wbGlmaWVkIGEgbG90IGlmIHlvdQ0KPiBhbHNvIGFkZGVkIGEgcGxsLT5lbl9iaXQg
bWVtYmVyLCBhbmQsIGhlcmUsIGRpZCB0aGlzOg0KPiANCj4gaWYgKHBsbC0+ZW5fcmVnKSB7DQo+
ICAgIHBsbC0+ZW5fYWRkciA9IGJhc2UgKyBkYXRhLT5lbl9yZWc7DQo+ICAgIHBsbC0+ZW5kX2Jp
dCA9IGRhdGEtPmVuX2JpdDsNCj4gfSBlbHNlIHsNCj4gICAgcGxsLT5lbl9hZGRyID0gcGxsLT5i
YXNlX2FkZHIgKyBSRUdfQ09OMDsNCj4gICAgcGxsLT5lbl9iaXQgPSBDT04wX0JBU0VfRU47DQo+
IH0NCj4gDQo+ID4gICAgICAgICBwbGwtPmh3LmluaXQgPSAmaW5pdDsNCj4gPiAgICAgICAgIHBs
bC0+ZGF0YSA9IGRhdGE7DQo+ID4NCj4gPiAtLQ0KPiA+IDEuOC4xLjEuZGlydHkNCg0K

