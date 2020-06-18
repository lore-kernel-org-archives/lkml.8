Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B84D21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CVo1LLaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgFRJOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:14:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60309 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727037AbgFRJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:14:19 -0400
X-UUID: a674bac57478429b9da3629ca5aeca07-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4XnqJ20IExga/K0IhPzstjZ7zg9Stdygd6pci2+yWAc=;
        b=CVo1LLaj/bLv/34Qw0lYsCGE0OrALjDzYWCBKeZGuV+xQ3RmI6L5eX5nOpqEgjwIT60kNz8sSV28Blwn0dABSfY1j1Xd3CGF8R13DcZHX70JHXxH4cZQx9KDqjPb7Zst5NkAxNaojoqwBS2YA8JWMZCM6E+2OhnNNzZK+QZFAVQ=;
X-UUID: a674bac57478429b9da3629ca5aeca07-20200618
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1166593568; Thu, 18 Jun 2020 17:14:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 17:14:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 17:14:09 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Jim Lin <jilin@nvidia.com>,
        Siqi Lin <siqilin@google.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
CC:     Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v3] usb: replace hardcode maximum usb string length by definition
Date:   Thu, 18 Jun 2020 17:13:38 +0800
Message-ID: <1592471618-29428-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
References: <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbGFjZSBoYXJkY29kZSBtYXhpbXVtIHVzYiBzdHJpbmcgbGVuZ3RoICgxMjYgYnl0ZXMpIGJ5
IGRlZmluaXRpb24NCiJNQVhfVVNCX1NUUklOR19MRU4iLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYWNw
YXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IEFsYW4gU3Rlcm4g
PHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+DQotLS0NCkNoYW5nZXMgZm9yIHYyOg0KICAtIEFk
ZCBkZWZpbml0aW9uICJNQVhfVVNCX1NUUklOR19MRU4iIGluIGNoOS5oIGluc3RlYWQgb2YgaW4g
dXNiLmguDQogICAgVGhhbmtzIGZvciBBbGFuJ3Mgc3VnZ2VzdGlvbi4NCkNoYW5nZXMgZm9yIHYz
Og0KICAtIFJlYmFzZSB0byA1LjgtcmMxIGFuZCByZXNvbHZlIGNvbmZsaWN0Lg0KDQogZHJpdmVy
cy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIHwgICAgNCArKy0tDQogZHJpdmVycy91c2IvZ2FkZ2V0
L2NvbmZpZ2ZzLmMgIHwgICAgMiArLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91c2JzdHJpbmcuYyB8
ICAgIDQgKystLQ0KIGluY2x1ZGUvdWFwaS9saW51eC91c2IvY2g5LmggICB8ICAgIDMgKysrDQog
NCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMgYi9kcml2ZXJzL3VzYi9nYWRn
ZXQvY29tcG9zaXRlLmMNCmluZGV4IGNiNDk1MGMuLmQwZGUwMTYgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21w
b3NpdGUuYw0KQEAgLTEwNDEsNyArMTA0MSw3IEBAIHN0YXRpYyB2b2lkIGNvbGxlY3RfbGFuZ3Mo
c3RydWN0IHVzYl9nYWRnZXRfc3RyaW5ncyAqKnNwLCBfX2xlMTYgKmJ1ZikNCiAJd2hpbGUgKCpz
cCkgew0KIAkJcyA9ICpzcDsNCiAJCWxhbmd1YWdlID0gY3B1X3RvX2xlMTYocy0+bGFuZ3VhZ2Up
Ow0KLQkJZm9yICh0bXAgPSBidWY7ICp0bXAgJiYgdG1wIDwgJmJ1ZlsxMjZdOyB0bXArKykgew0K
KwkJZm9yICh0bXAgPSBidWY7ICp0bXAgJiYgdG1wIDwgJmJ1ZltNQVhfVVNCX1NUUklOR19MRU5d
OyB0bXArKykgew0KIAkJCWlmICgqdG1wID09IGxhbmd1YWdlKQ0KIAkJCQlnb3RvIHJlcGVhdDsN
CiAJCX0NCkBAIC0xMTE2LDcgKzExMTYsNyBAQCBzdGF0aWMgaW50IGdldF9zdHJpbmcoc3RydWN0
IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2LA0KIAkJCWNvbGxlY3RfbGFuZ3Moc3AsIHMtPndEYXRh
KTsNCiAJCX0NCiANCi0JCWZvciAobGVuID0gMDsgbGVuIDw9IDEyNiAmJiBzLT53RGF0YVtsZW5d
OyBsZW4rKykNCisJCWZvciAobGVuID0gMDsgbGVuIDw9IE1BWF9VU0JfU1RSSU5HX0xFTiAmJiBz
LT53RGF0YVtsZW5dOyBsZW4rKykNCiAJCQljb250aW51ZTsNCiAJCWlmICghbGVuKQ0KIAkJCXJl
dHVybiAtRUlOVkFMOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb25maWdmcy5j
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbmZpZ2ZzLmMNCmluZGV4IDMyYjYzN2UuLjcwZGQ0YmEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYw0KKysrIGIvZHJpdmVy
cy91c2IvZ2FkZ2V0L2NvbmZpZ2ZzLmMNCkBAIC0xMTUsNyArMTE1LDcgQEAgc3RhdGljIGludCB1
c2Jfc3RyaW5nX2NvcHkoY29uc3QgY2hhciAqcywgY2hhciAqKnNfY29weSkNCiAJY2hhciAqc3Ry
Ow0KIAljaGFyICpjb3B5ID0gKnNfY29weTsNCiAJcmV0ID0gc3RybGVuKHMpOw0KLQlpZiAocmV0
ID4gMTI2KQ0KKwlpZiAocmV0ID4gTUFYX1VTQl9TVFJJTkdfTEVOKQ0KIAkJcmV0dXJuIC1FT1ZF
UkZMT1c7DQogDQogCXN0ciA9IGtzdHJkdXAocywgR0ZQX0tFUk5FTCk7DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VzYnN0cmluZy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VzYnN0
cmluZy5jDQppbmRleCA3YzI0ZDFjLi44YThkNjQ3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VzYnN0cmluZy5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdXNic3RyaW5nLmMN
CkBAIC01NSw5ICs1NSw5IEBADQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCiAJLyogc3RyaW5nIGRl
c2NyaXB0b3JzIGhhdmUgbGVuZ3RoLCB0YWcsIHRoZW4gVVRGMTYtTEUgdGV4dCAqLw0KLQlsZW4g
PSBtaW4gKChzaXplX3QpIDEyNiwgc3RybGVuIChzLT5zKSk7DQorCWxlbiA9IG1pbigoc2l6ZV90
KU1BWF9VU0JfU1RSSU5HX0xFTiwgc3RybGVuKHMtPnMpKTsNCiAJbGVuID0gdXRmOHNfdG9fdXRm
MTZzKHMtPnMsIGxlbiwgVVRGMTZfTElUVExFX0VORElBTiwNCi0JCQkod2NoYXJfdCAqKSAmYnVm
WzJdLCAxMjYpOw0KKwkJCSh3Y2hhcl90ICopICZidWZbMl0sIE1BWF9VU0JfU1RSSU5HX0xFTik7
DQogCWlmIChsZW4gPCAwKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCWJ1ZiBbMF0gPSAobGVuICsg
MSkgKiAyOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC91c2IvY2g5LmggYi9pbmNs
dWRlL3VhcGkvbGludXgvdXNiL2NoOS5oDQppbmRleCAyYjYyM2YzLi5jYzAyZDA1IDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3VzYi9jaDkuaA0KKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3VzYi9jaDkuaA0KQEAgLTM2NCw2ICszNjQsOSBAQCBzdHJ1Y3QgdXNiX2NvbmZpZ19kZXNj
cmlwdG9yIHsNCiANCiAvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLw0KIA0KKy8qIFVTQiBTdHJpbmcgZGVz
Y3JpcHRvcnMgY2FuIGNvbnRhaW4gYXQgbW9zdCAxMjYgY2hhcmFjdGVycy4gKi8NCisjZGVmaW5l
IE1BWF9VU0JfU1RSSU5HX0xFTgkxMjYNCisNCiAvKiBVU0JfRFRfU1RSSU5HOiBTdHJpbmcgZGVz
Y3JpcHRvciAqLw0KIHN0cnVjdCB1c2Jfc3RyaW5nX2Rlc2NyaXB0b3Igew0KIAlfX3U4ICBiTGVu
Z3RoOw0KLS0gDQoxLjcuOS41DQo=

