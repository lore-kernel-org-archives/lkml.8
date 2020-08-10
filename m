Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE606C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979D8206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D5ndVrMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHJDMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:12:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbgHJDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:12:06 -0400
X-UUID: 96ffc5b94c4b4961b0c8d46cd09dd008-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n5K4ha85DkZyz2NR99rNXSJw2MdSeUvrAikKRNypFvs=;
        b=D5ndVrMOxpEPRJwKxgh5O7/NBrLyZ8to7+BMcfLCOfceNKo/TovZ7lH7GX0m5aM6RGdmZqiWjur5W/d6lyDiwvK2R2VcjixtQnf5zawsQRT4wAn6/sx5AeaMCyJsmOv0+jRpbKJcuR4W6pP8mRtDXjkQ2Fk3p22JnX7XSAcSO6M=;
X-UUID: 96ffc5b94c4b4961b0c8d46cd09dd008-20200810
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1856708292; Mon, 10 Aug 2020 11:06:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 11:06:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 11:06:49 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, <eason.yen@mediatek.com>,
        <shane.chien@mediatek.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v2 2/2] dt-bindings: mediatek: mt6359: add codec document
Date:   Mon, 10 Aug 2020 11:05:54 +0800
Message-ID: <1597028754-7732-3-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIE1lZGlhVGVrIE1UNjM1OSBjb2RlYyBkb2N1bWVudC4NCg0KU2lnbmVk
LW9mZi1ieTogSmlheGluIFl1IDxqaWF4aW4ueXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgICAgICAgfCA2OCArKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210
NjM1OS55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc291bmQvbXQ2MzU5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbXQ2MzU5LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5j
ZDU5ZGJlDQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwNCkBAIC0wLDAgKzEsNjggQEANCisjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjIN
CistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvdW5kL210NjM1OS55
YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KKw0KK3RpdGxlOiBNZWRpYXRlayBNVDYzNTkgQ29kZWMgRGV2aWNlIFRyZWUgQmluZGlu
Z3MNCisNCittYWludGFpbmVyczoNCisgIC0gRWFzb24gWWVuIDxlYXNvbi55ZW5AbWVkaWF0ZWsu
Y29tPg0KKyAgLSBKaWF4aW4gWXUgPGppYXhpbi55dUBtZWRpYXRlay5jb20+DQorICAtIFNoYW5l
IENoaWVuIDxzaGFuZS5jaGllbkBtZWRpYXRlay5jb20+DQorDQorZGVzY3JpcHRpb246IHwNCisg
IFRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4gTVQ2MzU5IGFuZCBTb0MgaXMgdGhyb3VnaCBNZWRp
YXRlayBQTUlDIHdyYXBwZXIuDQorICBGb3IgbW9yZSBkZXRhaWwsIHBsZWFzZSB2aXNpdCBNZWRp
YXRlayBQTUlDIHdyYXBwZXIgZG9jdW1lbnRhdGlvbi4NCisgIE11c3QgYmUgYSBjaGlsZCBub2Rl
IG9mIFBNSUMgd3JhcHBlci4NCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAg
Y29uc3Q6IG1lZGlhdGVrLG10NjM1OS1zb3VuZA0KKw0KKyAgbWVkaWF0ZWssZG1pYy1tb2RlOg0K
KyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCisgICAg
ZGVzY3JpcHRpb246IHwNCisgICAgICBJbmRpY2F0ZXMgaG93IG1hbnkgZGF0YSBwaW5zIGFyZSB1
c2VkIHRvIHRyYW5zbWl0IHR3byBjaGFubmVscyBvZiBQRE0NCisgICAgICBzaWduYWwuIDAgbWVh
bnMgdHdvIHdpcmVzLCAxIG1lYW5zIG9uZSB3aXJlLiBEZWZhdWx0IHZhbHVlIGlzIDAuDQorICAg
IGVudW06DQorICAgICAgLSAwICMgb25lIHdpcmUNCisgICAgICAtIDEgIyB0d28gd2lyZXMNCisN
CisgIG1lZGlhdGVrLG1pYy10eXBlLTA6DQorICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3VpbnQzMg0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIFNwZWNpZmll
cyB0aGUgdHlwZSBvZiBtaWMgdHlwZSBjb25uZWN0ZWQgdG8gYWRjMA0KKw0KKyAgICBlbnVtOg0K
KyAgICAgIC0gMCAjIElETEUgLSBtaWMgaW4gdHVybi1vZmYgc3RhdHVzDQorICAgICAgLSAxICMg
QUNDIC0gYW5hbG9nIG1pYyB3aXRoIGFsdGVybmF0aW5nIGNvdXBsaW5nDQorICAgICAgLSAyICMg
RE1JQyAtIGRpZ2l0YWwgbWljDQorICAgICAgLSAzICMgRENDIC0gYW5hbG9nIG1pYyB3aXRoIGRp
cmVjdCBjb3VwaW5nDQorICAgICAgLSA0ICMgRENDX0VDTV9ESUZGIC0gYW5hbG9nIGVsZWN0cmV0
IGNvbmRlbnNlciBtaWMgd2l0aCBkaWZmZXJlbnRpYWwgbW9kZQ0KKyAgICAgIC0gNSAjIERDQ19F
Q01fU0lOR0xFIC0gYW5hbG9nIGVsZWN0cmV0IGNvbmRlbnNlciBtaWMgd2l0aCBzaW5nbGUgbW9k
ZQ0KKw0KKyAgbWVkaWF0ZWssbWljLXR5cGUtMToNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgU3Bl
Y2lmaWVzIHRoZSB0eXBlIG9mIG1pYyB0eXBlIGNvbm5lY3RlZCB0byBhZGMxDQorDQorICBtZWRp
YXRlayxtaWMtdHlwZS0yOg0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCisgICAgZGVzY3JpcHRpb246IHwNCisgICAgICBTcGVjaWZpZXMgdGhlIHR5
cGUgb2YgbWljIHR5cGUgY29ubmVjdGVkIHRvIGFkYzINCisNCityZXF1aXJlZDoNCisgIC0gY29t
cGF0aWJsZQ0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0K
KyAgLSB8DQorICAgIG10NjM1OWNvZGVjOiBtdDYzNTljb2RlYyB7DQorICAgICAgY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDYzNTktc291bmQiOw0KKyAgICAgIG1lZGlhdGVrLGRtaWMtbW9kZSA9
IDwwPjsNCisgICAgICBtZWRpYXRlayxtaWMtdHlwZS0wID0gPDI+Ow0KKyAgICB9Ow0KKw0KKy4u
Lg0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

