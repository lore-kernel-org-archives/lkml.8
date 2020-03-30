Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF944C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A2620771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Y88gBSDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgC3Nkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:40:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36176 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727437AbgC3Nkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:40:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UDSjd2004381;
        Mon, 30 Mar 2020 15:40:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=05Cp8FHkCUAY1uBXkh3rN+fUJ2vNWzHm6qdMX+Azm+8=;
 b=Y88gBSDr5K8hhZANqaYvDTtojUfVlgBBXc5IyuwCP4B4YeCVaOERix6AX09FKDLfYmGf
 +7cbnbh+dbZxc8q9q6IfHqBEx3pjS0BstS0EQUsfOpoPG2gwQydfAKWZMCvK8aF+Nse7
 kdF7VFtvSfZ9FcXzJMYSMCdLV7hzDD17L7WBRFhKVAenBNq1p6PWVvT2K52XpcAQYafC
 a/hE2nKc9BgVs/uW7soyEtGl71/H6A6GkTud8EysfPJsGCpIA47pgGx7wfX2y6t1eQj8
 eT4hBW2WTjWC553Qg48Xj7PmhxigaAuobJ2cuVedWdzmxXv9FkD39zwnjrLUTCV6ow/f 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbm9p1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 15:40:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 35F8D10002A;
        Mon, 30 Mar 2020 15:40:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 053992BC7AC;
        Mon, 30 Mar 2020 15:40:13 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 30 Mar
 2020 15:40:12 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Mon, 30 Mar 2020 15:40:12 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/stm: ltdc: check number of endpoints
