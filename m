Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE5FC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F29C20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="c1kp9RMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCWGYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:24:52 -0400
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:8694 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727142AbgCWGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1584944691; x=1616480691;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=79ymEayEp2gQQw0zEOKdH7KJ1bsGU0lvzPdso8hXutw=;
  b=c1kp9RMCyaBopTrXLj550MfvUi4P9ACwy+vPpbX3tE+hk+fouTCZzrwc
   gooBe/WzqlUawimXhFpNgCgdKguKR8s//FFbQSAUYaHYVDmTzEHYJQsjR
   Ek46AZGVJ6p3Tbz4d3z1rHik9oIYbhD1yU7rPkolaEy/KFcqY6zkYkoCO
   dAYPgGQo4V7fEnw65SDq7z+yRUbs/SmNFdZtSYABmwo+U6fGDqrHBFtYU
   38UoozK6w9Ges/M72hYSqstHQv8YLhXpOsHe19e4RwxwnPV9aS21rKoJh
   aNuJgkTiyY6pLeaj4anuYLT/fGVQbrfqrW+eViZ3QZALYDFOJw03DaVZA
   g==;
IronPort-SDR: nIiMowGo+x9RwXUW9MjD6Xj79nCED4MSq/4Mu51lmTdpVDzOj1z5Mx2AbofzT6NlwJxm//vosP
 iTyCmlg+YLUA==
From:   Denis Osterland-Heim <denis.osterland@diehl.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] leds: pwm: check result of led_pwm_set() in led_pwm_add()
Thread-Topic: [PATCH v4] leds: pwm: check result of led_pwm_set() in
 led_pwm_add()
