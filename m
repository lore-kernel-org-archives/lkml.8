Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3FC3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0B222527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="idwf/PwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgCKNnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:43:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5640 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729428AbgCKNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:43:19 -0400
X-UUID: 4ccf4a7c67bc4639b58278874f1ba63b-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=A72jYG29ZYGID3peLueFYfZ09ab4hxkJOXi8FenC89M=;
        b=idwf/PwLyaHjJ6WkHCzFSRrOGds9HsrQmOGkGMZxxq6CFiZw/hm7kM7+1lAtuH6+dq8ZTRamOg7hmUjiyLGXV39n2PzKUMw+qvy4jb67Q5amB7tiad1MJy1LsN87/ATiVCovU0dkiRaQrAUq04nZY7pGvyMgqdsqLollN6h5IHw=;
X-UUID: 4ccf4a7c67bc4639b58278874f1ba63b-20200311
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1806468321; Wed, 11 Mar 2020 21:43:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Mar 2020 21:42:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 21:43:18 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH -next] kasan: fix -Wstringop-overflow warning
Date:   Wed, 11 Mar 2020 21:42:44 +0800
Message-ID: <20200311134244.13016-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29tcGlsaW5nIHdpdGggZ2NjLTkuMi4xIHBvaW50cyBvdXQgYmVsb3cgd2FybmluZ3MuDQoNCklu
IGZ1bmN0aW9uICdtZW1tb3ZlJywNCiAgICBpbmxpbmVkIGZyb20gJ2ttYWxsb2NfbWVtbW92ZV9p
bnZhbGlkX3NpemUnIGF0IGxpYi90ZXN0X2thc2FuLmM6MzAxOjI6DQppbmNsdWRlL2xpbnV4L3N0
cmluZy5oOjQ0MTo5OiB3YXJuaW5nOiAnX19idWlsdGluX21lbW1vdmUnIHNwZWNpZmllZA0KYm91
bmQgMTg0NDY3NDQwNzM3MDk1NTE2MTQgZXhjZWVkcyBtYXhpbXVtIG9iamVjdCBzaXplDQo5MjIz
MzcyMDM2ODU0Nzc1ODA3IFstV3N0cmluZ29wLW92ZXJmbG93PV0NCg0KV2h5IGdlbmVyYXRlIHRo
aXMgd2FybmluZ3M/DQpCZWNhdXNlIG91ciB0ZXN0IGZ1bmN0aW9uIGRlbGliZXJhdGVseSBwYXNz
IGEgbmVnYXRpdmUgbnVtYmVyIGluIG1lbW1vdmUoKSwNCnNvIHdlIG5lZWQgdG8gbWFrZSBpdCAi
dm9sYXRpbGUiIHNvIHRoYXQgY29tcGlsZXIgZG9lc24ndCBzZWUgaXQuDQoNClJlcG9ydGVkLWJ5
OiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4NCkNjOiBEbWl0cnkgVnl1
a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5A
dmlydHVvenpvLmNvbT4NCkNjOiBRaWFuIENhaSA8Y2FpQGxjYS5wdz4NCkNjOiBBbmRyZXcgTW9y
dG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1
IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogbGliL3Rlc3Rfa2FzYW4uYyB8IDMg
KystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvbGliL3Rlc3Rfa2FzYW4uYyBiL2xpYi90ZXN0X2thc2FuLmMNCmluZGV4IGYx
MjNiNGI4YWFkZi4uZTMwODdkOTBlMDBkIDEwMDY0NA0KLS0tIGEvbGliL3Rlc3Rfa2FzYW4uYw0K
KysrIGIvbGliL3Rlc3Rfa2FzYW4uYw0KQEAgLTI4OSw2ICsyODksNyBAQCBzdGF0aWMgbm9pbmxp
bmUgdm9pZCBfX2luaXQga21hbGxvY19tZW1tb3ZlX2ludmFsaWRfc2l6ZSh2b2lkKQ0KIHsNCiAJ
Y2hhciAqcHRyOw0KIAlzaXplX3Qgc2l6ZSA9IDY0Ow0KKwl2b2xhdGlsZSBzaXplX3QgaW52YWxp
ZF9zaXplID0gLTI7DQogDQogCXByX2luZm8oImludmFsaWQgc2l6ZSBpbiBtZW1tb3ZlXG4iKTsN
CiAJcHRyID0ga21hbGxvYyhzaXplLCBHRlBfS0VSTkVMKTsNCkBAIC0yOTgsNyArMjk5LDcgQEAg
c3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0IGttYWxsb2NfbWVtbW92ZV9pbnZhbGlkX3NpemUo
dm9pZCkNCiAJfQ0KIA0KIAltZW1zZXQoKGNoYXIgKilwdHIsIDAsIDY0KTsNCi0JbWVtbW92ZSgo
Y2hhciAqKXB0ciwgKGNoYXIgKilwdHIgKyA0LCAtMik7DQorCW1lbW1vdmUoKGNoYXIgKilwdHIs
IChjaGFyICopcHRyICsgNCwgaW52YWxpZF9zaXplKTsNCiAJa2ZyZWUocHRyKTsNCiB9DQogDQot
LSANCjIuMTguMA0K

