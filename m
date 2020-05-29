Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D565C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497EE2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MAeKSDfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgE2LG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:06:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8567 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725863AbgE2LGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:06:52 -0400
X-UUID: cf913136332d4bb09b331d247ef7b198-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jZUffhDsS3iywjAJ/yJ5JfUnRTxh9XWi8vUqBMSK1xw=;
        b=MAeKSDfGibfhzNGpPlWlhJ/kWsZ4/N80ioIeOhEGfnRn/faegoj3xhPuJufnwFq45IodCqZ+aF5bUNUbzM8rYaIWU0OjCsYFaNOpfs8fsCBPRhKtCJe/9TaHin9DIIrmv4bbFFCv/8ljt+sDmssUASCaQQOUMOXjv6XuBF8n3JU=;
X-UUID: cf913136332d4bb09b331d247ef7b198-20200529
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 844972419; Fri, 29 May 2020 19:06:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 19:06:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 19:06:43 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <matthias.bgg@gmail.com>, <hariprasad.kelam@gmail.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt6358: support DMIC one-wire mode
Date:   Fri, 29 May 2020 19:04:53 +0800
Message-ID: <1590750293-12769-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 56AF50F10CD9D0433DF18F5F850C09F0DF00BA6224F5C412DE4A190D0C76F8BF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VwcG9ydHMgRE1JQyBvbmUtd2lyZSBtb2RlLiBBZGRzIGEgbWl4ZXIgY29udHJvbCB0byBlbmFi
bGUgYW5kIGRpc2FibGUuDQoNClNpZ25lZC1vZmYtYnk6IEppYXhpbiBZdSA8amlheGluLnl1QG1l
ZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBUenVuZy1CaSBTaGloIDx0enVuZ2JpQGdvb2dsZS5j
b20+DQotLS0NCiBzb3VuZC9zb2MvY29kZWNzL210NjM1OC5jIHwgMzMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvbXQ2MzU4LmMgYi9z
b3VuZC9zb2MvY29kZWNzL210NjM1OC5jDQppbmRleCAxYjgzMGVhLi5jYTc2MjhkIDEwMDY0NA0K
LS0tIGEvc291bmQvc29jL2NvZGVjcy9tdDYzNTguYw0KKysrIGIvc291bmQvc29jL2NvZGVjcy9t
dDYzNTguYw0KQEAgLTk1LDYgKzk1LDggQEAgc3RydWN0IG10NjM1OF9wcml2IHsNCiAJc3RydWN0
IHJlZ3VsYXRvciAqYXZkZF9yZWc7DQogDQogCWludCB3b3ZfZW5hYmxlZDsNCisNCisJaW50IGRt
aWNfb25lX3dpcmVfbW9kZTsNCiB9Ow0KIA0KIGludCBtdDYzNThfc2V0X210a2FpZl9wcm90b2Nv
bChzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNtcG50LA0KQEAgLTU2Niw2ICs1NjgsMjggQEAg
c3RhdGljIGludCBtdDYzNThfcHV0X3dvdihzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwN
CiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyBpbnQgbXQ2MzU4X2RtaWNfb25lX3dpcmVfbW9k
ZV9nZXQoc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsDQorCQkJCQkgc3RydWN0IHNuZF9j
dGxfZWxlbV92YWx1ZSAqdWNvbnRyb2wpDQorew0KKwlzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQg
KmNtcG50ID0gc25kX3NvY19rY29udHJvbF9jb21wb25lbnQoa2NvbnRyb2wpOw0KKwlzdHJ1Y3Qg
bXQ2MzU4X3ByaXYgKnByaXYgPSBzbmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjbXBudCk7
DQorDQorCXVjb250cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzBdID0gcHJpdi0+ZG1pY19vbmVf
d2lyZV9tb2RlOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludCBtdDYzNThfZG1p
Y19vbmVfd2lyZV9tb2RlX3NldChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwNCisJCQkJ
CSBzdHJ1Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkNCit7DQorCXN0cnVjdCBzbmRf
c29jX2NvbXBvbmVudCAqY21wbnQgPSBzbmRfc29jX2tjb250cm9sX2NvbXBvbmVudChrY29udHJv
bCk7DQorCXN0cnVjdCBtdDYzNThfcHJpdiAqcHJpdiA9IHNuZF9zb2NfY29tcG9uZW50X2dldF9k
cnZkYXRhKGNtcG50KTsNCisNCisJcHJpdi0+ZG1pY19vbmVfd2lyZV9tb2RlID0gdWNvbnRyb2wt
PnZhbHVlLmludGVnZXIudmFsdWVbMF07DQorDQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMg
Y29uc3QgREVDTEFSRV9UTFZfREJfU0NBTEUocGxheWJhY2tfdGx2LCAtMTAwMCwgMTAwLCAwKTsN
CiBzdGF0aWMgY29uc3QgREVDTEFSRV9UTFZfREJfU0NBTEUocGdhX3RsdiwgMCwgNjAwLCAwKTsN
CiANCkBAIC01ODgsNiArNjEyLDEwIEBAIHN0YXRpYyBpbnQgbXQ2MzU4X3B1dF93b3Yoc3RydWN0
IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsDQogDQogCVNPQ19TSU5HTEVfQk9PTF9FWFQoIldha2Ut
b24tVm9pY2UgUGhhc2UyIFN3aXRjaCIsIDAsDQogCQkJICAgIG10NjM1OF9nZXRfd292LCBtdDYz
NThfcHV0X3dvdiksDQorDQorCVNPQ19TSU5HTEVfQk9PTF9FWFQoIkRtaWMgT25lIFdpcmUgTW9k
ZSIsIDAsDQorCQkJICAgIG10NjM1OF9kbWljX29uZV93aXJlX21vZGVfZ2V0LA0KKwkJCSAgICBt
dDYzNThfZG1pY19vbmVfd2lyZV9tb2RlX3NldCksDQogfTsNCiANCiAvKiBNVVggKi8NCkBAIC0x
NzQwLDcgKzE3NjgsMTAgQEAgc3RhdGljIGludCBtdDYzNThfYW1pY19lbmFibGUoc3RydWN0IG10
NjM1OF9wcml2ICpwcml2KQ0KIAltdDYzNThfbXRrYWlmX3R4X2VuYWJsZShwcml2KTsNCiANCiAJ
LyogVUwgZG1pYyBzZXR0aW5nIG9mZiAqLw0KLQlyZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBN
VDYzNThfQUZFX1VMX1NSQ19DT04wX0gsIDB4MDAwMCk7DQorCWlmIChwcml2LT5kbWljX29uZV93
aXJlX21vZGUpDQorCQlyZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBNVDYzNThfQUZFX1VMX1NS
Q19DT04wX0gsIDB4MDQwMCk7DQorCWVsc2UNCisJCXJlZ21hcF93cml0ZShwcml2LT5yZWdtYXAs
IE1UNjM1OF9BRkVfVUxfU1JDX0NPTjBfSCwgMHgwMDgwKTsNCiANCiAJLyogVUwgdHVybiBvbiAq
Lw0KIAlyZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBNVDYzNThfQUZFX1VMX1NSQ19DT04wX0ws
IDB4MDAwMSk7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

