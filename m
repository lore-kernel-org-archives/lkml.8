Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B435C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6123722527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gV+vQumo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgBRHlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:41:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60387 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgBRHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:41:24 -0500
X-UUID: d408accb050345269bf4092c32b8eabd-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=R5o8h58rYOA1fQLNSXIwPhnCU0xALWjQ5mRQdByDjFk=;
        b=gV+vQumofRgeHZQLi18ZL0fXI0cOe/m8m9jHQK1lAAwIwiikMv2ILEXat/eyhU0IKRcshFL0QWupA8xNmwG/j707T7GFs7L/sAdvYuq6fi0fCOzpXQSn9nB2mR/p9Wky/ggJ7CRWDs0fdL5mb+PPO+/bq/uHzSDFyXvILobmlKU=;
X-UUID: d408accb050345269bf4092c32b8eabd-20200218
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1173835655; Tue, 18 Feb 2020 15:41:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 15:42:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Feb 2020 15:40:51 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shen Jing <jingx.shen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Jerry Zhang <zhangjerry@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH] lib: iov_iter.c: fix a possible calculation error on remaining bytes
Date:   Tue, 18 Feb 2020 15:41:12 +0800
Message-ID: <1582011672-17189-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpc3N1ZSB3YXMgZm91bmQgd2hlbiBhZGJkIHRyeWluZyB0byBvcGVuIGZ1bmN0aW9uZnMg
d2l0aCBBSU8gbW9kZS4NClVzdWFsbHksIHdlIG5lZWQgdG8gc2V0ICJzZXRwcm9wIHN5cy51c2Iu
ZmZzLmFpb19jb21wYXQgMCIgdG8gZW5hYmxlDQphZGJkIHdpdGggQUlPIG1vZGUgb24gQW5kcm9p
ZC4NCg0KV2hlbiBhZGJkIGlzIG9wZW5pbmcgZnVuY3Rpb25mcywgaXQgd2lsbCB0cnkgdG8gcmVh
ZCAyNCBieXRlcyBhdCB0aGUNCmZpc3J0IHJlYWQgSS9PIGNvbnRyb2wuIElmIHRoaXMgcmVhZGlu
ZyBoYXMgYmVlbiBmYWlsZWQsIGFkYmQgd2lsbA0KdHJ5IHRvIHNlbmQgRlVOQ1RJT05GU19DTEVB
Ul9IQUxUIHRvIGZ1bmN0aW9uZnMuIFdoZW4gYWRiZCBpcyBpbiBBSU8NCm1vZGUsIGZ1bmN0aW9u
ZnMgd2lsbCBiZSBhY3RlZCB3aXRoIGFzeW5jcm9uaXplZCBJL08gcGF0aC4gQWZ0ZXIgdGhlDQpz
dWNjZXNzZnVsIHJlYWQgdHJhbnNmZXIgaGFzIGJlZW4gY29tcGxldGVkIGJ5IGdhZGdldCBoYXJk
d2FyZSwgdGhlDQpmb2xsb3dpbmcgc2VyaWVzIG9mIGZ1bmN0aW9ucyB3aWxsIGJlIGNhbGxlZC4N
CiAgZmZzX2VwZmlsZV9hc3luY19pb19jb21wbGV0ZSgpIC0+IGZmc191c2VyX2NvcHlfd29ya2Vy
KCkgLT4NCiAgICBjb3B5X3RvX2l0ZXIoKSAtPiBfY29weV90b19pdGVyKCkgLT4gY29weW91dCgp
IC0+DQogICAgaXRlcmF0ZV9hbmRfYWR2YW5jZSgpIC0+IGl0ZXJhdGVfaW92ZWMoKQ0KDQpBZGRp
bmcgZGVidWcgdHJhY2UgdG8gdGhlc2UgZnVuY3Rpb25zLCBpdCBoYXMgYmVlbiBmb3VuZCB0aGF0
IGluDQppdGVyYXRlX2lvdmVjKCksIHRoZSBjYWxjdWxhdGlvbiByZXN1bHQgb2YgbiB3aWxsIGJl
IHR1cm5lZCBpbnRvIHplcm8uDQogICBuID0gd2FudGVkIC0gbjsgLyogMCA9PSBuID0gMjQgLSAy
NDsgKi8NCldoaWNoIGNhdXNlcyBjb3B5b3V0KCkgd29uJ3QgY29weSBkYXRhIHRvIHVzZXJzcGFj
ZSBzaW5jZSB0aGUgbGVuZ3RoDQp0byBiZSBjb3BpZWQgInYuaW92X2xlbiIgd2lsbCBiZSB6ZXJv
LCB3aGljaCBpc24ndCBjb3JyZWN0LiBUaGlzIGFsc28NCmxlYWRzIGZmc19jb3B5X3RvX2l0ZXIo
KSBhbHdheXMgcmV0dXJuIC1FRkFVTFQuIEZpbmFsbHkgYWRiZCBjYW5ub3QNCm9wZW4gZnVuY3Rp
b25mcyBhbmQgc2VuZCBGVU5DVElPTkZTX0NMRUFSX0hBTFQuDQoNClNpZ25lZC1vZmYtYnk6IE1h
Y3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQotLS0NCiBsaWIvaW92X2l0ZXIu
YyB8IDMgKystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvbGliL2lvdl9pdGVyLmMgYi9saWIvaW92X2l0ZXIuYw0KaW5kZXgg
ZmIyOWMwMmM2YTNjLi5mOTMzNDE0NGUyNTkgMTAwNjQ0DQotLS0gYS9saWIvaW92X2l0ZXIuYw0K
KysrIGIvbGliL2lvdl9pdGVyLmMNCkBAIC0zNiw3ICszNiw4IEBADQogCQlza2lwID0gX192Lmlv
dl9sZW47CQkJXA0KIAkJbiAtPSBfX3YuaW92X2xlbjsJCQlcDQogCX0JCQkJCQlcDQotCW4gPSB3
YW50ZWQgLSBuOwkJCQkJXA0KKwlpZiAobiAhPSB3YW50ZWQpCQkJCVwNCisJCW4gPSB3YW50ZWQg
LSBuOwkJCQlcDQogfQ0KIA0KICNkZWZpbmUgaXRlcmF0ZV9rdmVjKGksIG4sIF9fdiwgX19wLCBz
a2lwLCBTVEVQKSB7CVwNCi0tIA0KMi4xOC4wDQo=

