Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD0C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232D820728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgAQHoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:44:15 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:59754 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbgAQHoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:44:14 -0500
X-AuditID: c0a8fbf4-199ff70000001fa6-6c-5e2165cdaac1
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 84.C9.08102.DC5612E5; Fri, 17 Jan 2020 08:44:13 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Fri, 17 Jan 2020 08:44:08 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] mfd: bd70528: Fix hour register mask
Thread-Topic: [PATCH] mfd: bd70528: Fix hour register mask
Thread-Index: AQHVy33u6ExLp0ReyUCqWPc5BSkWM6fubBCA
Date:   Fri, 17 Jan 2020 07:44:07 +0000
Message-ID: <83e8e1ecc40a58e2e6d1960bbb41c8dcfe730ce1.camel@fi.rohmeurope.com>
References: <20200115082933.GA29117@localhost.localdomain>
In-Reply-To: <20200115082933.GA29117@localhost.localdomain>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <28783269C4A7F84E9972F95229914477@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRzn2d1uj86Tc073tFT0IMIi34haZWEUNAkk6FuRdrrLmXuR2yzN
        Dy38UFqalVQurSwNlYG4gaj5ElKmkr2gLuxtiVlpZqQtqUy72+XLp/vd//f2h+cPMYWNUMMs
        k5XlTIyBJvzxB3V/mjYNsFGpcV3lhObs9D2ZpvBuI6HxeB8BzWBbJaGprO3FNU6Hm0gitDcd
        BdpW+1uZ1tlQRGjfuNsJbVeVQ6addUYcIA7JE9MZ64mDWZmm2F1H5fpPTyZlOTUor3C0XGoD
        Q6pi4AcRtRm5+mdAMfCHCmoYoM/jLwnxpxegidJOrBhASFCJqHhEJkAltQ01vQgSJBhVJUHz
        pRUSISiYn7sWOnxYSW1Hr6bf4yJOQLd+t0gFjFPr0LWOOSBgkkpBlZ5an0bB613VLt/cj9qB
        vs9O+fSACkdFtmlfJkapkPPjnFRcmkI17c8wEYegibGF/3MadfwaxYU9MSoaNbbFijAJ/W3m
        xJQoVH5+VCZuEIT6Kj7gZSDUvqrAvmK2r5jtq8z2VebbQNoAkJHJMmQyVjY+hmNzYziz3sh/
        MsxGJxBf9EcLWOxO7gYSCLrBGiihQ0hle3iqIjDdrMvXMxZ9GpdrYC3dAEGMVpJ913mO1DH5
        p1jOvESthTitItePXjqioISubJbNYbklNgxCGpEFGVGpiiCOzWTzjmUZrCu0BPoJ4f5qpYU1
        6ViOybXq04TjSLPw1yFQAXxvvI63k5YcxshPRWs/2AjLJqruYPBhVe0dTIGbzCZWrSJnBSkl
        SPW5puWiSaCCgA4mKf5+FQH8WS/nTPIVEr6ibE+EUGFlVii1DTSzkap3BkfTvNvVOlB3scQb
        mVqTNzfeT/tf8Yt7mpB0eNBz8mrgzBlQ0pPhddA6j83l1NUbB/dWtN44ngcNQa0/OyP3uy+b
        pxIfD7efe346LGXMsLv+W1Jys/y+tUddXfT1S6i9oTNteGgxfGvjvpkpecXrC9H5iyUj2VPe
        LTtp3KJn4jdgnIX5B+b30Q+TAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGVlLCBBbGV4YW5kcmUsIEdyZWcgJiBTYXNoYQ0KDQpPbiBXZWQsIDIwMjAtMDEtMTUg
