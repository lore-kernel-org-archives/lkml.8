Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0B9C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2700020718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VMNhfQPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgBQJFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:05:47 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:30687 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728697AbgBQJFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:05:41 -0500
X-UUID: a8e676ab0dd441bd99c3e605fcabf806-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vQjXF5b/dhN0jgoPQcivzh7j7m7tgJaNaeuzKj+drKw=;
        b=VMNhfQPQNjqiwlbO0ZQXlurstAqXAOerflZLb7pzaA6yXmvDxbkgkI7nqSOcRSzUMAeqmUz+jkMn5PAgq4F414+eMXlsRej4DGv3u+MxV5dMf5ULnszdEEL0J9nrn5pSJOnU7eUxkGvy+0+8JJtXzW6x0Em2j5VmQuQEByotCTQ=;
X-UUID: a8e676ab0dd441bd99c3e605fcabf806-20200217
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 213135339; Mon, 17 Feb 2020 17:05:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 17:04:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 17:03:36 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v1 1/3] dt-binding: gce: remove atomic_exec in mboxes property
Date:   Mon, 17 Feb 2020 17:05:30 +0800
Message-ID: <20200217090532.16019-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
References: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgaXMgbm90IGFueSBjbGllbnQgZHJpdmVyIHVzaW5nIHRoaXMgZmVhdHVyZSBub3csDQpz
byByZW1vdmUgaXQgZnJvbSBiaW5kaW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBCaWJieSBIc2llaCA8
YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRp
YXRlay5jb20+DQpSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94
L210ay1nY2UudHh0IHwgMTAgKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tdGstZ2NlLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2UudHh0DQppbmRleCA3YjEzNzg3YWIxM2QuLjBi
NWIyYTZiY2M0OCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tYWlsYm94L210ay1nY2UudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWFpbGJveC9tdGstZ2NlLnR4dA0KQEAgLTE0LDEzICsxNCwxMSBAQCBSZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KIC0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWduYWwgZnJvbSB0aGUg
R0NFIGJsb2NrDQogLSBjbG9jazogQ2xvY2tzIGFjY29yZGluZyB0byB0aGUgY29tbW9uIGNsb2Nr
IGJpbmRpbmcNCiAtIGNsb2NrLW5hbWVzOiBNdXN0IGJlICJnY2UiIHRvIHN0YW5kIGZvciBHQ0Ug
Y2xvY2sNCi0tICNtYm94LWNlbGxzOiBTaG91bGQgYmUgMy4NCi0JPCZwaGFuZGxlIGNoYW5uZWwg
cHJpb3JpdHkgYXRvbWljX2V4ZWM+DQorLSAjbWJveC1jZWxsczogU2hvdWxkIGJlIDIuDQorCTwm
cGhhbmRsZSBjaGFubmVsIHByaW9yaXR5Pg0KIAlwaGFuZGxlOiBMYWJlbCBuYW1lIG9mIGEgZ2Nl
IG5vZGUuDQogCWNoYW5uZWw6IENoYW5uZWwgb2YgbWFpbGJveC4gQmUgZXF1YWwgdG8gdGhlIHRo
cmVhZCBpZCBvZiBHQ0UuDQogCXByaW9yaXR5OiBQcmlvcml0eSBvZiBHQ0UgdGhyZWFkLg0KLQlh
dG9taWNfZXhlYzogR0NFIHByb2Nlc3NpbmcgY29udGludW91cyBwYWNrZXRzIG9mIGNvbW1hbmRz
IGluIGF0b21pYw0KLQkJd2F5Lg0KIA0KIFJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIGEgY2xpZW50
IGRldmljZToNCiAtIG1ib3hlczogQ2xpZW50IHVzZSBtYWlsYm94IHRvIGNvbW11bmljYXRlIHdp
dGggR0NFLCBpdCBzaG91bGQgaGF2ZSB0aGlzDQpAQCAtNTQsOCArNTIsOCBAQCBFeGFtcGxlIGZv
ciBhIGNsaWVudCBkZXZpY2U6DQogDQogCW1tc3lzOiBjbG9jay1jb250cm9sbGVyQDE0MDAwMDAw
IHsNCiAJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLW1tc3lzIjsNCi0JCW1ib3hlcyA9
IDwmZ2NlIDAgQ01EUV9USFJfUFJJT19MT1dFU1QgMT4sDQotCQkJIDwmZ2NlIDEgQ01EUV9USFJf
UFJJT19MT1dFU1QgMT47DQorCQltYm94ZXMgPSA8JmdjZSAwIENNRFFfVEhSX1BSSU9fTE9XRVNU
PiwNCisJCQkgPCZnY2UgMSBDTURRX1RIUl9QUklPX0xPV0VTVD47DQogCQltdXRleC1ldmVudC1l
b2YgPSA8Q01EUV9FVkVOVF9NVVRFWDBfU1RSRUFNX0VPRg0KIAkJCQlDTURRX0VWRU5UX01VVEVY
MV9TVFJFQU1fRU9GPjsNCiAJCW1lZGlhdGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2UgU1VCU1lT
XzE0MDBYWFhYIDB4MzAwMCAweDEwMDA+LA0KLS0gDQoyLjE4LjANCg==

