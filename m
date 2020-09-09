Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE0FC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B821919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FIUeHAgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIIHfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:35:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45000 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729212AbgIIHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:35:40 -0400
X-UUID: d0c17f2ebd6a42b69a11a836f3ad05c1-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VMklwcOhW8OI2ICI2nE8LQDDKCbAyl/WWSvFOiipg3w=;
        b=FIUeHAgPeJIiUQQVnqieqQOmxTBjEraMQ1r4ycAK3Rjb97RaGDWoDIikzVTYpcvAUXS9PYG1EG1n09hP/mEuVjHuLKu0utv2LyMhLIQV1JOdd8k8tfchoxfTkp3CXT5gGz2pKqF61ICiJw77lyWWjdbh4Gwewg650X4UzSLrsaI=;
X-UUID: d0c17f2ebd6a42b69a11a836f3ad05c1-20200909
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 455313375; Wed, 09 Sep 2020 15:35:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 15:35:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 15:35:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Bin Liu <b-liu@ti.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 06/11] usb: gadget: bdc: add identifier name for function declaraion
Date:   Wed, 9 Sep 2020 15:32:57 +0800
Message-ID: <1599636782-7654-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4D5F2AAD80551DBD19C9BEEB68C000E644C5A0064BE2A06D4796E7AE36F81B0E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGF2b2lkIHRoZSB3YXJuaW5nIG9mIGZ1bmN0aW9uIGFyZ3VtZW50cywg
ZS5nLg0KICBXQVJOSU5HOkZVTkNUSU9OX0FSR1VNRU5UUzogZnVuY3Rpb24gZGVmaW5pdGlvbiBh
cmd1bWVudCAndTMyJw0KICBzaG91bGQgYWxzbyBoYXZlIGFuIGlkZW50aWZpZXIgbmFtZQ0KDQpD
YzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogRmxv
cmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQotLS0NCnYzOiBhZGQgYWNrZWQt
YnkgRmxvcmlhbg0KDQp2MjogYWRkIENjIEZsb3JpYW4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkYy5oICAgICB8IDI4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCiBk
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmggfCAxOCArKysrKysrKystLS0tLS0t
LS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmggfCAgOCArKysrLS0tLQ0K
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oICB8ICA4ICsrKystLS0tDQogNCBm
aWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjLmgNCmluZGV4IGMwZWU3MzUuLjY1OGFiZWYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjLmgNCkBAIC00NjYsMjQgKzQ2NiwyNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
YmRjX3dyaXRlbCh2b2lkIF9faW9tZW0gKmJhc2UsIHUzMiBvZmZzZXQsIHUzMiB2YWx1ZSkNCiB9
DQogDQogLyogQnVmZmVyIGRlc2NyaXB0b3IgbGlzdCBvcGVyYXRpb25zICovDQotdm9pZCBiZGNf
bm90aWZ5X3hmcihzdHJ1Y3QgYmRjICosIHUzMik7DQotdm9pZCBiZGNfc29mdGNvbm4oc3RydWN0
IGJkYyAqKTsNCi12b2lkIGJkY19zb2Z0ZGlzY29ubihzdHJ1Y3QgYmRjICopOw0KLWludCBiZGNf
cnVuKHN0cnVjdCBiZGMgKik7DQotaW50IGJkY19zdG9wKHN0cnVjdCBiZGMgKik7DQotaW50IGJk
Y19yZXNldChzdHJ1Y3QgYmRjICopOw0KLWludCBiZGNfdWRjX2luaXQoc3RydWN0IGJkYyAqKTsN
Ci12b2lkIGJkY191ZGNfZXhpdChzdHJ1Y3QgYmRjICopOw0KLWludCBiZGNfcmVpbml0KHN0cnVj
dCBiZGMgKik7DQordm9pZCBiZGNfbm90aWZ5X3hmcihzdHJ1Y3QgYmRjICpiZGMsIHUzMiBlcG51
bSk7DQordm9pZCBiZGNfc29mdGNvbm4oc3RydWN0IGJkYyAqYmRjKTsNCit2b2lkIGJkY19zb2Z0
ZGlzY29ubihzdHJ1Y3QgYmRjICpiZGMpOw0KK2ludCBiZGNfcnVuKHN0cnVjdCBiZGMgKmJkYyk7
DQoraW50IGJkY19zdG9wKHN0cnVjdCBiZGMgKmJkYyk7DQoraW50IGJkY19yZXNldChzdHJ1Y3Qg
YmRjICpiZGMpOw0KK2ludCBiZGNfdWRjX2luaXQoc3RydWN0IGJkYyAqYmRjKTsNCit2b2lkIGJk
Y191ZGNfZXhpdChzdHJ1Y3QgYmRjICpiZGMpOw0KK2ludCBiZGNfcmVpbml0KHN0cnVjdCBiZGMg
KmJkYyk7DQogDQogLyogU3RhdHVzIHJlcG9ydCBoYW5kbGVycyAqLw0KIC8qIFVwc3RyZWFtIHBv
cnQgc3RhdHVzIGNoYW5nZSBzciAqLw0KLXZvaWQgYmRjX3NyX3VzcGMoc3RydWN0IGJkYyAqLCBz
dHJ1Y3QgYmRjX3NyICopOw0KK3ZvaWQgYmRjX3NyX3VzcGMoc3RydWN0IGJkYyAqYmRjLCBzdHJ1
Y3QgYmRjX3NyICpzcmVwb3J0KTsNCiAvKiB0cmFuc2ZlciBzciAqLw0KLXZvaWQgYmRjX3NyX3hz
ZihzdHJ1Y3QgYmRjICosIHN0cnVjdCBiZGNfc3IgKik7DQordm9pZCBiZGNfc3JfeHNmKHN0cnVj
dCBiZGMgKmJkYywgc3RydWN0IGJkY19zciAqc3JlcG9ydCk7DQogLyogRVAwIFhTRiBoYW5kbGVy
cyAqLw0KLXZvaWQgYmRjX3hzZl9lcDBfc2V0dXBfcmVjdihzdHJ1Y3QgYmRjICosIHN0cnVjdCBi
ZGNfc3IgKik7DQotdm9pZCBiZGNfeHNmX2VwMF9kYXRhX3N0YXJ0KHN0cnVjdCBiZGMgKiwgc3Ry
dWN0IGJkY19zciAqKTsNCi12b2lkIGJkY194c2ZfZXAwX3N0YXR1c19zdGFydChzdHJ1Y3QgYmRj
ICosIHN0cnVjdCBiZGNfc3IgKik7DQordm9pZCBiZGNfeHNmX2VwMF9zZXR1cF9yZWN2KHN0cnVj
dCBiZGMgKmJkYywgc3RydWN0IGJkY19zciAqc3JlcG9ydCk7DQordm9pZCBiZGNfeHNmX2VwMF9k
YXRhX3N0YXJ0KHN0cnVjdCBiZGMgKmJkYywgc3RydWN0IGJkY19zciAqc3JlcG9ydCk7DQordm9p
ZCBiZGNfeHNmX2VwMF9zdGF0dXNfc3RhcnQoc3RydWN0IGJkYyAqYmRjLCBzdHJ1Y3QgYmRjX3Ny
ICpzcmVwb3J0KTsNCiANCiAjZW5kaWYgLyogX19MSU5VWF9CRENfSF9fICovDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjX2NtZC5oDQppbmRleCBhM2E2ZGJkLi41MzNhZDUyIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oDQorKysgYi9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCkBAIC0xMCwxNCArMTAsMTQgQEANCiAjZGVmaW5l
IF9fTElOVVhfQkRDX0NNRF9IX18NCiANCiAvKiBDb21tYW5kIG9wZXJhdGlvbnMgKi8NCi1pbnQg
YmRjX2FkZHJlc3NfZGV2aWNlKHN0cnVjdCBiZGMgKiwgdTMyKTsNCi1pbnQgYmRjX2NvbmZpZ19l
cChzdHJ1Y3QgYmRjICosIHN0cnVjdCBiZGNfZXAgKik7DQotaW50IGJkY19kY29uZmlnX2VwKHN0
cnVjdCBiZGMgKiwgc3RydWN0IGJkY19lcCAqKTsNCi1pbnQgYmRjX3N0b3BfZXAoc3RydWN0IGJk
YyAqLCBpbnQpOw0KLWludCBiZGNfZXBfc2V0X3N0YWxsKHN0cnVjdCBiZGMgKiwgaW50KTsNCi1p
bnQgYmRjX2VwX2NsZWFyX3N0YWxsKHN0cnVjdCBiZGMgKiwgaW50KTsNCi1pbnQgYmRjX2VwX2Js
YShzdHJ1Y3QgYmRjICosIHN0cnVjdCBiZGNfZXAgKiwgZG1hX2FkZHJfdCk7DQotaW50IGJkY19m
dW5jdGlvbl93YWtlKHN0cnVjdCBiZGMqLCB1OCk7DQotaW50IGJkY19mdW5jdGlvbl93YWtlX2Zo
KHN0cnVjdCBiZGMqLCB1OCk7DQoraW50IGJkY19hZGRyZXNzX2RldmljZShzdHJ1Y3QgYmRjICpi
ZGMsIHUzMiBhZGQpOw0KK2ludCBiZGNfY29uZmlnX2VwKHN0cnVjdCBiZGMgKmJkYywgc3RydWN0
IGJkY19lcCAqZXApOw0KK2ludCBiZGNfZGNvbmZpZ19lcChzdHJ1Y3QgYmRjICpiZGMsIHN0cnVj
dCBiZGNfZXAgKmVwKTsNCitpbnQgYmRjX3N0b3BfZXAoc3RydWN0IGJkYyAqYmRjLCBpbnQgZXBu
dW0pOw0KK2ludCBiZGNfZXBfc2V0X3N0YWxsKHN0cnVjdCBiZGMgKmJkYywgaW50IGVwbnVtKTsN
CitpbnQgYmRjX2VwX2NsZWFyX3N0YWxsKHN0cnVjdCBiZGMgKmJkYywgaW50IGVwbnVtKTsNCitp
bnQgYmRjX2VwX2JsYShzdHJ1Y3QgYmRjICpiZGMsIHN0cnVjdCBiZGNfZXAgKmVwLCBkbWFfYWRk
cl90IGRtYV9hZGRyKTsNCitpbnQgYmRjX2Z1bmN0aW9uX3dha2Uoc3RydWN0IGJkYyAqYmRjLCB1
OCBpbnRmKTsNCitpbnQgYmRjX2Z1bmN0aW9uX3dha2VfZmgoc3RydWN0IGJkYyAqYmRjLCB1OCBp
bnRmKTsNCiANCiAjZW5kaWYgLyogX19MSU5VWF9CRENfQ01EX0hfXyAqLw0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuaCBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19kYmcuaA0KaW5kZXggODU5ZDU4OC4uYWNkODMzMiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuaA0KKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5oDQpAQCAtMTIsMTAgKzEyLDEwIEBADQogI2luY2x1ZGUg
ImJkYy5oIg0KIA0KICNpZmRlZiBDT05GSUdfVVNCX0dBREdFVF9WRVJCT1NFDQotdm9pZCBiZGNf
ZGJnX2JkX2xpc3Qoc3RydWN0IGJkYyAqLCBzdHJ1Y3QgYmRjX2VwKik7DQotdm9pZCBiZGNfZGJn
X3NycihzdHJ1Y3QgYmRjICosIHUzMik7DQotdm9pZCBiZGNfZGJnX3JlZ3Moc3RydWN0IGJkYyAq
KTsNCi12b2lkIGJkY19kdW1wX2Vwc3RzKHN0cnVjdCBiZGMgKik7DQordm9pZCBiZGNfZGJnX2Jk
X2xpc3Qoc3RydWN0IGJkYyAqYmRjLCBzdHJ1Y3QgYmRjX2VwICplcCk7DQordm9pZCBiZGNfZGJn
X3NycihzdHJ1Y3QgYmRjICpiZGMsIHUzMiBzcnJfbnVtKTsNCit2b2lkIGJkY19kYmdfcmVncyhz
dHJ1Y3QgYmRjICpiZGMpOw0KK3ZvaWQgYmRjX2R1bXBfZXBzdHMoc3RydWN0IGJkYyAqYmRjKTsN
CiAjZWxzZQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBiZGNfZGJnX3JlZ3Moc3RydWN0IGJkYyAqYmRj
KQ0KIHsgfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5o
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmgNCmluZGV4IDViYmQ3M2YuLjRk
M2FmZmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuaA0K
KysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmgNCkBAIC05LDkgKzksOSBA
QA0KICNpZm5kZWYgX19MSU5VWF9CRENfRVBfSF9fDQogI2RlZmluZSBfX0xJTlVYX0JEQ19FUF9I
X18NCiANCi1pbnQgYmRjX2luaXRfZXAoc3RydWN0IGJkYyAqKTsNCi1pbnQgYmRjX2VwX2Rpc2Fi
bGUoc3RydWN0IGJkY19lcCAqKTsNCi1pbnQgYmRjX2VwX2VuYWJsZShzdHJ1Y3QgYmRjX2VwICop
Ow0KLXZvaWQgYmRjX2ZyZWVfZXAoc3RydWN0IGJkYyAqKTsNCitpbnQgYmRjX2luaXRfZXAoc3Ry
dWN0IGJkYyAqYmRjKTsNCitpbnQgYmRjX2VwX2Rpc2FibGUoc3RydWN0IGJkY19lcCAqZXApOw0K
K2ludCBiZGNfZXBfZW5hYmxlKHN0cnVjdCBiZGNfZXAgKmVwKTsNCit2b2lkIGJkY19mcmVlX2Vw
KHN0cnVjdCBiZGMgKmJkYyk7DQogDQogI2VuZGlmIC8qIF9fTElOVVhfQkRDX0VQX0hfXyAqLw0K
LS0gDQoxLjkuMQ0K