Thread-Index: AQHWANvAJMLMvmSD7k6XGa70NKV6/Q==
Date:   Mon, 23 Mar 2020 06:24:47 +0000
Message-ID: <20200323062407.16617-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <4838A0E35562DC498631EB0CDEC1719D@diehl.internal>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: PkB65aL1SqtESF35r/jQn9knrvSb6ZZz9+PQqUlde7IWZUXeLjBmV2cmKgrOqBZw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bGVkX3B3bV9zZXQoKSBub3cgcmV0dXJucyBhbiBlcnJvciB3aGVuIHNldHRpbmcgdGhlIFBX
TSBmYWlscy4NCg0KQ2M6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5v
cmc+DQpTaWduZWQtb2ZmLWJ5OiBEZW5pcyBPc3RlcmxhbmQtSGVpbSA8RGVuaXMuT3N0ZXJs
YW5kQGRpZWhsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbGVkcy9sZWRzLXB3bS5jIHwgMTYgKysr
KysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9sZWRzL2xlZHMtcHdtLmMgYi9k
cml2ZXJzL2xlZHMvbGVkcy1wd20uYw0KaW5kZXggNmNhZjhiZWE4Y2Q1Li4wN2VhYjJkOGI3
YzcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2xlZHMvbGVkcy1wd20uYw0KKysrIGIvZHJpdmVy
cy9sZWRzL2xlZHMtcHdtLmMNCkBAIC05MSwxNSArOTEsMjEgQEAgc3RhdGljIGludCBsZWRf
cHdtX2FkZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsZWRfcHdtX3ByaXYgKnByaXYs
DQogCXB3bV9pbml0X3N0YXRlKGxlZF9kYXRhLT5wd20sICZsZWRfZGF0YS0+cHdtc3RhdGUp
Ow0KIA0KIAlyZXQgPSBkZXZtX2xlZF9jbGFzc2Rldl9yZWdpc3RlcihkZXYsICZsZWRfZGF0
YS0+Y2Rldik7DQotCWlmIChyZXQgPT0gMCkgew0KLQkJcHJpdi0+bnVtX2xlZHMrKzsNCi0J
CWxlZF9wd21fc2V0KCZsZWRfZGF0YS0+Y2RldiwgbGVkX2RhdGEtPmNkZXYuYnJpZ2h0bmVz
cyk7DQotCX0gZWxzZSB7DQorCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIHJlZ2lzdGVyIFBXTSBsZWQgZm9yICVzOiAlZFxuIiwNCiAJCQlsZWQtPm5hbWUsIHJl
dCk7DQorCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQotCXJldHVybiByZXQ7DQorCXJldCA9IGxl
ZF9wd21fc2V0KCZsZWRfZGF0YS0+Y2RldiwgbGVkX2RhdGEtPmNkZXYuYnJpZ2h0bmVzcyk7
DQorCWlmIChyZXQpIHsNCisJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHNldCBsZWQgUFdN
IHZhbHVlIGZvciAlczogJWQiLA0KKwkJCWxlZC0+bmFtZSwgcmV0KTsNCisJCXJldHVybiBy
ZXQ7DQorCX0NCisNCisJcHJpdi0+bnVtX2xlZHMrKzsNCisJcmV0dXJuIDA7DQogfQ0KIA0K
IHN0YXRpYyBpbnQgbGVkX3B3bV9jcmVhdGVfZndub2RlKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGxlZF9wd21fcHJpdiAqcHJpdikNCi0tIA0KMi4yNS4yDQoNCg0KDQpEaWVobCBD
b25uZWN0aXZpdHkgU29sdXRpb25zIEdtYkgNCkdlc2Now6RmdHNmw7xocnVuZzogSG9yc3Qg
TGVvbmJlcmdlcg0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBOw7xybmJlcmcgLSBSZWdpc3Rl
cmdlcmljaHQ6IEFtdHNnZXJpY2h0DQpOw7xybmJlcmc6IEhSQiAzMjMxNQ0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCkRlciBJbmhhbHQgZGVy
IHZvcnN0ZWhlbmRlbiBFLU1haWwgaXN0IG5pY2h0IHJlY2h0bGljaCBiaW5kZW5kLiBEaWVz
ZSBFLU1haWwgZW50aGFlbHQgdmVydHJhdWxpY2hlIHVuZC9vZGVyIHJlY2h0bGljaCBnZXNj
aHVldHp0ZSBJbmZvcm1hdGlvbmVuLg0KSW5mb3JtaWVyZW4gU2llIHVucyBiaXR0ZSwgd2Vu
biBTaWUgZGllc2UgRS1NYWlsIGZhZWxzY2hsaWNoZXJ3ZWlzZSBlcmhhbHRlbiBoYWJlbi4g
Qml0dGUgbG9lc2NoZW4gU2llIGluIGRpZXNlbSBGYWxsIGRpZSBOYWNocmljaHQuDQpKZWRl
IHVuZXJsYXVidGUgRm9ybSBkZXIgUmVwcm9kdWt0aW9uLCBCZWthbm50Z2FiZSwgQWVuZGVy
dW5nLCBWZXJ0ZWlsdW5nIHVuZC9vZGVyIFB1Ymxpa2F0aW9uIGRpZXNlciBFLU1haWwgaXN0
IHN0cmVuZ3N0ZW5zIHVudGVyc2FndC4NCi0gSW5mb3JtYXRpb25lbiB6dW0gRGF0ZW5zY2h1
dHosIGluc2Jlc29uZGVyZSB6dSBJaHJlbiBSZWNodGVuLCBlcmhhbHRlbiBTaWUgdW50ZXIg
aHR0cHM6Ly93d3cuZGllaGwuY29tL2dyb3VwL2RlL3RyYW5zcGFyZW56LXVuZC1pbmZvcm1h
dGlvbnNwZmxpY2h0ZW4vDQoNClRoZSBjb250ZW50cyBvZiB0aGUgYWJvdmUgbWVudGlvbmVk
IGUtbWFpbCBpcyBub3QgbGVnYWxseSBiaW5kaW5nLiBUaGlzIGUtbWFpbCBjb250YWlucyBj
b25maWRlbnRpYWwgYW5kL29yIGxlZ2FsbHkgcHJvdGVjdGVkIGluZm9ybWF0aW9uLiBQbGVh
c2UgaW5mb3JtIHVzIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGJ5DQptaXN0
YWtlIGFuZCBkZWxldGUgaXQgaW4gc3VjaCBhIGNhc2UuIEVhY2ggdW5hdXRob3JpemVkIHJl
cHJvZHVjdGlvbiwgZGlzY2xvc3VyZSwgYWx0ZXJhdGlvbiwgZGlzdHJpYnV0aW9uIGFuZC9v
ciBwdWJsaWNhdGlvbiBvZiB0aGlzIGUtbWFpbCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiAN
Ci0gRm9yIGdlbmVyYWwgaW5mb3JtYXRpb24gb24gZGF0YSBwcm90ZWN0aW9uIGFuZCB5b3Vy
IHJlc3BlY3RpdmUgcmlnaHRzIHBsZWFzZSB2aXNpdCBodHRwczovL3d3dy5kaWVobC5jb20v
Z3JvdXAvZW4vdHJhbnNwYXJlbmN5LWFuZC1pbmZvcm1hdGlvbi1vYmxpZ2F0aW9ucy8NCg==
