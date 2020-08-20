Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEC8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A940820724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O8UwMUw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHTFsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:48:18 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26557 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgHTFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:24 -0400
X-UUID: 5fa6dd0948c14d37bc911b9a446ec315-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oAP5zwZxDjrS5iQRAq1dYHyOyODPcgJHQ5kTHeYS9H8=;
        b=O8UwMUw9lSVGZvMhCMgvO1bsTRmAorNEsDp/Jsfl7mWccv+tJnK6iOVbfWcLdxEt5rA1rHZoEFMv1eiTDkvQ66AVTGjEF1BFsyEU1KFxgr2hTTUDAGPb4VRAu1R1wN9yUlCK2xgUkcI9LtKKi7JxC2KFkzL4u2aV+GBm5AUjDF8=;
X-UUID: 5fa6dd0948c14d37bc911b9a446ec315-20200820
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 741345176; Thu, 20 Aug 2020 13:47:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 02/11] usb: early: ehci-dbgp: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:40 +0800
Message-ID: <1597902349-8998-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E1099680E78D2534BB6ACBE72C4DD5FBD99438982FDEED0B0161D86D052EE3452000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiAi
RXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4bWlzc2lvbi5jb20+DQpDYzogUGV0ciBNbGFk
ZWsgPHBtbGFkZWtAc3VzZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBubyBjaGFuZ2VzDQotLS0NCiBkcml2ZXJz
L3VzYi9lYXJseS9laGNpLWRiZ3AuYyB8IDE1ICsrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZWFybHkvZWhjaS1kYmdwLmMgYi9kcml2ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3Au
Yw0KaW5kZXggYjA3NWRiZi4uNDViNDJkOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2Vhcmx5
L2VoY2ktZGJncC5jDQorKysgYi9kcml2ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3AuYw0KQEAgLTE1
LDYgKzE1LDcgQEANCiAjaW5jbHVkZSA8bGludXgvY29uc29sZS5oPg0KICNpbmNsdWRlIDxsaW51
eC9lcnJuby5oPg0KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2lv
cG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC9wY2lfcmVncy5oPg0KICNpbmNsdWRlIDxsaW51eC9w
Y2lfaWRzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi9jaDkuaD4NCkBAIC0xNjEsMTcgKzE2Miwx
MSBAQCBzdGF0aWMgaW5saW5lIHUzMiBkYmdwX3BpZF9yZWFkX3VwZGF0ZSh1MzIgeCwgdTMyIHRv
aykNCiBzdGF0aWMgaW50IGRiZ3Bfd2FpdF91bnRpbF9jb21wbGV0ZSh2b2lkKQ0KIHsNCiAJdTMy
IGN0cmw7DQotCWludCBsb29wID0gREJHUF9USU1FT1VUOw0KLQ0KLQlkbyB7DQotCQljdHJsID0g
cmVhZGwoJmVoY2lfZGVidWctPmNvbnRyb2wpOw0KLQkJLyogU3RvcCB3aGVuIHRoZSB0cmFuc2Fj
dGlvbiBpcyBmaW5pc2hlZCAqLw0KLQkJaWYgKGN0cmwgJiBEQkdQX0RPTkUpDQotCQkJYnJlYWs7
DQotCQl1ZGVsYXkoMSk7DQotCX0gd2hpbGUgKC0tbG9vcCA+IDApOw0KKwlpbnQgcmV0Ow0KIA0K
LQlpZiAoIWxvb3ApDQorCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoJmVoY2lfZGVi
dWctPmNvbnRyb2wsIGN0cmwsDQorCQkJCShjdHJsICYgREJHUF9ET05FKSwgMSwgREJHUF9USU1F
T1VUKTsNCisJaWYgKHJldCkNCiAJCXJldHVybiAtREJHUF9USU1FT1VUOw0KIA0KIAkvKg0KLS0g
DQoxLjkuMQ0K

