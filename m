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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76917C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230CD2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mVeJpvz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgIJI0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:26:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2671 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730393AbgIJIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:38 -0400
X-UUID: 4d03c4db00bb4a5e8236d13890d71c84-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F4mzGda76Rx36DNHSGEKqplD8yql9lIdY7JyMYhES0w=;
        b=mVeJpvz+f1x62p2saZatnh61UwBArI54BYT7HBIyxwmappQKZ1QuRXs9NIH+JatHQNZBtZOn7seayfT1q8ExdfmYGJZevsqgworTA5J/GN26qfrq6mWCLaeYoAPqApJkbjlHRaVk0D9y59br5g8E0GAF+HL/mrQAYfC24Viftvc=;
X-UUID: 4d03c4db00bb4a5e8236d13890d71c84-20200910
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 297554876; Thu, 10 Sep 2020 16:24:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:04 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:02 +0800
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
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:45 +0800
Message-ID: <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D551D691DB25F07A367A51FC77988420B16EE09204599E6579A68152A513AEC42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NCkNjOiBZb3NoaWhp
cm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyfnYz
OiBubyBjaGFuZ2VzDQotLS0NCiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jIHwgNDMgKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2hvc3QveGhjaS1yY2FyLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jDQpp
bmRleCBjMTAyNWQzLi43NGY4MzZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNp
LXJjYXIuYw0KKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KQEAgLTYsNiArNiw3
IEBADQogICovDQogDQogI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQorI2luY2x1ZGUgPGxp
bnV4L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mLmg+DQpAQCAtMTI3LDgg
KzEyOCw3IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1
c2JfaGNkICpoY2QpDQogCXZvaWQgX19pb21lbSAqcmVncyA9IGhjZC0+cmVnczsNCiAJc3RydWN0
IHhoY2lfcGxhdF9wcml2ICpwcml2ID0gaGNkX3RvX3hoY2lfcHJpdihoY2QpOw0KIAljb25zdCBz
dHJ1Y3QgZmlybXdhcmUgKmZ3Ow0KLQlpbnQgcmV0dmFsLCBpbmRleCwgaiwgdGltZTsNCi0JaW50
IHRpbWVvdXQgPSAxMDAwMDsNCisJaW50IHJldHZhbCwgaW5kZXgsIGo7DQogCXUzMiBkYXRhLCB2
YWwsIHRlbXA7DQogCXUzMiBxdWlya3MgPSAwOw0KIAljb25zdCBzdHJ1Y3Qgc29jX2RldmljZV9h
dHRyaWJ1dGUgKmF0dHI7DQpAQCAtMTY2LDMyICsxNjYsMTkgQEAgc3RhdGljIGludCB4aGNpX3Jj
YXJfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVzYl9oY2QgKmhjZCkNCiAJCXRlbXAgfD0gUkNB
Ul9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwOw0KIAkJd3JpdGVsKHRlbXAsIHJlZ3MgKyBSQ0FS
X1VTQjNfRExfQ1RSTCk7DQogDQotCQlmb3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGlt
ZSsrKSB7DQotCQkJdmFsID0gcmVhZGwocmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCi0JCQlp
ZiAoKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCkgPT0gMCkNCi0JCQkJYnJl
YWs7DQotCQkJdWRlbGF5KDEpOw0KLQkJfQ0KLQkJaWYgKHRpbWUgPT0gdGltZW91dCkgew0KLQkJ
CXJldHZhbCA9IC1FVElNRURPVVQ7DQorCQlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRv
bWljKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCwNCisJCQkJdmFsLCAhKHZhbCAmIFJDQVJfVVNC
M19ETF9DVFJMX0ZXX1NFVF9EQVRBMCksDQorCQkJCTEsIDEwMDAwKTsNCisJCWlmIChyZXR2YWwg
PCAwKQ0KIAkJCWJyZWFrOw0KLQkJfQ0KIAl9DQogDQogCXRlbXAgPSByZWFkbChyZWdzICsgUkNB
Ul9VU0IzX0RMX0NUUkwpOw0KIAl0ZW1wICY9IH5SQ0FSX1VTQjNfRExfQ1RSTF9FTkFCTEU7DQog
CXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KIA0KLQlmb3IgKHRpbWUg
PSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsrKSB7DQotCQl2YWwgPSByZWFkbChyZWdzICsgUkNB
Ul9VU0IzX0RMX0NUUkwpOw0KLQkJaWYgKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NF
U1MpIHsNCi0JCQlyZXR2YWwgPSAwOw0KLQkJCWJyZWFrOw0KLQkJfQ0KLQkJdWRlbGF5KDEpOw0K
LQl9DQotCWlmICh0aW1lID09IHRpbWVvdXQpDQotCQlyZXR2YWwgPSAtRVRJTUVET1VUOw0KKwly
ZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKChyZWdzICsgUkNBUl9VU0IzX0RMX0NU
UkwpLA0KKwkJCXZhbCwgKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpLCAxLCAx
MDAwMCk7DQogDQogCXJlbGVhc2VfZmlybXdhcmUoZncpOw0KIA0KQEAgLTIwMCwxOCArMTg3LDEy
IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNk
ICpoY2QpDQogDQogc3RhdGljIGJvb2wgeGhjaV9yY2FyX3dhaXRfZm9yX3BsbF9hY3RpdmUoc3Ry
dWN0IHVzYl9oY2QgKmhjZCkNCiB7DQotCWludCB0aW1lb3V0ID0gMTAwMDsNCisJaW50IHJldHZh
bDsNCiAJdTMyIHZhbCwgbWFzayA9IFJDQVJfVVNCM19BWEhfU1RBX1BMTF9BQ1RJVkVfTUFTSzsN
CiANCi0Jd2hpbGUgKHRpbWVvdXQgPiAwKSB7DQotCQl2YWwgPSByZWFkbChoY2QtPnJlZ3MgKyBS
Q0FSX1VTQjNfQVhIX1NUQSk7DQotCQlpZiAoKHZhbCAmIG1hc2spID09IG1hc2spDQotCQkJcmV0
dXJuIHRydWU7DQotCQl1ZGVsYXkoMSk7DQotCQl0aW1lb3V0LS07DQotCX0NCi0NCi0JcmV0dXJu
IGZhbHNlOw0KKwlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKGhjZC0+cmVncyAr
IFJDQVJfVVNCM19BWEhfU1RBLA0KKwkJCXZhbCwgKCh2YWwgJiBtYXNrKSA9PSBtYXNrKSwgMSwg
MTAwMCk7DQorCXJldHVybiAhIXJldHZhbDsNCiB9DQogDQogLyogVGhpcyBmdW5jdGlvbiBuZWVk
cyB0byBpbml0aWFsaXplIGEgInBoeSIgb2YgdXNiIGJlZm9yZSAqLw0KLS0gDQoxLjkuMQ0K

