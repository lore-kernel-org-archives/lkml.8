Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582FC761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5656020718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KU7uNzSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgBQJFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:05:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58062 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728599AbgBQJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:05:40 -0500
X-UUID: 9d8daa15a41247eaa710b158ecd38da1-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=035FQ1Fw3xURfPM55/UUoa6QVfGND190Ak9FtnTFJ0g=;
        b=KU7uNzSuul8qgKRsTbzaDNP5WB0tPR8kiGqP+Q7NbcpsuuPrgR1kCuL+ysbvjyQgCdqi99oQPI2akmkcT0Vhe6SUlCZXPUT2422hUUOVhoH/HpSE6EXCn5R1zqN3wnjN6MlJP10VUd+z+4mlv08ucLZpDm2S8CQB2+2ugtGWjaI=;
X-UUID: 9d8daa15a41247eaa710b158ecd38da1-20200217
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1385568392; Mon, 17 Feb 2020 17:05:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 17:04:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 17:03:36 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v1 3/3] mailbox: mediatek: remove implementation related to atomic_exec
Date:   Mon, 17 Feb 2020 17:05:32 +0800
Message-ID: <20200217090532.16019-4-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
References: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWZ0ZXIgaW1wbGVtZW50IGZsdXNoLCBjbGllbnQgY2FuIGZsdXNoIHRoZSBleGVjdXRpbmcNCmNv
bW1hbmQgYnVmZmVyIG9yIGFib3J0IHRoZSBzdGlsbCB3YWl0aW5nIGZvciBldmVudA0KY29tbWFu
ZCBidWZmZXIsIHNvIGNvbnRyb2xsZXIgZG8gbm90IG5lZWQgdG8gaW1wbGVtZW50DQphdG9taWNf
ZXhlIGZlYXR1cmUuIHJlbW92ZSBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJp
YmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyB8IDc2ICsr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDY4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210
ay1jbWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCmlu
ZGV4IDBkYTVlMmRjMmMwZS4uYjI0ODIyYWQ4NDA5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYw0KKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KQEAgLTU2LDcgKzU2LDYgQEAgc3RydWN0IGNtZHFfdGhyZWFkIHsNCiAJdm9pZCBf
X2lvbWVtCQkqYmFzZTsNCiAJc3RydWN0IGxpc3RfaGVhZAl0YXNrX2J1c3lfbGlzdDsNCiAJdTMy
CQkJcHJpb3JpdHk7DQotCWJvb2wJCQlhdG9taWNfZXhlYzsNCiB9Ow0KIA0KIHN0cnVjdCBjbWRx
X3Rhc2sgew0KQEAgLTE2Miw0OCArMTYxLDExIEBAIHN0YXRpYyB2b2lkIGNtZHFfdGFza19pbnNl
cnRfaW50b190aHJlYWQoc3RydWN0IGNtZHFfdGFzayAqdGFzaykNCiAJY21kcV90aHJlYWRfaW52
YWxpZGF0ZV9mZXRjaGVkX2RhdGEodGhyZWFkKTsNCiB9DQogDQotc3RhdGljIGJvb2wgY21kcV9j
b21tYW5kX2lzX3dmZSh1NjQgY21kKQ0KLXsNCi0JdTY0IHdmZV9vcHRpb24gPSBDTURRX1dGRV9V
UERBVEUgfCBDTURRX1dGRV9XQUlUIHwgQ01EUV9XRkVfV0FJVF9WQUxVRTsNCi0JdTY0IHdmZV9v
cCA9ICh1NjQpKENNRFFfQ09ERV9XRkUgPDwgQ01EUV9PUF9DT0RFX1NISUZUKSA8PCAzMjsNCi0J
dTY0IHdmZV9tYXNrID0gKHU2NClDTURRX09QX0NPREVfTUFTSyA8PCAzMiB8IDB4ZmZmZmZmZmY7
DQotDQotCXJldHVybiAoKGNtZCAmIHdmZV9tYXNrKSA9PSAod2ZlX29wIHwgd2ZlX29wdGlvbikp
Ow0KLX0NCi0NCi0vKiB3ZSBhc3N1bWUgdGFza3MgaW4gdGhlIHNhbWUgZGlzcGxheSBHQ0UgdGhy
ZWFkIGFyZSB3YWl0aW5nIHRoZSBzYW1lIGV2ZW50LiAqLw0KLXN0YXRpYyB2b2lkIGNtZHFfdGFz
a19yZW1vdmVfd2ZlKHN0cnVjdCBjbWRxX3Rhc2sgKnRhc2spDQotew0KLQlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSB0YXNrLT5jbWRxLT5tYm94LmRldjsNCi0JdTY0ICpiYXNlID0gdGFzay0+cGt0LT52
YV9iYXNlOw0KLQlpbnQgaTsNCi0NCi0JZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoZGV2LCB0YXNr
LT5wYV9iYXNlLCB0YXNrLT5wa3QtPmNtZF9idWZfc2l6ZSwNCi0JCQkJRE1BX1RPX0RFVklDRSk7
DQotCWZvciAoaSA9IDA7IGkgPCBDTURRX05VTV9DTUQodGFzay0+cGt0KTsgaSsrKQ0KLQkJaWYg
KGNtZHFfY29tbWFuZF9pc193ZmUoYmFzZVtpXSkpDQotCQkJYmFzZVtpXSA9ICh1NjQpQ01EUV9K
VU1QX0JZX09GRlNFVCA8PCAzMiB8DQotCQkJCSAgQ01EUV9KVU1QX1BBU1M7DQotCWRtYV9zeW5j
X3NpbmdsZV9mb3JfZGV2aWNlKGRldiwgdGFzay0+cGFfYmFzZSwgdGFzay0+cGt0LT5jbWRfYnVm
X3NpemUsDQotCQkJCSAgIERNQV9UT19ERVZJQ0UpOw0KLX0NCi0NCiBzdGF0aWMgYm9vbCBjbWRx
X3RocmVhZF9pc19pbl93ZmUoc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQpDQogew0KIAlyZXR1
cm4gcmVhZGwodGhyZWFkLT5iYXNlICsgQ01EUV9USFJfV0FJVF9UT0tFTikgJiBDTURRX1RIUl9J
U19XQUlUSU5HOw0KIH0NCiANCi1zdGF0aWMgdm9pZCBjbWRxX3RocmVhZF93YWl0X2VuZChzdHJ1
Y3QgY21kcV90aHJlYWQgKnRocmVhZCwNCi0JCQkJIHVuc2lnbmVkIGxvbmcgZW5kX3BhKQ0KLXsN
Ci0Jc3RydWN0IGRldmljZSAqZGV2ID0gdGhyZWFkLT5jaGFuLT5tYm94LT5kZXY7DQotCXVuc2ln
bmVkIGxvbmcgY3Vycl9wYTsNCi0NCi0JaWYgKHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWModGhy
ZWFkLT5iYXNlICsgQ01EUV9USFJfQ1VSUl9BRERSLA0KLQkJCWN1cnJfcGEsIGN1cnJfcGEgPT0g
ZW5kX3BhLCAxLCAyMCkpDQotCQlkZXZfZXJyKGRldiwgIkdDRSB0aHJlYWQgY2Fubm90IHJ1biB0
byBlbmQuXG4iKTsNCi19DQotDQogc3RhdGljIHZvaWQgY21kcV90YXNrX2V4ZWNfZG9uZShzdHJ1
Y3QgY21kcV90YXNrICp0YXNrLCBlbnVtIGNtZHFfY2Jfc3RhdHVzIHN0YSkNCiB7DQogCXN0cnVj
dCBjbWRxX3Rhc2tfY2IgKmNiID0gJnRhc2stPnBrdC0+YXN5bmNfY2I7DQpAQCAtMzgzLDM2ICsz
NDUsMTUgQEAgc3RhdGljIGludCBjbWRxX21ib3hfc2VuZF9kYXRhKHN0cnVjdCBtYm94X2NoYW4g
KmNoYW4sIHZvaWQgKmRhdGEpDQogCQlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwg
dGhyZWFkKSA8IDApOw0KIAkJY3Vycl9wYSA9IHJlYWRsKHRocmVhZC0+YmFzZSArIENNRFFfVEhS
X0NVUlJfQUREUik7DQogCQllbmRfcGEgPSByZWFkbCh0aHJlYWQtPmJhc2UgKyBDTURRX1RIUl9F
TkRfQUREUik7DQotDQotCQkvKg0KLQkJICogQXRvbWljIGV4ZWN1dGlvbiBzaG91bGQgcmVtb3Zl
IHRoZSBmb2xsb3dpbmcgd2ZlLCBpLmUuIG9ubHkNCi0JCSAqIHdhaXQgZXZlbnQgYXQgZmlyc3Qg
dGFzaywgYW5kIHByZXZlbnQgdG8gcGF1c2Ugd2hlbiBydW5uaW5nLg0KLQkJICovDQotCQlpZiAo
dGhyZWFkLT5hdG9taWNfZXhlYykgew0KLQkJCS8qIEdDRSBpcyBleGVjdXRpbmcgaWYgY29tbWFu
ZCBpcyBub3QgV0ZFICovDQotCQkJaWYgKCFjbWRxX3RocmVhZF9pc19pbl93ZmUodGhyZWFkKSkg
ew0KLQkJCQljbWRxX3RocmVhZF9yZXN1bWUodGhyZWFkKTsNCi0JCQkJY21kcV90aHJlYWRfd2Fp
dF9lbmQodGhyZWFkLCBlbmRfcGEpOw0KLQkJCQlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQo
Y21kcSwgdGhyZWFkKSA8IDApOw0KLQkJCQkvKiBzZXQgdG8gdGhpcyB0YXNrIGRpcmVjdGx5ICov
DQotCQkJCXdyaXRlbCh0YXNrLT5wYV9iYXNlLA0KLQkJCQkgICAgICAgdGhyZWFkLT5iYXNlICsg
Q01EUV9USFJfQ1VSUl9BRERSKTsNCi0JCQl9IGVsc2Ugew0KLQkJCQljbWRxX3Rhc2tfaW5zZXJ0
X2ludG9fdGhyZWFkKHRhc2spOw0KLQkJCQljbWRxX3Rhc2tfcmVtb3ZlX3dmZSh0YXNrKTsNCi0J
CQkJc21wX21iKCk7IC8qIG1vZGlmeSBqdW1wIGJlZm9yZSBlbmFibGUgdGhyZWFkICovDQotCQkJ
fQ0KKwkJLyogY2hlY2sgYm91bmRhcnkgKi8NCisJCWlmIChjdXJyX3BhID09IGVuZF9wYSAtIENN
RFFfSU5TVF9TSVpFIHx8DQorCQkgICAgY3Vycl9wYSA9PSBlbmRfcGEpIHsNCisJCQkvKiBzZXQg
dG8gdGhpcyB0YXNrIGRpcmVjdGx5ICovDQorCQkJd3JpdGVsKHRhc2stPnBhX2Jhc2UsDQorCQkJ
ICAgICAgIHRocmVhZC0+YmFzZSArIENNRFFfVEhSX0NVUlJfQUREUik7DQogCQl9IGVsc2Ugew0K
LQkJCS8qIGNoZWNrIGJvdW5kYXJ5ICovDQotCQkJaWYgKGN1cnJfcGEgPT0gZW5kX3BhIC0gQ01E
UV9JTlNUX1NJWkUgfHwNCi0JCQkgICAgY3Vycl9wYSA9PSBlbmRfcGEpIHsNCi0JCQkJLyogc2V0
IHRvIHRoaXMgdGFzayBkaXJlY3RseSAqLw0KLQkJCQl3cml0ZWwodGFzay0+cGFfYmFzZSwNCi0J
CQkJICAgICAgIHRocmVhZC0+YmFzZSArIENNRFFfVEhSX0NVUlJfQUREUik7DQotCQkJfSBlbHNl
IHsNCi0JCQkJY21kcV90YXNrX2luc2VydF9pbnRvX3RocmVhZCh0YXNrKTsNCi0JCQkJc21wX21i
KCk7IC8qIG1vZGlmeSBqdW1wIGJlZm9yZSBlbmFibGUgdGhyZWFkICovDQotCQkJfQ0KKwkJCWNt
ZHFfdGFza19pbnNlcnRfaW50b190aHJlYWQodGFzayk7DQorCQkJc21wX21iKCk7IC8qIG1vZGlm
eSBqdW1wIGJlZm9yZSBlbmFibGUgdGhyZWFkICovDQogCQl9DQogCQl3cml0ZWwodGFzay0+cGFf
YmFzZSArIHBrdC0+Y21kX2J1Zl9zaXplLA0KIAkJICAgICAgIHRocmVhZC0+YmFzZSArIENNRFFf
VEhSX0VORF9BRERSKTsNCkBAIC01MDEsNyArNDQyLDYgQEAgc3RhdGljIHN0cnVjdCBtYm94X2No
YW4gKmNtZHFfeGxhdGUoc3RydWN0IG1ib3hfY29udHJvbGxlciAqbWJveCwNCiANCiAJdGhyZWFk
ID0gKHN0cnVjdCBjbWRxX3RocmVhZCAqKW1ib3gtPmNoYW5zW2luZF0uY29uX3ByaXY7DQogCXRo
cmVhZC0+cHJpb3JpdHkgPSBzcC0+YXJnc1sxXTsNCi0JdGhyZWFkLT5hdG9taWNfZXhlYyA9IChz
cC0+YXJnc1syXSAhPSAwKTsNCiAJdGhyZWFkLT5jaGFuID0gJm1ib3gtPmNoYW5zW2luZF07DQog
DQogCXJldHVybiAmbWJveC0+Y2hhbnNbaW5kXTsNCi0tIA0KMi4xOC4wDQo=

