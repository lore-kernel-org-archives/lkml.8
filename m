Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107AEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE92204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DL9GXj0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgHTLgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:36:47 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26809 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730628AbgHTLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:51 -0400
X-UUID: 30217b546e2c40b291b867d2b83d08a4-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rUjS11blM0i2nbEVgBDdodrrb27dEhfpxPSUWZxykdw=;
        b=DL9GXj0IL44kMz71geAKuXX8nUGjKQoHUQq/IUxrdup+Sy5m954PVnZBZvaI+NwYbudLqIL3Z7Q0T6JsBt5nG4IXJGDBH8cJA18hCuz3zPBTeowY+EUqZAeZxuYXcURUdpXy6wpMNy4HjdxFt6TR/tcs81rL8/zbxQXtvOqfVx4=;
X-UUID: 30217b546e2c40b291b867d2b83d08a4-20200820
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 413091336; Thu, 20 Aug 2020 19:32:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:25 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 06/11] usb: gadget: bdc: add identifier name for function declaraion
Date:   Thu, 20 Aug 2020 19:30:41 +0800
Message-ID: <1597923046-12535-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 52D2E40CD77ED8F45B911AA3C223BEAAE034D4FFD7A2B61AE5760C8962D475982000:8
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
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBhZGQg
Q2MgRmxvcmlhbg0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmggICAgIHwg
MjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMv
YmRjL2JkY19jbWQuaCB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19kYmcuaCB8ICA4ICsrKystLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2VwLmggIHwgIDggKysrKy0tLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDMxIGluc2Vy
dGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KaW5k
ZXggYzBlZTczNS4uNjU4YWJlZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMv
YmRjL2JkYy5oDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KQEAgLTQ2
NiwyNCArNDY2LDI0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBiZGNfd3JpdGVsKHZvaWQgX19pb21l
bSAqYmFzZSwgdTMyIG9mZnNldCwgdTMyIHZhbHVlKQ0KIH0NCiANCiAvKiBCdWZmZXIgZGVzY3Jp
cHRvciBsaXN0IG9wZXJhdGlvbnMgKi8NCi12b2lkIGJkY19ub3RpZnlfeGZyKHN0cnVjdCBiZGMg
KiwgdTMyKTsNCi12b2lkIGJkY19zb2Z0Y29ubihzdHJ1Y3QgYmRjICopOw0KLXZvaWQgYmRjX3Nv
ZnRkaXNjb25uKHN0cnVjdCBiZGMgKik7DQotaW50IGJkY19ydW4oc3RydWN0IGJkYyAqKTsNCi1p
bnQgYmRjX3N0b3Aoc3RydWN0IGJkYyAqKTsNCi1pbnQgYmRjX3Jlc2V0KHN0cnVjdCBiZGMgKik7
DQotaW50IGJkY191ZGNfaW5pdChzdHJ1Y3QgYmRjICopOw0KLXZvaWQgYmRjX3VkY19leGl0KHN0
cnVjdCBiZGMgKik7DQotaW50IGJkY19yZWluaXQoc3RydWN0IGJkYyAqKTsNCit2b2lkIGJkY19u
b3RpZnlfeGZyKHN0cnVjdCBiZGMgKmJkYywgdTMyIGVwbnVtKTsNCit2b2lkIGJkY19zb2Z0Y29u
bihzdHJ1Y3QgYmRjICpiZGMpOw0KK3ZvaWQgYmRjX3NvZnRkaXNjb25uKHN0cnVjdCBiZGMgKmJk
Yyk7DQoraW50IGJkY19ydW4oc3RydWN0IGJkYyAqYmRjKTsNCitpbnQgYmRjX3N0b3Aoc3RydWN0
IGJkYyAqYmRjKTsNCitpbnQgYmRjX3Jlc2V0KHN0cnVjdCBiZGMgKmJkYyk7DQoraW50IGJkY191
ZGNfaW5pdChzdHJ1Y3QgYmRjICpiZGMpOw0KK3ZvaWQgYmRjX3VkY19leGl0KHN0cnVjdCBiZGMg
KmJkYyk7DQoraW50IGJkY19yZWluaXQoc3RydWN0IGJkYyAqYmRjKTsNCiANCiAvKiBTdGF0dXMg
cmVwb3J0IGhhbmRsZXJzICovDQogLyogVXBzdHJlYW0gcG9ydCBzdGF0dXMgY2hhbmdlIHNyICov
DQotdm9pZCBiZGNfc3JfdXNwYyhzdHJ1Y3QgYmRjICosIHN0cnVjdCBiZGNfc3IgKik7DQordm9p
ZCBiZGNfc3JfdXNwYyhzdHJ1Y3QgYmRjICpiZGMsIHN0cnVjdCBiZGNfc3IgKnNyZXBvcnQpOw0K
IC8qIHRyYW5zZmVyIHNyICovDQotdm9pZCBiZGNfc3JfeHNmKHN0cnVjdCBiZGMgKiwgc3RydWN0
IGJkY19zciAqKTsNCit2b2lkIGJkY19zcl94c2Yoc3RydWN0IGJkYyAqYmRjLCBzdHJ1Y3QgYmRj
X3NyICpzcmVwb3J0KTsNCiAvKiBFUDAgWFNGIGhhbmRsZXJzICovDQotdm9pZCBiZGNfeHNmX2Vw
MF9zZXR1cF9yZWN2KHN0cnVjdCBiZGMgKiwgc3RydWN0IGJkY19zciAqKTsNCi12b2lkIGJkY194
c2ZfZXAwX2RhdGFfc3RhcnQoc3RydWN0IGJkYyAqLCBzdHJ1Y3QgYmRjX3NyICopOw0KLXZvaWQg
YmRjX3hzZl9lcDBfc3RhdHVzX3N0YXJ0KHN0cnVjdCBiZGMgKiwgc3RydWN0IGJkY19zciAqKTsN
Cit2b2lkIGJkY194c2ZfZXAwX3NldHVwX3JlY3Yoc3RydWN0IGJkYyAqYmRjLCBzdHJ1Y3QgYmRj
X3NyICpzcmVwb3J0KTsNCit2b2lkIGJkY194c2ZfZXAwX2RhdGFfc3RhcnQoc3RydWN0IGJkYyAq
YmRjLCBzdHJ1Y3QgYmRjX3NyICpzcmVwb3J0KTsNCit2b2lkIGJkY194c2ZfZXAwX3N0YXR1c19z
dGFydChzdHJ1Y3QgYmRjICpiZGMsIHN0cnVjdCBiZGNfc3IgKnNyZXBvcnQpOw0KIA0KICNlbmRp
ZiAvKiBfX0xJTlVYX0JEQ19IX18gKi8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfY21kLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgN
CmluZGV4IGEzYTZkYmQuLjUzM2FkNTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfY21kLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19j
bWQuaA0KQEAgLTEwLDE0ICsxMCwxNCBAQA0KICNkZWZpbmUgX19MSU5VWF9CRENfQ01EX0hfXw0K
IA0KIC8qIENvbW1hbmQgb3BlcmF0aW9ucyAqLw0KLWludCBiZGNfYWRkcmVzc19kZXZpY2Uoc3Ry
dWN0IGJkYyAqLCB1MzIpOw0KLWludCBiZGNfY29uZmlnX2VwKHN0cnVjdCBiZGMgKiwgc3RydWN0
IGJkY19lcCAqKTsNCi1pbnQgYmRjX2Rjb25maWdfZXAoc3RydWN0IGJkYyAqLCBzdHJ1Y3QgYmRj
X2VwICopOw0KLWludCBiZGNfc3RvcF9lcChzdHJ1Y3QgYmRjICosIGludCk7DQotaW50IGJkY19l
cF9zZXRfc3RhbGwoc3RydWN0IGJkYyAqLCBpbnQpOw0KLWludCBiZGNfZXBfY2xlYXJfc3RhbGwo
c3RydWN0IGJkYyAqLCBpbnQpOw0KLWludCBiZGNfZXBfYmxhKHN0cnVjdCBiZGMgKiwgc3RydWN0
IGJkY19lcCAqLCBkbWFfYWRkcl90KTsNCi1pbnQgYmRjX2Z1bmN0aW9uX3dha2Uoc3RydWN0IGJk
YyosIHU4KTsNCi1pbnQgYmRjX2Z1bmN0aW9uX3dha2VfZmgoc3RydWN0IGJkYyosIHU4KTsNCitp
bnQgYmRjX2FkZHJlc3NfZGV2aWNlKHN0cnVjdCBiZGMgKmJkYywgdTMyIGFkZCk7DQoraW50IGJk
Y19jb25maWdfZXAoc3RydWN0IGJkYyAqYmRjLCBzdHJ1Y3QgYmRjX2VwICplcCk7DQoraW50IGJk
Y19kY29uZmlnX2VwKHN0cnVjdCBiZGMgKmJkYywgc3RydWN0IGJkY19lcCAqZXApOw0KK2ludCBi
ZGNfc3RvcF9lcChzdHJ1Y3QgYmRjICpiZGMsIGludCBlcG51bSk7DQoraW50IGJkY19lcF9zZXRf
c3RhbGwoc3RydWN0IGJkYyAqYmRjLCBpbnQgZXBudW0pOw0KK2ludCBiZGNfZXBfY2xlYXJfc3Rh
bGwoc3RydWN0IGJkYyAqYmRjLCBpbnQgZXBudW0pOw0KK2ludCBiZGNfZXBfYmxhKHN0cnVjdCBi
ZGMgKmJkYywgc3RydWN0IGJkY19lcCAqZXAsIGRtYV9hZGRyX3QgZG1hX2FkZHIpOw0KK2ludCBi
ZGNfZnVuY3Rpb25fd2FrZShzdHJ1Y3QgYmRjICpiZGMsIHU4IGludGYpOw0KK2ludCBiZGNfZnVu
Y3Rpb25fd2FrZV9maChzdHJ1Y3QgYmRjICpiZGMsIHU4IGludGYpOw0KIA0KICNlbmRpZiAvKiBf
X0xJTlVYX0JEQ19DTURfSF9fICovDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2RiZy5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5oDQpp
bmRleCA4NTlkNTg4Li5hY2Q4MzMyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2RiZy5oDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJn
LmgNCkBAIC0xMiwxMCArMTIsMTAgQEANCiAjaW5jbHVkZSAiYmRjLmgiDQogDQogI2lmZGVmIENP
TkZJR19VU0JfR0FER0VUX1ZFUkJPU0UNCi12b2lkIGJkY19kYmdfYmRfbGlzdChzdHJ1Y3QgYmRj
ICosIHN0cnVjdCBiZGNfZXAqKTsNCi12b2lkIGJkY19kYmdfc3JyKHN0cnVjdCBiZGMgKiwgdTMy
KTsNCi12b2lkIGJkY19kYmdfcmVncyhzdHJ1Y3QgYmRjICopOw0KLXZvaWQgYmRjX2R1bXBfZXBz
dHMoc3RydWN0IGJkYyAqKTsNCit2b2lkIGJkY19kYmdfYmRfbGlzdChzdHJ1Y3QgYmRjICpiZGMs
IHN0cnVjdCBiZGNfZXAgKmVwKTsNCit2b2lkIGJkY19kYmdfc3JyKHN0cnVjdCBiZGMgKmJkYywg
dTMyIHNycl9udW0pOw0KK3ZvaWQgYmRjX2RiZ19yZWdzKHN0cnVjdCBiZGMgKmJkYyk7DQordm9p
ZCBiZGNfZHVtcF9lcHN0cyhzdHJ1Y3QgYmRjICpiZGMpOw0KICNlbHNlDQogc3RhdGljIGlubGlu
ZSB2b2lkIGJkY19kYmdfcmVncyhzdHJ1Y3QgYmRjICpiZGMpDQogeyB9DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfZXAuaA0KaW5kZXggNWJiZDczZi4uNGQzYWZmZCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oDQorKysgYi9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2JkYy9iZGNfZXAuaA0KQEAgLTksOSArOSw5IEBADQogI2lmbmRlZiBfX0xJTlVYX0JE
Q19FUF9IX18NCiAjZGVmaW5lIF9fTElOVVhfQkRDX0VQX0hfXw0KIA0KLWludCBiZGNfaW5pdF9l
cChzdHJ1Y3QgYmRjICopOw0KLWludCBiZGNfZXBfZGlzYWJsZShzdHJ1Y3QgYmRjX2VwICopOw0K
LWludCBiZGNfZXBfZW5hYmxlKHN0cnVjdCBiZGNfZXAgKik7DQotdm9pZCBiZGNfZnJlZV9lcChz
dHJ1Y3QgYmRjICopOw0KK2ludCBiZGNfaW5pdF9lcChzdHJ1Y3QgYmRjICpiZGMpOw0KK2ludCBi
ZGNfZXBfZGlzYWJsZShzdHJ1Y3QgYmRjX2VwICplcCk7DQoraW50IGJkY19lcF9lbmFibGUoc3Ry
dWN0IGJkY19lcCAqZXApOw0KK3ZvaWQgYmRjX2ZyZWVfZXAoc3RydWN0IGJkYyAqYmRjKTsNCiAN
CiAjZW5kaWYgLyogX19MSU5VWF9CRENfRVBfSF9fICovDQotLSANCjEuOS4xDQo=