YXQgMTA6MjkgKzAyMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gV2hlbiBSVEMgaXMgdXNl
ZCBpbiAyNEggbW9kZSAoYW5kIGl0IGlzIGJ5IHRoaXMgZHJpdmVyKSB0aGUgbWF4aW11bQ0KPiBo
b3VyIHZhbHVlIGlzIDI0IGluIEJDRC4gVGhpcyBvY2N1cGllcyBiaXRzIFs1OjBdIC0gd2hpY2gg
bWVhbnMNCj4gY29ycmVjdCBtYXNrIGZvciBIT1VSIHJlZ2lzdGVyIGlzIDB4M2Ygbm90IDB4MWYu
IEZpeCB0aGUgbWFzaw0KPiANCj4gRml4ZXM6IDMyYTRhNGViZjc2OCAoInJ0YzogYmQ3MDUyODog
SW5pdGlhbCBzdXBwb3J0IGZvciBST0hNIGJkNzA1MjgNCj4gUlRDIikNCj4gU2lnbmVkLW9mZi1i
eTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+
IEFja2VkLWJ5OiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5j
b20+DQo+IC0tLQ0KPiANCj4gSSBqdXN0IG5vdGljZWQgdGhpcyB3YXMgbmV2ZXIgYXBwbGllZC4g
SSdkIGxpa2UgdG8gZ2V0IHRoaXMgaW4gYXMNCj4gd2UgY3VycmVudGx5IGhhdmUgYmQ3MDUyOCBS
VEMgbm90IHdvcmtpbmcgaW4gZmV3IGV4aXRpbmcgcmVsZWFzZXMuDQo+IChPciBpdCB3b3JrcyBh
cyBsb25nIGFzIHRpbWUgaXMgbm90IHNldCBhdCB0aGUgZXZlbmluZyA6LykNCj4gDQo+IEkgdGhp
bmsgdGhpcyBvbmNlIHdhcyBpbiBSVEMgdHJlZSBidXQgd2FzIGRyb3BwZWQgYXMgTGVlIG1lbnRp
b25lZA0KPiB0aGlzDQo+IGJlbG9uZ3MgdG8gTUZELiBUaHVzIEkgZGFyZWQgdG8gYWRkIHRoZSBB
bGV4YW5kcmUncyBhY2tlZC1ieSAtIHBsZWFzZQ0KPiBsZXQgbWUga25vdyBpZiB0aGlzIGlzIG5v
dCBPay4NCj4gDQo+IExlZSwgY2FuIHlvdSBwbGVhc2UgcHVsbCB0aGlzIGluIHNvIHRoYXQgd2Ug
Z2V0IHRoZSBmaXgNCj4gaW4tdHJlZT8gSSBndWVzcyB0aGUgZml4ZXMgdGFnIGhlbHBzIHRoaXMg
dG8gYmUgaW5jbHVkZWQgaW4gc29tZQ0KPiBleGlzdGluZyBicmFuY2hlcy4NCg0KQWN0dWFsbHkg
LSBJIGRvbid0IGtub3cgaWYgYXBwbHlpbmcgdGhpcyBpbiBNRkQgaXMgZ29vZCBpZGVhLiBUaGUN
CkJENzE4Mjggc3VwcG9ydCBzZXJpZXMNCg0KKA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9jb3Zlci4xNTc5MDc4NjgxLmdpdC5tYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20v
DQopDQoNCndpbGwgZml4IHRoaXMgd2hlbiBhcHBsaWVkIChhbmQgY29uZmxpY3Qgd2l0aCB0aGlz
IGlmIGJvdGggYXJlDQphcHBsaWVkKS4gSSB3b3VsZCBsaWtlIHRvIGdldCB0aGlzIGZpeCBpbiA1
LjQgdGhvdWdoIC0gYnV0IEkgZG9uJ3QNCnRoaW5rIHRoZSBCRDcxODI4IHNlcmllcyBzaG91bGQg
YmUgaW4gNS40Lg0KDQpJcyBpdCBwb3NzaWJsZSB0byBnZXQgdGhpcyBpbiA1LjQgc3RhYmxlIC0g
d2hpbGUgbGVhdmluZyB0aGlzIG91dCBvZg0KY3VycmVudCBNRkQgdHJlZSBhbmQgYXBwbHlpbmcg
dGhlIEJENzE4Mjggc2VyaWVzIHRvIE1GRD8NCg0KPiANCj4gIGluY2x1ZGUvbGludXgvbWZkL3Jv
aG0tYmQ3MDUyOC5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZmQvcm9obS1i
ZDcwNTI4LmgNCj4gYi9pbmNsdWRlL2xpbnV4L21mZC9yb2htLWJkNzA1MjguaA0KPiBpbmRleCAx
MDEzZTYwYzViMjUuLmIwMTA5ZWU2ZGFlMiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9t
ZmQvcm9obS1iZDcwNTI4LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcwNTI4
LmgNCj4gQEAgLTMxNyw3ICszMTcsNyBAQCBlbnVtIHsNCj4gICNkZWZpbmUgQkQ3MDUyOF9NQVNL
X1JUQ19NSU5VVEUJCTB4N2YNCj4gICNkZWZpbmUgQkQ3MDUyOF9NQVNLX1JUQ19IT1VSXzI0SAkw
eDgwDQo+ICAjZGVmaW5lIEJENzA1MjhfTUFTS19SVENfSE9VUl9QTQkweDIwDQo+IC0jZGVmaW5l
IEJENzA1MjhfTUFTS19SVENfSE9VUgkJMHgxZg0KPiArI2RlZmluZSBCRDcwNTI4X01BU0tfUlRD
X0hPVVIJCTB4M2YNCj4gICNkZWZpbmUgQkQ3MDUyOF9NQVNLX1JUQ19EQVkJCTB4M2YNCj4gICNk
ZWZpbmUgQkQ3MDUyOF9NQVNLX1JUQ19XRUVLCQkweDA3DQo+ICAjZGVmaW5lIEJENzA1MjhfTUFT
S19SVENfTU9OVEgJCTB4MWYNCj4gLS0gDQo+IDIuMjEuMA0KPiANCj4gDQoNCg==
