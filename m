Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB76C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A7207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uwfDNSQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHTFre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:47:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:32006 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726815AbgHTFr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:27 -0400
X-UUID: 3e35ec2fe11e42379a08392de7f0f51b-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KqivLJ82o4nQcvuVJ38MnC9qLo3O961PB6uECAnVwuo=;
        b=uwfDNSQoBKHKf12TeA1ZtPrzf9xu8n9m/NMSGEF1XxMHo6x9nyIiHglkvLvQNu1gL7/uW4oHRD00Cfvci8sIUZNN80TvHwxkw/QV3MdbHcc7eicDzHK1EF5uoec7baqB3ubKBwgSELqBX6PMZMszYqC3BRAmuN3z65VYHuP9OkM=;
X-UUID: 3e35ec2fe11e42379a08392de7f0f51b-20200820
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1521420158; Thu, 20 Aug 2020 13:47:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:11 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 04/11] usb: xhci-rcar: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:42 +0800
Message-ID: <1597902349-8998-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A432BAA91F560CA8F5BAB65220EE2453B9D32BEB3EF465235A28FB7C317A19F42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NCkNjOiBZb3NoaWhp
cm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBu
byBjaGFuZ2VzDQotLS0NCiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jIHwgNDMgKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS1yY2FyLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jDQppbmRl
eCBjMTAyNWQzLi43NGY4MzZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXJj
YXIuYw0KKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KQEAgLTYsNiArNiw3IEBA
DQogICovDQogDQogI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQorI2luY2x1ZGUgPGxpbnV4
L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgv
cGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mLmg+DQpAQCAtMTI3LDggKzEy
OCw3IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2Jf
aGNkICpoY2QpDQogCXZvaWQgX19pb21lbSAqcmVncyA9IGhjZC0+cmVnczsNCiAJc3RydWN0IHho
Y2lfcGxhdF9wcml2ICpwcml2ID0gaGNkX3RvX3hoY2lfcHJpdihoY2QpOw0KIAljb25zdCBzdHJ1
Y3QgZmlybXdhcmUgKmZ3Ow0KLQlpbnQgcmV0dmFsLCBpbmRleCwgaiwgdGltZTsNCi0JaW50IHRp
bWVvdXQgPSAxMDAwMDsNCisJaW50IHJldHZhbCwgaW5kZXgsIGo7DQogCXUzMiBkYXRhLCB2YWws
IHRlbXA7DQogCXUzMiBxdWlya3MgPSAwOw0KIAljb25zdCBzdHJ1Y3Qgc29jX2RldmljZV9hdHRy
aWJ1dGUgKmF0dHI7DQpAQCAtMTY2LDMyICsxNjYsMTkgQEAgc3RhdGljIGludCB4aGNpX3JjYXJf
ZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVzYl9oY2QgKmhjZCkNCiAJCXRlbXAgfD0gUkNBUl9V
U0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwOw0KIAkJd3JpdGVsKHRlbXAsIHJlZ3MgKyBSQ0FSX1VT
QjNfRExfQ1RSTCk7DQogDQotCQlmb3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsr
KSB7DQotCQkJdmFsID0gcmVhZGwocmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCi0JCQlpZiAo
KHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCkgPT0gMCkNCi0JCQkJYnJlYWs7
DQotCQkJdWRlbGF5KDEpOw0KLQkJfQ0KLQkJaWYgKHRpbWUgPT0gdGltZW91dCkgew0KLQkJCXJl
dHZhbCA9IC1FVElNRURPVVQ7DQorCQlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWlj
KHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCwNCisJCQkJdmFsLCAhKHZhbCAmIFJDQVJfVVNCM19E
TF9DVFJMX0ZXX1NFVF9EQVRBMCksDQorCQkJCTEsIDEwMDAwKTsNCisJCWlmIChyZXR2YWwgPCAw
KQ0KIAkJCWJyZWFrOw0KLQkJfQ0KIAl9DQogDQogCXRlbXAgPSByZWFkbChyZWdzICsgUkNBUl9V
U0IzX0RMX0NUUkwpOw0KIAl0ZW1wICY9IH5SQ0FSX1VTQjNfRExfQ1RSTF9FTkFCTEU7DQogCXdy
aXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KIA0KLQlmb3IgKHRpbWUgPSAw
OyB0aW1lIDwgdGltZW91dDsgdGltZSsrKSB7DQotCQl2YWwgPSByZWFkbChyZWdzICsgUkNBUl9V
U0IzX0RMX0NUUkwpOw0KLQkJaWYgKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1Mp
IHsNCi0JCQlyZXR2YWwgPSAwOw0KLQkJCWJyZWFrOw0KLQkJfQ0KLQkJdWRlbGF5KDEpOw0KLQl9
DQotCWlmICh0aW1lID09IHRpbWVvdXQpDQotCQlyZXR2YWwgPSAtRVRJTUVET1VUOw0KKwlyZXR2
YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwp
LA0KKwkJCXZhbCwgKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpLCAxLCAxMDAw
MCk7DQogDQogCXJlbGVhc2VfZmlybXdhcmUoZncpOw0KIA0KQEAgLTIwMCwxOCArMTg3LDEyIEBA
IHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNkICpo
Y2QpDQogDQogc3RhdGljIGJvb2wgeGhjaV9yY2FyX3dhaXRfZm9yX3BsbF9hY3RpdmUoc3RydWN0
IHVzYl9oY2QgKmhjZCkNCiB7DQotCWludCB0aW1lb3V0ID0gMTAwMDsNCisJaW50IHJldHZhbDsN
CiAJdTMyIHZhbCwgbWFzayA9IFJDQVJfVVNCM19BWEhfU1RBX1BMTF9BQ1RJVkVfTUFTSzsNCiAN
Ci0Jd2hpbGUgKHRpbWVvdXQgPiAwKSB7DQotCQl2YWwgPSByZWFkbChoY2QtPnJlZ3MgKyBSQ0FS
X1VTQjNfQVhIX1NUQSk7DQotCQlpZiAoKHZhbCAmIG1hc2spID09IG1hc2spDQotCQkJcmV0dXJu
IHRydWU7DQotCQl1ZGVsYXkoMSk7DQotCQl0aW1lb3V0LS07DQotCX0NCi0NCi0JcmV0dXJuIGZh
bHNlOw0KKwlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKGhjZC0+cmVncyArIFJD
QVJfVVNCM19BWEhfU1RBLA0KKwkJCXZhbCwgKCh2YWwgJiBtYXNrKSA9PSBtYXNrKSwgMSwgMTAw
MCk7DQorCXJldHVybiAhIXJldHZhbDsNCiB9DQogDQogLyogVGhpcyBmdW5jdGlvbiBuZWVkcyB0
byBpbml0aWFsaXplIGEgInBoeSIgb2YgdXNiIGJlZm9yZSAqLw0KLS0gDQoxLjkuMQ0K

