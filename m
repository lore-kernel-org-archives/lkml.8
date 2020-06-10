Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD62207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Fg/VXkPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgFJHig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:38:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22065 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgFJHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:38:35 -0400
X-UUID: b618efbba94c497c9ab14a9a7b19df01-20200610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Ra99Eu+wdfyk6Soso8ag8ilUd7xttL71qdj/oWcCkzo=;
        b=Fg/VXkPTlNNItGS1xki1iUm+0h8xi8y1kKlG3V71MYUqBevKPCXwhF32eYQPHU55wu4IhLf2l91ahgzECXEF1I6ZzQOMHVA9aAiIuy2abh7RWKPlIssXdioXhM+yK1v7cdUr4vOKn5mFsmi/5VZkTMiVzxiAJomboL6g7Br2Nc4=;
X-UUID: b618efbba94c497c9ab14a9a7b19df01-20200610
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <tiffany.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 705854983; Wed, 10 Jun 2020 15:38:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Jun 2020 15:38:26 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Jun 2020 15:38:25 +0800
Message-ID: <1591774707.21260.14.camel@mtksdaap41>
Subject: Re: [PATCH v4 01/17] media: dt-binding: mtk-vcodec: Separating
 mtk-vcodec encode node.
From:   Tiffany Lin <tiffany.lin@mediatek.com>
To:     Alexandre Courbot <acourbot@chromium.org>
CC:     Rob Herring <robh@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Evan Green" <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        "Hsin-Yi Wang" <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>
Date:   Wed, 10 Jun 2020 15:38:27 +0800
In-Reply-To: <CAPBb6MXdbEgWtOx_b5ab3hOTdyPPaGDQ2kA21pLjoLE-2sjuTg@mail.gmail.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
         <1590826218-23653-2-git-send-email-yong.wu@mediatek.com>
         <20200609212102.GA1416099@bogus>
         <CAPBb6MXdbEgWtOx_b5ab3hOTdyPPaGDQ2kA21pLjoLE-2sjuTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTEwIGF0IDE1OjQ2ICswOTAwLCBBbGV4YW5kcmUgQ291cmJvdCB3cm90
