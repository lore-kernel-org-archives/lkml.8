Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E577C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C922076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N1yfkH3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgIJIdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:33:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22807 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730383AbgIJIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:34 -0400
X-UUID: 815a4b2562534e99882e822c9115cae9-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J3BiqWxfV1+Z3aDvfR83RogHjSnqeDdQl3tqJBLcqsI=;
        b=N1yfkH3WlUUIQZeetodgAdzUspqrvn46lPxvvFh0ATzymaKRt5nJxqfCcU7oV7ia3PR844vaHZQkQgl2D1EbwHTjHJKvmvQpA4Nml0noG020XkQMkovGIWsb0dqjp5QlSNMNbywZkXRcvtn7rBwhZ62UYPaIjBZ0vRv6s00XLPI=;
X-UUID: 815a4b2562534e99882e822c9115cae9-20200910
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1942603470; Thu, 10 Sep 2020 16:24:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:00 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:23:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RESEND v3 02/11] usb: early: ehci-dbgp: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:43 +0800
Message-ID: <1599726112-4439-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AFF16CD37DCA3267BBDFA7FEB25A7875F550A782E36CA49A37CE082BE0907E122000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiAi
RXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4bWlzc2lvbi5jb20+DQpDYzogUGV0ciBNbGFk
ZWsgPHBtbGFkZWtAc3VzZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyfnYzOiBubyBjaGFuZ2VzDQotLS0NCiBkcml2
ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3AuYyB8IDE1ICsrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZWFybHkvZWhjaS1kYmdwLmMgYi9kcml2ZXJzL3VzYi9lYXJseS9laGNpLWRi
Z3AuYw0KaW5kZXggYjA3NWRiZi4uNDViNDJkOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2Vh
cmx5L2VoY2ktZGJncC5jDQorKysgYi9kcml2ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3AuYw0KQEAg
LTE1LDYgKzE1LDcgQEANCiAjaW5jbHVkZSA8bGludXgvY29uc29sZS5oPg0KICNpbmNsdWRlIDxs
aW51eC9lcnJuby5oPg0KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQorI2luY2x1ZGUgPGxpbnV4
L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC9wY2lfcmVncy5oPg0KICNpbmNsdWRlIDxsaW51
eC9wY2lfaWRzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi9jaDkuaD4NCkBAIC0xNjEsMTcgKzE2
MiwxMSBAQCBzdGF0aWMgaW5saW5lIHUzMiBkYmdwX3BpZF9yZWFkX3VwZGF0ZSh1MzIgeCwgdTMy
IHRvaykNCiBzdGF0aWMgaW50IGRiZ3Bfd2FpdF91bnRpbF9jb21wbGV0ZSh2b2lkKQ0KIHsNCiAJ
dTMyIGN0cmw7DQotCWludCBsb29wID0gREJHUF9USU1FT1VUOw0KLQ0KLQlkbyB7DQotCQljdHJs
ID0gcmVhZGwoJmVoY2lfZGVidWctPmNvbnRyb2wpOw0KLQkJLyogU3RvcCB3aGVuIHRoZSB0cmFu
c2FjdGlvbiBpcyBmaW5pc2hlZCAqLw0KLQkJaWYgKGN0cmwgJiBEQkdQX0RPTkUpDQotCQkJYnJl
YWs7DQotCQl1ZGVsYXkoMSk7DQotCX0gd2hpbGUgKC0tbG9vcCA+IDApOw0KKwlpbnQgcmV0Ow0K
IA0KLQlpZiAoIWxvb3ApDQorCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoJmVoY2lf
ZGVidWctPmNvbnRyb2wsIGN0cmwsDQorCQkJCShjdHJsICYgREJHUF9ET05FKSwgMSwgREJHUF9U
SU1FT1VUKTsNCisJaWYgKHJldCkNCiAJCXJldHVybiAtREJHUF9USU1FT1VUOw0KIA0KIAkvKg0K
LS0gDQoxLjkuMQ0K

