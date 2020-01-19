Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46407C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12498246AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JuFvvO89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgASBqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:46:20 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17002 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728847AbgASBqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:46:19 -0500
X-UUID: 2224402434e14e11985b2fb348685f06-20200119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ivEcPT8iEpAX9W6/VujM8EVm+W1Y9SnJ0dVmMcBNlH8=;
        b=JuFvvO891DcZ8n2lL03BjCVmGunkGTzmVUznn4UsaKs09upEYnL+QRPJWBiiB2dNFUTEU+BJlu//RqqxBD6mX8FMxRJ6o0raK7R3UEPaERKaaYUxeCR1h1Ulb6GTvitsDmHqiYO0bvHC6Q5di9a5UF40MVkM0sVB0rDPj/HErTM=;
X-UUID: 2224402434e14e11985b2fb348685f06-20200119
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1726624286; Sun, 19 Jan 2020 09:46:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 19 Jan
 2020 09:42:38 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 19 Jan 2020 09:45:02 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v10 3/5] drm/panel: support for auo, kd101n80-45na wuxga dsi video mode panel
Date:   Sun, 19 Jan 2020 09:45:39 +0800
Message-ID: <20200119014541.64273-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200119014541.64273-1-jitao.shi@mediatek.com>
References: <20200119014541.64273-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8E08A057F485E67EEFF4661343877C52EE854D1E48A879BAE38A304BDE365EA22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXVvLGtkMTAxbjgwLTQ1bmEncyBjb25uZWN0b3IgaXMgc2FtZSBhcyBib2UsdHYxMDF3dW0tbmw2
Lg0KVGhlIG1vc3QgY29kZXMgY2FuIGJlIHJldXNlLg0KU28gYXVvLGtkMTAxbjgwLTQ1bmEgYW5k
IGJvZSx0djEwMXd1bS1ubDYgdXNlIG9uZSBkcml2ZXIgZmlsZS4NCkFkZCB0aGUgZGlmZmVyZW50
IHBhcnRzIGluIGRyaXZlciBkYXRhLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFv
LnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgfCAgNiArLQ0KIC4uLi9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEw
MXd1bS1ubDYuYyAgICB8IDY0ICsrKysrKysrKysrKysrKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQs
IDYxIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcGFuZWwvS2NvbmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9LY29uZmlnDQpp
bmRleCBjYTcyN2MyMzNhOWEuLmI1NDEzZWRkNjI1YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9wYW5lbC9LY29uZmlnDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvS2NvbmZpZw0K
QEAgLTMwLDEzICszMCwxMyBAQCBjb25maWcgRFJNX1BBTkVMX0JPRV9ISU1BWDgyNzlEDQogCSAg
dGhlIGhvc3QgYW5kIGhhcyBhIGJ1aWx0LWluIExFRCBiYWNrbGlnaHQuDQogDQogY29uZmlnIERS
TV9QQU5FTF9CT0VfVFYxMDFXVU1fTkw2DQotCXRyaXN0YXRlICJCT0UgVFYxMDFXVU0gMTIwMHgx
OTIwIHBhbmVsIg0KKwl0cmlzdGF0ZSAiQk9FIFRWMTAxV1VNIGFuZCBBVU8gS0QxMDFOODAgNDVO
QSAxMjAweDE5MjAgcGFuZWwiDQogCWRlcGVuZHMgb24gT0YNCiAJZGVwZW5kcyBvbiBEUk1fTUlQ
SV9EU0kNCiAJZGVwZW5kcyBvbiBCQUNLTElHSFRfQ0xBU1NfREVWSUNFDQogCWhlbHANCi0JICBT
YXkgWSBoZXJlIGlmIHlvdSB3YW50IHRvIHN1cHBvcnQgZm9yIEJPRSBUVjEwMVdVTSBXVVhHQSBQ
QU5FTA0KLQkgIERTSSBWaWRlbyBNb2RlIHBhbmVsDQorCSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2Fu
dCB0byBzdXBwb3J0IGZvciBCT0UgVFYxMDFXVU0gYW5kIEFVTyBLRDEwMU44MA0KKwkgIDQ1TkEg
V1VYR0EgUEFORUwgRFNJIFZpZGVvIE1vZGUgcGFuZWwNCiANCiBjb25maWcgRFJNX1BBTkVMX0xW
RFMNCiAJdHJpc3RhdGUgIkdlbmVyaWMgTFZEUyBwYW5lbCBkcml2ZXIiDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYuYyBiL2RyaXZlcnMv
Z3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMNCmluZGV4IDUxZmRlNTg4YWRj
MS4uMjE2MDE0NGNhNTFiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVs
LWJvZS10djEwMXd1bS1ubDYuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJv
ZS10djEwMXd1bS1ubDYuYw0KQEAgLTM0LDYgKzM0LDcgQEAgc3RydWN0IHBhbmVsX2Rlc2Mgew0K
IAllbnVtIG1pcGlfZHNpX3BpeGVsX2Zvcm1hdCBmb3JtYXQ7DQogCWNvbnN0IHN0cnVjdCBwYW5l
bF9pbml0X2NtZCAqaW5pdF9jbWRzOw0KIAl1bnNpZ25lZCBpbnQgbGFuZXM7DQorCWJvb2wgZGlz
Y2hhcmdlX29uX2Rpc2FibGU7DQogfTsNCiANCiBzdHJ1Y3QgYm9lX3BhbmVsIHsNCkBAIC0zNjcs
NiArMzY4LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGFuZWxfaW5pdF9jbWQgYm9lX2luaXRf
Y21kW10gPSB7DQogCXt9LA0KIH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBwYW5lbF9pbml0
X2NtZCBhdW9fa2QxMDFuODBfNDVuYV9pbml0X2NtZFtdID0gew0KKwlfSU5JVF9ERUxBWV9DTUQo
MjQpLA0KKwlfSU5JVF9EQ1NfQ01EKDB4MTEpLA0KKwlfSU5JVF9ERUxBWV9DTUQoMTIwKSwNCisJ
X0lOSVRfRENTX0NNRCgweDI5KSwNCisJX0lOSVRfREVMQVlfQ01EKDEyMCksDQorCXt9LA0KK307
DQorDQogc3RhdGljIGlubGluZSBzdHJ1Y3QgYm9lX3BhbmVsICp0b19ib2VfcGFuZWwoc3RydWN0
IGRybV9wYW5lbCAqcGFuZWwpDQogew0KIAlyZXR1cm4gY29udGFpbmVyX29mKHBhbmVsLCBzdHJ1
Y3QgYm9lX3BhbmVsLCBiYXNlKTsNCkBAIC00NDQsMTIgKzQ1NCwyMiBAQCBzdGF0aWMgaW50IGJv
ZV9wYW5lbF91bnByZXBhcmUoc3RydWN0IGRybV9wYW5lbCAqcGFuZWwpDQogCX0NCiANCiAJbXNs
ZWVwKDE1MCk7DQotCWdwaW9kX3NldF92YWx1ZShib2UtPmVuYWJsZV9ncGlvLCAwKTsNCi0JdXNs
ZWVwX3JhbmdlKDUwMCwgMTAwMCk7DQotCXJlZ3VsYXRvcl9kaXNhYmxlKGJvZS0+YXZlZSk7DQot
CXJlZ3VsYXRvcl9kaXNhYmxlKGJvZS0+YXZkZCk7DQotCXVzbGVlcF9yYW5nZSg1MDAwLCA3MDAw
KTsNCi0JcmVndWxhdG9yX2Rpc2FibGUoYm9lLT5wcDE4MDApOw0KKw0KKwlpZiAoYm9lLT5kZXNj
LT5kaXNjaGFyZ2Vfb25fZGlzYWJsZSkgew0KKwkJcmVndWxhdG9yX2Rpc2FibGUoYm9lLT5hdmVl
KTsNCisJCXJlZ3VsYXRvcl9kaXNhYmxlKGJvZS0+YXZkZCk7DQorCQl1c2xlZXBfcmFuZ2UoNTAw
MCwgNzAwMCk7DQorCQlncGlvZF9zZXRfdmFsdWUoYm9lLT5lbmFibGVfZ3BpbywgMCk7DQorCQl1
c2xlZXBfcmFuZ2UoNTAwMCwgNzAwMCk7DQorCQlyZWd1bGF0b3JfZGlzYWJsZShib2UtPnBwMTgw
MCk7DQorCX0gZWxzZSB7DQorCQlncGlvZF9zZXRfdmFsdWUoYm9lLT5lbmFibGVfZ3BpbywgMCk7
DQorCQl1c2xlZXBfcmFuZ2UoNTAwLCAxMDAwKTsNCisJCXJlZ3VsYXRvcl9kaXNhYmxlKGJvZS0+
YXZlZSk7DQorCQlyZWd1bGF0b3JfZGlzYWJsZShib2UtPmF2ZGQpOw0KKwkJdXNsZWVwX3Jhbmdl
KDUwMDAsIDcwMDApOw0KKwkJcmVndWxhdG9yX2Rpc2FibGUoYm9lLT5wcDE4MDApOw0KKwl9DQog
DQogCWJvZS0+cHJlcGFyZWQgPSBmYWxzZTsNCiANCkBAIC01NDIsNiArNTYyLDM1IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGFuZWxfZGVzYyBib2VfdHYxMDF3dW1fbmw2X2Rlc2MgPSB7DQogCS5t
b2RlX2ZsYWdzID0gTUlQSV9EU0lfTU9ERV9WSURFTyB8IE1JUElfRFNJX01PREVfVklERU9fU1lO
Q19QVUxTRSB8DQogCQkgICAgICBNSVBJX0RTSV9NT0RFX0xQTSwNCiAJLmluaXRfY21kcyA9IGJv
ZV9pbml0X2NtZCwNCisJLmRpc2NoYXJnZV9vbl9kaXNhYmxlID0gZmFsc2UsDQorfTsNCisNCitz
dGF0aWMgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgYXVvX2tkMTAxbjgwXzQ1bmFfZGVm
YXVsdF9tb2RlID0gew0KKwkuY2xvY2sgPSAxNTcwMDAsDQorCS5oZGlzcGxheSA9IDEyMDAsDQor
CS5oc3luY19zdGFydCA9IDEyMDAgKyA4MCwNCisJLmhzeW5jX2VuZCA9IDEyMDAgKyA4MCArIDI0
LA0KKwkuaHRvdGFsID0gMTIwMCArIDgwICsgMjQgKyAzNiwNCisJLnZkaXNwbGF5ID0gMTkyMCwN
CisJLnZzeW5jX3N0YXJ0ID0gMTkyMCArIDE2LA0KKwkudnN5bmNfZW5kID0gMTkyMCArIDE2ICsg
NCwNCisJLnZ0b3RhbCA9IDE5MjAgKyAxNiArIDQgKyAxNiwNCisJLnZyZWZyZXNoID0gNjAsDQor
fTsNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IHBhbmVsX2Rlc2MgYXVvX2tkMTAxbjgwXzQ1bmFf
ZGVzYyA9IHsNCisJLm1vZGVzID0gJmF1b19rZDEwMW44MF80NW5hX2RlZmF1bHRfbW9kZSwNCisJ
LmJwYyA9IDgsDQorCS5zaXplID0gew0KKwkJLndpZHRoX21tID0gMTM1LA0KKwkJLmhlaWdodF9t
bSA9IDIxNiwNCisJfSwNCisJLmxhbmVzID0gNCwNCisJLmZvcm1hdCA9IE1JUElfRFNJX0ZNVF9S
R0I4ODgsDQorCS5tb2RlX2ZsYWdzID0gTUlQSV9EU0lfTU9ERV9WSURFTyB8IE1JUElfRFNJX01P
REVfVklERU9fU1lOQ19QVUxTRSB8DQorCQkgICAgICBNSVBJX0RTSV9NT0RFX0xQTSwNCisJLmlu
aXRfY21kcyA9IGF1b19rZDEwMW44MF80NW5hX2luaXRfY21kLA0KKwkuZGlzY2hhcmdlX29uX2Rp
c2FibGUgPSB0cnVlLA0KIH07DQogDQogc3RhdGljIGludCBib2VfcGFuZWxfZ2V0X21vZGVzKHN0
cnVjdCBkcm1fcGFuZWwgKnBhbmVsLA0KQEAgLTY3Myw2ICs3MjIsOSBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBib2Vfb2ZfbWF0Y2hbXSA9IHsNCiAJeyAuY29tcGF0aWJsZSA9
ICJib2UsdHYxMDF3dW0tbmw2IiwNCiAJICAuZGF0YSA9ICZib2VfdHYxMDF3dW1fbmw2X2Rlc2MN
CiAJfSwNCisJeyAuY29tcGF0aWJsZSA9ICJhdW8sa2QxMDFuODAtNDVuYSIsDQorCSAgLmRhdGEg
PSAmYXVvX2tkMTAxbjgwXzQ1bmFfZGVzYw0KKwl9LA0KIAl7IC8qIHNlbnRpbmVsICovIH0NCiB9
Ow0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGJvZV9vZl9tYXRjaCk7DQotLSANCjIuMjEuMA0K

