Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A035C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0AE2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L20rOhkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUBkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:40:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45047 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgDUBkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:40:14 -0400
X-UUID: f69d6d55cb2f45d897c05192bdd4f3dc-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kvJkIFmK0+Fajj8XRCQra0WIBlEJ5d/F7a174u9kVSw=;
        b=L20rOhkQrm5OIsQ7JG1D0X0FejXBuxj46p0oxGM0IovM9eOanQ6EcQ1hKv2FxtJ5BIxY01+wvIuWmLwMCQO2My/FSRNUWt8sQxZ+tYMk3XaZiaLLBLAMdf8QcNsx1z7qb++B2ZBH/wlwK++uMf6P42qsGprWsWWXYLLqhxXX/Oc=;
X-UUID: f69d6d55cb2f45d897c05192bdd4f3dc-20200421
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2126729325; Tue, 21 Apr 2020 09:40:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 09:40:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 09:40:08 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH] kasan: fix KASAN unit tests for tag-based KASAN
Date:   Tue, 21 Apr 2020 09:40:07 +0800
Message-ID: <20200421014007.6012-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2CEDE98B7C8540AA4DB9C008FB938823D9E9F478584B868D577067E8D6D705122000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiB3ZSB1c2UgdGFnLWJhc2VkIEtBU0FOLCB0aGVuIEtBU0FOIHVuaXQgdGVzdHMgZG9uJ3Qg
ZGV0ZWN0DQpvdXQtb2YtYm91bmRzIG1lbW9yeSBhY2Nlc3MuIEJlY2F1c2Ugd2l0aCB0YWctYmFz
ZWQgS0FTQU4gdGhlIHN0YXRlDQpvZiBlYWNoIDE2IGFsaWduZWQgYnl0ZXMgb2YgbWVtb3J5IGlz
IGVuY29kZWQgaW4gb25lIHNoYWRvdyBieXRlDQphbmQgdGhlIHNoYWRvdyB2YWx1ZSBpcyB0YWcg
b2YgcG9pbnRlciwgc28gd2UgbmVlZCB0byByZWFkIG5leHQNCnNoYWRvdyBieXRlLCB0aGUgc2hh
ZG93IHZhbHVlIGlzIG5vdCBlcXVhbCB0byB0YWcgb2YgcG9pbnRlciwNCnRoZW4gdGFnLWJhc2Vk
IEtBU0FOIHdpbGwgZGV0ZWN0IG91dC1vZi1ib3VuZHMgbWVtb3J5IGFjY2Vzcy4NCg0KU2lnbmVk
LW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KQ2M6IEFuZHJl
eSBSeWFiaW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+DQpDYzogRG1pdHJ5IFZ5dWtvdiA8
ZHZ5dWtvdkBnb29nbGUuY29tPg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29n
bGUuY29tPg0KQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQpD
YzogQW5kcmV5IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPg0KQ2M6IEFuZHJldyBN
b3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQotLS0NCiBsaWIvdGVzdF9rYXNhbi5j
IHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9saWIvdGVzdF9rYXNhbi5jIGIvbGliL3Rlc3Rfa2FzYW4uYw0KaW5kZXggZTMwODdk
OTBlMDBkLi5hMTY0ZjZiNDdmZTUgMTAwNjQ0DQotLS0gYS9saWIvdGVzdF9rYXNhbi5jDQorKysg
Yi9saWIvdGVzdF9rYXNhbi5jDQpAQCAtNDAsNyArNDAsMTIgQEAgc3RhdGljIG5vaW5saW5lIHZv
aWQgX19pbml0IGttYWxsb2Nfb29iX3JpZ2h0KHZvaWQpDQogCQlyZXR1cm47DQogCX0NCiANCisj
aWZkZWYgQ09ORklHX0tBU0FOX0dFTkVSSUMNCiAJcHRyW3NpemVdID0gJ3gnOw0KKyNlbHNlDQor
CXB0cltzaXplICsgNV0gPSAneCc7DQorI2VuZGlmDQorDQogCWtmcmVlKHB0cik7DQogfQ0KIA0K
QEAgLTkyLDcgKzk3LDEyIEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBrbWFsbG9jX3Bh
Z2VhbGxvY19vb2JfcmlnaHQodm9pZCkNCiAJCXJldHVybjsNCiAJfQ0KIA0KKyNpZmRlZiBDT05G
SUdfS0FTQU5fR0VORVJJQw0KIAlwdHJbc2l6ZV0gPSAwOw0KKyNlbHNlDQorCXB0cltzaXplICsg
Nl0gPSAwOw0KKyNlbmRpZg0KKw0KIAlrZnJlZShwdHIpOw0KIH0NCiANCkBAIC0xNjIsNyArMTcy
LDExIEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBrbWFsbG9jX29vYl9rcmVhbGxvY19t
b3JlKHZvaWQpDQogCQlyZXR1cm47DQogCX0NCiANCisjaWZkZWYgQ09ORklHX0tBU0FOX0dFTkVS
SUMNCiAJcHRyMltzaXplMl0gPSAneCc7DQorI2Vsc2UNCisJcHRyMltzaXplMiArIDEzXSA9ICd4
JzsNCisjZW5kaWYNCiAJa2ZyZWUocHRyMik7DQogfQ0KIA0KQEAgLTE4MCw3ICsxOTQsMTIgQEAg
c3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0IGttYWxsb2Nfb29iX2tyZWFsbG9jX2xlc3Modm9p
ZCkNCiAJCWtmcmVlKHB0cjEpOw0KIAkJcmV0dXJuOw0KIAl9DQorDQorI2lmZGVmIENPTkZJR19L
QVNBTl9HRU5FUklDDQogCXB0cjJbc2l6ZTJdID0gJ3gnOw0KKyNlbHNlDQorCXB0cjJbc2l6ZTIg
KyAyXSA9ICd4JzsNCisjZW5kaWYNCiAJa2ZyZWUocHRyMik7DQogfQ0KIA0KQEAgLTIxNiw3ICsy
MzUsMTEgQEAgc3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0IGttYWxsb2Nfb29iX21lbXNldF8y
KHZvaWQpDQogCQlyZXR1cm47DQogCX0NCiANCisjaWZkZWYgQ09ORklHX0tBU0FOX0dFTkVSSUMN
CiAJbWVtc2V0KHB0cis3LCAwLCAyKTsNCisjZWxzZQ0KKwltZW1zZXQocHRyKzE1LCAwLCAyKTsN
CisjZW5kaWYNCiAJa2ZyZWUocHRyKTsNCiB9DQogDQpAQCAtMjMyLDcgKzI1NSwxMSBAQCBzdGF0
aWMgbm9pbmxpbmUgdm9pZCBfX2luaXQga21hbGxvY19vb2JfbWVtc2V0XzQodm9pZCkNCiAJCXJl
dHVybjsNCiAJfQ0KIA0KKyNpZmRlZiBDT05GSUdfS0FTQU5fR0VORVJJQw0KIAltZW1zZXQocHRy
KzUsIDAsIDQpOw0KKyNlbHNlDQorCW1lbXNldChwdHIrMTUsIDAsIDQpOw0KKyNlbmRpZg0KIAlr
ZnJlZShwdHIpOw0KIH0NCiANCkBAIC0yNDksNyArMjc2LDExIEBAIHN0YXRpYyBub2lubGluZSB2
b2lkIF9faW5pdCBrbWFsbG9jX29vYl9tZW1zZXRfOCh2b2lkKQ0KIAkJcmV0dXJuOw0KIAl9DQog
DQorI2lmZGVmIENPTkZJR19LQVNBTl9HRU5FUklDDQogCW1lbXNldChwdHIrMSwgMCwgOCk7DQor
I2Vsc2UNCisJbWVtc2V0KHB0cisxNSwgMCwgOCk7DQorI2VuZGlmDQogCWtmcmVlKHB0cik7DQog
fQ0KIA0KQEAgLTI2NSw3ICsyOTYsMTEgQEAgc3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0IGtt
YWxsb2Nfb29iX21lbXNldF8xNih2b2lkKQ0KIAkJcmV0dXJuOw0KIAl9DQogDQorI2lmZGVmIENP
TkZJR19LQVNBTl9HRU5FUklDDQogCW1lbXNldChwdHIrMSwgMCwgMTYpOw0KKyNlbHNlDQorCW1l
bXNldChwdHIrMTUsIDAsIDE2KTsNCisjZW5kaWYNCiAJa2ZyZWUocHRyKTsNCiB9DQogDQpAQCAt
MjgxLDcgKzMxNiwxMSBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX2luaXQga21hbGxvY19vb2Jf
aW5fbWVtc2V0KHZvaWQpDQogCQlyZXR1cm47DQogCX0NCiANCisjaWZkZWYgQ09ORklHX0tBU0FO
X0dFTkVSSUMNCiAJbWVtc2V0KHB0ciwgMCwgc2l6ZSs1KTsNCisjZWxzZQ0KKwltZW1zZXQocHRy
LCAwLCBzaXplKzcpOw0KKyNlbmRpZg0KIAlrZnJlZShwdHIpOw0KIH0NCiANCkBAIC00MTUsNyAr
NDU0LDExIEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBrbWVtX2NhY2hlX29vYih2b2lk
KQ0KIAkJcmV0dXJuOw0KIAl9DQogDQorI2lmZGVmIENPTkZJR19LQVNBTl9HRU5FUklDDQogCSpw
ID0gcFtzaXplXTsNCisjZWxzZQ0KKwkqcCA9IHBbc2l6ZSArIDhdOw0KKyNlbmRpZg0KIAlrbWVt
X2NhY2hlX2ZyZWUoY2FjaGUsIHApOw0KIAlrbWVtX2NhY2hlX2Rlc3Ryb3koY2FjaGUpOw0KIH0N
CkBAIC00OTcsNiArNTQwLDExIEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBjb3B5X3Vz
ZXJfdGVzdCh2b2lkKQ0KIAljaGFyIF9fdXNlciAqdXNlcm1lbTsNCiAJc2l6ZV90IHNpemUgPSAx
MDsNCiAJaW50IHVudXNlZDsNCisjaWZkZWYgQ09ORklHX0tBU0FOX0dFTkVSSUMNCisJc2l6ZV90
IG9vYl9zaXplID0gMTsNCisjZWxzZQ0KKwlzaXplX3Qgb29iX3NpemUgPSA3Ow0KKyNlbmRpZg0K
IA0KIAlrbWVtID0ga21hbGxvYyhzaXplLCBHRlBfS0VSTkVMKTsNCiAJaWYgKCFrbWVtKQ0KQEAg
LTUxMiwyNSArNTYwLDI1IEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBjb3B5X3VzZXJf
dGVzdCh2b2lkKQ0KIAl9DQogDQogCXByX2luZm8oIm91dC1vZi1ib3VuZHMgaW4gY29weV9mcm9t
X3VzZXIoKVxuIik7DQotCXVudXNlZCA9IGNvcHlfZnJvbV91c2VyKGttZW0sIHVzZXJtZW0sIHNp
emUgKyAxKTsNCisJdW51c2VkID0gY29weV9mcm9tX3VzZXIoa21lbSwgdXNlcm1lbSwgc2l6ZSAr
IG9vYl9zaXplKTsNCiANCiAJcHJfaW5mbygib3V0LW9mLWJvdW5kcyBpbiBjb3B5X3RvX3VzZXIo
KVxuIik7DQotCXVudXNlZCA9IGNvcHlfdG9fdXNlcih1c2VybWVtLCBrbWVtLCBzaXplICsgMSk7
DQorCXVudXNlZCA9IGNvcHlfdG9fdXNlcih1c2VybWVtLCBrbWVtLCBzaXplICsgb29iX3NpemUp
Ow0KIA0KIAlwcl9pbmZvKCJvdXQtb2YtYm91bmRzIGluIF9fY29weV9mcm9tX3VzZXIoKVxuIik7
DQotCXVudXNlZCA9IF9fY29weV9mcm9tX3VzZXIoa21lbSwgdXNlcm1lbSwgc2l6ZSArIDEpOw0K
Kwl1bnVzZWQgPSBfX2NvcHlfZnJvbV91c2VyKGttZW0sIHVzZXJtZW0sIHNpemUgKyBvb2Jfc2l6
ZSk7DQogDQogCXByX2luZm8oIm91dC1vZi1ib3VuZHMgaW4gX19jb3B5X3RvX3VzZXIoKVxuIik7
DQotCXVudXNlZCA9IF9fY29weV90b191c2VyKHVzZXJtZW0sIGttZW0sIHNpemUgKyAxKTsNCisJ
dW51c2VkID0gX19jb3B5X3RvX3VzZXIodXNlcm1lbSwga21lbSwgc2l6ZSArIG9vYl9zaXplKTsN
CiANCiAJcHJfaW5mbygib3V0LW9mLWJvdW5kcyBpbiBfX2NvcHlfZnJvbV91c2VyX2luYXRvbWlj
KClcbiIpOw0KLQl1bnVzZWQgPSBfX2NvcHlfZnJvbV91c2VyX2luYXRvbWljKGttZW0sIHVzZXJt
ZW0sIHNpemUgKyAxKTsNCisJdW51c2VkID0gX19jb3B5X2Zyb21fdXNlcl9pbmF0b21pYyhrbWVt
LCB1c2VybWVtLCBzaXplICsgb29iX3NpemUpOw0KIA0KIAlwcl9pbmZvKCJvdXQtb2YtYm91bmRz
IGluIF9fY29weV90b191c2VyX2luYXRvbWljKClcbiIpOw0KLQl1bnVzZWQgPSBfX2NvcHlfdG9f
dXNlcl9pbmF0b21pYyh1c2VybWVtLCBrbWVtLCBzaXplICsgMSk7DQorCXVudXNlZCA9IF9fY29w
eV90b191c2VyX2luYXRvbWljKHVzZXJtZW0sIGttZW0sIHNpemUgKyBvb2Jfc2l6ZSk7DQogDQog
CXByX2luZm8oIm91dC1vZi1ib3VuZHMgaW4gc3RybmNweV9mcm9tX3VzZXIoKVxuIik7DQotCXVu
dXNlZCA9IHN0cm5jcHlfZnJvbV91c2VyKGttZW0sIHVzZXJtZW0sIHNpemUgKyAxKTsNCisJdW51
c2VkID0gc3RybmNweV9mcm9tX3VzZXIoa21lbSwgdXNlcm1lbSwgc2l6ZSArIG9vYl9zaXplKTsN
CiANCiAJdm1fbXVubWFwKCh1bnNpZ25lZCBsb25nKXVzZXJtZW0sIFBBR0VfU0laRSk7DQogCWtm
cmVlKGttZW0pOw0KLS0gDQoyLjE4LjANCg==

