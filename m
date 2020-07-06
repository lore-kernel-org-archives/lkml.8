Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F5DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C96520724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Eil/MUly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGFLur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:50:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26193 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728264AbgGFLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:50:47 -0400
X-UUID: b63b5d4ad2d545fcba1674c27f637cfd-20200706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HgGv5GllBCIs4pALjjuZNyjAbCUoNT8X/DWFg7aCCeA=;
        b=Eil/MUly95lLDMnUXY6cJGmJ9v+WJe2uvQQN7gcFfyqstVDuYD+PjeTB7HilE89J8pWTFWOlTXsj/+H3m0J71jPnn5DXNl+f+1MlUb3nPsVePUJPq9DJAurk2YQPH7fCg9tfH80WJtGOIolwnQUjWV8rSDiJiZJRyJa0Mgp8E94=;
X-UUID: b63b5d4ad2d545fcba1674c27f637cfd-20200706
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 776962270; Mon, 06 Jul 2020 19:50:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Jul 2020 19:50:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 19:50:38 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] kasan: fix KASAN unit tests for tag-based KASAN
Date:   Mon, 6 Jul 2020 19:50:39 +0800
Message-ID: <20200706115039.16750-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2696D56F8A745539E46ABFD94ABC60186801271EB9B4EF448FB11D58BE36061F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2UgdXNlIHRhZy1iYXNlZCBLQVNBTiwgdGhlbiBLQVNBTiB1bml0IHRlc3RzIGRvbid0IGRldGVj
dCBvdXQtb2YtYm91bmRzDQptZW1vcnkgYWNjZXNzLiBUaGV5IG5lZWQgdG8gYmUgZml4ZWQuDQoN
CldpdGggdGFnLWJhc2VkIEtBU0FOLCB0aGUgc3RhdGUgb2YgZWFjaCAxNiBhbGlnbmVkIGJ5dGVz
IG9mIG1lbW9yeSBpcw0KZW5jb2RlZCBpbiBvbmUgc2hhZG93IGJ5dGUgYW5kIHRoZSBzaGFkb3cg
dmFsdWUgaXMgdGFnIG9mIHBvaW50ZXIsIHNvDQp3ZSBuZWVkIHRvIHJlYWQgbmV4dCBzaGFkb3cg
Ynl0ZSwgdGhlIHNoYWRvdyB2YWx1ZSBpcyBub3QgZXF1YWwgdG8gdGFnDQp2YWx1ZSBvZiBwb2lu
dGVyLCBzbyB0aGF0IHRhZy1iYXNlZCBLQVNBTiB3aWxsIGRldGVjdCBvdXQtb2YtYm91bmRzDQpt
ZW1vcnkgYWNjZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBt
ZWRpYXRlay5jb20+DQpTdWdnZXN0ZWQtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xl
LmNvbT4NCkNjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2aXJ0dW96em8uY29tPg0KQ2M6
IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCkNjOiBBbGV4YW5kZXIgUG90YXBl
bmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCkNjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5i
Z2dAZ21haWwuY29tPg0KQ2M6IEFuZHJleSBLb25vdmFsb3YgPGFuZHJleWtudmxAZ29vZ2xlLmNv
bT4NCkNjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KLS0tDQoN
CmNoYW5nZXMgc2luY2UgdjE6DQotIFJlZHVjZSBhbW91bnQgb2Ygbm9uLWNvbXBpbGVkIGNvZGUu
DQotIEtVbml0LUtBU0FOIEludGVncmF0aW9uIHBhdGNoc2V0IGlzIG5vdCBtZXJnZWQgeWV0LiBN
eSBwYXRjaCBzaG91bGQNCiAgaGF2ZSBjb25mbGljdCB3aXRoIGl0LCBpZiBuZWVkZWQsIHdlIGNh
biBjb250aW51ZSB0byB3YWl0IGl0Lg0KDQpjaGFuZ2VzIHNpbmNlIHYyOg0KLSBBZGQgb25lIG1h
cmNvIHRvIG1ha2UgdW5pdCB0ZXN0cyBtb3JlIHJlYWRhYmlsaXR5Lg0KDQotLS0NCiBsaWIvdGVz
dF9rYXNhbi5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9saWIvdGVzdF9rYXNhbi5jIGIvbGliL3Rlc3Rfa2FzYW4uYw0KaW5k
ZXggZTMwODdkOTBlMDBkLi5iNTA0OWE4MDdlMjUgMTAwNjQ0DQotLS0gYS9saWIvdGVzdF9rYXNh
bi5jDQorKysgYi9saWIvdGVzdF9rYXNhbi5jDQpAQCAtMjMsNiArMjMsOCBAQA0KIA0KICNpbmNs
dWRlIDxhc20vcGFnZS5oPg0KIA0KKyNkZWZpbmUgT09CX1RBR19PRkYgKElTX0VOQUJMRUQoQ09O
RklHX0tBU0FOX0dFTkVSSUMpID8gMCA6IDEzKQ0KKw0KIC8qDQogICogTm90ZTogdGVzdCBmdW5j
dGlvbnMgYXJlIG1hcmtlZCBub2lubGluZSBzbyB0aGF0IHRoZWlyIG5hbWVzIGFwcGVhciBpbg0K
ICAqIHJlcG9ydHMuDQpAQCAtNDAsNyArNDIsOCBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX2lu
aXQga21hbGxvY19vb2JfcmlnaHQodm9pZCkNCiAJCXJldHVybjsNCiAJfQ0KIA0KLQlwdHJbc2l6
ZV0gPSAneCc7DQorCXB0cltzaXplICsgT09CX1RBR19PRkZdID0gJ3gnOw0KKw0KIAlrZnJlZShw
dHIpOw0KIH0NCiANCkBAIC05Miw3ICs5NSw4IEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5p
dCBrbWFsbG9jX3BhZ2VhbGxvY19vb2JfcmlnaHQodm9pZCkNCiAJCXJldHVybjsNCiAJfQ0KIA0K
LQlwdHJbc2l6ZV0gPSAwOw0KKwlwdHJbc2l6ZSArIE9PQl9UQUdfT0ZGXSA9IDA7DQorDQogCWtm
cmVlKHB0cik7DQogfQ0KIA0KQEAgLTE2Miw3ICsxNjYsOCBAQCBzdGF0aWMgbm9pbmxpbmUgdm9p
ZCBfX2luaXQga21hbGxvY19vb2Jfa3JlYWxsb2NfbW9yZSh2b2lkKQ0KIAkJcmV0dXJuOw0KIAl9
DQogDQotCXB0cjJbc2l6ZTJdID0gJ3gnOw0KKwlwdHIyW3NpemUyICsgT09CX1RBR19PRkZdID0g
J3gnOw0KKw0KIAlrZnJlZShwdHIyKTsNCiB9DQogDQpAQCAtMTgwLDcgKzE4NSw5IEBAIHN0YXRp
YyBub2lubGluZSB2b2lkIF9faW5pdCBrbWFsbG9jX29vYl9rcmVhbGxvY19sZXNzKHZvaWQpDQog
CQlrZnJlZShwdHIxKTsNCiAJCXJldHVybjsNCiAJfQ0KLQlwdHIyW3NpemUyXSA9ICd4JzsNCisN
CisJcHRyMltzaXplMiArIE9PQl9UQUdfT0ZGXSA9ICd4JzsNCisNCiAJa2ZyZWUocHRyMik7DQog
fQ0KIA0KQEAgLTIxNiw3ICsyMjMsOCBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX2luaXQga21h
bGxvY19vb2JfbWVtc2V0XzIodm9pZCkNCiAJCXJldHVybjsNCiAJfQ0KIA0KLQltZW1zZXQocHRy
KzcsIDAsIDIpOw0KKwltZW1zZXQocHRyICsgNyArIE9PQl9UQUdfT0ZGLCAwLCAyKTsNCisNCiAJ
a2ZyZWUocHRyKTsNCiB9DQogDQpAQCAtMjMyLDcgKzI0MCw4IEBAIHN0YXRpYyBub2lubGluZSB2
b2lkIF9faW5pdCBrbWFsbG9jX29vYl9tZW1zZXRfNCh2b2lkKQ0KIAkJcmV0dXJuOw0KIAl9DQog
DQotCW1lbXNldChwdHIrNSwgMCwgNCk7DQorCW1lbXNldChwdHIgKyA1ICsgT09CX1RBR19PRkYs
IDAsIDQpOw0KKw0KIAlrZnJlZShwdHIpOw0KIH0NCiANCkBAIC0yNDksNyArMjU4LDggQEAgc3Rh
dGljIG5vaW5saW5lIHZvaWQgX19pbml0IGttYWxsb2Nfb29iX21lbXNldF84KHZvaWQpDQogCQly
ZXR1cm47DQogCX0NCiANCi0JbWVtc2V0KHB0cisxLCAwLCA4KTsNCisJbWVtc2V0KHB0ciArIDEg
KyBPT0JfVEFHX09GRiwgMCwgOCk7DQorDQogCWtmcmVlKHB0cik7DQogfQ0KIA0KQEAgLTI2NSw3
ICsyNzUsOCBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX2luaXQga21hbGxvY19vb2JfbWVtc2V0
XzE2KHZvaWQpDQogCQlyZXR1cm47DQogCX0NCiANCi0JbWVtc2V0KHB0cisxLCAwLCAxNik7DQor
CW1lbXNldChwdHIgKyAxICsgT09CX1RBR19PRkYsIDAsIDE2KTsNCisNCiAJa2ZyZWUocHRyKTsN
CiB9DQogDQpAQCAtMjgxLDcgKzI5Miw4IEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBr
bWFsbG9jX29vYl9pbl9tZW1zZXQodm9pZCkNCiAJCXJldHVybjsNCiAJfQ0KIA0KLQltZW1zZXQo
cHRyLCAwLCBzaXplKzUpOw0KKwltZW1zZXQocHRyLCAwLCBzaXplICsgNSArIE9PQl9UQUdfT0ZG
KTsNCisNCiAJa2ZyZWUocHRyKTsNCiB9DQogDQpAQCAtNDE1LDcgKzQyNyw4IEBAIHN0YXRpYyBu
b2lubGluZSB2b2lkIF9faW5pdCBrbWVtX2NhY2hlX29vYih2b2lkKQ0KIAkJcmV0dXJuOw0KIAl9
DQogDQotCSpwID0gcFtzaXplXTsNCisJKnAgPSBwW3NpemUgKyBPT0JfVEFHX09GRl07DQorDQog
CWttZW1fY2FjaGVfZnJlZShjYWNoZSwgcCk7DQogCWttZW1fY2FjaGVfZGVzdHJveShjYWNoZSk7
DQogfQ0KQEAgLTUxMiwyNSArNTI1LDI1IEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBj
b3B5X3VzZXJfdGVzdCh2b2lkKQ0KIAl9DQogDQogCXByX2luZm8oIm91dC1vZi1ib3VuZHMgaW4g
Y29weV9mcm9tX3VzZXIoKVxuIik7DQotCXVudXNlZCA9IGNvcHlfZnJvbV91c2VyKGttZW0sIHVz
ZXJtZW0sIHNpemUgKyAxKTsNCisJdW51c2VkID0gY29weV9mcm9tX3VzZXIoa21lbSwgdXNlcm1l
bSwgc2l6ZSArIDEgKyBPT0JfVEFHX09GRik7DQogDQogCXByX2luZm8oIm91dC1vZi1ib3VuZHMg
aW4gY29weV90b191c2VyKClcbiIpOw0KLQl1bnVzZWQgPSBjb3B5X3RvX3VzZXIodXNlcm1lbSwg
a21lbSwgc2l6ZSArIDEpOw0KKwl1bnVzZWQgPSBjb3B5X3RvX3VzZXIodXNlcm1lbSwga21lbSwg
c2l6ZSArIDEgKyBPT0JfVEFHX09GRik7DQogDQogCXByX2luZm8oIm91dC1vZi1ib3VuZHMgaW4g
X19jb3B5X2Zyb21fdXNlcigpXG4iKTsNCi0JdW51c2VkID0gX19jb3B5X2Zyb21fdXNlcihrbWVt
LCB1c2VybWVtLCBzaXplICsgMSk7DQorCXVudXNlZCA9IF9fY29weV9mcm9tX3VzZXIoa21lbSwg
dXNlcm1lbSwgc2l6ZSArIDEgKyBPT0JfVEFHX09GRik7DQogDQogCXByX2luZm8oIm91dC1vZi1i
b3VuZHMgaW4gX19jb3B5X3RvX3VzZXIoKVxuIik7DQotCXVudXNlZCA9IF9fY29weV90b191c2Vy
KHVzZXJtZW0sIGttZW0sIHNpemUgKyAxKTsNCisJdW51c2VkID0gX19jb3B5X3RvX3VzZXIodXNl
cm1lbSwga21lbSwgc2l6ZSArIDEgKyBPT0JfVEFHX09GRik7DQogDQogCXByX2luZm8oIm91dC1v
Zi1ib3VuZHMgaW4gX19jb3B5X2Zyb21fdXNlcl9pbmF0b21pYygpXG4iKTsNCi0JdW51c2VkID0g
X19jb3B5X2Zyb21fdXNlcl9pbmF0b21pYyhrbWVtLCB1c2VybWVtLCBzaXplICsgMSk7DQorCXVu
dXNlZCA9IF9fY29weV9mcm9tX3VzZXJfaW5hdG9taWMoa21lbSwgdXNlcm1lbSwgc2l6ZSArIDEg
KyBPT0JfVEFHX09GRik7DQogDQogCXByX2luZm8oIm91dC1vZi1ib3VuZHMgaW4gX19jb3B5X3Rv
X3VzZXJfaW5hdG9taWMoKVxuIik7DQotCXVudXNlZCA9IF9fY29weV90b191c2VyX2luYXRvbWlj
KHVzZXJtZW0sIGttZW0sIHNpemUgKyAxKTsNCisJdW51c2VkID0gX19jb3B5X3RvX3VzZXJfaW5h
dG9taWModXNlcm1lbSwga21lbSwgc2l6ZSArIDEgKyBPT0JfVEFHX09GRik7DQogDQogCXByX2lu
Zm8oIm91dC1vZi1ib3VuZHMgaW4gc3RybmNweV9mcm9tX3VzZXIoKVxuIik7DQotCXVudXNlZCA9
IHN0cm5jcHlfZnJvbV91c2VyKGttZW0sIHVzZXJtZW0sIHNpemUgKyAxKTsNCisJdW51c2VkID0g
c3RybmNweV9mcm9tX3VzZXIoa21lbSwgdXNlcm1lbSwgc2l6ZSArIDEgKyBPT0JfVEFHX09GRik7
DQogDQogCXZtX211bm1hcCgodW5zaWduZWQgbG9uZyl1c2VybWVtLCBQQUdFX1NJWkUpOw0KIAlr
ZnJlZShrbWVtKTsNCi0tIA0KMi4xOC4wDQo=