Thread-Topic: [PATCH] drm/stm: ltdc: check number of endpoints
Thread-Index: AQHV7g4ofITfVj+w50Wq5yte7qHdC6hhVL8Q
Date:   Mon, 30 Mar 2020 13:40:12 +0000
Message-ID: <6a14216d33374f6d8d8a5653cad683e9@SFHDAG6NODE3.st.com>
References: <1582877258-1112-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1582877258-1112-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-30_01:2020-03-27,2020-03-30 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLA0KQWNrZWQtYnk6IFBoaWxp
cHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQooc29ycnkgZm9yIHRoZSBlbWFpbCBm
b3JtYXQpDQpQaGlsaXBwZSA6LSkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFlhbm5pY2sgRkVSVFJFIDx5YW5uaWNrLmZlcnRyZUBzdC5jb20+IA0KU2VudDogRnJpZGF5LCBG
ZWJydWFyeSAyOCwgMjAyMCAwOTowOA0KVG86IFlhbm5pY2sgRkVSVFJFIDx5YW5uaWNrLmZlcnRy
ZUBzdC5jb20+OyBQaGlsaXBwZSBDT1JOVSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPjsgQmVuamFt
aW4gR0FJR05BUkQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT47IERhdmlkIEFpcmxpZSA8YWly
bGllZEBsaW51eC5pZT47IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD47IE1heGltZSBD
b3F1ZWxpbiA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IEFsZXhhbmRyZSBUT1JHVUUgPGFs
ZXhhbmRyZS50b3JndWVAc3QuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
bGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9zdG06IGx0ZGM6IGNoZWNrIG51bWJlciBvZiBlbmRwb2ludHMNCg0K
TnVtYmVyIG9mIGVuZHBvaW50cyBjb3VsZCBleGNlZWQgdGhlIGZpeCB2YWx1ZSBNQVhfRU5EUE9J
TlRTKDIpLg0KSW5zdGVhZCBvZiBpbmNyZWFzZSBzaW1wbHkgdGhpcyB2YWx1ZSwgdGhlIG51bWJl
ciBvZiBlbmRwb2ludCBjb3VsZCBiZSByZWFkIGZyb20gZGV2aWNlIHRyZWUuIExvYWQgc2VxdWVu
Y2UgaGFzIGJlZW4gYSBsaXR0bGUgcmV3b3JrIHRvIHRha2UgY2FyZSBvZiBzZXZlcmFsIHBhbmVs
IG9yIGJyaWRnZSB3aGljaCBjYW4gYmUgY29ubmVjdGVkL2Rpc2Nvbm5lY3RlZCBvciBlbmFibGUv
ZGlzYWJsZS4NCg0KU2lnbmVkLW9mZi1ieTogWWFubmljayBGZXJ0cmUgPHlhbm5pY2suZmVydHJl
QHN0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIHwgMTAyICsrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1
MiBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9zdG0vbHRkYy5jIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgaW5kZXggZGY1
ODVmZS4uZjg5NDk2OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KQEAgLTQyLDggKzQyLDYgQEANCg0KICNk
ZWZpbmUgTUFYX0lSUSA0DQoNCi0jZGVmaW5lIE1BWF9FTkRQT0lOVFMgMg0KLQ0KICNkZWZpbmUg
SFdWRVJfMTAyMDAgMHgwMTAyMDANCiAjZGVmaW5lIEhXVkVSXzEwMzAwIDB4MDEwMzAwDQogI2Rl
ZmluZSBIV1ZFUl8yMDEwMSAweDAyMDEwMQ0KQEAgLTEyMDEsMzYgKzExOTksMjAgQEAgaW50IGx0
ZGNfbG9hZChzdHJ1Y3QgZHJtX2RldmljZSAqZGRldikNCiAJc3RydWN0IGx0ZGNfZGV2aWNlICps
ZGV2ID0gZGRldi0+ZGV2X3ByaXZhdGU7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9IGRkZXYtPmRl
djsNCiAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsNCi0Jc3RydWN0IGRy
bV9icmlkZ2UgKmJyaWRnZVtNQVhfRU5EUE9JTlRTXSA9IHtOVUxMfTsNCi0Jc3RydWN0IGRybV9w
YW5lbCAqcGFuZWxbTUFYX0VORFBPSU5UU10gPSB7TlVMTH07DQorCXN0cnVjdCBkcm1fYnJpZGdl
ICpicmlkZ2U7DQorCXN0cnVjdCBkcm1fcGFuZWwgKnBhbmVsOw0KIAlzdHJ1Y3QgZHJtX2NydGMg
KmNydGM7DQogCXN0cnVjdCByZXNldF9jb250cm9sICpyc3RjOw0KIAlzdHJ1Y3QgcmVzb3VyY2Ug
KnJlczsNCi0JaW50IGlycSwgcmV0LCBpLCBlbmRwb2ludF9ub3RfcmVhZHkgPSAtRU5PREVWOw0K
KwlpbnQgaXJxLCBpLCBuYl9lbmRwb2ludHM7DQorCWludCByZXQgPSAtRU5PREVWOw0KDQogCURS
TV9ERUJVR19EUklWRVIoIlxuIik7DQoNCi0JLyogR2V0IGVuZHBvaW50cyBpZiBhbnkgKi8NCi0J
Zm9yIChpID0gMDsgaSA8IE1BWF9FTkRQT0lOVFM7IGkrKykgew0KLQkJcmV0ID0gZHJtX29mX2Zp
bmRfcGFuZWxfb3JfYnJpZGdlKG5wLCAwLCBpLCAmcGFuZWxbaV0sDQotCQkJCQkJICAmYnJpZGdl
W2ldKTsNCi0NCi0JCS8qDQotCQkgKiBJZiBhdCBsZWFzdCBvbmUgZW5kcG9pbnQgaXMgLUVQUk9C
RV9ERUZFUiwgZGVmZXIgcHJvYmluZywNCi0JCSAqIGVsc2UgaWYgYXQgbGVhc3Qgb25lIGVuZHBv
aW50IGlzIHJlYWR5LCBjb250aW51ZSBwcm9iaW5nLg0KLQkJICovDQotCQlpZiAocmV0ID09IC1F
UFJPQkVfREVGRVIpDQotCQkJcmV0dXJuIHJldDsNCi0JCWVsc2UgaWYgKCFyZXQpDQotCQkJZW5k
cG9pbnRfbm90X3JlYWR5ID0gMDsNCi0JfQ0KLQ0KLQlpZiAoZW5kcG9pbnRfbm90X3JlYWR5KQ0K
LQkJcmV0dXJuIGVuZHBvaW50X25vdF9yZWFkeTsNCi0NCi0JcnN0YyA9IGRldm1fcmVzZXRfY29u
dHJvbF9nZXRfZXhjbHVzaXZlKGRldiwgTlVMTCk7DQotDQotCW11dGV4X2luaXQoJmxkZXYtPmVy
cl9sb2NrKTsNCisJLyogR2V0IG51bWJlciBvZiBlbmRwb2ludHMgKi8NCisJbmJfZW5kcG9pbnRz
ID0gb2ZfZ3JhcGhfZ2V0X2VuZHBvaW50X2NvdW50KG5wKTsNCisJaWYgKCFuYl9lbmRwb2ludHMp
DQorCQlyZXR1cm4gLUVOT0RFVjsNCg0KIAlsZGV2LT5waXhlbF9jbGsgPSBkZXZtX2Nsa19nZXQo
ZGV2LCAibGNkIik7DQogCWlmIChJU19FUlIobGRldi0+cGl4ZWxfY2xrKSkgew0KQEAgLTEyNDQs
NiArMTIyNiw0MyBAQCBpbnQgbHRkY19sb2FkKHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KIAkJ
cmV0dXJuIC1FTk9ERVY7DQogCX0NCg0KKwkvKiBHZXQgZW5kcG9pbnRzIGlmIGFueSAqLw0KKwlm
b3IgKGkgPSAwOyBpIDwgbmJfZW5kcG9pbnRzOyBpKyspIHsNCisJCXJldCA9IGRybV9vZl9maW5k
X3BhbmVsX29yX2JyaWRnZShucCwgMCwgaSwgJnBhbmVsLCAmYnJpZGdlKTsNCisNCisJCS8qDQor
CQkgKiBJZiBhdCBsZWFzdCBvbmUgZW5kcG9pbnQgaXMgLUVOT0RFViwgY29udGludWUgcHJvYmlu
ZywNCisJCSAqIGVsc2UgaWYgYXQgbGVhc3Qgb25lIGVuZHBvaW50IHJldHVybmVkIGFuIGVycm9y
DQorCQkgKiAoaWUgLUVQUk9CRV9ERUZFUikgdGhlbiBzdG9wIHByb2JpbmcuDQorCQkgKi8NCisJ
CWlmIChyZXQgPT0gLUVOT0RFVikNCisJCQljb250aW51ZTsNCisJCWVsc2UgaWYgKHJldCkNCisJ
CQlnb3RvIGVycjsNCisNCisJCWlmIChwYW5lbCkgew0KKwkJCWJyaWRnZSA9IGRybV9wYW5lbF9i
cmlkZ2VfYWRkX3R5cGVkKHBhbmVsLA0KKwkJCQkJCQkgICAgRFJNX01PREVfQ09OTkVDVE9SX0RQ
SSk7DQorCQkJaWYgKElTX0VSUihicmlkZ2UpKSB7DQorCQkJCURSTV9FUlJPUigicGFuZWwtYnJp
ZGdlIGVuZHBvaW50ICVkXG4iLCBpKTsNCisJCQkJcmV0ID0gUFRSX0VSUihicmlkZ2UpOw0KKwkJ
CQlnb3RvIGVycjsNCisJCQl9DQorCQl9DQorDQorCQlpZiAoYnJpZGdlKSB7DQorCQkJcmV0ID0g
bHRkY19lbmNvZGVyX2luaXQoZGRldiwgYnJpZGdlKTsNCisJCQlpZiAocmV0KSB7DQorCQkJCURS
TV9FUlJPUigiaW5pdCBlbmNvZGVyIGVuZHBvaW50ICVkXG4iLCBpKTsNCisJCQkJZ290byBlcnI7
DQorCQkJfQ0KKwkJfQ0KKwl9DQorDQorCXJzdGMgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X2V4
Y2x1c2l2ZShkZXYsIE5VTEwpOw0KKw0KKwltdXRleF9pbml0KCZsZGV2LT5lcnJfbG9jayk7DQor
DQogCWlmICghSVNfRVJSKHJzdGMpKSB7DQogCQlyZXNldF9jb250cm9sX2Fzc2VydChyc3RjKTsN
CiAJCXVzbGVlcF9yYW5nZSgxMCwgMjApOw0KQEAgLTEyODUsMjcgKzEzMDQsNyBAQCBpbnQgbHRk
Y19sb2FkKHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KIAkJCURSTV9FUlJPUigiRmFpbGVkIHRv
IHJlZ2lzdGVyIExUREMgaW50ZXJydXB0XG4iKTsNCiAJCQlnb3RvIGVycjsNCiAJCX0NCi0JfQ0K
DQotCS8qIEFkZCBlbmRwb2ludHMgcGFuZWxzIG9yIGJyaWRnZXMgaWYgYW55ICovDQotCWZvciAo
aSA9IDA7IGkgPCBNQVhfRU5EUE9JTlRTOyBpKyspIHsNCi0JCWlmIChwYW5lbFtpXSkgew0KLQkJ
CWJyaWRnZVtpXSA9IGRybV9wYW5lbF9icmlkZ2VfYWRkX3R5cGVkKHBhbmVsW2ldLA0KLQkJCQkJ
CQkgICAgICAgRFJNX01PREVfQ09OTkVDVE9SX0RQSSk7DQotCQkJaWYgKElTX0VSUihicmlkZ2Vb
aV0pKSB7DQotCQkJCURSTV9FUlJPUigicGFuZWwtYnJpZGdlIGVuZHBvaW50ICVkXG4iLCBpKTsN
Ci0JCQkJcmV0ID0gUFRSX0VSUihicmlkZ2VbaV0pOw0KLQkJCQlnb3RvIGVycjsNCi0JCQl9DQot
CQl9DQotDQotCQlpZiAoYnJpZGdlW2ldKSB7DQotCQkJcmV0ID0gbHRkY19lbmNvZGVyX2luaXQo
ZGRldiwgYnJpZGdlW2ldKTsNCi0JCQlpZiAocmV0KSB7DQotCQkJCURSTV9FUlJPUigiaW5pdCBl
bmNvZGVyIGVuZHBvaW50ICVkXG4iLCBpKTsNCi0JCQkJZ290byBlcnI7DQotCQkJfQ0KLQkJfQ0K
IAl9DQoNCiAJY3J0YyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqY3J0YyksIEdGUF9LRVJO
RUwpOyBAQCAtMTM0MCw4ICsxMzM5LDggQEAgaW50IGx0ZGNfbG9hZChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGRldikNCg0KIAlyZXR1cm4gMDsNCiBlcnI6DQotCWZvciAoaSA9IDA7IGkgPCBNQVhfRU5E
UE9JTlRTOyBpKyspDQotCQlkcm1fcGFuZWxfYnJpZGdlX3JlbW92ZShicmlkZ2VbaV0pOw0KKwlm
b3IgKGkgPSAwOyBpIDwgbmJfZW5kcG9pbnRzOyBpKyspDQorCQlkcm1fb2ZfcGFuZWxfYnJpZGdl
X3JlbW92ZShkZGV2LT5kZXYtPm9mX25vZGUsIDAsIGkpOw0KDQogCWNsa19kaXNhYmxlX3VucHJl
cGFyZShsZGV2LT5waXhlbF9jbGspOw0KDQpAQCAtMTM1MCwxMSArMTM0OSwxNCBAQCBpbnQgbHRk
Y19sb2FkKHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KDQogdm9pZCBsdGRjX3VubG9hZChzdHJ1
Y3QgZHJtX2RldmljZSAqZGRldikgIHsNCi0JaW50IGk7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9
IGRkZXYtPmRldjsNCisJaW50IG5iX2VuZHBvaW50cywgaTsNCg0KIAlEUk1fREVCVUdfRFJJVkVS
KCJcbiIpOw0KDQotCWZvciAoaSA9IDA7IGkgPCBNQVhfRU5EUE9JTlRTOyBpKyspDQorCW5iX2Vu
ZHBvaW50cyA9IG9mX2dyYXBoX2dldF9lbmRwb2ludF9jb3VudChkZXYtPm9mX25vZGUpOw0KKw0K
Kwlmb3IgKGkgPSAwOyBpIDwgbmJfZW5kcG9pbnRzOyBpKyspDQogCQlkcm1fb2ZfcGFuZWxfYnJp
ZGdlX3JlbW92ZShkZGV2LT5kZXYtPm9mX25vZGUsIDAsIGkpOw0KDQogCXBtX3J1bnRpbWVfZGlz
YWJsZShkZGV2LT5kZXYpOw0KLS0NCjIuNy40DQoNCg==
