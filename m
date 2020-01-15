Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EA5C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CCD222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NwUu7Mic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgAOOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:01:38 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:14321 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729934AbgAOOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:01:32 -0500
X-UUID: 1bcc5aa316f04e159577dda9d675fba0-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1zzPyvAy87Qpl4i7Jvu5cxPmnsWNRTfp6raNBTPD/Ag=;
        b=NwUu7MicjxywB3lhbVrCMhbYYqQXTxiAUDY3hlZisXc1kizuZJGH5xJDi+i/mO9ZC5U6K+2tYhskOEJbzVkynr3AJ9cl4PEwICnabqUbLp+42wW7KGxInJvvqodIiXxpVSm1KtkdIEai1qdCrV1ny/dzx21c4NQsQI7WpHXK8e4=;
X-UUID: 1bcc5aa316f04e159577dda9d675fba0-20200115
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 918427187; Wed, 15 Jan 2020 22:00:55 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 Jan
 2020 21:59:48 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 15 Jan 2020 22:01:04 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v8 1/8] dt-bindings: display: panel: Add BOE tv101wum-n16 panel bindings
Date:   Wed, 15 Jan 2020 21:59:51 +0800
Message-ID: <20200115135958.126303-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115135958.126303-1-jitao.shi@mediatek.com>
References: <20200115135958.126303-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3E97ECF72CC10E7A5A1785BA4E4CC0653CFB3943D64BE1E6840C7A78AD3C07612000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRvY3VtZW50YXRpb24gZm9yIGJvZSB0djEwMXd1bS1uMTYgcGFuZWwuDQoNClNpZ25lZC1v
ZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBT
YW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+DQotLS0NCiAuLi4vZGlzcGxheS9wYW5lbC9i
b2UsdHYxMDF3dW0tbmw2LnlhbWwgICAgICAgfCA3NCArKysrKysrKysrKysrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3VtLW5s
Ni55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3dW0tbmw2LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3dW0tbmw2LnlhbWwNCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmQzOGFlZTIyZDQwNg0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
cGFuZWwvYm9lLHR2MTAxd3VtLW5sNi55YW1sDQpAQCAtMCwwICsxLDc0IEBADQorIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3dW0tbmw2Lnlh
bWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQorDQordGl0bGU6IEJPRSBUVjEwMVdVTS1ObDYgRFNJIERpc3BsYXkgUGFuZWwNCisNCitt
YWludGFpbmVyczoNCisgIC0gVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNv
bT4NCisgIC0gU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KKyAgLSBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiBwYW5lbC1jb21t
b24ueWFtbCMNCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgICAgIGNvbnN0
OiBib2UsdHYxMDF3dW0tbmw2DQorDQorICByZWc6DQorICAgIGRlc2NyaXB0aW9uOiB0aGUgdmly
dHVhbCBjaGFubmVsIG51bWJlciBvZiBhIERTSSBwZXJpcGhlcmFsDQorDQorICBlbmFibGUtZ3Bp
b3M6DQorICAgIGRlc2NyaXB0aW9uOiBhIEdQSU8gc3BlYyBmb3IgdGhlIGVuYWJsZSBwaW4NCisN
CisgIHBwMTgwMC1zdXBwbHk6DQorICAgIGRlc2NyaXB0aW9uOiBjb3JlIHZvbHRhZ2Ugc3VwcGx5
DQorDQorICBhdmRkLXN1cHBseToNCisgICAgZGVzY3JpcHRpb246IHBoYW5kbGUgb2YgdGhlIHJl
Z3VsYXRvciB0aGF0IHByb3ZpZGVzIHBvc2l0aXZlIHZvbHRhZ2UNCisNCisgIGF2ZWUtc3VwcGx5
Og0KKyAgICBkZXNjcmlwdGlvbjogcGhhbmRsZSBvZiB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlk
ZXMgbmVnYXRpdmUgdm9sdGFnZQ0KKw0KKyAgYmFja2xpZ2h0Og0KKyAgICBkZXNjcmlwdGlvbjog
cGhhbmRsZSBvZiB0aGUgYmFja2xpZ2h0IGRldmljZSBhdHRhY2hlZCB0byB0aGUgcGFuZWwNCisN
CisgIHBvcnQ6IHRydWUNCisNCityZXF1aXJlZDoNCisgLSBjb21wYXRpYmxlDQorIC0gcmVnDQor
IC0gZW5hYmxlLWdwaW9zDQorIC0gcHAxODAwLXN1cHBseQ0KKyAtIGF2ZGQtc3VwcGx5DQorIC0g
YXZlZS1zdXBwbHkNCisgLSBiYWNrbGlnaHQNCisNCithZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICBkc2kgew0KKyAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQorICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisgICAgICAgIHBhbmVs
QDAgew0KKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYm9lLHR2MTAxd3VtLW5sNiI7DQorICAg
ICAgICAgICAgcmVnID0gPDA+Ow0KKyAgICAgICAgICAgIGVuYWJsZS1ncGlvcyA9IDwmcGlvIDQ1
IDA+Ow0KKyAgICAgICAgICAgIGF2ZGQtc3VwcGx5ID0gPCZwcHZhcm5fbGNkPjsNCisgICAgICAg
ICAgICBhdmVlLXN1cHBseSA9IDwmcHB2YXJwX2xjZD47DQorICAgICAgICAgICAgcHAxODAwLXN1
cHBseSA9IDwmcHAxODAwX2xjZD47DQorICAgICAgICAgICAgYmFja2xpZ2h0ID0gPCZiYWNrbGln
aHRfbGNkMD47DQorICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KKyAgICAgICAgICAgIHBv
cnQgew0KKyAgICAgICAgICAgICAgICBwYW5lbF9pbjogZW5kcG9pbnQgew0KKyAgICAgICAgICAg
ICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkc2lfb3V0PjsNCisgICAgICAgICAgICAgICAg
fTsNCisgICAgICAgICAgICB9Ow0KKyAgICAgICAgfTsNCisgICAgfTsNCisNCisuLi4NCi0tIA0K
Mi4yMS4wDQo=

