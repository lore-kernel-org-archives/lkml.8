Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D276C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EDD206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IEqe1JAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCYHPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:15:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:16976 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCYHPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585120507; x=1616656507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=/uvEuu5157i1qwfOiIOBUtxGUiAPahfuD8HQNkA0ynM=;
  b=IEqe1JAkJAGygYdK0w70bWA2c33rMoMTTQmYAWmM0AzSNkhN69nRfpfI
   rPCwLgg46EMwmuHna4Bsn/csbWUvCdn9Y6aC/9EPaEsIpcx0JcB2yoDRQ
   Jmb55ScJ0jHN5V2VCcMIP9dZkjQ+fFpnKZ3ntv8yCHggI1JDFYkzRqpmu
   M=;
IronPort-SDR: /TJH2FelNaaDGAuuSgwJSdoi3uIZD+qVvLUZl3cF4Xs5DfBaqgmUFcNx3w8NXENwCoRztiHlGn
 z/prLf8IT16Q==
X-Amazon-filename: v2-0004-arch-x86-L1D-flush-optimize-the-context-switch.patch
X-IronPort-AV: E=Sophos;i="5.72,303,1580774400"; 
   d="scan'208,223";a="34698652"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 25 Mar 2020 07:15:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 8F00FA26D7;
        Wed, 25 Mar 2020 07:15:02 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 07:15:01 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 07:15:01 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Wed, 25 Mar 2020 07:15:01 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v2 4/4] arch/x86: L1D flush, optimize the context
 switch
Thread-Topic: [RFC PATCH v2 4/4] arch/x86: L1D flush, optimize the context
 switch
Thread-Index: AQHWAnSYFSI4KfGBZEuiUZixsPHjuqhY5UcA
Date:   Wed, 25 Mar 2020 07:15:01 +0000
Message-ID: <a0926f775b8cba31218602c3a8ba932ca5017334.camel@amazon.com>
References: <20200325071101.29556-1-sblbir@amazon.com>
         <20200325071101.29556-5-sblbir@amazon.com>
In-Reply-To: <20200325071101.29556-5-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.164]
Content-Type: multipart/mixed;
        boundary="_002_a0926f775b8cba31218602c3a8ba932ca5017334camelamazoncom_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_a0926f775b8cba31218602c3a8ba932ca5017334camelamazoncom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5A2E180061CCB4B9C82A5556A50FA59@amazon.com>
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDE4OjExICsxMTAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
IFVzZSBhIHN0YXRpYyBicmFuY2gvanVtcCBsYWJlbCB0byBvcHRpbWl6ZSB0aGUgY29kZS4gUmln
aHQgbm93DQo+IHdlIGRvbid0IHJlZiBjb3VudCB0aGUgdXNlcnMsIGJ1dCB0aGF0IGNvdWxkIGJl
IGRvbmUgaWYgbmVlZGVkDQo+IGluIHRoZSBmdXR1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
YWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPg0KPiANCg0KSSBzZW50IGFuIG9sZGVyIHZl
cnNpb24gb2YgdGhlIHBhdGNoLCBoZXJlIGlzIHRoZSB1cGRhdGVkIHZlcnNpb24NCg0KQmFsYmly
IFNpbmdoDQoNCg0K

--_002_a0926f775b8cba31218602c3a8ba932ca5017334camelamazoncom_
Content-Type: text/x-patch;
	name="v2-0004-arch-x86-L1D-flush-optimize-the-context-switch.patch"
Content-Description: v2-0004-arch-x86-L1D-flush-optimize-the-context-switch.patch
Content-Disposition: attachment;
	filename="v2-0004-arch-x86-L1D-flush-optimize-the-context-switch.patch";
	size=3493; creation-date="Wed, 25 Mar 2020 07:15:01 GMT";
	modification-date="Wed, 25 Mar 2020 07:15:01 GMT"
Content-ID: <CD03083E42E0A346B085B4C187897A3C@amazon.com>
Content-Transfer-Encoding: base64

