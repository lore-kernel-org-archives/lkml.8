Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D4C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93EB20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tY83siKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgBNFGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:06:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11367 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbgBNFF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:05:59 -0500
X-UUID: 261adbaa94cd42408c75edb182aaf88d-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Nk30hZyMmCTsGuoRVVxRW3RnPZuvr/Vyq/uf64SMG/w=;
        b=tY83siKs+zarzkOB5JykZEfAHsvV5RJJu1MFJiPLBH2DV8w0NSB2VIvtuObOXuTV8eUfDz0psN7N+s+BhRK5av/BAfHm0QTRwiHsIaMwsdOCirRLenDvyJM7ljsdiM87W47U3Z+n8M29RiND0XAXmYvWVH5Bn400+KaBPphfAhI=;
X-UUID: 261adbaa94cd42408c75edb182aaf88d-20200214
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1334308191; Fri, 14 Feb 2020 13:05:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 13:05:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 13:05:50 +0800
Message-ID: <1581656751.9307.0.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] dt-binding: gce: remove atomic_exec in mboxes
 property
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Fri, 14 Feb 2020 13:05:51 +0800
In-Reply-To: <20200214043325.16618-4-bibby.hsieh@mediatek.com>
References: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
         <20200214043325.16618-4-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTI6MzMgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBUaGVyZSBpcyBub3QgYW55IGNsaWVudCBkcml2ZXIgdXNpbmcgdGhpcyBm
ZWF0dXJlIG5vdywNCj4gc28gcmVtb3ZlIGl0IGZyb20gYmluZGluZy4NCj4gDQoNClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEJpYmJ5
IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbXRrLWdjZS50eHQgfCAxMCArKysrLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94
L210ay1nY2UudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gv
bXRrLWdjZS50eHQNCj4gaW5kZXggN2IxMzc4N2FiMTNkLi4wYjViMmE2YmNjNDggMTAwNjQ0DQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2Uu
dHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210
ay1nY2UudHh0DQo+IEBAIC0xNCwxMyArMTQsMTEgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4g
IC0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWduYWwgZnJvbSB0aGUgR0NFIGJsb2NrDQo+
ICAtIGNsb2NrOiBDbG9ja3MgYWNjb3JkaW5nIHRvIHRoZSBjb21tb24gY2xvY2sgYmluZGluZw0K
PiAgLSBjbG9jay1uYW1lczogTXVzdCBiZSAiZ2NlIiB0byBzdGFuZCBmb3IgR0NFIGNsb2NrDQo+
IC0tICNtYm94LWNlbGxzOiBTaG91bGQgYmUgMy4NCj4gLQk8JnBoYW5kbGUgY2hhbm5lbCBwcmlv
cml0eSBhdG9taWNfZXhlYz4NCj4gKy0gI21ib3gtY2VsbHM6IFNob3VsZCBiZSAyLg0KPiArCTwm
cGhhbmRsZSBjaGFubmVsIHByaW9yaXR5Pg0KPiAgCXBoYW5kbGU6IExhYmVsIG5hbWUgb2YgYSBn
Y2Ugbm9kZS4NCj4gIAljaGFubmVsOiBDaGFubmVsIG9mIG1haWxib3guIEJlIGVxdWFsIHRvIHRo
ZSB0aHJlYWQgaWQgb2YgR0NFLg0KPiAgCXByaW9yaXR5OiBQcmlvcml0eSBvZiBHQ0UgdGhyZWFk
Lg0KPiAtCWF0b21pY19leGVjOiBHQ0UgcHJvY2Vzc2luZyBjb250aW51b3VzIHBhY2tldHMgb2Yg
Y29tbWFuZHMgaW4gYXRvbWljDQo+IC0JCXdheS4NCj4gIA0KPiAgUmVxdWlyZWQgcHJvcGVydGll
cyBmb3IgYSBjbGllbnQgZGV2aWNlOg0KPiAgLSBtYm94ZXM6IENsaWVudCB1c2UgbWFpbGJveCB0
byBjb21tdW5pY2F0ZSB3aXRoIEdDRSwgaXQgc2hvdWxkIGhhdmUgdGhpcw0KPiBAQCAtNTQsOCAr
NTIsOCBAQCBFeGFtcGxlIGZvciBhIGNsaWVudCBkZXZpY2U6DQo+ICANCj4gIAltbXN5czogY2xv
Y2stY29udHJvbGxlckAxNDAwMDAwMCB7DQo+ICAJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLW1tc3lzIjsNCj4gLQkJbWJveGVzID0gPCZnY2UgMCBDTURRX1RIUl9QUklPX0xPV0VTVCAx
PiwNCj4gLQkJCSA8JmdjZSAxIENNRFFfVEhSX1BSSU9fTE9XRVNUIDE+Ow0KPiArCQltYm94ZXMg
PSA8JmdjZSAwIENNRFFfVEhSX1BSSU9fTE9XRVNUPiwNCj4gKwkJCSA8JmdjZSAxIENNRFFfVEhS
X1BSSU9fTE9XRVNUPjsNCj4gIAkJbXV0ZXgtZXZlbnQtZW9mID0gPENNRFFfRVZFTlRfTVVURVgw
X1NUUkVBTV9FT0YNCj4gIAkJCQlDTURRX0VWRU5UX01VVEVYMV9TVFJFQU1fRU9GPjsNCj4gIAkJ
bWVkaWF0ZWssZ2NlLWNsaWVudC1yZWcgPSA8JmdjZSBTVUJTWVNfMTQwMFhYWFggMHgzMDAwIDB4
MTAwMD4sDQoNCg==

