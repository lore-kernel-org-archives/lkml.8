Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEC020760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QLgEKSyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGCEmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:42:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18438 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725779AbgGCEmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:42:49 -0400
X-UUID: c9b2f040ccb34369906be916612b05f1-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=e/bGfH/vs/SEn/d/7v72DL9HP+g5CsFblZIevZXeBhM=;
        b=QLgEKSypB9wm7yPREo8R1GIUyye4Q4Oyve8b391W3a8oyJjAafJpXOHGDUq40Q7BdemmkXpTHkgyCELMz5E3fdQMCVzbQhKnnbMAuG5p7+3CessLX79esLjAUD/QU3HbBIWFz4soQ6YQYUN2Rd/YviiYOYuNeeKcZJacTu8dDZ8=;
X-UUID: c9b2f040ccb34369906be916612b05f1-20200703
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 419561045; Fri, 03 Jul 2020 12:42:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:42 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:38 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 03/10] iommu/mediatek: Use a u32 flags to describe different HW features
Date:   Fri, 3 Jul 2020 12:41:20 +0800
Message-ID: <20200703044127.27438-4-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2l2ZW4gdGhlIGZhY3QgdGhhdCB3ZSBhcmUgYWRkaW5nIG1vcmUgYW5kIG1vcmUgcGxhdF9kYXRh
IGJvb2wgdmFsdWVzLA0KaXQgd291bGQgbWFrZSBzZW5zZSB0byB1c2UgYSB1MzIgZmxhZ3MgcmVn
aXN0ZXIgYW5kIGFkZCB0aGUgYXBwcm9wcmlhdGUNCm1hY3JvIGRlZmluaXRpb25zIHRvIHNldCBh
bmQgY2hlY2sgZm9yIGEgZmxhZyBwcmVzZW50Lg0KTm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQoNCkNj
OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NClN1Z2dlc3RlZC1ieTogTWF0dGhpYXMg
QnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IENoYW8gSGFv
IDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8
bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
fCAyOCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuaCB8ICA3ICstLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE3
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBi
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDg4ZDNkZjViOTFjMi4uNDBjYTU2NGQ5
N2FmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTEwMCw2ICsxMDAsMTUgQEANCiAjZGVmaW5lIE1US19N
NFVfVE9fTEFSQihpZCkJCSgoKGlkKSA+PiA1KSAmIDB4ZikNCiAjZGVmaW5lIE1US19NNFVfVE9f
UE9SVChpZCkJCSgoaWQpICYgMHgxZikNCiANCisjZGVmaW5lIEhBU180R0JfTU9ERQkJCUJJVCgw
KQ0KKy8qIEhXIHdpbGwgdXNlIHRoZSBFTUkgY2xvY2sgaWYgdGhlcmUgaXNuJ3QgdGhlICJiY2xr
Ii4gKi8NCisjZGVmaW5lIEhBU19CQ0xLCQkJQklUKDEpDQorI2RlZmluZSBIQVNfVkxEX1BBX1JO
RwkJCUJJVCgyKQ0KKyNkZWZpbmUgUkVTRVRfQVhJCQkJQklUKDMpDQorDQorI2RlZmluZSBNVEtf
SU9NTVVfSEFTX0ZMQUcocGRhdGEsIF94KSBcDQorCQkoKCgocGRhdGEpLT5mbGFncykgJiAoX3gp
KSA9PSAoX3gpKQ0KKw0KIHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluIHsNCiAJc3RydWN0IGlvX3Bn
dGFibGVfY2ZnCQljZmc7DQogCXN0cnVjdCBpb19wZ3RhYmxlX29wcwkJKmlvcDsNCkBAIC01NjMs
NyArNTcyLDggQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRr
X2lvbW11X2RhdGEgKmRhdGEpDQogCQkJIHVwcGVyXzMyX2JpdHMoZGF0YS0+cHJvdGVjdF9iYXNl
KTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9JVlJQX1BB
RERSKTsNCiANCi0JaWYgKGRhdGEtPmVuYWJsZV80R0IgJiYgZGF0YS0+cGxhdF9kYXRhLT5oYXNf
dmxkX3BhX3JuZykgew0KKwlpZiAoZGF0YS0+ZW5hYmxlXzRHQiAmJg0KKwkgICAgTVRLX0lPTU1V
X0hBU19GTEFHKGRhdGEtPnBsYXRfZGF0YSwgSEFTX1ZMRF9QQV9STkcpKSB7DQogCQkvKg0KIAkJ
ICogSWYgNEdCIG1vZGUgaXMgZW5hYmxlZCwgdGhlIHZhbGlkYXRlIFBBIHJhbmdlIGlzIGZyb20N
CiAJCSAqIDB4MV8wMDAwXzAwMDAgdG8gMHgxX2ZmZmZfZmZmZi4gaGVyZSByZWNvcmQgYml0WzMy
OjMwXS4NCkBAIC01NzMsNyArNTgzLDcgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5pdChj
b25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQogCX0NCiAJd3JpdGVsX3JlbGF4ZWQo
MCwgZGF0YS0+YmFzZSArIFJFR19NTVVfRENNX0RJUyk7DQogDQotCWlmIChkYXRhLT5wbGF0X2Rh
dGEtPnJlc2V0X2F4aSkgew0KKwlpZiAoTVRLX0lPTU1VX0hBU19GTEFHKGRhdGEtPnBsYXRfZGF0
YSwgUkVTRVRfQVhJKSkgew0KIAkJLyogVGhlIHJlZ2lzdGVyIGlzIGNhbGxlZCBTVEFOREFSRF9B
WElfTU9ERSBpbiB0aGlzIGNhc2UgKi8NCiAJCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2Ug
KyBSRUdfTU1VX01JU0NfQ1RSTCk7DQogCX0NCkBAIC02MTgsNyArNjI4LDcgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJLyog
V2hldGhlciB0aGUgY3VycmVudCBkcmFtIGlzIG92ZXIgNEdCICovDQogCWRhdGEtPmVuYWJsZV80
R0IgPSAhIShtYXhfcGZuID4gKEJJVF9VTEwoMzIpID4+IFBBR0VfU0hJRlQpKTsNCi0JaWYgKCFk
YXRhLT5wbGF0X2RhdGEtPmhhc180Z2JfbW9kZSkNCisJaWYgKCFNVEtfSU9NTVVfSEFTX0ZMQUco
ZGF0YS0+cGxhdF9kYXRhLCBIQVNfNEdCX01PREUpKQ0KIAkJZGF0YS0+ZW5hYmxlXzRHQiA9IGZh
bHNlOw0KIA0KIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9N
RU0sIDApOw0KQEAgLTYzMSw3ICs2NDEsNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoZGF0YS0+aXJxIDwgMCkNCiAJCXJl
dHVybiBkYXRhLT5pcnE7DQogDQotCWlmIChkYXRhLT5wbGF0X2RhdGEtPmhhc19iY2xrKSB7DQor
CWlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBIQVNfQkNMSykpIHsNCiAJ
CWRhdGEtPmJjbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAiYmNsayIpOw0KIAkJaWYgKElTX0VSUihk
YXRhLT5iY2xrKSkNCiAJCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5iY2xrKTsNCkBAIC03NjMsMjMg
Kzc3MywxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgbXRrX2lvbW11X3BtX29w
cyA9IHsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQyNzEy
X2RhdGEgPSB7DQogCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQyNzEyLA0KLQkuaGFzXzRnYl9tb2Rl
ID0gdHJ1ZSwNCi0JLmhhc19iY2xrICAgICA9IHRydWUsDQotCS5oYXNfdmxkX3BhX3JuZyAgID0g
dHJ1ZSwNCisJLmZsYWdzICAgICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwgSEFTX1ZM
RF9QQV9STkcsDQogCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwg
OX0sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4
MTczX2RhdGEgPSB7DQogCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTczLA0KLQkuaGFzXzRnYl9t
b2RlID0gdHJ1ZSwNCi0JLmhhc19iY2xrICAgICA9IHRydWUsDQotCS5yZXNldF9heGkgICAgPSB0
cnVlLA0KKwkuZmxhZ3MJICAgICAgPSBIQVNfNEdCX01PREUgfCBIQVNfQkNMSyB8IFJFU0VUX0FY
SSwNCiAJLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1fSwgLyogTGluZWFyIG1hcHBp
bmcuICovDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEg
bXQ4MTgzX2RhdGEgPSB7DQogCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTgzLA0KLQkucmVzZXRf
YXhpICAgID0gdHJ1ZSwNCisJLmZsYWdzICAgICAgICA9IFJFU0VUX0FYSSwNCiAJLmxhcmJpZF9y
ZW1hcCA9IHswLCA0LCA1LCA2LCA3LCAyLCAzLCAxfSwNCiB9Ow0KIA0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRl
eCA3MjEyZTZmY2Y5ODIuLjUyMjVhOTE3MGFhYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0zOSwxMiAr
MzksNyBAQCBlbnVtIG10a19pb21tdV9wbGF0IHsNCiANCiBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRf
ZGF0YSB7DQogCWVudW0gbXRrX2lvbW11X3BsYXQgbTR1X3BsYXQ7DQotCWJvb2wgICAgICAgICAg
ICAgICAgaGFzXzRnYl9tb2RlOw0KLQ0KLQkvKiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlm
IHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICovDQotCWJvb2wgICAgICAgICAgICAgICAgaGFzX2Jj
bGs7DQotCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQotCWJvb2wgICAgICAg
ICAgICAgICAgcmVzZXRfYXhpOw0KKwl1MzIgICAgICAgICAgICAgICAgIGZsYWdzOw0KIAl1bnNp
Z25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0KIH07DQogDQot
LSANCjIuMTguMA0K