RnJvbSBmYTgwZTk2OTEyMDIxODNhMjg3OWEwMTNlNDk3ZjIyMWIyMjMwNWE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPgpEYXRl
OiBXZWQsIDI1IE1hciAyMDIwIDE2OjQxOjE4ICsxMTAwClN1YmplY3Q6IFtSRkMgUEFUQ0ggdjIg
NC80XSBhcmNoL3g4NjogTDFEIGZsdXNoLCBvcHRpbWl6ZSB0aGUgY29udGV4dCBzd2l0Y2gKClVz
ZSBhIHN0YXRpYyBicmFuY2gvanVtcCBsYWJlbCB0byBvcHRpbWl6ZSB0aGUgY29kZS4gUmlnaHQg
bm93CndlIGRvbid0IHJlZiBjb3VudCB0aGUgdXNlcnMsIGJ1dCB0aGF0IGNvdWxkIGJlIGRvbmUg
aWYgbmVlZGVkCmluIHRoZSBmdXR1cmUuCgpTaWduZWQtb2ZmLWJ5OiBCYWxiaXIgU2luZ2ggPHNi
bGJpckBhbWF6b24uY29tPgotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL25vc3BlYy1icmFuY2gu
aCB8ICAyICsrCiBhcmNoL3g4Ni9tbS90bGIuYyAgICAgICAgICAgICAgICAgICAgfCA1MiArKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMo
KyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL25v
c3BlYy1icmFuY2guaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL25vc3BlYy1icmFuY2guaAppbmRl
eCAwN2U5NWRjYjQwYWQuLjM3MWUyOGNlYTFmNCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbm9zcGVjLWJyYW5jaC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL25vc3BlYy1i
cmFuY2guaApAQCAtMzEwLDYgKzMxMCw4IEBAIERFQ0xBUkVfU1RBVElDX0tFWV9GQUxTRShzd2l0
Y2hfbW1fYWx3YXlzX2licGIpOwogREVDTEFSRV9TVEFUSUNfS0VZX0ZBTFNFKG1kc191c2VyX2Ns
ZWFyKTsKIERFQ0xBUkVfU1RBVElDX0tFWV9GQUxTRShtZHNfaWRsZV9jbGVhcik7CiAKK0RFQ0xB
UkVfU1RBVElDX0tFWV9GQUxTRShzd2l0Y2hfbW1fbDFkX2ZsdXNoKTsKKwogI2luY2x1ZGUgPGFz
bS9zZWdtZW50Lmg+CiAKIC8qKgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vdGxiLmMgYi9hcmNo
L3g4Ni9tbS90bGIuYwppbmRleCAyMmY5NmM1Zjc0ZjAuLjhmMjcyZTU5MjFjZSAxMDA2NDQKLS0t
IGEvYXJjaC94ODYvbW0vdGxiLmMKKysrIGIvYXJjaC94ODYvbW0vdGxiLmMKQEAgLTE1NSw2ICsx
NTUsMTEgQEAgRVhQT1JUX1NZTUJPTF9HUEwobGVhdmVfbW0pOwogc3RhdGljIHZvaWQgKmwxZF9m
bHVzaF9wYWdlczsKIHN0YXRpYyBERUZJTkVfTVVURVgobDFkX2ZsdXNoX211dGV4KTsKIAorLyog
Rmx1c2ggTDFEIG9uIHN3aXRjaF9tbSgpICovCitERUZJTkVfU1RBVElDX0tFWV9GQUxTRShzd2l0
Y2hfbW1fbDFkX2ZsdXNoKTsKK0VYUE9SVF9TWU1CT0xfR1BMKHN3aXRjaF9tbV9sMWRfZmx1c2gp
OworCisKIGludCBlbmFibGVfbDFkX2ZsdXNoX2Zvcl90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAq
dHNrKQogewogCXN0cnVjdCBwYWdlICpwYWdlOwpAQCAtMTcwLDYgKzE3NSwxMSBAQCBpbnQgZW5h
YmxlX2wxZF9mbHVzaF9mb3JfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaykKIAkJCWwxZF9m
bHVzaF9wYWdlcyA9IGFsbG9jX2wxZF9mbHVzaF9wYWdlcygpOwogCQkJaWYgKCFsMWRfZmx1c2hf
cGFnZXMpCiAJCQkJcmV0dXJuIC1FTk9NRU07CisJCQkvKgorCQkJICogV2UgY291bGQgZG8gbW9y
ZSBhY2N1cmF0ZSByZWYgY291bnRpbmcKKwkJCSAqIGlmIG5lZWRlZAorCQkJICovCisJCQlzdGF0
aWNfYnJhbmNoX2VuYWJsZSgmc3dpdGNoX21tX2wxZF9mbHVzaCk7CiAJCX0KIAkJbXV0ZXhfdW5s
b2NrKCZsMWRfZmx1c2hfbXV0ZXgpOwogCX0KQEAgLTE5NSwyOSArMjA1LDMxIEBAIHN0YXRpYyB2
b2lkIGwxZF9mbHVzaChzdHJ1Y3QgbW1fc3RydWN0ICpuZXh0LCBzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRzaykKIHsKIAlzdHJ1Y3QgbW1fc3RydWN0ICpyZWFsX3ByZXYgPSB0aGlzX2NwdV9yZWFkKGNw
dV90bGJzdGF0ZS5sb2FkZWRfbW0pOwogCi0JLyoKLQkgKiBJZiB3ZSBhcmUgbm90IHJlYWxseSBz
d2l0Y2hpbmcgbW0ncywgd2UgY2FuIGp1c3QgcmV0dXJuCi0JICovCi0JaWYgKHJlYWxfcHJldiA9
PSBuZXh0KQotCQlyZXR1cm47CisJaWYgKHN0YXRpY19icmFuY2hfdW5saWtlbHkoJnN3aXRjaF9t
bV9sMWRfZmx1c2gpKSB7CisJCS8qCisJCSAqIElmIHdlIGFyZSBub3QgcmVhbGx5IHN3aXRjaGlu
ZyBtbSdzLCB3ZSBjYW4ganVzdCByZXR1cm4KKwkJICovCisJCWlmIChyZWFsX3ByZXYgPT0gbmV4
dCkKKwkJCXJldHVybjsKIAotCS8qCi0JICogRG8gd2UgbmVlZCBmbHVzaGluZyBmb3IgYnkgdGhl
IHByZXZpb3VzIHRhc2sKLQkgKi8KLQlpZiAodGhpc19jcHVfcmVhZChjcHVfdGxic3RhdGUubGFz
dF91c2VyX21tX2wxZF9mbHVzaCkgIT0gMCkgewotCQlpZiAoIWZsdXNoX2wxZF9jYWNoZV9odygp
KQotCQkJZmx1c2hfbDFkX2NhY2hlX3N3KGwxZF9mbHVzaF9wYWdlcyk7Ci0JCXRoaXNfY3B1X3dy
aXRlKGNwdV90bGJzdGF0ZS5sYXN0X3VzZXJfbW1fbDFkX2ZsdXNoLCAwKTsKLQkJLyogTWFrZSBz
dXJlIHdlIGNsZWFyIHRoZSB2YWx1ZXMgYmVmb3JlIHdlIHNldCBpdCBhZ2FpbiAqLwotCQliYXJy
aWVyKCk7Ci0JfQorCQkvKgorCQkgKiBEbyB3ZSBuZWVkIGZsdXNoaW5nIGZvciBieSB0aGUgcHJl
dmlvdXMgdGFzaworCQkgKi8KKwkJaWYgKHRoaXNfY3B1X3JlYWQoY3B1X3RsYnN0YXRlLmxhc3Rf
dXNlcl9tbV9sMWRfZmx1c2gpICE9IDApIHsKKwkJCWlmICghZmx1c2hfbDFkX2NhY2hlX2h3KCkp
CisJCQkJZmx1c2hfbDFkX2NhY2hlX3N3KGwxZF9mbHVzaF9wYWdlcyk7CisJCQl0aGlzX2NwdV93
cml0ZShjcHVfdGxic3RhdGUubGFzdF91c2VyX21tX2wxZF9mbHVzaCwgMCk7CisJCQkvKiBNYWtl
IHN1cmUgd2UgY2xlYXIgdGhlIHZhbHVlcyBiZWZvcmUgd2Ugc2V0IGl0IGFnYWluICovCisJCQli
YXJyaWVyKCk7CisJCX0KIAotCWlmICh0c2sgPT0gTlVMTCkKLQkJcmV0dXJuOworCQlpZiAodHNr
ID09IE5VTEwpCisJCQlyZXR1cm47CiAKLQkvKiBXZSBkb24ndCBuZWVkIHN0cmluZ2VudCBjaGVj
a3MgYXMgd2Ugb3B0LWluL29wdC1vdXQgKi8KLQlpZiAodGVzdF90aV90aHJlYWRfZmxhZygmdHNr
LT50aHJlYWRfaW5mbywgVElGX0wxRF9GTFVTSCkpCi0JCXRoaXNfY3B1X3dyaXRlKGNwdV90bGJz
dGF0ZS5sYXN0X3VzZXJfbW1fbDFkX2ZsdXNoLCAxKTsKKwkJLyogV2UgZG9uJ3QgbmVlZCBzdHJp
bmdlbnQgY2hlY2tzIGFzIHdlIG9wdC1pbi9vcHQtb3V0ICovCisJCWlmICh0ZXN0X3RpX3RocmVh
ZF9mbGFnKCZ0c2stPnRocmVhZF9pbmZvLCBUSUZfTDFEX0ZMVVNIKSkKKwkJCXRoaXNfY3B1X3dy
aXRlKGNwdV90bGJzdGF0ZS5sYXN0X3VzZXJfbW1fbDFkX2ZsdXNoLCAxKTsKKwl9CiB9CiAKIHZv
aWQgc3dpdGNoX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKnByZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm5l
eHQsCi0tIAoyLjE3LjEKCg==

--_002_a0926f775b8cba31218602c3a8ba932ca5017334camelamazoncom_--