ZToNCj4gT24gV2VkLCBKdW4gMTAsIDIwMjAgYXQgNjoyMSBBTSBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIFNhdCwgTWF5IDMwLCAyMDIwIGF0IDA0OjEw
OjAyUE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiBGcm9tOiBNYW9ndWFuZyBNZW5nIDxt
YW9ndWFuZy5tZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+DQo+ID4gPiBVcGRhdGUgYmluZGluZyBk
b2N1bWVudCBzaW5jZSB0aGUgYXZjIGFuZCB2cDggaGFyZHdhcmUgZW5jb2RlciBpbg0KPiA+ID4g
bXQ4MTczIGFyZSBub3cgc2VwYXJhdGVkLiBTZXBhcmF0ZSAibWVkaWF0ZWssbXQ4MTczLXZjb2Rl
Yy1lbmMiIHRvDQo+ID4gPiAibWVkaWF0ZWssbXQ4MTczLXZjb2RlYy12cDgtZW5jIiBhbmQgIm1l
ZGlhdGVrLG10ODE3My12Y29kZWMtYXZjLWVuYyIuDQo+ID4NCj4gPiBUaGUgaC93IHN1ZGRlbmx5
IHNwbGl0IGluIDI/IFlvdSBhcmUgYnJlYWtpbmcgY29tcGF0aWJpbGl0eS4gVXAgdG8gdGhlDQo+
ID4gTWVkaWF0ZWsgbWFpbnRhaW5lcnMgdG8gZGVjaWRlIGlmIHRoYXQncyBva2F5LCBidXQgeW91
IG5lZWQgdG8gc3RhdGUgeW91DQo+ID4gYXJlIGJyZWFraW5nIGNvbXBhdGliaWxpdHkgKGhlcmUg
YW5kIGluIHRoZSBkcml2ZXIpIGFuZCB3aHkgdGhhdCBpcw0KPiA+IG9rYXkuDQo+IA0KPiBJbiBt
eSB1bmRlcnN0YW5kaW5nIHRoZXJlIGlzIG5vIHJlYWwgaGFyZHdhcmUgdXNpbmcgdGhlIG9sZCBi
aW5kaW5ncw0KPiBhdCB0aGUgbW9tZW50LCBhbmQgdGhlIHNwbGl0IGlzIGluZGVlZCBhIHJlZmxl
Y3Rpb24gb2YgdGhlIGFjdHVhbA0KPiBoYXJkd2FyZSBsYXlvdXQuIFRpZmZhbnksIGNhbiB5b3Ug
Z2l2ZSB5b3VyIGFja2VkLWJ5IGlmIHRoaXMgY2hhbmdlIGlzDQo+IG9rIHdpdGggeW91Pw0KPiAN
Cg0KSW4gbXkgb3BpbmlvbiwgdGhlcmUgaXMgbm8gbmVlZCB0byBjaGFuZ2UgbXQ4MTczIGR0cyBm
b3IgZHJpdmVyIHRvDQpzdXBwb3J0IG10ODE4My4NCkkgc2F3IGFub3RoZXIgcGF0Y2ggdGhhdCBh
bHJlYWR5IG1ha2UgY2hhbmdlIHRvIGhhdmUgZW5jb2RlciBkcml2ZXINCnN1cHBvcnQgYm90aCBt
dDgxNzMgYW5kIG10ODE4My4NCkJ1dCB0aGV5IGRvbmUgYSBsb3QgdG8gcHJvdmUgaDI2NCBhbmQg
dnA4IGVuY29kZXIgY291bGQgd29yaw0KaW5kZXBlbmRlbnRseSBhbmQgcGFyYWxsZWwuDQpJbiB0
aGlzIGNhc2UsIEkgYW0gb2sgd2l0aCBpdCBiZWNhdXNlIGR0cyBzaG91bGQgYmUgYSByZWZsZWN0
aW9uIG9mIHRoZQ0KYWN0dWFsIGhhcmR3YXJlLg0KDQoNCg0KPiA+DQo+ID4gPg0KPiA+ID4gVGhp
cyBpcyBhIHByZXBhcmluZyBwYXRjaCBmb3Igc21pIGNsZWFuaW5nIHVwICJtZWRpYXRlayxsYXJi
Ii4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYW9ndWFuZyBNZW5nIDxtYW9ndWFuZy5t
ZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEhzaW4tWWkgV2FuZyA8aHNp
bnlpQGNocm9taXVtLm9yZz4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IElydWkgV2FuZyA8aXJ1aS53
YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VA
bWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVkaWEvbWVkaWF0ZWstdmNvZGVjLnR4dCAgfCA1OCArKysrKysrKysrKystLS0tLS0tLS0tDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0K
PiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvbWVkaWF0ZWstdmNvZGVjLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZWRpYS9tZWRpYXRlay12Y29kZWMudHh0DQo+ID4gPiBpbmRleCA4MDkzMzM1Li4x
MDIzNzQwIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lZGlhL21lZGlhdGVrLXZjb2RlYy50eHQNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlay12Y29kZWMudHh0DQo+ID4gPiBAQCAt
NCw3ICs0LDkgQEAgTWVkaWF0ZWsgVmlkZW8gQ29kZWMgaXMgdGhlIHZpZGVvIGNvZGVjIGh3IHBy
ZXNlbnQgaW4gTWVkaWF0ZWsgU29DcyB3aGljaA0KPiA+ID4gIHN1cHBvcnRzIGhpZ2ggcmVzb2x1
dGlvbiBlbmNvZGluZyBhbmQgZGVjb2RpbmcgZnVuY3Rpb25hbGl0aWVzLg0KPiA+ID4NCj4gPiA+
ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gLS0gY29tcGF0aWJsZSA6ICJtZWRpYXRlayxt
dDgxNzMtdmNvZGVjLWVuYyIgZm9yIE1UODE3MyBlbmNvZGVyDQo+ID4gPiArLSBjb21wYXRpYmxl
IDogbXVzdCBiZSBvbmUgb2YgdGhlIGZvbGxvd2luZyBzdHJpbmc6DQo+ID4gPiArICAibWVkaWF0
ZWssbXQ4MTczLXZjb2RlYy12cDgtZW5jIiBmb3IgbXQ4MTczIHZwOCBlbmNvZGVyLg0KPiA+ID4g
KyAgIm1lZGlhdGVrLG10ODE3My12Y29kZWMtYXZjLWVuYyIgZm9yIG10ODE3MyBhdmMgZW5jb2Rl
ci4NCj4gPiA+ICAgICJtZWRpYXRlayxtdDgxODMtdmNvZGVjLWVuYyIgZm9yIE1UODE4MyBlbmNv
ZGVyLg0KPiA+ID4gICAgIm1lZGlhdGVrLG10ODE3My12Y29kZWMtZGVjIiBmb3IgTVQ4MTczIGRl
Y29kZXIuDQo+ID4gPiAgLSByZWcgOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3Mgb2YgdGhlIHZpZGVv
IGNvZGVjIHJlZ2lzdGVycyBhbmQgbGVuZ3RoIG9mDQo+ID4gPiBAQCAtMTMsMTAgKzE1LDExIEBA
IFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gPiAgLSBtZWRpYXRlayxsYXJiIDogbXVzdCBjb250
YWluIHRoZSBsb2NhbCBhcmJpdGVycyBpbiB0aGUgY3VycmVudCBTb2NzLg0KPiA+ID4gIC0gY2xv
Y2tzIDogbGlzdCBvZiBjbG9jayBzcGVjaWZpZXJzLCBjb3JyZXNwb25kaW5nIHRvIGVudHJpZXMg
aW4NCj4gPiA+ICAgIHRoZSBjbG9jay1uYW1lcyBwcm9wZXJ0eS4NCj4gPiA+IC0tIGNsb2NrLW5h
bWVzOiBlbmNvZGVyIG11c3QgY29udGFpbiAidmVuY19zZWxfc3JjIiwgInZlbmNfc2VsIiwsDQo+
ID4gPiAtICAidmVuY19sdF9zZWxfc3JjIiwgInZlbmNfbHRfc2VsIiwgZGVjb2RlciBtdXN0IGNv
bnRhaW4gInZjb2RlY3BsbCIsDQo+ID4gPiAtICAidW5pdnBsbF9kMiIsICJjbGtfY2NpNDAwX3Nl
bCIsICJ2ZGVjX3NlbCIsICJ2ZGVjcGxsIiwgInZlbmNwbGwiLA0KPiA+ID4gLSAgInZlbmNfbHRf
c2VsIiwgInZkZWNfYnVzX2Nsa19zcmMiLg0KPiA+ID4gKy0gY2xvY2stbmFtZXM6DQo+ID4gPiAr
ICAgYXZjIHZlbmMgbXVzdCBjb250YWluICJ2ZW5jX3NlbCI7DQo+ID4gPiArICAgdnA4IHZlbmMg
bXVzdCBjb250YWluICJ2ZW5jX2x0X3NlbCI7DQo+ID4gPiArICAgZGVjb2RlciAgbXVzdCBjb250
YWluICJ2Y29kZWNwbGwiLCAidW5pdnBsbF9kMiIsICJjbGtfY2NpNDAwX3NlbCIsDQo+ID4gPiAr
ICAgInZkZWNfc2VsIiwgInZkZWNwbGwiLCAidmVuY3BsbCIsICJ2ZW5jX2x0X3NlbCIsICJ2ZGVj
X2J1c19jbGtfc3JjIi4NCj4gPiA+ICAtIGlvbW11cyA6IHNob3VsZCBwb2ludCB0byB0aGUgcmVz
cGVjdGl2ZSBJT01NVSBibG9jayB3aXRoIG1hc3RlciBwb3J0IGFzDQo+ID4gPiAgICBhcmd1bWVu
dCwgc2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxp
b21tdS50eHQNCj4gPiA+ICAgIGZvciBkZXRhaWxzLg0KPiA+ID4gQEAgLTgwLDE0ICs4MywxMCBA
QCB2Y29kZWNfZGVjOiB2Y29kZWNAMTYwMDAwMDAgew0KPiA+ID4gICAgICBhc3NpZ25lZC1jbG9j
ay1yYXRlcyA9IDwwPiwgPDA+LCA8MD4sIDwxNDgyMDAwMDAwPiwgPDgwMDAwMDAwMD47DQo+ID4g
PiAgICB9Ow0KPiA+ID4NCj4gPiA+IC0gIHZjb2RlY19lbmM6IHZjb2RlY0AxODAwMjAwMCB7DQo+
ID4gPiAtICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXZjb2RlYy1lbmMiOw0KPiA+
ID4gLSAgICByZWcgPSA8MCAweDE4MDAyMDAwIDAgMHgxMDAwPiwgICAgLypWRU5DX1NZUyovDQo+
ID4gPiAtICAgICAgICAgIDwwIDB4MTkwMDIwMDAgMCAweDEwMDA+OyAgICAvKlZFTkNfTFRfU1lT
Ki8NCj4gPiA+IC0gICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5OCBJUlFfVFlQRV9MRVZFTF9M
T1c+LA0KPiA+ID4gLSAgICAgICAgICAgICAgPEdJQ19TUEkgMjAyIElSUV9UWVBFX0xFVkVMX0xP
Vz47DQo+ID4gPiAtICAgIG1lZGlhdGVrLGxhcmIgPSA8JmxhcmIzPiwNCj4gPiA+IC0gICAgICAg
ICAgICAgICAgIDwmbGFyYjU+Ow0KPiA+ID4gK3Zjb2RlY19lbmM6IHZjb2RlY0AxODAwMjAwMCB7
DQo+ID4gPiArICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXZjb2RlYy1hdmMtZW5j
IjsNCj4gPiA+ICsgICAgcmVnID0gPDAgMHgxODAwMjAwMCAwIDB4MTAwMD47DQo+ID4gPiArICAg
IGludGVycnVwdHMgPSA8R0lDX1NQSSAxOTggSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gPiA+ICAg
ICAgaW9tbXVzID0gPCZpb21tdSBNNFVfUE9SVF9WRU5DX1JDUFU+LA0KPiA+ID4gICAgICAgICAg
ICAgICA8JmlvbW11IE00VV9QT1JUX1ZFTkNfUkVDPiwNCj4gPiA+ICAgICAgICAgICAgICAgPCZp
b21tdSBNNFVfUE9SVF9WRU5DX0JTRE1BPiwNCj4gPiA+IEBAIC05OCw4ICs5NywyMCBAQCB2Y29k
ZWNfZGVjOiB2Y29kZWNAMTYwMDAwMDAgew0KPiA+ID4gICAgICAgICAgICAgICA8JmlvbW11IE00
VV9QT1JUX1ZFTkNfUkVGX0xVTUE+LA0KPiA+ID4gICAgICAgICAgICAgICA8JmlvbW11IE00VV9Q
T1JUX1ZFTkNfUkVGX0NIUk9NQT4sDQo+ID4gPiAgICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BP
UlRfVkVOQ19OQk1fUkRNQT4sDQo+ID4gPiAtICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BPUlRf
VkVOQ19OQk1fV0RNQT4sDQo+ID4gPiAtICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BPUlRfVkVO
Q19SQ1BVX1NFVDI+LA0KPiA+ID4gKyAgICAgICAgICAgICA8JmlvbW11IE00VV9QT1JUX1ZFTkNf
TkJNX1dETUE+Ow0KPiA+ID4gKyAgICBtZWRpYXRlayxsYXJiID0gPCZsYXJiMz47DQo+ID4gPiAr
ICAgIG1lZGlhdGVrLHZwdSA9IDwmdnB1PjsNCj4gPiA+ICsgICAgY2xvY2tzID0gPCZ0b3Bja2dl
biBDTEtfVE9QX1ZFTkNfU0VMPjsNCj4gPiA+ICsgICAgY2xvY2stbmFtZXMgPSAidmVuY19zZWwi
Ow0KPiA+ID4gKyAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19T
RUw+Ow0KPiA+ID4gKyAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZ0b3Bja2dlbiBDTEtf
VE9QX1ZDT0RFQ1BMTD47DQo+ID4gPiArICB9Ow0KPiA+ID4gKw0KPiA+ID4gK3Zjb2RlY19lbmNf
bHQ6IHZjb2RlY0AxOTAwMjAwMCB7DQo+ID4gPiArICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTczLXZjb2RlYy12cDgtZW5jIjsNCj4gPiA+ICsgICAgcmVnID0gIDwwIDB4MTkwMDIwMDAg
MCAweDEwMDA+OyAgLyogVkVOQ19MVF9TWVMgKi8NCj4gPiA+ICsgICAgaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDIwMiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ID4gKyAgICBpb21tdXMgPSA8Jmlv
bW11IE00VV9QT1JUX1ZFTkNfUkNQVV9TRVQyPiwNCj4gPiA+ICAgICAgICAgICAgICAgPCZpb21t
dSBNNFVfUE9SVF9WRU5DX1JFQ19GUk1fU0VUMj4sDQo+ID4gPiAgICAgICAgICAgICAgIDwmaW9t
bXUgTTRVX1BPUlRfVkVOQ19CU0RNQV9TRVQyPiwNCj4gPiA+ICAgICAgICAgICAgICAgPCZpb21t
dSBNNFVfUE9SVF9WRU5DX1NWX0NPTUFfU0VUMj4sDQo+ID4gPiBAQCAtMTA4LDE3ICsxMTksMTAg
QEAgdmNvZGVjX2RlYzogdmNvZGVjQDE2MDAwMDAwIHsNCj4gPiA+ICAgICAgICAgICAgICAgPCZp
b21tdSBNNFVfUE9SVF9WRU5DX0NVUl9DSFJPTUFfU0VUMj4sDQo+ID4gPiAgICAgICAgICAgICAg
IDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19SRUZfTFVNQV9TRVQyPiwNCj4gPiA+ICAgICAgICAgICAg
ICAgPCZpb21tdSBNNFVfUE9SVF9WRU5DX1JFQ19DSFJPTUFfU0VUMj47DQo+ID4gPiArICAgIG1l
ZGlhdGVrLGxhcmIgPSA8JmxhcmI1PjsNCj4gPiA+ICAgICAgbWVkaWF0ZWssdnB1ID0gPCZ2cHU+
Ow0KPiA+ID4gLSAgICBjbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ1BMTF9EMj4sDQo+
ID4gPiAtICAgICAgICAgICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9WRU5DX1NFTD4sDQo+ID4gPiAt
ICAgICAgICAgICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9VTklWUExMMV9EMj4sDQo+ID4gPiAtICAg
ICAgICAgICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9WRU5DX0xUX1NFTD47DQo+ID4gPiAtICAgIGNs
b2NrLW5hbWVzID0gInZlbmNfc2VsX3NyYyIsDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgInZl
bmNfc2VsIiwNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAidmVuY19sdF9zZWxfc3JjIiwNCj4g
PiA+IC0gICAgICAgICAgICAgICAgICAidmVuY19sdF9zZWwiOw0KPiA+ID4gLSAgICBhc3NpZ25l
ZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19TRUw+LA0KPiA+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19MVF9TRUw+Ow0KPiA+ID4gLSAg
ICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX1ZFTkNQTExfRDI+
LA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBDTEtfVE9Q
X1VOSVZQTEwxX0QyPjsNCj4gPiA+ICsgICAgY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX1ZF
TkNfTFRfU0VMPjsNCj4gPiA+ICsgICAgY2xvY2stbmFtZXMgPSAidmVuY19sdF9zZWwiOw0KPiA+
ID4gKyAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19MVF9TRUw+
Ow0KPiA+ID4gKyAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZ0b3Bja2dlbiBDTEtfVE9Q
X1ZDT0RFQ1BMTF8zNzBQNT47DQo+ID4gPiAgICB9Ow0KPiA+ID4gLS0NCj4gPiA+IDEuOS4xDQoN
Cg==

