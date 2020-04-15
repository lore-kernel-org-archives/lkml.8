Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECD920737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895040AbgDOKuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:50:32 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:52276 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896654AbgDOKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:50:09 -0400
X-AuditID: c0a8fbf4-473ff70000004419-ea-5e96e6dd6fa1
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 91.20.17433.DD6E69E5; Wed, 15 Apr 2020 12:50:05 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Wed, 15 Apr 2020 12:49:59 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Thread-Topic: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Thread-Index: AQHWAzqhn2Sg7V5pBEqGkrHrcsfhsqh57rYAgAAQigA=
Date:   Wed, 15 Apr 2020 10:49:59 +0000
Message-ID: <a4b45b01e78c37e23cc4e464ec07d2364e02e379.camel@fi.rohmeurope.com>
References: <20200326064852.GA23265@localhost.localdomain>
         <20200415095052.GI2167633@dell>
In-Reply-To: <20200415095052.GI2167633@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <068E9DAB13930A43885DBCFC424D130E@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsVyYMXvjbp3n02LM/i4T8zi/tejjBaXd81h
        s5iz9ASLA7PHzll32T3uXNvD5vF5k1wAcxS3TVJiSVlwZnqevl0Cd0ZH4w22gj18FVf7VBoY
        e/i6GDk5JARMJHpnT2TuYuTiEBK4xijRceUHG0hCSOAEo8T9YxpdjBwcbAI2El032UHCIgKG
        EktOPGUBsZkFqiTunmoEs4UFnCS+te5mgqhxlrj9aS0zhG0l0dP3jA1kDIuAqsTNk7UgYV4B
        P4n2rvWMEJtiJU6f3gu2lVNAR+Lx2pVgIxkFZCU6G94xQawSl9j07DsrxMkCEkv2nGeGsEUl
        Xj7+BxVXlNj+fR0LyCpmAU2J9bv0IVodJCY8XgA1RlFiSvdDdogTBCVOznzCMoFRbBaSDbMQ
        umch6Z6FpHsWku4FjKyrGCVyEzNz0hNLUg31ilJL9YryM3KBVHJ+7iZGSJx92cH4/5DnIUYm
        DsZDjJIcTEqivK1Pp8UJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFdnzs1Tog3JbGyKrUoHyYl
        zcGiJM6r/nBirJAAyK7s1NSC1CKYrAwHh5IEr+kToKGCRanpqRVpmTklCGkmDk6Q4VxSIsWp
        eSmpRYmlJRnxoLQRXwxMHCApHqC9BiA38RYXJOYCRSFaTzFqc0x4OXcRM8eRuUsXMQux5OXn
        pUqJ81oC06CQAEhpRmke3KJXjOIcjErCvCtA7uABJly4Oa+AVjABrSjwmQyyoiQRISXVwKgv
        1aOx6HBpeeN9W+5zK7nV8/a2t81UX/54l/FTiVrvhEnhXaxBblwKM1+d+KbI+fVt4Z8c/eMX
        djXsYxG7nDDvkuyBb+u9fr/NTC4r8/q5Lv/4IWaPUk9Juzd97D93X6lXvWz60mHW6YJPfPWh
        PhUzYhIfrOVKev/00r+nng8enZyp8K1KY7YSS3FGoqEWc1FxIgA1Alp3dQMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGVlLA0KDQpPbiBXZWQsIDIwMjAtMDQtMTUgYXQgMTA6NTAgKzAxMDAsIExlZSBKb25l
cyB3cm90ZToNCj4gT24gVGh1LCAyNiBNYXIgMjAyMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0K
PiANCj4gPiBST0hNIEJENzA1MjggYW5kIEJENzE4eDcgZHJpdmVycyBkbyBub3QgdXRpbGl6ZSB0
aGUgSTJDIGlkLg0KPiA+IERvIHRoZSB0cml2aWFsIGNvbnZlcnNpb24gYW5kIG1ha2UgdGhlbSB0
byB1c2UgcHJvYmVfbmV3DQo+ID4gaW5zdGVhZCBvZiBwcm9iZS4NCj4gDQo+IE5vdCBzdXJlIEkg
dW5kZXJzdGFuZCB0aGUgcHVycG9zZSBvZiB0aGUgcGF0Y2guDQo+IA0KPiBUaGUgb25seSByZWFz
b24gdG8gc3dpdGNoIHRvIHByb2JlX25ldyBpcyB0byBhaWQgdGhlIHJlbW92YWwgb2YgdGhlDQo+
IGNvbXB1bHNvcnkgSTJDIHRhYmxlcy4gIEhvd2V2ZXIsIG5laXRoZXIgb2YgdGhlc2UgZHJpdmVy
cyBoYXZlIHRoZW0uDQoNCk1heWJlIEkgaGF2ZSBtaXN1bmRlcnN0b29kIHRoZSBwcm9iZV9uZXcu
IE15IHVuZGVyc3RhbmRpbmcgd2FzIHRoYXQgdGhlDQpwcm9iZV9uZXcgaXMgd2hhdCBzaG91bGQg
YmVjb21lIHRoZSBzdGFuZGFyZCAtIEVnLiBldmVudHVhbGx5IGFsbCBJMkMNCmRyaXZlcnMgd291
bGQgdXNlIHByb2JlIHdoaWNoIGlzIG5vdCBnZXR0aW5nIHRoZSBJRCB0YWJsZXMgYXMgYXJndW1l
bnQNCi0gYW5kIHRoZSBvbGQgcHJvYmUgY291bGQgYmUgcmVtb3ZlZC4gVGh1cyBJIHRob3VnaHQg
Y29udmVyc2lvbiBvZg0KcHJvYmUgdG8gcHJvYmVfbmV3IHdvdWxkIGJlIHJlcXVpcmVkIGluIG9y
ZGVyIHRvIGdldCByaWQgb2YgdGhlIG9sZA0KcHJvYmUuIEkgdGhpbmsgSSBnb3QgdGhpcyB1bmRl
cnN0YW5kaW5nIHdoZW4gSSBzdWJtaXR0ZWQgZHJpdmVyIGZvcg0KQkQ3MTgyOCAtIGFuZCBJIHRo
aW5rIGl0IHdhcyB5b3Ugd2hvIHN1Z2dlc3RlZCBtZSB0byBzd2l0Y2ggdG8NCnByb2JlX25ldyBh
cyAnaWQnIHdhcyB1bnVzZWQuIEJ1dCBpZiBwbGVhc2UganVzdCBkcm9wIHRoaXMgcGF0Y2ggaWYN
CnRoaXMgY2hhbmdlIGlzIG5vdCBuZWVkZWQhDQoNClRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBh
dCB0aGlzIDopDQoNCkJlc3QgUmVnYXJkcw0KICAgIC0tTWF0dGkNCg0KPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZmQvcm9obS1iZDcwNTI4LmMgfCA1ICsrLS0tDQo+
ID4gIGRyaXZlcnMvbWZkL3JvaG0tYmQ3MTh4Ny5jIHwgNSArKy0tLQ0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0K
