Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE337C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1DC20637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hFd3ssV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgCKMU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:20:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49420 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729095AbgCKMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:20:59 -0400
X-UUID: 6dbda1a3d6ee4ac6af30b8c2d6027b5f-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ko1BjI2ELzJodvKKe45j1AqO09tGfo0MC5W9HBQrrI4=;
        b=hFd3ssV38dSzWcHGUfFxv41cNlIzg1K6LwKuaT4btZfKqojgk4NhpFB53ppr1KkIIPs/jga7i9b2NHg2TyoCvc6WzgszSU0G4a93S7uxpAPkhpr6nvMENo9FKWsr3guixQQRo9cT7+drVmlsfMK1GEZqTAaLjmR/w822/YcQaAA=;
X-UUID: 6dbda1a3d6ee4ac6af30b8c2d6027b5f-20200311
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 412987948; Wed, 11 Mar 2020 20:20:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Mar 2020 20:20:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 20:20:58 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH] pid: fix uninitialized var warnings
Date:   Wed, 11 Mar 2020 20:20:49 +0800
Message-ID: <20200311122049.11589-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8FFCA056A86FDAB388FAEAFCBF293114866B37C98B625B24FDEB9BC4584ECB9F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29tcGlsaW5nIHdpdGggZ2NjLTkuMi4xIHBvaW50cyBvdXQgYmVsb3cgd2FybmluZ3MuIEZpeCBp
dC4NCg0Ka2VybmVsL3BpZC5jOiBJbiBmdW5jdGlvbiAnYWxsb2NfcGlkJzoNCmtlcm5lbC9waWQu
YzoxODA6MTA6IHdhcm5pbmc6ICdyZXR2YWwnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQNCmlu
IHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0aWFsaXplZF0NCg0KQ2M6IEFuZHJldyBNb3J0
b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpDYzogQ2hyaXN0aWFuIEJyYXVuZXIgPGNo
cmlzdGlhbkBicmF1bmVyLmlvPg0KQ2M6IE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVkaGF0LmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIGtlcm5lbC9waWQuYyB8IDQgKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9waWQuYyBiL2tlcm5lbC9w
aWQuYw0KaW5kZXggZmY2Y2Q2Nzg2ZDEwLi4wMjk0NGNmZDRlNTEgMTAwNjQ0DQotLS0gYS9rZXJu
ZWwvcGlkLmMNCisrKyBiL2tlcm5lbC9waWQuYw0KQEAgLTE3Niw4ICsxNzYsMTAgQEAgc3RydWN0
IHBpZCAqYWxsb2NfcGlkKHN0cnVjdCBwaWRfbmFtZXNwYWNlICpucywgcGlkX3QgKnNldF90aWQs
DQogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCiANCiAJcGlkID0ga21lbV9jYWNoZV9hbGxv
Yyhucy0+cGlkX2NhY2hlcCwgR0ZQX0tFUk5FTCk7DQotCWlmICghcGlkKQ0KKwlpZiAoIXBpZCkg
ew0KKwkJcmV0dmFsID0gLUVOT01FTTsNCiAJCXJldHVybiBFUlJfUFRSKHJldHZhbCk7DQorCX0N
CiANCiAJdG1wID0gbnM7DQogCXBpZC0+bGV2ZWwgPSBucy0+bGV2ZWw7DQotLSANCjIuMTguMA0K

