Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39999206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b/X8KeEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgFOGRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:17:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50470 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728224AbgFOGRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:17:45 -0400
X-UUID: 736ae04e7d144c80a912027f8a13581b-20200615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8E6iUgy1G5r0W+amwcAzOmYy/2hIRJmEje9glVMcWAE=;
        b=b/X8KeEoJ94QKzFOYASCMzMn/nguGtHkwdi9D7frlPbA/VSjC8rvGQuQflitKCFsvC8qLQltFeQWJwzHhHFMm2Iwka/GPAMP1dr1OflTS3hLmTGwSt08KHMJmX4sa9l4bV3B5PZH9d8Zi0fo/BWyJhPqS2NsYwfNz+87voD7qIo=;
X-UUID: 736ae04e7d144c80a912027f8a13581b-20200615
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1518178391; Mon, 15 Jun 2020 14:17:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Jun 2020 14:17:38 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Jun 2020 14:17:36 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Jim Lin <jilin@nvidia.com>,
        Siqi Lin <siqilin@google.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH v2] usb: replace hardcode maximum usb string length by definition
Date:   Mon, 15 Jun 2020 14:17:35 +0800
Message-ID: <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1591939967-29943-1-git-send-email-macpaul.lin@mediatek.com>
References: <1591939967-29943-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ADBF890E55533CA3D08784747C3C1882B436106C825BCC1A9AAF43AD4F3E88222000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbGFjZSBoYXJkY29kZSBtYXhpbXVtIHVzYiBzdHJpbmcgbGVuZ3RoICgxMjYgYnl0ZXMpIGJ5
IGRlZmluaXRpb24NCiJNQVhfVVNCX1NUUklOR19MRU4iLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYWNw
YXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQpDaGFuZ2VzIGZvciB2MjoN
CiAgLSBBZGQgZGVmaW5pdGlvbiAiTUFYX1VTQl9TVFJJTkdfTEVOIiBpbiBjaDkuaCBpbnN0ZWFk
IG9mIGluIHVzYi5oLg0KICAgIFRoYW5rcyBmb3IgQWxhbidzIHN1Z2dlc3Rpb24uDQoNCiBkcml2
ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMgfCAgICA0ICsrLS0NCiBkcml2ZXJzL3VzYi9nYWRn
ZXQvY29uZmlnZnMuYyAgfCAgICAyICstDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VzYnN0cmluZy5j
IHwgICAgNCArKy0tDQogaW5jbHVkZS91YXBpL2xpbnV4L3VzYi9jaDkuaCAgIHwgICAgMyArKysN
CiA0IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyBiL2RyaXZlcnMvdXNiL2dh
ZGdldC9jb21wb3NpdGUuYw0KaW5kZXggY2I0OTUwYy4uZDBkZTAxNiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Nv
bXBvc2l0ZS5jDQpAQCAtMTA0MSw3ICsxMDQxLDcgQEAgc3RhdGljIHZvaWQgY29sbGVjdF9sYW5n
cyhzdHJ1Y3QgdXNiX2dhZGdldF9zdHJpbmdzICoqc3AsIF9fbGUxNiAqYnVmKQ0KIAl3aGlsZSAo
KnNwKSB7DQogCQlzID0gKnNwOw0KIAkJbGFuZ3VhZ2UgPSBjcHVfdG9fbGUxNihzLT5sYW5ndWFn
ZSk7DQotCQlmb3IgKHRtcCA9IGJ1ZjsgKnRtcCAmJiB0bXAgPCAmYnVmWzEyNl07IHRtcCsrKSB7
DQorCQlmb3IgKHRtcCA9IGJ1ZjsgKnRtcCAmJiB0bXAgPCAmYnVmW01BWF9VU0JfU1RSSU5HX0xF
Tl07IHRtcCsrKSB7DQogCQkJaWYgKCp0bXAgPT0gbGFuZ3VhZ2UpDQogCQkJCWdvdG8gcmVwZWF0
Ow0KIAkJfQ0KQEAgLTExMTYsNyArMTExNiw3IEBAIHN0YXRpYyBpbnQgZ2V0X3N0cmluZyhzdHJ1
Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYsDQogCQkJY29sbGVjdF9sYW5ncyhzcCwgcy0+d0Rh
dGEpOw0KIAkJfQ0KIA0KLQkJZm9yIChsZW4gPSAwOyBsZW4gPD0gMTI2ICYmIHMtPndEYXRhW2xl
bl07IGxlbisrKQ0KKwkJZm9yIChsZW4gPSAwOyBsZW4gPD0gTUFYX1VTQl9TVFJJTkdfTEVOICYm
IHMtPndEYXRhW2xlbl07IGxlbisrKQ0KIAkJCWNvbnRpbnVlOw0KIAkJaWYgKCFsZW4pDQogCQkJ
cmV0dXJuIC1FSU5WQUw7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbmZpZ2Zz
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYw0KaW5kZXggMzJiNjM3ZS4uNzBkZDRi
YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb25maWdmcy5jDQorKysgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYw0KQEAgLTExNSw3ICsxMTUsNyBAQCBzdGF0aWMgaW50
IHVzYl9zdHJpbmdfY29weShjb25zdCBjaGFyICpzLCBjaGFyICoqc19jb3B5KQ0KIAljaGFyICpz
dHI7DQogCWNoYXIgKmNvcHkgPSAqc19jb3B5Ow0KIAlyZXQgPSBzdHJsZW4ocyk7DQotCWlmIChy
ZXQgPiAxMjYpDQorCWlmIChyZXQgPiBNQVhfVVNCX1NUUklOR19MRU4pDQogCQlyZXR1cm4gLUVP
VkVSRkxPVzsNCiANCiAJc3RyID0ga3N0cmR1cChzLCBHRlBfS0VSTkVMKTsNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9nYWRnZXQvdXNic3RyaW5nLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdXNi
c3RyaW5nLmMNCmluZGV4IDdjMjRkMWMuLjhhOGQ2NDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdXNic3RyaW5nLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91c2JzdHJpbmcu
Yw0KQEAgLTU1LDkgKzU1LDkgQEANCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KIAkvKiBzdHJpbmcg
ZGVzY3JpcHRvcnMgaGF2ZSBsZW5ndGgsIHRhZywgdGhlbiBVVEYxNi1MRSB0ZXh0ICovDQotCWxl
biA9IG1pbigoc2l6ZV90KSAxMjYsIHN0cmxlbiAocy0+cykpOw0KKwlsZW4gPSBtaW4oKHNpemVf
dClNQVhfVVNCX1NUUklOR19MRU4sIHN0cmxlbihzLT5zKSk7DQogCWxlbiA9IHV0ZjhzX3RvX3V0
ZjE2cyhzLT5zLCBsZW4sIFVURjE2X0xJVFRMRV9FTkRJQU4sDQotCQkJKHdjaGFyX3QgKikgJmJ1
ZlsyXSwgMTI2KTsNCisJCQkod2NoYXJfdCAqKSAmYnVmWzJdLCBNQVhfVVNCX1NUUklOR19MRU4p
Ow0KIAlpZiAobGVuIDwgMCkNCiAJCXJldHVybiAtRUlOVkFMOw0KIAlidWYgWzBdID0gKGxlbiAr
IDEpICogMjsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdXNiL2NoOS5oIGIvaW5j
bHVkZS91YXBpL2xpbnV4L3VzYi9jaDkuaA0KaW5kZXggMmI2MjNmMy4uY2MwMmQwNSAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC91c2IvY2g5LmgNCisrKyBiL2luY2x1ZGUvdWFwaS9s
aW51eC91c2IvY2g5LmgNCkBAIC0zNjQsNiArMzY0LDkgQEAgc3RydWN0IHVzYl9jb25maWdfZGVz
Y3JpcHRvciB7DQogDQogLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8NCiANCisvKiBVU0IgU3RyaW5nIGRl
c2NyaXB0b3JzIGNhbiBjb250YWluIGF0IG1vc3QgMTI2IGNoYXJhY3RlcnMuICovDQorI2RlZmlu
ZSBNQVhfVVNCX1NUUklOR19MRU4JMTI2DQorDQogLyogVVNCX0RUX1NUUklORzogU3RyaW5nIGRl
c2NyaXB0b3IgKi8NCiBzdHJ1Y3QgdXNiX3N0cmluZ19kZXNjcmlwdG9yIHsNCiAJX191OCAgYkxl
bmd0aDsNCi0tIA0KMS43LjkuNQ0K

